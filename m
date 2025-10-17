Return-Path: <netdev+bounces-230399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0006BE77D7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9F3C5408DC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCA314D27;
	Fri, 17 Oct 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP2P2nq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35772D8362;
	Fri, 17 Oct 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692028; cv=none; b=IhAnXgNM1dJS0wmCri+mZ+fDIVrky6BIJL6C5KKn0PirFlZ0tK6PTdvxCLTw1YtVPMXvcUh0PfSLjRHE1PPYQl9bGcinexcSN/+HzEAf/4y3DoSlu44M6P8lZg3kHO29RA6LBUzw+2ibcaIMKrByn1QBt40VAAJ9dawJjv6OjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692028; c=relaxed/simple;
	bh=0B65CqGzJEK6ceaUHrNKfW0NJ7hQsUV/sEi/kCYzBAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTNd0DNlo271W0H9ev4UGjp2ptztMDlt3l6KZl33qjPSPAbUI6ryOmvyebbyVVcW+FD3WQ0u98+ATLFR72o7HzDpuDT8uYuHZBGSgCS/jjmK4H1FMX9rZUGaEprdwKPd8ENMX7ejp6HVKxDkBlL2G1xQ8jqcZnBESvF2hoKacfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP2P2nq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E8C4CEE7;
	Fri, 17 Oct 2025 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692025;
	bh=0B65CqGzJEK6ceaUHrNKfW0NJ7hQsUV/sEi/kCYzBAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oP2P2nq9WZa8iQ6R+VCwTi0eH2hwOQ/biFYbUmiKYFKJECaYdfW0+/JCL2uZwMcy8
	 HPHVzN1PSBUF0ZhjtPz/+mUNGN34VBoDkLfMR1SX/FPCgegjv8GTRj1Jx2lChBB5At
	 c0oxRNe+6zjxYMgt5+2tdzDG4Ug0R84cDZKZ0eMsW/g8BuJ+t+atqQgWq47kf+UetI
	 F8kLZNUd5A/Ix4AeHXaDr+mSv9fwIgk3ndUnae9OSloEWjaMMXHVpAmu3nsgdYd50x
	 PvQtFpnzn/y8vUmSzhy877IEeKfq4IptYYohKiJD4NmVPqZVVBpacAP0O/dMoVLL8W
	 DQBU2XNgHpZHw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:22 +0200
Subject: [PATCH net-next v3 13/13] net: airoha: Add AN7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-13-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Introduce support for AN7583 ethernet controller to airoha-eth dirver.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 68 +++++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h | 11 ++++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  3 ++
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4671f906a68c794d2ad05fbf5777fe22405c3d8f..8483ea02603e24de5eb37654452f8c2b21b9bff4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1684,10 +1684,8 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 
 static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
-	u32 val, pse_port, chan = port->id == AIROHA_GDM3_IDX ? 4 : 0;
 	struct airoha_eth *eth = port->qdma->eth;
-	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
-	u32 nbq = port->id == AIROHA_GDM3_IDX ? 4 : 0;
+	u32 val, pse_port, chan, nbq;
 	int src_port;
 
 	/* Forward the traffic to the proper GDM port */
@@ -1699,6 +1697,8 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	/* Enable GDM2 loopback */
 	airoha_fe_wr(eth, REG_GDM_TXCHN_EN(2), 0xffffffff);
 	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
+
+	chan = port->id == AIROHA_GDM3_IDX ? airoha_is_7581(eth) ? 4 : 3 : 0;
 	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
 		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
 		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
@@ -1713,6 +1713,8 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(2));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(2));
 
+	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
+	nbq = port->id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
 	src_port = eth->soc->ops.get_src_port_id(port, nbq);
 	if (src_port < 0)
 		return src_port;
@@ -1726,7 +1728,7 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
 
-	if (port->id != AIROHA_GDM3_IDX)
+	if (port->id != AIROHA_GDM3_IDX && airoha_is_7581(eth))
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
 			      FC_ID_OF_SRC_PORT24_MASK,
 			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
@@ -1895,6 +1897,22 @@ static bool airoha_dev_tx_queue_busy(struct airoha_queue *q, u32 nr_frags)
 	return index >= tail;
 }
 
+static int airoha_get_fe_port(struct airoha_gdm_port *port)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+
+	switch (eth->soc->version) {
+	case 0x7583:
+		return port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
+						   : port->id;
+	case 0x7581:
+	default:
+		return port->id == AIROHA_GDM4_IDX ? FE_PSE_PORT_GDM4
+						   : port->id;
+	}
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -1935,7 +1953,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		}
 	}
 
-	fport = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	fport = airoha_get_fe_port(port);
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
@@ -3098,6 +3116,35 @@ static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
 	return -EINVAL;
 }
 
+static const char * const an7583_xsi_rsts_names[] = {
+	"xsi-mac",
+	"hsi0-mac",
+	"hsi1-mac",
+	"xfp-mac",
+};
+
+static int airoha_an7583_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+{
+	switch (port->id) {
+	case 3:
+		/* 7583 SoC supports eth serdes on GDM3 port */
+		if (!nbq)
+			return HSGMII_LAN_7583_ETH_SRCPORT;
+		break;
+	case 4:
+		/* 7583 SoC supports PCIe and USB serdes on GDM4 port */
+		if (!nbq)
+			return HSGMII_LAN_7583_PCIE_SRCPORT;
+		if (nbq == 1)
+			return HSGMII_LAN_7583_USB_SRCPORT;
+		break;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static const struct airoha_eth_soc_data en7581_soc_data = {
 	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
@@ -3108,8 +3155,19 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	},
 };
 
+static const struct airoha_eth_soc_data an7583_soc_data = {
+	.version = 0x7583,
+	.xsi_rsts_names = an7583_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
+	.num_ppe = 1,
+	.ops = {
+		.get_src_port_id = airoha_an7583_get_src_port_id,
+	},
+};
+
 static const struct of_device_id of_airoha_match[] = {
 	{ .compatible = "airoha,en7581-eth", .data = &en7581_soc_data },
+	{ .compatible = "airoha,an7583-eth", .data = &an7583_soc_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_match);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index e09579da8c78a99ef07ee7eef7be3cd6c1b5be76..eb27a4ff51984ef376c6e94607ee2dc1a806488b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -73,6 +73,12 @@ enum {
 	HSGMII_LAN_7581_USB_SRCPORT,
 };
 
+enum {
+	HSGMII_LAN_7583_ETH_SRCPORT	= 0x16,
+	HSGMII_LAN_7583_PCIE_SRCPORT	= 0x18,
+	HSGMII_LAN_7583_USB_SRCPORT,
+};
+
 enum {
 	XSI_PCIE0_VIP_PORT_MASK	= BIT(22),
 	XSI_PCIE1_VIP_PORT_MASK	= BIT(23),
@@ -629,6 +635,11 @@ static inline bool airoha_is_7581(struct airoha_eth *eth)
 	return eth->soc->version == 0x7581;
 }
 
+static inline bool airoha_is_7583(struct airoha_eth *eth)
+{
+	return eth->soc->version == 0x7583;
+}
+
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index eda95107cd1daf6ff00a85abc72313a509ed67e9..c373f21d95f5a610deae365c64bc589c21f5e1a0 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -37,6 +37,9 @@ static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe)
 	if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
 		return -EOPNOTSUPP;
 
+	if (airoha_is_7583(ppe->eth))
+		return -EOPNOTSUPP;
+
 	return PPE_STATS_NUM_ENTRIES;
 }
 

-- 
2.51.0


