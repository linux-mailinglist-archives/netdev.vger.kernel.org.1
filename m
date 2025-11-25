Return-Path: <netdev+bounces-241602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 789CCC866C3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600094E2B4A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0643329C4D;
	Tue, 25 Nov 2025 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LMS3VTbW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB0279918
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093853; cv=none; b=FLho2JXZu00tyzY+KbMBXiNhzKel0ezFjO84DyJNmg1m6WDkcXmULpAngCqiF5qHjqcveGOeMJ+pr66Xr/uS6KK6C7s/2bGKa+OEnHJm4hqudvLF5C05/J++Mmx1qxa4GgiHPcVoG2UqxbZUVkGQhrRe7aYQytbOPvXnoAHhiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093853; c=relaxed/simple;
	bh=MAN1Je7TPaDMLRdBr0droWaKityTEcsy8RZZnZZc6no=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NvCvdPAoRSGoDGmKQxxFGci9fup7njHNJUVyFSkICrxrOkJ5q99Dp9XkEWbWEM3fu1k4y4T8S2xM9sz8LksEkHN6rOlHU7d92RdaeRv+mOm+VwuYGGDPtGAfGtPG3M/fMFuXi+yXoa29iWmk72FFpfqtYG0vMzVFI4wJNUvPnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LMS3VTbW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D6F61A1D40;
	Tue, 25 Nov 2025 18:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDDBE606A1;
	Tue, 25 Nov 2025 18:04:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDE09102F08A7;
	Tue, 25 Nov 2025 19:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764093846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dBBoz5z3l2BX+xX1UKTnTROr59ODxTu+uvr5PipWPkQ=;
	b=LMS3VTbWslcD43lTwSyPemQzLhiEJ/0B+aQ8RYT7v2Eg7rvTdwgwlR7Eamh6nmajlk7sz+
	W5gs66uK1UxLbzLD9igYvxLWBDQI9xC4Qg1ADUmJMKTWXVIlAkoybmFmF3bGLQmuvoH3/z
	KZPDgsRup1QcH0cCxnIJFeMPB4jTgRpayW6yT9Ygoj6DVvGTT10Ek/hqcA+eQZkFq4SqZb
	Dm4SIhvTH+wJbADNJMPGT/vPza7LPFZU8qcFdSOj1Cex94lkJ9808RJ5g2WlkGiFrXMIgk
	2Fxi7WGo06gvCq/VP14pI1WDdjNvBIRuS71jygVDaAuqezW/2GLfBXChQWr44A==
Message-ID: <bd6b9659-8721-43d0-be60-12af0342b500@bootlin.com>
Date: Tue, 25 Nov 2025 19:03:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on
 Rx Buffer Unavailable
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
 <58ec46bb-5850-4dde-a1ea-d242f7d95409@bootlin.com>
Content-Language: en-US
In-Reply-To: <58ec46bb-5850-4dde-a1ea-d242f7d95409@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 25/11/2025 18:15, Maxime Chevallier wrote:
> Hi Rohan,
> 
> On 25/11/2025 17:37, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> In Store and Forward mode, flushing frames when the receive buffer is
>> unavailable, can cause the MTL Rx FIFO to go out of sync. This results
>> in buffering of a few frames in the FIFO without triggering Rx DMA
>> from transferring the data to the system memory until another packet
>> is received. Once the issue happens, for a ping request, the packet is
>> forwarded to the system memory only after we receive another packet
>> and hece we observe a latency equivalent to the ping interval.
>>
>> 64 bytes from 192.168.2.100: seq=1 ttl=64 time=1000.344 ms
>>
>> Also, we can observe constant gmacgrp_debug register value of
>> 0x00000120, which indicates "Reading frame data".
>>
>> The issue is not reproducible after disabling frame flushing when Rx
>> buffer is unavailable. But in that case, the Rx DMA enters a suspend
>> state due to buffer unavailability. To resume operation, software
>> must write to the receive_poll_demand register after adding new
>> descriptors, which reactivates the Rx DMA.
>>
>> This issue is observed in the socfpga platforms which has dwmac1000 IP
>> like Arria 10, Cyclone V and Agilex 7. Issue is reproducible after
>> running iperf3 server at the DUT for UDP lower packet sizes.
>>
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> 
> Should this be a fix ?
> 
> Can you elaborate on how to reproduce this ? I've given this a try on
> CycloneV and I can't see any difference in the ping results and iperf3
> results.
> 
> From the DUT, I've tried :
>  - iperf3 -c 192.168.X.X -u -b 0 -l 64
>  - iperf3 -c 192.168.X.X -u -b 0 -l 64 -R

Ah ! my iperf3 peer wasn't sending packets hard enough. I switched to a
more powerful LP and I can now see the huge latencies by doing :

1 - ping the CycloneV from test machine :

PING 192.168.2.41 (192.168.2.41) 56(84) bytes of data.
64 bytes from 192.168.2.41: icmp_seq=1 ttl=64 time=0.387 ms
64 bytes from 192.168.2.41: icmp_seq=2 ttl=64 time=0.196 ms
64 bytes from 192.168.2.41: icmp_seq=3 ttl=64 time=0.193 ms
64 bytes from 192.168.2.41: icmp_seq=4 ttl=64 time=0.207 ms

2 - on cycloneV, Run iperf3 -c 192.168.X.X -u -b 0 -l 64 -R

3 - Re-ping :

PING 192.168.2.41 (192.168.2.41) 56(84) bytes of data.
64 bytes from 192.168.2.41: icmp_seq=1 ttl=64 time=1022 ms
64 bytes from 192.168.2.41: icmp_seq=2 ttl=64 time=1024 ms
64 bytes from 192.168.2.41: icmp_seq=3 ttl=64 time=1024 ms


This behaviour disapears after your patch :)

Maxime


>  - iperf3 -c 192.168.X.X
>  - iperf3 -c 192.168.X.X -R
> 
> I'm reading the same results with and without the patch
> 
> I've done ping tests as well, the latency seems to be the same with and
> without this patch, at around 0.193ms RTT.
> 
> I'm not familiar with the SF_DMA_MODE though, any thing special to do to
> enter that mode ?
> 
> Thanks,
> 
> Maxime
> 
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 5 +++--
>>  drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     | 1 +
>>  drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     | 5 +++++
>>  drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +++
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 2 ++
>>  5 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> index 6d9b8fac3c6d0fd76733ab4a1a8cce2420fa40b4..5877fec9f6c30ed18cdcf5398816e444e0bd0091 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
>> @@ -135,10 +135,10 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>>  
>>  	if (mode == SF_DMA_MODE) {
>>  		pr_debug("GMAC: enable RX store and forward mode\n");
>> -		csr6 |= DMA_CONTROL_RSF;
>> +		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
>>  	} else {
>>  		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
>> -		csr6 &= ~DMA_CONTROL_RSF;
>> +		csr6 &= ~(DMA_CONTROL_RSF | DMA_CONTROL_DFF);
>>  		csr6 &= DMA_CONTROL_TC_RX_MASK;
>>  		if (mode <= 32)
>>  			csr6 |= DMA_CONTROL_RTC_32;
>> @@ -262,6 +262,7 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
>>  	.dma_rx_mode = dwmac1000_dma_operation_mode_rx,
>>  	.dma_tx_mode = dwmac1000_dma_operation_mode_tx,
>>  	.enable_dma_transmission = dwmac_enable_dma_transmission,
>> +	.enable_dma_reception = dwmac_enable_dma_reception,
>>  	.enable_dma_irq = dwmac_enable_dma_irq,
>>  	.disable_dma_irq = dwmac_disable_dma_irq,
>>  	.start_tx = dwmac_dma_start_tx,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> index d1c149f7a3dd9e472b237101666e11878707f0f2..054ecb20ce3f68bce5da3efaf36acf33e430d3f0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
>> @@ -169,6 +169,7 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
>>  #define NUM_DWMAC4_DMA_REGS	27
>>  
>>  void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
>> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan);
>>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>  			  u32 chan, bool rx, bool tx);
>>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> index 467f1a05747ecf0be5b9f3392cd3d2049d676c21..97a803d68e3a2f120beaa7c3254748cf404236df 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
>> @@ -33,6 +33,11 @@ void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>>  	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>>  }
>>  
>> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan)
>> +{
>> +	writel(1, ioaddr + DMA_CHAN_RCV_POLL_DEMAND(chan));
>> +}
>> +
>>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>>  			  u32 chan, bool rx, bool tx)
>>  {
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> index f257ce4b6c66e0bbd3180d54ac7f5be934153a6b..df6e8a567b1f646f83effbb38d8e53441a6f6150 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
>> @@ -201,6 +201,7 @@ struct stmmac_dma_ops {
>>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>>  				  void __iomem *ioaddr);
>>  	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
>> +	void (*enable_dma_reception)(void __iomem *ioaddr, u32 chan);
>>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>>  			       u32 chan, bool rx, bool tx);
>>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>> @@ -261,6 +262,8 @@ struct stmmac_dma_ops {
>>  	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>>  #define stmmac_enable_dma_transmission(__priv, __args...) \
>>  	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
>> +#define stmmac_enable_dma_reception(__priv, __args...) \
>> +	stmmac_do_void_callback(__priv, dma, enable_dma_reception, __args)
>>  #define stmmac_enable_dma_irq(__priv, __args...) \
>>  	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>>  #define stmmac_disable_dma_irq(__priv, __args...) \
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 6cacedb2c9b3fefdd4c9ec8ba98d389443d21ebd..1ecca60baf74286da7f156b4c3c835b3cbabf1ba 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -4973,6 +4973,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>>  	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
>>  			    (rx_q->dirty_rx * sizeof(struct dma_desc));
>>  	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
>> +	/* Wake up Rx DMA from the suspend state if required */
>> +	stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
>>  }
>>  
>>  static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>>
>> ---
>> base-commit: e3daf0e7fe9758613bec324fd606ed9caa187f74
>> change-id: 20251125-a10_ext_fix-5951805b9906
>>
>> Best regards,
> 
> 


