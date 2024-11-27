Return-Path: <netdev+bounces-147562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D929DA372
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B11656B0
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAA154C12;
	Wed, 27 Nov 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzRM6WTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076E1272A6;
	Wed, 27 Nov 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694523; cv=none; b=cdCj8H+lWxyHqLSzmzfALWqVnPNd/eTIUKGbPnEqfWi8XVIXenGzcSkvYWXlU19e3YvwpgLlg12/f/FJ64ODGp3WqGjlaAIHJVY9Cuzm5aHXrFc69P7Yz91obRk5w1t0CmVUo8rhgHo4CdsgvHTcDs/NyVydqzwHpT0/nYDkbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694523; c=relaxed/simple;
	bh=TA/9WZEbvgB1jmH6kCzUe9r/FiGqTL+90VzfPh1UVzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvjuAd+jbXUqFQ8Y12cwPp3MXBe3ZKSFjGMVEgv7S0kuZ7vJs5S8uZ4l7LmuzicSXuKOhJF2k9773RsmfKd1jUcjyVwBQFD96mR+gh4CLPX9QgPQbBy7oZkcQ5aZSyxqXNdtrJbl8TJPXsI9Md72ro2GXoULVZF0EE4lr9kQop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzRM6WTf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2124a86f4cbso58320885ad.3;
        Wed, 27 Nov 2024 00:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732694521; x=1733299321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bew/I5xXVZXMcMLGcr2bk1V3h79V/rlhudJAubnILnI=;
        b=JzRM6WTflhvuVNaoLpDjpBRtkSWaGFvch6uCz1KzlfG/5AzIlRqGtW7HywmZCXL4eS
         KiAFxhExAfVlnttpDVpYVd9cqX+UNy8U7yQP+UYOnG4ww16ZZqjPjb9GLKqPVgZJ70Nq
         ssWN3W6JgDu1R3zJtCdc4Ms5ktjNm2eqzR9FzSNv3sfpqnkFd30GDU85fKUSN0J+ngrQ
         8kR5IrWc0002X7kVCJ2RWtGoq6vOX3WcQW1lWCMWi2SOd8r2ZsDYddR5imh7kvKbmBoe
         HFuNQKWko4ncxtKrhgF+QCERLbFM06R0dNuBzaswYhoyrw4f2EQDgt9W8F5eDDdmxYtf
         ti/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694521; x=1733299321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bew/I5xXVZXMcMLGcr2bk1V3h79V/rlhudJAubnILnI=;
        b=s9pKu6nyB5M9EJBO/bfAcHsL2o/6couBcFOPfkNYk+0ycQWp5VWvA259BL26BnVZFW
         qvP0VKv693Ey2ao60ZhhVqSCBMR1myz/57RnivkI4lvd3nN6jAyQgbamVJOeiWfmDMJN
         NSZiCju/pdOGuetstHaAiU4wVaX97jmQADr1Qv+oeURQ/qst7P0BJvm9qycvPmYhbmQq
         BJ9IUBV+Ss1aYbjoaod2MnPeSmKMSAokrsWDFs/Rx0AmjrDGUCAisp9FzoWIYAkVVPFe
         UPmWWtx11bCjAR4/5VNLBoQP10rsjSgQqumTb87PtVx6nW0tH+V5QeJXLzbVXdAxciD1
         ASvA==
X-Forwarded-Encrypted: i=1; AJvYcCVC4qSpfMjaDE0Gs84JXjehZDn20eGFxko97EUeyHgZuT1VCpgcCePP8depj0d7LG0373F13sZ8@vger.kernel.org, AJvYcCVyhDacbGT5p3FUS/aDO9fG6J0U3J76iH2jvtIDe3EhvYdwbzVoO2fLr0WpJtVJfk4YQXOsT57g5IGZ@vger.kernel.org, AJvYcCWCevaguTFm9qI9/gB89Z3bkPRApiKbXWKknFmI5BR1ht3Wd7TxvnHmCj8nHbG185eqBdrWsZPTi6Hdv7fN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IXotH4fWY9zdTC8nc9FuaTE4nZyiNBxFbTl19kKnDEZhjKER
	lTLfi3aK3qTM8GPpF6gTDvI7FYFPCasccSuDVG41gnbvAMwPxuke
X-Gm-Gg: ASbGncsJFqnaJRgk3xC22wz3913tY1ZbOyhyeFeQV3twFoLZ1oMs9aaXRR5fyIY2Bd0
	SCsaZhcTLKI75MmsY5srkRRmJXek8eEI6MNU/Tw5WxoHpTTraYzCPGKFqv7Itu8MJUHZNtqgZfi
	b5lCGWmxowepKFKGezwr0Ws9Ctob/0XzTtRxTk3VwG0zRNOtHutMUFJrgUgLSoqK+gF0nEoz78R
	ejjBgnPnSH7SkW/U0kR6E/nPD+gathzzEFrs20BcfSM15Tc4RYrLOpH9cQrxnNgHWNBBfIZK1a9
	b1a1Qsw3ubQaPPurGvSBF6NxEBH7
X-Google-Smtp-Source: AGHT+IGtUIoISB0+clpN9PkK/2UFXTIykn3qm+m0cLDTT9iuNBtfEZ70ZERWyU6+cs55GUUZXZV4kQ==
X-Received: by 2002:a17:903:2b08:b0:211:e812:3948 with SMTP id d9443c01a7336-21500fedf8amr32131585ad.0.1732694521468;
        Wed, 27 Nov 2024 00:02:01 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c783sm96580615ad.25.2024.11.27.00.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 00:02:01 -0800 (PST)
Message-ID: <6efc512e-b153-4f2c-8b38-4443024475ee@gmail.com>
Date: Wed, 27 Nov 2024 16:01:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: nuvoton: Add Ethernet nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-3-a0987203069@gmail.com>
 <a220d407-de40-4398-a837-de11e01d2381@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <a220d407-de40-4398-a837-de11e01d2381@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.

Krzysztof Kozlowski 於 11/26/2024 6:08 PM 寫道:
> On 18/11/2024 09:27, Joey Lu wrote:
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> index e51b98f5bdce..2e0071329309 100644
>> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -379,5 +379,57 @@ uart16: serial@40880000 {
>>   			clocks = <&clk UART16_GATE>;
>>   			status = "disabled";
>>   		};
>> +
>> +		gmac0: ethernet@40120000 {
>> +			compatible = "nuvoton,ma35d1-dwmac";
>> +			reg = <0x0 0x40120000 0x0 0x10000>;
>> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "macirq";
>> +			clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
>> +			clock-names = "stmmaceth", "ptp_ref";
>> +
>> +			nuvoton,sys = <&sys 0>;
>> +			resets = <&sys MA35D1_RESET_GMAC0>;
>> +			reset-names = "stmmaceth";
>> +			status = "disabled";
> Status is always, always the last property. Please read and follow DTS
> coding style.
>
> Best regards,
> Krzysztof

Got it. I will fix these.

Thanks!

BR,

Joey


