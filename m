Return-Path: <netdev+bounces-229702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60EEBDFF41
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E5D19C73DE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FED2FFF8A;
	Wed, 15 Oct 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwPuF2mA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4C2FF14D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550831; cv=none; b=FSemOSL1/xbJR0gdJdZo8qRtu0Aw3WzIn7uyiuJbIFTb+Jf0T5/zmsXbMG8oV2KOJFogdUA/17IxwwnSeWeKU7Q7mz391lVGi6a/H6pwhK7bOYA0dcsnO3Xfy1ATKm3Z81oPRiFmav04Wl7o1hs+IANgArUB2XMpeRkDX/F3KBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550831; c=relaxed/simple;
	bh=QY5Q3e8txI/J/FQMQUgNHznkfG9qsKg1wReVe48igtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUrlrGI9SolyEnDjpfYSTdpmNjZ6f4Iha1vrrH9wk1v2d7a5fdca/M4JDbbnP88+9AHa8Jp/4xaGnGX56UeO8GvP8SsBurx3ySTsa0m2OX+tuk3FCfOYX40DU5QPC44LifKqgj3su5OKPoxNgeh1NMbZoANhsKJxIAU/s1MgzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwPuF2mA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27ee41e0798so107351335ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550827; x=1761155627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hp/Nuwc38Z7OYEkKhtIlgotNSr8Am7/Jhj3sfoXTNkk=;
        b=EwPuF2mADBV2KZpkX9SlycfhFN6Fu07onDVhwwJ5MLpJF9JhfSheqR1kZ1VkujA+ID
         ri0XtDT5t2V4gFD3SoIfSfbNu9NoAjaKfqdSmmH5TnmAD/2pwmUYfS8Suw2aa1Dkp3dU
         oPgI+KJvZbMJ4mX+8Xwk1dEqUIO8em/QhwS/NQacwV82aY074jkuKMYj9WsjWFlvMva+
         mDPnxQTzEsZziGYOC8L+c18G6JuJwM5I4slvertFgkI/2tUTgh3O5/mSfVaXyodNfZu0
         QPXb+J3uHfj3dz6cFBWOqKK0TFzCLyCWIwcRANuO4XRs8Y98C7y5sG8oSZwpYYpjMoP+
         doag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550827; x=1761155627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp/Nuwc38Z7OYEkKhtIlgotNSr8Am7/Jhj3sfoXTNkk=;
        b=H4sx0pXwnPeyJ/NG6rB6uDvJ4mQU6FryWWpAatTeplLDZKptXOGq0xDbh2H0rJMdMl
         Mfnf33TXoyXDil/efDvtY3kMZlOfDqIuuT2t0HmzVQIEuk7QBi87Vg4I1/cgrhGE2R+U
         X/3SbtpPAAuFWoLieLErQh3KOsco/vNnSH1AIyTVuL0iAP1ekzRove708NNovxF0jkLy
         4YkW39daB4mI3k6+GYkMPgRcwm12BVQkgFlUpJf1htaiPVpenKmw528Q6COsOsTkbhkn
         wd/FGa40HHFX0DCthigsgwG5CSUTyUZuLo8d8SxUT7iFMCz6NH1bLZbVpcDYW9yJYCjo
         FJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFod5arm0iz9+pHNmsazmd/IeNwtNNkal/NfGnqGuvYj/kC0dklhl9rfjjS4sDCqzPwCYiR8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjmQtPNhR1rsAkqUyXSCaoc/xk0Tiv5RPh4Z8qnjR58VJh3ST
	pomGT3095s2V8qFaxtw0Qpp52zFK6CnQNr8j1dbjnvqOHMQr4s7Q7b1M
X-Gm-Gg: ASbGncvSZfHiZ9mXxlkL/gjCvoeFrKXK10BvzyWdRSx7tCsGzZD46IHiKAuA2DFnHHW
	meRBp9iSKiGnuH8kLHB7qJJb1au/c6q5k9jo2Jl0DwHjnHGb8bCi9bcxRd5fZt4lcgiLMiAdZWv
	rJWnl+qREzryMXM6u7+Enz4L/KPUSEgnh6dx5ORJRbNr6xzqIBvjYgpJt8J7a2wAx4U1p5ooBjG
	zZWYWpIQlLWldxxiXP81408bbJiGmahfKAI65up1Qn8L1/avCBIZCSe8bdVrzPIJYFMCy+gNOPO
	R6nQlsJtkpOPpCND090b2AkuN2dWMyJQhEZnUTJcVHmt2vRHnjzT0252qrgsbJTQrYjAZUBw0RJ
	bGQm1lBt5y31w6zXac0WHB0stlssUXej4EhQ629g9Q/KeREmB+783iteRa/57N7OVMaStn0RZcM
	j6pH7gj0IWZZj/EimafacsV7C1wsTgysD1itA=
X-Google-Smtp-Source: AGHT+IE6uYN73YkBBSE70m0dCIAoYj5ndrBXem7j2fPzhYt8+AH8vZYZh019bHy61G9OIiEIrYd/uw==
X-Received: by 2002:a17:903:1b64:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-290273ecb07mr372344675ad.39.1760550827419;
        Wed, 15 Oct 2025 10:53:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290993466absm2779815ad.35.2025.10.15.10.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:53:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e94f188d-3578-447f-8815-6c2393f2f807@roeck-us.net>
Date: Wed, 15 Oct 2025 10:53:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: guard fwlog code by
 CONFIG_DEBUG_FS
To: Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251014141110.751104-1-michal.swiatkowski@linux.intel.com>
 <11eac3d4-d81c-42e2-b9e3-d6f715a946b2@intel.com>
 <aO8wDmPWWEV6+tkZ@mev-dev.igk.intel.com>
 <0c8c5f34-c5cb-4a81-98fc-e3b957a2a8e9@intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <0c8c5f34-c5cb-4a81-98fc-e3b957a2a8e9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 10:32, Jacob Keller wrote:
> 
> 
> On 10/14/2025 10:24 PM, Michal Swiatkowski wrote:
>> On Tue, Oct 14, 2025 at 04:41:43PM -0700, Jacob Keller wrote:
>>>
>>>
>>> On 10/14/2025 7:11 AM, Michal Swiatkowski wrote:
>>>> Building the ixgbe without CONFIG_DEBUG_FS leads to a build error. Fix
>>>> that by guarding fwlog code.
>>>>
>>>> Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> ---
>>>
>>> Hm. It probably is best to make this optional and not require debugfs
>>> via kconfig.
>>
>> Make sense
>>
>>>
>>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 ++
>>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h | 8 ++++++++
>>>>   2 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>>>> index c2f8189a0738..c5d76222df18 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>>>> @@ -3921,6 +3921,7 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
>>>>   	return err;
>>>>   }
>>>>   
>>>> +#ifdef CONFIG_DEBUG_FS
>>>>   static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
>>>>   			    u16 size)
>>>>   {
>>>> @@ -3952,6 +3953,7 @@ void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
>>>>   
>>>>   	libie_fwlog_deinit(&hw->fwlog);
>>>>   }
>>>> +#endif /* CONFIG_DEBUG_FS */
>>>>   
>>>
>>> What does the fwlog module from libie do? Seems likely that it won't
>>> compile without CONFIG_DEBUG_FS either...
>>
>> Right, it shouldn't, because there is a dependency on fs/debugfs.
>> It is building on my env, but maybe I don't have it fully cleaned.
>> I wonder, because in ice there wasn't a check (or select) for
>> CONFIG_DEBUG_FS for fwlog code.
>>
>> Looks like LIBIE_FWLOG should select DEBUG_FS, right?
>> I will send v2 with that, if it is fine.
>>
>> Thanks
>>
> My only worry is that could lead to ice selecting LIBIE_FWLOG which then
> selects DEBUG_FS which then means we implicitly require DEBUG_FS regardless.
> 
> I don't quite remember the semantics of select and whether that would
> let you build a kernel without DEBUG_FS.. I think some systems would
> like to be able to disable DEBUG_FS as a way of limiting scope of
> available interfaces exposed by the kernel.
> 

If fwlog depends on debugfs, why not spell out that dependency and
provide dummy functions if it isn't enabled ? The Kconfig entries
selecting it could then be changed to
	select LIBIE_FWLOG if DEBUG_FS

Guenter


