Return-Path: <netdev+bounces-155706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA5A036C2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5C918892DE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9630132111;
	Tue,  7 Jan 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL2xj0ln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B04179BD;
	Tue,  7 Jan 2025 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222122; cv=none; b=aZsHQcgvlQOKlPT0fIqk968s7A7kL7E9fJFmWB7L0h3aYdg4hrlrqVl2e7OSKZ3bAFKSzt1/XOZ9/mMJNmx7OraqxGSS7G8sJUuXmWRtl0mZ3RfLRR28PHsyAOtBuBXOYw+7/fT7L0D/hMolrC8extVfkaAgMBKlru+h0CiSY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222122; c=relaxed/simple;
	bh=MCyi/Uq5xfm6lADiXWeYpnAzki3jw/DvNmQ0riZ4B0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWWqyOyUoYVf5+dIrKXhSSrM8XreAXiq4d5uY1pGSytziZaANco/paDTXcan1PuR70kohSWnl5ZAuC2CMkrxn4ve5CrlWkYSgt+Kk1LGr30nK/KL5TxtHLHfmmUKi1Bg724Y1DnHIzTp8brAyz4kUpPFDWM3sYqnqeiec+i85QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL2xj0ln; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441791e40so17724836a91.3;
        Mon, 06 Jan 2025 19:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736222120; x=1736826920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkSX5xIdc8zBLFm+jjJZtb1iB0BmRRseeOTnpcRWYIA=;
        b=TL2xj0lnIsrlEDjmeQIyqDD5Q9yXJEHWWiefMRESuRm2izR/qN9wBXZVV4/ajRjf9O
         ADFPaQNPYcqVAb747q0/eqkXlb6Ev/2EHwWEeE4DI4K/aky7WmEsqhOsQzquSWE5MK6L
         eelGlbjNOowCRj19jQs3MyuxhwsEciNpp+ItdGtVLyp+LP0383UF1XAoygSPJcLPfK7y
         sMwVXSLvpH/4SYl+Ejm98uhjD1kof/SGMZ960MNWgMHZ/cCdwWuqNNB3qImHtBCMplhF
         jtr337N0jlGUS+wKQ44mX+OFgUp128I1M8R/rjvY6iBJUb/1h7W8W4/Q/1hmcVOAme+n
         fdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736222120; x=1736826920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkSX5xIdc8zBLFm+jjJZtb1iB0BmRRseeOTnpcRWYIA=;
        b=e01aSuXCfjsCVHgzkJCRiqNkQ+I5d8y//mzJqSHHF3ViIzwCDcjyuuwzwxfx4LvUY8
         KEbdvAyOh2inFBy7PH9tepCDwBxflJbSugJmoJSbAi4zJE84gJOMyssJyclIQK3rh5E6
         SxgVKLLnn5ZGrU6K7fyoBhY+TftdrtXBl7ySHAEwlkaYVu5h6pt7z77fwsNoVnj2RmDL
         GdEC5kZzyVM2ltDGOYG0ZjthTzpkuDU+llEsdydw5ZEitAzt9eGslghXyAy0opYRMjiK
         p05sp2MtqUlTHb1EoDubNcBjFwgTeXAhC/pcJCGwJf3Sb+RQoG0ZMhMD7Ds3SjzdkkC3
         jBew==
X-Forwarded-Encrypted: i=1; AJvYcCVYLEInIEroxCtgpeGgX21BCXfv0f+5ESdtw5WCAp/nll8EnG5NhDBlfoT5BhRzXsgw/AfmpOtp@vger.kernel.org, AJvYcCWyFOCTn1ZCOH8ouwOk1LJfwpABzD/uNyXIYDDqn9EtQ1oO+n7UUMREnIrMpYKt5TlDe7gjebAig12vDX/+@vger.kernel.org, AJvYcCXaTkINZCudD5K6WooX5gd/WH5BBa2EOHP+X129GFDDeeC5Q5zBxzxqm82ao9bF0822qqI8uiULj0Vr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/QTfmAXwxIRDn6P0q7ymPz3mwk4IkpQ/3vyIhZBQTxxdiwCR
	oPBun/suqFs/2nKeIoB03vRMMnBrMxA8BWX5TTVL6iG6p+EhT+zl
X-Gm-Gg: ASbGncviJt9nRwOroYi+kO2ZwshMzZSBQaQon6nRqXVPI67EXVCsn/X7fUpXac4v/mL
	OfWYE5Db8F2IQqEz7HT0KN41qRhZOEwmxyeUNJB3dXV9IA25iCQ7MzxYhruiweu5yn3B+BlWRZz
	R/cS5JmNLE9N2uZVq33KJxoS2efJqmMTMWt6WPmJTXDopYimhsmleVEx5PG1c2NzsOeE0ahdt04
	1mA0nALFqzQ4P4m0Lr45hPDteUQADT7DFsf+33f339XyqRBpuW8Bl5WnPL4VlmAEdP7chcVHt/4
	PZJDvkLmJHaFBOY3hgc9f6m0vg2D/4iZ2A0=
X-Google-Smtp-Source: AGHT+IE2K2gRs1V2fgpYN0CLM9zdF4nwVbYze0GXJZkFBE9yEldHu2WRl6ZMw9QvCXUDA6422eZIOQ==
X-Received: by 2002:a17:90b:2545:b0:2ee:a76a:820 with SMTP id 98e67ed59e1d1-2f452e3eebamr85264355a91.18.1736222120018;
        Mon, 06 Jan 2025 19:55:20 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f48db83c37sm26295046a91.47.2025.01.06.19.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 19:55:19 -0800 (PST)
Message-ID: <14ad5eae-e10d-426d-ace1-f841b5249e9f@gmail.com>
Date: Tue, 7 Jan 2025 11:55:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250103063241.2306312-4-a0987203069@gmail.com>
 <2736ccd3-680d-4f5d-a31a-156dec056f22@wanadoo.fr>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <2736ccd3-680d-4f5d-a31a-156dec056f22@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Christophe JAILLET 於 1/4/2025 12:38 AM 寫道:
> Le 03/01/2025 à 07:32, Joey Lu a écrit :
>> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac 
>> driver.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>
> ...
>
>> +    /* Nuvoton DWMAC configs */
>> +    plat_dat->has_gmac = 1;
>> +    plat_dat->tx_fifo_size = 2048;
>> +    plat_dat->rx_fifo_size = 4096;
>> +    plat_dat->multicast_filter_bins = 0;
>> +    plat_dat->unicast_filter_entries = 8;
>> +    plat_dat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
>> +
>> +    priv_data = nvt_gmac_setup(pdev, plat_dat);
>> +    if (IS_ERR(priv_data))
>> +        return PTR_ERR(priv_data);
>> +
>> +    ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>
> stmmac_pltfr_remove() is called by the .remove function.
> Is it correct to call stmmac_dvr_probe() here, and not 
> stmmac_pltfr_probe()?

Thank you for the feedback. You're correct. I will update the code to 
call stmmac_pltfr_probe().

BR,

Joey

>
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* The PMT flag is determined by the RWK property.
>> +     * However, our hardware is configured to support only MGK.
>> +     * This is an override on PMT to enable WoL capability.
>> +     */
>> +    plat_dat->pmt = 1;
>> +    device_set_wakeup_capable(&pdev->dev, 1);
>> +
>> +    return 0;
>> +}
>
> ...
>
>> +static struct platform_driver nvt_dwmac_driver = {
>> +    .probe  = nvt_gmac_probe,
>> +    .remove = stmmac_pltfr_remove,
>> +    .driver = {
>> +        .name           = "nuvoton-dwmac",
>> +        .pm        = &stmmac_pltfr_pm_ops,
>> +        .of_match_table = nvt_dwmac_match,
>> +    },
>> +};
>
> ...
>
> CJ

