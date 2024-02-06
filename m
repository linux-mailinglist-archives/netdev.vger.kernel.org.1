Return-Path: <netdev+bounces-69395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D784B0B2
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B051C243CE
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B612C814;
	Tue,  6 Feb 2024 09:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7C12BF3C
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210166; cv=none; b=AZhJIup8m8qntoQftJwEdwEBdHQbn0nVigDjDCpcD1p+tqVgLquc12rqz4ErOydFaq1iqrVk2vHdFj+mvSCm8nINhXwgdFyhDTBzTn0Q68p8mTMxU6XX5OyEBCYASlX7+Ku/p9lriEyvAThInkzsrKb+Mmd2T8N3JszvhcM11mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210166; c=relaxed/simple;
	bh=DqzkZLAJplusZVIkfiq8QGup2YIBWvozP5StcL61UdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8Pv0VdWGDDH7AgbNYqTLYBgeGRCMZ4bDRZQdB1ek9X5pMW8dAI8f6xFf2//QR0sfILs5jIy925S/lmSeO7mWmhw2NkKvmL9eT9RbsYFNR4rPi5AuzOaN26wKuAqn83c3kznOaLQzv4dxaF+LZ/YCboR1Fa3dLbryYyPfVr/Uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.61])
	by gateway (Coremail) with SMTP id _____8BxVfGq9cFl7ycLAA--.31774S3;
	Tue, 06 Feb 2024 17:02:34 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.61])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs+l9cFl1NswAA--.51866S3;
	Tue, 06 Feb 2024 17:02:30 +0800 (CST)
Message-ID: <f6b6aad5-7010-42a5-b17d-f0b95f5c94f0@loongson.cn>
Date: Tue, 6 Feb 2024 17:02:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/11] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <a2f467fd7e3cecc7dc4cc0bfd2968f371cd40888.1706601050.git.siyanteng@loongson.cn>
 <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <bhnrczwm2numoce3olexw4ope7svz6uktk44ozefxyeqrof4um@7vkl2fr6uexc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs+l9cFl1NswAA--.51866S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZFW7tFW5KryfAry7WF13ZFc_yoW8WF1xXo
	Z3Arnagr1agw1rur97Kw1kXry7X3sxZw45CFW8ur4kua97CayYyrW0q393Wa13JF43uFW5
	Z348Xa4qvF45tF15l-sFpf9Il3svdjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYG7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


在 2024/2/5 07:28, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:43:21PM +0800, Yanteng Si wrote:
>> DW GMAC v3.x multi-channels feature is implemented as multiple
>> sets of the same CSRs. Here is only preliminary support, it will
>> be useful for the driver further evolution and for the users
>> having multi-channel DWGMAC v3.x devices.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
>>   .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 36 ++++++++++---------
>>   .../net/ethernet/stmicro/stmmac/dwmac_dma.h   | 19 +++++++++-
>>   .../net/ethernet/stmicro/stmmac/dwmac_lib.c   | 32 ++++++++---------
>>   drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++--
>>   6 files changed, 58 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> index 137741b94122..7cdfa0bdb93a 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>> @@ -395,7 +395,7 @@ static void sun8i_dwmac_dma_start_tx(struct stmmac_priv *priv,
>>   	writel(v, ioaddr + EMAC_TX_CTL1);
>>   }
>>   
>> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
>> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>   {
>>   	u32 v;
>>   
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> index daf79cdbd3ec..5f7b82ad3ec2 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> @@ -70,15 +70,18 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
>>   	writel(value, ioaddr + DMA_AXI_BUS_MODE);
>>   }
>>   
>> -static void dwmac1000_dma_init(void __iomem *ioaddr,
>> -			       struct stmmac_dma_cfg *dma_cfg, int atds)
>> +static void dwmac1000_dma_init_channel(struct stmmac_priv *priv,
>> +				       void __iomem *ioaddr,
>> +				       struct stmmac_dma_cfg *dma_cfg, u32 chan)
>>   {
>> -	u32 value = readl(ioaddr + DMA_BUS_MODE);
>> +	u32 value;
>>   	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
>>   	int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
> Reverse xmas tree please.
OK!
>
>>   
>> -	/*
>> -	 * Set the DMA PBL (Programmable Burst Length) mode.
>> +	/* common channel control register config */
> Redundant comment. Please drop.
OK!
>
>> +	value = readl(ioaddr + DMA_CHAN_BUS_MODE(chan));
>> +
>> +	/* Set the DMA PBL (Programmable Burst Length) mode.
>>   	 *
>>   	 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
>>   	 * post 3.5 mode bit acts as 8*PBL.
>> @@ -98,16 +101,15 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
>>   	if (dma_cfg->mixed_burst)
>>   		value |= DMA_BUS_MODE_MB;
>>   
>> -	if (atds)
>> -		value |= DMA_BUS_MODE_ATDS;
>> +	value |= DMA_BUS_MODE_ATDS;
> No, just convert the stmmac_dma_ops.dma_init_channel() to accepting
> the atds flag as I suggested in v7:
> https://lore.kernel.org/netdev/vxcfrxtbfu4pya56m22icnizsyjzqqha5blzb7zpexqcur56uh@uv6vsjf77npa/
>
> In order to simplify this patch you can provide the
> stmmac_dma_ops.dma_init_channel() and
> stmmac_dma_ops.enable_dma_transmission() prototype updates in a
> pre-requisite/preparation patch.
OK.
>
>>   
>>   	if (dma_cfg->aal)
>>   		value |= DMA_BUS_MODE_AAL;
>>   
>> -	writel(value, ioaddr + DMA_BUS_MODE);
>> +	writel(value, ioaddr + DMA_CHAN_BUS_MODE(chan));
>>   
>>   	/* Mask interrupts by writing to CSR7 */
>> -	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_INTR_ENA);
>> +	writel(DMA_INTR_DEFAULT_MASK, ioaddr + DMA_CHAN_INTR_ENA(chan));
>>   }
>>   
>>   static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>> @@ -116,7 +118,7 @@ static void dwmac1000_dma_init_rx(struct stmmac_priv *priv,
>>   				  dma_addr_t dma_rx_phy, u32 chan)
>>   {
>>   	/* RX descriptor base address list must be written into DMA CSR3 */
>> -	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_RCV_BASE_ADDR);
>> +	writel(lower_32_bits(dma_rx_phy), ioaddr + DMA_CHAN_RCV_BASE_ADDR(chan));
>>   }
>>   
>>   static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>> @@ -125,7 +127,7 @@ static void dwmac1000_dma_init_tx(struct stmmac_priv *priv,
>>   				  dma_addr_t dma_tx_phy, u32 chan)
>>   {
>>   	/* TX descriptor base address list must be written into DMA CSR4 */
>> -	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_TX_BASE_ADDR);
>> +	writel(lower_32_bits(dma_tx_phy), ioaddr + DMA_CHAN_TX_BASE_ADDR(chan));
>>   }
>>   
>>   static u32 dwmac1000_configure_fc(u32 csr6, int rxfifosz)
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
>>   static void dwmac1000_dump_dma_regs(struct stmmac_priv *priv,
>> @@ -271,12 +273,12 @@ static int dwmac1000_get_hw_feature(void __iomem *ioaddr,
>>   static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
>>   				  void __iomem *ioaddr, u32 riwt, u32 queue)
>>   {
>> -	writel(riwt, ioaddr + DMA_RX_WATCHDOG);
>> +	writel(riwt, ioaddr + DMA_CHAN_RX_WATCHDOG(queue));
>>   }
>>   
>>   const struct stmmac_dma_ops dwmac1000_dma_ops = {
>>   	.reset = dwmac_dma_reset,
>> -	.init = dwmac1000_dma_init,
>> +	.init_chan = dwmac1000_dma_init_channel,
>>   	.init_rx_chan = dwmac1000_dma_init_rx,
>>   	.init_tx_chan = dwmac1000_dma_init_tx,
>>   	.axi = dwmac1000_dma_axi,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> index 72672391675f..593be79c46e1 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> @@ -148,11 +148,14 @@
>>   					 DMA_STATUS_TI | \
>>   					 DMA_STATUS_MSK_COMMON)
>>   
>> +/* Following DMA defines are chanels oriented */    \
>> +#define DMA_CHAN_OFFSET			0x100   |-------------+
>> +                                                    /              |
>                                                                        |
> Please move all of these ---------------------------------------------+-------------------------+
> to being defined just below the DMA_MISSED_FRAME_CTR macros definition.                         |
> The point is to keep a coherency between dwmac_dma.h and dwmac4_dma.h.                          |
> The later header file has first generic DMA-related macros defined                              |
> (CSR addresses and flags) and then the channel-specific ones (CSR                               |
> addresses and flags). Since in case of the DW GMAC v3.x the                                     |
> multi-channels are implemented as a copy of all the DMA CSRs let's                              |
> preserve the logic of having all CSR address defined first, then the                            |
> CSR flags.                                                                                      |
>                                                                                                  |
>>   #define NUM_DWMAC100_DMA_REGS	9                                                       |
>>   #define NUM_DWMAC1000_DMA_REGS	23                                                      |
>>   #define NUM_DWMAC4_DMA_REGS	27                                                              |
>>                                                                                                |
>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr);                                    |
>> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);                          |
>>   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                    |
>>   			  u32 chan, bool rx, bool tx);                                          |
>>   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,                   |
>> @@ -169,4 +172,18 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,  |
>>   			struct stmmac_extra_stats *x, u32 chan, u32 dir);                       |
>>   int dwmac_dma_reset(void __iomem *ioaddr);                                                   |
>>                                                                                                |
>                                                                                                  |
>> +static inline u32 dma_chan_base_addr(u32 base, u32 chan)                                  \  |
>> +{                                                                                          | |
>> +	return base + chan * DMA_CHAN_OFFSET;                                                 | |
>> +}                                                                                          | |
>> +                                                                                           | |
>> +#define DMA_CHAN_XMT_POLL_DEMAND(chan)	dma_chan_base_addr(DMA_XMT_POLL_DEMAND, chan) | |
>> +#define DMA_CHAN_INTR_ENA(chan)		dma_chan_base_addr(DMA_INTR_ENA, chan)        | |
>> +#define DMA_CHAN_CONTROL(chan)		dma_chan_base_addr(DMA_CONTROL, chan)         | |
>> +#define DMA_CHAN_STATUS(chan)		dma_chan_base_addr(DMA_STATUS, chan)          |-+
>> +#define DMA_CHAN_BUS_MODE(chan)		dma_chan_base_addr(DMA_BUS_MODE, chan)        |
>> +#define DMA_CHAN_RCV_BASE_ADDR(chan)	dma_chan_base_addr(DMA_RCV_BASE_ADDR, chan)           |
>> +#define DMA_CHAN_TX_BASE_ADDR(chan)	dma_chan_base_addr(DMA_TX_BASE_ADDR, chan)            |
>> +#define DMA_CHAN_RX_WATCHDOG(chan)	dma_chan_base_addr(DMA_RX_WATCHDOG, chan)             |
>> +                                                                                           /
OK.
>>   #endif /* __DWMAC_DMA_H__ */
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> index 7907d62d3437..b37368137810 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> @@ -28,65 +28,65 @@ int dwmac_dma_reset(void __iomem *ioaddr)
>>   }
>>   
>>   /* CSR1 enables the transmit DMA to check for new descriptor */
>> -void dwmac_enable_dma_transmission(void __iomem *ioaddr)
>> +void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>   {
>> -	writel(1, ioaddr + DMA_XMT_POLL_DEMAND);
>> +	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>>   }
>>   
>>   void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			  u32 chan, bool rx, bool tx)
>>   {
>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>>   
>>   	if (rx)
>>   		value |= DMA_INTR_DEFAULT_RX;
>>   	if (tx)
>>   		value |= DMA_INTR_DEFAULT_TX;
>>   
>> -	writel(value, ioaddr + DMA_INTR_ENA);
>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>>   }
>>   
>>   void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			   u32 chan, bool rx, bool tx)
>>   {
>> -	u32 value = readl(ioaddr + DMA_INTR_ENA);
>> +	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
>>   
>>   	if (rx)
>>   		value &= ~DMA_INTR_DEFAULT_RX;
>>   	if (tx)
>>   		value &= ~DMA_INTR_DEFAULT_TX;
>>   
>> -	writel(value, ioaddr + DMA_INTR_ENA);
>> +	writel(value, ioaddr + DMA_CHAN_INTR_ENA(chan));
>>   }
>>   
>>   void dwmac_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			u32 chan)
>>   {
>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>   	value |= DMA_CONTROL_ST;
>> -	writel(value, ioaddr + DMA_CONTROL);
>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>   }
>>   
>>   void dwmac_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>>   {
>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>   	value &= ~DMA_CONTROL_ST;
>> -	writel(value, ioaddr + DMA_CONTROL);
>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>   }
>>   
>>   void dwmac_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			u32 chan)
>>   {
>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>   	value |= DMA_CONTROL_SR;
>> -	writel(value, ioaddr + DMA_CONTROL);
>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>   }
>>   
>>   void dwmac_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr, u32 chan)
>>   {
>> -	u32 value = readl(ioaddr + DMA_CONTROL);
>> +	u32 value = readl(ioaddr + DMA_CHAN_CONTROL(chan));
>>   	value &= ~DMA_CONTROL_SR;
>> -	writel(value, ioaddr + DMA_CONTROL);
>> +	writel(value, ioaddr + DMA_CHAN_CONTROL(chan));
>>   }
>>   
>>   #ifdef DWMAC_DMA_DEBUG
>> @@ -166,7 +166,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[chan];
>>   	int ret = 0;
>>   	/* read the status register (CSR5) */
>> -	u32 intr_status = readl(ioaddr + DMA_STATUS);
>> +	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
>>   
>>   #ifdef DWMAC_DMA_DEBUG
>>   	/* Enable it to monitor DMA rx/tx status in case of critical problems */
>> @@ -236,7 +236,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   		pr_warn("%s: unexpected status %08x\n", __func__, intr_status);
>>   
>>   	/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
>> -	writel((intr_status & 0x1ffff), ioaddr + DMA_STATUS);
>> +	writel((intr_status & 0x7ffff), ioaddr + DMA_CHAN_STATUS(chan));
> Isn't the mask change going to be implemented in the framework of the
> Loongson-specific DMA-interrupt handler in some of the further patches?
Yes!
>
> I'll get back to reviewing the series tomorrow (later today)...

OK, Thanks for your review!  I have read all your comments in others patch.


I will modify the code as soon as possible according to your comments,

but in the next two weeks (Spring Festival), I will not be able to test 
on all devices.


Thanks,

Yanteng

>
> -Serge(y)
>
>>   
>>   	return ret;
>>   }
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> index 7be04b54738b..b0db38396171 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> @@ -198,7 +198,7 @@ struct stmmac_dma_ops {
>>   	/* To track extra statistic (if supported) */
>>   	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>>   				  void __iomem *ioaddr);
>> -	void (*enable_dma_transmission) (void __iomem *ioaddr);
>> +	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
>>   	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>   			       u32 chan, bool rx, bool tx);
>>   	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index b334eb16da23..5617b40abbe4 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -2558,7 +2558,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>>   				       true, priv->mode, true, true,
>>   				       xdp_desc.len);
>>   
>> -		stmmac_enable_dma_transmission(priv, priv->ioaddr);
>> +		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>   
>>   		xsk_tx_metadata_to_compl(meta,
>>   					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
>> @@ -4706,7 +4706,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>   
>>   	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
>>   
>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>   
>>   	stmmac_flush_tx_descriptors(priv, queue);
>>   	stmmac_tx_timer_arm(priv, queue);
>> @@ -4926,7 +4926,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>>   		u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
>>   	}
>>   
>> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
>> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>>   
>>   	entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
>>   	tx_q->cur_tx = entry;
>> -- 
>> 2.31.4
>>


