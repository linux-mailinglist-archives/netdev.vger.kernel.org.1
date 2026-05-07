Return-Path: <netdev+bounces-285506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOuOEQgD/WmIWgAAu9opvQ
	(envelope-from <netdev+bounces-285506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1704EF3C2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C841030719E3
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3261342C93;
	Thu,  7 May 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo1MGcEm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051F30E837;
	Thu,  7 May 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188963; cv=none; b=Y0wqT+SSf12Cr5eWVw8aw5sw124sBeYVWcDLhw+mX6x7vL7rrpzGoa/aZ06moYBWP+y90AIpCsR6xI4ME2njPjgJ4FQ94gQJgK8qAyww+r4XX7S1Q56n8nL4QWp6c9XSozde/uNFonJVlsq9qUNEbevbQU0INHdh023uCet8dZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188963; c=relaxed/simple;
	bh=4t8IE8nDrzhdZFlTocOZOHtjcWAwuwXSrSA4BZbw3sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9sdpG88kBor4dyFcfa+9QwDyWC1N0RJenJm/laZVkhhcFaS2Q1eKuoZ/3yF/TLQ5wuGuwCP2rnn6FMEpSobWEMAlfxoQSatBmPIaBVcMQ1nN3TppUIj52pRhG7MF1onps33lJpypShfG7kANS/raMaet9zvk7mDRrd0DJFs734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo1MGcEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA6C2BCB8;
	Thu,  7 May 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188963;
	bh=4t8IE8nDrzhdZFlTocOZOHtjcWAwuwXSrSA4BZbw3sA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xo1MGcEmZKbmxinfniS/DrYlI7nP2dE8XR9UWQq+AX5O/75pLFzaLOjBzf8Vk6+z0
	 PJpfYUaKCNbJN4VWOl8qkpPkqHkBnjmflkbxI10ZmF5wwAVX9B2hddTR6KYWPHJgq0
	 PMXnAznRtXUtBZBfo1xhHpR/GhA9OwV6ciJVtiT1EkoUHQ6m1lmUgMvmldddFRtTrg
	 WOatddiM7gETh7L7OmibVdk4XyVMmatUX0v13mEw2L/4DPb/H+H+leNmKXmmhTrxSf
	 A2vvvW7m61+ZmDucLe+oAt95qInfbOnV1WU3N7sMz6CZagdbnvCCJZPiOcKLjJg77I
	 xTTlhkz4nK6xQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 May 2026 23:21:50 +0200
Subject: [PATCH net-next v4 07/10] net: airoha: Support multiple
 net_devices for a single FE GDM port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-airoha-eth-multi-serdes-v4-7-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: BA1704EF3C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285506-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
manages the traffic in a TDM manner. As a result multiple net_devices can
connect to the same GDM{3,4} port and there is a theoretical "1:n"
relation between GDM ports and net_devices.

           ┌─────────────────────────────────┐
           │                                 │    ┌──────┐
           │                         P1 GDM1 ├────►MT7530│
           │                                 │    └──────┘
           │                                 │      ETH0 (DSA conduit)
           │                                 │
           │              PSE/FE             │
           │                                 │
           │                                 │
           │                                 │    ┌─────┐
           │                         P0 CDM1 ├────►QDMA0│
           │  P4                     P9 GDM4 │    └─────┘
           └──┬─────────────────────────┬────┘
              │                         │
           ┌──▼──┐                 ┌────▼────┐
           │ PPE │                 │   ARB   │
           └─────┘                 └─┬─────┬─┘
                                     │     │
                                  ┌──▼──┐┌─▼───┐
                                  │ ETH ││ USB │
                                  └─────┘└─────┘
                                   ETH1   ETH2

Introduce support for multiple net_devices connected to the same Frame
Engine (FE) GDM port (GDM3 or GDM4) via an external hw arbiter.
Please note GDM1 or GDM2 does not support the connection with the external
arbiter.
Add get_dev_from_sport callback since EN7581 and AN7583 have different
logics for the net_device type connected to GDM3 or GDM4.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 271 ++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |  10 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  13 +-
 3 files changed, 229 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 786bc677af3c..0253919714e0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -106,7 +106,7 @@ static int airoha_set_vip_for_gdm_port(struct airoha_gdm_dev *dev, bool enable)
 	struct airoha_eth *eth = dev->eth;
 	u32 vip_port;
 
-	vip_port = eth->soc->ops.get_vip_port(port, port->nbq);
+	vip_port = eth->soc->ops.get_vip_port(port, dev->nbq);
 	if (enable) {
 		airoha_fe_set(eth, REG_FE_VIP_PORT_EN, vip_port);
 		airoha_fe_set(eth, REG_FE_IFC_PORT_EN, vip_port);
@@ -565,24 +565,26 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 	return nframes;
 }
 
-static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
-				    struct airoha_qdma_desc *desc)
+static struct airoha_gdm_dev *
+airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 {
-	u32 port, sport, msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+	struct airoha_gdm_port *port;
+	u16 p, d;
 
-	sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK, msg1);
-	switch (sport) {
-	case 0x10 ... 0x14:
-		port = 0;
-		break;
-	case 0x2 ... 0x4:
-		port = sport - 1;
-		break;
-	default:
-		return -EINVAL;
-	}
+	if (eth->soc->ops.get_dev_from_sport(desc, &p, &d))
+		return ERR_PTR(-ENODEV);
 
-	return port >= ARRAY_SIZE(eth->ports) ? -EINVAL : port;
+	if (p >= ARRAY_SIZE(eth->ports))
+		return ERR_PTR(-ENODEV);
+
+	port = eth->ports[p];
+	if (!port)
+		return ERR_PTR(-ENODEV);
+
+	if (d >= ARRAY_SIZE(port->devs))
+		return ERR_PTR(-ENODEV);
+
+	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
@@ -597,9 +599,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		u32 hash, reason, msg1, desc_ctrl;
-		struct airoha_gdm_port *port;
-		struct net_device *netdev;
-		int data_len, len, p;
+		struct airoha_gdm_dev *dev;
+		int data_len, len;
 		struct page *page;
 
 		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
@@ -621,12 +622,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!len || data_len < len)
 			goto free_frag;
 
-		p = airoha_qdma_get_gdm_port(eth, desc);
-		if (p < 0 || !eth->ports[p])
+		dev = airoha_qdma_get_gdm_dev(eth, desc);
+		if (IS_ERR(dev))
 			goto free_frag;
 
-		port = eth->ports[p];
-		netdev = port->dev->dev;
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf, q->buf_size);
 			if (!q->skb)
@@ -634,8 +633,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
+			q->skb->dev = dev->dev;
+			q->skb->protocol = eth_type_trans(q->skb, dev->dev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
@@ -653,7 +652,9 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
 			continue;
 
-		if (netdev_uses_dsa(netdev)) {
+		if (netdev_uses_dsa(dev->dev)) {
+			struct airoha_gdm_port *port = dev->port;
+
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
@@ -847,22 +848,27 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
-		int j;
+		int d;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev->qdma != qdma)
-			continue;
+		for (d = 0; d < ARRAY_SIZE(port->devs); d++) {
+			struct airoha_gdm_dev *dev = port->devs[d];
+			int j;
 
-		dev = port->dev;
-		for (j = 0; j < dev->dev->num_tx_queues; j++) {
-			if (airoha_qdma_get_txq(qdma, j) != qid)
+			if (!dev)
 				continue;
 
-			netif_wake_subqueue(dev->dev, j);
+			if (dev->qdma != qdma)
+				continue;
+
+			for (j = 0; j < dev->dev->num_tx_queues; j++) {
+				if (airoha_qdma_get_txq(qdma, j) != qid)
+					continue;
+
+				netif_wake_subqueue(dev->dev, j);
+			}
 		}
 	}
 	q->txq_stopped = false;
@@ -1823,7 +1829,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	src_port = eth->soc->ops.get_sport(port, port->nbq);
+	src_port = eth->soc->ops.get_sport(port, dev->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -1840,7 +1846,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
 
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
-		u32 mask = FC_ID_OF_SRC_PORT_MASK(port->nbq);
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(dev->nbq);
 
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
 			      __field_prep(mask, AIROHA_GDM2_IDX));
@@ -2044,7 +2050,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	}
 
 	fport = airoha_get_fe_port(dev);
-	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
+	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
 	q = &qdma->q_tx[qid];
@@ -2961,12 +2968,15 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
 
 		if (!port)
 			continue;
 
-		if (port->dev == dev)
-			return true;
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			if (port->devs[j] == dev)
+				return true;
+		}
 	}
 
 	return false;
@@ -2974,10 +2984,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
 static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 				   struct airoha_gdm_port *port,
-				   struct device_node *np)
+				   int nbq, struct device_node *np)
 {
-	struct airoha_gdm_dev *dev;
 	struct net_device *netdev;
+	struct airoha_gdm_dev *dev;
+	u8 index;
 	int err;
 
 	netdev = devm_alloc_etherdev_mqs(eth->dev, sizeof(*dev),
@@ -2997,7 +3008,6 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 			      NETIF_F_HW_TC;
 	netdev->features |= netdev->hw_features;
 	netdev->vlan_features = netdev->hw_features;
-	netdev->dev.of_node = np;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
@@ -3015,11 +3025,25 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 			 netdev->dev_addr);
 	}
 
+	/* Allowed nbq for EN7581 on GDM3 port are 4 and 5 for PCIE0
+	 * and PCIE1 respectively.
+	 */
+	index = nbq;
+	if (index && airoha_is_7581(eth) && port->id == AIROHA_GDM3_IDX)
+		index -= 4;
+
+	if (index >= ARRAY_SIZE(port->devs) || port->devs[index]) {
+		dev_err(eth->dev, "invalid nbq id: %d\n", nbq);
+		return -EINVAL;
+	}
+
+	netdev->dev.of_node = of_node_get(np);
 	dev = netdev_priv(netdev);
 	dev->dev = netdev;
 	dev->port = port;
-	port->dev = dev;
 	dev->eth = eth;
+	dev->nbq = nbq;
+	port->devs[index] = dev;
 
 	return 0;
 }
@@ -3029,7 +3053,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
-	int err, p;
+	struct device_node *node;
+	int err, nbq, p, d = 0;
 	u32 id;
 
 	if (!id_ptr) {
@@ -3057,15 +3082,51 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	u64_stats_init(&port->stats.syncp);
 	spin_lock_init(&port->stats.lock);
 	port->id = id;
-	/* XXX: Read nbq from DTS */
-	port->nbq = id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
 	eth->ports[p] = port;
 
 	err = airoha_metadata_dst_alloc(port);
 	if (err)
 		return err;
 
-	return airoha_alloc_gdm_device(eth, port, np);
+	/* Default nbq value to ensure backward compatibility */
+	nbq = id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
+
+	for_each_child_of_node(np, node) {
+		/* Multiple external serdes connected to the FE GDM port via an
+		 * external arbiter.
+		 */
+		const __be32 *nbq_ptr;
+
+		if (!of_device_is_compatible(node, "airoha,eth-port"))
+			continue;
+
+		d++;
+		if (!of_device_is_available(node))
+			continue;
+
+		nbq_ptr = of_get_property(node, "reg", NULL);
+		if (!nbq_ptr) {
+			dev_err(eth->dev, "missing nbq id\n");
+			of_node_put(node);
+			return -EINVAL;
+		}
+
+		/* Verify the provided nbq parameter is valid */
+		nbq = be32_to_cpup(nbq_ptr);
+		err = eth->soc->ops.get_sport(port, nbq);
+		if (err < 0) {
+			of_node_put(node);
+			return err;
+		}
+
+		err = airoha_alloc_gdm_device(eth, port, nbq, node);
+		if (err) {
+			of_node_put(node);
+			return err;
+		}
+	}
+
+	return !d ? airoha_alloc_gdm_device(eth, port, nbq, np) : 0;
 }
 
 static int airoha_register_gdm_devices(struct airoha_eth *eth)
@@ -3074,14 +3135,22 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		int err;
+		int j;
 
 		if (!port)
 			continue;
 
-		err = register_netdev(port->dev->dev);
-		if (err)
-			return err;
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			int err;
+
+			if (!dev)
+				continue;
+
+			err = register_netdev(dev->dev);
+			if (err)
+				return err;
+		}
 	}
 
 	set_bit(DEV_STATE_REGISTERED, &eth->state);
@@ -3188,14 +3257,23 @@ static int airoha_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
+		int j;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev && dev->dev->reg_state == NETREG_REGISTERED)
-			unregister_netdev(dev->dev);
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!dev)
+				continue;
+
+			netdev = dev->dev;
+			of_node_put(netdev->dev.of_node);
+			if (netdev->reg_state == NETREG_REGISTERED)
+				unregister_netdev(netdev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3216,14 +3294,22 @@ static void airoha_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
+		int j;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev)
-			unregister_netdev(dev->dev);
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!dev)
+				continue;
+
+			netdev = dev->dev;
+			of_node_put(netdev->dev.of_node);
+			unregister_netdev(netdev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3286,6 +3372,39 @@ static u32 airoha_en7581_get_vip_port(struct airoha_gdm_port *port, int nbq)
 	return 0;
 }
 
+static int airoha_en7581_get_dev_from_sport(struct airoha_qdma_desc *desc,
+					    u16 *port, u16 *dev)
+{
+	u32 sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK,
+			      le32_to_cpu(READ_ONCE(desc->msg1)));
+
+	*dev = 0;
+	switch (sport) {
+	case 0x10 ... 0x14:
+		*port = 0; /* GDM1 */
+		break;
+	case 0x2 ... 0x4:
+		*port = sport - 1;
+		break;
+	case HSGMII_LAN_7581_PCIE1_SRCPORT:
+		*dev = 1;
+		fallthrough;
+	case HSGMII_LAN_7581_PCIE0_SRCPORT:
+		*port = 2; /* GDM3 */
+		break;
+	case HSGMII_LAN_7581_USB_SRCPORT:
+		*dev = 1;
+		fallthrough;
+	case HSGMII_LAN_7581_ETH_SRCPORT:
+		*port = 3; /* GDM4 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const char * const an7583_xsi_rsts_names[] = {
 	"xsi-mac",
 	"hsi0-mac",
@@ -3335,6 +3454,36 @@ static u32 airoha_an7583_get_vip_port(struct airoha_gdm_port *port, int nbq)
 	return 0;
 }
 
+static int airoha_an7583_get_dev_from_sport(struct airoha_qdma_desc *desc,
+					    u16 *port, u16 *dev)
+{
+	u32 sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK,
+			      le32_to_cpu(READ_ONCE(desc->msg1)));
+
+	*dev = 0;
+	switch (sport) {
+	case 0x10 ... 0x14:
+		*port = 0; /* GDM1 */
+		break;
+	case 0x2 ... 0x4:
+		*port = sport - 1;
+		break;
+	case HSGMII_LAN_7583_ETH_SRCPORT:
+		*port = 2; /* GDM3 */
+		break;
+	case HSGMII_LAN_7583_USB_SRCPORT:
+		*dev = 1;
+		fallthrough;
+	case HSGMII_LAN_7583_PCIE_SRCPORT:
+		*port = 3; /* GDM4 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct airoha_eth_soc_data en7581_soc_data = {
 	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
@@ -3343,6 +3492,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.ops = {
 		.get_sport = airoha_en7581_get_sport,
 		.get_vip_port = airoha_en7581_get_vip_port,
+		.get_dev_from_sport = airoha_en7581_get_dev_from_sport,
 	},
 };
 
@@ -3354,6 +3504,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.ops = {
 		.get_sport = airoha_an7583_get_sport,
 		.get_vip_port = airoha_an7583_get_vip_port,
+		.get_dev_from_sport = airoha_an7583_get_dev_from_sport,
 	},
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 3e93919a175c..207c75152fde 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -17,6 +17,7 @@
 #include <net/dsa.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
+#define AIROHA_MAX_NUM_GDM_DEVS		2
 #define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
@@ -542,14 +543,15 @@ struct airoha_qdma {
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
-	struct net_device *dev;
 	struct airoha_eth *eth;
+	struct net_device *dev;
+
+	int nbq;
 };
 
 struct airoha_gdm_port {
-	struct airoha_gdm_dev *dev;
+	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
 	int id;
-	int nbq;
 
 	struct airoha_hw_stats stats;
 
@@ -585,6 +587,8 @@ struct airoha_eth_soc_data {
 	struct {
 		int (*get_sport)(struct airoha_gdm_port *port, int nbq);
 		u32 (*get_vip_port)(struct airoha_gdm_port *port, int nbq);
+		int (*get_dev_from_sport)(struct airoha_qdma_desc *desc,
+					  u16 *port, u16 *dev);
 	} ops;
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 047141b2d6d8..c4086d29d984 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -169,6 +169,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 
 		for (p = 0; p < ARRAY_SIZE(eth->ports); p++) {
 			struct airoha_gdm_port *port = eth->ports[p];
+			int j;
 
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
 				      FP0_EGRESS_MTU_MASK |
@@ -180,8 +181,16 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port->dev, i,
-						airoha_get_fe_port(port->dev));
+			for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+				struct airoha_gdm_dev *dev = port->devs[j];
+				u8 fport;
+
+				if (!dev)
+					continue;
+
+				fport = airoha_get_fe_port(dev);
+				airoha_ppe_set_cpu_port(dev, i, fport);
+			}
 		}
 	}
 }

-- 
2.54.0


