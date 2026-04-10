Return-Path: <netdev+bounces-277216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOtSBExn2Gm1cwgAu9opvQ
	(envelope-from <netdev+bounces-277216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:58:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D53D19EE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96A83037D57
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CEF305968;
	Fri, 10 Apr 2026 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI3jfIKD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298220B22;
	Fri, 10 Apr 2026 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789846; cv=none; b=ouJ2rFvE5XZ5GaKLPZOz70kpG54y3Nt/qOb1IUn1zuSxKs/G9BPf6udnR1/Ro8mrMF4k9JZS5P7OlDeE/K3Cw4PU9eEVhjwGENUCnyUAYT5PYFVYAFis+ZtvQ7fHzwNTai41yx49s0uKLkbQFW+4lidg7Fv+xuVvKwOKiadUYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789846; c=relaxed/simple;
	bh=QSwNSRAsPxDs4+Uk0whRkMxmap3dgGjpyVtmoF7NINc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnup69py6bkZDa+W2iYkFoJHtknNMsQvs3v1edebs8SJfygP1GK3B0G87nqu+CuPD7pZfrKqVoq1EJ4RCz4WFYXfGE5D3Mb9dFLAgG3bV0vys7t164PmZfl9t6fGSuTecseldRgXeAPvgjHDZIiZ1gfnsnS9yhpgjj0j+/nf+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI3jfIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FF3C4CEF7;
	Fri, 10 Apr 2026 02:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775789846;
	bh=QSwNSRAsPxDs4+Uk0whRkMxmap3dgGjpyVtmoF7NINc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mI3jfIKDLxLym5e90Jr1ymfcypJwDHOSvRMgLLmuq6uO4mCz9iWL2DqQXi4f2CAHP
	 mvug8asu/+LDRr0ErsIbCHdz7bW9ptRsQtL/iDqLWdUZgnwXBOWUHadiG9s3hyL5zP
	 LsU2DR7iDU/Z72o1f8E8NA6wQscO1x2CY9VSZbnWxObA7kQZORg5P9aIuENnJlJu58
	 1gvuxgH/AZN6MKcQOatAEeM9aF5hDuwyU6df+IwPBAXLvanrCJ80RtaFCH3Zpt+Vbb
	 u8lBNfDXtXJgr+TLkOJYUgxp9NRjEvFDrkwNozFADZ/UNFR2teG+yO6WLUDLSInWmg
	 EJEtvx95+MFQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 09/12] net: airoha: Support multiple net_devices for a single FE GDM port
Date: Thu,  9 Apr 2026 19:57:24 -0700
Message-ID: <20260410025724.1810007-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-9-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-9-ab6ea49d59ff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-277216-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E8D53D19EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "For your consideration."
---
net: airoha: Support multiple net_devices for a single FE GDM port

This commit introduces support for mapping multiple net_device interfaces
to a single Frame Engine (FE) GDM port via an external hardware arbiter.
It updates the rx/tx paths, port allocation, and registration logic to
handle the new net_device array.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
[ ... ]
> @@ -615,9 +617,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
>  		struct page *page = virt_to_head_page(e->buf);
>  		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
> -		struct airoha_gdm_port *port;
> -		struct net_device *netdev;
> -		int data_len, len, p;
> +		struct airoha_gdm_dev *dev;
> +		int data_len, len;
>  
>  		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
>  			break;

While looking at this code, I noticed an issue that predates this patch.
Can the lack of a memory barrier after checking the descriptor ownership bit
cause stale reads?

The driver checks QDMA_DESC_DONE_MASK to verify that the hardware has finished
writing the descriptor. However, it reads desc->msg1 before this check and
without a dma_rmb():

		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
		struct page *page = virt_to_head_page(e->buf);
		u32 desc_ctrl = le32_to_cpu(desc->ctrl);

		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
			break;

Since weakly ordered architectures can reorder memory reads, could the CPU
prefetch msg1 before the DMA engine writes the new descriptor values, leading
to routing the packet to the wrong gdm_dev?

[ ... ]
> @@ -1764,9 +1765,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
>  	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
>  
> -	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
> -	nbq = port->id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
> -	src_port = eth->soc->ops.get_src_port_id(port, nbq);
> +	src_port = eth->soc->ops.get_src_port_id(port, dev->nbq);
>  	if (src_port < 0)
>  		return src_port;

Can configuring the loopback for one device break connectivity for other
devices sharing the same port?

When multiple net_devices (like PCIE0 and PCIE1 on GDM3) open and call
airoha_set_gdm2_loopback(), they modify global hardware registers such as
REG_FE_WAN_PORT.

Since WAN0_MASK is unconditionally updated to track the current device's
src_port:

	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
		      FIELD_PREP(WAN0_MASK, src_port));

won't the last configured device clobber the hardware state for the others?

[ ... ]
> @@ -1987,7 +1986,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>  	}
>  
>  	fport = airoha_get_fe_port(dev);
> -	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> +	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
> +	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
>  	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
>  
>  	q = &qdma->q_tx[qid];

Does sharing the hardware QDMA TX queues among multiple net_device instances
introduce a permanent transmit stall?

In airoha_dev_xmit(), if a shared hardware queue is full, the driver stops the
netdev_queue of the specific netdev making the call:

	if (q->queued + nr_frags >= q->ndesc) {
		/* not enough space in the queue */
		netif_tx_stop_queue(txq);
		spin_unlock_bh(&q->lock);
		return NETDEV_TX_BUSY;
	}

However, the TX completion handler (airoha_tx_irq_process()) only wakes the
queue of the netdev attached to the completed packet. If an interface's TX
queue is stopped but it has no pending packets in the hardware queue (because
another interface filled it), will it ever get woken up?

[ ... ]
> @@ -2955,11 +2958,25 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
>  			 netdev->dev_addr);
>  	}
>  
> +	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
> +	 * and PCIE1 respectively.
> +	 */
> +	index = nbq;
> +	if (index && airoha_is_7581(eth) && port->id == AIROHA_GDM3_IDX)
> +		index -= 4;
> +
> +	if (index >= ARRAY_SIZE(port->devs) || port->devs[index]) {
> +		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
> +		return -EINVAL;
> +	}
> +
> +	netdev->dev.of_node = of_node_get(np);
>  	dev = netdev_priv(netdev);

Does this code leak the of_node reference?

The node reference is explicitly incremented via of_node_get(np). The networking
core does not automatically drop explicit of_node references on free_netdev().
Without a matching of_node_put() in the error paths or the driver's teardown
function (airoha_remove()), will this reference permanently leak when the device
is destroyed?

[ ... ]
> @@ -3003,7 +3021,43 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  	if (err)
>  		return err;
>  
> -	return airoha_alloc_gdm_device(eth, port, np);
> +	for_each_child_of_node(np, node) {
> +		/* Multiple external serdes connected to the FE GDM port via an
> +		 * external arbiter.
> +		 */
> +		const __be32 *nbq_ptr;
> +		int nbq;
> +
> +		if (!of_device_is_compatible(node, "airoha,eth-port"))
> +			continue;
> +
> +		d++;
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		nbq_ptr = of_get_property(node, "reg", NULL);
> +		if (!nbq_ptr) {
> +			dev_err(eth->dev, "missing nbq id\n");
> +			of_node_put(node);
> +			return -EINVAL;
> +		}
> +
> +		/* Verify the provided nbq parameter is valid */
> +		nbq = be32_to_cpup(nbq_ptr);
> +		err = eth->soc->ops.get_src_port_id(port, nbq);
> +		if (err < 0) {
> +			of_node_put(node);
> +			return err;
> +		}
> +
> +		err = airoha_alloc_gdm_device(eth, port, nbq, node);
> +		if (err) {
> +			of_node_put(node);
> +			return err;
> +		}
> +	}
> +
> +	return !d ? airoha_alloc_gdm_device(eth, port, 0, np) : 0;
>  }

Does passing 0 for nbq in the fallback path break older device trees on the
EN7581 SoC?

Later, when the interface is brought up, airoha_set_gdm2_loopback() calls
airoha_en7581_get_src_port_id(), which returns -EINVAL for GDM3 if nbq is
not 4 or 5:

	switch (port->id) {
	case AIROHA_GDM3_IDX:
		/* 7581 SoC supports PCIe serdes on GDM3 port */
		if (nbq == 4)
			return HSGMII_LAN_7581_PCIE0_SRCPORT;
		if (nbq == 5)
			return HSGMII_LAN_7581_PCIE1_SRCPORT;
		break;

If nbq is hardcoded to 0 for legacy DTs, won't this cause interface
initialization to fail unconditionally for GDM3?

