Return-Path: <netdev+bounces-253343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAxJH7EQd2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-253343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:58:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41584A53
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D993006B1D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB1286897;
	Mon, 26 Jan 2026 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Ee4dFrzb"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C302701B8;
	Mon, 26 Jan 2026 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769410731; cv=none; b=r9P5fVL8k0X4jgjTHZq/ThZgXAOyvyTa7IdcjJhj7fy2fi5wLDqKIcHXkC+C9VFXTUbU7U2zf1tv+qPYXboUvuzBOdxtnr3fZWdLlaCUYmwfkvbxRqHGiz7K61CEQ73FRjzxD/Zv1J1r/6jRkeWTS348HGe73i2b37y+LyvNmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769410731; c=relaxed/simple;
	bh=G7kakWzKoJdfWIkRW/LTvwMHjGcXyO2h+RiQoTQFhkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ql3zkPIjjqXIhEOeKuyWlXI9GeY2iECLO8hwQwOfezeHz2qBAbEzxTrKblikg/raFn81y3FNdcCCK2XyB7y8GKHMAV5s1zngXhY9nnnc4oeZK0+kAPCBAAOV5mz7GEFEGYnd37IGlCfcZB4ZzrQhUh9YW8S7Z4FCey5wAEqDtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=Ee4dFrzb; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=Ee4dFrzb;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60Q6vtIO1701722
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 06:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769410675; bh=gMaJQGeaiMBNbt7JqXjuMSeuOOlHtoQ8E1/WT7UT3oc=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=Ee4dFrzbd0jd+avw8aa0QFOjtW8rtrgNawR+dba1mj22eeBZWhHvM+nsLuND18Soz
	 9onHFplZcW4hbAprUWR7iTww26lcghy8POwXYGvwWClbjjhjgRbHuO70VPboos9Fex
	 kXAuyvTi0Dv+ACy3hZU3Gaqy//IuRFq4w15Yl6yw=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60Q6vtEI285636
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 07:57:55 +0100
Received: (nullmailer pid 1334890 invoked by uid 1000);
	Mon, 26 Jan 2026 06:57:54 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v3 2/3] net: phy: air_en8811h: add Airoha AN8811HB support
Date: Mon, 26 Jan 2026 07:57:48 +0100
Message-ID: <20260126065749.1334867-3-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126065749.1334867-1-bjorn@mork.no>
References: <20260126065749.1334867-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-253343-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mork.no:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email,makrotopia.org:email]
X-Rspamd-Queue-Id: CF41584A53
X-Rspamd-Action: no action

The Airoha AN8811HB is mostly compatible with the EN8811H, adding 10Base-T
support and reducing power consumption.

This driver is based on the air_an8811hb v0.0.4 out-of-tree driver
written by "Lucien.Jheng <lucien.jheng@airoha.com>"

Firmware is available in linux-firmware. The driver has been tested with
firmware version 25110702

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
Cc: Lucien.Jheng <lucienzx159@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/air_en8811h.c | 281 ++++++++++++++++++++++++++++++++--
 1 file changed, 270 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 392552692762..05a7023b98a9 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
+ * Driver for the Airoha EN8811H and AN8811HB 2.5 Gigabit PHYs.
  *
- * Limitations of the EN8811H:
+ * Limitations:
  * - Only full duplex supported
  * - Forced speed (AN off) is not supported by hardware (100Mbps)
  *
  * Source originated from airoha's en8811h.c and en8811h.h v1.2.1
+ * with AN8811HB bits from air_an8811hb.c v0.0.4
  *
- * Copyright (C) 2023 Airoha Technology Corp.
+ * Copyright (C) 2023, 2026 Airoha Technology Corp.
  */
 
 #include <linux/clk.h>
@@ -21,9 +22,12 @@
 #include <linux/unaligned.h>
 
 #define EN8811H_PHY_ID		0x03a2a411
+#define AN8811HB_PHY_ID		0xc0ff04a0
 
 #define EN8811H_MD32_DM		"airoha/EthMD32.dm.bin"
 #define EN8811H_MD32_DSP	"airoha/EthMD32.DSP.bin"
+#define AN8811HB_MD32_DM	"airoha/an8811hb/EthMD32_CRC.DM.bin"
+#define AN8811HB_MD32_DSP	"airoha/an8811hb/EthMD32_CRC.DSP.bin"
 
 #define AIR_FW_ADDR_DM	0x00000000
 #define AIR_FW_ADDR_DSP	0x00100000
@@ -31,6 +35,7 @@
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
 #define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
+#define   AIR_AUX_CTRL_STATUS_SPEED_10		0x0
 #define   AIR_AUX_CTRL_STATUS_SPEED_100		0x4
 #define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
 #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
@@ -56,6 +61,7 @@
 #define EN8811H_PHY_FW_STATUS		0x8009
 #define   EN8811H_PHY_READY			0x02
 
+#define AIR_PHY_MCU_CMD_0		0x800b
 #define AIR_PHY_MCU_CMD_1		0x800c
 #define AIR_PHY_MCU_CMD_1_MODE1			0x0
 #define AIR_PHY_MCU_CMD_2		0x800d
@@ -65,6 +71,10 @@
 #define AIR_PHY_MCU_CMD_3_DOCMD			0x1100
 #define AIR_PHY_MCU_CMD_4		0x800f
 #define AIR_PHY_MCU_CMD_4_MODE1			0x0002
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_A		0x00d7
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_B		0x00d8
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_C		0x00d9
+#define AIR_PHY_MCU_CMD_4_CABLE_PAIR_D		0x00da
 #define AIR_PHY_MCU_CMD_4_INTCLR		0x00e4
 
 /* Registers on MDIO_MMD_VEND2 */
@@ -106,6 +116,9 @@
 #define   AIR_PHY_LED_BLINK_2500RX		BIT(11)
 
 /* Registers on BUCKPBUS */
+#define AIR_PHY_CONTROL			0x3a9c
+#define   AIR_PHY_CONTROL_INTERNAL		BIT(11)
+
 #define EN8811H_2P5G_LPA		0x3b30
 #define   EN8811H_2P5G_LPA_2P5G			BIT(0)
 
@@ -129,6 +142,34 @@
 #define EN8811H_FW_CTRL_2		0x800000
 #define EN8811H_FW_CTRL_2_LOADING		BIT(11)
 
+#define AN8811HB_CRC_PM_SET1		0xf020c
+#define AN8811HB_CRC_PM_MON2		0xf0218
+#define AN8811HB_CRC_PM_MON3		0xf021c
+#define AN8811HB_CRC_DM_SET1		0xf0224
+#define AN8811HB_CRC_DM_MON2		0xf0230
+#define AN8811HB_CRC_DM_MON3		0xf0234
+#define   AN8811HB_CRC_RD_EN			BIT(0)
+#define   AN8811HB_CRC_ST			(BIT(0) | BIT(1))
+#define   AN8811HB_CRC_CHECK_PASS		BIT(0)
+
+#define AN8811HB_TX_POLARITY		0x5ce004
+#define   AN8811HB_TX_POLARITY_NORMAL		BIT(7)
+#define AN8811HB_RX_POLARITY		0x5ce61c
+#define   AN8811HB_RX_POLARITY_NORMAL		BIT(7)
+
+#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
+#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
+
+#define AN8811HB_HWTRAP1		0x5cf910
+#define AN8811HB_HWTRAP2		0x5cf914
+#define   AN8811HB_HWTRAP2_CKO			BIT(28)
+
+#define AN8811HB_CLK_DRV		0x5cf9e4
+#define AN8811HB_CLK_DRV_CKO_MASK		GENMASK(14, 12)
+#define   AN8811HB_CLK_DRV_CKOPWD		BIT(12)
+#define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
+#define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
+
 /* Led definitions */
 #define EN8811H_LED_COUNT	3
 
@@ -466,6 +507,39 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 	return 0;
 }
 
+static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
+			      u32 mon2, u32 mon3)
+{
+	u32 pbus_value;
+	int retry = 25;
+	int ret;
+
+	/* Configure CRC */
+	ret = air_buckpbus_reg_modify(phydev, set1,
+				      AN8811HB_CRC_RD_EN,
+				      AN8811HB_CRC_RD_EN);
+	if (ret < 0)
+		return ret;
+	air_buckpbus_reg_read(phydev, set1, &pbus_value);
+
+	do {
+		mdelay(300);
+		air_buckpbus_reg_read(phydev, mon2, &pbus_value);
+
+		if (pbus_value & AN8811HB_CRC_ST) {
+			air_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			phydev_dbg(phydev, "CRC Check %s!\n",
+				   pbus_value & AN8811HB_CRC_CHECK_PASS ?
+					"PASS" : "FAIL");
+			return air_buckpbus_reg_modify(phydev, set1,
+						       AN8811HB_CRC_RD_EN, 0);
+		}
+	} while (--retry);
+
+	phydev_err(phydev, "CRC Check is not ready (%u)\n", pbus_value);
+	return -ENODEV;
+}
+
 static void en8811h_print_fw_version(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
@@ -476,6 +550,63 @@ static void en8811h_print_fw_version(struct phy_device *phydev)
 		    priv->firmware_version);
 }
 
+static int an8811hb_load_firmware(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw1, *fw2;
+	int ret;
+
+	ret = request_firmware_direct(&fw1, AN8811HB_MD32_DM, dev);
+	if (ret < 0)
+		return ret;
+
+	ret = request_firmware_direct(&fw2, AN8811HB_MD32_DSP, dev);
+	if (ret < 0)
+		goto an8811hb_load_firmware_rel1;
+
+	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+				     EN8811H_FW_CTRL_1_START);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = an8811hb_check_crc(phydev, AN8811HB_CRC_DM_SET1,
+				 AN8811HB_CRC_DM_MON2,
+				 AN8811HB_CRC_DM_MON3);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = an8811hb_check_crc(phydev, AN8811HB_CRC_PM_SET1,
+				 AN8811HB_CRC_PM_MON2,
+				 AN8811HB_CRC_PM_MON3);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	ret = en8811h_wait_mcu_ready(phydev);
+	if (ret < 0)
+		goto an8811hb_load_firmware_out;
+
+	en8811h_print_fw_version(phydev);
+
+an8811hb_load_firmware_out:
+	release_firmware(fw2);
+
+an8811hb_load_firmware_rel1:
+	release_firmware(fw1);
+
+	if (ret < 0)
+		phydev_err(phydev, "Load firmware failed: %d\n", ret);
+
+	return ret;
+}
+
 static int en8811h_load_firmware(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -939,6 +1070,41 @@ static int en8811h_leds_setup(struct phy_device *phydev)
 	return ret;
 }
 
+static int an8811hb_probe(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct en8811h_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	phydev->priv = priv;
+
+	ret = an8811hb_load_firmware(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* mcu has just restarted after firmware load */
+	priv->mcu_needs_restart = false;
+
+	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
+	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+
+	ret = en8811h_leds_setup(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Configure led gpio pins as output */
+	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+				      AN8811HB_GPIO_OUTPUT_345,
+				      AN8811HB_GPIO_OUTPUT_345);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int en8811h_probe(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv;
@@ -980,6 +1146,37 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	u32 pbus_value = 0;
+	unsigned int pol;
+	int ret;
+
+	ret = phy_get_manual_rx_polarity(dev_fwnode(dev),
+					 phy_modes(phydev->interface), &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= AN8811HB_RX_POLARITY_NORMAL;
+	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
+				      AN8811HB_RX_POLARITY_NORMAL,
+				      pbus_value);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_get_manual_tx_polarity(dev_fwnode(dev),
+					 phy_modes(phydev->interface), &pol);
+	if (ret)
+		return ret;
+	pbus_value = 0;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= AN8811HB_TX_POLARITY_NORMAL;
+	return air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
+				       AN8811HB_TX_POLARITY_NORMAL,
+				       pbus_value);
+}
+
 static int en8811h_config_serdes_polarity(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -1016,6 +1213,33 @@ static int en8811h_config_serdes_polarity(struct phy_device *phydev)
 				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
 }
 
+static int an8811hb_config_init(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	/* If restart happened in .probe(), no need to restart now */
+	if (priv->mcu_needs_restart) {
+		ret = en8811h_restart_mcu(phydev);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Next calls to .config_init() mcu needs to restart */
+		priv->mcu_needs_restart = true;
+	}
+
+	ret = an8811hb_config_serdes_polarity(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
+			    AIR_LED_MODE_USER_DEFINE);
+	if (ret < 0)
+		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+
+	return ret;
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
@@ -1129,13 +1353,23 @@ static int en8811h_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Get link partner 2.5GBASE-T ability from vendor register */
-	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
-	if (ret < 0)
-		return ret;
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->lp_advertising,
-			 pbus_value & EN8811H_2P5G_LPA_2P5G);
+	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
+		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+		if (val < 0)
+			return val;
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising,
+				 val & MDIO_AN_10GBT_STAT_LP2_5G);
+	} else {
+		/* Get link partner 2.5GBASE-T ability from vendor register */
+		ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA,
+					    &pbus_value);
+		if (ret < 0)
+			return ret;
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising,
+				 pbus_value & EN8811H_2P5G_LPA_2P5G);
+	}
 
 	if (phydev->autoneg_complete)
 		phy_resolve_aneg_pause(phydev);
@@ -1157,6 +1391,9 @@ static int en8811h_read_status(struct phy_device *phydev)
 	case AIR_AUX_CTRL_STATUS_SPEED_100:
 		phydev->speed = SPEED_100;
 		break;
+	case AIR_AUX_CTRL_STATUS_SPEED_10:
+		phydev->speed = SPEED_10;
+		break;
 	}
 
 	/* Firmware before version 24011202 has no vendor register 2P5G_LPA.
@@ -1241,20 +1478,42 @@ static struct phy_driver en8811h_driver[] = {
 	.led_brightness_set	= air_led_brightness_set,
 	.led_hw_control_set	= air_led_hw_control_set,
 	.led_hw_control_get	= air_led_hw_control_get,
+},
+{
+	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
+	.name			= "Airoha AN8811HB",
+	.probe			= an8811hb_probe,
+	.get_features		= en8811h_get_features,
+	.config_init		= an8811hb_config_init,
+	.get_rate_matching	= en8811h_get_rate_matching,
+	.config_aneg		= en8811h_config_aneg,
+	.read_status		= en8811h_read_status,
+	.config_intr		= en8811h_clear_intr,
+	.handle_interrupt	= en8811h_handle_interrupt,
+	.led_hw_is_supported	= en8811h_led_hw_is_supported,
+	.read_page		= air_phy_read_page,
+	.write_page		= air_phy_write_page,
+	.led_blink_set		= air_led_blink_set,
+	.led_brightness_set	= air_led_brightness_set,
+	.led_hw_control_set	= air_led_hw_control_set,
+	.led_hw_control_get	= air_led_hw_control_get,
 } };
 
 module_phy_driver(en8811h_driver);
 
 static const struct mdio_device_id __maybe_unused en8811h_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(EN8811H_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, en8811h_tbl);
 MODULE_FIRMWARE(EN8811H_MD32_DM);
 MODULE_FIRMWARE(EN8811H_MD32_DSP);
+MODULE_FIRMWARE(AN8811HB_MD32_DM);
+MODULE_FIRMWARE(AN8811HB_MD32_DSP);
 
-MODULE_DESCRIPTION("Airoha EN8811H PHY drivers");
+MODULE_DESCRIPTION("Airoha EN8811H and AN8811HB PHY drivers");
 MODULE_AUTHOR("Airoha");
 MODULE_AUTHOR("Eric Woudstra <ericwouds@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.47.3


