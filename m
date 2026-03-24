Return-Path: <netdev+bounces-271250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H8TBSThwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:08:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09A31B365
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D344A304008F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD5340282;
	Tue, 24 Mar 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPav99De"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD773783AC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379203; cv=none; b=hSaitmMdoNfA+eEKdgzwz8sH8pV3PfimrDp2PzrftkglJtUxrMcsKiSE+ZQFdiCUMZ0/dcsG/41MygDAUcvAe63TGVPG4Uue8Pn9eG5yf1MMo6yif74MjijcE9xfeBS/5uKgaFbqK7WaUIEW3BIXE/VdnZfMyWxPA9hQlnTsMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379203; c=relaxed/simple;
	bh=5GDKSSP8pB5qaJNDZS96MivX8NZANRKUOJJCkZA0mMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kn7Q5fKoRayIXMYxX4Tx2WaDZc3Zh2gYbGTl8InZ+OBw/tIgujppu6u1yt19p/AI5uSZZlDjU4CnDeGVpox3ac9ggcMm2SU7+WuQ9aMPWiql0aBLV/dNaFMD4nAeNOYzNRLOLmEBjADX/YdiILqzU0XI9l6Y2M7lSzChJQKMZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPav99De; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b6d9c981so111259f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379200; x=1774984000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2oqbOVBQMg4GotjWppJzcaNGyfKsWk7lWEpLVMBJAU=;
        b=hPav99DeZVNaj62lpMxvq1cO/CK16H+xx8bRYBkuinRz9VvYULkytLfM0R4SjW2o54
         mTuis6WwkVqZqhUs3O9LsvUmauEsYmuiJg/R00htNnUdfP63jlb1entJhgrIktBMUKqK
         HP8la7xd7GIGY/r1+Jb7xgIDHxZYGaT5UqkrQFBRmg/YbUHrA+GfYde5GcO358HX+Snr
         QtAuGeAu3WOvsvZfgDYhw5PF+DamjYdPN7rye0YQSyYLdL9T2fsgJlPgb1B04dgoK7pq
         DYc3IKFggUZtEPVFiqqaD6fDxC8t9i71cYN1haNJuV2gLZBN11FGTixZjaNNHbgGWtdv
         b8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379200; x=1774984000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2oqbOVBQMg4GotjWppJzcaNGyfKsWk7lWEpLVMBJAU=;
        b=I1Tgi0gqkbf28YCGtBMNhkrEWN6jUs0OdThrszBruAVeqxLzLwf/G39AB97Y930r//
         +OC2qq4v5Fi1YJqAURB91BW/K76BqJdfq+tHvUUOF7xVjFkQxZzOJKnkbmEjyZ1T6ONQ
         XIjMT1UE84jJr5P03r1jKn7p6T3CYT3CCdpIkvFIYRnLH/+XVH24HhRaFbhAO1InSmNV
         9bwsp5bFhhuxF5AwxQzUh9vWmEfwKYic1ygXbrosvuRf0Hwuoq1Nc0l6is3GEl1M9N3c
         TzkT+OkRAJz04/hQwPcv8/gDGqOlHccGtQujvAnr6wKi3DlEi+VY5dcw+J/nmfFtY9OG
         jdnw==
X-Gm-Message-State: AOJu0YyyYWk0dd46KNP/AiQOH7ZTarmjC66wCc53Y4BuavZN1Ugl9/Q0
	IqNtVZwqrWZy44fJEJCWEeNNwNU+2i1TGv9GY6Q3n5UgGB+h6OG9PSX2wxhsiw==
X-Gm-Gg: ATEYQzySgQtDwitNYLxZ9Eyi+6TIH1vqAzcodC3Q6NAbeSqsI7nhi+fil+/vujHSGEl
	Pk2RUmobDTndqsYVJYcR21v8ATKOVYBXBLn/o5jtoJwqCtNmXAc2oztInCec8UIW2BAiHwlm3l4
	ZR+e/CAuAszYhQWbF7PgAEOLAsbJTymiu9LoF932Q8oPl+vQY77+0Ix0XxfCoT57eiTlYgcxB3A
	VsH5xNg9RMyQ56OB0nU+aKUxVo3xIrD7AfmOo5RbwuBHhll53meRDqIQUPHEwMhXe+1s3buBdRe
	pWNQM/n4Y65loQg54ba0ZRrC/tX9wvQdVVLGfRv2n8Kup4w2tXTFOG8/4S2LvrBj7xgbKx8XkUi
	IDR2nYRGsM696sDMdrce0BwMuCf0M58yp0tVlb88cFbbwxgqnef3JIpOZGS2dHKfdnEBaBmQeFh
	VdSRmwIRkXUSp/Q/gq43254BHHYDBJ0Z259s+F3ZegTdcWWA2PnNm7Xgz8lkJ4sacdV/VeI9Yif
	iOmv8L6iCYDy+ZV
X-Received: by 2002:a05:6000:3c5:b0:439:c153:ae3d with SMTP id ffacd0b85a97d-43b805265e9mr6436648f8f.6.1774379200248;
        Tue, 24 Mar 2026 12:06:40 -0700 (PDT)
Received: from 6850u.ox.dtw.sh (cpc69060-oxfd26-2-0-cust335.4-3.cable.virginm.net. [82.6.49.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm35985435f8f.31.2026.03.24.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:06:39 -0700 (PDT)
From: Daniel Wagner <wagner.daniel.t@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	bcm-kernel-feedback-list@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Wagner <wagner.daniel.t@gmail.com>
Subject: [PATCH net-next v2] net: phy: bcm84881: add BCM84891/BCM84892 support
Date: Tue, 24 Mar 2026 19:06:01 +0000
Message-ID: <20260324190601.1616343-1-wagner.daniel.t@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271250-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD09A31B365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
BCM84881, sharing the register map and most callbacks. They add USXGMII
as a host interface mode.

bcm8489x_config_init() is separate from bcm84881_config_init(): it
allows only USXGMII (the only host mode available on the tested
hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
tested platform. Does not recur on ifdown/ifup, cable events, or
link-partner advertisement changes, so config_init is sufficient.

For USXGMII, read_status() skips the 0x4011 host-mode register: it
returns the same value regardless of negotiated copper speed (USXGMII
symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
standard C45 AN resolution.

Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
running OpenWrt, where the MDIO controller driver is currently
OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.

Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
---
Changes in v2:
- Separate bcm8489x_config_init() that allows only USXGMII. v1 also
  allowed USXGMII for BCM84881 (which doesn't support it), and put
  SGMII/2500BASEX/10GBASER in the 8489x possible_interfaces which I
  can't substantiate on this hardware. (Russell)
- LPOWER clear moved from config_aneg to config_init. Characterized on
  hardware: boot-time only, does not recur on ifdown/ifup, cable
  events, or link-partner advertisement changes. (Russell)
- Dropped LED support; will figure out the PHY LED framework approach
  for bicolor speed-mapped LEDs as a follow-up. (Russell, Andrew)
- PHY_ID_MATCH_MODEL(). (Russell, Andrew)
- is_bcm8489x() helper removed; the interface mode now suffices as a
  discriminator in read_status since only the 8489x config_init allows
  USXGMII.

v1: https://lore.kernel.org/netdev/20260324152503.1522071-2-wagner.daniel.t@gmail.com/

 drivers/net/phy/bcm84881.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index d7f7cc44c5..f114212dd3 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -54,6 +54,21 @@ static int bcm84881_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int bcm8489x_config_init(struct phy_device *phydev)
+{
+	__set_bit(PHY_INTERFACE_MODE_USXGMII, phydev->possible_interfaces);
+
+	if (phydev->interface != PHY_INTERFACE_MODE_USXGMII)
+		return -ENODEV;
+
+	/* MDIO_CTRL1_LPOWER is set at boot on the tested platform. Does not
+	 * recur on ifdown/ifup, cable events, or link-partner advertisement
+	 * changes; clear it once.
+	 */
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+				  MDIO_CTRL1_LPOWER);
+}
+
 static int bcm84881_probe(struct phy_device *phydev)
 {
 	/* This driver requires PMAPMD and AN blocks */
@@ -201,6 +216,15 @@ static int bcm84881_read_status(struct phy_device *phydev)
 		return 0;
 	}
 
+	/* BCM84891/92 on USXGMII: the host interface mode doesn't change
+	 * with copper speed (USXGMII symbol replication; the MAC receives
+	 * the negotiated copper speed, not 10G, so no rate adaptation).
+	 * Skip 0x4011; phy_resolve_aneg_linkmode() above already set the
+	 * speed. Only bcm8489x_config_init() allows USXGMII.
+	 */
+	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII)
+		return genphy_c45_read_mdix(phydev);
+
 	/* Set the host link mode - we set the phy interface mode and
 	 * the speed according to this register so that downshift works.
 	 * We leave the duplex setting as per the resolution from the
@@ -256,6 +280,26 @@ static struct phy_driver bcm84881_drivers[] = {
 		.config_aneg	= bcm84881_config_aneg,
 		.aneg_done	= bcm84881_aneg_done,
 		.read_status	= bcm84881_read_status,
+	}, {
+		PHY_ID_MATCH_MODEL(0x35905080),
+		.name		= "Broadcom BCM84891",
+		.inband_caps	= bcm84881_inband_caps,
+		.config_init	= bcm8489x_config_init,
+		.probe		= bcm84881_probe,
+		.get_features	= bcm84881_get_features,
+		.config_aneg	= bcm84881_config_aneg,
+		.aneg_done	= bcm84881_aneg_done,
+		.read_status	= bcm84881_read_status,
+	}, {
+		PHY_ID_MATCH_MODEL(0x359050a0),
+		.name		= "Broadcom BCM84892",
+		.inband_caps	= bcm84881_inband_caps,
+		.config_init	= bcm8489x_config_init,
+		.probe		= bcm84881_probe,
+		.get_features	= bcm84881_get_features,
+		.config_aneg	= bcm84881_config_aneg,
+		.aneg_done	= bcm84881_aneg_done,
+		.read_status	= bcm84881_read_status,
 	},
 };
 
@@ -264,9 +308,11 @@ module_phy_driver(bcm84881_drivers);
 /* FIXME: module auto-loading for Clause 45 PHYs seems non-functional */
 static const struct mdio_device_id __maybe_unused bcm84881_tbl[] = {
 	{ 0xae025150, 0xfffffff0 },
+	{ PHY_ID_MATCH_MODEL(0x35905080) },
+	{ PHY_ID_MATCH_MODEL(0x359050a0) },
 	{ },
 };
 MODULE_AUTHOR("Russell King");
-MODULE_DESCRIPTION("Broadcom BCM84881 PHY driver");
+MODULE_DESCRIPTION("Broadcom BCM84881/BCM84891/BCM84892 PHY driver");
 MODULE_DEVICE_TABLE(mdio, bcm84881_tbl);
 MODULE_LICENSE("GPL");
-- 
2.47.3


