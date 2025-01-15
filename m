Return-Path: <netdev+bounces-158485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61FBA12215
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E7169519
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D390241683;
	Wed, 15 Jan 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+yU7mZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0E23F292;
	Wed, 15 Jan 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939134; cv=none; b=HO5s0TvDOAy3pCIkCoKyF0pbE9ZEcIVSUYV+fmE30sGwdnoFJosCU6JdsYJApIdNmaVkWlydn/nFG3R1+DTEhHREHeGXXthGqIHFgN0YSSf5BSM+LnUakZObHdeyQFYmGORBtAfgvRTJVfIctZ1ejGM8Kg/boRwIlFCyIfJyKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939134; c=relaxed/simple;
	bh=ICKWw+LQOACiFmhC0CwpTVLD12k+vWO/yjvmuEJXp0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdiK13uxvEDz0eQs20UHT7Hy97m9Uruyjh5UR7Ff2Tb1K2Fz6b2eZfxs6Sl3+ZqxDxrN36VGhEpwqpxQdb87tDhqK+7u6ZMM6N7ypAvEnjV3TjitQxBVeVD10eVmFYtD1+m0C3vOmNqhy2wkkaerAvSOH56BR0KoKzmViHYU5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+yU7mZN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so11237189a91.2;
        Wed, 15 Jan 2025 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736939132; x=1737543932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZhmJVX2Z/1on+VLI7mM1RgJuJ/QDUUV3rq29Mr1CH4=;
        b=W+yU7mZNaO7kFe4qfYmZaNXUMKM3QLJ80LkRbutMCnVO1TtTISqZ6Nj/ZNBRZ8D8sR
         rCLytF3pj+TQQX/42oNIv2y8wMYzceMjw1O5LyZtnktHUAjUbUsiMqARO3BbQTpiQxtc
         RKRqrtHYMEx9lzJbpec4StwC4QgXNQwQAPKixXLxJQJd1kXeCmhz23wTaT8UhFfPS0k1
         6NrtrnVB32XtaMSsktUqqMa77QtrJHSTZHC9G+aUB+WoeCqWCXwXtf3AWglt8db+SiFP
         fb4iPr1wcrWaJhjaTnkX8fe9ivCpyr8dNZK/gWsuAaJtnUyE7p1lJdqvLP2yKo5WPQdX
         70qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939132; x=1737543932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZhmJVX2Z/1on+VLI7mM1RgJuJ/QDUUV3rq29Mr1CH4=;
        b=hKSlGd1QMZ/3KpL/gKYxqp5Wb6sXNvk5anQZ+as75GrMXLiHVH3laXZAPl0wuUM8a1
         PT8CD7gNWjAqU+AWjgm6aYOzz6Y8o/yWhzjawvtx8LhUKe2jzZ3QL/0gBWPYUmbajL0A
         nbiKAO4xzad85X4p5v9nWI/UiCTerDTKRM352vpPKHmDk3fXZWJUlpvXFKQDFvw6laN7
         nHQrOYjJgZQUa9WFpL+bG4higiojUSQEXDU4PobNK+9cV49oTgNme66WGE+pYKOnd/nV
         aUux3tQU1g1x1enop1mXGgnSIEoxYAHGin7SywWyUVjnP7gmQzlaGhRMSF5qoLRt9xSf
         4vLw==
X-Forwarded-Encrypted: i=1; AJvYcCWhf/V25bvjSpt5Rx4QxI4P3M7bLWa1Ma8oiLPKPTMIX87t/PKgVWLqxcL6V5WrIAMmSkIoX+E0HU2r@vger.kernel.org, AJvYcCXYeJN/xFBUVBkeDmSiXrM/8MJnNWIDe1FVh5ZOcYNzxotr395A22AQodB9muW+waMpJROLgv/T@vger.kernel.org, AJvYcCXdFAGGVo38FgO11JROTdlBNUHn1kIfWcSX5+/YscRhqfgylbo+x2KPpC+J+xTubCNxqCO4luWhLT9/jWQX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQU00acJ7bjM9Qy3oD3P0UXaBY1dERBDSfmKZxIN9G9Gh3Cf+t
	mP0Og7lwowhejpZGgzSR/ZpCv1fLaFdOVFt8byEc3pAv37JvY9K4
X-Gm-Gg: ASbGncsFau68bBxPH2tSx71Oaq4NEn9l6QoG/nFm1ufvB8TMFIF2CWELAZFJ+qRw8vO
	WLtV6BzFe8UfI8pP7RutPcLyhiLr8rPEwQbmOlFEHgEiPEGA6td+BypTUKN1DPwhP1wTcNqY4Ts
	PvAmCJVVLKXUS8jbTYfaFntu1WLvnSx09pu3f+V5K6VvAVysFrzMvxbMlUhz7rAuGJBpm6fqF6e
	fVzUbtlkyB+Gy34ZxBbK5KneN7lzEtyLbIHjxmk48JLes5XHT1pjf1rRtaG0+HMb0xyjcDHUhgJ
	1m0JBo5XzHFJ4tZDgoFX5R3h81FZeo+B0ug=
X-Google-Smtp-Source: AGHT+IEIUJ161wQLQ7M7tzPplUbCNDBmqlqWnABZRELuVW2sGY23Vkufmemaywh2bkhh0gVhD2Yq9A==
X-Received: by 2002:a17:90b:264c:b0:2ee:9b2c:3253 with SMTP id 98e67ed59e1d1-2f5490c20e7mr40326717a91.30.1736939131935;
        Wed, 15 Jan 2025 03:05:31 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c22b474sm1111164a91.44.2025.01.15.03.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 03:05:31 -0800 (PST)
Message-ID: <da332a44-8fbe-40c3-8053-c4c9fdfc8746@gmail.com>
Date: Wed, 15 Jan 2025 19:05:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com,
 Andrew Lunn <andrew@lunn.ch>, schung@nuvoton.com, peppe.cavallaro@st.com,
 yclu4@nuvoton.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
 <2cf758f2-529e-4ccd-9dc1-18fc29ad5ac0@gmail.com>
 <990a3fc9-7fd6-49b6-8918-d5bf4ae48953@molgen.mpg.de>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <990a3fc9-7fd6-49b6-8918-d5bf4ae48953@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paul,

Thank you for your kind reply.

Paul Menzel 於 1/15/2025 5:22 PM 寫道:
> Dear Joey,
>
>
> Thank you for your prompt reply.
>
>
> Am 15.01.25 um 10:03 schrieb Joey Lu:
>
>> Paul Menzel 於 1/14/2025 9:49 AM 寫道:
>
> […]
>
>>> Am 13.01.25 um 00:54 schrieb Joey Lu:
>>>> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac 
>>>> driver.
>
> […]
>
>>> Also, please document how tested the driver. Maybe even paste new 
>>> log messages.
>>
>> These are the kernel configurations for testing the MA35D1 GMAC 
>> driver: ARCH_MA35, STMMAC_PLATFORM, DWMAC_NUVOTON.
>>
>> I'm not sure if this information is sufficient, so please provide 
>> some guidance on what else I should include to meet your requirements.
>
> I’d be interested on what hardware you tested it. Probably some 
> evaluation or customer reference board.
The driver has been validated on our development boards, 
NuMaker-IoT-MA35D1-A1 and NuMaker-HMI-MA35D1-S1.
>
>> I will include the log messages at the end of the email.
>
> Awesome. Thank you. Personally, I also like to see those in the commit 
> message.
Understood. I will include in the commit message in the next patch.
>
>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>>>
>>> As you use your company email address in the AUTHOR line below, 
>>> please also add that email address to the commit message (and maybe 
>>> even as the author).
>>
>> I will update the AUTHOR to use my personal email address instead of 
>> the company email.
>
> Understood. (yclu4@nuvoton.com is also personal, but the Gmail address 
> is private, I guess. ;-)).
Oops, I meant to say "private" instead.
>
> For statistics, how companies contribute to the Linux kernel, having 
> the company address somewhere would be nice though, as you are doing 
> this as your work at Nuvoton, right?
I will keep the company information in the driver header as you mentioned.
>
>>>> ---
>>>>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
>>>>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>>>>   .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 179 
>>>> ++++++++++++++++++
>>>>   3 files changed, 191 insertions(+)
>>>>   create mode 100644 
>>>> drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
>
> […]
>
>> log:
>>
>> [    T0] Booting Linux on physical CPU 0x0000000000 [0x411fd040]
>
> Out of curiosity, how do you get these timestamps T0, T1, …?
>
> […]
>
>
> Thank you and kind regards,
>
> Paul

I simply forgot to enable CONFIG_PRINTK_TIME. Here is what the log looks 
like after enabling it.

[    1.886100] nuvoton-dwmac 40120000.ethernet: TX Checksum insertion 
supported
[    1.893104] nuvoton-dwmac 40120000.ethernet: Enhanced/Alternate 
descriptors
[    1.900048] nuvoton-dwmac 40120000.ethernet: Enabled extended descriptors
[    1.906806] nuvoton-dwmac 40120000.ethernet: Ring mode enabled
[    1.912611] nuvoton-dwmac 40120000.ethernet: Enable RX Mitigation via 
HW Watchdog Timer

BR,

Joey



