Return-Path: <netdev+bounces-160161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11AA1898E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4B41881CC0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0761EB44;
	Wed, 22 Jan 2025 01:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9923DE;
	Wed, 22 Jan 2025 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509627; cv=none; b=e2F1vaBlcFSV/9MJF/05UQNtemAKhuIollXnkZ9O9Q00wzGk7QrOYJ7hJuP7CUZv0UoeBaFLEK78vrAcHqQTMlu77AFvNiT4u6J3q37HvQy+GS5Ea+o6hkZQhKC+Z3WyK6//ZxzcRzajbFukuEI2hHDwYFI4xPvfOBPQBZjrP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509627; c=relaxed/simple;
	bh=tmoIjGC+MFlbC5dNKjHuH9lj7Z3Y77wDADRN3UlypRA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fxUMuLI5rRr51xNJGL81A8vVs83EUWfp76E469pnpk2/B9HNqMwzVUP3LXxQjcM24BLuVz17yhztv5bnMjBmCNtn547hK5OYMeM1UeXUZivSjckLjpxJDsWiH5mJOG2sWUZNTvdQJppk/edOI+olgFTnupPlE/gxy5H/CijveOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxyuD3SpBnzgFnAA--.3851S3;
	Wed, 22 Jan 2025 09:33:43 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxNeTzSpBnECQqAA--.21615S2;
	Wed, 22 Jan 2025 09:33:42 +0800 (CST)
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Yanteng Si <si.yanteng@linux.dev>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenhuacai@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <4787f868-a384-4753-8cfd-3027f5c88fd0@linux.dev>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <7073a4e9-2a6b-a3e9-769e-5069b0e9772c@loongson.cn>
Date: Wed, 22 Jan 2025 09:31:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4787f868-a384-4753-8cfd-3027f5c88fd0@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxNeTzSpBnECQqAA--.21615S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryUXr4kZw4UXF1rZFW7ZFc_yoW8trWDpr
	4kAa43Kry5XryxJ3WUAr45XFyYvrW8tw4DWF4xt3Z5K3yDAr90qr1jqF4q9r17ArWkKF12
	vr1UursruF1DJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUU
	U==


在 2025/1/21 下午9:41, Yanteng Si 写道:
>
> 在 1/21/25 16:25, Qunqin Zhao 写道:
>> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
>> however, the default waiting time for reset is 200 milliseconds
> Is only GMAC like this?
At present, this situation has only been found on GMAC.
>>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c 
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index bfe6e2d631bd..35639d26256c 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -516,6 +516,18 @@ static int loongson_dwmac_acpi_config(struct 
>> pci_dev *pdev,
>>       return 0;
>>   }
> How about putting a part of the commit message here as a comment?
Sure, will do that.
>> +static int loongson_fix_soc_reset(void *priv, void __iomem *ioaddr)
>
>
>> +{
>> +    u32 value = readl(ioaddr + DMA_BUS_MODE);
>> +
>> +    value |= DMA_BUS_MODE_SFT_RESET;
>> +    writel(value, ioaddr + DMA_BUS_MODE);
>> +
>> +    return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
>> +                  !(value & DMA_BUS_MODE_SFT_RESET),
>> +                  10000, 2000000);
>> +}
>> +
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct 
>> pci_device_id *id)
>>   {
>>       struct plat_stmmacenet_data *plat;
>> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev 
>> *pdev, const struct pci_device_id
>>         plat->bsp_priv = ld;
>>       plat->setup = loongson_dwmac_setup;
>> +    plat->fix_soc_reset = loongson_fix_soc_reset;
>
> If only GMAC needs to be done this way, how about putting it inside 
> the loongson_gmac_data()?

Regardless of whether this situation occurs in other devices(like gnet), 
this change will not have any impact on gnet, right?

Thanks.

>
> Thanks,
>
> Yanteng


