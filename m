Return-Path: <netdev+bounces-79663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7487A7B3
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51061C22743
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C246AD6;
	Wed, 13 Mar 2024 12:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D52EAF7
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333578; cv=none; b=YM4NaAXA70ptFRixHry4WS4b7FLzNKnPcA3xT4RTeK+WOxJQgM5dKqtLRk2EkXqoLOHjt3deHVoIUyZ+PLMu/Z6uoqaTy8XdPkiKzBjzrtthXvNp6ZD/6HDKntAu8HypTjS+UWELHKmycT1pZlrN3ClC9wrBdLHllVhyjTiF+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333578; c=relaxed/simple;
	bh=3cWZmA+Umk/4f8WrANNy/7Nqna1sMzDQ2eAgqxXNbZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOGmMcbCrO+C8bCgFs5RxadqOtBrVU6teMFcinpg7KmXKXSFEWnsZjcM+SWIAZbbE9RC+k/AzoXUTrB6Ocfhc/Aaz2NwyWVpO2EppCbt0ovMAo0VoQWjVUMePRbMMUwAUJPc9j/3w4cLDkZMxokacgPnTt6sxpnRCLAKXH/UEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AA58961E5FE04;
	Wed, 13 Mar 2024 13:39:10 +0100 (CET)
Message-ID: <ec459f09-6355-439f-bb1b-4320cb149ea7@molgen.mpg.de>
Date: Wed, 13 Mar 2024 13:39:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix vf may be used
 uninitialized in this function warning
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20240313095639.6554-1-aleksandr.loktionov@intel.com>
 <1fa71d41-dc3c-4c1a-8b6e-70aa4c9511c1@molgen.mpg.de>
 <SJ0PR11MB58668956DC932D7C8E25B487E52A2@SJ0PR11MB5866.namprd11.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SJ0PR11MB58668956DC932D7C8E25B487E52A2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Aleksandr,


Thank you for your reply.

Am 13.03.24 um 13:34 schrieb Loktionov, Aleksandr:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Wednesday, March 13, 2024 11:58 AM

>> Am 13.03.24 um 10:56 schrieb Aleksandr Loktionov:
>>> To fix the regression introduced by commit 52424f974bc5, which causes
>>> servers hang in very hard to reproduce conditions with resets races.
>>> Using two sources for the information is the root cause.
>>> In this function before the fix bumping v didn't mean bumping vf
>>> pointer. But the code used this variables interchangeably, so staled
>>> vf could point to different/not intended vf.
>>>
>>> Remove redundant "v" variable and iterate via single VF pointer across
>>> whole function instead to guarantee VF pointer validity.
>>>
>>> Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
>>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>> v1 -> v2: commit message change
>>
>> Thank you very much. No need to resend, but I find it also always
>> useful to have the exact warning pasted in the commit message.
>>
> The warning is exactly "vf may be used uninitialized in this
> function"  it's already in the title. What you suggest me to do?
Doesn’t the warning also contain the line number? I’d paste the wohle 
line – as there is also no problem in having some information of the 
summary/title duplicated in the message. Anyway, as written, not important.


Kind regards,

Paul

