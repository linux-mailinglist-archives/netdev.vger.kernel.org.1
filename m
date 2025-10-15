Return-Path: <netdev+bounces-229500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7BBDCE18
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5065B3E5FC0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BA315D39;
	Wed, 15 Oct 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtEIprY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14C9315D30;
	Wed, 15 Oct 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512562; cv=none; b=bN80MrKH9LLZs+aV63OK8VwflINNzUqe/IoaQUQg6h9A5c2Ra0v6sGW3eF9di2MSIjtyEUOisjnURu7+ok1NUG2u5Ywi5ucm3tWJNz6ebDPaVdL0/jylW3vO3YJD5VcQ7+nGSb4D+mY8Nis6DpKbuywHv5U8p/qwRNddwOWEBAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512562; c=relaxed/simple;
	bh=S4CJOPreTSFAueUrvY6h/HbfEswJjG7BoSqKebhsDAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwJcgBokOCLDhXA6ivTghpjsmzMFFO/oo6iATcefq7+yEFyg+XgkbOJySwHEaqJPOZMAfb8GAA0+9VJxgINmvSQGUxrF6toolpaU73q1AFVQVbGFjHMP/DyH+9EGCa8qvz+p8kU7kXTd7nRLHA3UISQf/WQSeLuNpyu2xQfMY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtEIprY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE9C4CEFE;
	Wed, 15 Oct 2025 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512561;
	bh=S4CJOPreTSFAueUrvY6h/HbfEswJjG7BoSqKebhsDAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NtEIprY8JHcGVSY65cRr/AskgToTX3ZELWnVosoiRCkQ4NWI4VSpNiOxy5ddxdapD
	 mkH5nZYlOI24yL2RbaxNgEFUqON6BbielDvIRfW4Lvc9EjgUkM1jf/XW5GPQ0f08fd
	 uSx7ZLkWxpnNMFMX6igupDessmvhmCZl8zyuipcsvBkSbhadSDZQSzRhSlqFhRy+Pj
	 3XC2R8REKHAQtOKUIdLof/Xz96Uan96pj1N7c1tinCRaawASvGGFXxZSeYNBLp9/P4
	 lGN2ivBooBlbOYpERybZgZ3G70+GH11nDUoD26TxRN5JGAibKDHdUINl9h0eMas2xI
	 9My1Ezli/RWlA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:12 +0200
Subject: [PATCH net-next 12/12] net: airoha: Add AN7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-12-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce support for AN7583 ethernet controller to airoha-eth dirver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 66 +++++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h | 11 ++++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  3 ++
 3 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 76c82750b3ae89a9fa81c64d3b7c3578b369480c..1e432922c8418777d2a9ba482924ef5d8f98081a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1686,9 +1686,7 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	u32 pse_port = port->id == 3 ? FE_PSE_PORT_GDM3 : FE_PSE_PORT_GDM4;
 	struct airoha_eth *eth = port->qdma->eth;
-	u32 chan = port->id == 3 ? 4 : 0;
-	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
-	u32 nbq = port->id == 3 ? 4 : 0;
+	u32 chan, nbq;
 	int src_port;
 
 	/* Forward the traffic to the proper GDM port */
@@ -1698,6 +1696,8 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	/* Enable GDM2 loopback */
 	airoha_fe_wr(eth, REG_GDM_TXCHN_EN(2), 0xffffffff);
 	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
+
+	chan = port->id == 3 ? airoha_is_7581(eth) ? 4 : 3 : 0;
 	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
 		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
 		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
@@ -1712,6 +1712,8 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(2));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(2));
 
+	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
+	nbq = port->id == 3 && airoha_is_7581(eth) ? 4 : 0;
 	src_port = eth->soc->ops.get_src_port_id(port, nbq);
 	if (src_port < 0)
 		return src_port;
@@ -1723,7 +1725,7 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(src_port & 0x7),
 		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(src_port & 0x7)));
 
-	if (port->id != 3)
+	if (port->id != 3 && airoha_is_7581(eth))
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
 			      FC_ID_OF_SRC_PORT24_MASK,
 			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
@@ -1878,6 +1880,20 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
+static int airoha_get_fe_port(struct airoha_gdm_port *port)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+
+	switch (eth->soc->version) {
+	case 0x7583:
+		return port->id == 3 ? FE_PSE_PORT_GDM3 : port->id;
+	case 0x7581:
+	default:
+		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	}
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -1918,7 +1934,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		}
 	}
 
-	fport = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	fport = airoha_get_fe_port(port);
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
@@ -3081,6 +3097,35 @@ static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
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
@@ -3091,8 +3136,19 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
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
index 1b83b935520cd736a1eb376eff937340ed99a49a..35fca0a0ea9793388fda2598f7bc830f821cd926 100644
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
@@ -622,6 +628,11 @@ static inline bool airoha_is_7581(struct airoha_eth *eth)
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
index 0315aafe2fd596e5f5b27d2a2b3fb198ff2ec19f..85bc5301f4b8cdfba4e582a0d8368910545c9a5b 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -36,6 +36,9 @@ static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
 					    u32 *num_stats)
 {
 #ifdef CONFIG_NET_AIROHA_FLOW_STATS
+	if (airoha_is_7583(ppe->eth))
+		return -EOPNOTSUPP;
+
 	*num_stats = PPE_STATS_NUM_ENTRIES;
 	return 0;
 #else

-- 
2.51.0


