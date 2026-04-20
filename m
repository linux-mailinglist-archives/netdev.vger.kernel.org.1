Return-Path: <netdev+bounces-279832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC0UAxdV5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7942F978
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F2AF35F1914
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14526F2AF;
	Mon, 20 Apr 2026 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZrgNrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161F273D8D
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692797; cv=none; b=BqmlhQWLwJgg2Kr8oJXFAVrCWWczi8pIZQmKYUUbDeEuuL/UZ4EDb3VvSdnRsfqGiMaf0msezmc29Yp2mNTMTHEsrN7zp60x8kR5Q1UEoyfBYZFK9wxxUYHqz47oGd+gWnJZm84HoxME8t+4lgynufuFpyL9GIJt7CmUTzSa2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692797; c=relaxed/simple;
	bh=TAKQch0k/gLwdRuXwgsAoqCakhctFdtQD4H4GTZg2Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fbup5qpnOOn1oxHDHKly8FGQOQFF/p3iZjKhWgfz40zCp6qAWMlkRa7goT/W+U6IHO6TPv9gvpZi8PpYijUplHh9WpWno6Ikmj2CIWKQT7xWm79VBRheksRbRWnlDS/L01a7NQ71qQNWbAsGiUuq0MDqpa2vtZY8a3wQJZ5E/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZrgNrb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b45cb89f7eso22254245ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692796; x=1777297596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuyqHPkXyghrYyVcdsd1ZI8DKLjrheorYnay2citIT8=;
        b=WDZrgNrbLG69LwNjvc6jI0KvofvhfEeTtVg+/XDnM6jOQ3fu5j92HKgT0h6Ekekmj8
         YvCEnVqx/pqkuFA7BBz7uUj2NY2VDq9Rv4FGly/7MbeqWSH6kXRdSMBqr8R7nxHUCznp
         8JGA4jbO33cZ8O7GY5VP6cjHEJgxA7oqx/nw1Rmyj6K0c7pCN3YSrExVzQvRTg4T0iYI
         G+KQPXiB6I2QdEKNU70zRNwIYV7c4D97IERdi0mN9eGJy7J0hd0j279eXiJpg21q4cVI
         J7+20s8ZkafRBTu9nY7jAsdM0A8tPO8FiVuSi5hrWg+Ac4OLjWWEm5V/YdFSGw/V4iCz
         ddvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692796; x=1777297596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuyqHPkXyghrYyVcdsd1ZI8DKLjrheorYnay2citIT8=;
        b=KnvY8XaWZEWQ8mLVabI0Ruz1pOIvAKL5na7F93cxqjYilky97wrw2keacXuJ026V97
         9qatsyyM19/GrI0vk+baDKGkU/5gn98z0NCKcw5ER/DKoTZhK4qcsyClpExl/eHdfjT4
         NsVNbHC57Ho3KzWTe5UWkYB78pr4YOTcKEmGePTgG9mJCref5JlKKGGht+H1Biq+hP2r
         LWRYrpX13fvQoy5zisN5BUqQQGPW+NCUO9IRZ/yLWF+J3AvxhI2jqpo0Mc+aQe3ZV6Xi
         IMVg+GOXawp3qEc4F8xH+Yk7vJ+yk6Uq0yWbOyYwOpup/pldSrAHTq1v3QcMBOoMbSv+
         ssww==
X-Forwarded-Encrypted: i=1; AFNElJ9y2bc9LFzZRymuscPChoTEToGt8exwzb1H18r4Wo3DLOJqiYSUJNwitQb/M6/DRtYfCuqX708=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCKcDT33bCzXo+4GhzWQy8aPoXbTSQtGQYWJbcn9xG7tucA/T
	8qVrIxDRiIBz8Aa1OWz0oHXo2Y4L8xDRn0vq5UcmZrga48cngRl1z5lK
X-Gm-Gg: AeBDietFVqv3HHyC33VoDwO6ZHRyuIsn/uyfFDvMtxolsY2zb1vKW/R0I1Wicw5ZVB9
	5NcwJmdLBXewtFSJTHJbhsWI52gndFb550o6yecXzm0KWeeoD0R2if+V+58afF3IwsotmkSZ6TV
	bvxAtngdBAdxrDZ0Pxmb+lU5AcevJ8kRATtI+gS9YvbXZ3Hlek4b6+YQGpCo+iGweR+kyg0wgPi
	OSXtXLBdgBa+RzJwlbAfmmwjr1pHJpriUQYkOVwwP2By46to+vaZk8+eKKzsH+spRvCSJqsSSjn
	yRcN/Z6+4sPBFk/azAxbhb1ixy73HCBJZKIUT6Gysi740yZuNVuU5gFJcSAaSsS7kzHo/Te/7bv
	oK3FytJW1gSCWFPPU7nydmJzxaxLag/7SVX6ypwTJ60gr5PhIPlkdFJ3lN92t51ZfWTnInPvWMr
	+3KUlr73kpZdT7bpys2hJIsDe8GN/pyNHY1OC7VRn0OUNIqCu2s6xBQD73LbpzuJCxkRb/uLSAb
	K0HRr4TyWdZ3EMcKHCSClSLXx4ZBmwu
X-Received: by 2002:a17:902:c9c4:b0:2b2:712c:61be with SMTP id d9443c01a7336-2b5f9ed0b48mr97460005ad.18.1776692795592;
        Mon, 20 Apr 2026 06:46:35 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa494e1sm101960195ad.35.2026.04.20.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:46:35 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no
Cc: ericwouds@gmail.com,
	frank-w@public-files.de,
	daniel@makrotopia.org,
	lucien.jheng@airoha.com,
	albert-al.lee@airoha.com,
	"Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
Date: Mon, 20 Apr 2026 21:45:06 +0800
Message-Id: <20260420134506.35164-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279832-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89E7942F978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
Assert the MCU (hold it in reset) and immediately deassert (release)
via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
through a registered mdio_device at PHY-addr+8.

Add __air_pbus_reg_write() as a low-level helper taking a struct
mdio_device *, create and register the PBUS mdio_device in
an8811hb_probe() and store it in priv->pbusdev, then implement
an8811hb_mcu_assert() / _deassert() on top of it. Add
an8811hb_remove() to unregister the PBUS device on teardown. Wire
both calls into an8811hb_load_firmware() and en8811h_restart_mcu()
so every firmware load or MCU restart on AN8811HB correctly sequences
the reset control registers.

Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
---
Changes in v3:
- Register a dedicated mdio_device for the PBUS node (addr+8) in
  an8811hb_probe() and store it in priv->pbusdev, replacing the
  inline addr+8 computation in v2.
- Change __air_pbus_reg_write() to take struct mdio_device * instead
  of struct phy_device *.
- Add an8811hb_remove() to unregister and free the PBUS device.
- Fix error handling in an8811hb_probe() with goto error paths to
  ensure the PBUS device is always cleaned up on failure.

 drivers/net/phy/air_en8811h.c | 142 +++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65..1fe2d8bec 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -170,9 +170,21 @@
 #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
 #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
 
+#define AN8811HB_MCU_SW_RST		0x5cf9f8
+#define   AN8811HB_MCU_SW_RST_HOLD		BIT(16)
+#define   AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
+#define AN8811HB_MCU_SW_START		0x5cf9fc
+#define   AN8811HB_MCU_SW_START_EN		BIT(16)
+
+/* MII register constants for PBUS access (PHY addr + 8) */
+#define AIR_PBUS_ADDR_HIGH		0x1c
+#define AIR_PBUS_DATA_HIGH		0x10
+
 /* Led definitions */
 #define EN8811H_LED_COUNT	3
 
+#define EN8811H_PBUS_ADDR_OFFS	8
+
 /* Default LED setup:
  * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
  * GPIO4 <-> LED1  On: Link detected at 2500 or 1000 Mbps
@@ -201,6 +213,7 @@ struct en8811h_priv {
 	struct clk_hw		hw;
 	struct phy_device	*phydev;
 	unsigned int		cko_is_enabled;
+	struct mdio_device	*pbusdev;
 };
 
 enum {
@@ -254,6 +267,31 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
 }
 
+static int __air_pbus_reg_write(struct mdio_device *mdiodev,
+				u32 pbus_reg, u32 pbus_data)
+{
+	int ret;
+
+	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
+			      upper_16_bits(pbus_reg));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
+			      (pbus_reg & GENMASK(15, 6)) >> 6);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
+			      (pbus_reg & GENMASK(5, 2)) >> 2,
+			      lower_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
+			       upper_16_bits(pbus_data));
+}
+
 static int __air_buckpbus_reg_write(struct phy_device *phydev,
 				    u32 pbus_address, u32 pbus_data)
 {
@@ -570,10 +608,67 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	return ret;
 }
 
+static int an8811hb_mcu_assert(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_RST,
+				   AN8811HB_MCU_SW_RST_HOLD);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_START, 0);
+	if (ret < 0)
+		goto unlock;
+
+	msleep(50);
+	phydev_dbg(phydev, "MCU asserted\n");
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static int an8811hb_mcu_deassert(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_START,
+				   AN8811HB_MCU_SW_START_EN);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(priv->pbusdev, AN8811HB_MCU_SW_RST,
+				   AN8811HB_MCU_SW_RST_RUN);
+	if (ret < 0)
+		goto unlock;
+
+	msleep(50);
+	phydev_dbg(phydev, "MCU deasserted\n");
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 static int an8811hb_load_firmware(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = an8811hb_mcu_assert(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = an8811hb_mcu_deassert(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
@@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
 {
 	int ret;
 
+	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
+		ret = an8811hb_mcu_assert(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = an8811hb_mcu_deassert(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
@@ -1166,6 +1271,7 @@ static int en8811h_leds_setup(struct phy_device *phydev)
 
 static int an8811hb_probe(struct phy_device *phydev)
 {
+	struct mdio_device *mdiodev;
 	struct en8811h_priv *priv;
 	int ret;
 
@@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
 		return -ENOMEM;
 	phydev->priv = priv;
 
+	mdiodev = mdio_device_create(phydev->mdio.bus,
+				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
+	if (IS_ERR(mdiodev))
+		return PTR_ERR(mdiodev);
+
+	ret = mdio_device_register(mdiodev);
+	if (ret) {
+		mdio_device_free(mdiodev);
+		return ret;
+	}
+	priv->pbusdev = mdiodev;
+
 	ret = an8811hb_load_firmware(phydev);
 	if (ret < 0) {
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
-		return ret;
+		goto error;
 	}
 
 	en8811h_print_fw_version(phydev);
@@ -1191,22 +1309,27 @@ static int an8811hb_probe(struct phy_device *phydev)
 
 	ret = en8811h_leds_setup(phydev);
 	if (ret < 0)
-		return ret;
+		goto error;
 
 	priv->phydev = phydev;
 	/* Co-Clock Output */
 	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
 	if (ret)
-		return ret;
+		goto error;
 
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
 				      AN8811HB_GPIO_OUTPUT_345,
 				      AN8811HB_GPIO_OUTPUT_345);
 	if (ret < 0)
-		return ret;
+		goto error;
 
 	return 0;
+
+error:
+	mdio_device_remove(priv->pbusdev);
+	mdio_device_free(priv->pbusdev);
+	return ret;
 }
 
 static int en8811h_probe(struct phy_device *phydev)
@@ -1561,6 +1684,16 @@ static int en8811h_suspend(struct phy_device *phydev)
 	return genphy_suspend(phydev);
 }
 
+static void an8811hb_remove(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+
+	if (priv->pbusdev) {
+		mdio_device_remove(priv->pbusdev);
+		mdio_device_free(priv->pbusdev);
+	}
+}
+
 static struct phy_driver en8811h_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
@@ -1587,6 +1720,7 @@ static struct phy_driver en8811h_driver[] = {
 	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
 	.name			= "Airoha AN8811HB",
 	.probe			= an8811hb_probe,
+	.remove			= an8811hb_remove,
 	.get_features		= en8811h_get_features,
 	.config_init		= an8811hb_config_init,
 	.get_rate_matching	= en8811h_get_rate_matching,
-- 
2.34.1


