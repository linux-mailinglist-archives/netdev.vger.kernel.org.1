Return-Path: <netdev+bounces-273361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UChoLs8By2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCED3623FA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7393077412
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B443ECBD9;
	Mon, 30 Mar 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuWmvmW0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E4284B29
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911288; cv=none; b=E1AAnoJ8OkV+5nYzrBeFe+29Q8KAzJJucAJ5xvrgAuQj6cMYxvvpXSFV9+TOed+EhWClWy7/zPQBgqrsmojsEPY3dyZJbtRKRGCJW2fTs3kORIqdnXBZ3SD5159IqAbK/GLj01eze6L3wQYyjmP9JUn4gO+lwfFjOdGrVRgX2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911288; c=relaxed/simple;
	bh=Ujv4VWibSVw2HAdRUF5dpkKnp3v6rUy47IDc6MZc+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsWw4eM6rEbxydWV3tAlu9QMcFSsO/hAbenLuiKjrTCxzZdqfcKaZFu1XJpv5w4t6RizSd1QCbuplxRNfqIGJSP4ZBlD83nF1BlmtGYECH6BQer+ZjjscMLeDfIx2GSX8qMi+0IDxUX+sqNyZ7qQFToRTZjtSQEbgsgiV6CbPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuWmvmW0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2893515f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774911277; x=1775516077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRbr4JDUO9O8YW98OsDnqXVG2lTsNgXdEBiAPgW16ZM=;
        b=IuWmvmW0ufWu3MuVGIIlZTDtn/rgkQpkJZYNDwY9IIguets+nL27hPnreq2BrqFVga
         38OZXn4Y8wGTKPAdyMn4hKOZeuiHEF4fjcPbTA65RnGQYyl8OLb71SYpsiD8c5YQJ/Hn
         pqf/HWPD5fbEE5+1xZpJYCcTrEOrTVGUHmtwUesU7+JJ7vtYnURZP1keU/bHvTCnnnJq
         cRaXUahatAZVB8mHwYfFDHZ1Xq56kWiJBSVwkvMl6gzGMYZVKhPExiYToAgRNovlAUML
         13XzISGZJi2ZxWSByBtfLW9GjAwYpMNFPHXEsqX3UAZFVcK0Ir5/FsoYjE9bKPxj6gZj
         bCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911277; x=1775516077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRbr4JDUO9O8YW98OsDnqXVG2lTsNgXdEBiAPgW16ZM=;
        b=D3A2p+m5rxt0J3exni3L//pQvBNEGIfzOlQwVwIpHHwlyymi1F+yZfzwBvrDgpxiHY
         jI4ow7CadDCcsEdupbJQYEaEu/OlgDqQAoQQ0TXJd8A5uix9RGLGYIz+Ok5GrhuSV7xK
         2zyhkKGNdXpZtkZ+WGpUZz7cAdYSugJ86rbcQWZmTtG9/kzo7HqB+9APbRjUa1rXBJ/a
         GxlzSU3Gjxf/O2OUtOMGq+/JH1K96ENgxLFA+lA55Wx2nL8yt4iYQNj0yyIZ8aMhIKI5
         3uRtQiat5CxLZuCyhIv8TEG3WXiybttlQbEMvfwZ4eXakbgOX2ndcPcgX6xDPQZWSxoD
         UqDQ==
X-Gm-Message-State: AOJu0YwistjeN972MQtno8ZbX1JAWZTExSFKK10RAIynWJIbXNxA6KFr
	/lwC/vlRpPEBwJKfvj44d8JEhKxq7RSLf5ayuq7X8/8bFeTL6OTt4fRCumRc/n51
X-Gm-Gg: ATEYQzxZ2YnDeoNOYP1Ja5iXJPQwwkcCFqdWBnpzxbPEh6F3tcRgXOE+Vf/ykPLJ6f2
	PXyaOhM5IKAHLEFB9j7E49wM64wyG2vLchg6jxmlO0he2LJHyr9VGxz0BFiyWO+AyrGvNO7m9BR
	bv3Hh4lHPcytmbS8g9tbt2bZk0LJbBqUmKVkop3JQJplQRa7vCw/SCoN/lPb3KMGTRlceEF/5P0
	5rdHfo4NVCv//QX+qDdjTLZJKqgXKgTiK6WmM1K7prsnqSaSflCSyhAgmzrIBjSJJzJDMXR3GBI
	wHQFvsVqFcIFaP2OpdnkUWKu0y9rkid6dorURoj0YJjmyPqHHdLA/KTtl9zpA83AQZMTd515OPC
	9Mb9upO7rbKoqRxKck7U4xWzQqQ98Cfyctz/a5JrTya5MxOyW8J0rjrf3mFWn9rPTYCEpEbO2nh
	kbY+PlPRWhJMgGrp/TBpgFIO2pzF/blmQ2Rh5tFNpYSKlN6ugcecVPW0KyzrSrQ1VyIwVIzOoUu
	a2OCIQl5GUGV257Y64K/UFRARU=
X-Received: by 2002:a05:6000:2902:b0:43c:f650:cc97 with SMTP id ffacd0b85a97d-43d081979e8mr2236737f8f.9.1774911276892;
        Mon, 30 Mar 2026 15:54:36 -0700 (PDT)
Received: from 6850u.ox.dtw.sh (cpc69060-oxfd26-2-0-cust335.4-3.cable.virginm.net. [82.6.49.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580168sm22707682f8f.36.2026.03.30.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:54:36 -0700 (PDT)
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
	Nicolai Buchwitz <nb@tipi-net.de>,
	Daniel Wagner <wagner.daniel.t@gmail.com>
Subject: [PATCH net-next v3] net: phy: bcm84881: add BCM84891/BCM84892 support
Date: Mon, 30 Mar 2026 23:53:10 +0100
Message-ID: <20260330225310.2801264-1-wagner.daniel.t@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273361-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,google.com,redhat.com,tipi-net.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email]
X-Rspamd-Queue-Id: 3CCED3623FA
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
v3: No code changes. Resend per Jakub's request (v2 was posted while
    the v1 discussion was still ongoing). Collected Reviewed-by tags.

v2: https://lore.kernel.org/netdev/20260324190601.1616343-1-wagner.daniel.t@gmail.com/
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


