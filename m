Return-Path: <netdev+bounces-250460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB61D2D3F2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCCC630737A4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBA2D94B4;
	Fri, 16 Jan 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="fsxFwow/"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2642C158D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548613; cv=none; b=L6sSbXcWLT4FjMc2eU07yY8rzerlrIocorjeEAQoJFUdnppl7viczFmfQt/+ZxSOEiaMDP2XqXc3i/uDHvBLj+gbMS+i+J7hgGcHht5t6AWJi4FUPxFcQXw2/8PjoTFbgOmrH/42iO8PTAeJgNWZ16cHKlwNhjW9ueMbC8OcAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548613; c=relaxed/simple;
	bh=O9AD6dejuN3H7Qcztavj3uUt/Napd/KAyHiclubWADI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAMVtJCG7FkyeyMYIfr387jcT07dR+nIAFZIRrlyYPdjeUlTwzW0hyRGpTD0e9VKe92Y4/9KgLkQW2g/dQhn6fwW0lk08a2UCZXT0qanPTn5SzPkG/HI+AiW+wDR1NGIQmWWeA/ojYiRDrC1DCR4YPBaUylGgLd04M+GtUG91O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=fsxFwow/; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768548598; x=2632462198;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O9AD6dejuN3H7Qcztavj3uUt/Napd/KAyHiclubWADI=;
	b=fsxFwow/LGaP6vQ97RASC6QUuVtCdkEdVCoMnetjyH3pDAnK0/X/cDLba+611OUO
	TzMnV5tlNZVhVmyfRUHi9CkV6XMRKbeFz7JddBxF0LDbB/gCodwGk3oF7OTDsHyh
	Ibo3lud4rZAdTGBAo/28dD8hPnx9XJr+RS4RTSwOqB4=;
X-AuditID: 0a0901b2-dfddb70000001406-9d-6969e8f6acc1
Received: from mailgw03.horizon.ai ( [10.9.15.211])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id 6F.4B.05126.6F8E9696; Fri, 16 Jan 2026 15:29:58 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 robotics002.hobot.cc (10.9.15.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 16 Jan 2026 15:29:57 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <linux@armlinux.org.uk>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>,
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tao03.wang@horizon.auto>
Subject: Re: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after resume
Date: Fri, 16 Jan 2026 15:29:45 +0800
Message-ID: <20260116072945.125661-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
References: <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To robotics002.hobot.cc
 (10.9.15.211)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42Lh4uS/rPvtRWamwdHXxhY/X05jtFj+YAer
	xZzzLSwWj/pPsFlc2NbHarGwbQmLxeVdc9gsDk3dy2jx8vU2ZotjC8Qsvp1+w+jA7XH52kVm
	j3lrqj22rLzJ5PG0fyu7x6ZVnWweO3d8ZvJ4v+8qm8fnTXIBHFFcNimpOZllqUX6dglcGX1r
	ggt6AiuuT5rL1MDY5tTFyMkhIWAi0bHuPjOILSSwklHi3X6tLkYuIPsto8S61qdMIAk2AQ2J
	u1OvsXQxcnCICEhLHJujAVLDLHCfSeLY0d2MIDXCAmESl0/8YAOpYRFQlTi+TxUkzCtgK/Hi
	3yxWiF3yEtenHAAr5xQwlbj5ayfUXhOJ/rWdzBD1ghInZz5hAbGZgeqbt85mhrAlJA6+eAFV
	ryLRfHI+O8RMOYnXG/azQdixEqsbnrJNYBSahWTULCSjZiEZtYCReRWjcG5iZk56uYGxXkZ+
	UWZVfp5eYuYmRnA8MW7awbhkwUe9Q4xMHIyHGCU4mJVEeHl/p2UK8aYkVlalFuXHF5XmpBYf
	YpTmYFES59VWjMsUEkhPLEnNTk0tSC2CyTJxcEo1MGm5dp54Ny2zdwZ/4OOSc+dWt67Tn7b/
	ttpDrkztnn/Oa/f/uuXwTuvvTPFmhwPCatYrV7JFf19juN30qJLtHq0HvxU3W65q/2p5Qjaw
	IyBm5UKJb69n+jKvPOzBfbT1wlT1+ut3RBIsNOP/Bh5RXJnN9fyz44zj+fe55xy07n10M1ss
	+a5JzL+VhpN2CK/j/vglr2f91HvztHqXpvgvdHo6O/ntvJcf7tveF79sPuGV/5eNldkvNecp
	a9c07rz3OdJ5TwSb4Y15W/Oi9JZffVL6OGYXD2Maw/YbxWaH2N6e3dt8/ZPkpK7kH182teUe
	3z6dQz60OzLpmCMzxzV50bQP98VUH2/4VynmWHWost9NiaU4I9FQi7moOBEA9RTv7RYDAAA=

> > > While I agree with the change for stmmac_tso_xmit(), please explain why
> > > the change in stmmac_free_tx_buffer() is necessary.
> > >
> > > It seems to me that if this is missing in stmmac_free_tx_buffer(), the
> > > driver should have more problems than just TSO.
> > 
> > The change in stmmac_free_tx_buffer() is intended to be generic for all
> > users of last_segment, not only for the TSO path.
> 
> However, transmit is a hotpath, so work needs to be minimised for good
> performance. We don't want anything that is unnecessary in these paths.
> 
> If we always explicitly set .last_segment when adding any packet to the
> ring, then there is absolutely no need to also do so when freeing them.
> 
> Also, I think there's a similar issue with .is_jumbo.
> 
> So, I think it would make more sense to have some helpers for setting
> up the tx_skbuff_dma entry. Maybe something like the below? I'll see
> if I can measure the performance impact of this later today, but I
> can't guarantee I'll get to that.
> 
> The idea here is to ensure that all members with the exception of
> xsk_meta are fully initialised when an entry is populated.
> 
> I haven't removed anything in the tx_q->tx_skbuff_dma entry release
> path yet, but with this in place, we should be able to eliminate the
> clearance of these in stmmac_tx_clean() and stmmac_free_tx_buffer().
> 
> Note that the driver assumes setting .buf to zero means the entry is
> cleared. dma_addr_t is a cookie which is device specific, and zero
> may be a valid DMA cookie. Only DMA_MAPPING_ERROR is invalid, and
> can be assumed to hold any meaning in driver code. So that needs
> fixing as well.
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a8a78fe7d01f..0e605d0f6a94 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1874,6 +1874,34 @@ static int init_dma_rx_desc_rings(struct net_device *dev,
>  	return ret;
>  }
>  
> +static void stmmac_set_tx_dma_entry(struct stmmac_tx_queue *tx_q,
> +				    unsigned int entry,
> +				    enum stmmac_txbuf_type type,
> +				    dma_addr_t addr, size_t len,
> +				    bool map_as_page)
> +{
> +	tx_q->tx_skbuff_dma[entry].buf = addr;
> +	tx_q->tx_skbuff_dma[entry].len = len;
> +	tx_q->tx_skbuff_dma[entry].buf_type = type;
> +	tx_q->tx_skbuff_dma[entry].map_as_page = map_as_page;
> +	tx_q->tx_skbuff_dma[entry].last_segment = false;
> +	tx_q->tx_skbuff_dma[entry].is_jumbo = false;
> +}
> +
> +static void stmmac_set_tx_skb_dma_entry(struct stmmac_tx_queue *tx_q,
> +					unsigned int entry, dma_addr_t addr,
> +					size_t len, bool map_as_page)
> +{
> +	stmmac_set_tx_dma_entry(tx_q, entry, STMMAC_TXBUF_T_SKB, addr, len,
> +				map_as_page);
> +}
> +
> +static void stmmac_set_tx_dma_last_segment(struct stmmac_tx_queue *tx_q,
> +					   unsigned int entry)
> +{
> +	tx_q->tx_skbuff_dma[entry].last_segment = true;
> +}
> +
>  /**
>   * __init_dma_tx_desc_rings - init the TX descriptor ring (per queue)
>   * @priv: driver private structure
> @@ -1919,11 +1947,8 @@ static int __init_dma_tx_desc_rings(struct stmmac_priv *priv,
>  			p = tx_q->dma_tx + i;
>  
>  		stmmac_clear_desc(priv, p);
> +		stmmac_set_tx_skb_dma_entry(tx_q, i, 0, 0, false);
>  
> -		tx_q->tx_skbuff_dma[i].buf = 0;
> -		tx_q->tx_skbuff_dma[i].map_as_page = false;
> -		tx_q->tx_skbuff_dma[i].len = 0;
> -		tx_q->tx_skbuff_dma[i].last_segment = false;
>  		tx_q->tx_skbuff[i] = NULL;
>  	}
>  
> @@ -2649,19 +2674,15 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
>  		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
>  
> -		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
> -
>  		/* To return XDP buffer to XSK pool, we simple call
>  		 * xsk_tx_completed(), so we don't need to fill up
>  		 * 'buf' and 'xdpf'.
>  		 */
> -		tx_q->tx_skbuff_dma[entry].buf = 0;
> -		tx_q->xdpf[entry] = NULL;
> +		stmmac_set_tx_dma_entry(tx_q, entry, STMMAC_TXBUF_T_XSK_TX,
> +					0, xdp_desc.len, false);
> +		stmmac_set_tx_dma_last_segment(tx_q, entry);
>  
> -		tx_q->tx_skbuff_dma[entry].map_as_page = false;
> -		tx_q->tx_skbuff_dma[entry].len = xdp_desc.len;
> -		tx_q->tx_skbuff_dma[entry].last_segment = true;
> -		tx_q->tx_skbuff_dma[entry].is_jumbo = false;
> +		tx_q->xdpf[entry] = NULL;
>  
>  		stmmac_set_desc_addr(priv, tx_desc, dma_addr);
>  
> @@ -2836,6 +2857,9 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
>  			tx_q->tx_skbuff_dma[entry].map_as_page = false;
>  		}
>  
> +		/* This looks at tx_q->tx_skbuff_dma[tx_q->dirty_tx].is_jumbo
> +		 * and tx_q->tx_skbuff_dma[tx_q->dirty_tx].last_segment
> +		 */
>  		stmmac_clean_desc3(priv, tx_q, p);
>  
>  		tx_q->tx_skbuff_dma[entry].last_segment = false;
> @@ -4494,10 +4518,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 * this DMA buffer right after the DMA engine completely finishes the
>  	 * full buffer transmission.
>  	 */
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> +	stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des, skb_headlen(skb),
> +				    false);
>  
>  	/* Prepare fragments */
>  	for (i = 0; i < nfrags; i++) {
> @@ -4512,17 +4534,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		stmmac_tso_allocator(priv, des, skb_frag_size(frag),
>  				     (i == nfrags - 1), queue);
>  
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_frag_size(frag);
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = true;
> -		tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
> +		stmmac_set_tx_skb_dma_entry(tx_q, tx_q->cur_tx, des,
> +					    skb_frag_size(frag), true);
>  	}
>  
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].last_segment = true;
> +	stmmac_set_tx_dma_last_segment(tx_q, tx_q->cur_tx);
>  
>  	/* Only the last descriptor gets to point to the skb. */
>  	tx_q->tx_skbuff[tx_q->cur_tx] = skb;
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
>  
>  	/* Manage tx mitigation */
>  	tx_packets = (tx_q->cur_tx + 1) - first_tx;
> @@ -4774,23 +4793,18 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		if (dma_mapping_error(priv->device, des))
>  			goto dma_map_err; /* should reuse desc w/o issues */
>  
> -		tx_q->tx_skbuff_dma[entry].buf = des;
> -
> +		stmmac_set_tx_skb_dma_entry(tx_q, entry, des, len, true);
>  		stmmac_set_desc_addr(priv, desc, des);
>  
> -		tx_q->tx_skbuff_dma[entry].map_as_page = true;
> -		tx_q->tx_skbuff_dma[entry].len = len;
> -		tx_q->tx_skbuff_dma[entry].last_segment = last_segment;
> -		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
> -
>  		/* Prepare the descriptor and set the own bit too */
>  		stmmac_prepare_tx_desc(priv, desc, 0, len, csum_insertion,
>  				priv->mode, 1, last_segment, skb->len);
>  	}
>  
> +	stmmac_set_tx_dma_last_segment(tx_q, entry);
> +
>  	/* Only the last descriptor gets to point to the skb. */
>  	tx_q->tx_skbuff[entry] = skb;
> -	tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
>  
>  	/* According to the coalesce parameter the IC bit for the latest
>  	 * segment is reset and the timer re-started to clean the tx status.
> @@ -4869,14 +4883,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		if (dma_mapping_error(priv->device, des))
>  			goto dma_map_err;
>  
> -		tx_q->tx_skbuff_dma[first_entry].buf = des;
> -		tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
> -		tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
> +		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, des, nopaged_len,
> +					    false);
>  
>  		stmmac_set_desc_addr(priv, first, des);
>  
> -		tx_q->tx_skbuff_dma[first_entry].len = nopaged_len;
> -		tx_q->tx_skbuff_dma[first_entry].last_segment = last_segment;
> +		if (last_segment)
> +			stmmac_set_tx_dma_last_segment(tx_q, first_entry);
>  
>  		if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  			     priv->hwts_tx_en)) {
> @@ -5064,6 +5077,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
>  	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
>  	unsigned int entry = tx_q->cur_tx;
> +	enum stmmac_txbuf_type buf_type;
>  	struct dma_desc *tx_desc;
>  	dma_addr_t dma_addr;
>  	bool set_ic;
> @@ -5091,7 +5105,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		if (dma_mapping_error(priv->device, dma_addr))
>  			return STMMAC_XDP_CONSUMED;
>  
> -		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_NDO;
> +		buf_type = STMMAC_TXBUF_T_XDP_NDO;
>  	} else {
>  		struct page *page = virt_to_page(xdpf->data);
>  
> @@ -5100,14 +5114,12 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		dma_sync_single_for_device(priv->device, dma_addr,
>  					   xdpf->len, DMA_BIDIRECTIONAL);
>  
> -		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XDP_TX;
> +		buf_type = STMMAC_TXBUF_T_XDP_TX;
>  	}
>  
> -	tx_q->tx_skbuff_dma[entry].buf = dma_addr;
> -	tx_q->tx_skbuff_dma[entry].map_as_page = false;
> -	tx_q->tx_skbuff_dma[entry].len = xdpf->len;
> -	tx_q->tx_skbuff_dma[entry].last_segment = true;
> -	tx_q->tx_skbuff_dma[entry].is_jumbo = false;
> +	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
> +				false);
> +	stmmac_set_tx_dma_last_segment(tx_q, entry);
>  
>  	tx_q->xdpf[entry] = xdpf;

Since the changes are relatively large, I suggest splitting them into 
a separate optimization patch.As I cannot validate the is_jumbo scenario, 
I have dropped the changes to stmmac_free_tx_buffer.I will submit a 
separate patch focusing only on fixing the TSO case.

