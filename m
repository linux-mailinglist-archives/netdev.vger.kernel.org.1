Return-Path: <netdev+bounces-214345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52ACB29079
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE07E17C3E6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518523AE93;
	Sat, 16 Aug 2025 19:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39142222A1;
	Sat, 16 Aug 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374212; cv=none; b=F5pPL2V72dw//VeU7mngyjxfxwEN28/rFWmpWe1NzPstZesgfvkNtIrQymzF/aGeg8SYhJPwulhfZ0kuDhdn0MYp9qFMIQCNWE9hMFH14xEHQKWcmjqssya/EVJiPCBqdYRDOtj0Rxff5wh23k9XKEZ02i7O/iuIolWPbFy7m3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374212; c=relaxed/simple;
	bh=ZyrYY8i/0z/lKxBFYDbC/g/1Q+dtJIjG0/VAO0pL4ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P/RgqR79wE6APSa7VcU91Gjda24HR6RwgzYDVjU2Dv/TC2Cge9XMnpi47FN2CZIK9m66bHfJzFhzCctKbBYsm4w/DKQQHLM90/S/U2MB2IxtFD6Ia/emY0HxX6ALw8jEd0gasFYjWPn7dDvBqz/u2fCw62BnQP02vTU4hLcLj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unN1A-0000000078E-3BeB;
	Sat, 16 Aug 2025 19:56:44 +0000
Date: Sat, 16 Aug 2025 20:56:41 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 20/23] net: dsa: lantiq_gswip: add registers
 specific for MaxLinear GSW1xx
Message-ID: <aKDief99H-oV0Q7y@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add registers needed for MaxLinear GSW1xx family of dedicated switch
ICs connected via MDIO or SPI.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.h | 109 +++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index fd898991180d..e8914480d59e 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -224,6 +224,114 @@
 
 #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
 
+#define GSW1XX_PORTS				6
+/* Port used for RGMII or optional RMII */
+#define GSW1XX_MII_PORT				0x5
+/* Port used for SGMII */
+#define GSW1XX_SGMII_PORT			0x4
+
+#define GSW1XX_SYS_CLK_FREQ			340000000
+
+/* SMDIO switch register base address */
+#define GSW1XX_SMDIO_BADR			0x1f
+#define  GSW1XX_SMDIO_BADR_UNKNOWN		-1
+
+/* GSW1XX SGMII PCS */
+#define GSW1XX_SGMII_BASE			0xd000
+#define GSW1XX_SGMII_PHY_HWBU_CTRL		0x009
+#define  GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM	BIT(0)
+#define  GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN	BIT(3)
+#define GSW1XX_SGMII_TBI_TXANEGH		0x300
+#define GSW1XX_SGMII_TBI_TXANEGL		0x301
+#define GSW1XX_SGMII_TBI_ANEGCTL		0x304
+#define  GSW1XX_SGMII_TBI_ANEGCTL_LT		GENMASK(1, 0)
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_10US	0
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_1_6MS	1
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_5MS	2
+#define   GSW1XX_SGMII_TBI_ANEGCTL_LT_10MS	3
+#define  GSW1XX_SGMII_TBI_ANEGCTL_ANEGEN	BIT(2)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_RANEG		BIT(3)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_OVRABL	BIT(4)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG	BIT(5)
+#define  GSW1XX_SGMII_TBI_ANEGCTL_ANMODE	GENMASK(7, 6)
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_1000BASEX	1
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_PHY	2
+#define   GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC	3
+#define  GSW1XX_SGMII_TBI_ANEGCTL_BCOMP		BIT(15)
+
+#define GSW1XX_SGMII_TBI_TBICTL			0x305
+#define  GSW1XX_SGMII_TBI_TBICTL_INITTBI	BIT(0)
+#define  GSW1XX_SGMII_TBI_TBICTL_ENTBI		BIT(1)
+#define  GSW1XX_SGMII_TBI_TBICTL_CRSTRR		BIT(4)
+#define  GSW1XX_SGMII_TBI_TBICTL_CRSOFF		BIT(5)
+#define GSW1XX_SGMII_TBI_TBISTAT		0x309
+#define  GSW1XX_SGMII_TBI_TBISTAT_LINK		BIT(0)
+#define  GSW1XX_SGMII_TBI_TBISTAT_AN_COMPLETE	BIT(1)
+#define GSW1XX_SGMII_TBI_LPSTAT			0x30a
+#define  GSW1XX_SGMII_TBI_LPSTAT_DUPLEX		BIT(0)
+#define  GSW1XX_SGMII_TBI_LPSTAT_PAUSE_RX	BIT(1)
+#define  GSW1XX_SGMII_TBI_LPSTAT_PAUSE_TX	BIT(2)
+#define  GSW1XX_SGMII_TBI_LPSTAT_SPEED		GENMASK(6, 5)
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_10	0
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_100	1
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_1000	2
+#define   GSW1XX_SGMII_TBI_LPSTAT_SPEED_NOSGMII	3
+#define GSW1XX_SGMII_PHY_D			0x100
+#define GSW1XX_SGMII_PHY_A			0x101
+#define GSW1XX_SGMII_PHY_C			0x102
+#define  GSW1XX_SGMII_PHY_STATUS		BIT(0)
+#define  GSW1XX_SGMII_PHY_READ			BIT(4)
+#define  GSW1XX_SGMII_PHY_WRITE			BIT(8)
+#define  GSW1XX_SGMII_PHY_RESET_N		BIT(12)
+#define GSW1XX_SGMII_PCS_RXB_CTL		0x401
+#define  GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB	BIT(1)
+#define GSW1XX_SGMII_PCS_TXB_CTL		0x404
+#define  GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB	BIT(1)
+
+#define GSW1XX_SGMII_PHY_RX0_CFG2		0x004
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_EQ		GENMASK(2, 0)
+#define   GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF	2
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_INVERT	BIT(3)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN	BIT(4)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN	BIT(5)
+#define  GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT	GENMASK(12, 6)
+#define   GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF	20
+
+/* GSW1XX PDI Registers */
+#define GSW1XX_SWITCH_BASE			0xe000
+
+/* GSW1XX MII Registers */
+#define GSW1XX_RGMII_BASE			0xf100
+
+/* GSW1XX GPIO Registers */
+#define GSW1XX_GPIO_BASE			0xf300
+#define GPIO_ALTSEL0				0x83
+#define GPIO_ALTSEL0_EXTPHY_MUX_VAL		0x03c3
+#define GPIO_ALTSEL1				0x84
+#define GPIO_ALTSEL1_EXTPHY_MUX_VAL		0x003f
+
+/* MDIO bus controller */
+#define GSW1XX_MMDIO_BASE			0xf400
+
+/* generic IC registers */
+#define GSW1XX_SHELL_BASE			0xfa00
+#define  GSW1XX_SHELL_RST_REQ			0x01
+#define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
+/* RGMII PAD Slew Control Register */
+#define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
+#define   RGMII_SLEW_CFG_RX_2_5_V		BIT(4)
+#define   RGMII_SLEW_CFG_TX_2_5_V		BIT(5)
+
+/* SGMII clock related settings */
+#define GSW1XX_CLK_BASE				0xf900
+#define  GSW1XX_CLK_NCO_CTRL			0x68
+#define   GSW1XX_SGMII_HSP_MASK			GENMASK(3, 2)
+#define   GSW1XX_SGMII_SEL			BIT(1)
+#define   GSW1XX_SGMII_1G			0x0
+#define   GSW1XX_SGMII_2G5			0xc
+#define   GSW1XX_SGMII_1G_NCO1			0x0
+#define   GSW1XX_SGMII_2G5_NCO2			0x2
+
 /* Maximum packet size supported by the switch. In theory this should be 10240,
  * but long packets currently cause lock-ups with an MTU of over 2526. Medium
  * packets are sometimes dropped (e.g. TCP over 2477, UDP over 2516-2519, ICMP
@@ -254,6 +362,7 @@ struct gswip_hw_info {
 				 struct phylink_config *config);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
 					      phy_interface_t interface);
+	bool supports_2500m;
 };
 
 struct gswip_gphy_fw {
-- 
2.50.1

