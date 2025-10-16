Return-Path: <netdev+bounces-229986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2FBE2CC3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DE419C86EF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493731D729;
	Thu, 16 Oct 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnHbnSEL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C52BDC34;
	Thu, 16 Oct 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610552; cv=none; b=qEMdv7rJPxLw3p6k8M0nqBDbZxVoi/ShaLWTGcmhinTZ78RXK62R+wqQ4gazLez14XTRqf64bSe1sY2xyDkA1TiuXRtZwZGEl8e1vBzbxbzbnzmR5aiNsSBBc0doXN1zK+s4qDtBldY42kkfHdZPXRVDLQlgqhfP7/9mfv3ohbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610552; c=relaxed/simple;
	bh=V7uKdWh9DL8VLIBAcI157v28Uag8XqY9eeq4Pg3ppWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQX6dIRGZ6A5YqGZw2oirVFKNX7vJnCybcTQDuwt7HL7ZYMTlCkdaece/76Zco3/E/T0R8XRPO9Ldv6blf9L6ekyUshnwj8hOT0QgodEXXIekiDu6bt7ADMbcmxbbYG9TH2lBMoRnZkga2UGS1BWOcwQqHh9pCgR6O54XWTzxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnHbnSEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19907C4CEF1;
	Thu, 16 Oct 2025 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610552;
	bh=V7uKdWh9DL8VLIBAcI157v28Uag8XqY9eeq4Pg3ppWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NnHbnSELJYPgY3+ZqM+AKIPbdx9nnJPD8hPo09TKQLtx/x+TdzxgLEPg4r/+9Z/Vw
	 L6JJj9MefF6oCFkl3C8glAQVkNwaneSuGR15KdqDUP+ObppcqLbC7KkubTC8/oCrfP
	 61egIgKoOZXuNBlee62ixxrrJDZLnXG23o3sCzIEwFVbvm5aVFf1o5Vrom6/OkqGMY
	 t1EboGM2kGh0jMlwKaEQuZJrmsVQUsNikiHUPKYjiXtzvIEA3YSCkxe36L5bQ1F/TU
	 pZTsw9rcWN9Ln/ILlmKFWRQN+gTCaPfCIy1UytIzfV0Qd1nTRf+upUSeTxNp2J1GEq
	 qbv1ItBFulW0g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:27 +0200
Subject: [PATCH net-next v2 13/13] net: airoha: Add AN7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-13-ea6e7e9acbdb@kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
In-Reply-To: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
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
 drivers/net/ethernet/airoha/airoha_eth.c | 68 +++++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h | 11 ++++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  3 ++
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index b9d36b841fe272a302125367a8d1e88e6e5adfbf..79a85ce96d6393fe47d91208068ff20a29862ca7 100644
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
@@ -1881,6 +1883,22 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
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
@@ -1921,7 +1939,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		}
 	}
 
-	fport = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	fport = airoha_get_fe_port(port);
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
@@ -3084,6 +3102,35 @@ static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
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
@@ -3094,8 +3141,19 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
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


