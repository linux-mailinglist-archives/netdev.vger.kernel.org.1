Return-Path: <netdev+bounces-272120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF4gLadUxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:45:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CB337D1E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6D0B3132535
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA1405ABB;
	Thu, 26 Mar 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK8n6N3k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5824035DA
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539389; cv=none; b=YLgKJmT7rOPOUDPVxQ4B0d9Ir+UngNi+NeSB3iMK84dkshxlPpvcYiWIT/nrmGDNMTgxAV3PkIraiOTsi2o9HaM1NHj32x3+yz9csUo23ENH13wFlFqdepcS3jvsFHsKw9/VPxWNHX9O5qXSak9XSJc+M8GSQRuSFfdHj8papNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539389; c=relaxed/simple;
	bh=Cxub38LQEZnp/P8NSeKse7/8OQRjXv7T6cJ+v2kaZxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=in6DhSLGKCpt7puxr3IZK6QaBAYtBssg4YleSxcK7ApUjv1mI8ejGnGKMIoFxUhG9Gl2t3LixJ6ctKqObRIHr5CVkB8XQeGii9H4dQftYvp3GZLtx8dlAy6jR/jDMQBT8d4x7C0fiMTgtEUPjvvhxrMv3cHXLqmJXx1QSi+DIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK8n6N3k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0c8362d93so3073765ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539387; x=1775144187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0r5aAUsCjDNb058qyitmFhLHtK1PctaqpFNaeMzbcgw=;
        b=lK8n6N3kJIC45dch3on+HmU0HruVwZaLFxAQDbx7llBH6SEEujsiox2lC9Z0VYYpsM
         Rmt4FHxWbbLb613W6eCcI99QnZWxvIOAFGrDpaWrQFGJcyKisqmkACKLA4oQB7x9Hn6+
         vvH2SkIQ+pqPqgxW4ghcOA0sr7LYD2dAUtgmkJ9Y0EjVvAov5tX9DqMhOPnXwTVNOQjj
         BqsZlKjb2SKYOcB5xNOKteGxUUbnlMGmLok/hl1P3yY8SPBC0A2LFLnBiBSeUdgW6mdx
         aU2m+cWX9rjJXrwVKSl5rVfOskbCtgDEGxdAnR8MZHOPUcUPzjqdCr1TSeBK3cN67Bhr
         gQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539387; x=1775144187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r5aAUsCjDNb058qyitmFhLHtK1PctaqpFNaeMzbcgw=;
        b=dKt7hHbJJHL0Y7Rs9MjOFgwO5ckwflOWZn7oFK0xppkmqIkXzckicl/2/1o4N2Unl2
         +qfZLAtuaEp+Z/t8BrYIHO4ylqnCzTEzirjCfp7qRr2qjZsg2JL5X0rNaZASkD6WLkjy
         OFwP74gVtEYeAwTlkji5cDtxCROBSXwDYASzmSTxn0dEw4UYPzlYTyZpWruxYxZQifVk
         WE/kEEQt7GH28aDkTpRp23fWYEfHELArS1ovSaRsFom1v7ildKrd2PnO0OwibOuQhTuB
         SXr55BPTO56b1n26u3zIlvivL9W9qlSs/uDF3OdQozmbn9YGtM817zKwjPQoyTD5m3cv
         lrmg==
X-Forwarded-Encrypted: i=1; AJvYcCXDOIua6syrjQqoqUeS39lrOjOd3H0NicA0QIztQhAF5OvyrRiO1uZ1HC5VeXsGmo65Rwu7gL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbohiPoLAIvcPjYDHGP9k5tGB+zzEsx4SemnrNcgLnxHzXyzd0
	GmTteNdtu1Hg2465RElxuRhpMu1SwXkP57iOdkBn59PuG4IAkNiDR0t8
X-Gm-Gg: ATEYQzwgIwV2lfK4ibTpoZ8j/45m/ZII3wMZLluyk1UOQHlafQMLLlEyAUcju2JrAdO
	dDlX/LFABl3rEu+POIUDV2ZBUTDYDuWnUb+G55oJ5c+u7Gu84PGksWu6OXKIf0flE8E6lTju7QZ
	oWTlNxm/yZgVPRQvhUOWMmV0qYyrYKGzw/mcFmNVijEZwgOSFmTsFpC9TvookEFpMs3mlkzIRg1
	5NexFCzwYrbPfT5My7dk9fQvZA32svgOLRIPsX9IAca3ntFJV9LWC1gN4FAtFQMDh/ZzOSjGS2p
	+NN2bfzszzgQeMIn0BA8yvE+VfHZx6oOQOnGTWuFu2Mw+GvnUwfijaAPuNbiaLgJDG2C9j2va4k
	sPUOqr2h1bgSOsO6SFyxR1tjPyjk3IE5hQV4Mekf01uR4lQHjNUk4MI7tApF5kLo5DITM/7zDYV
	bWw9iQZRCbxM/Pq0vBz82+OxQh5O9+anGYkoy23Pmg2b348oQmFy2+kntCJPaHRG1UMBCnomE9u
	0TUn6EolMJ1gw455Gl4Jg==
X-Received: by 2002:a17:903:38c5:b0:2ae:c7e6:a13b with SMTP id d9443c01a7336-2b0b0a0fc4emr86705225ad.4.1774539387366;
        Thu, 26 Mar 2026 08:36:27 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc90c845sm31688835ad.77.2026.03.26.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:36:26 -0700 (PDT)
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
	"Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU assert/deassert support
Date: Thu, 26 Mar 2026 23:35:18 +0800
Message-Id: <20260326153518.8387-1-lucienzx159@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272120-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 654CB337D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
Assert the MCU (hold it in reset) and immediately deassert (release)
via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
path.  This clears the MCU state before the firmware loading sequence
starts.

Add __air_pbus_reg_write() as a low-level helper for this access, then
implement an8811hb_mcu_assert() / _deassert() on top of it.  Wire both
into an8811hb_load_firmware() and en8811h_restart_mcu() so every
firmware load or MCU restart on AN8811HB correctly sequences the reset
control registers.

Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
---
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

 drivers/net/phy/air_en8811h.c | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65caa..01fce1b93618 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -170,6 +170,16 @@
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

@@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
 }

+static int __air_pbus_reg_write(struct phy_device *phydev,
+				u32 pbus_reg, u32 pbus_data)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int pbus_addr = phydev->mdio.addr + 8;
+	int ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
+			      upper_16_bits(pbus_reg));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
+			      (pbus_reg & GENMASK(15, 6)) >> 6);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 2)) >> 2,
+			      lower_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
+			      upper_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __air_buckpbus_reg_write(struct phy_device *phydev,
 				    u32 pbus_address, u32 pbus_data)
 {
@@ -570,10 +610,65 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	return ret;
 }

+static int an8811hb_mcu_assert(struct phy_device *phydev)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
+				   AN8811HB_MCU_SW_RST_HOLD);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
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
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
+				   AN8811HB_MCU_SW_START_EN);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
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
--
2.34.1


