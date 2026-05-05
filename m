Return-Path: <netdev+bounces-284443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGAaGUf/+WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C34CF6F3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3E230B7637
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A148A2A4;
	Tue,  5 May 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KVXS4Omc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EB481FBF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991139; cv=none; b=R/c0lFURkp6DjGVwBPiiZIbgMNfEV20h50mNfSnNElDPNa6+hTGur8foK6vAikGWV+G6HYQGP9bD5hN8OFemnrtAX19+qVFF/XVokgfiUZi8yjaLhm+DjEVK/Jvmel6ppnl4Rjndi4r4bB4mhtmfXvqUIVe+RbAPpNpnFoNSZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991139; c=relaxed/simple;
	bh=ufN60Bn7R/+t5jZoP20V7Du0WNZ3kidlXmoNNukyKVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uplTidXb8EuPDOtt1GWuzeWHBgLortbY+7DYeNmrNfpoAD5gl3PGtH4UsEoriQ7/qyJeeHp3455hOjFFkuZJsFvQL6mvTS/Gu6EfWEQjFXnwLhbVBR4ePhxLtXGdutxy20/ed9sa+WS+zrYDEeSCcSLId44YwFj8jgV9PzwaDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KVXS4Omc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5B0A04E42BD2;
	Tue,  5 May 2026 14:25:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31E8C6053C;
	Tue,  5 May 2026 14:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51D8E11AD024A;
	Tue,  5 May 2026 16:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bgoVx+80kD133mKE6MAZGhY5C6kyBOvMP+TwPKf4yBQ=;
	b=KVXS4OmccmRUNKClhIOZj5qTUbwvQZoEkYIbUbTbTipgqWBHlr3YQH+CsGZYM+ZhyDjEfF
	f2/RhXO38rYg4el8cp7IPR0QjpoSdDEPC5w940/KADIFua5bj5aP0A5Fvq67xIspD5Adj2
	2/AhdT81b5AsPvs3AI2wGpqDsx3Bz7ojgub0jjQUc4GEJFGq0s6w5pPr+lYpoYyw0Twrni
	dIDklC9SMKkHTBl3UPmeCfk3PNbkXCsCJnfUCMse5ZcXSFKEda6SqJKHOdqdbJUHDV84Zb
	uPR4SP2rTQP4vxlT0T7WH8mJQ2St4fjk/sBoDwDurBD+JmivTH0PQgUtRhDDAg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:09 +0200
Subject: [PATCH net-next 9/9] net: dsa: microchip: split
 ksz_connect_tag_protocol()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-9-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: D30C34CF6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

All the KSZ switches use the same ksz_connect_tag_protocol while they
don't support all the KSZ tag protocols. So if, for some reason, a given
switch tries to connect another KSZ tag protocol, it won't fail.

Split the common ksz_connect_tag_protocol() into switch-specific
operations. This way, each switch will only accept to connect the tag
protocol it supports.
Remove the no longer used common operation.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 51 ++++++++++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.c      | 17 ++++++++++-
 drivers/net/dsa/microchip/ksz_common.c   | 19 ------------
 drivers/net/dsa/microchip/ksz_common.h   |  2 --
 drivers/net/dsa/microchip/lan937x_main.c | 17 ++++++++++-
 5 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index fa2e1256323c2..abee0dc5ec04b 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -16,6 +16,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/dsa/ksz_common.h>
 #include <linux/export.h>
 #include <linux/gpio.h>
 #include <linux/if_vlan.h>
@@ -2107,6 +2108,20 @@ static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_KSZ9893;
 }
 
+static int ksz8463_connect_tag_protocol(struct dsa_switch *ds,
+					enum dsa_tag_protocol proto)
+{
+	struct ksz_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_KSZ9893)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ksz_tagger_data(ds);
+	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+
+	return 0;
+}
+
 static enum dsa_tag_protocol ksz87xx_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -2114,6 +2129,15 @@ static enum dsa_tag_protocol ksz87xx_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_KSZ8795;
 }
 
+static int ksz87xx_connect_tag_protocol(struct dsa_switch *ds,
+					enum dsa_tag_protocol proto)
+{
+	if (proto != DSA_TAG_PROTO_KSZ8795)
+		return -EPROTONOSUPPORT;
+
+	return 0;
+}
+
 static enum dsa_tag_protocol ksz88xx_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -2126,6 +2150,27 @@ static enum dsa_tag_protocol ksz88xx_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_KSZ9893;
 }
 
+static int ksz88xx_connect_tag_protocol(struct dsa_switch *ds,
+					enum dsa_tag_protocol proto)
+{
+	struct ksz_tagger_data *tagger_data;
+
+	if (ksz_is_8895_family(ds->priv)) { /* KSZ8864, KSZ8895 */
+		if (proto != DSA_TAG_PROTO_KSZ8795)
+			return -EPROTONOSUPPORT;
+
+		return 0;
+	}
+
+	if (proto != DSA_TAG_PROTO_KSZ9893)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ksz_tagger_data(ds);
+	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+
+	return 0;
+}
+
 static void ksz88x3_phylink_mac_config(struct phylink_config *config,
 				       unsigned int mode,
 				       const struct phylink_link_state *state)
@@ -2256,7 +2301,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
 	.teardown		= ksz_teardown,
@@ -2317,7 +2362,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 
 const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_tag_protocol	= ksz87xx_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.connect_tag_protocol   = ksz87xx_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
 	.teardown		= ksz_teardown,
@@ -2378,7 +2423,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 
 const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_tag_protocol	= ksz88xx_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.connect_tag_protocol   = ksz88xx_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
 	.teardown		= ksz_teardown,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 9bac95bb079ff..ac2c63fe0588c 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
+#include <linux/dsa/ksz_common.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
@@ -1624,6 +1625,20 @@ static enum dsa_tag_protocol ksz9477_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_KSZ9477;
 }
 
+static int ksz9477_connect_tag_protocol(struct dsa_switch *ds,
+					enum dsa_tag_protocol proto)
+{
+	struct ksz_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_KSZ9893 && proto != DSA_TAG_PROTO_KSZ9477)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ksz_tagger_data(ds);
+	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+
+	return 0;
+}
+
 static void ksz9477_set_gbit(struct ksz_device *dev, int port, bool gbit)
 {
 	const u8 *bitval = dev->info->xmii_ctrl1;
@@ -1790,7 +1805,7 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 
 const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_tag_protocol	= ksz9477_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.connect_tag_protocol   = ksz9477_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
 	.teardown		= ksz_teardown,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1be055d3f1994..426414a218455 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3304,25 +3304,6 @@ int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-int ksz_connect_tag_protocol(struct dsa_switch *ds,
-			     enum dsa_tag_protocol proto)
-{
-	struct ksz_tagger_data *tagger_data;
-
-	switch (proto) {
-	case DSA_TAG_PROTO_KSZ8795:
-		return 0;
-	case DSA_TAG_PROTO_KSZ9893:
-	case DSA_TAG_PROTO_KSZ9477:
-	case DSA_TAG_PROTO_LAN937X:
-		tagger_data = ksz_tagger_data(ds);
-		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
-		return 0;
-	default:
-		return -EPROTONOSUPPORT;
-	}
-}
-
 int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
 			    bool flag, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 39486b5571bd6..3dde7e7717272 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -473,8 +473,6 @@ void ksz_teardown(struct dsa_switch *ds);
 int ksz_port_setup(struct dsa_switch *ds, int port);
 void ksz_port_teardown(struct dsa_switch *ds, int port);
 
-int ksz_connect_tag_protocol(struct dsa_switch *ds,
-			     enum dsa_tag_protocol proto);
 void ksz_init_mib_timer(struct ksz_device *dev);
 bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index c39be6eb50121..e522990cce22e 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -2,6 +2,7 @@
 /* Microchip LAN937X switch driver main logic
  * Copyright (C) 2019-2024 Microchip Technology Inc.
  */
+#include <linux/dsa/ksz_common.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
@@ -674,6 +675,20 @@ static enum dsa_tag_protocol lan937x_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_LAN937X;
 }
 
+static int lan937x_connect_tag_protocol(struct dsa_switch *ds,
+					enum dsa_tag_protocol proto)
+{
+	struct ksz_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_LAN937X)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ksz_tagger_data(ds);
+	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+
+	return 0;
+}
+
 const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
@@ -722,7 +737,7 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 
 const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_tag_protocol	= lan937x_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
+	.connect_tag_protocol   = lan937x_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz_setup,
 	.teardown		= ksz_teardown,

-- 
2.53.0


