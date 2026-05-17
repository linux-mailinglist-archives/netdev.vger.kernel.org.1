Return-Path: <netdev+bounces-288692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDcQGMdjCWoCYAQAu9opvQ
	(envelope-from <netdev+bounces-288692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B957A55F8DD
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD90301326C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FF2ECE91;
	Sun, 17 May 2026 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9Y3Dlt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D92E3709
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779000253; cv=none; b=DD3jqDOnJEOTDBC/F92xbXBbcx1Urz9QfMvah+pg5yFAo6neMfB636SlhciZBqNHtVKNvv3M0ZXRmioK2QgGNwEnHAX7SfxZiLGWciuCPwZEAjZUJZQpBDoPgGw49d13xPkGbnhdxeAF1aoD1kVtD8tk1jW3PqiwtuGLppl43L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779000253; c=relaxed/simple;
	bh=RwSUPSYjkY1cUvGLe5DyiI+pjLR9+PiahUB66ndc6tM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVbg93CE0l4thiHJ7acRxLd9Jg1xpCC3J7gL5mrH7SkUi/hB6D/BbIDSSXL+C/H/uEh5enBPvroWFDGTaM05omuxa+juuI0HR+jkb9ZP3decYAdGVEu21MpFyDmqlmlp8sx+IjMhkNHr1H4Q1O3rLj2tc1IEFg+N4d5baT6atag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9Y3Dlt7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b45cb89f7eso7574555ad.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779000250; x=1779605050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8+aK4KjsrGqCk09naIC6bjaMAElcC5s623RKlmDu/A=;
        b=K9Y3Dlt7EB7d2irQbw/GRB70z4dfowOvTFhK6jYS1D8dg/Vzi1yEXT6DAsBUk1+Abb
         PaqE8opfOdarKQEpLVVyE0WvCAaCA9V1CZeWJX0eMFfNYlme6PT2NmhEzanGmcLsV7TA
         3zqlNE2SJbYdMfwJSbVp0gBLvcL+OzTQnRZ8UxZgQBvCzs9ecdSv4qKn+UusGgE/LK8z
         mlVtQ0J2RB5+5jTpWNB9Os+nS7Go6JyHOjvm0DEvOAtpPY/FfTaTE52oPXHvElJyGNnr
         k+rKf1kFO8CV1Qj4P4xYJseCHBAHp2t+q/XciNnWnosAhQEBqyof4gGsa9m0p67+eYY3
         3c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779000250; x=1779605050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8+aK4KjsrGqCk09naIC6bjaMAElcC5s623RKlmDu/A=;
        b=YTZSFEjbxso269AiC5yO53I31XPPOGSOU8853QQkPEyA0E5GAw6NII1fUVncqniCsp
         wGwCpODcEBYfIfODeY2D18KSqdhd42XJ/ZagRirmiiUp8mvEjn16VwQaKXsQ8VLV9iph
         6hzYYgCL+LnbzrLrWzIhICPnoYUsF0Zk8r2SY4tplHBHcTITju6Fpum9lU8/okzv5d3O
         zjFn/vBs5+90AFYPCwCHbCizl1i9yR5TDTuaufWqhT3ovzcSdxFF/v8h5dPU+CimUGbI
         gGysh89KT/nVSnarwU3vd0v3valDa0Z1j0WqfpbIrnRoYHEYxLuUTJ4eCINwbyfMNi7a
         M8qg==
X-Forwarded-Encrypted: i=1; AFNElJ8gsbjI9Q9cIE38VwQiD7fChKtLg1AP1M4NK86fPHfdhiPw3U2ksu/fGtsFF88Q3d12ZuztI1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kbj8DcubEyS4uS106HbCMIZwkI5ES9SLf9h0NV0rUqIn+w/d
	J8ZEMv5UXMU/TJy8MfE0/eqK+8sHGG4AMEq74nzXhE0AuQbUrgxdMaOeYlWmBw==
X-Gm-Gg: Acq92OFf7JmP8zj1ufoY4Re49xG/XRuH56JJSU7qyGLCgGfn99nO2B7d+gYnPdNpIjK
	xSxe69sAJlpBOFBVu/SyzL2Eqj723jjpMPeA13oJmbX+8QHCQ+UFOgwUlKx+rL+6nb7eB5G+4jR
	wAVtHDLMTKY5at3VkCkBpX86rRnNKDjhv28oMt1F4uqWyCEi9lJaOYA3qNiA1pRW5SLhUB/AHQq
	K6owCaz/pZasfUHeh1kdH0uibuT7KI52rtCsFlrI0ZD6VqjrVR2Syjegd9HcjZFJzaAGHpsHtZ7
	8kmnQs3m4GF7AScNznZ0vgDVnZfYd0zoNirm0WiwY3Np4NSdTx4l6gQvr+9Lss/TTgX4fqUGMB+
	m3xg/y0L5cYmZoaDrQARTtkclrzc9Xw9/uYY1FtDpQCtZyOGqVrt8/ot1HNqpjKruvUKLdQRl92
	s86WiS1cGwjQ6+kCOWy4mrczHhOr7ZiilHe7U5r6xCF3CZzBNHi+0yFYoSQCci3uxj4Tvm3Fp6Q
	CiblkYT71LoNidcItyu8A==
X-Received: by 2002:a17:903:2f90:b0:2bd:a413:6b07 with SMTP id d9443c01a7336-2bda422adfcmr56200645ad.8.1779000250224;
        Sat, 16 May 2026 23:44:10 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f287sm146578695ad.24.2026.05.16.23.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:44:09 -0700 (PDT)
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
Subject: [PATCH v4] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
Date: Sun, 17 May 2026 14:42:54 +0800
Message-Id: <20260517064254.49216-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B957A55F8DD
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288692-lists,netdev=lfdr.de];
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
---
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


