Return-Path: <netdev+bounces-95385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72F8C21CE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D9C1F21B11
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB444165FD8;
	Fri, 10 May 2024 10:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6A165FCB
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336037; cv=none; b=OIhKo8voUEOOGZ7mV0m7GPPomED/GxJZMrYewA2wikyLW5zQXY3N7yjRYTOD5pFy/Dgw3Reo4hu5mDe5+jIwcvD2bAh6qFOtl3Icj9Iz/s3f3DbrCBCKn62HfEPp90G16VYpR1LC76lYKld7+T0V/bjZMjQhDc3KzOJLfn7rpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336037; c=relaxed/simple;
	bh=05WBO0dHpHCs3B2si0lnWUO4hKXI7L3zIv/qUk1JrrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBqKKQv22BGtbKHoybzVQm01bPyCF/JTe2mdSGNxqFY7g9NGU+ADsIZl56NVL7fpHPNaMHAmtUEXZ8oPnnLvyGO1CDwtY5Ulglch61GTs6itSLkKNNh4UGV9MoQRfgcjnY1eiseNaZUXI/OrxZ0Ro4S7n+7p5327PIE6FZZF1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxCupW8z1mUIgKAA--.14859S3;
	Fri, 10 May 2024 18:13:42 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxKORU8z1mO5oYAA--.45943S3;
	Fri, 10 May 2024 18:13:41 +0800 (CST)
Message-ID: <33ee7998-df36-492c-9507-a08c3a6dad9b@loongson.cn>
Date: Fri, 10 May 2024 18:13:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 02/15] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <5409facf916c0123e39a913c8342cc0ce8ed93db.1714046812.git.siyanteng@loongson.cn>
 <zbs5vkzyuoyte5mr2pprf7xxahhuxlinvxe24h4oc6jeshwii5@ivqr45z27ef4>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <zbs5vkzyuoyte5mr2pprf7xxahhuxlinvxe24h4oc6jeshwii5@ivqr45z27ef4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxKORU8z1mO5oYAA--.45943S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1xWF1rWw1UKFyfXFy3WrX_yoWrZFWDpF
	WkA3yvqF95JF1Sy3WkJw4kXFyrtr15tw1UZrs5Ga429a1qgr90qr4Ygayjga4UuF4xAr42
	qr4Utr1Dur1DAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

Hi Serge

在 2024/5/3 06:02, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:01:55PM +0800, Yanteng Si wrote:
>> DW GMAC v3.x multi-channels feature is implemented as multiple
>> sets of the same CSRs. Here is only preliminary support, it will
>> be useful for the driver further evolution and for the users
>> having multi-channel DWGMAC v3.x devices.
> Why do you call it "preliminary"? AFAICS it's a fully functional
> support with no restrictions. Am I wrong?
>
> I would reformulate the commit message as:
>
> "DW GMAC v3.73 can be equipped with the Audio Video (AV) feature which
> enables transmission of time-sensitive traffic over bridged local area
> networks (DWC Ethernet QoS Product). In that case there can be up to two
> additional DMA-channels available with no Tx COE support (unless there is
> vendor-specific IP-core alterations). Each channel is implemented as a
> separate Control and Status register (CSR) for managing the transmit and
> receive functions, descriptor handling, and interrupt handling.
>
> Add the multi-channels DW GMAC controllers support just by making sure the
> already implemented DMA-configs are performed on the per-channel basis.
>
> Note the only currently known instance of the multi-channel DW GMAC
> IP-core is the LS2K2000 GNET controller, which has been released with the
> vendor-specific feature extension of having eight DMA-channels. The device
> support will be added in one of the following up commits."
OK.
>
>
>> @@ -153,7 +155,7 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>   					    void __iomem *ioaddr, int mode,
>>   					    u32 channel, int fifosz, u8 qmode)
>>   {
>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>   
>>   	if (mode == SF_DMA_MODE) {
>>   		pr_debug("GMAC: enable RX store and forward mode\n");
>> @@ -175,14 +177,14 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>   	/* Configure flow control based on rx fifo size */
>>   	csr6 = dwmac1000_configure_fc(csr6, fifosz);
>>   
>> -	writel(csr6, ioaddr + DMA_CONTROL);
>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>   }
>>   
>>   static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>   					    void __iomem *ioaddr, int mode,
>>   					    u32 channel, int fifosz, u8 qmode)
>>   {
>> -	u32 csr6 = readl(ioaddr + DMA_CONTROL);
>> +	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
>>   
>>   	if (mode == SF_DMA_MODE) {
>>   		pr_debug("GMAC: enable TX store and forward mode\n");
>> @@ -209,7 +211,7 @@ static void dwmac1000_dma_operation_mode_tx(struct stmmac_priv *priv,
>>   			csr6 |= DMA_CONTROL_TTC_256;
>>   	}
>>   
>> -	writel(csr6, ioaddr + DMA_CONTROL);
>> +	writel(csr6, ioaddr + DMA_CHAN_CONTROL(channel));
>>   }
>>   
> Just figured out that besides of the channel-related changes you also need
> to have the stmmac_dma_operation_mode() method fixed. So one wouldn't
> redistribute the detected Tx/Rx FIFO between the channels. Each DW GMAC
> channel has separate FIFO of the same size. The databook explicitly says
> about that:
>
> "The Tx FIFO size of all selected Transmit channels is always same.
> Similarly, the Rx FIFO size of all selected Receive channels is same.
> These channels cannot be of different sizes."
>
Should I do this, right?

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 33d04243b4d8..9d4148daee68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2371,8 +2371,13 @@ static void stmmac_dma_operation_mode(struct 
stmmac_priv *priv)
                 txfifosz = priv->dma_cap.tx_fifo_size;

         /* Adjust for real per queue fifo size */
-       rxfifosz /= rx_channels_count;
-       txfifosz /= tx_channels_count;
+       if ((priv->synopsys_id != DWMAC_CORE_3_40) ||
+           (priv->synopsys_id != DWMAC_CORE_3_50) ||
+           (priv->synopsys_id != DWMAC_CORE_3_70)) {
+               rxfifosz /= rx_channels_count;
+               txfifosz /= tx_channels_count;
+       }
+

         if (priv->plat->force_thresh_dma_mode) {
                 txmode = tc;


Thanks,

Yanteng


