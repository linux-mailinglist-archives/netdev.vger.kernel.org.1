Return-Path: <netdev+bounces-307429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6H5XM9wZVmrKzAAAu9opvQ
	(envelope-from <netdev+bounces-307429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D8753CC5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307429-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307429-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=motor-comm.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 627D3302BBB6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADD37D128;
	Tue, 14 Jul 2026 11:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080037DAA3;
	Tue, 14 Jul 2026 11:12:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027556; cv=none; b=kXnJazsdGAL3JfNTHM/TWQeU6129JtzWuh7dCfbJU0h4coTUmwJxw+acdy7KluB3HlIwjNaPWihy21AucNN3PwqigRGxrOGpKoqXnEH1DNqo+5Y9LepN25uje3MqaVjvPk078AWKb+tVrW9E3I7aUDzfTsdo2XjUNBAYQ0PqTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027556; c=relaxed/simple;
	bh=hVpeOGOSJf67mCYIu3K4PGTbR3S9K7nPBqffHgPxzBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=moKvwH1tGWRAUIwOGOqBkWDVtnVXqOYGvuTxT/u7La2nXM46rqLSxmIZUonSzdHJFvzHodEbJj/9m2CnDVvBMLBfpbo8YkQnA6g6Fau0mx7ZCJAX5eFJZ6+YO/65oY2WcLuTZhR/QH7zqOa+yGdriXEyeZTS9AhtqjItR513bpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.2
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0115021-0.150402-0.838096;FP=14626370780987411698|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iL-EJRN_1784027524;
Received: from localhost.localdomain(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iL-EJRN_1784027524 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 19:12:10 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianmin.wang@motor-comm.com,
	ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Tue, 14 Jul 2026 19:12:03 +0800
Message-Id: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[motor-comm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianmin.wang@motor-comm.com,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jie.han@motor-comm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307429-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A1D8753CC5

Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
2.5G/1000M/100M/10M speed.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 1824 +++++++++++++++++++++++++++++++++--
 1 file changed, 1737 insertions(+), 87 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..e6f93ed4349c 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/8821/8824 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
+ * Author: Kyle <kyle.switch@motor-comm.com>
  */
 
 #include <linux/etherdevice.h>
@@ -12,12 +13,16 @@
 #include <linux/phy.h>
 #include <linux/property.h>
 
+/* used for phy8824 baseaddr */
+#define PHY_BASE_ADDR (1)
+
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
 #define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
 #define PHY_ID_YT8821		0x4f51ea19
+#define PHY_ID_YT8824		0x4f51e8b8
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -29,6 +34,18 @@
  *  ------------------------------------------------------------
  */
 
+/* YT8824 Register Overview
+ *	UTP Register space	|	FIBER Register space
+ *  ------------------------------------------------------------
+ * |	UTP MII			|	FIBER MII	        |
+ * |	UTP MMD			|				|
+ * |	UTP Extended		|	FIBER Extended		|
+ * |	UTP Top Extended	|	FIBER Top Extended	|
+ *  ------------------------------------------------------------
+ * |			Common Top Extended			|
+ *  ------------------------------------------------------------
+ */
+
 /* 0x10 ~ 0x15 , 0x1E and 0x1F are common MII registers of yt phy */
 
 /* Specific Function Control Register */
@@ -375,6 +392,12 @@
 #define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
 #define YT8821_CHIP_MODE_FORCE_BX2500		1
 
+#define YT8824_RSSR_SPACE_MASK			BIT(0)
+#define YT8824_RSSR_FIBER_SPACE			(0x1)
+#define YT8824_RSSR_UTP_SPACE			(0x0)
+#define REG_MII_MMD_CTRL			0x0D
+#define REG_MII_MMD_DATA			0x0E
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -391,8 +414,29 @@ struct yt8521_priv {
 	 * YT8521_RSSR_TO_BE_ARBITRATED
 	 */
 	u8 reg_page;
+	/* YT8824 reg space addr */
+	u8 phy_base_addr;
+	/* top extend reg addr */
+	u8 top_phy_addr;
 };
 
+static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
+				  u16 val)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	struct mii_bus *bus = phydev->mdio.bus;
+
+	return bus->write(bus, priv->top_phy_addr, regnum, val);
+}
+
+static inline int ytphy_top_read(struct phy_device *phydev, u32 regnum)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	struct mii_bus *bus = phydev->mdio.bus;
+
+	return bus->read(bus, priv->top_phy_addr, regnum);
+}
+
 /**
  * ytphy_read_ext() - read a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -431,6 +475,70 @@ static int ytphy_read_ext_with_lock(struct phy_device *phydev, u16 regnum)
 	return ret;
 }
 
+/**
+ * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to read
+ *
+ * NOTE:The caller must have taken the MDIO bus lock.
+ *
+ * returns the value of regnum reg or negative error code
+ */
+static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	ret = ytphy_top_write(phydev, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return ytphy_top_read(phydev, YTPHY_PAGE_DATA);
+}
+
+static int ytphy_read_top_ext_with_lock(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = ytphy_read_top_ext(phydev, regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+/**
+ * ytphy_write_top_ext() - read a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to read
+ *
+ * NOTE:The caller must have taken the MDIO bus lock.
+ *
+ * returns the value of regnum reg or negative error code
+ */
+static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
+			       u16 val)
+{
+	int ret;
+
+	ret = ytphy_top_write(phydev, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return ytphy_top_write(phydev, YTPHY_PAGE_DATA, val);
+}
+
+static int ytphy_write_top_ext_with_lock(struct phy_device *phydev, u16 regnum,
+					 u16 val)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = ytphy_write_top_ext(phydev, regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
 /**
  * ytphy_write_ext() - write a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -521,6 +629,26 @@ static int ytphy_modify_ext_with_lock(struct phy_device *phydev, u16 regnum,
 	return ret;
 }
 
+static int ytphy_write_mmd(struct phy_device *phydev,
+			   u16 device, u16 reg,
+			   u16 value)
+{
+	int ret;
+
+	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device);
+	if (ret)
+		return ret;
+	ret = __phy_write(phydev, REG_MII_MMD_DATA, reg);
+	if (ret)
+		return ret;
+	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device | 0x4000);
+	if (ret)
+		return ret;
+	ret = __phy_write(phydev, REG_MII_MMD_DATA, value);
+
+	return ret;
+}
+
 /**
  * ytphy_get_wol() - report whether wake-on-lan is enabled
  * @phydev: a pointer to a &struct phy_device
@@ -3059,99 +3187,1620 @@ static int yt8821_resume(struct phy_device *phydev)
 	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
 }
 
-static struct phy_driver motorcomm_phy_drvs[] = {
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
-		.name		= "YT8511 Gigabit Ethernet",
-		.config_init	= yt8511_config_init,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.read_page	= yt8511_read_page,
-		.write_page	= yt8511_write_page,
-	},
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8521),
-		.name		= "YT8521 Gigabit Ethernet",
-		.get_features	= yt8521_get_features,
-		.probe		= yt8521_probe,
-		.read_page	= yt8521_read_page,
-		.write_page	= yt8521_write_page,
-		.get_wol	= ytphy_get_wol,
-		.set_wol	= ytphy_set_wol,
-		.config_aneg	= yt8521_config_aneg,
-		.aneg_done	= yt8521_aneg_done,
-		.config_init	= yt8521_config_init,
-		.read_status	= yt8521_read_status,
-		.soft_reset	= yt8521_soft_reset,
-		.suspend	= yt8521_suspend,
-		.resume		= yt8521_resume,
-		.led_hw_is_supported = yt8521_led_hw_is_supported,
-		.led_hw_control_set = yt8521_led_hw_control_set,
-		.led_hw_control_get = yt8521_led_hw_control_get,
-	},
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8522),
-		.name		= "YT8522 100 Megabit Ethernet",
-		.config_aneg	= genphy_config_aneg,
-		.config_init	= yt8522_config_init,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-	},
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
-		.name		= "YT8531 Gigabit Ethernet",
-		.probe		= yt8531_probe,
-		.config_init	= yt8531_config_init,
-		.suspend	= genphy_suspend,
-		.resume		= genphy_resume,
-		.get_wol	= ytphy_get_wol,
-		.set_wol	= yt8531_set_wol,
-		.link_change_notify = yt8531_link_change_notify,
-		.led_hw_is_supported = yt8521_led_hw_is_supported,
-		.led_hw_control_set = yt8521_led_hw_control_set,
-		.led_hw_control_get = yt8521_led_hw_control_get,
-	},
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8531S),
-		.name		= "YT8531S Gigabit Ethernet",
-		.get_features	= yt8521_get_features,
-		.probe		= yt8521_probe,
-		.read_page	= yt8521_read_page,
-		.write_page	= yt8521_write_page,
-		.get_wol	= ytphy_get_wol,
-		.set_wol	= ytphy_set_wol,
-		.config_aneg	= yt8521_config_aneg,
-		.aneg_done	= yt8521_aneg_done,
-		.config_init	= yt8521_config_init,
-		.read_status	= yt8521_read_status,
-		.soft_reset	= yt8521_soft_reset,
-		.suspend	= yt8521_suspend,
-		.resume		= yt8521_resume,
-	},
-	{
-		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
-		.name			= "YT8821 2.5Gbps PHY",
-		.get_features		= yt8821_get_features,
-		.read_page		= yt8521_read_page,
-		.write_page		= yt8521_write_page,
-		.get_wol		= ytphy_get_wol,
-		.set_wol		= ytphy_set_wol,
-		.config_aneg		= genphy_config_aneg,
-		.aneg_done		= yt8821_aneg_done,
-		.config_init		= yt8821_config_init,
-		.get_rate_matching	= yt8821_get_rate_matching,
-		.read_status		= yt8821_read_status,
-		.soft_reset		= yt8821_soft_reset,
-		.suspend		= yt8821_suspend,
-		.resume			= yt8821_resume,
+/**
+ * yt8824_read_page() - read reg page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns current reg space of yt8824 (YT8824_RSSR_FIBER_SPACE/
+ * YT8824_RSSR_UTP_SPACE) or negative errno code
+ */
+static int yt8824_read_page(struct phy_device *phydev)
+{
+	int old_page;
+
+	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+
+	if ((old_page & YT8824_RSSR_SPACE_MASK) == YT8824_RSSR_FIBER_SPACE)
+		return YT8824_RSSR_FIBER_SPACE;
+
+	return YT8824_RSSR_UTP_SPACE;
+};
+
+/**
+ * yt8824_write_page() - write reg page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: The reg page(YT8824_RSSR_FIBER_SPACE/YT8824_RSSR_UTP_SPACE) to write.
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_write_page(struct phy_device *phydev, int page)
+{
+	int old_page;
+	u16 data;
+
+	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
+	data = old_page & (~(0x1));
+	data |= page;
+
+	return ytphy_write_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG, data);
+};
+
+/**
+ * configuration YT8824 to one template test mode.
+ */
+static int yt8824_soft_reset_step1_paged(struct phy_device *phydev,
+					 int reg_space)
+{
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (old_page >= 0) {
+		if (reg_space == YT8824_RSSR_UTP_SPACE) {
+			ret =  ytphy_write_mmd(phydev, 0x1, 0x0084, 0x2000);
+			if (ret < 0)
+				goto err_restore_page;
+		}
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * enable YT8824 serdes isolate.
+ */
+static int yt8824_soft_reset_step2_paged(struct phy_device *phydev,
+					 int reg_space)
+{
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+	if (old_page >= 0) {
+		if (reg_space == YT8824_RSSR_FIBER_SPACE) {
+			ret = __phy_read(phydev, MII_BMCR);
+			if (ret < 0)
+				goto err_restore_page;
+			/* isolation */
+			ret |= BIT(10);
+			ret = __phy_write(phydev, MII_BMCR, ret);
+			if (ret < 0)
+				goto err_restore_page;
+		}
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * do YT8824 UTP softreset.
+ */
+static int yt8824_soft_reset_step3_paged(struct phy_device *phydev,
+					 int reg_space)
+{
+	unsigned int retry = 12;
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+	if (old_page >= 0) {
+		if (reg_space == YT8824_RSSR_UTP_SPACE) {
+			ret = __phy_read(phydev, MII_BMCR);
+			if (ret < 0)
+				goto err_restore_page;
+			ret |= BMCR_RESET;
+			ret = __phy_write(phydev, MII_BMCR, ret);
+			if (ret < 0)
+				goto err_restore_page;
+			do {
+				msleep(50);
+				ret = __phy_read(phydev, MII_BMCR);
+				if (ret < 0)
+					goto err_restore_page;
+			} while ((ret & BMCR_RESET) && --retry);
+			if (ret & BMCR_RESET)
+				goto err_restore_page;
+		}
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * disable YT8824 template test mode.
+ */
+static int yt8824_soft_reset_step4_paged(struct phy_device *phydev,
+					 int reg_space)
+{
+	int old_page;
+	int port;
+	int ret;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (old_page >= 0) {
+		if (reg_space == YT8824_RSSR_UTP_SPACE) {
+			/* normal mode */
+			ret = ytphy_write_mmd(phydev, 0x1, 0x0084, 0x0000);
+			if (ret < 0)
+				goto err_restore_page;
+			if (port == 0 || port == 2) {
+				/* read the calibration val of band after power on,
+				 * * only for recording.
+				 */
+				ret = ytphy_read_ext(phydev, 0x043e);
+				if (ret < 0)
+					goto err_restore_page;
+			}
+		}
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * disable YT8824 serdes isolate.
+ */
+static int yt8824_soft_reset_step5_paged(struct phy_device *phydev,
+					 int reg_space)
+{
+	unsigned int retry = 12;
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+	if (old_page >= 0) {
+		if (reg_space == YT8824_RSSR_FIBER_SPACE) {
+			ret = __phy_read(phydev, MII_BMCR);
+			if (ret < 0)
+				goto err_restore_page;
+			/* disable isolation */
+			ret &= ~BIT(10);
+			/* soft reset */
+			ret |= BMCR_RESET;
+			ret = __phy_write(phydev, MII_BMCR, ret);
+			if (ret < 0)
+				return ret;
+			do {
+				msleep(50);
+				ret = __phy_read(phydev, MII_BMCR);
+				if (ret < 0)
+					goto err_restore_page;
+			} while ((ret & BMCR_RESET) && --retry);
+			if (ret & BMCR_RESET)
+				goto err_restore_page;
+		}
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_soft_reset() - called to issue a PHY software reset
+ * @phydev: a pointer to a &struct phy_device
+ * for internal YT8824
+ * 1) set utp template test mode
+ * 2) utp restart
+ * 3) disable utp template test mode
+ * for external YT8824
+ * 1) set utp template test mode
+ * 2) enable serdes isolate
+ * 3) utp restart
+ * 4) disable utp template test mode
+ * 5) disable serdes isolate
+ * returns 0 or negative errno code
+ */
+static int yt8824_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		ret = yt8824_soft_reset_step3_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds isolation */
+		ret = yt8824_soft_reset_step2_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* utp soft reset */
+		ret = yt8824_soft_reset_step3_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_soft_reset_step5_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * external YT8824 init
+ */
+static int yt8824_config_init_paged(struct phy_device *phydev, int reg_space)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	int ret = 0, old_page;
+	u16 val_1, val_2, val_3, tmp;
+	int port;
+
+	port = phydev->mdio.addr - priv->phy_base_addr;
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (reg_space == YT8824_RSSR_FIBER_SPACE) {
+		/* read efuse */
+		val_1 = ytphy_read_top_ext_with_lock(phydev, 0xa13e);
+		if (val_1 < 0)
+			goto err_restore_page;
+
+		val_2 = ytphy_read_top_ext_with_lock(phydev, 0xa13f);
+		if (val_2 < 0)
+			goto err_restore_page;
+
+		val_3 = ytphy_read_top_ext_with_lock(phydev, 0xa140);
+		if (val_3 < 0)
+			goto err_restore_page;
+
+		if (port == 0) {
+			/* Serdes optimization */
+			ret = ytphy_write_ext(phydev, 0x04be, 0x000d);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x049f, 0x7ded);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x04a9, 0x009f);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* analog CDR */
+			ret = ytphy_write_ext(phydev, 0x0406, 0x0800);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* optimized VCO */
+			ret = ytphy_write_ext(phydev, 0x0438, 0x9024);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0439, 0x00c0);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* optimized PLL lock */
+			ret = ytphy_read_ext(phydev, 0x0429);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret &= ~(BIT(13) | BIT(12));
+			tmp = (val_1 & (BIT(7) | BIT(6)) >> 6);
+			ret |= (tmp << 12);
+			ret = ytphy_write_ext(phydev, 0x0429, ret);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_read_ext(phydev, 0x0441);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret &= ~(BIT(1) | BIT(0));
+			tmp = (val_1 & (BIT(5) | BIT(4)) >> 4);
+			ret |= tmp;
+			ret = ytphy_write_ext(phydev, 0x0441, ret);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_read_ext(phydev, 0x042b);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret &= ~(BIT(13) | BIT(12));
+			tmp = (val_3 & (BIT(1) | BIT(0)));
+			ret |= (tmp << 12);
+			ret = ytphy_write_ext(phydev, 0x042b, ret);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x043a, 0x1006);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x042a, 0xf070);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* cable length threshold */
+			ret = ytphy_write_ext(phydev, 0x0491, 0x007f);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* Serdes training threshold */
+			ret = ytphy_write_ext(phydev, 0x0454, 0x0f14);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0497, 0x0a44);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* digital eye diagram of SerDes */
+			ret = ytphy_write_ext(phydev, 0x04cd, 0x0000);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* Serdes LDO */
+			ret = ytphy_read_ext(phydev, 0x04b5);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret &= ~(BIT(6) | BIT(5) | BIT(4));
+			tmp = (val_2 & (BIT(4) | BIT(3) | BIT(2)) >> 2);
+			ret |= (tmp << 4);
+			ret = ytphy_write_ext(phydev, 0x04b5, ret);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_read_ext(phydev, 0x04b4);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret &= ~(BIT(10) | BIT(9) | BIT(8));
+			tmp = (val_2 & (BIT(7) | BIT(6) | BIT(5)) >> 5);
+			ret |= (tmp << 8);
+			ret = ytphy_write_ext(phydev, 0x04b4, ret);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* optimized Serdes RX */
+			ret = ytphy_write_ext(phydev, 0x04af, 0x45e3);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x048a, 0x0fff);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0408, 0x7c00);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x04d6, 0x007f);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x044f, 0xff08);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* optimized Serdes TX */
+			ret = ytphy_write_ext(phydev, 0x048e, 0x7d00);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x000d, 0x0606);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* Serdes manual config */
+			ret = ytphy_write_ext(phydev, 0x04b0, 0x0804);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x04b1, 0x7074);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x04af, 0x45e7);
+			if (ret < 0)
+				goto err_restore_page;
+
+			/* restart calibration */
+			ret = ytphy_write_ext(phydev, 0x0003, 0x5603);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0492, 0x7fff);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x0492, 0x7f7f);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x2000, 0x0040);
+			if (ret < 0)
+				goto err_restore_page;
+
+			ret = ytphy_write_ext(phydev, 0x2000, 0x0000);
+			if (ret < 0)
+				goto err_restore_page;
+		}
+
+		/* TX preamble padded to 8; RX IPG always > 8 */
+		ret = __phy_write(phydev, 0x0017, 0x2007);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = __phy_write(phydev, 0x0000, 0x9000);
+		if (ret < 0)
+			goto err_restore_page;
+	} else if (reg_space == YT8824_RSSR_UTP_SPACE) {
+		/* power down */
+		ret = __phy_write(phydev, 0x0000, 0x1900);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* pll calibration */
+		ret = ytphy_write_ext(phydev, 0x0001, 0x0003);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa20e, 0x0cba);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa20a, 0xc3f1);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa20c, 0x1620);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2b6, 0x0a00);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2b6, 0x0e00);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimization utp */
+		ret = ytphy_write_ext(phydev, 0x0001, 0x0003);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* enable nibble */
+		ret = ytphy_write_ext(phydev, 0xa003, 0x0003);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* idle err detect enable */
+		ret = ytphy_write_ext(phydev, 0x03d0, 0x5210);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized 2.5G long cable performance */
+		ret = ytphy_write_ext(phydev, 0x0372, 0x5038);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x037c, 0x6068);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0388, 0x00a0);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized fast retrain */
+		ret = ytphy_write_ext(phydev, 0x0359, 0x2140);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x000c, 0xc1a0);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* 2.5G template tone */
+		ret = ytphy_write_ext(phydev, 0xa2fa, 0x0083);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x04e2, 0x0149);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized 2.5G template */
+		ret = ytphy_write_ext(phydev, 0x047e, 0x3939);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x047f, 0x3939);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0480, 0x3939);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0481, 0x3939);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized 1000M cable length threshold */
+		ret = ytphy_write_ext(phydev, 0x0336, 0xab0a);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0340, 0x301d);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* 100M template amplitude */
+		ret = ytphy_write_ext(phydev, 0x046e, 0x4545);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x046f, 0x4545);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0470, 0x4545);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0471, 0x4545);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized 100M cable length threshold */
+		ret = ytphy_write_ext(phydev, 0x030b, 0xaa1d);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x071f, 0x0036);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* 10M template amplitude */
+		ret = ytphy_write_ext(phydev, 0x046b, 0x1818);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x046c, 0x1818);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized 10M cable length threshold */
+		ret = ytphy_write_ext(phydev, 0x0466, 0x6c6c);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0467, 0x6c6c);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0468, 0x6c6c);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0469, 0x6c6c);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimize utp 1000M performance */
+		ret = ytphy_write_ext(phydev, 0x034a, 0xff03);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x00f8, 0xb3ff);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0059, 0x4040);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x032c, 0x5094);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x032d, 0xd094);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x032e, 0x5308);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x0322, 0x6440);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x04d3, 0x5220);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x04d2, 0x5220);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized EMC CS */
+		ret = ytphy_write_ext(phydev, 0x00c8, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x00be, 0x6406);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0x037a, 0x40ff);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* optimized EMC RE */
+		ret = ytphy_write_ext(phydev, 0x0482, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2d5, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2d6, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2d7, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa2d8, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa218, 0x006e);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa01d, 0xfff0);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa01e, 0xfff0);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa01d, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_write_ext(phydev, 0xa01e, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * internal YT8824 init
+ */
+static int yt8824_internal_config_init_paged(struct phy_device *phydev,
+					     int reg_space)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	int old_page;
+	int port = 0;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	port = phydev->mdio.addr - priv->phy_base_addr;
+	ret = ytphy_write_ext(phydev, 0x1, 0x3);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = __phy_write(phydev, MII_BMCR, 0x1900);
+	if (ret < 0)
+		goto err_restore_page;
+	if (port == 0 || port == 2) {
+		ret = ytphy_write_ext(phydev, 0xa20e, 0xcba);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa20a, 0xc3f1);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa20c, 0x1620);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2b6, 0xa00);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2b6, 0xe00);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa003, 0x3);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+	ret = ytphy_write_ext(phydev, 0x3d0, 0x5210);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x372, 0x5038);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x37c, 0x6068);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x388, 0xa0);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x359, 0x2140);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_top_ext(phydev, 0xa2fa, 0x83);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x4e2, 0x149);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 2.5G tempate */
+	ret = ytphy_write_ext(phydev, 0x47e, 0x3939);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x47f, 0x3939);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x480, 0x3939);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x481, 0x3939);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 1000 cable length threshold */
+	ret = ytphy_write_ext(phydev, 0x336, 0xab0a);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x340, 0x301d);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 1000 performance */
+	ret = ytphy_write_ext(phydev, 0x34a, 0xff03);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0xf8, 0xb3ff);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x32c, 0x5094);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x32d, 0xd094);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x32e, 0x5308);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x322, 0x6440);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x4d3, 0x5220);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x4d2, 0x5220);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 100 tempate */
+	ret = ytphy_write_ext(phydev, 0x46e, 0x4545);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x46f, 0x4545);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x470, 0x4545);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x471, 0x4545);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 100 cable length threshold */
+	ret = ytphy_write_ext(phydev, 0x30b, 0xaa1d);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x71f, 0x36);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 10 tempate */
+	ret = ytphy_write_ext(phydev, 0x46b, 0x1818);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x46c, 0x1818);
+	if (ret < 0)
+		goto err_restore_page;
+	/* 10 tempate MAU*/
+	ret = ytphy_write_ext(phydev, 0x466, 0x6c6c);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x467, 0x6c6c);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x468, 0x6c6c);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x469, 0x6c6c);
+	if (ret < 0)
+		goto err_restore_page;
+	/* EMC CS */
+	ret = ytphy_write_ext(phydev, 0xc8, 0xfff);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0xbe, 0x6406);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_ext(phydev, 0x37a, 0x40ff);
+	if (ret < 0)
+		goto err_restore_page;
+	/* EMC RE*/
+	ret = ytphy_write_ext(phydev, 0x482, 0xffff);
+	if (ret < 0)
+		goto err_restore_page;
+	if (port == 0 || port == 2) {
+		ret = ytphy_write_ext(phydev, 0x482, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2d5, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2d6, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2d7, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa2d8, 0x1f1f);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa218, 0x6e);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa01d, 0xfff0);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa01e, 0xfff0);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa01d, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+		ret = ytphy_write_ext(phydev, 0xa01e, 0xffff);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+	ret = ytphy_write_ext(phydev, 0xc, 0x41a1);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_mmd(phydev, 0x1, 0x84, 0x2000);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = __phy_write(phydev, MII_BMCR, 0x9140);
+	if (ret < 0)
+		goto err_restore_page;
+	ret = ytphy_write_mmd(phydev, 0x1, 0x84, 0x0);
+	if (ret < 0)
+		goto err_restore_page;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_config_init() - phy initializatioin
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_init(struct phy_device *phydev)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	int ret;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
+		/* base addr and top addr update for internal YT8824*/
+		priv->phy_base_addr = 0x4;
+		priv->top_phy_addr = 0x9;
+		ret = yt8824_internal_config_init_paged(phydev,
+							YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = yt8824_config_init_paged(phydev, YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+		ret = yt8824_config_init_paged(phydev, YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+	}
+	ret = yt8824_soft_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	netdev_info(phydev->attached_dev,
+		    "%s done, phy addr: %d, phy base addr = %d\n",
+		    __func__, phydev->mdio.addr, priv->phy_base_addr);
+
+	return 0;
+}
+
+static int yt8824_config_intr(struct phy_device *phydev)
+{
+	struct yt8521_priv *priv = phydev->priv;
+	int ret = 0, old_page;
+	int port;
+
+	port = phydev->mdio.addr - priv->phy_base_addr;
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* top ext reg 0xa000
+		 * bit6 int_polarity 1'b0 low active, 1'b1 high active
+		 */
+		ret = ytphy_top_read(phydev, YT8521_REG_SPACE_SELECT_REG);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_top_write(phydev, YT8521_REG_SPACE_SELECT_REG, ret & (~BIT(6)));
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* top ext reg 0xa019
+		 * bit5 intr_phy_pulse_en 1'b0 level, 1'b1 pulse
+		 */
+		ret = ytphy_top_read(phydev, 0xa019);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_top_write(phydev, 0xa019, ret | BIT(5));
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* top ext reg 0xa018 phy_pulse_lth bit14:8
+		 * top ext reg 0xa019 timer_tick_sel bit8:7
+		 * bit14:8 phy_pulse_lth bit8:7 timer_tick_sel   pulse width
+		 * 0x007a		 0x0002		         10ms pulse width
+		 * 0x0064		 0x0001		         1ms pulse width
+		 * 0x004e		 0x0000		         100ms pulse width
+		 * 0x0009		 0x0000		         10ms pulse width(default)
+		 */
+		ret = ytphy_top_read(phydev, 0xa018);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret &= ~0x7f00;
+		ret |= (0x0009 << 8);
+		ret = ytphy_top_write(phydev, 0xa018, ret);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret = ytphy_top_read(phydev, 0xa019);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret &= ~0x180;
+		ret |= (0x0000 << 7);
+		ret = ytphy_top_write(phydev, 0xa019, ret);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* top ext reg 0xa01c interrupt state(Read Clear)
+		 * bit11 PHY3 interrupt 1: phy3 link up/down interrupt happened, 0: interrupt not happened
+		 * bit10 PHY2 interrupt 1: phy2 link up/down interrupt happened, 0: interrupt not happened
+		 * bit9  PHY1 interrupt 1: phy1 link up/down interrupt happened, 0: interrupt not happened
+		 * bit8  PHY0 interrupt 1: phy0 link up/down interrupt happened, 0: interrupt not happened
+		 *
+		 * bit7  PHY3 link down 1: phy3 link down interrupt happened, 0: interrupt not happened
+		 * bit6  PHY2 link down 1: phy2 link down interrupt happened, 0: interrupt not happened
+		 * bit5  PHY1 link down 1: phy1 link down interrupt happened, 0: interrupt not happened
+		 * bit4  PHY0 link down 1: phy0 link down interrupt happened, 0: interrupt not happened
+		 *
+		 * bit3  PHY3 link up 1: phy3 link up interrupt happened, 0: interrupt not happened
+		 * bit2  PHY2 link up 1: phy2 link up interrupt happened, 0: interrupt not happened
+		 * bit1  PHY1 link up 1: phy1 link up interrupt happened, 0: interrupt not happened
+		 * bit0  PHY0 link up 1: phy0 link up interrupt happened, 0: interrupt not happened
+		 */
+		ret = ytphy_top_read(phydev, 0xa01c);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* top ext reg 0xa01a
+		 * bit5 intn_wol_mode 1'b1 enable intn_wol pin output
+		 * bit4 intn_mode 1'b1 enable intn pin output
+		 */
+		ret = ytphy_top_read(phydev, 0xa01a);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret &= ~BIT(5);
+		ret |= BIT(4);
+		ret = ytphy_top_write(phydev, 0xa01a, ret);
+		if (ret < 0)
+			goto err_restore_page;
+
+		/* top ext reg 0xa01b interrupt mask
+		 * bit11 1'b1 enable interrupt signal(link up/down) output to interrupt pin
+		 * bit7 1'b1 enable interrupt signal(link down) output to interrupt pin
+		 * bit3 1'b1 enable interrupt signal(link up) output to interrupt pin
+		 *
+		 * bit10 1'b1 enable interrupt signal(link up/down) output to interrupt pin
+		 * bit6 1'b1 enable interrupt signal(link down) output to interrupt pin
+		 * bit2 1'b1 enable interrupt signal(link up) output to interrupt pin
+		 *
+		 * bit9 1'b1 enable interrupt signal(link up/down) output to interrupt pin
+		 * bit5 1'b1 enable interrupt signal(link down) output to interrupt pin
+		 * bit1 1'b1 enable interrupt signal(link up) output to interrupt pin
+		 *
+		 * bit8 1'b1 enable interrupt signal(link up/down) output to interrupt pin
+		 * bit4 1'b1 enable interrupt signal(link down) output to interrupt pin
+		 * bit0 1'b1 enable interrupt signal(link up) output to interrupt pin
+		 */
+		ret = ytphy_top_read(phydev, 0xa01b);
+		if (ret < 0)
+			goto err_restore_page;
+
+		ret |= (BIT(port + 8) | BIT(port + 4) | BIT(port));
+		ret = ytphy_top_write(phydev, 0xa01b, ret);
+		if (ret < 0)
+			goto err_restore_page;
+	}
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+static irqreturn_t yt8824_handle_interrupt(struct phy_device *phydev)
+{
+	int ret = 0, old_page;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* top ext reg 0xa01c interrupt state(Read Clear)
+	 * bit11 PHY3 interrupt 1: phy3 link up/down interrupt happened, 0: interrupt not happened
+	 * bit10 PHY2 interrupt 1: phy2 link up/down interrupt happened, 0: interrupt not happened
+	 * bit9  PHY1 interrupt 1: phy1 link up/down interrupt happened, 0: interrupt not happened
+	 * bit8  PHY0 interrupt 1: phy0 link up/down interrupt happened, 0: interrupt not happened
+	 * bit7  PHY3 link down 1: phy3 link down interrupt happened, 0: interrupt not happened
+	 * bit6  PHY2 link down 1: phy2 link down interrupt happened, 0: interrupt not happened
+	 * bit5  PHY1 link down 1: phy1 link down interrupt happened, 0: interrupt not happened
+	 * bit4  PHY0 link down 1: phy0 link down interrupt happened, 0: interrupt not happened
+	 * bit3  PHY3 link up 1: phy3 link up interrupt happened, 0: interrupt not happened
+	 * bit2  PHY2 link up 1: phy2 link up interrupt happened, 0: interrupt not happened
+	 * bit1  PHY1 link up 1: phy1 link up interrupt happened, 0: interrupt not happened
+	 * bit0  PHY0 link up 1: phy0 link up interrupt happened, 0: interrupt not happened
+	 */
+	ret = ytphy_read_top_ext(phydev, 0xa01c);
+	if (ret < 0)
+		goto err_restore_page;
+
+	phy_trigger_machine(phydev);
+
+err_restore_page:
+	phy_restore_page(phydev, old_page, ret);
+	if (ret > 0)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
+/**
+ * yt8824_config_aneg()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_aneg_done(struct phy_device *phydev)
+{
+	int link = 0;
+	int old_page;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	link = !!(__phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG) &
+			     YTPHY_SSR_LINK);
+
+	netdev_info(phydev->attached_dev, "%s, phy addr: %d, link_utp: %d\n",
+		    __func__, phydev->mdio.addr, link);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_read_status_paged() -  determines the speed and duplex of one page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: The reg page(YT8824_RSSR_FIBER_SPACE/YT8824_RSSR_UTP_SPACE) to
+ * operate.
+ *
+ * returns 1 (utp or fiber link),0 (no link) or negative errno code
+ */
+static int yt8824_read_status_paged(struct phy_device *phydev, int page,
+				    int *status, int *lpa)
+{
+	int old_page;
+	int ret = 0;
+
+	page &= YT8824_RSSR_SPACE_MASK;
+	old_page = phy_select_page(phydev, page);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = __phy_read(phydev, MII_LPA);
+	*lpa = ret;
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	*status = ret;
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = !!(*status & YTPHY_SSR_LINK);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_read_status(struct phy_device *phydev)
+{
+	int link;
+	int lpa;
+	int val;
+
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+	phydev->link = 0;
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+
+	link = yt8824_read_status_paged(phydev,
+					YT8824_RSSR_UTP_SPACE, &val, &lpa);
+	if (link < 0)
+		return link;
+
+	if (link) {
+		phydev->link = 1;
+		phydev->pause = !!(lpa & BIT(10));
+		phydev->asym_pause = !!(lpa & BIT(11));
+
+		/* update speed & duplex */
+		yt8821_adjust_status(phydev, val);
+	} else {
+		phydev->link = 0;
+		phydev->pause = 0;
+		phydev->asym_pause = 0;
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/**
+ * yt8824_utp_power_on()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_utp_power_on(struct phy_device *phydev,
+			       int reg_space)
+{
+	int old_page;
+	int ret;
+
+	old_page = phy_select_page(phydev, reg_space);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = __phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~BMCR_PDOWN;
+	ret &= ~BMCR_ISOLATE;
+
+	ret = __phy_write(phydev, MII_BMCR, ret);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_utp_power_down()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_utp_power_down(struct phy_device *phydev,
+				 int reg_space)
+{
+	int ret = 0, old_page;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	ret = __phy_read(phydev, MII_BMCR);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = __phy_write(phydev, MII_BMCR, ret | BMCR_PDOWN);
+	if (ret < 0)
+		goto err_restore_page;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_power_on()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ * need WA like softreset
+ */
+static int yt8824_power_on(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		/* utp power on */
+		ret = yt8824_utp_power_on(phydev, YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds isolation */
+		ret = yt8824_soft_reset_step2_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* utp power on */
+		ret = yt8824_utp_power_on(phydev, YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_soft_reset_step5_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int yt8824_resume(struct phy_device *phydev)
+{
+	return yt8824_power_on(phydev);
+}
+
+static int yt8824_power_down(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		/* utp power down */
+		ret = yt8824_utp_power_down(phydev, YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* invalid test mode */
+		ret = yt8824_soft_reset_step1_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds isolation */
+		ret = yt8824_soft_reset_step2_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* utp power down */
+		ret = yt8824_utp_power_down(phydev, YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* normal mode */
+		ret = yt8824_soft_reset_step4_paged(phydev,
+						    YT8824_RSSR_UTP_SPACE);
+		if (ret < 0)
+			return ret;
+
+		/* sds soft reset and disable isolation */
+		ret = yt8824_soft_reset_step5_paged(phydev,
+						    YT8824_RSSR_FIBER_SPACE);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int yt8824_suspend(struct phy_device *phydev)
+{
+	return yt8824_power_down(phydev);
+}
+
+/**
+ * yt8824_config_aneg()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_config_aneg(struct phy_device *phydev)
+{
+	int phy_ctrl = 0;
+	int old_page;
+	int ret;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_UTP_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
+				     MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G,
+				     phy_ctrl);
+	if (ret)
+		goto err_restore_page;
+
+	ret = genphy_config_aneg(phydev);
+	if (ret)
+		goto err_restore_page;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_probe()
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * returns 0 or negative errno code
+ */
+static int yt8824_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct yt8521_priv *priv;
+	u32 phy_base_addr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	/* get base addr and top addr for external YT8824 */
+	if (!device_property_read_u32(dev, "motorcomm,base-address",
+				      &phy_base_addr))
+		priv->phy_base_addr = phy_base_addr;
+	else
+		priv->phy_base_addr = PHY_BASE_ADDR;
+
+	priv->top_phy_addr = priv->phy_base_addr + 4;
+
+	return 0;
+}
+
+static struct phy_driver motorcomm_phy_drvs[] = {
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
+		.name		= "YT8511 Gigabit Ethernet",
+		.config_init	= yt8511_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= yt8511_read_page,
+		.write_page	= yt8511_write_page,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8521),
+		.name		= "YT8521 Gigabit Ethernet",
+		.get_features	= yt8521_get_features,
+		.probe		= yt8521_probe,
+		.read_page	= yt8521_read_page,
+		.write_page	= yt8521_write_page,
+		.get_wol	= ytphy_get_wol,
+		.set_wol	= ytphy_set_wol,
+		.config_aneg	= yt8521_config_aneg,
+		.aneg_done	= yt8521_aneg_done,
+		.config_init	= yt8521_config_init,
+		.read_status	= yt8521_read_status,
+		.soft_reset	= yt8521_soft_reset,
+		.suspend	= yt8521_suspend,
+		.resume		= yt8521_resume,
+		.led_hw_is_supported = yt8521_led_hw_is_supported,
+		.led_hw_control_set = yt8521_led_hw_control_set,
+		.led_hw_control_get = yt8521_led_hw_control_get,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8522),
+		.name		= "YT8522 100 Megabit Ethernet",
+		.config_aneg	= genphy_config_aneg,
+		.config_init	= yt8522_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
+		.name		= "YT8531 Gigabit Ethernet",
+		.probe		= yt8531_probe,
+		.config_init	= yt8531_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.get_wol	= ytphy_get_wol,
+		.set_wol	= yt8531_set_wol,
+		.link_change_notify = yt8531_link_change_notify,
+		.led_hw_is_supported = yt8521_led_hw_is_supported,
+		.led_hw_control_set = yt8521_led_hw_control_set,
+		.led_hw_control_get = yt8521_led_hw_control_get,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8531S),
+		.name		= "YT8531S Gigabit Ethernet",
+		.get_features	= yt8521_get_features,
+		.probe		= yt8521_probe,
+		.read_page	= yt8521_read_page,
+		.write_page	= yt8521_write_page,
+		.get_wol	= ytphy_get_wol,
+		.set_wol	= ytphy_set_wol,
+		.config_aneg	= yt8521_config_aneg,
+		.aneg_done	= yt8521_aneg_done,
+		.config_init	= yt8521_config_init,
+		.read_status	= yt8521_read_status,
+		.soft_reset	= yt8521_soft_reset,
+		.suspend	= yt8521_suspend,
+		.resume		= yt8521_resume,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
+		.name			= "YT8821 2.5Gbps PHY",
+		.get_features		= yt8821_get_features,
+		.read_page		= yt8521_read_page,
+		.write_page		= yt8521_write_page,
+		.get_wol		= ytphy_get_wol,
+		.set_wol		= ytphy_set_wol,
+		.config_aneg		= genphy_config_aneg,
+		.aneg_done		= yt8821_aneg_done,
+		.config_init		= yt8821_config_init,
+		.get_rate_matching	= yt8821_get_rate_matching,
+		.read_status		= yt8821_read_status,
+		.soft_reset		= yt8821_soft_reset,
+		.suspend		= yt8821_suspend,
+		.resume			= yt8821_resume,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8824),
+		.name			= "YT8824 Quad Ports 2.5Gbps Ethernet",
+		.get_features		= yt8821_get_features,
+		.read_page		= yt8824_read_page,
+		.write_page		= yt8824_write_page,
+		.config_intr            = yt8824_config_intr,
+		.handle_interrupt	= yt8824_handle_interrupt,
+		.probe		        = yt8824_probe,
+		.config_aneg		= yt8824_config_aneg,
+		.aneg_done		= yt8824_aneg_done,
+		.config_init		= yt8824_config_init,
+		.read_status		= yt8824_read_status,
+		.soft_reset		= yt8824_soft_reset,
+		.suspend		= yt8824_suspend,
+		.resume			= yt8824_resume,
 	},
 };
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821/8824 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
+MODULE_AUTHOR("Kyle");
 MODULE_LICENSE("GPL");
 
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
@@ -3161,6 +4810,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8824) },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1


