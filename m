Return-Path: <netdev+bounces-294559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VItSB9HDH2qEpgAAu9opvQ
	(envelope-from <netdev+bounces-294559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C16347F3
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l8mOiG1u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294559-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31952303C807
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEDD3F58C9;
	Wed,  3 Jun 2026 06:01:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171783F8ED2;
	Wed,  3 Jun 2026 06:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466470; cv=none; b=a2nQ0epUVd7/4Dq60pN6R2X2ZvsUYZ+3YtDOG9fsXgsbExjUIqSZeYrrfeAMi9MHaX2O78YVhKBiQ7Jd1C0p2NzmHzm3hA/AmwyERFXbO6VIYRSe3CVLr4VdeU7Y3JuScbgsJQlrbYNMU95T90R98aGBEEBoRcKKJpgd5/9WOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466470; c=relaxed/simple;
	bh=HlXMOC7BJkv9vSON5G5Ms1NtEYg/73Xyph2ZfUTvdWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm+9BJJ6vOrtWISqV5OJ0RhDituUaWU/zeT7rgSt0BI6Su/4FxuTdLmDoenRPlfXlqYiVXHEKLGwmJhO+8r3qoBQsfPN8cvaE3V67qFXTgR3EOtt1JyWtC65+UKLHptNDgoSoFF7hy/xP0NKQE8l+6c9r4JbHPQyQznOKZJ56k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8mOiG1u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A0E1F00899;
	Wed,  3 Jun 2026 06:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466468;
	bh=aoqeg4r0oBstpJPgBzmFYmQpgDOXqKeWC10hLg4z5BM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l8mOiG1uZahQX/p90CRXSuebreOQ+5FkLcCRPZOr0G9FpdM/sNBpXYDVaM5Nhgz08
	 N2/1If6CyeBC1e/HfwNbetyg4zs3S84+1nHg2UdrMPYDRE2Tk3THcvc+vMUfJ4B9Ji
	 XDadBpwxeK+sqpGnKTaBdr+hoIdPslP2LcV1i3zqE5IBinLihi5ck9XyatkjWigK3e
	 bJrECehseZRGBLD07DEdH2rB/5PzBETzr3kGG6m0anWO+r9j/MdM0jQkVdbGiiqbBX
	 8QNj6rI2HsjJpi0pOWM3NTskcSZpwAuFccG9Hw4UiALR3T33TtVRdwWZ4eb4LHaUgo
	 Ni7xvclNyS/+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 08:00:17 +0200
Subject: [PATCH net-next v9 3/6] net: airoha: Support multiple net_devices
 for a single FE GDM port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-airoha-eth-multi-serdes-v9-3-5d476bc2f426@kernel.org>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lorenzo@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:xuegang.lu@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7C16347F3

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
 drivers/net/ethernet/airoha/airoha_eth.c | 280 +++++++++++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h |   8 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  26 ++-
 3 files changed, 237 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 57a16de0a2ec..1d088d95d5fb 100644
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
@@ -566,24 +566,26 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
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
@@ -598,9 +600,9 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		u32 hash, reason, msg1, desc_ctrl;
-		struct airoha_gdm_port *port;
+		struct airoha_gdm_dev *dev;
 		struct net_device *netdev;
-		int data_len, len, p;
+		int data_len, len;
 		struct page *page;
 
 		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
@@ -621,15 +623,11 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!len || data_len < len)
 			goto free_frag;
 
-		p = airoha_qdma_get_gdm_port(eth, desc);
-		if (p < 0 || !eth->ports[p])
+		dev = airoha_qdma_get_gdm_dev(eth, desc);
+		if (IS_ERR(dev))
 			goto free_frag;
 
-		port = eth->ports[p];
-		if (!port->dev)
-			goto free_frag;
-
-		netdev = netdev_from_priv(port->dev);
+		netdev = netdev_from_priv(dev);
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
 						q->buf_size);
@@ -659,6 +657,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			continue;
 
 		if (netdev_uses_dsa(netdev)) {
+			struct airoha_gdm_port *port = dev->port;
+
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
@@ -852,26 +852,29 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
-		struct net_device *netdev;
-		int j;
+		int d;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (!dev)
-			continue;
+		for (d = 0; d < ARRAY_SIZE(port->devs); d++) {
+			struct airoha_gdm_dev *dev = port->devs[d];
+			struct net_device *netdev;
+			int j;
 
-		if (dev->qdma != qdma)
-			continue;
+			if (!dev)
+				continue;
 
-		netdev = netdev_from_priv(dev);
-		for (j = 0; j < netdev->num_tx_queues; j++) {
-			if (airoha_qdma_get_txq(qdma, j) != qid)
+			if (dev->qdma != qdma)
 				continue;
 
-			netif_wake_subqueue(netdev, j);
+			netdev = netdev_from_priv(dev);
+			for (j = 0; j < netdev->num_tx_queues; j++) {
+				if (airoha_qdma_get_txq(qdma, j) != qid)
+					continue;
+
+				netif_wake_subqueue(netdev, j);
+			}
 		}
 	}
 	q->txq_stopped = false;
@@ -1742,11 +1745,9 @@ static int airoha_dev_open(struct net_device *netdev)
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 	atomic_inc(&qdma->users);
 
-	if (port->id == AIROHA_GDM2_IDX &&
-	    airoha_ppe_is_enabled(qdma->eth, 1)) {
-		/* For PPE2 always use secondary cpu port. */
+	if (!airoha_is_lan_gdm_dev(dev) &&
+	    airoha_ppe_is_enabled(qdma->eth, 1))
 		pse_port = FE_PSE_PORT_PPE2;
-	}
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
 
@@ -1834,7 +1835,7 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	src_port = eth->soc->ops.get_sport(port, port->nbq);
+	src_port = eth->soc->ops.get_sport(port, dev->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -1851,7 +1852,7 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 		airoha_ppe_set_cpu_port(dev, i, AIROHA_GDM2_IDX);
 
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
-		u32 mask = FC_ID_OF_SRC_PORT_MASK(port->nbq);
+		u32 mask = FC_ID_OF_SRC_PORT_MASK(dev->nbq);
 
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
 			      __field_prep(mask, AIROHA_GDM2_IDX));
@@ -1865,7 +1866,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
-	int i;
+	int ppe_id;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
@@ -1888,8 +1889,8 @@ static int airoha_dev_init(struct net_device *netdev)
 		break;
 	}
 
-	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
+	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
+	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
 
 	return 0;
 }
@@ -2055,7 +2056,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	}
 
 	fport = airoha_get_fe_port(dev);
-	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
+	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_NBOQ_MASK, dev->nbq) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
 	q = &qdma->q_tx[qid];
@@ -2985,12 +2987,15 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
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
@@ -2998,10 +3003,11 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 
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
@@ -3021,7 +3027,6 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 			      NETIF_F_HW_TC;
 	netdev->features |= netdev->hw_features;
 	netdev->vlan_features = netdev->hw_features;
-	netdev->dev.of_node = np;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
@@ -3039,10 +3044,24 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
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
 	dev->port = port;
-	port->dev = dev;
 	dev->eth = eth;
+	dev->nbq = nbq;
+	port->devs[index] = dev;
 
 	return 0;
 }
@@ -3052,7 +3071,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
 	struct airoha_gdm_port *port;
-	int err, p;
+	struct device_node *node;
+	int err, nbq, p, d = 0;
 	u32 id;
 
 	if (!id_ptr) {
@@ -3080,15 +3100,51 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
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
@@ -3097,14 +3153,22 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		int err;
+		int j;
 
 		if (!port)
 			continue;
 
-		err = register_netdev(netdev_from_priv(port->dev));
-		if (err)
-			return err;
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			int err;
+
+			if (!dev)
+				continue;
+
+			err = register_netdev(netdev_from_priv(dev));
+			if (err)
+				return err;
+		}
 	}
 
 	set_bit(DEV_STATE_REGISTERED, &eth->state);
@@ -3211,17 +3275,22 @@ static int airoha_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
+		int j;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev) {
-			struct net_device *netdev = netdev_from_priv(dev);
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!dev)
+				continue;
 
+			netdev = netdev_from_priv(dev);
 			if (netdev->reg_state == NETREG_REGISTERED)
 				unregister_netdev(netdev);
+			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
 	}
@@ -3243,14 +3312,22 @@ static void airoha_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
-		struct airoha_gdm_dev *dev;
+		int j;
 
 		if (!port)
 			continue;
 
-		dev = port->dev;
-		if (dev)
-			unregister_netdev(netdev_from_priv(dev));
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!dev)
+				continue;
+
+			netdev = netdev_from_priv(dev);
+			unregister_netdev(netdev);
+			of_node_put(netdev->dev.of_node);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3313,6 +3390,39 @@ static u32 airoha_en7581_get_vip_port(struct airoha_gdm_port *port, int nbq)
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
@@ -3362,6 +3472,36 @@ static u32 airoha_an7583_get_vip_port(struct airoha_gdm_port *port, int nbq)
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
@@ -3370,6 +3510,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.ops = {
 		.get_sport = airoha_en7581_get_sport,
 		.get_vip_port = airoha_en7581_get_vip_port,
+		.get_dev_from_sport = airoha_en7581_get_dev_from_sport,
 	},
 };
 
@@ -3381,6 +3522,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.ops = {
 		.get_sport = airoha_an7583_get_sport,
 		.get_vip_port = airoha_an7583_get_vip_port,
+		.get_dev_from_sport = airoha_an7583_get_dev_from_sport,
 	},
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 1f162fa1405e..92fd81bb9269 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -17,6 +17,7 @@
 #include <net/dsa.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
+#define AIROHA_MAX_NUM_GDM_DEVS		2
 #define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
@@ -546,12 +547,13 @@ struct airoha_gdm_dev {
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
+
+	int nbq;
 };
 
 struct airoha_gdm_port {
-	struct airoha_gdm_dev *dev;
+	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
 	int id;
-	int nbq;
 
 	struct airoha_hw_stats stats;
 
@@ -587,6 +589,8 @@ struct airoha_eth_soc_data {
 	struct {
 		int (*get_sport)(struct airoha_gdm_port *port, int nbq);
 		u32 (*get_vip_port)(struct airoha_gdm_port *port, int nbq);
+		int (*get_dev_from_sport)(struct airoha_qdma_desc *desc,
+					  u16 *port, u16 *dev);
 	} ops;
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c9711bb7ef1c..96abf451fdac 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -167,9 +167,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
 				PPE_FLOW_CFG_IP6_6RD_MASK);
 
-		for (p = 0; p < ARRAY_SIZE(eth->ports); p++) {
-			struct airoha_gdm_port *port = eth->ports[p];
-
+		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
 				      FP0_EGRESS_MTU_MASK |
 				      FP1_EGRESS_MTU_MASK,
@@ -177,11 +175,27 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 						 AIROHA_MAX_MTU) |
 				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
 						 AIROHA_MAX_MTU));
-			if (!port)
+	}
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			int ppe_id;
+			u8 fport;
+
+			if (!dev)
 				continue;
 
-			airoha_ppe_set_cpu_port(port->dev, i,
-						airoha_get_fe_port(port->dev));
+			ppe_id = !airoha_is_lan_gdm_dev(dev) &&
+				 airoha_ppe_is_enabled(eth, 1);
+			fport = airoha_get_fe_port(dev);
+			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
 		}
 	}
 }

-- 
2.54.0


