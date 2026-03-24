Return-Path: <netdev+bounces-271130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNslBWqwwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:40:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFF3183AB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D5D5309CAC2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12FE406263;
	Tue, 24 Mar 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5CcpmHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEC406278
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366009; cv=none; b=Tob2tavt2Xn+KQ9vDPKNX53o45QBFJwrG09xNzRnnRvCdn2ON3EWlF+U34mjGV1iel0xrAtAYiINKjlEcVLzQaZR66yzXYt/xxW9e/jse7+iprEeLRf/Q9kcNvAKxnVRFlb8kFZS+P1tr+69hI999e8EzHhAJWLk0jwteWx6Bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366009; c=relaxed/simple;
	bh=h1Cgxv/MbBovDfmYb+eCNblRESOnhBD3a8P7TeNNyfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIKmyYPB4cQkIZUEpje4K8PgCQ/S819HoGpUP8jS7+zW97zGYCN4UcguZlSCOBFhN7b9npPkENTIeX2pB1sSqHGsm5d0C9upVl9U7U3I+cwR/FT9mpKYrH016vXsmO7lYuNK7yklqoyg/Dtx8K/4SHoon5XYcQvOCI5a17XuIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5CcpmHZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so35280265e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366004; x=1774970804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9X7xuJzrFVA61UqL5AZpBVCs0izcfwIXnfX+VPlxo0=;
        b=Q5CcpmHZwFaVMzwn+fvMfy8UvFAjfQ5ubqaiyAL6ZM/HMZfRiwqIY7wk8POyTUtRsF
         VIikOVvtVqDRjPNPr3eBjqXRLRCBG07OWjk/+I2r080s9SSGKzRaufdhzMgRhFTtkdAO
         jniJVhbjHg17O+11EIrXF3qnHsejCX/63LS3VcSbl0i+vtSZOUNaO9/9Jg2RvDr6Jsd9
         9quITOA0gwqJD3qPlh1a34sYmrKU3fcJ49jMIbWTIsrkEFM/7iTPBoJrrjR8x6+EdLxc
         bhQVASaPUB+TY6WftvQ054lTuncFmHCHND0++cR3007sTDE7EcR+RxJbI34sFZJGZde/
         iqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366004; x=1774970804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9X7xuJzrFVA61UqL5AZpBVCs0izcfwIXnfX+VPlxo0=;
        b=c9sOIO7LWiYsFCQ76jXVOLue7qcGoDChl0hiGzvOOCAu3/o0FQDp9lNL8O+1gkfL7R
         uycK89w8VMCfveyvEANHQbliqJ7UU4PkToqa9f7Rj71jy8BcfDHg0bo0HCfC7cYx2490
         ojB/TuT4bsgD29DZJaCfKjGj87aZEPWAmQeQ1c2VWamtYQPLSyicqdnT+tOiho95+5FV
         iccJCXNzOxWRxBbgHHNUIlVRGlGQ7FjTTBAtdIg6QxBjnxX3fBWHXdt049hQb9UJkYas
         7fwcB4mAb10lB5uaxIhbt33OrFfygeLb/OLXDBnYQQ9Kq+TTN2kzaFJdSfpHMKjcx4qU
         ZtJA==
X-Gm-Message-State: AOJu0Yzv2AbHY485KHGOp/I/G/w8mekE1ZoOI5YSo6/eH7Gu1KXxZGXK
	PF77vF2lTHZrIwh4bgiot2KBmbZqC9K/CISIHQKuOeb0K8OZyy0pVxRgmG/Tpw==
X-Gm-Gg: ATEYQzwtspURhPMh27R0crWnetiz83VouTMIPz6+mG2z5ZCqk8qFdQUASiaIfrCw4ZS
	6fHimAKFNL09kMSeGtz1j5EnZIwQMGAymrBUn51x2W+vUyNgcVLcj8Q3Bixkwq22LcFcAAFPuV2
	lhHRDZ8MRQPQk9kTprCm658Ffz24kegdzIEwV9+D0p2iP14mT/EklUsGpz7A509PkulBoWzP+/3
	/bA6NMQH6FAqCtMzZZhwlRwhHVn2t91Ua817BHLzbj00tXJ4dcxohpXuqkZXUiiCJL32OHIhxQu
	kiWpt2JuHG77q2J3gkSOz8eWe+JWP3j31kXadlCIFhkdEJdJtn8v6oeSldwINfYNsGo/yw4uq7x
	ooRjTSDGuxkdbTceFCNF2iuSQvonmtCpUNSnMrxE+EoGHUqzpI9Tr0XV3xPZlyHeBYKtJ8jtCz1
	7QLv7ouhYGjtGib4t5d6vqLmXmaY6zd3deM15Dhx3avaShY6fHexjYu83z0wWb4F0d42xk78OYf
	e3SE69a2LvcX3H5
X-Received: by 2002:a05:600c:4447:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-48715fd4baamr2647745e9.8.1774366003895;
        Tue, 24 Mar 2026 08:26:43 -0700 (PDT)
Received: from 6850u.ox.dtw.sh (cpc69060-oxfd26-2-0-cust335.4-3.cable.virginm.net. [82.6.49.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2desm73626725e9.9.2026.03.24.08.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:26:43 -0700 (PDT)
From: Daniel Wagner <wagner.daniel.t@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	bcm-kernel-feedback-list@broadcom.com,
	Daniel Wagner <wagner.daniel.t@gmail.com>
Subject: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892 support
Date: Tue, 24 Mar 2026 15:25:04 +0000
Message-ID: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271130-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DAFF3183AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
BCM84881, sharing the register map and most callbacks. They add USXGMII
as a host interface mode.

There are three behavioral differences from BCM84881:

- USXGMII host interface: the 0x4011 host mode register reports 10GBASER
  (the USXGMII SerDes line rate) regardless of the negotiated copper
  speed. Skip it for USXGMII; phy_resolve_aneg_linkmode() has already
  set the correct speed from standard C45 AN resolution.

- Low power: the PHY firmware has been observed setting MDIO_CTRL1_LPOWER
  autonomously (e.g. during SerDes reconfiguration). Clear it in
  config_aneg() so AN can proceed.

- Speed LED: bicolor (green/amber) via vendor registers Dev1:0xa82f
  (amber gate) and Dev1:0xa83b (color select). 10G = green, else amber,
  matching vendor firmware behavior. Cleared at config_init() since the
  bootloader may leave it on.

The is_bcm8489x() helper checks phydev->drv->phy_id rather than
phydev->phy_id: for C45-enumerated devices, phy_id is left at 0 by
get_phy_device() and matching uses c45_ids.device_ids[].

Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
running OpenWrt, where the MDIO controller driver is currently
OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.

Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
---
 drivers/net/phy/bcm84881.c | 97 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index d7f7cc44c5..e95242486d 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -20,6 +20,10 @@ enum {
 	MDIO_AN_C22 = 0xffe0,
 };
 
+/* BCM84891/92 vendor registers */
+#define BCM8489X_LED_GATE		0xa82f	/* Dev1: gates amber only */
+#define BCM8489X_LED_COLOR		0xa83b	/* Dev1: color select */
+
 static int bcm84881_wait_init(struct phy_device *phydev)
 {
 	int val;
@@ -29,6 +33,17 @@ static int bcm84881_wait_init(struct phy_device *phydev)
 					 100000, 2000000, false);
 }
 
+static bool bcm84881_is_bcm8489x(struct phy_device *phydev)
+{
+	/* For C45 PHYs, phydev->phy_id is 0; match via the driver entry's
+	 * declared ID, which is what phy_bus_match() used to bind us.
+	 */
+	u32 id = phydev->drv->phy_id;
+
+	return (id & 0xfffffff0) == 0x35905080 ||
+	       (id & 0xfffffff0) == 0x359050a0;
+}
+
 static void bcm84881_fill_possible_interfaces(struct phy_device *phydev)
 {
 	unsigned long *possible = phydev->possible_interfaces;
@@ -42,10 +57,22 @@ static int bcm84881_config_init(struct phy_device *phydev)
 {
 	bcm84881_fill_possible_interfaces(phydev);
 
+	if (bcm84881_is_bcm8489x(phydev)) {
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  phydev->possible_interfaces);
+		/* Bootloader may have left the speed LED on, and
+		 * link_change_notify won't fire for ports with no cable.
+		 * Clear both color bits (green ignores the gate register).
+		 */
+		phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD,
+				   BCM8489X_LED_COLOR, 0x0012);
+	}
+
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
 		break;
 	default:
 		return -ENODEV;
@@ -96,6 +123,17 @@ static int bcm84881_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* BCM84891/92 firmware has been observed setting MDIO_CTRL1_LPOWER
+	 * autonomously (e.g. during SerDes reconfiguration). Clear it so AN
+	 * can proceed.
+	 */
+	if (bcm84881_is_bcm8489x(phydev)) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+					 MDIO_CTRL1_LPOWER);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* We don't support manual MDI control */
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 
@@ -201,6 +239,15 @@ static int bcm84881_read_status(struct phy_device *phydev)
 		return 0;
 	}
 
+	/* For BCM84891/92 in USXGMII mode, the host-side register 0x4011
+	 * reports 10GBASER (the USXGMII SerDes line rate) regardless of the
+	 * negotiated copper speed. Skip it; phy_resolve_aneg_linkmode()
+	 * above already set the correct speed from standard AN resolution.
+	 */
+	if (bcm84881_is_bcm8489x(phydev) &&
+	    phydev->interface == PHY_INTERFACE_MODE_USXGMII)
+		return genphy_c45_read_mdix(phydev);
+
 	/* Set the host link mode - we set the phy interface mode and
 	 * the speed according to this register so that downshift works.
 	 * We leave the duplex setting as per the resolution from the
@@ -235,6 +282,26 @@ static int bcm84881_read_status(struct phy_device *phydev)
 	return genphy_c45_read_mdix(phydev);
 }
 
+/* BCM8489x speed LED control.
+ * Dev1:a83b bit 1 (0x0002) = green, bit 4 (0x0010) = amber.
+ * Dev1:a82f = 0x0020 gates amber on; green ignores the gate.
+ * Writes are best-effort (LED is cosmetic; this callback is void).
+ */
+static void bcm84881_link_change_notify(struct phy_device *phydev)
+{
+	if (phydev->link) {
+		/* 10G = green, else amber; matches vendor firmware */
+		u16 color = (phydev->speed == SPEED_10000) ? 0x0002 : 0x0010;
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_GATE, 0x0020);
+		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_COLOR,
+			       0x0012, color);
+	} else {
+		phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD,
+				   BCM8489X_LED_COLOR, 0x0012);
+	}
+}
+
 /* The Broadcom BCM84881 in the Methode DM7052 is unable to provide a SGMII
  * or 802.3z control word, so inband will not work.
  */
@@ -257,6 +324,32 @@ static struct phy_driver bcm84881_drivers[] = {
 		.aneg_done	= bcm84881_aneg_done,
 		.read_status	= bcm84881_read_status,
 	},
+	{
+		.phy_id		= 0x35905081,
+		.phy_id_mask	= 0xfffffff0,
+		.name		= "Broadcom BCM84891",
+		.inband_caps	= bcm84881_inband_caps,
+		.config_init	= bcm84881_config_init,
+		.probe		= bcm84881_probe,
+		.get_features	= bcm84881_get_features,
+		.config_aneg	= bcm84881_config_aneg,
+		.aneg_done	= bcm84881_aneg_done,
+		.read_status	= bcm84881_read_status,
+		.link_change_notify = bcm84881_link_change_notify,
+	},
+	{
+		.phy_id		= 0x359050a1,
+		.phy_id_mask	= 0xfffffff0,
+		.name		= "Broadcom BCM84892",
+		.inband_caps	= bcm84881_inband_caps,
+		.config_init	= bcm84881_config_init,
+		.probe		= bcm84881_probe,
+		.get_features	= bcm84881_get_features,
+		.config_aneg	= bcm84881_config_aneg,
+		.aneg_done	= bcm84881_aneg_done,
+		.read_status	= bcm84881_read_status,
+		.link_change_notify = bcm84881_link_change_notify,
+	},
 };
 
 module_phy_driver(bcm84881_drivers);
@@ -264,9 +357,11 @@ module_phy_driver(bcm84881_drivers);
 /* FIXME: module auto-loading for Clause 45 PHYs seems non-functional */
 static const struct mdio_device_id __maybe_unused bcm84881_tbl[] = {
 	{ 0xae025150, 0xfffffff0 },
+	{ 0x35905081, 0xfffffff0 },
+	{ 0x359050a1, 0xfffffff0 },
 	{ },
 };
 MODULE_AUTHOR("Russell King");
-MODULE_DESCRIPTION("Broadcom BCM84881 PHY driver");
+MODULE_DESCRIPTION("Broadcom BCM84881/BCM84891/BCM84892 PHY driver");
 MODULE_DEVICE_TABLE(mdio, bcm84881_tbl);
 MODULE_LICENSE("GPL");
-- 
2.47.3


