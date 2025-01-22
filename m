Return-Path: <netdev+bounces-160160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55BA1897A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463713A9890
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE153368;
	Wed, 22 Jan 2025 01:24:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11EA84A3E;
	Wed, 22 Jan 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509081; cv=none; b=HIvVkrdy60viOA7n6PoNyxtAc+jSfOgVam8rFrBJ4cix1ehq5idu6Y0PvZYX82SdSKo5JvR//r/Fywa9Tjjsf1f3HgOPMxAG16ESoAog/r2Ymb/rVgzVsingQO3EtHv8G2l0XPukad97fnx1nywx8odG2iYifqgzC2i8NFokZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509081; c=relaxed/simple;
	bh=7J9k+vhJbkWnpKNkU1nyvXKGlDpz5XeS8fbzoe+ZSvE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N3UpPDL2uzIN0hPLQ7747iEPCLdV75dmLBXQcn4zl8RZTHcrWANE2NcjP/Z+Qaj6s+gy1oPUwKSYexgV1tZEscBUfoogrchDxWL1pKPvIkINAoXMuxmwP6Xy8R3amlfDX26S8n/7YoCJDyKOEiWWrlveub4sFleRYXo15MrDyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxDePTSJBnQQFnAA--.9323S3;
	Wed, 22 Jan 2025 09:24:35 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxFOTSSJBnSSMqAA--.21666S2;
	Wed, 22 Jan 2025 09:24:34 +0800 (CST)
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, si.yanteng@linux.dev,
 fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <e4497169-a14f-d29e-bd32-22bb4ed9fcfc@loongson.cn>
Date: Wed, 22 Jan 2025 09:22:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxFOTSSJBnSSMqAA--.21666S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4rWw4xXw1UXFWUGw1Utwc_yoW8tF13pr
	W3Aa4Ygryjqry7tan0yr45ZFyYvrWFgrWxWF4xtwna9as0y34qqFyjgF4Ykr13ArWkKF12
	vr1j9r17CF1qkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2025/1/21 下午5:29, Huacai Chen 写道:
> Hi, Qunqin,
>
> The patch itself looks good to me, but something can be improved.
> 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() callback"
> 2. You lack a "." at the end of the commit message.
> 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
> to 6.12/6.13.
>
> After that you can add:
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
OK, Thanks
>
>
> Huacai
>
> On Tue, Jan 21, 2025 at 4:26 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
>> however, the default waiting time for reset is 200 milliseconds
>>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index bfe6e2d631bd..35639d26256c 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -516,6 +516,18 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
>>          return 0;
>>   }
>>
>> +static int loongson_fix_soc_reset(void *priv, void __iomem *ioaddr)
>> +{
>> +       u32 value = readl(ioaddr + DMA_BUS_MODE);
>> +
>> +       value |= DMA_BUS_MODE_SFT_RESET;
>> +       writel(value, ioaddr + DMA_BUS_MODE);
>> +
>> +       return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
>> +                                 !(value & DMA_BUS_MODE_SFT_RESET),
>> +                                 10000, 2000000);
>> +}
>> +
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>          struct plat_stmmacenet_data *plat;
>> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>
>>          plat->bsp_priv = ld;
>>          plat->setup = loongson_dwmac_setup;
>> +       plat->fix_soc_reset = loongson_fix_soc_reset;
>>          ld->dev = &pdev->dev;
>>          ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>>
>>
>> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
>> --
>> 2.43.0
>>


