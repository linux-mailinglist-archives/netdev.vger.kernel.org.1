Return-Path: <netdev+bounces-288360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKG1MZNOB2rBxgIAu9opvQ
	(envelope-from <netdev+bounces-288360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA8553F90
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ECC4334C810
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16A3FBB7E;
	Fri, 15 May 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyQwKX3C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC553FBB66
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861920; cv=none; b=ZS04iVxJMrH1zRfqI3Qqgsmn7lpKtTPVDbot9BpqUNCfWJ9dgW+HSM91rT9uMa3TNNzyqexngpW0A3Qu9OXWVdfRrKbvsq7nl0NIy3cdU93fMfB0aePLZ2hiWMFBpj6nuCzhHcrY//Xj8OLRYg4QTkx84gHcAGKGfxMWgNmYSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861920; c=relaxed/simple;
	bh=7661PnX5ar30DmK9RYPqrmIl5SLmNk8IKrGpXiqOTtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDzeWKu2ZcZdqlCqyE64TE744yrNkwCgf1mjXuoMPlQza9eymuBAqnkHgoHWlpxw064dlMGQ2ka1ZiJw2UG1UYUabBKojQnlleZRkn7grFuS20Bhh+uxq5y4Trx2H3UXTsIrSp7S6X79g7szLIjv8X+Lj8YdupmO8UQNxwell7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyQwKX3C; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7e23defbso5537970f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861917; x=1779466717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmR8La+e76BqsIVrUChJEpw5jXSOx7pQ44UqgPaW+Ic=;
        b=VyQwKX3CQNpSyT6EhbDhowIWEHr8e4EdfEQerZaYvpUV3IS+fW5VR+JGZM2sqacvVU
         FhSvm8hmlIY7M0xS4A68D8C6eVq7dUtkHRg0Iouv+nCR9HETYVkFwki00QZghC9vZOuM
         4OVt4Zv4ad4H0TKUtCxe+McVWwB4sr4c6isaRv0bR1LCRS7eMx2jlpqWAaxAYUyoK6Gm
         0WVgVLSxKQwfRRN/c+8qbWtuwLxwvqbf3IzY5KzbjR8/W37i4h1gYGhM6HWW1KCelyHb
         QYKkZV2jT4zwwT51P4mlc/bvXeasRcASmJ6iE917bPmgiDoDv8fVP+CzP61kmh9sUgp4
         6Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861917; x=1779466717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmR8La+e76BqsIVrUChJEpw5jXSOx7pQ44UqgPaW+Ic=;
        b=S33JGlF0gzqfo79ViXm65sybYXafe4Kbyv7d3pOUIzqz/MtRoXsWgSav+CV+xl+79y
         P/1N7cHS1Vm0XTfJD1FWLJQkqLRx0SwKQtfwcztoN1zbavPVRD2NamR5/uLJvoI/w8CU
         +W1lkf+Hh0oOvIrFxqqjIsuEaIre0IgNBqMDm7O29MrMszP0px1t9C+a72AtZYMH6QE7
         qEGk/n/Miza2+UARKXMlpSv+GmDfjahnE16Xknv4S86awQ9SUpO4XTOrx9hMBqgPpTxN
         ybKE9xvN2siE68WnmyLFWpAKVfVa5j1hvTBOUvNEisyPif4F481+LZewtZwjTFOeAUNf
         ZDEw==
X-Gm-Message-State: AOJu0YwanT982G5mr5itmsZ2X1S8oGSyzWrgMRD3GJmioCdfamA0CNkA
	Mrft6/T5XU9CXJrZDxJp0nYZF6arGxlqaFhYxcCl1msx72jEA3cDbBymjsxqE2IM
X-Gm-Gg: Acq92OGsoAW1pVWhS7kpOCw+vDyF4AGCTuSWJntYH0gAspXRc/VP92RzcFT3ISakjDU
	wXCBhL0rShd6WKR5IKKDirmspgciW5Xn6ZIvkIyX/9RY+0KHSJml7puBheT6mujTNl8z01zIbYl
	wCB6Pbq4ziDfvmQ0XB8GTgUWBIO9vA/FVxE7GbZ7PiE9rKej/OZVp3YwX6100XoTgag60Zu0xow
	0LT6rGowC1yHaylylQGhpNnfm6jeOgzrhLua8ao7rvB9uNlKmteMPiEbI85D7IiyPPGZYNiZjsS
	IvYuCXeFW0EZo0Sj+eFVDTlRXjRLD0PhNEc3KgSFsv+Cy+y79y5wupaUJpQqJOexqsgWq3m2Jtw
	0SCM2PXDYHs8/kXDf1Zex9YwND9+MH8LC7Pb4skiIv7xXCiS0kpyT68ZCHCjODm86vRintW2cja
	yDcUxLFGblRqexDAzqarF6ek0d7kxY+hBete6c5MvKzExPkqz0XfnnnqmPx8ap+zLmlA==
X-Received: by 2002:a5d:5f90:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-45e5c5be273mr6552925f8f.11.1778861916929;
        Fri, 15 May 2026 09:18:36 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm15063653f8f.11.2026.05.15.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:18:36 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Fri, 15 May 2026 18:18:34 +0200
Message-ID: <20260515161834.23628-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260515115527.17241-1-petr.wozniak@gmail.com>
References: <20260515115527.17241-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80AA8553F90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mork.no,lunn.ch,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288360-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
vendor/part-number combination.  This works for modules that genuinely
implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
that share the same EEPROM strings without having such a bridge.

The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
00:00:00, making OUI-based differentiation impossible.  With
MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
appears:

  sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol

Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
RollBall protocol constants are already defined.  After sending the
unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
genuine RollBall bridge asserts CMD_DONE within that window; modules
without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
sfp_i2c_mdiobus_create() treats -ENODEV as no PHY and falls back to
MDIO_I2C_NONE without creating an MDIO bus.

Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
the probe path; genuine RollBall modules continue to work as before.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---

Changes since v1:
  - Moved probe from sfp.c into i2c_mii_probe_rollball() in mdio-i2c.c;
    all RollBall protocol logic now lives in one place.
  - Removed duplicated #define constants from sfp.c.
  - sfp_i2c_mdiobus_create() handles -ENODEV from mdio_i2c_alloc()
    and falls back to MDIO_I2C_NONE instead of failing the module probe.
  - OEM/SFP-10G-T-I uses sfp_fixup_rollball (no CC byte correction
    needed for a media converter).
 drivers/net/mdio/mdio-i2c.c | 59 +++++++++++++++++++++++++++++++++----
 drivers/net/phy/sfp.c       |  8 ++++-
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index da2001e..1973fda 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -352,6 +352,52 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
 	return 0;
 }
 
+/*
+ * Probe for a RollBall I2C-to-MDIO bridge by issuing CMD_READ and waiting
+ * ~70 ms for CMD_DONE.  Genuine RollBall bridges respond within that window.
+ * Modules that share the same EEPROM vendor/part strings but have no bridge
+ * (e.g. RTL8261BE pure copper media converter) never assert CMD_DONE, so
+ * -ENODEV is returned for them.
+ */
+static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+{
+	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
+	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
+	u8 cmd_addr   = ROLLBALL_CMD_ADDR, result;
+	struct i2c_msg msgs[2];
+	int ret;
+
+	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[0].flags = 0;
+	msgs[0].len   = sizeof(data_buf);
+	msgs[0].buf   = data_buf;
+	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[1].flags = 0;
+	msgs[1].len   = sizeof(cmd_buf);
+	msgs[1].buf   = cmd_buf;
+
+	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
+	if (ret)
+		return ret;
+
+	msleep(70);
+
+	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[0].flags = 0;
+	msgs[0].len   = 1;
+	msgs[0].buf   = &cmd_addr;
+	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len   = 1;
+	msgs[1].buf   = &result;
+
+	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
+	if (ret)
+		return ret;
+
+	return result == ROLLBALL_CMD_DONE ? 0 : -ENODEV;
+}
+
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
 	struct i2c_msg msg;
@@ -372,10 +418,10 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 	ret = i2c_transfer(i2c, &msg, 1);
 	if (ret < 0)
 		return ret;
-	else if (ret != 1)
+	if (ret != 1)
 		return -EIO;
-	else
-		return 0;
+
+	return i2c_mii_probe_rollball(i2c);
 }
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
@@ -399,9 +445,10 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
 		if (ret < 0) {
-			dev_err(parent,
-				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
-				ret);
+			if (ret != -ENODEV)
+				dev_err(parent,
+					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
+					ret);
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 218c775..ce745b6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -599,7 +599,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("TP-LINK", "TL-SM410U", sfp_quirk_oem_2_5g),
 
 	SFP_QUIRK_F("ETU", "ESP-T5-R", sfp_fixup_rollball_cc),
-	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
+	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
@@ -802,6 +803,11 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
 	int ret;
 
 	i2c_mii = mdio_i2c_alloc(sfp->dev, sfp->i2c, sfp->mdio_protocol);
+	if (PTR_ERR_OR_ZERO(i2c_mii) == -ENODEV) {
+		/* RollBall probe found no bridge: no PHY on this module */
+		sfp->mdio_protocol = MDIO_I2C_NONE;
+		return 0;
+	}
 	if (IS_ERR(i2c_mii))
 		return PTR_ERR(i2c_mii);
 
-- 
2.51.0


