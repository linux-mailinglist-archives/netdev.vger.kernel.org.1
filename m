Return-Path: <netdev+bounces-230396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10540BE7759
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38A00562BFE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567453128B5;
	Fri, 17 Oct 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBvKa9BP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6562D5410;
	Fri, 17 Oct 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692020; cv=none; b=QM3VBQGbDE8GgJEyjJ/IcuIXjyUSZdhBf/3Q/KRHL4kwmk1etMlu+Fy6nUvvTsHfoV5cToZaZ/3V6ZiRvZiAvWDHASG5G92ScLyB+Cc9PoMsgZEWZknKbcMCPP7vdKMGair9e0NOx5AVGeFV0b+AwonbjbLDTk/ETZ6kfXON0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692020; c=relaxed/simple;
	bh=zOyKLJsbXyMhr/5wiHTlh6Y9eRxkAu03maX20daSvCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5IWR0QYLST517oxMT97dOjQp7v+3ob4lcqARlxLg152uRIMOSvw3fp/VYDL6+BL7dFjJPYLsdGB5i4r98mClUMcL6rqaBGS6CZMQlbL00OT2ghgXe7nWwzj0OR+enXSdk+ESJJqhM/qZdbu6KWikskZDsV+ynmPmr1247HsqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBvKa9BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E5C4CEFE;
	Fri, 17 Oct 2025 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692020;
	bh=zOyKLJsbXyMhr/5wiHTlh6Y9eRxkAu03maX20daSvCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MBvKa9BPKKCYXCM8uvoPEUnMNha0sDnfWQbP7rFYZNWyCFzQPvmmJ/CL1ZBctd6xn
	 XVQk0vMCbOXXLMIu5F3rATfFaK5iebbSpRq6DNsI5tl4ol+ioEo/H4HfU3dmopkv2I
	 z7iLP8kHxPLHrk8pk9x5dSW26Sgims7GTpLGv9MOZ76AJ7hY6IX52EoCMP0TIEtw+d
	 RkFoUFFSZbiBwm/5xin6mszKnESHUElfte67Ni4DpKt7/9ZIMM6y/gA/zo5N6eACjy
	 rVwFnsNNghlrUVGG+uHhfcjR2ceR477g/Qzzb6C7QPkWchR9+d1o3RQuxtFS62EczK
	 eiCAC667Osjcw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:20 +0200
Subject: [PATCH net-next v3 11/13] net: airoha: Refactor src port
 configuration in airhoha_set_gdm2_loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-11-f28319666667@kernel.org>
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

AN7583 chipset relies on different definitions for source-port
identifier used for hw offloading. In order to support hw offloading
in AN7583 controller, refactor src port configuration in
airhoha_set_gdm2_loopback routine and introduce get_src_port_id
callback.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 82 +++++++++++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h  | 18 +++++--
 drivers/net/ethernet/airoha/airoha_regs.h |  6 +--
 3 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4e338c126dd3fa16f040960ff7f26d8214a9d6f7..4671f906a68c794d2ad05fbf5777fe22405c3d8f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1682,13 +1682,17 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	return 0;
 }
 
-static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
+static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
-	u32 pse_port = port->id == 3 ? FE_PSE_PORT_GDM3 : FE_PSE_PORT_GDM4;
+	u32 val, pse_port, chan = port->id == AIROHA_GDM3_IDX ? 4 : 0;
 	struct airoha_eth *eth = port->qdma->eth;
-	u32 chan = port->id == 3 ? 4 : 0;
+	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
+	u32 nbq = port->id == AIROHA_GDM3_IDX ? 4 : 0;
+	int src_port;
 
 	/* Forward the traffic to the proper GDM port */
+	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
+					       : FE_PSE_PORT_GDM4;
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(2), pse_port);
 	airoha_fe_clear(eth, REG_GDM_FWD_CFG(2), GDM_STRIP_CRC);
 
@@ -1709,29 +1713,25 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(2));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(2));
 
-	if (port->id == 3) {
-		/* FIXME: handle XSI_PCE1_PORT */
-		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
-			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
-			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_PCIE0_SRCPORT));
-		airoha_fe_rmw(eth,
-			      REG_SP_DFT_CPORT(HSGMII_LAN_PCIE0_SRCPORT >> 3),
-			      SP_CPORT_PCIE0_MASK,
-			      FIELD_PREP(SP_CPORT_PCIE0_MASK,
-					 FE_PSE_PORT_CDM2));
-	} else {
-		/* FIXME: handle XSI_USB_PORT */
+	src_port = eth->soc->ops.get_src_port_id(port, nbq);
+	if (src_port < 0)
+		return src_port;
+
+	airoha_fe_rmw(eth, REG_FE_WAN_PORT,
+		      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
+		      FIELD_PREP(WAN0_MASK, src_port));
+	val = src_port & SP_CPORT_DFT_MASK;
+	airoha_fe_rmw(eth,
+		      REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
+		      SP_CPORT_MASK(val),
+		      FE_PSE_PORT_CDM2 << __ffs(SP_CPORT_MASK(val)));
+
+	if (port->id != AIROHA_GDM3_IDX)
 		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6,
 			      FC_ID_OF_SRC_PORT24_MASK,
 			      FIELD_PREP(FC_ID_OF_SRC_PORT24_MASK, 2));
-		airoha_fe_rmw(eth, REG_FE_WAN_PORT,
-			      WAN1_EN_MASK | WAN1_MASK | WAN0_MASK,
-			      FIELD_PREP(WAN0_MASK, HSGMII_LAN_ETH_SRCPORT));
-		airoha_fe_rmw(eth,
-			      REG_SP_DFT_CPORT(HSGMII_LAN_ETH_SRCPORT >> 3),
-			      SP_CPORT_ETH_MASK,
-			      FIELD_PREP(SP_CPORT_ETH_MASK, FE_PSE_PORT_CDM2));
-	}
+
+	return 0;
 }
 
 static int airoha_dev_init(struct net_device *dev)
@@ -1748,8 +1748,13 @@ static int airoha_dev_init(struct net_device *dev)
 	case 3:
 	case 4:
 		/* If GDM2 is active we can't enable loopback */
-		if (!eth->ports[1])
-			airhoha_set_gdm2_loopback(port);
+		if (!eth->ports[1]) {
+			int err;
+
+			err = airhoha_set_gdm2_loopback(port);
+			if (err)
+				return err;
+		}
 		fallthrough;
 	case 2:
 		if (airoha_ppe_is_enabled(eth, 1)) {
@@ -3069,11 +3074,38 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
+{
+	switch (port->id) {
+	case 3:
+		/* 7581 SoC supports PCIe serdes on GDM3 port */
+		if (nbq == 4)
+			return HSGMII_LAN_7581_PCIE0_SRCPORT;
+		if (nbq == 5)
+			return HSGMII_LAN_7581_PCIE1_SRCPORT;
+		break;
+	case 4:
+		/* 7581 SoC supports eth and usb serdes on GDM4 port */
+		if (!nbq)
+			return HSGMII_LAN_7581_ETH_SRCPORT;
+		if (nbq == 1)
+			return HSGMII_LAN_7581_USB_SRCPORT;
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
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.num_ppe = 2,
+	.ops = {
+		.get_src_port_id = airoha_en7581_get_src_port_id,
+	},
 };
 
 static const struct of_device_id of_airoha_match[] = {
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index df168d798699d50c70fa5f87764de24e85994dfd..e09579da8c78a99ef07ee7eef7be3cd6c1b5be76 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -67,10 +67,10 @@ enum {
 };
 
 enum {
-	HSGMII_LAN_PCIE0_SRCPORT = 0x16,
-	HSGMII_LAN_PCIE1_SRCPORT,
-	HSGMII_LAN_ETH_SRCPORT,
-	HSGMII_LAN_USB_SRCPORT,
+	HSGMII_LAN_7581_PCIE0_SRCPORT	= 0x16,
+	HSGMII_LAN_7581_PCIE1_SRCPORT,
+	HSGMII_LAN_7581_ETH_SRCPORT,
+	HSGMII_LAN_7581_USB_SRCPORT,
 };
 
 enum {
@@ -99,6 +99,13 @@ enum {
 	CRSN_25 = 0x19,
 };
 
+enum airoha_gdm_index {
+	AIROHA_GDM1_IDX = 1,
+	AIROHA_GDM2_IDX = 2,
+	AIROHA_GDM3_IDX = 3,
+	AIROHA_GDM4_IDX = 4,
+};
+
 enum {
 	FE_PSE_PORT_CDM1,
 	FE_PSE_PORT_GDM1,
@@ -555,6 +562,9 @@ struct airoha_eth_soc_data {
 	const char * const *xsi_rsts_names;
 	int num_xsi_rsts;
 	int num_ppe;
+	struct {
+		int (*get_src_port_id)(struct airoha_gdm_port *port, int nbq);
+	} ops;
 };
 
 struct airoha_eth {
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 69c5a143db8c079be0a6ecf41081cd3f5048c090..ebcce00d9bc6f0b0dfe3cabeddaa59b26c7b289d 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -383,10 +383,8 @@
 #define REG_MC_VLAN_DATA		0x2108
 
 #define REG_SP_DFT_CPORT(_n)		(0x20e0 + ((_n) << 2))
-#define SP_CPORT_PCIE1_MASK		GENMASK(31, 28)
-#define SP_CPORT_PCIE0_MASK		GENMASK(27, 24)
-#define SP_CPORT_USB_MASK		GENMASK(7, 4)
-#define SP_CPORT_ETH_MASK		GENMASK(7, 4)
+#define SP_CPORT_DFT_MASK		GENMASK(2, 0)
+#define SP_CPORT_MASK(_n)		GENMASK(3 + ((_n) << 2), ((_n) << 2))
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
 #define FC_ID_OF_SRC_PORT27_MASK	GENMASK(28, 24)

-- 
2.51.0


