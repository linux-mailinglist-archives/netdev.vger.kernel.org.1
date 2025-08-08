Return-Path: <netdev+bounces-212140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B62CB1E57F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C21638B2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913920C010;
	Fri,  8 Aug 2025 09:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAB2AE74
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644708; cv=none; b=FYXPa4FmFIANJBn3XBZPRoxnnrGDIcmu9E3oqKlVrNVs8BUe7IKv8/Bvo8OWBqWX2bwwu4Jtox2dqC4R0ogqXfdUE35C1v/AIyw9lMrDmyeak+YkmEyI8BjWxC4Wv2qYWHAd44QwmpjAFZ8B09Xe2MkfMcXuJDvKVkW240fR/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644708; c=relaxed/simple;
	bh=rsxhN9P+El3D4jSAs2XETN3TyFDNDfI8wH8S43ftxkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHko5oaClJExOJultjRQB9lsV1NTbR8HXaJZVF0yqVP9D2iguj2erlhc7wrxa8WhUT2Vfyd4RzJRq/ahOaMcH1tXRe2TLdwlSefsZzLgLCzaVj2z4TAwdNHygCSUUi/tiV8nsD5gn/slUB2YNhZii4CAgd+ulU0ILc99eaS7mKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af14c.dynamic.kabel-deutschland.de [95.90.241.76])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0D77F6028827A;
	Fri, 08 Aug 2025 11:17:57 +0200 (CEST)
Message-ID: <8e4ec57e-dc14-470c-b56e-9f594a7a8390@molgen.mpg.de>
Date: Fri, 8 Aug 2025 11:17:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v8 iwl-next] ice: add recovery clock and
 clock 1588 control for E825c
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Milena Olech <milena.olech@intel.com>
References: <20250724122736.3398010-1-grzegorz.nitka@intel.com>
 <dff2578f-2336-4384-a1c3-427fc92dc1f2@molgen.mpg.de>
 <IA1PR11MB62193480CBF232FDCB54111E9227A@IA1PR11MB6219.namprd11.prod.outlook.com>
 <IA1PR11MB6219A68EFD8E72E5298842A9922CA@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <IA1PR11MB6219A68EFD8E72E5298842A9922CA@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Grzegorz,


Am 07.08.25 um 10:35 schrieb Nitka, Grzegorz:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Nitka, Grzegorz
>> Sent: Thursday, July 31, 2025 5:36 PM

[…]

>> My responses in-line. I'm going to address your comments in v9.

Thank you for digging into this, and your replies. I am looking forward 
to v9.


Kind regards,

Paul

