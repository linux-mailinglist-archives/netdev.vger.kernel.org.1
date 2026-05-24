Return-Path: <netdev+bounces-291147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c7EXC12dEmq21gYAu9opvQ
	(envelope-from <netdev+bounces-291147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9DB5C18AB
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18DE300D338
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F738D3FD;
	Sun, 24 May 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZLjI4YC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A038D3E8
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779604824; cv=none; b=kEV7mddrAlgbcz0T8GbfoiOuRPnRNY23Fin3W44Xh1zWazfsF/SVZij18w6yOc9PYOCaAznuVX+Z9F9KLyEaV3Ge2xX1SgBS6nEisC8RRr4+vditH4L7ZPtjzGDBlUcSVDFufHFgyzi1jxOghUjaX0nLHeh9pAmV8K2Sa3H1sbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779604824; c=relaxed/simple;
	bh=P04mb+mT20DBKkOXv2/0VC5JxFWirmaqXYsC4UcBdPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFIp3vzWrpj8Mo2buuZIo4Q2r5cQEbviD0I8UZEK4ZhF8y6Hc4MaND79+oTsZINF5a9jjyAyTINvuMNt+T3l4iPtWN7Uq76KtxIoVvehhLcykdapusMHqgY03LNu3+olABfXjDohAXynPjcGwz96ErBlG6Ih47WXf1Mrn0nmlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZLjI4YC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso21332a91.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779604822; x=1780209622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KsHEd7B27KwA9RN6kTdcgaeBrmbNHF/YD5HQcWnwWk=;
        b=dZLjI4YC/Fiw0Q4PkQOtx6jT5xoTEYqvSgPkX89c/edADz4ac9OG4+WLCa0kj4a8s/
         BOV9enCOpsdlVxnfrSSQgBlqXbbXUna+uISjDurqSjYOn++bmksdo9ur6V6o7kGm6WFQ
         poiIVnUjo27BmGeLAv0v6+UoQg+iL/djo4uIf1KPO+Nkcux/MAjm4oZMYyFTREUX6Vr/
         VAW2WgBdOXeT/zOFkPYJAse7l6ap8XTeYRD0lspATLAXvseFD27YCq4QE8/QSuXdrjJS
         YDEru7FObq9tdpO7z7k8kMY3vwTXVFKwdSQz5KrMfymMpQNHWbG4kSRf5po7M6inLXf4
         GYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779604822; x=1780209622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KsHEd7B27KwA9RN6kTdcgaeBrmbNHF/YD5HQcWnwWk=;
        b=WzqdJziwagzWzsQUC2ylFxzq0rOucXcsOZPJyMcQ/TEKK0EBhZRsOgKbxuIil21HiJ
         r37kzqDpAkShBsSd2kpP2PF8Mpfw4SRnTClZWy/ylNKDN+R/wKAh3KiQDMusshC47ToB
         LVgk/CZzUthVHKg7tjrbP2cs2Xk8wKWJHpJxj7/Nq8lSiklTXMuz5QKA6cnHg8Bn2QA/
         5pp14ZC94wyT+ZCT0D1gYSyMMwI1DhTbA4A2NKY37yKgZkTcWW80BinGHLc80QD9datS
         7vmtuN7sellJQjEmEzYnb+Zx45Bz3ZGFEa2kyeqPIw7tHSWzPzlss+asMlXtMxcIfaNt
         oMEA==
X-Forwarded-Encrypted: i=1; AFNElJ8ezujooJKKyTKkCgSmoE8s8VikJj14PyczBfTow4yDYgJp+JSbDgPB5lLLbr7vbI2BMQjdtSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3n0jTBkA7mjgCpleV5g/9kO6NQUd/8Ze6/rQHnV6ZMeX5EHy
	3fU0QrjW2l+c3QZBB4q08RUF8YRxnU8x60VESmnevs5XqgLF9Cild91Q
X-Gm-Gg: Acq92OERJM0ISFT7TMA/SDaJd/NB7gdOP7ZsgTMOEeEm/KMyElNNvG79YOrHKNqBNLe
	thKUsNzQstEsluUSPKumI51n3Mys2jz2EewhQXrer7w+iJFNTzVYNVY580UKrhbH4+Wq0mrolHY
	c0bfUIeECUkkkwCp5bnBMCfc3I1gtk9Jh7bNBfELjP6IRiMUY7c1tQE4X2bCNvED6Ug/vmmKtOO
	YPyrgToPuQZStjx93e/6VdE1g1hUDwIYiaI0WjzeJQQPUxWvp25MNleRMQGN5rGa8hS5temugUL
	XsoNy1sBevi5pQYhqev3lRV4mCQwpHerXnT5YTmsvvcz6FXhPMJYZCxl6D3LvjLbBpJ5QoXD/9M
	hJ36WWnjGXG78hOfcWTIza3BtXD3V2D782AX82R6S6j0XqZ7z1Tcd/p0eYogwO0KBSGU8eNTnoU
	Kbc6VVxHrziyWpLzGorcC1ZZSEgfXUUxxRit7CHVjs1ohHuRgOq2ViTba9iPx4LTgOakZOjeLnG
	avCfNzQG37CSxyctoISMg==
X-Received: by 2002:a17:90b:5385:b0:366:346a:6891 with SMTP id 98e67ed59e1d1-36a67836e6fmr10002511a91.16.1779604822056;
        Sat, 23 May 2026 23:40:22 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm5745659a91.15.2026.05.23.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 23:40:21 -0700 (PDT)
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
Subject: [PATCH v6] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
Date: Sun, 24 May 2026 14:39:15 +0800
Message-Id: <20260524063915.47961-1-lucienzx159@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291147-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A9DB5C18AB
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

Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>

---
Changes in v6:
- Include <linux/bitfield.h> and use FIELD_GET() in __air_pbus_reg_write()
  for PBUS register index extraction.
- Introduce AIR_PBUS_REG_ADDR_HIGH_MASK and AIR_PBUS_REG_ADDR_LOW_MASK
  macros to avoid open-coded bit operations.
- Add an8811hb_probe() comment documenting PHY strap constraints
  (addr 8-15), explaining why PHY addr + 8 stays within the valid
  0-31 MDIO address range.

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

 drivers/net/phy/air_en8811h.c | 153 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65..a86129ce6 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -17,6 +17,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy-common-props.h>
 #include <linux/firmware.h>
+#include <linux/bitfield.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
 #include <linux/unaligned.h>
@@ -170,9 +171,23 @@
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
+#define AIR_PBUS_REG_ADDR_HIGH_MASK	GENMASK(15, 6)
+#define AIR_PBUS_REG_ADDR_LOW_MASK	GENMASK(5, 2)
+
 /* Led definitions */
 #define EN8811H_LED_COUNT	3

+#define EN8811H_PBUS_ADDR_OFFS	8
+
 /* Default LED setup:
  * GPIO5 <-> LED0  On: Link detected, blink Rx/Tx
  * GPIO4 <-> LED1  On: Link detected at 2500 or 1000 Mbps
@@ -201,6 +216,7 @@ struct en8811h_priv {
 	struct clk_hw		hw;
 	struct phy_device	*phydev;
 	unsigned int		cko_is_enabled;
+	struct mdio_device	*pbusdev;
 };

 enum {
@@ -254,6 +270,31 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
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
+			      FIELD_GET(AIR_PBUS_REG_ADDR_HIGH_MASK, pbus_reg));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
+			      FIELD_GET(AIR_PBUS_REG_ADDR_LOW_MASK, pbus_reg),
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
@@ -570,10 +611,67 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
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
@@ -662,6 +760,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
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
@@ -1166,6 +1274,7 @@ static int en8811h_leds_setup(struct phy_device *phydev)

 static int an8811hb_probe(struct phy_device *phydev)
 {
+	struct mdio_device *mdiodev;
 	struct en8811h_priv *priv;
 	int ret;

@@ -1175,10 +1284,28 @@ static int an8811hb_probe(struct phy_device *phydev)
 		return -ENOMEM;
 	phydev->priv = priv;

+	/*
+	 * The AN8811HB PHY address is restricted to 8-15 (decimal),
+	 * depending on the board hardware strapping.
+	 * This means the PBUS address is only in the range 16-21 (decimal),
+	 * so we do not need to handle the case
+	 * where the PBUS address exceeds 31 (decimal).
+	 */
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
@@ -1191,22 +1318,29 @@ static int an8811hb_probe(struct phy_device *phydev)

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
@@ -1561,6 +1695,16 @@ static int en8811h_suspend(struct phy_device *phydev)
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
@@ -1587,6 +1731,7 @@ static struct phy_driver en8811h_driver[] = {
 	PHY_ID_MATCH_MODEL(AN8811HB_PHY_ID),
 	.name			= "Airoha AN8811HB",
 	.probe			= an8811hb_probe,
+	.remove			= an8811hb_remove,
 	.get_features		= en8811h_get_features,
 	.config_init		= an8811hb_config_init,
 	.get_rate_matching	= en8811h_get_rate_matching,
--
2.34.1

