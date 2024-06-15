Return-Path: <netdev+bounces-103778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD13909733
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED37128474B
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F3182BD;
	Sat, 15 Jun 2024 09:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456317555
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443103; cv=none; b=hT0gAh1jg/tAKhhqxVGHtflL4v37r/dHiqGTBmrC2MZFaqDDn4U5yGnDd4GlAQd44nZuB+GweaG1ffcUYZOT0ahPSvUjCN2a9KDib1qPF98H16QPUgYAu9rY/Rw07XpMyo+vI2SCvUXJjhw4fAOBnckiNM3mwQ1jDOR4JW00u8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443103; c=relaxed/simple;
	bh=BBU7CBzhty95mJNdi2CwbXALiaxgjPY9pmMNErP3ruk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3eFDS2HKjSbPrTD4yuetRExQ0xJtQhXwE01fPDDsKaEF/WephwRGGTAtcxNpDz3p5Y8b//5WyY8B/N1ZCBTWxiT8/FH8zZSQAn2ciqAem7sWjFJkwDZmwQFiwEQTNVYafOb3W//iRbGoSp8zzReaatskgJnCwthkiEwowR1cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.225])
	by gateway (Coremail) with SMTP id _____8Bxb+tYXG1mFCEHAA--.28561S3;
	Sat, 15 Jun 2024 17:18:16 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.225])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx78dWXG1mOuQhAA--.17529S3;
	Sat, 15 Jun 2024 17:18:15 +0800 (CST)
Message-ID: <c19e54fc-f352-40c1-8ff2-ca17f31a9dc5@loongson.cn>
Date: Sat, 15 Jun 2024 17:18:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 02/15] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b4ab0f87284b5f2b0f03961b76878dcc000830c2.1716973237.git.siyanteng@loongson.cn>
 <s2nglkzifuhqwfop5ztdaep3cag23s4z2re3s7wvmnf6vkuidi@jnywporyoay7>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <s2nglkzifuhqwfop5ztdaep3cag23s4z2re3s7wvmnf6vkuidi@jnywporyoay7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx78dWXG1mOuQhAA--.17529S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr13tryfCw1UGw13ZryfZrc_yoWrtw1rp3
	y7Xay5WrWkJr13Aa1xJws8XryY9a1rtry29rW0q3yF9a1qy34xWrZ8ta1YgFyUuFn2krW2
	qr4Yvr13Zr9IyrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/6/14 21:31, Serge Semin 写道:
> Hi Yanteng
>
> On Wed, May 29, 2024 at 06:18:18PM +0800, Yanteng Si wrote:
>> DW GMAC v3.x multi-channels feature is implemented as multiple
>> sets of the same CSRs. Here is only preliminary support, it will
>> be useful for the driver further evolution and for the users
>> having multi-channel DWGMAC v3.x devices.
> Why haven't you picked up the commit log suggested on v12? It has more
> details about the feature and the change context. Please use it:
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
Oops! I will pick up in v14.
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>>   .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 32 ++++++++++---------
>>
>>   	.axi = dwmac1000_dma_axi,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> index 72672391675f..363a85469594 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> @@ -22,6 +22,23 @@
>>   #define DMA_INTR_ENA		0x0000101c	/* Interrupt Enable */
>>   #define DMA_MISSED_FRAME_CTR	0x00001020	/* Missed Frame Counter */
>>   
>> +/* Following DMA defines are channels oriented */
>> +#define DMA_CHAN_BASE_OFFSET			0x100
>> +
>> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)
>> +{
>> +	return base + chan * DMA_CHAN_BASE_OFFSET;
>> +}
>> +
>> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan)
>> +#define DMA_CHAN_INTR_ENA(chan)	dma_chan_base_addr(DMA_INTR_ENA, chan)
>> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)
>> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)
>> +#define DMA_CHAN_BUS_MODE(chan)	dma_chan_base_addr(DMA_BUS_MODE, chan)
>> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)
>> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)
>> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)
>> +
> Please re-define the macros in the address ascending order:
> DMA_CHAN_BUS_MODE()
> DMA_CHAN_XMT_POLL_DEMAND()
> DMA_CHAN_RCV_POLL_DEMAND()
> DMA_CHAN_RCV_BASE_ADDR()
> DMA_CHAN_TX_BASE_ADDR()
> DMA_CHAN_STATUS()
> DMA_CHAN_CONTROL()
> DMA_CHAN_INTR_ENA()
> DMA_CHAN_MISSED_FRAME_CTR()
> DMA_CHAN_RX_WATCHDOG()
>
> * Please don't forget DMA_CHAN_RCV_POLL_DEMAND() and
> DMA_CHAN_MISSED_FRAME_CTR() macros you've missed in your patch.
OK.
>>   /* SW Reset */
>>   #define DMA_BUS_MODE_SFT_RESET	0x00000001	/* Software Reset */
>>   
>> @@ -152,7 +169,7 @@
>>   #define NUM_DWMAC1000_DMA_REGS	23
>>   #define NUM_DWMAC4_DMA_REGS	27
>>   
>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);
>> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>>   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			  u32 chan, bool rx, bool tx);
>>   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>> @@ -168,5 +185,4 @@ void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			struct stmmac_extra_stats *x, u32 chan, u32 dir);
>>   int dwmac_dma_reset(void __iomem *ioaddr);
>> -
> What has been wrong with this empty line so you decided to remove it?)

OK, will restore it.


Thanks,

Yanteng

>
> -Serge(y)
>


