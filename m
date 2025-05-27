Return-Path: <netdev+bounces-193635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED98AC4DC5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2316A2D5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0254A0A;
	Tue, 27 May 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtVR71YC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860719D07A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748346009; cv=none; b=dAl4w4c8BNElAERMv6+ygK1dYdW3LS3w7+PGu/2Fk1VVx4ymLjHhfX95xDPdQt1OQv3gzOnVzERAqEdZYwQ/7BL8oX7KsZ2aF7LUMqK+eILyFzDaV3wmnap0tmGiJOMagGraXlwA7QTKH2sW8ONjX4NaWx36I/Fow1UNrfJI3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748346009; c=relaxed/simple;
	bh=AZ7mIprUma2O1s4w4SEppk4MGgS2Zpa8dm827ytH4PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Goe/sKC80RZItzlFXDGfQ6V/vVJxnbWxVWO3IhFk6ebNCw9TyVNyyD9+OqXs7VjFxw5wB50iyvPtLce1ycOzrMsP1kc/Gkphx+fAD+foRLiU7OHDFDlx6z2zmC10GAFenw1xQ2CqDFUQvipf41qhgjVQ7TConmIgbzw1fFNI2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtVR71YC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748346005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT7cIrRybh6LbikgTpPxvFtoL3MIOWg7nn/7vwDh1rQ=;
	b=OtVR71YCJ6K7budDQT3TagF8Vv//JLOBkfiwX9rRUW4IqC23FvMz7bPPsIzhzyeXalxpve
	IT+ilAY/26lDSFPYXVaqtmK7jx802R8U8jO4cUMxpOlxlA0R0Cyfrg8CA0H9K2M5RIXW8/
	pLaVJbmGmGKxi2UU8lYTl6Zt6nKb5rY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-q6pugjN4PuuAbg_SsNuvSA-1; Tue, 27 May 2025 07:40:04 -0400
X-MC-Unique: q6pugjN4PuuAbg_SsNuvSA-1
X-Mimecast-MFC-AGG-ID: q6pugjN4PuuAbg_SsNuvSA_1748346003
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso1969646f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748346003; x=1748950803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT7cIrRybh6LbikgTpPxvFtoL3MIOWg7nn/7vwDh1rQ=;
        b=CKSg6eKOS+DgR9L0nT7nRs8O56oIcnoQ/QNt+RlJSt3MlYOlmzwW3fXLSK3cO8QNvQ
         oWR+3xOP8ATHsxQXrFFEbRrFoBdyc3f3/NgmdyODVQGZ8OBBadHyyMYnBPBIbzJRmYJS
         6s+ToayRoOLAkUijdb6TcYFxcxf4p0BPkFyJvLaFcfQ0XWteAv6AQNxNrOZkZt//Kgno
         rljpByqtq4wBdvO34YyA0iyxsB2CMaZ3/DPNrNFqdQqchneh66aTSwtzEjixTfMu1DXP
         DKthmj9Z6Y2f+Ux/BnpyiVa6CfIaqJh7BdMZGAinsAfT4Khn7iTLVc96eIw6AwkpkZri
         NAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUnRAeCb/YZk9dXReDA4k/IGyFK9UobOsbgVBCT8zDNVaVKY0egVfIl+vaP8ZR61MoT1Q5LPwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpLoDn+6gQkM3OvE1Qq+CONHI5NDdYirQL7KoJ3sw/Fs0Ph4I
	NDfO4tLW69H6HNWXDVY8jCxD7UzsidBpWrpJs6nfNK1PrTl/AmW/Zn9BofV1gjjYjWjC3ysMe7P
	qsxVo0RfuOM9KAqD5xMJIergfyViFzPnBwzlJHSf/FWzTBYoV117Gvh9Mog==
X-Gm-Gg: ASbGncsehqfF9qoy1xBUkNFDWQytrxYmMRd42RVeet6Gr8vOLhFu/XItr9F78KTNlv6
	BY38RJbmiEn0BBCr2CC+IHeW7FbAdZD2zt1banuGdFc/fJAGnt74tSP22vOfdMfOLAsEN95qWkQ
	0xX2Rl7TboELJqfIwVqgl3CTXwxtmjaP5dYCTgKTZVL14FKzIbthzbp+I73YY4Lxyy08g0ixae/
	yl86c0LOrGiBzUBPK9Le6mKQpTvYcvtaUdW8e4k+wZRY1eANJXCdT9nl5aYF1LRVBMqJF9fHRGh
	3Zgu3b0s8Lb8haQH7c4=
X-Received: by 2002:a5d:5f55:0:b0:3a4:e1ea:3b38 with SMTP id ffacd0b85a97d-3a4e5e5d241mr322136f8f.7.1748346003054;
        Tue, 27 May 2025 04:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELMhcsA2f/uFLjMPoJvuMHyXx64VnNfgsaZOJQOZLfdMdByqjQpxsJ0DHCecIbJFbX7bOLwg==
X-Received: by 2002:a5d:5f55:0:b0:3a4:e1ea:3b38 with SMTP id ffacd0b85a97d-3a4e5e5d241mr322102f8f.7.1748346002542;
        Tue, 27 May 2025 04:40:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4dc7e69c8sm4613797f8f.95.2025.05.27.04.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:40:02 -0700 (PDT)
Message-ID: <f738d1ed-7ade-4a37-b8fd-25178f7c1dee@redhat.com>
Date: Tue, 27 May 2025 13:39:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v12 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250522075455.1723560-1-lukma@denx.de>
 <20250522075455.1723560-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250522075455.1723560-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 9:54 AM, Lukasz Majewski wrote:
> +/* dynamicms MAC address table learn and migration */
> +static void
> +mtip_atable_dynamicms_learn_migration(struct switch_enet_private *fep,
> +				      int curr_time, unsigned char *mac,
> +				      u8 *rx_port)
> +{
> +	u8 port = MTIP_PORT_FORWARDING_INIT;
> +	struct mtip_port_info *port_info;
> +	u32 rx_mac_lo = 0, rx_mac_hi = 0;
> +	unsigned long flags;
> +	int index;
> +
> +	spin_lock_irqsave(&fep->learn_lock, flags);

AFAICS this is called by napi context and by a plain thread context,
spin_lock_bh() should be sufficient.

> +
> +	if (mac && is_valid_ether_addr(mac)) {
> +		rx_mac_lo = (u32)((mac[3] << 24) | (mac[2] << 16) |
> +				  (mac[1] << 8) | mac[0]);
> +		rx_mac_hi = (u32)((mac[5] << 8) | (mac[4]));
> +	}
> +
> +	port_info = mtip_portinfofifo_read(fep);
> +	while (port_info) {
> +		/* get block index from lookup table */
> +		index = GET_BLOCK_PTR(port_info->hash);
> +		mtip_update_atable_dynamic1(port_info->maclo, port_info->machi,
> +					    index, port_info->port,
> +					    curr_time, fep);
> +
> +		if (mac && is_valid_ether_addr(mac) &&
> +		    port == MTIP_PORT_FORWARDING_INIT) {
> +			if (rx_mac_lo == port_info->maclo &&
> +			    rx_mac_hi == port_info->machi) {
> +				/* The newly learned MAC is the source of
> +				 * our filtered frame.
> +				 */
> +				port = (u8)port_info->port;
> +			}
> +		}
> +		port_info = mtip_portinfofifo_read(fep);
> +	}
> +
> +	if (rx_port)
> +		*rx_port = port;
> +
> +	spin_unlock_irqrestore(&fep->learn_lock, flags);
> +}
> +
> +static void mtip_aging_timer(struct timer_list *t)
> +{
> +	struct switch_enet_private *fep = from_timer(fep, t, timer_aging);
> +
> +	fep->curr_time = mtip_timeincrement(fep->curr_time);
> +
> +	mod_timer(&fep->timer_aging,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +}

It's unclear to me why you need to maintain a timer just to update a
timestamp?!?

(jiffies >> msecs_to_jiffies(LEARNING_AGING_INTERVAL)) & ((1 <<
AT_DENTRY_TIMESTAMP_WIDTH) - 1)

should yield the same value (and possibly define a bitmask as a shortcut)

> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short	status;
> +	unsigned long flags;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);

AFAICS this lock is acquired only by napi and thread context the _bh
variant should be sufficient.

> +
> +	if (!fep->link[0] && !fep->link[1]) {
> +		/* Link is down or autonegotiation is in progress. */
> +		netif_stop_queue(dev);
> +		spin_unlock_irqrestore(&fep->hw_lock, flags);
> +		return NETDEV_TX_BUSY;

Intead you should probably stop the queue when such events happen

> +	}
> +
> +	/* Fill in a Tx ring entry */
> +	bdp = fep->cur_tx;
> +
> +	status = bdp->cbd_sc;
> +
> +	if (status & BD_ENET_TX_READY) {
> +		/* All transmit buffers are full. Bail out.
> +		 * This should not happen, since dev->tbusy should be set.
> +		 */
> +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n", dev->name);
> +		spin_unlock_irqrestore(&fep->hw_lock, flags);
> +		return NETDEV_TX_BUSY;

Instead you should use
netif_txq_maybe_stop()/netif_subqueue_maybe_stop() to stop the queue
eariler.

> +	}
> +
> +	/* Clear all of the status flags */
> +	status &= ~BD_ENET_TX_STATS;
> +
> +	/* Set buffer length and buffer pointer */
> +	bufaddr = skb->data;
> +	bdp->cbd_datlen = skb->len;
> +
> +	/* On some FEC implementations data must be aligned on
> +	 * 4-byte boundaries. Use bounce buffers to copy data
> +	 * and get it aligned.
> +	 */
> +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
> +		unsigned int index;
> +
> +		index = bdp - fep->tx_bd_base;
> +		memcpy(fep->tx_bounce[index],
> +		       (void *)skb->data, skb->len);
> +		bufaddr = fep->tx_bounce[index];
> +	}
> +
> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +		swap_buffer(bufaddr, skb->len);

Ouch, the above will kill performances. Also it looks like it will
access uninitialized memory if skb->len is not 4 bytes aligned.

> +
> +	/* Save skb pointer. */
> +	fep->tx_skbuff[fep->skb_cur] = skb;
> +
> +	dev->stats.tx_bytes += skb->len;

It looks like this start is incremented too early, as tx could still
fail later.

> +	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;
> +
> +	/* Push the data cache so the CPM does not get stale memory
> +	 * data.
> +	 */
> +	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
> +					  MTIP_SWITCH_TX_FRSIZE,
> +					  DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
> +		dev_err(&fep->pdev->dev,
> +			"Failed to map descriptor tx buffer\n");
> +		dev->stats.tx_errors++;
> +		dev->stats.tx_dropped++;
> +		dev_kfree_skb_any(skb);
> +		goto err;
> +	}
> +
> +	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
> +	 * it's the last BD of the frame, and to put the CRC on the end.
> +	 */
> +

Likely you need some memory barrier here to ensure the descriptor status
update is seen by the device after the buffer addr update.

> +	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
> +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
> +	bdp->cbd_sc = status;
> +
> +	netif_trans_update(dev);
> +	skb_tx_timestamp(skb);
> +
> +	/* For port separation - force sending via specified port */
> +	if (!fep->br_offload && port != 0)
> +		mtip_forced_forward(fep, port, 1);
> +
> +	/* Trigger transmission start */
> +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);

Possibly you should check skb->xmit_more to avoid ringing the doorbell
when not needed.

> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	dev->stats.tx_errors++;
> +
> +	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) {
> +		dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
> +		dev_info(&dev->dev,
> +			 "Ring data: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
> +			 (unsigned long)fep->cur_tx,
> +			 fep->tx_full ? " (full)" : "",
> +			 (unsigned long)fep->dirty_tx,
> +			 (unsigned long)fep->cur_rx);
> +
> +		bdp = fep->tx_bd_base;
> +		dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
> +		for (i = 0; i < TX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp, bdp->cbd_sc,
> +				 bdp->cbd_datlen, (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}
> +
> +		bdp = fep->rx_bd_base;
> +		dev_info(&dev->dev, " rx: %lu buffers\n",
> +			 (unsigned long)RX_RING_SIZE);
> +		for (i = 0 ; i < RX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp,
> +				 bdp->cbd_sc, bdp->cbd_datlen,
> +				 (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}
> +	}
> +
> +	rtnl_lock();

This is called in atomic scope, you can't acquire a mutex here. Instead
you could schedule a work and do the reset in such scope.

> +	if (netif_device_present(dev) || netif_running(dev)) {
> +		napi_disable(&fep->napi);
> +		netif_tx_lock_bh(dev);
> +		mtip_switch_restart(dev, fep->full_duplex[0],
> +				    fep->full_duplex[1]);
> +		netif_tx_wake_all_queues(dev);
> +		netif_tx_unlock_bh(dev);
> +		napi_enable(&fep->napi);
> +	}
> +	rtnl_unlock();
> +}

> +
> +/* During a receive, the cur_rx points to the current incoming buffer.
> + * When we update through the ring, if the next incoming buffer has
> + * not been given to the system, we just set the empty indicator,
> + * effectively tossing the packet.
> + */
> +static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	u8 *data, rx_port = MTIP_PORT_FORWARDING_INIT;
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status, pkt_len;
> +	struct net_device *pndev;
> +	struct ethhdr *eth_hdr;
> +	int pkt_received = 0;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	struct cbd_t *bdp;
> +
> +	spin_lock_irqsave(&fep->hw_lock, flags);
> +
> +	/* First, grab all of the stats for the incoming packet.
> +	 * These get messed up if we get called due to a busy condition.
> +	 */
> +	bdp = fep->cur_rx;
> +
> +	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
> +		if (pkt_received >= budget)
> +			break;
> +
> +		pkt_received++;
> +		/* Since we have allocated space to hold a complete frame,
> +		 * the last indicator should be set.
> +		 */
> +		if ((status & BD_ENET_RX_LAST) == 0)
> +			dev_warn_ratelimited(&dev->dev,
> +					     "SWITCH ENET: rcv is not +last\n");
> +
> +		if (!fep->usage_count)
> +			goto rx_processing_done;
> +
> +		/* Check for errors. */
> +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> +			      BD_ENET_RX_CR | BD_ENET_RX_OV)) {
> +			dev->stats.rx_errors++;
> +			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
> +				/* Frame too long or too short. */
> +				dev->stats.rx_length_errors++;
> +			}
> +			if (status & BD_ENET_RX_NO)	/* Frame alignment */
> +				dev->stats.rx_frame_errors++;
> +			if (status & BD_ENET_RX_CR)	/* CRC Error */
> +				dev->stats.rx_crc_errors++;
> +			if (status & BD_ENET_RX_OV)	/* FIFO overrun */
> +				dev->stats.rx_fifo_errors++;
> +		}
> +
> +		/* Report late collisions as a frame error.
> +		 * On this error, the BD is closed, but we don't know what we
> +		 * have in the buffer.  So, just drop this frame on the floor.
> +		 */
> +		if (status & BD_ENET_RX_CL) {
> +			dev->stats.rx_errors++;
> +			dev->stats.rx_frame_errors++;
> +			goto rx_processing_done;
> +		}
> +
> +		/* Process the incoming frame */
> +		pkt_len = bdp->cbd_datlen;
> +		data = (__u8 *)__va(bdp->cbd_bufaddr);
> +
> +		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> +				 bdp->cbd_datlen, DMA_FROM_DEVICE);

I have read your explaination WRT unmap/map. Actually you don't need to
do any mapping here, since you are unconditionally copying the whole
buffer (why???) and re-using it.

Still you need a dma_sync_single() to ensure the CPUs see the correct data.

> +
> +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +			swap_buffer(data, pkt_len);
> +
> +		if (data) {
> +			eth_hdr = (struct ethhdr *)data;
> +			mtip_atable_get_entry_port_number(fep,
> +							  eth_hdr->h_source,
> +							  &rx_port);
> +			if (rx_port == MTIP_PORT_FORWARDING_INIT)
> +				mtip_atable_dynamicms_learn_migration(fep,
> +								      fep->curr_time,
> +								      eth_hdr->h_source,
> +								      &rx_port);
> +		}
> +
> +		if (!fep->br_offload && (rx_port == 1 || rx_port == 2))
> +			pndev = fep->ndev[rx_port - 1];
> +		else
> +			pndev = dev;
> +
> +		*port = rx_port;
> +		pndev->stats.rx_packets++;
> +		pndev->stats.rx_bytes += pkt_len;

It looks like the stats are incremented too early, as the packets could
still be dropped a few lines later

> +
> +		/* This does 16 byte alignment, exactly what we need.
> +		 * The packet length includes FCS, but we don't want to
> +		 * include that when passing upstream as it messes up
> +		 * bridging applications.
> +		 */
> +		skb = netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
> +		if (unlikely(!skb)) {
> +			dev_dbg(&fep->pdev->dev,
> +				"%s: Memory squeeze, dropping packet.\n",
> +				pndev->name);
> +			pndev->stats.rx_dropped++;
> +			goto err_mem;
> +		} else {
> +			skb_reserve(skb, NET_IP_ALIGN);
> +			skb_put(skb, pkt_len);      /* Make room */
> +			skb_copy_to_linear_data(skb, data, pkt_len);
> +			skb->protocol = eth_type_trans(skb, pndev);
> +			napi_gro_receive(&fep->napi, skb);
> +		}
> +
> +		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, data,
> +						  bdp->cbd_datlen,
> +						  DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> +					       bdp->cbd_bufaddr))) {
> +			dev_err(&fep->pdev->dev,
> +				"Failed to map descriptor rx buffer\n");
> +			pndev->stats.rx_errors++;
> +			pndev->stats.rx_dropped++;
> +			dev_kfree_skb_any(skb);

The above statement is wrong even if you intend to keep the
dma_unmap/dma_map pair (and please, don't do that! ;). At this point the
skb ownership has been handed to the stack by the previous
napi_gro_receive(), freeing it here will cause UaF and double free.

> +			goto err_mem;
> +		}
> +
> + rx_processing_done:
> +		/* Clear the status flags for this buffer */
> +		status &= ~BD_ENET_RX_STATS;

With the dma map/unmap in place, you likely need a memory barrier to
ensure the device will see the descriptor status update after bufferptr
update.

> +static int mtip_alloc_buffers(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	bdp = fep->rx_bd_base;
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		skb = netdev_alloc_skb(dev, MTIP_SWITCH_RX_FRSIZE);
> +		if (!skb)
> +			goto err;
> +
> +		fep->rx_skbuff[i] = skb;
> +
> +		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
> +						  MTIP_SWITCH_RX_FRSIZE,
> +						  DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> +					       bdp->cbd_bufaddr))) {
> +			dev_err(&fep->pdev->dev,
> +				"Failed to map descriptor rx buffer\n");
> +			dev_kfree_skb_any(skb);

At this point fep->rx_skbuff[i] is still not NULL, and later
mtip_free_buffers() will try to free it again. You should remove the
above dev_kfree_skb_any(skb).

> +static const struct ethtool_ops mtip_ethtool_ops = {
> +	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
> +	.get_drvinfo            = mtip_get_drvinfo,
> +	.get_link               = ethtool_op_get_link,
> +	.get_ts_info		= ethtool_op_get_ts_info,
> +};
> +
> +static const struct net_device_ops mtip_netdev_ops = {
> +	.ndo_open		= mtip_open,
> +	.ndo_stop		= mtip_close,
> +	.ndo_start_xmit	= mtip_start_xmit,
> +	.ndo_set_rx_mode	= mtip_set_multicast_list,
> +	.ndo_tx_timeout	= mtip_timeout,
> +	.ndo_set_mac_address	= mtip_set_mac_address,
> +};
> +
> +bool mtip_is_switch_netdev_port(const struct net_device *ndev)
> +{
> +	return ndev->netdev_ops == &mtip_netdev_ops;
> +}
> +
> +static int mtip_switch_dma_init(struct switch_enet_private *fep)
> +{
> +	struct cbd_t *bdp, *cbd_base;
> +	int ret, i;
> +
> +	/* Check mask of the streaming and coherent API */
> +	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_err(&fep->pdev->dev, "No suitable DMA available\n");
> +		return ret;
> +	}
> +
> +	/* Allocate memory for buffer descriptors */
> +	cbd_base = dma_alloc_coherent(&fep->pdev->dev, PAGE_SIZE, &fep->bd_dma,
> +				      GFP_KERNEL);
> +	if (!cbd_base)
> +		return -ENOMEM;
> +
> +	/* Set receive and transmit descriptor base */
> +	fep->rx_bd_base = cbd_base;
> +	fep->tx_bd_base = cbd_base + RX_RING_SIZE;
> +
> +	/* Initialize the receive buffer descriptors */
> +	bdp = fep->rx_bd_base;
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		bdp->cbd_sc = 0;
> +		bdp++;
> +	}
> +
> +	/* Set the last buffer to wrap */
> +	bdp--;
> +	bdp->cbd_sc |= BD_SC_WRAP;

This is a recurring pattern, you should use an helper for it.

> +/* FEC MII MMFR bits definition */
> +#define FEC_MMFR_ST             BIT(30)
> +#define FEC_MMFR_OP_READ        BIT(29)
> +#define FEC_MMFR_OP_WRITE       BIT(28)
> +#define FEC_MMFR_PA(v)          (((v) & 0x1F) << 23)
> +#define FEC_MMFR_RA(v)          (((v) & 0x1F) << 18)

Here and elsewhere it looks like you could use FIELD_PREP and friends

This patch is really too big, I'm pretty sure I missed some relevant
issues. You should split it in multiple ones: i.e. initialization and
h/w access, rx/tx, others ndos.

/P


