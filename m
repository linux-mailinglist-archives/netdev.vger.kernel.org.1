Return-Path: <netdev+bounces-287138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGKTE20qA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1C521209
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E622233492A6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B243AB498;
	Tue, 12 May 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v+MGO5cm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660D3A83A3
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591210; cv=none; b=UR3rTOVDcTXmXZS9LLEnSpqffRifMnUlIlrUQtgTaKL4IUx0RqlVMh1SPk9SuLaB5DqD4L7t1BwWK9lhej1OyZNq/gYtGrA0nT+ywXT5qJd2SwM+I3XpjpnNzbTCzGtRIDj4yZ4f6rJcv2iJOloo+uE30/lqT4YV0+nfrBAcpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591210; c=relaxed/simple;
	bh=ZBTjRmiqhHelyvesIP0CrzdBOjIkyfdorEyyd0m3jjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACNn+gKVVK4qvVWAe5U7CoQa0Lp71YoIJiCEDy7Mt2o/WSDsRK06pCbuz3BHL43nFYoWk1zOP75yRAgjoLRTziME6rUYJ+BTu0hYCGajRBYlsxTsjQjH8PwH6YNKKWIo5d/k6unlafX2ZcTxfgZKe6O71bwYuUk0yXc8jPV9Iz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v+MGO5cm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 509A0C5E179;
	Tue, 12 May 2026 13:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5512560646;
	Tue, 12 May 2026 13:06:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EC6B11AF883A;
	Tue, 12 May 2026 15:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NDdPKN9PalIKQH7yi50b2Tc7S+eRHJ6p0jSsZWWouV8=;
	b=v+MGO5cmOjN09TLh83InNkE71Byq0kx6hwS+4IU7oqMqNK4W5EXXVOR7qxLgbIgy5utYyD
	cTRFvApiB/VVM66FZ67idiR7yeeYERG7E/MZpmzB7brFDONNXQ6PPkuacvfzDAuVLz3Pc1
	sl0AP0B9cIWIekjmKf1tt7Lg3duHBcRBa6JabxmcDxVnGJXosauVh9dmxOSdn0TQEI9/7g
	ZqpMOIwRtetK45OTOYjWvJ+ddW3hEdPtwiz8sK08792EwzIJg2v1m69Y6v5L4oYJRnDN8D
	k1gX/Wcp/iVvxFioCJs1AZ+yrBE0IC/7IETeKiZA2fqfubfkr4UWusd4j6REtg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:27 +0200
Subject: [PATCH net-next 05/15] net: dsa: microchip: bypass dev_ops for FDB
 and MDB operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-5-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A4D1C521209
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

FDB and MDB operations are handled through a common function that
redirects the treatment to ksz_dev_ops callbacks. This layer of
indirection isn't needed since we now have a dsa_switch_ops for each kind
of switch.

Remove one indirection layer for KSZ switches, by connecting the
ksz_dev_ops :: fdb_dump(), fdb_add(), fdb_del(), mdb_add() and mdb_del()
operations directly to dsa_switch_ops.
Remove the FDB and MDB operations from ksz_dev_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 64 +++++++++++++-------------------
 drivers/net/dsa/microchip/ksz9477.c      | 42 ++++++++++-----------
 drivers/net/dsa/microchip/ksz9477.h      | 10 ++---
 drivers/net/dsa/microchip/ksz_common.c   | 59 -----------------------------
 drivers/net/dsa/microchip/ksz_common.h   | 26 -------------
 drivers/net/dsa/microchip/lan937x_main.c | 15 +++-----
 6 files changed, 56 insertions(+), 160 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 94c8034a192a9..83795fd66aab2 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1315,9 +1315,10 @@ static void ksz8_flush_dyn_mac_table(struct dsa_switch *ds, int port)
 	}
 }
 
-static int ksz8_fdb_dump(struct ksz_device *dev, int port,
+static int ksz8_fdb_dump(struct dsa_switch *ds, int port,
 			 dsa_fdb_dump_cb_t *cb, void *data)
 {
+	struct ksz_device *dev = ds->priv;
 	u8 mac[ETH_ALEN];
 	u8 src_port, fid;
 	u16 entries = 0;
@@ -1420,30 +1421,30 @@ static int ksz8_del_sta_mac(struct ksz_device *dev, int port,
 	return ksz8_w_sta_mac_table(dev, index, &alu);
 }
 
-static int ksz8_mdb_add(struct ksz_device *dev, int port,
+static int ksz8_mdb_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_mdb *mdb,
 			struct dsa_db db)
 {
-	return ksz8_add_sta_mac(dev, port, mdb->addr, mdb->vid);
+	return ksz8_add_sta_mac(ds->priv, port, mdb->addr, mdb->vid);
 }
 
-static int ksz8_mdb_del(struct ksz_device *dev, int port,
+static int ksz8_mdb_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_mdb *mdb,
 			struct dsa_db db)
 {
-	return ksz8_del_sta_mac(dev, port, mdb->addr, mdb->vid);
+	return ksz8_del_sta_mac(ds->priv, port, mdb->addr, mdb->vid);
 }
 
-static int ksz8_fdb_add(struct ksz_device *dev, int port,
+static int ksz8_fdb_add(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
-	return ksz8_add_sta_mac(dev, port, addr, vid);
+	return ksz8_add_sta_mac(ds->priv, port, addr, vid);
 }
 
-static int ksz8_fdb_del(struct ksz_device *dev, int port,
+static int ksz8_fdb_del(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
-	return ksz8_del_sta_mac(dev, port, addr, vid);
+	return ksz8_del_sta_mac(ds->priv, port, addr, vid);
 }
 
 static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
@@ -2215,11 +2216,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2242,11 +2238,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2272,11 +2263,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2316,11 +2302,11 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_vlan_filtering	= ksz8_port_vlan_filtering,
 	.port_vlan_add		= ksz8_port_vlan_add,
 	.port_vlan_del		= ksz8_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
+	.port_fdb_dump		= ksz8_fdb_dump,
+	.port_fdb_add		= ksz8_fdb_add,
+	.port_fdb_del		= ksz8_fdb_del,
+	.port_mdb_add           = ksz8_mdb_add,
+	.port_mdb_del           = ksz8_mdb_del,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
@@ -2376,11 +2362,11 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_vlan_filtering	= ksz8_port_vlan_filtering,
 	.port_vlan_add		= ksz8_port_vlan_add,
 	.port_vlan_del		= ksz8_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
+	.port_fdb_dump		= ksz8_fdb_dump,
+	.port_fdb_add		= ksz8_fdb_add,
+	.port_fdb_del		= ksz8_fdb_del,
+	.port_mdb_add           = ksz8_mdb_add,
+	.port_mdb_del           = ksz8_mdb_del,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
@@ -2436,11 +2422,11 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_vlan_filtering	= ksz8_port_vlan_filtering,
 	.port_vlan_add		= ksz8_port_vlan_add,
 	.port_vlan_del		= ksz8_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
+	.port_fdb_dump		= ksz8_fdb_dump,
+	.port_fdb_add		= ksz8_fdb_add,
+	.port_fdb_del		= ksz8_fdb_del,
+	.port_mdb_add           = ksz8_mdb_add,
+	.port_mdb_del           = ksz8_mdb_del,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 959229185df97..69a4fb683b3a1 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -718,9 +718,10 @@ int ksz9477_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-int ksz9477_fdb_add(struct ksz_device *dev, int port,
+int ksz9477_fdb_add(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid, struct dsa_db db)
 {
+	struct ksz_device *dev = ds->priv;
 	u32 alu_table[4];
 	u32 data;
 	int ret = 0;
@@ -774,9 +775,10 @@ int ksz9477_fdb_add(struct ksz_device *dev, int port,
 	return ret;
 }
 
-int ksz9477_fdb_del(struct ksz_device *dev, int port,
+int ksz9477_fdb_del(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid, struct dsa_db db)
 {
+	struct ksz_device *dev = ds->priv;
 	u32 alu_table[4];
 	u32 data;
 	int ret = 0;
@@ -863,13 +865,14 @@ static void ksz9477_convert_alu(struct alu_struct *alu, u32 *alu_table)
 	alu->mac[5] = alu_table[3] & 0xFF;
 }
 
-int ksz9477_fdb_dump(struct ksz_device *dev, int port,
+int ksz9477_fdb_dump(struct dsa_switch *ds, int port,
 		     dsa_fdb_dump_cb_t *cb, void *data)
 {
-	int ret = 0;
-	u32 ksz_data;
-	u32 alu_table[4];
+	struct ksz_device *dev = ds->priv;
 	struct alu_struct alu;
+	u32 alu_table[4];
+	u32 ksz_data;
+	int ret = 0;
 	int timeout;
 
 	mutex_lock(&dev->alu_mutex);
@@ -917,9 +920,10 @@ int ksz9477_fdb_dump(struct ksz_device *dev, int port,
 	return ret;
 }
 
-int ksz9477_mdb_add(struct ksz_device *dev, int port,
+int ksz9477_mdb_add(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
 {
+	struct ksz_device *dev = ds->priv;
 	u32 static_table[4];
 	const u8 *shifts;
 	const u32 *masks;
@@ -996,16 +1000,17 @@ int ksz9477_mdb_add(struct ksz_device *dev, int port,
 	return err;
 }
 
-int ksz9477_mdb_del(struct ksz_device *dev, int port,
+int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
 {
+	struct ksz_device *dev = ds->priv;
 	u32 static_table[4];
+	u32 mac_hi, mac_lo;
 	const u8 *shifts;
 	const u32 *masks;
-	u32 data;
-	int index;
 	int ret = 0;
-	u32 mac_hi, mac_lo;
+	int index;
+	u32 data;
 
 	shifts = dev->info->shifts;
 	masks = dev->info->masks;
@@ -1787,11 +1792,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.mirror_add = ksz9477_port_mirror_add,
 	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = ksz9477_get_caps,
-	.fdb_dump = ksz9477_fdb_dump,
-	.fdb_add = ksz9477_fdb_add,
-	.fdb_del = ksz9477_fdb_del,
-	.mdb_add = ksz9477_mdb_add,
-	.mdb_del = ksz9477_mdb_del,
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
 	.pme_pwrite8 = ksz_pwrite8,
@@ -1831,11 +1831,11 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_vlan_filtering	= ksz9477_port_vlan_filtering,
 	.port_vlan_add		= ksz9477_port_vlan_add,
 	.port_vlan_del		= ksz9477_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
+	.port_fdb_dump		= ksz9477_fdb_dump,
+	.port_fdb_add		= ksz9477_fdb_add,
+	.port_fdb_del		= ksz9477_fdb_del,
+	.port_mdb_add           = ksz9477_mdb_add,
+	.port_mdb_del           = ksz9477_mdb_del,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 75a7b2bfc7976..39f042e56f365 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -33,15 +33,15 @@ void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
 int ksz9477_errata_monitor(struct ksz_device *dev, int port,
 			   u64 tx_late_col);
-int ksz9477_fdb_dump(struct ksz_device *dev, int port,
+int ksz9477_fdb_dump(struct dsa_switch *ds, int port,
 		     dsa_fdb_dump_cb_t *cb, void *data);
-int ksz9477_fdb_add(struct ksz_device *dev, int port,
+int ksz9477_fdb_add(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid, struct dsa_db db);
-int ksz9477_fdb_del(struct ksz_device *dev, int port,
+int ksz9477_fdb_del(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid, struct dsa_db db);
-int ksz9477_mdb_add(struct ksz_device *dev, int port,
+int ksz9477_mdb_add(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
-int ksz9477_mdb_del(struct ksz_device *dev, int port,
+int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 07d1d58113f05..d17ce88d49471 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3085,65 +3085,6 @@ void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
 	 */
 }
 
-int ksz_port_fdb_add(struct dsa_switch *ds, int port,
-		     const unsigned char *addr, u16 vid,
-		     struct dsa_db db)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->fdb_add)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->fdb_add(dev, port, addr, vid, db);
-}
-
-int ksz_port_fdb_del(struct dsa_switch *ds, int port,
-		     const unsigned char *addr,
-		     u16 vid, struct dsa_db db)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->fdb_del)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->fdb_del(dev, port, addr, vid, db);
-}
-
-int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
-		      dsa_fdb_dump_cb_t *cb, void *data)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->fdb_dump)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->fdb_dump(dev, port, cb, data);
-}
-
-int ksz_port_mdb_add(struct dsa_switch *ds, int port,
-		     const struct switchdev_obj_port_mdb *mdb,
-		     struct dsa_db db)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->mdb_add)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->mdb_add(dev, port, mdb, db);
-}
-
-int ksz_port_mdb_del(struct dsa_switch *ds, int port,
-		     const struct switchdev_obj_port_mdb *mdb,
-		     struct dsa_db db)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->mdb_del)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->mdb_del(dev, port, mdb, db);
-}
-
 static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
 						  int port)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index d07b3f5918f8e..fe3b2dad3d684 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -413,18 +413,6 @@ struct ksz_dev_ops {
 			  bool ingress, struct netlink_ext_ack *extack);
 	void (*mirror_del)(struct ksz_device *dev, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror);
-	int (*fdb_add)(struct ksz_device *dev, int port,
-		       const unsigned char *addr, u16 vid, struct dsa_db db);
-	int (*fdb_del)(struct ksz_device *dev, int port,
-		       const unsigned char *addr, u16 vid, struct dsa_db db);
-	int (*fdb_dump)(struct ksz_device *dev, int port,
-			dsa_fdb_dump_cb_t *cb, void *data);
-	int (*mdb_add)(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_mdb *mdb,
-		       struct dsa_db db);
-	int (*mdb_del)(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_mdb *mdb,
-		       struct dsa_db db);
 	void (*get_caps)(struct ksz_device *dev, int port,
 			 struct phylink_config *config);
 	int (*pme_write8)(struct ksz_device *dev, u32 reg, u8 value);
@@ -498,20 +486,6 @@ int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 			  struct switchdev_brport_flags flags,
 			  struct netlink_ext_ack *extack);
-int ksz_port_fdb_add(struct dsa_switch *ds, int port,
-		     const unsigned char *addr, u16 vid,
-		     struct dsa_db db);
-int ksz_port_fdb_del(struct dsa_switch *ds, int port,
-		     const unsigned char *addr,
-		     u16 vid, struct dsa_db db);
-int ksz_port_fdb_dump(struct dsa_switch *ds, int port,
-		      dsa_fdb_dump_cb_t *cb, void *data);
-int ksz_port_mdb_add(struct dsa_switch *ds, int port,
-		     const struct switchdev_obj_port_mdb *mdb,
-		     struct dsa_db db);
-int ksz_port_mdb_del(struct dsa_switch *ds, int port,
-		     const struct switchdev_obj_port_mdb *mdb,
-		     struct dsa_db db);
 
 void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 			  struct phylink_config *config);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index be6a457ee8e4b..aa428353818d8 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -717,11 +717,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = lan937x_phylink_get_caps,
 	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
-	.fdb_dump = ksz9477_fdb_dump,
-	.fdb_add = ksz9477_fdb_add,
-	.fdb_del = ksz9477_fdb_del,
-	.mdb_add = ksz9477_mdb_add,
-	.mdb_del = ksz9477_mdb_del,
 	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -757,11 +752,11 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_vlan_filtering	= ksz9477_port_vlan_filtering,
 	.port_vlan_add		= ksz9477_port_vlan_add,
 	.port_vlan_del		= ksz9477_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
+	.port_fdb_dump		= ksz9477_fdb_dump,
+	.port_fdb_add		= ksz9477_fdb_add,
+	.port_fdb_del		= ksz9477_fdb_del,
+	.port_mdb_add           = ksz9477_mdb_add,
+	.port_mdb_del           = ksz9477_mdb_del,
 	.port_mirror_add	= ksz_port_mirror_add,
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,

-- 
2.53.0


