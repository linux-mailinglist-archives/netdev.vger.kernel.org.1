Return-Path: <netdev+bounces-201206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50BAE872D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14391643CF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1825CC72;
	Wed, 25 Jun 2025 14:54:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B711D5165
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863253; cv=none; b=kmoIDKTalNe+ck2gSomeYR9ML6rWHV3d3N8SL1zZPEGHnv01AHT4lhhSEyaU69Sx2CU/rsRPeGzqCh6f5+3wHykSezt+Gds/KvDSTUXBHURhV/duDXAzIs7vFfv+APuWkewfiPwucu8sl7utL+883insPV03QWB8KkhDAVX1tng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863253; c=relaxed/simple;
	bh=kn9gi/mp+gU7lozuVo0xHfXmebklFWKCem2C9a2JVBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO3spJcp0gvNhvJMUIst/WblPowB40bbYqFXCIOLNyvjPbBPYh75lRRxeTeiPshZZ3An2CssZXNwApfSh1v5LHBxVDEj+PgCLXnWPzInoNZDUcltS5PQ92F8kmoXuuD5M9VZjM6ic36z3JfBK0unyViWLqs6OgebeaWpK4ju4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34C5961E647BA;
	Wed, 25 Jun 2025 16:53:07 +0200 (CEST)
Message-ID: <1c43ebac-2334-473d-b3dc-de26bf5abca7@molgen.mpg.de>
Date: Wed, 25 Jun 2025 16:53:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Jacob E Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Eric Dumazet
 <edumazet@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Igor Raits <igor@gooddata.com>,
 Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>, regressions@lists.linux.dev
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
 <20250415175359.3c6117c9@kernel.org>
 <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
 <20250416064852.39fd4b8f@kernel.org>
 <CAK8fFZ4bKHa8L6iF7dZNBRxujdmsoFN05p73Ab6mkPf6FGhmMQ@mail.gmail.com>
 <CO1PR11MB5089365F31BCD97E59CCFA83D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <20250416171311.30b76ec1@kernel.org>
 <CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
 <CAK8fFZ4BJ-T40eNzO1rDLLpSRkeaHGctATsGLKD3bqVCa4RFEQ@mail.gmail.com>
 <CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jaroslav,


Am 25.06.25 um 14:17 schrieb Jaroslav Pulchart:

> We are still facing the memory issue with Intel 810 NICs (even on latest
> 6.15.y).

Commit 492a044508ad13 ("ice: Add support for persistent NAPI config") 
was added in Linux v6.13-rc1, and as until now, no fix could be 
presented, but reverting it fixes your issue, I strongly recommend to 
send a revert. No idea if it’s compiler depended or what else could be 
the issue. But due to Linux’ no regression policy this should be 
reverted as soon as possible.


Kind regards,

Paul

