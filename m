Return-Path: <netdev+bounces-193478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BFAC42DC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D7D189248D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E49214814;
	Mon, 26 May 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b="ennRCcKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753E19CC37
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276231; cv=none; b=Gw6sjBLNGZYcLpsQ/SfLc6asrzWRroGJ+YIdndySEaX5FIYdh0hncDVw24yhwyTk0UXfi/46FwtWoROMB0wO9h+fT7MQWe09Rsl95fw54osKuRS6NyGpFdNERtN5lWZlFQCP/IDDPs+636IxL50WZYJRN3ymsSM47WGj0iXvTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276231; c=relaxed/simple;
	bh=BbfJwyvUfPcPHmjozsUgs5lTeEXemRIfUXabR3ZB/mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imbBiXwcbfzX//pxBUFEoW296q0MaVkDzTDTSzlv7BGH63upmtRtyLmzmx+qn7otmiHjWyEVJLObQAa1SwSEKx9/i2STZxofCYqptSlWL1z1S6TXyPwB5qhC9tZQkx8p0npX7PJfd/X+8OMKqBBgf+sUPmtSJCosLrj+dGLREZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai; spf=pass smtp.mailfrom=sima.ai; dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b=ennRCcKg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sima.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2340ea6f3c1so1283465ad.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sima.ai; s=google; t=1748276229; x=1748881029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpLNyektUDJ+Wy1bMHRPw9xz1Qvt5LipEoHKiCF+WW0=;
        b=ennRCcKgO+9VTohpIelqOFFhBf/6aI51TtpdnvkGlHWHurC3WNzDP2C5gJyy8KBBWz
         ZxZIarjDCra3qzvxJm+EzHZPDWQDCMSX/6FuKc5j+8STzGcMQVrbnwBaUo0UHYRwfHLc
         o+v+32NRFp5cU5OMsCw93zTEBFh+zPWGfeXD++uNqn/zKrXnNd/mxsW4fxrBIIenCn4B
         nHZvJCyir7Ytd7mvGHdZAsvsFKgNryCC1xz2qTSqhoB1ixJm1rNgA6DI523S29JeYVF1
         cWe3qsBfLYQp3Jhhc8Tr5qoace2cfpkoq2TqecNfrUbWEPxXws3EVlp7oWs9mkDh08/c
         /3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748276229; x=1748881029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpLNyektUDJ+Wy1bMHRPw9xz1Qvt5LipEoHKiCF+WW0=;
        b=PD3Wkf9nrsIP5qz2abIgPlvJdfo3JjSFRZegVntdZ6/64KBTJRYK2YSAH9Bn8Z2tX+
         10b8cdWE1Vj9Hd3lTKGgiXg9RDpuDD1HVPEs0TDHt9azZArhIaKJWwFktxrqxWlHCl8r
         BD2jhYLI8ByWjrO5MEIgcISKLjU0e7FSJxwRE/Kkg8uVNTFheRpZeXLwdCaBLutYxpRQ
         wJrqZHfTrpZe5Cfs65+cI5gGULQN244XR5cijU5SU0J7WsYWFpmePq8qp5M8fYjX6tvi
         HrUxQ9+VIbRhNh5/SG+pq7Z4JKrRlIka5c9ujR1nfyiGNUMIQAeTTcY0PVssr2m6tLnV
         4oyw==
X-Forwarded-Encrypted: i=1; AJvYcCVtRU/fTFfkCUqrUmgp2wXg3ln+pk+lfKdaxhIMQG6KjWMgTaKxeg6TuDG+/Jss+l7d4iO2rWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx29osqr2mCCJLBSJ9+Ui8x8WOEtMA3inLQUW92FD0341WI5sn
	4oUWkeBTcqoBWEJdpCIt9qLwuEWMQRdPTQ+rUGn6gNiEA+w1h9Z0djW/elq/KcuZlmg=
X-Gm-Gg: ASbGncu5x/GnjdjRMCL/BnTPDoaXlFd9cuDbvt8b8KELQnyvqYmP+AABGnO+pmoFT4E
	hB3PBxcHkEDlRPe9CsCcQR/gH1g3z6O4BtTvaj+xHIR2SyHj3TvL3U/bNHBr1lxjEMPrVBrHEJu
	iKM6S86dFVHFmk6EqYVmLPzNIdyeTW7+6464YZpumZ2KFqOZ4Is+bU3Fzgr9VpobncefSKr/z4j
	VrVwyZYWh1HLmcJsJIaBNY2rUIKN3QhuxXYIRDGLNqjnOHEu2zf3G/5oYyvH6hIHoFg4e4aqpuA
	hURVqL5k+3GBp5hnRX2ZyX2GV7YZJq6UvnKQ8FRiuKqj+qShjoEDxKPmbOkEeEvGBEVo
X-Google-Smtp-Source: AGHT+IEhAY42K8o5WUtsFhwOWKSys2t+FWegKVAVXKM+NEJ0A73fVF3hLcAex7C5XJx2ISqqHBdL8A==
X-Received: by 2002:a17:902:eccb:b0:224:1579:b347 with SMTP id d9443c01a7336-23414f64ab7mr53080415ad.7.1748276229149;
        Mon, 26 May 2025 09:17:09 -0700 (PDT)
Received: from [172.16.1.45] ([45.62.187.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2341ccad6fcsm41723455ad.170.2025.05.26.09.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 09:17:08 -0700 (PDT)
Message-ID: <93ae82e6-44f4-4f2f-b3b6-71240f84500c@sima.ai>
Date: Mon, 26 May 2025 09:17:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: set multicast filter to zero if feature is
 unsupported
To: Yanteng Si <si.yanteng@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250523221938.2980773-1-nikunj.kela@sima.ai>
 <e0552940-9fbe-4375-a9a9-e26cd425591a@linux.dev>
Content-Language: en-US
From: Nikunj Kela <nikunj.kela@sima.ai>
In-Reply-To: <e0552940-9fbe-4375-a9a9-e26cd425591a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/25/25 7:09 PM, Yanteng Si wrote:
> 在 5/24/25 6:19 AM, Nikunj Kela 写道:
>> Hash based multicast filtering is an optional feature. Currently,
>> driver overrides the value of multicast_filter_bins based on the hash
>> table size. If the feature is not supported, hash table size reads 0
>> however the value of multicast_filter_bins remains set to default
>> HASH_TABLE_SIZE which is incorrect. Let's override it to 0 if the
>> feature is unsupported.
>>
>> Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 085c09039af4..ccea9f811a05 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7241,6 +7241,9 @@ static int stmmac_hw_init(struct stmmac_priv 
>> *priv)
>>                       (BIT(priv->dma_cap.hash_tb_sz) << 5);
>>               priv->hw->mcast_bits_log2 =
>> ilog2(priv->hw->multicast_filter_bins);
>> +        } else {
>> +            priv->hw->multicast_filter_bins = 0;
>> +            priv->hw->mcast_bits_log2 = 0;
>>           }
>
> I didn't read the code carefully, just did a simple search：
>
> ❯ grep -rn multicast_filter_bins drivers/net/
> drivers/net/ethernet/stmicro/stmmac/common.h:611:    unsigned int 
> multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:26: 
> plat_dat->multicast_filter_bins = 0;
> ***
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:512: 
> plat->multicast_filter_bins = HASH_TABLE_SIZE;
> ***
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:536: 
> &plat->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:541: 
> plat->multicast_filter_bins = dwmac1000_validate_mcast_bins(
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:542: &pdev->dev, 
> plat->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:523: 
> mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:527:    if 
> (mac->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:528: 
> mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:516: 
> (netdev_mc_count(dev) > hw->multicast_filter_bins)) {
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1527: 
> mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1531:    if 
> (mac->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1532: 
> mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1568: 
> mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1572:    if 
> (mac->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1573: 
> mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:543:    if 
> (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:633:    if 
> (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c:679:    if 
> (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:31: 
> plat->multicast_filter_bins = HASH_TABLE_SIZE;
> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:84: 
> plat->multicast_filter_bins = HASH_TABLE_SIZE;
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:98: 
> plat->multicast_filter_bins = 256;
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:365: 
> mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:369:    if 
> (mac->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:370: 
> mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7240: 
> priv->hw->multicast_filter_bins =
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:7243: 
> ilog2(priv->hw->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:570: 
> plat->multicast_filter_bins = HASH_TABLE_SIZE;
> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:707: 
> plat->multicast_filter_bins = HASH_TABLE_SIZE;
> drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c:479: 
> plat_dat->multicast_filter_bins = 0;
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:456:    int 
> numhashregs = (hw->multicast_filter_bins >> 5);
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:485: 
> (netdev_mc_count(dev) > hw->multicast_filter_bins)) {
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:1057: 
> mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:1061:    if 
> (mac->multicast_filter_bins)
> drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:1062: 
> mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c:43: 
> plat_dat->multicast_filter_bins = HASH_TABLE_SIZE;
>
> and
>
> drivers/net/ethernet/stmicro/stmmac/common.h:265:#define 
> HASH_TABLE_SIZE 64
>
>
> From the search results, the default value of multicast_filter_bins
> may be meaningful. And I think that even if some hardware does not
> support this feature, it should still be overridden in its own directory.

There is a DT property 'snps,multicast-filter-bins' available to 
override the default value for a platform however this property is not 
taken into consideration in case of xgmac. That being said, 
stmmac_platform.c logic can be modified to extend the property use for 
xgmac also however the value will be overridden later based on hash 
table size read from the HW Feature register. So only zero value will be 
usable via DT in that case. Hence I thought of setting it to 0 in the 
else part of the code I modified in this patch. If you think I should 
extend the DT property for xgmac, I can modify the patch too.

Thanks,

-Nikunj

>
>
> Thanks,
> Yanteng
>

