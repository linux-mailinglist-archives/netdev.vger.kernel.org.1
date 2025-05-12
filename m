Return-Path: <netdev+bounces-189688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8CAB3398
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C0E860BB7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823D25DD1C;
	Mon, 12 May 2025 09:27:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0C25DD17
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042054; cv=none; b=XAsMAfO+IhBmUO+umR0nF4nOfJ3yXAH50/M4zngraOlAqA6Sr+KDqWYMVTi1ve+RKCJaHCX87paKpbAvXxcijp4d6mleI6KiUWwn2mTDOe0cKxA6cP3gXiyIqq8Dwy8D7XRpvkIWEgpdsB5iIXel0db/DpiidxvOSRu54OUG5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042054; c=relaxed/simple;
	bh=uaZ69ms+r2tPDlfwyayuqqZ39J7PMqRVdQjliPS9TOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsXwRziX8a1gLAJ/C2V7geFlogTWAyxFg+lA/JikjHq5TySyA9C3iCQFp5QuLEseDUxPBv2Zr8YivZ4QWUG48I4ZqEeqFdXcQRRZYKoXOXvcp3+5O6SZRQYOnSZ++hSYfSdYgrrkQYexAU4EwlVB/PcQ5EHzyKLuA7RyEMTlOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p57bd9455.dip0.t-ipconnect.de [87.189.148.85])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BA307601EBF0A;
	Mon, 12 May 2025 11:27:10 +0200 (CEST)
Message-ID: <355fc4f1-0116-4028-a455-ec76772f19b3@molgen.mpg.de>
Date: Mon, 12 May 2025 11:27:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: add link_down_events
 statistic
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
 <55ae83fc-8333-4a04-9320-053af1fd6f46@molgen.mpg.de>
 <4012b88a-091d-4f81-92ab-ad32727914ff@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4012b88a-091d-4f81-92ab-ad32727914ff@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Martyna,


Thank you for your reply.

Am 14.04.25 um 15:12 schrieb Szapar-Mudlaw, Martyna:

> On 4/9/2025 2:08 PM, Paul Menzel wrote:

>> Am 09.04.25 um 13:36 schrieb Martyna Szapar-Mudlaw:
>>> Introduce a new ethtool statistic to ice driver, `link_down_events`,
>>> to track the number of times the link transitions from up to down.
>>> This counter can help diagnose issues related to link stability,
>>> such as port flapping or unexpected link drops.
>>>
>>> The counter increments when a link-down event occurs and is exposed
>>> via ethtool stats as `link_down_events.nic`.
>>
>> It’d be great if you pasted an example output.
> 
> In v2 (which I just submitted) the generic ethtool statistic is used for 
> this, instead of driver specific, so I guess no need to paste the 
> example output now.

I think it’s always good also as a reference how to test the patch. I 
just saw your v3. Should you resent, it’d be great if you added the 
example output.

[…]


Kind regards,

Paul

