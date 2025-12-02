Return-Path: <netdev+bounces-243286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1BCC9C8C5
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CDF3A7447
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E329BDBF;
	Tue,  2 Dec 2025 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls7enNpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D821288C34
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698767; cv=none; b=cicSjutUlOMY6TSzc+7i8A0yrfONaO3TrDm1uSfLgJdRLipcz45oi5Cm2OtuOP8fvpMvj6e5jOYZaAOEPUh4QsdEDFbOrD+X/lshGLmxUlcvatUn4726TTwlYJwdzQTdDZBf+/8ZSGnmCUVMlaYjMDgccTH2JYpbPAMmFbmj8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698767; c=relaxed/simple;
	bh=tKruHEijudRQFzmAZxUaQfX4z4A3FeGXCpbZKppiWFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HV2EK0mY7wA9PGwga1JMvUCdQ+W4BCBcCPH45C87xno1cgFGznHKSvmvhHhfyazjTuxnz+GiZvfL9kJNeFQGWI1ayWFvSQklnm9ssic3EbARaiMlPmHVw4/Ms3hBskJnSMKOuQCiWuBeqgqHChWGnyT6vt3Go3uSkwJlBbi0Q+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls7enNpy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so38482135e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698764; x=1765303564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEzNj44roGFkK2x5+6+QBYAIrevMJ3F4KxBZFfLzIPQ=;
        b=ls7enNpyiBSH2Xa/IUfrWiAkf9CRxsEMZfh8SBCAC1dQZ2XvwMv1rJ+WZka/1rnfZL
         0QAkInLaEGN8JPnOKtmh1lFxyjukU1m8fxWHEftvpi+HiqDl2QgfaAInhN5eDkKimVG7
         W6Ui0v+Yw8qj75eC2gra/vI92xQy0NjT7wDm2IGPYbZC7qQffcZ0BckIYNUtPgnBNUcM
         zfwqjKpO07GnbnUWI/8IBqcxA67WkzDKK1R6H8cz22ovKyzbc9X9aA0YYR3TOrW14Sbm
         Sc0ZNEvdZicE9mUXNlh28bedctTs5zBpGbAfFBqEvRakRXqH0w9A7ZFlInhcBTIIPuLI
         fimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698764; x=1765303564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEzNj44roGFkK2x5+6+QBYAIrevMJ3F4KxBZFfLzIPQ=;
        b=MWP/t5uQAaTQHEq7U9LLEWPYuLfNH9c30KfhR30qgTNk8ynsRJq7vyCWdPJCuKM9kW
         mciPQSx2aykOfFBfXoh9LvbNtJjDvj5haYQgSyq4mCUd90vt0hznfogsgfL/B4h0Rrck
         L10AXOhiCyBjEBtemmzAUA2ocLDfd6Z6cgRdAIEdYJ71FyONWsGtldV/h+mkp7jNBdhL
         mur5gLEabeDDqlIGfA6WNjcbvTDv1NPASIRTnKzkKNYUgLk9V/08VVxlWijQ+ULPu07v
         rX0M/nGEgRlzf50lYqFONmKjDMHGkisVvzUxg/OJEBHCBWwBnSuMnZgE8NKHcDAJejVu
         upww==
X-Gm-Message-State: AOJu0YxXZ8BH3IGJ3IXCoqYErgzshBwsk+5ByEKxZ8Ktv/khU9aXtxR4
	Y3htpgfVHi7CAdkra56VzT6RX3n9pLLJOEKqJCzV+e3R/DqLIGB+HKtLR4PT2hoCA9k=
X-Gm-Gg: ASbGncub17Ln5bT1gfq/d8GzEDvw9QOz/gP6gJGDguuouwiHNFdDw9fc7oklzlg9/3n
	3MvCA1+SET/8OgoWc76eyGBPuMGyjR3f+eD9dyW6aaGmBtHNENkXoRqgWxDtZ6lZ9c4C6V57bg3
	NHIQC1K497V6bMoQ81DCLmgLGXZ2ZXWHIUNBMqbDeK2QbHWd/nYOHG9+2Moi33vLI/KvEfFQtf/
	RQD4FRhOhVSJEy663Dd+tNYW7qaHEaDpp1nnBZFI9S8liQejqAC1ViJZWa94EhpLWDWMcaaUYup
	LjBOMy+Z0FrZMCIORcB0MYiX1JucO91uIgfCbMEu4qZ4RHEU+umhpEyyb+TWvN3lkpCtKIMWA1U
	UdGnKmXfJjE4ZyXMMLBGorqXdFreeUaAKJ6MR8ImPgyrxzOyJIyD+CJYNCtDCfm7pRwP1+QEOV0
	KKcaUShFEU61caaZh2wkszLO11lam6+u3t78icYfBkIOAY/jc7VKcZ6sVZC76iCng9kYkLpXsQb
	bXkUzSerDKTM7ZcCTI35UtFwMTf7UjAhTm0SwytXvOkd/9qkxXeGmSfXie5R/aT
X-Google-Smtp-Source: AGHT+IH/twEPIUkQDBgOHnSX+rq8bWtVESc+mwjM9K7WCbkfRrK8SkZh+YC4ijZL/kJpWvM+qKR+eg==
X-Received: by 2002:a05:600c:354e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47904b12eb0mr334154165e9.17.1764698763376;
        Tue, 02 Dec 2025 10:06:03 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:cb00:61e9:ed14:30da:92bc? (p200300ea8f22cb0061e9ed1430da92bc.dip0.t-ipconnect.de. [2003:ea:8f22:cb00:61e9:ed14:30da:92bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca40945sm35108182f8f.30.2025.12.02.10.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 10:06:02 -0800 (PST)
Message-ID: <b25d0f31-94ef-4baa-9cbb-a949494ac9a7@gmail.com>
Date: Tue, 2 Dec 2025 19:06:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20251202.161642.99138760036999555.rene@exactco.de>
 <8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
 <20251202.184507.229081049189704462.rene@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251202.184507.229081049189704462.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/2025 6:45 PM, René Rebe wrote:
> On Tue, 2 Dec 2025 18:19:02 +0100, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 12/2/2025 4:16 PM, René Rebe wrote:
>>> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
>>> X570-ACE with RTL8168fp/RTL8117.
>>>
>>> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
>>> While this fixes WoL, it still kills the OOB RTL8117 remote management
>>> BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.
>>>
>>> Fixes: 065c27c184d6 ("r8169: phy power ops")
>>> Signed-off-by: René Rebe <rene@exactco.de>
>>> ---
>>> V2; DASH WoL fix only
>>> Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 5 +----
>>>  1 file changed, 1 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 853aabedb128..e2f9b9027fe2 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>>>  
>>>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>>>  {
>>> -	if (tp->dash_enabled)
>>> -		return;
>>> -
>>>  	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>>>  	    tp->mac_version == RTL_GIGA_MAC_VER_33)
>>>  		rtl_ephy_write(tp, 0x19, 0xff64);
>>> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>>>  	rtl_disable_exit_l1(tp);
>>>  	rtl_prepare_power_down(tp);
>>>  
>>> -	if (tp->dash_type != RTL_DASH_NONE)
>>> +	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
>>>  		rtl8168_driver_stop(tp);
>>>  }
>>>  
>>
>> Patch itself is fine with me. ToDo's:
>> - target net tree
> 
> What is the difference? The patch clearly git am applies to the net
> tree with zero fuzz, not?
> 
See netdev-FAQ. Always annotate whether you target net or net-next tree.

>> - cc stable
> 
> I was under the impression this is automatic when patches are merged
> with Fixes:, no? Do I need to manually cc stable? Nobody ever asked me
> for that before.
> 
https://docs.kernel.org/process/maintainer-netdev.html
See 1.5.7

>> - include all maintainers / blamed authors
>>   -> get_maintainer.pl
> 
> Of course I used get_maintainers.pl and thought I included all
> relevant. I surely can include all of them it spits out. I usually
> filter to the relevant ones to keep the noise level down.
> 
Please include all of them. CI also checks for it.

> 	  René
> 


