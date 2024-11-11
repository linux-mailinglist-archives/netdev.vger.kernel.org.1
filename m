Return-Path: <netdev+bounces-143694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A869C3AB6
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090321F2215D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F11684B4;
	Mon, 11 Nov 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBFFvHa6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8F15B135;
	Mon, 11 Nov 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316678; cv=none; b=a6lOD2KGyJVV8rWzgNUCajZujg4b+CD0XGJk16bUjnSqEsUBRx6WxykH5CyAZylRT5CQCTcJiUGKeoWhOYpEnyzDTd8jy0O5jmV1k1JNxLErZ8w66BPP5Q3XB3kPgu+nE91zrM+S0LBsrgLvq53Gs7AbKwrJ5Ey1s9xmq0o2/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316678; c=relaxed/simple;
	bh=Zp8dcjXzFMrOFGBN9Ry967Doem9Ags0iEDztcikfI4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu0CJcQL+ENwoPR0dHxXItfBt+LigcBEmJS3f3YRan4KZVu4g5ZElWBTMNUnrS5BbTPqmql37w64aCYVbtUDb41MSr0+sa30n4WUEA3aqH2Gy+m/3ZDlAWfhiUnxNsz0k1aoiJur1tup1EFYoR0mQbCcENx1SXxsL8gGt6SJHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBFFvHa6; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5ffbc6acbso2531271b6e.3;
        Mon, 11 Nov 2024 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731316676; x=1731921476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgzDV6XTYtXT/ZAEBGBUP7h48Bysqg7RCg25yVB5U/k=;
        b=aBFFvHa6TjQRRYej1m2W/DFwPwWqw2BaGBLCbX7i4kgJ/I9UeU51QgZg79ZVYOcDLu
         vpMdHOLOEZ1Ee/WcYp6nh1Yq9RRTlqCPySpTY7K6HZbuWpR5wmnM5xJAclaM4FGp6mc8
         0zMwV/zY3EKXx6xuFWiDNbF8jnhcn+bmBbiVL1SQpfuDmE3u3dM/IWlioRnPuY0xjMsO
         e7yk15FpI7I8pvURMfbishd26UjaOeeBoOQRWtOtpgev+bHbknMorqwcxS0hjVMF5N3k
         m/9VXsUmDPAkxVs2fSv4une1y9ngzrlt4x4rWukKo9+ktF0eJpzSh6j1IrW1rC0qXMJK
         YU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731316676; x=1731921476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgzDV6XTYtXT/ZAEBGBUP7h48Bysqg7RCg25yVB5U/k=;
        b=An6Oqxt8sKVfPjYD3WUGLkqmdT8HNUTPuqceiw0IQD8+WlxP3wDpMvjdULihytl4Kp
         9QoE/sg4Htwo6lkmlryiAZzkz0dI1CY3Z4QYIoOHnazPS/P+2Pcna67jyll7NNyUkR27
         ClG7EpHcmTvn7Le82/zHLWzvOR/3VfLeciohtoDx+R+JuthAfgHnyJOviUv/oqIOVAx3
         5Xfh9EtIhMKrRWCafvc56Knwjt75640T/wLBlFGIFQ1R/4N+FKG6RtthZlA9YBZ9x666
         0I/K9mzStcLPRIyk5RDm5B5dL9gQ/+L44KZVKyQRLGR5hic6piXi9jsl6v+g//mXyaLp
         UpNg==
X-Forwarded-Encrypted: i=1; AJvYcCVW6yzQcBryLnw9s1bD8SVi/2bsARrqdt0qDmWOaZbA2NY1+olHAJDVdgZRQzolRo+1mawJXFq8832z@vger.kernel.org, AJvYcCWhXhd3ZhdO/aiav9m84Tqb1+3pWCirj22Sq0LBn7+g1Hd7xAngx1A47TBBilfGZ8UN5zRGFPkKZ7htN4UP@vger.kernel.org, AJvYcCXtIyJciPC2D6y1ZzySt/W82YBESkbi+xp9LqcRvED0ob9LMwUKMriCRVljXIWoKf24gpyaC435@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh6U/i5bjtIqGlFxNdw5/SzgbfooS79MS4NBC/c5kOQepu3xc
	yf3tXrxGAhlCbk/7ymTQaBIetGi4VgGQFMMO76273zCiYkHEo5du
X-Google-Smtp-Source: AGHT+IH5XF4fHujuj+ksffR1RtxhphO0REZBT78S9uIbUEfLxCgT7hRETIpEKjykIRYtuUK5CY8I6Q==
X-Received: by 2002:a05:6808:16ab:b0:3e7:5af4:f8e7 with SMTP id 5614622812f47-3e794680de1mr10057389b6e.1.1731316676277;
        Mon, 11 Nov 2024 01:17:56 -0800 (PST)
Received: from [192.168.0.101] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5bab50sm6863158a12.25.2024.11.11.01.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 01:17:55 -0800 (PST)
Message-ID: <cb718d0f-75a5-4720-b0c1-d8fb1f1c653b@gmail.com>
Date: Mon, 11 Nov 2024 17:17:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <f3c6b67f-5c15-43e2-832e-28392fbe52ec@lunn.ch>
 <21a00f02-7f2f-46da-a67f-be3e64019303@gmail.com>
 <9455e2f6-b41d-476e-bda9-fc01958e48d5@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <9455e2f6-b41d-476e-bda9-fc01958e48d5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/7/24 21:18, Andrew Lunn wrote:
> On Thu, Nov 07, 2024 at 06:31:26PM +0800, Joey Lu wrote:
>> Dear Andrew,
>>
>> Thank you for your reply.
>>
>> Andrew Lunn 於 11/7/2024 2:13 AM 寫道:
>>>> +  phy-mode:
>>>> +    enum:
>>>> +      - rmii
>>>> +      - rgmii-id
>>> The phy-mode deepened on the board design. All four rgmii values are
>>> valid.
>> I will add them.
>>>> +
>>>> +  tx_delay:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Control transmit clock path delay in nanoseconds.
>>>> +
>>>> +  rx_delay:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Control receive clock path delay in nanoseconds.
>>> If you absolutely really need these, keep them, but i suggest you drop
>>> them. They just cause confusion, when ideally we want the PHY to be
>>> adding RGMII delays, not the MAC.
>>>
>>> If you do need them, then they should be in pS.
>> I will fix it.
>>
>> We have customers who use a fixed link instead of a PHY, so these properties
>> may be necessary.
> That is a legitimate use case which can require the MAC to add delays,
> but i generally try to get the switch on the other end to add the
> delays, just to keep with the uniform setup.
>
> Also, please take a look at ethernet-controller.yaml, these should be
> called rx-internal-delay-ps & tx-internal-delay-ps.
>
> 	Andrew

Thank you, sir. I will use rx-internal-delay-ps and tx-internal-delay-ps 
instead.

                 Joey


