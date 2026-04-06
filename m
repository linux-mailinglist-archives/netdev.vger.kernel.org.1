Return-Path: <netdev+bounces-275564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DLOI26M02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0FD3A2D7D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE799300380F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3232B99F;
	Mon,  6 Apr 2026 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKUaLcQc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34EB3264F3;
	Mon,  6 Apr 2026 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471715; cv=none; b=rS9hS2BPmMIrwTZzld+43GkOy46cUVHSKHX0volWjHGjEUPU3H4G2z1EgvneE2fKxrcErc8SBOum3adlVhGPDrbv3dh7MYo1Zx+OowwAm29AoSNXKGBvpq5+bh64EZhgQsQy7T0dHqMWbSfR0zO2vqz02H4ov1rFXCFlPAjgNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471715; c=relaxed/simple;
	bh=kqOit8qht6zrHkR0OU1v+nN1W+YIqt8Odo8Ras24D7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSmQjPAJtGwhiLP6BeOlCxg/fqGDQT9b13QV7hN6TUyp+MDsik52ePLVe3UKk1Om75gKM+Aj1Wr6+ysmGknk1frEJariPkMG7B0oFoCtT0sHtCM59tmYQktj0+yyEBgaUtgzGkQYHC6iNnl4nM9/t7QQDQMXyyEVZB7ojK4tFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKUaLcQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F6FC2BCB2;
	Mon,  6 Apr 2026 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471714;
	bh=kqOit8qht6zrHkR0OU1v+nN1W+YIqt8Odo8Ras24D7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eKUaLcQcfQ9w5Ir6J5YzYIqUeNeR1NIR8R5U9lCYdFILRYtWwayUkOTW9VKYsEsT4
	 OPYyZCBI0E/EYhjrsWJOSIJjjXDMWL76z1HOrSmkEhtbVf/3FicelFSan0IEwB8+UB
	 i9SPWQpv0JlE5WQAlwgWnQyId04QcQaeO+9ov838Q4S3wJAe+iwWbpHt5x4VgSQ1U/
	 c+Ulom1P5Xucgqxjdf1Wz6VPdXCurqPFmtvs3EqkMEcxFh3LIoYX2h6cG+TGpB/TYb
	 W4l/EALcJx7utOV9LmjCM/TghQ+dD9YIpM9PrETfze6XjkX2J6u5u2kmFjM61MZ0UQ
	 NDEYJMaxGwi/g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:14 +0200
Subject: [PATCH net-next v3 09/12] net: airoha: Support multiple
 net_devices for a single FE GDM port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-9-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0FD3A2D7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/airoha/airoha_eth.c | 238 ++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h |   9 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  13 +-
 3 files changed, 206 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d25b0338b5ca..fd27ba13029b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -581,24 +581,26 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 	return nframes;
 }
 
-static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
-				    struct airoha_qdma_desc *desc)
+static struct airoha_gdm_dev *
+airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 {
-	u32 port, sport, msg1 = le32_to_cpu(desc->msg1);
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
+
+	if (p >= ARRAY_SIZE(eth->ports))
+		return ERR_PTR(-ENODEV);
+
+	port = eth->ports[p];
+	if (!port)
+		return ERR_PTR(-ENODEV);
+
+	if (d >= ARRAY_SIZE(port->devs))
+		return ERR_PTR(-ENODEV);
 
-	return port >= ARRAY_SIZE(eth->ports) ? -EINVAL : port;
+	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
@@ -615,9 +617,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
 		struct page *page = virt_to_head_page(e->buf);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
-		struct airoha_gdm_port *port;
-		struct net_device *netdev;
-		int data_len, len, p;
+		struct airoha_gdm_dev *dev;
+		int data_len, len;
 
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
@@ -634,12 +635,10 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
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
@@ -647,8 +646,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
+			q->skb->dev = dev->dev;
+			q->skb->protocol = eth_type_trans(q->skb, dev->dev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
@@ -666,7 +665,9 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
 			continue;
 
-		if (netdev_uses_dsa(netdev)) {
+		if (netdev_uses_dsa(dev->dev)) {
+			struct airoha_gdm_port *port = dev->port;
+
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
@@ -1734,7 +1735,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
-	u32 val, pse_port, chan, nbq;
+	u32 val, pse_port, chan;
 	int i, src_port;
 
 	/* Forward the traffic to the proper GDM port */
@@ -1764,9 +1765,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
-	nbq = port->id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
-	src_port = eth->soc->ops.get_src_port_id(port, nbq);
+	src_port = eth->soc->ops.get_src_port_id(port, dev->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -1783,7 +1782,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
 
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
-		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(dev->nbq);
 
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
 			      __field_prep(mask, AIROHA_GDM2_IDX));
@@ -1987,7 +1986,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	}
 
 	fport = airoha_get_fe_port(dev);
-	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
+	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
 	q = &qdma->q_tx[qid];
@@ -2901,12 +2901,15 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
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
@@ -2914,10 +2917,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
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
@@ -2937,7 +2941,6 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 			      NETIF_F_HW_TC;
 	netdev->features |= netdev->hw_features;
 	netdev->vlan_features = netdev->hw_features;
-	netdev->dev.of_node = np;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
@@ -2955,11 +2958,25 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
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
@@ -2969,7 +2986,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
-	int err, p;
+	struct device_node *node;
+	int err, p, d = 0;
 	u32 id;
 
 	if (!id_ptr) {
@@ -3003,7 +3021,43 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (err)
 		return err;
 
-	return airoha_alloc_gdm_device(eth, port, np);
+	for_each_child_of_node(np, node) {
+		/* Multiple external serdes connected to the FE GDM port via an
+		 * external arbiter.
+		 */
+		const __be32 *nbq_ptr;
+		int nbq;
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
+		err = eth->soc->ops.get_src_port_id(port, nbq);
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
+	return !d ? airoha_alloc_gdm_device(eth, port, 0, np) : 0;
 }
 
 static int airoha_register_gdm_devices(struct airoha_eth *eth)
@@ -3012,14 +3066,22 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 
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
@@ -3126,14 +3188,20 @@ static int airoha_probe(struct platform_device *pdev)
 
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
+
+			if (!dev)
+				continue;
+
+			if (dev->dev->reg_state == NETREG_REGISTERED)
+				unregister_netdev(dev->dev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3154,14 +3222,19 @@ static void airoha_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
+		int j;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev)
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+
+			if (!dev)
+				continue;
+
 			unregister_netdev(dev->dev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3202,6 +3275,39 @@ static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
 	return -EINVAL;
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
+	case 0x2:
+		*port = 1; /* GDM2 */
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
@@ -3231,6 +3337,36 @@ static int airoha_an7583_get_src_port_id(struct airoha_gdm_port *port, int nbq)
 	return -EINVAL;
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
+	case 0x2:
+		*port = 1; /* GDM2 */
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
@@ -3238,6 +3374,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.num_ppe = 2,
 	.ops = {
 		.get_src_port_id = airoha_en7581_get_src_port_id,
+		.get_dev_from_sport = airoha_en7581_get_dev_from_sport,
 	},
 };
 
@@ -3248,6 +3385,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.num_ppe = 1,
 	.ops = {
 		.get_src_port_id = airoha_an7583_get_src_port_id,
+		.get_dev_from_sport = airoha_an7583_get_dev_from_sport,
 	},
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index e6c87ed20b39..5ce71aff6c39 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -17,6 +17,7 @@
 #include <net/dsa.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
+#define AIROHA_MAX_NUM_GDM_DEVS		2
 #define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
@@ -535,12 +536,14 @@ struct airoha_qdma {
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
 
 	struct airoha_hw_stats stats;
@@ -582,6 +585,8 @@ struct airoha_eth_soc_data {
 	int num_ppe;
 	struct {
 		int (*get_src_port_id)(struct airoha_gdm_port *port, int nbq);
+		int (*get_dev_from_sport)(struct airoha_qdma_desc *desc,
+					  u16 *port, u16 *dev);
 	} ops;
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 712fc336c073..a6b188fab053 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -162,6 +162,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 
 		for (p = 0; p < ARRAY_SIZE(eth->ports); p++) {
 			struct airoha_gdm_port *port = eth->ports[p];
+			int j;
 
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
 				      FP0_EGRESS_MTU_MASK |
@@ -173,8 +174,16 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
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
2.53.0


