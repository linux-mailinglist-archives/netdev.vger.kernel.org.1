Return-Path: <netdev+bounces-288694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GtnuHHVlCWoYYQQAu9opvQ
	(envelope-from <netdev+bounces-288694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24155F912
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 702A9300D170
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A22853F8;
	Sun, 17 May 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeiaIWr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFA23BF9F
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779000690; cv=none; b=Hp7lO3KBYm3hR82tcGWlccds4I92jup4sq2ocKWXptaTLke/+dSzglp9ylU3RBoRgrxhEMFQIan+PVjmYpmP2z3V7CMKzxrQd9SHJRRaPpMuo6x1cj9riU7USb1QYhbhNxdiiofOnaKG4C8FRkYdyoq/FRqoclgShvf6r5p3D30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779000690; c=relaxed/simple;
	bh=I4fZBWo7xeRD5kNgdnR+0yi9rdwTfpFYCgSH+jxnDnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6TboF6U1ZZEu5FkC+/lmvxYeJHor1mttyrCVKy1qIxCYpDu9nvct5b/lGFypiGUribhdXARYjqipP9MWheN8lT/rcbOA3xMUoDM/vgCC94+hml05QgxLYNwq0DUjnr59e4oQk2rpO87EGUcTJwjZcNT8DBFvF5KImToAn+TRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeiaIWr2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso13764755ad.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779000688; x=1779605488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWcF6Tu94ZUMlCG+mLEuiLjfUm9hfl+aSzIjCzu3eIs=;
        b=BeiaIWr2t1aoTQTPsPx2tPbFBDnWeUKlMJviu0RabkwA+kCiBixXkOa+GmaUDi7Q7e
         +ATYk1yeLTTrmPKKseo1mC5xBhk9ubAd4JYaMudh6aook5Imcg5L8xGruUgdlOder9gk
         YaR939YdEMwjHFwxZnQz2vxnrj+JWESz7u/aPmKFIvYvFGcXevxUPKJ1aI+dUuAA4/fH
         jfpivZf7Ztm2UMq0sHlfZHmM97X5hz8Ry0q801Auye8D37pkSYviApugENDkG7AkdVWO
         IWhjwsTQZr+iUaWqqisPTUcAdNOKGrFnvp0FZMaljo08BAExyJNAX6O2G2NcbHel8KVS
         O7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779000688; x=1779605488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWcF6Tu94ZUMlCG+mLEuiLjfUm9hfl+aSzIjCzu3eIs=;
        b=Jcsc7cCdRE27DK85Hz0ahIqdtWAluOCEUvFbmw2ACQSo00PDXoHLpCPf4jceTqOrlh
         ehHq0DBJcFYaS5bPeWvjEeMZ4BM1wYtv8RWltRaSaUtPCvZyQGJymGNxIWp/WC74EehP
         PxBfBMctnbrQJiKWHkBSYDcCS380tMVBoQGKXIQNgQ34p16dV4v93UMm4t9OpqJvPGYq
         EfgWhL2Lrq70QbRS2Ln+lMDzDjvg0Iqfg8NbHCWV8j+FOwsvItAM5H1Xq4UoRjr9tfI7
         73EWJNbRoXrqOU+bEiDRPKmwBnLPYd1x6rFj4qgk39u+ymFZE0nlCPKGGkO1hbf5NVsk
         YDkA==
X-Forwarded-Encrypted: i=1; AFNElJ/6SaWEWSw+sxsfLhhtpe6HF6nvn6WABOKuhNt+JWjWz/s8Igxuz9kXsizsuXzxZQrL70RkpZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsnI7UdAVxczYgwsBgx3uZSaQKrHiGkeZMwa7aLpxgHGb6JqW
	OQFqP5Nz3saSykxjB7q6XTVMGa+oXtkirXvto9Xvw7KFlFSVp+ivgu53
X-Gm-Gg: Acq92OEM7UnyarSfkNlT4XYyHnDiXTFs0rymUb55oMAdDtx2M0JHA9LlHoLbbzI9ZX6
	8ETDIhKoRvzMh1Z+WtYejbSk967IMlm+hz0o9dHTMkbLuAOhnGztOWHfvz9hXoDP9LJeSFYB/OG
	6ljvXJsEp5NXBLIaJ0fGfyzhhWaZXqbblr8cW0aWOhb+UQGvobC2q59+7y4tnVA72Dot53w7LRb
	LF4WSOtEZd4uslsK+/DPf2vQN/M3xXrvalQjOKOa/Gf9tbUzm74pw9OQAQrka9xCI8W6vXz0F35
	XTaN+GXZuWJ7EqgCmvOKWB+CBMKL1UggxiyZo19AnuaXzJKjJLUROm+00dbsPklSkHbGJz0FNxz
	XRwt3YhMYpGkFbar9BmkcXHk+0ZdxixT0Eo0xBqOnOdNujVeIaniMQdBjzZhELjQLEcOJV+WNMy
	1lr/qy3JvMydk54ezVVrQVh0ZId+TFG15T2hfIALnamdwRYa4gWL1vy5CbY6HJzstrxIj3xw9jx
	9+I9OGG/YmQf+Ml0oueAw==
X-Received: by 2002:a17:902:f78a:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2bd7e8f25f5mr115574575ad.23.1779000688026;
        Sat, 16 May 2026 23:51:28 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235c18sm104022015ad.81.2026.05.16.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:51:27 -0700 (PDT)
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
Subject: [PATCH v5] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
Date: Sun, 17 May 2026 14:50:41 +0800
Message-Id: <20260517065041.50155-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE24155F912
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288694-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

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

Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>

---
Changes in v5:
- Move the version changelog out of the commit message;
  keep it only in the patch changelog section.

Changes in v4:
- Correct Fixes tag to 5afda1d734ed.
- Refine an8811hb_probe() error paths: split cleanup into err_dev_free and
  err_dev_create so an unregistered PBUS mdio_device is only freed, while a
  registered one is removed then freed. Simplify with fallthrough pattern.

Changes in v3:
- Register a dedicated mdio_device for the PBUS node (addr+8) in
  an8811hb_probe() and store it in priv->pbusdev, replacing the
  inline addr+8 computation in v2.
- Change __air_pbus_reg_write() to take struct mdio_device * instead
  of struct phy_device *.
- Add an8811hb_remove() to unregister and free the PBUS device.
- Fix error handling in an8811hb_probe() with goto error paths to
  ensure the PBUS device is always cleaned up on failure.

Changes in v2:
- Rewrite commit message: The previous wording was ambiguous,
  as it suggested the MCU remains asserted during the entire
  firmware loading process, rather than a quick reset cycle
  before it starts.
  Clarify that assert and deassert is an immediate soft-reset
  cycle to clear MCU state before firmware loading begins.
- Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
  support").
- Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
  an8811hb_mcu_deassert() to avoid noise during normal boot.

 drivers/net/phy/air_en8811h.c | 143 +++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65..07978979d 100644
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

@@ -1175,10 +1281,21 @@ static int an8811hb_probe(struct phy_device *phydev)
 		return -ENOMEM;
 	phydev->priv = priv;

+	mdiodev = mdio_device_create(phydev->mdio.bus,
+				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
+	if (IS_ERR(mdiodev))
+		return PTR_ERR(mdiodev);
+
+	ret = mdio_device_register(mdiodev);
+	if (ret)
+		goto err_dev_free;
+
+	priv->pbusdev = mdiodev;
+
 	ret = an8811hb_load_firmware(phydev);
 	if (ret < 0) {
 		phydev_err(phydev, "Load firmware failed: %d\n", ret);
-		return ret;
+		goto err_dev_create;
 	}

 	en8811h_print_fw_version(phydev);
@@ -1191,22 +1308,29 @@ static int an8811hb_probe(struct phy_device *phydev)

 	ret = en8811h_leds_setup(phydev);
 	if (ret < 0)
-		return ret;
+		goto err_dev_create;

 	priv->phydev = phydev;
 	/* Co-Clock Output */
 	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
 	if (ret)
-		return ret;
+		goto err_dev_create;

 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
 				      AN8811HB_GPIO_OUTPUT_345,
 				      AN8811HB_GPIO_OUTPUT_345);
 	if (ret < 0)
-		return ret;
+		goto err_dev_create;

 	return 0;
+
+err_dev_create:
+	mdio_device_remove(mdiodev);
+
+err_dev_free:
+	mdio_device_free(mdiodev);
+	return ret;
 }

 static int en8811h_probe(struct phy_device *phydev)
@@ -1561,6 +1685,16 @@ static int en8811h_suspend(struct phy_device *phydev)
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
@@ -1587,6 +1721,7 @@ static struct phy_driver en8811h_driver[] = {
 	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
 	.name			= "Airoha AN8811HB",
 	.probe			= an8811hb_probe,
+	.remove			= an8811hb_remove,
 	.get_features		= en8811h_get_features,
 	.config_init		= an8811hb_config_init,
 	.get_rate_matching	= en8811h_get_rate_matching,
--
2.34.1


