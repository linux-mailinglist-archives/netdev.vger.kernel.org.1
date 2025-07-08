Return-Path: <netdev+bounces-204910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29AAFC790
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B976421D0A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F07267AF6;
	Tue,  8 Jul 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCIIW5hR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED021FF51
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968336; cv=none; b=pQKdcTZ+aOKAxG4f1bRgsuF4kn2wac0BxmdbiRK47d0fMqTU+rHf53WKNqk8OFVFbNsOhRy7GTFlP5cSRGtCu8IiNqMkTnY7QU9JV23c59hdAuY1EQCx6deFkS8PzM9npmaSGqMjP0NXncy/bhXEKrEXXCe55CbvwH3rMtjq2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968336; c=relaxed/simple;
	bh=/0Y1Y7OTqONCmx1m/8TUQikKpKzMmzQI4UbNLHxksNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFIs4G0HB6K4iM5U4GKEjZXWZpWSKLnYpygo6X0mLMZZl6VAK77ztzPMyrJrDQkI2ZgjlwGqPfLdAoXWA/Y3pImRs8fj9mVpa0/AKtj1Re/tCOQR5hjUQM4eR2PzARXZ8Vk9Irgb1N9qsiyc93L/KLyHCAoeseadaLWcbSJ3prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCIIW5hR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751968332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X5BK60lt8yHW2mcPT6pFw1X0evw7hr2NRoNEBvx6z8=;
	b=FCIIW5hRlKDl0aaxY2Cv4PSpWMxf2T0AB1LjFG9bVejd68fIHNeUQo7422OTdF1vwFDo7W
	iOeErN4c71i/Sq+tNapUhzMJfy6P7232G2RjP33K9vH8t8D0w+CD+rlj44feKhYhEnY/fZ
	26qvTgEljZWmMHGIjfQ6TdlQWNd3rLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-i99sjp_VNEigxilN47epcA-1; Tue, 08 Jul 2025 05:52:11 -0400
X-MC-Unique: i99sjp_VNEigxilN47epcA-1
X-Mimecast-MFC-AGG-ID: i99sjp_VNEigxilN47epcA_1751968330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4530c186394so16027815e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 02:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968330; x=1752573130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2X5BK60lt8yHW2mcPT6pFw1X0evw7hr2NRoNEBvx6z8=;
        b=fYYC1pPg+aRpO2jV8OeYKxeHMaAIdnaPCTp0p30i8iMnRwo3AIOZanRA68q7C2Ccft
         5wkpGas/ApfMLttVBmomC/gDNIB9uuevpfOVZpDPyFxWPFSL3py9lBjaxIuTH1xdo+yQ
         QdNb44CmVj/4zapV6wNhVzqB0tR7Y6D91GnyqIjDrakskTJhlsPm7BesN58DqG4Vipu4
         lRJ5uhKiXbQEIP8IsPjz+qMCDahmEcRob2iJmO36r9sHL6cbCKOIEALESrHuu92iF2kl
         X8D/ezClhY6RTfi22XYDZtM5qd2cCequVBD/rblfI6GkJGioit8aSGNMbucuOWTWFL/6
         tpkw==
X-Forwarded-Encrypted: i=1; AJvYcCU2IYpF9vW/aNF2AmDLY609vpfG4ZzRpbvYcQDK/8psNJsrcyKeY81PpvpN6cQaJsvGMUYxuc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3F+FH+ckPP+Cf7T3EQqaeY242lozm502I2CJPK0ukKv90MAH
	413n0JYg5sjq8NLO4noSzMoyykXy/g5XFbXfZf+iZdfJaLEKjFnstTBbNGh01SZ5HhNOROad7Wb
	CD/dc+v0lil700cocKJptzm++hrANUoWPLQsG6KiQGnOOQCx/Rp+6T0qiqA==
X-Gm-Gg: ASbGncsoSNJfu3PmtRdS2IGMVgsLhhCatkX5pGkEtH2KpUYzGQjV00WiqSq13td9uxX
	Iz1m++dg4sopl+six5r8i84tmY8JBDJhYLn3xuqX6evsbNRauxpC3EZqF3S2N9zZw+vEkpMkDkt
	cxZgYmnM36Yfok95+9BoJa0hQdCM9FJgLolRfri5k7/BMCJUSpVlQq15WtmMEUjPiiSWeHaYCMK
	2WkBV3FBp2aN2RkRszT0hQ9QQUGBzjvupALZZvsOaklwITOdcYDMpXvP40u/F+hPhlEoncANY1T
	GRkF4o8SMFi0AFERcowUi+ZYVYMOsOMhqmNqCTtbc3xEz7t7i56c7bmqICZEO+/KKbkNTg==
X-Received: by 2002:a05:600c:190c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-454c6531885mr70789345e9.9.1751968329694;
        Tue, 08 Jul 2025 02:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMDOBH0qBMZ6iN2OTX9dqvc0LhZZ2FR75EoU2J03ehS7fOg9IG4eoFaiP/Vpy/EZIcQItAhw==
X-Received: by 2002:a05:600c:190c:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-454c6531885mr70788875e9.9.1751968329162;
        Tue, 08 Jul 2025 02:52:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd45957fsm16437885e9.17.2025.07.08.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:52:08 -0700 (PDT)
Message-ID: <d51a84c7-d534-44cc-88bc-73db8721e50e@redhat.com>
Date: Tue, 8 Jul 2025 11:52:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 07/12] net: mtip: Add mtip_switch_{rx|tx} functions
 to the L2 switch driver
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
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-8-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-8-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 63afdf2beea6..b5a82748b39b 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -228,6 +228,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
>  	return info;
>  }
>  
> +static void mtip_atable_get_entry_port_number(struct switch_enet_private *fep,
> +					      unsigned char *mac_addr, u8 *port)
> +{
> +	int block_index, block_index_end, entry;
> +	u32 mac_addr_lo, mac_addr_hi;
> +	u32 read_lo, read_hi;
> +
> +	mac_addr_lo = (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
> +			    (mac_addr[1] << 8) | mac_addr[0]);
> +	mac_addr_hi = (u32)((mac_addr[5] << 8) | (mac_addr[4]));
> +
> +	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
> +	block_index_end = block_index + ATABLE_ENTRY_PER_SLOT;
> +
> +	/* now search all the entries in the selected block */
> +	for (entry = block_index; entry < block_index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
> +		*port = MTIP_PORT_FORWARDING_INIT;
> +
> +		if (read_lo == mac_addr_lo &&
> +		    ((read_hi & 0x0000FFFF) ==
> +		     (mac_addr_hi & 0x0000FFFF))) {
> +			/* found the correct address */
> +			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
> +				*port = FIELD_GET(AT_PORT_MASK, read_hi);
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
> +		mac_addr, *port);
> +}
> +
>  /* Clear complete MAC Look Up Table */
>  void mtip_clear_atable(struct switch_enet_private *fep)
>  {
> @@ -825,11 +858,217 @@ static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
>  
>  static void mtip_switch_tx(struct net_device *dev)
>  {
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +
> +	spin_lock(&fep->hw_lock);
> +	bdp = fep->dirty_tx;
> +
> +	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
> +		if (bdp == fep->cur_tx && fep->tx_full == 0)
> +			break;
> +
> +		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> +				 MTIP_SWITCH_TX_FRSIZE, DMA_TO_DEVICE);
> +		bdp->cbd_bufaddr = 0;
> +		skb = fep->tx_skbuff[fep->skb_dirty];
> +		/* Check for errors */
> +		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> +				   BD_ENET_TX_RL | BD_ENET_TX_UN |
> +				   BD_ENET_TX_CSL)) {
> +			dev->stats.tx_errors++;
> +			if (status & BD_ENET_TX_HB)  /* No heartbeat */
> +				dev->stats.tx_heartbeat_errors++;
> +			if (status & BD_ENET_TX_LC)  /* Late collision */
> +				dev->stats.tx_window_errors++;
> +			if (status & BD_ENET_TX_RL)  /* Retrans limit */
> +				dev->stats.tx_aborted_errors++;
> +			if (status & BD_ENET_TX_UN)  /* Underrun */
> +				dev->stats.tx_fifo_errors++;
> +			if (status & BD_ENET_TX_CSL) /* Carrier lost */
> +				dev->stats.tx_carrier_errors++;
> +		} else {
> +			dev->stats.tx_packets++;
> +		}
> +
> +		if (status & BD_ENET_TX_READY)
> +			dev_err(&fep->pdev->dev,
> +				"Enet xmit interrupt and TX_READY.\n");
> +
> +		/* Deferred means some collisions occurred during transmit,
> +		 * but we eventually sent the packet OK.
> +		 */
> +		if (status & BD_ENET_TX_DEF)
> +			dev->stats.collisions++;
> +
> +		/* Free the sk buffer associated with this last transmit */
> +		dev_consume_skb_irq(skb);
> +		fep->tx_skbuff[fep->skb_dirty] = NULL;
> +		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;
> +
> +		/* Update pointer to next buffer descriptor to be transmitted */
> +		if (status & BD_ENET_TX_WRAP)
> +			bdp = fep->tx_bd_base;
> +		else
> +			bdp++;
> +
> +		/* Since we have freed up a buffer, the ring is no longer
> +		 * full.
> +		 */
> +		if (fep->tx_full) {
> +			fep->tx_full = 0;
> +			if (netif_queue_stopped(dev))
> +				netif_wake_queue(dev);
> +		}
> +	}
> +	fep->dirty_tx = bdp;
> +	spin_unlock(&fep->hw_lock);
>  }
>  
> +/* During a receive, the cur_rx points to the current incoming buffer.
> + * When we update through the ring, if the next incoming buffer has
> + * not been given to the system, we just set the empty indicator,
> + * effectively tossing the packet.
> + */
>  static int mtip_switch_rx(struct net_device *dev, int budget, int *port)
>  {
> -	return -ENOMEM;
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	u8 *data, rx_port = MTIP_PORT_FORWARDING_INIT;
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status, pkt_len;
> +	struct net_device *pndev;
> +	struct ethhdr *eth_hdr;
> +	int pkt_received = 0;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +	struct page *page;
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
> +
> +		if (!fep->usage_count)
> +			goto rx_processing_done;
> +
> +		status ^= BD_ENET_RX_LAST;
> +		/* Check for errors. */
> +		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
> +			      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
> +			      BD_ENET_RX_CL)) {
> +			dev->stats.rx_errors++;
> +			if (status & BD_ENET_RX_OV) {
> +				/* FIFO overrun */
> +				dev->stats.rx_fifo_errors++;
> +				goto rx_processing_done;
> +			}
> +			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
> +				      | BD_ENET_RX_LAST)) {
> +				/* Frame too long or too short. */
> +				dev->stats.rx_length_errors++;
> +				if (status & BD_ENET_RX_LAST)
> +					netdev_err(dev, "rcv is not +last\n");
> +			}
> +			if (status & BD_ENET_RX_CR)	/* CRC Error */
> +				dev->stats.rx_crc_errors++;
> +
> +			/* Report late collisions as a frame error. */
> +			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
> +				dev->stats.rx_frame_errors++;
> +			goto rx_processing_done;
> +		}
> +
> +		/* Get correct RX page */
> +		page = fep->page[bdp - fep->rx_bd_base];
> +		/* Process the incoming frame */
> +		pkt_len = bdp->cbd_datlen;
> +		data = (__u8 *)__va(bdp->cbd_bufaddr);
> +
> +		dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
> +					pkt_len, DMA_FROM_DEVICE);
> +		net_prefetch(page_address(page));

Both `__va(bdp->cbd_bufaddr)` and `page_address(page)` should point to
the same same memory. Please use constantly one _or_ the other  - likely
page_address(page) is the best option.

> +
> +		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +			swap_buffer(data, pkt_len);
> +
> +		if (data) {

The above check is not needed. If data is null swap_buffer will still
unconditionally dereference it.

Also it looks like it can't be NULL.

/P


