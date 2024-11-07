Return-Path: <netdev+bounces-142658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FE9BFDE5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19F01C20FBF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD444191F98;
	Thu,  7 Nov 2024 05:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3035D53F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959010; cv=none; b=GiaDBID8YzMn0E6hQmvYRo5PNhc/UTB8HVUEWpniDTI7usVdFkvqPCs70iz4V2tEnNqjZxpJEZXujED13aqfxJtv2LUfsnipNE0eOlzR2NV228Gk3NV/x49Yz2MM970CjAUTOpF4dJU7fbH4I1JcGsDT39odbwvQBltJBLbsUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959010; c=relaxed/simple;
	bh=+TDNA+J28mngmXjyZr8hVgDnPVZ4+DL/Q90E3Mk01fQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vE7RxE8mAiVVY9sleUIwXjunN5FYpdGNgOoEsYVDkyCLY4c7D5wlF0urctaibJowUaYvGXLWT5PAbm4EFMGZdxG6l8y58wWNCNUCO6tSnOn9ORBygRfXR1TzjFlaLUMxa6dWse3XxZcJT+RKPcVRMQ0nXsqeBLDNeHjpPDuklbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedb4.dynamic.kabel-deutschland.de [95.90.237.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4337461E5FE05;
	Thu, 07 Nov 2024 06:56:21 +0100 (CET)
Message-ID: <dc4194a7-c4aa-4132-9ca3-1121530ba1bc@molgen.mpg.de>
Date: Thu, 7 Nov 2024 06:56:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 2/6] igc: Lengthen the
 hardware retry time to prevent timeouts
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Christopher S Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, David Zage <david.zage@intel.com>,
 Vinicius Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org,
 "Cadore Cataldo, Rodrigo" <rodrigo.cadore@l-acoustics.com>,
 Corinna Vinschen <vinschen@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mor Bar Gabay <morx.bar.gabay@intel.com>,
 Avigail Dahan <avigailx.dahan@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
 <20241106184722.17230-3-christopher.s.hall@intel.com>
 <4ee8f886-40ed-46bc-9d11-1619d64f7875@molgen.mpg.de>
 <MW4PR11MB698491CB1DA8179D870F787FC2532@MW4PR11MB6984.namprd11.prod.outlook.com>
 <3383e090-2545-4a02-abab-f92d4cbaa357@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <3383e090-2545-4a02-abab-f92d4cbaa357@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: -Sasha, 550 #5.1.0 Address rejected.]

Am 07.11.24 um 06:48 schrieb Paul Menzel:
> [Cc: +Sasha]
> 
> Dear Christopher,
> 
> 
> Am 07.11.24 um 00:53 schrieb Hall, Christopher S:
> 
>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Sent: Wednesday, November 06, 2024 3:14 PM
>>
>>> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 2/6] igc: Lengthen the hardware retry time to prevent timeouts
> 
>>> I’d use the more specific summary/title below:
>>
>> Will do.
>>
>>> igc: Lengthen hardware retry time to 4 μs to prevent timeouts
>>>
>>> Am 06.11.24 um 19:47 schrieb Christopher S M Hall:
>>>> Lengthen the hardware retry timer to four microseconds.
>>>>
>>>> The i225/i226 hardware retries if it receives an inappropriate response
>>>> from the upstream device. If the device retries too quickly, the root
>>>> port does not respond.
>>>
>>> Any idea why? Is it documented somewhere?
>>
>> I do not. Theoretically, 1 us should work, but it does not. It could be a root
>> port problem or an issue with i225/i226 NIC. I am not able to directly observe
>> the state of either. 4 us has worked in all my testing I am comfortable with
>> that value. 2 us also works, but given the limited hardware at my disposal
>> I doubled the value to 4 us to be safe. PTM is not time critical. Typically,
>> software initiates a transaction between 8 and 32 times per second. There
>> is no performance impact for PTM or any other function of the card. The
>> timeout occurs rarely, but if the retry time is too short the PTM state
>> machine does not recover.
> 
> Thank you for clearing this up. If it’s not time critical, why not 
> revert the original patch and go back to 10 μs.
> 
> The referenced commit 6b8aa753a9f9 (igc: Decrease PTM short interval 
> from 10 us to 1 us) also says, that 1 μs was suggested by the hardware 
> team. Were you able to talk to them?
> 
>>>> The issue can be reproduced with the following:
>>>>
>>>> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
>>>>
>>>> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
>>>> quickly reproduce the issue.
>>>>
>>>> PHC2SYS exits with:
>>>>
>>>> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>>>>     fails
>>>
>>> Why four microseconds, and not some other value?
>>
>> See above.
> 
> It’d be great, if you extended the commit message.
> 
>>>> Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 
>>>> 1 us")
>>>>
>>>> -#define IGC_PTM_SHORT_CYC_DEFAULT    1   /* Default short cycle interval */
>>>> +#define IGC_PTM_SHORT_CYC_DEFAULT    4   /* Default short cycle interval */
> 
> Maybe also add a comment, that 1 μs should work, but does not.
> 
> 
> Kind regards,
> 
> Paul

