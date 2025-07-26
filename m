Return-Path: <netdev+bounces-210291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A5B12A88
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72AA1C22B2B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87224466D;
	Sat, 26 Jul 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gxBQj7IA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828D242D9B
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753534586; cv=none; b=Ar8PRYOQigZTro4rXYxPa+gFQRIc7seymEWcAlhV0rpPBZP1y70pzzogbZKhWkGKLeBu64zNFuGUwDeVhkLj1k0LQ6VEllRJ9R1QO41NRWQboJPf7KtN93In+Sxf73JL9/tTV2RuKS8+Oq6g1++SS/d+cp/b7n1dAM0XJ/qKmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753534586; c=relaxed/simple;
	bh=2s2R/UOkxr5JqesTnpu8H8gMVEpM0R3qzK7yClKajVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMu59PU2mgt+a7m62Adk23Uv9ea9L7DklgYdrY6i6FHmtRKxpnCoTlHsTESuUQ/G/EQokiW0dJP97bHTo5BTAOuv5qf0f3GijaU8C5xZxr10Rk9ZKPCpsBIG2bE+T5bx3Ni3vhNwYtsMgetyUPyQPNmTwLXwIchhOrstK8kfS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gxBQj7IA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so38921f8f.1
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753534583; x=1754139383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVd7AMali/jsi6H1hzbMRMOEHFNbKvjmSzlnGm24Ac0=;
        b=gxBQj7IA1HBi+YRu9BuwmFox9nam0KLfaoU+TLvxKbm+mhFqNI6Yejpt56o1wW7H1l
         X9Y0YR8hsIfd2j+PvqineDMFRR8oZY+0RwX75mjWNSZl71XUz0aWbK6P2woI5+DP3vid
         xCfwvtcyteNq41gKuep5G5VhurrI/CR0HrmfgIRgz9WhIhIHnLGNvrPJEP9o2mrswIt0
         6M0UfMCvmxb/6F04jE2ycgBD7N4hqYF547YycKSc8ySN8RPd2+dsm6hnXXaHq3yrJZvM
         xcHR4l7avQbJmiJGtC7zKiVy02KXcXJ+aWb691cWzmh3LGjEeh0UUanqEFaLrhjqcgD3
         CiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753534583; x=1754139383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVd7AMali/jsi6H1hzbMRMOEHFNbKvjmSzlnGm24Ac0=;
        b=MwekzkfbeKuVCsv3/A6mx+cGgF9Cip3h/q3cIrcQlE+WEpGYhkxk79XqOz1IRTaxtP
         E3Gwto//wt4hvSO+QlwrcZdAEfSUNRjhLUJ0zt1T9rgsxldWs4gJLnrqxcAuFnWURWf/
         SUIDiYv/o5RXD6TU5L3mOQQb6SJbq3Pxk7jmdrm8aT4ff0+3gTrx1wmQsOVNFg7CTL10
         2zSnDcBmSn/2zi1mx6rq/TB8Rmo6uEr/+yES0U3lX5CqKc2UXUJsCtZX/h8Pe9vChmbQ
         YavB9G0K0LnTSOoG8JJLUe0Hpv6lCYbIVpGX4dQ+e05uEQxuXdEpp29eWBS3+VWhjCX2
         Nm+A==
X-Gm-Message-State: AOJu0YyW6drUTdy0EeGIqMGm2J/DZTkqY885MORjGJo4jsB9R/X789aO
	4kNoEilZyE+zA7Kb7vUBuE1NDzJ/d0ueS+2H+KvmDssdMRIEdSEMrjcAtJU82nwCd0A=
X-Gm-Gg: ASbGncv0I1cyLRLZDhHFY0lqoxqC9VDqapD31ADX7eG8sITT1J/VKQ+tY3fpw7mzhpy
	80XOztyb6E5F8sCHeD2cbiYNUlv8XKsRCe4/Q3qnq90WpgfwpFU1vtLidIIIkCeYMP9qdGxZgJm
	rNG988grZy8eSE+kXcSWQjF5AYWJP4zOxJAy2VK60dJMnSd0a6IJdbawsZlQl95Yvmj6Hvulh29
	rJZNuieNB+KYrHLw57CWUpT50XQ3DYWdNNOTqsF+HyWq6XGu9HFeaJi5Y+Gmmmiku82Sela32Lh
	AzIsI1zFAulhrI2PiFIk6J6qmmvSR1wscXW/V3qggju/C3aPNWiPCBEZ1aOwc86b8rCiZpYbN5k
	eRsYD7ZsO8gSCW97a3v2v2370D5VacDbK2QrmeLSCl+hMVQ7AzDcEn+j5hJiMpIPEPO9I/z4l/K
	TMo8MfB+B3WA==
X-Google-Smtp-Source: AGHT+IHcdmZgE50L6D5Uo+PeD640vgCbTir0gSC0WUCoG2jj5zd6WbBnoWPwULzq1pOtJHDErCHGfw==
X-Received: by 2002:a05:6000:1445:b0:3b7:7ceb:1428 with SMTP id ffacd0b85a97d-3b77ceb1730mr1042661f8f.8.1753534583420;
        Sat, 26 Jul 2025 05:56:23 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6206:d100:13e7:7f4:965e:e5b8? ([2a02:2f04:6206:d100:13e7:7f4:965e:e5b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb27besm2791649f8f.9.2025.07.26.05.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:56:22 -0700 (PDT)
Message-ID: <681b063c-6eab-459b-a714-1967a735c37d@tuxon.dev>
Date: Sat, 26 Jul 2025 15:56:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
To: Ryan.Wanner@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
 <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
 <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
 <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/21/25 18:39, Ryan.Wanner@microchip.com wrote:
> On 7/18/25 04:00, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Ryan,
>>
>> On 14.07.2025 19:37, Ryan.Wanner@microchip.com wrote:
>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>
>>> Remove USARIO_CLKEN flag since this is now a device tree argument and
>>
>> s/USARIO_CLKEN/USRIO_HAS_CLKEN here and in title as well.
>>
>>> not fixed to the SoC.
>>>
>>> This will instead be selected by the "cdns,refclk-ext"
>>> device tree property.
>>>
>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>> ---
>>>   drivers/net/ethernet/cadence/macb_main.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>> index 51667263c01d..cd54e4065690 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -5113,8 +5113,7 @@ static const struct macb_config sama7g5_gem_config = {
>>>
>>>   static const struct macb_config sama7g5_emac_config = {
>>>        .caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
>>> -             MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
>>
>> Will old DTBs still work with new kernels with this change?
> 
> That was my assumption, but it seems it would be safer to keep this
> property for this IP and implement this dt flag property on IPs that do
> not already have  MACB_CAPS_USRIO_HAS_CLKEN property.

So, this patch should be reverted, right?

Thank you,
Claudiu

> 
> Ryan
>>
>> Thank you,
>> Claudiu
>>
>>> -             MACB_CAPS_GEM_HAS_PTP,
>>> +             MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
>>>        .dma_burst_length = 16,
>>>        .clk_init = macb_clk_init,
>>>        .init = macb_init,
>>
> 


