Return-Path: <netdev+bounces-89559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C758AAB1B
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CFBB23A0A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336B651B6;
	Fri, 19 Apr 2024 09:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840665194
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517355; cv=none; b=g3nbrCn3ZWotjjoMJ7jrNiEjFmixpGzKjJf7hQI7ETJE2m5mv5XY685MpWgfMiytAGUCt3m+OX6aPkg7P0sDRseNHJ/u1jc9FHgkaFtstJ/l56Is4T++n8t3ARVWTPlMEt1pJMdp39bOxAwjkD7Z/CyM1bRTrly4+e48boEiQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517355; c=relaxed/simple;
	bh=RB9AneP3F8aXP5eqS0plQxUxrv/bCQqwf0GdBN91ea0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzwXjHhlkPfR3tqJUaP01fRQQBhSHlm1ZabAUumva0c2p84asxOn0C1eDBZ7c05Sba6qPNo0Dv2StJOfub3c0m3TtXbPmvfVI6ZQRaoQyh/A4ZhQExDJgvEEW2O1rLXkIlhV9s+ePCZszl7XcjUf21KXhXXkmDLVJLZmFFnIIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxurofMyJml7gpAA--.13430S3;
	Fri, 19 Apr 2024 17:02:23 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxihIZMyJmcAyAAA--.35989S3;
	Fri, 19 Apr 2024 17:02:18 +0800 (CST)
Message-ID: <636a0d00-3141-4d4d-85af-5232fd5b1820@loongson.cn>
Date: Fri, 19 Apr 2024 17:02:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/6] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>
 <5v6ypjjtbq72ovb437p6n4fkq2z5a3nhkv6spjct2flvjaxmgq@ykrdiv7kk4kq>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <5v6ypjjtbq72ovb437p6n4fkq2z5a3nhkv6spjct2flvjaxmgq@ykrdiv7kk4kq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxihIZMyJmcAyAAA--.35989S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw17AFy5Cry5Cr45urWxuFX_yoW8XFW5pF
	WUJas5uFn5Jw1xJa1DXa1xXFyYq343trWxuw4xKw1fua92gryaqFnFgayY9FnrAF43WF12
	vFs0v3sxCF1vyrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

>>   
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> index daf79cdbd3ec..f161ec9ac490 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> @@ -70,15 +70,17 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>>   	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>>   }
>>   
>> -static void dwmac1000_dma_init(void __iomem *ioaddr,
>> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
>> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
>> +				       void __iomem *ioaddr,
>> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
> please create a pre-requisite/preparation patch with the atds argument
> movement to the stmmac_dma_cfg structure as I suggested in v8:
> https://lore.kernel.org/netdev/yzs6eqx2swdhaegxxcbijhtb5tkhkvvyvso2perkessv5swq47@ywmea5xswsug/
> That will make this patch looking simpler and providing a single
> coherent change.
OK.
>>   	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
>> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> I'll ask once again:
>
> "Isn't the mask change going to be implemented in the framework of the
> Loongson-specific DMA-interrupt handler in some of the further
> patches?"
>
The future is not going to change.


Thanks,

Yanteng

>


