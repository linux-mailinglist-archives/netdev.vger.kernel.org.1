Return-Path: <netdev+bounces-61880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EC825261
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3741C23A1C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FB28DDA;
	Fri,  5 Jan 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="ABrSEtxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9328DAF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LEGREd70N4e8+Yc+aGcmDF2f8QuwYRN7VPx9JbhRgHM=; b=ABrSEtxIq851RO4vL4nn3ODd33
	yST+dkA8uN3mUmHMcKDmQD0NCGcsY9mgblOw8KS0k1VcqAmB04HaRlVyel82i0WKq6jaO9gZCuaI7
	mAg1bt1OhRxQ1HvLmymot85arqrsBwiQaxTauRzx9mZ067Jw+QrUUiDt1O21T3lM1tUGOF7hV139p
	e0BYWF3TkaE459oytrRy8N6nFYWk00q+OwLWeYVdfSAPvP4B7Th8ZHIMsu3knQSow0rkKBXGKznWD
	Ybdu1IKcHS+GmYFAMCR6hUHR90O/MdhmpJIO4Z3U0i8Dd+TyKeaGuMBQzmMDr2ibJybh4dmXL0+iG
	q1GEC0CQ==;
Received: from [192.168.1.4] (port=44799 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhiY-0000eT-22;
	Fri, 05 Jan 2024 11:46:22 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:22 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 1/6] net:dsa: drop mirror struct from port mirror functions
Date: Fri, 5 Jan 2024 11:46:14 +0100
Message-ID: <f3f9848d464a6d86ac3cc2690c04b8fcbcc21697.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1704449760.git.ante.knezic@helmholz.de>
References: <cover.1704449760.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

dsa_mall_mirror_tc_entry struct assumes that the mirror
destination port must be on the same switch device as the
mirror source port. While this is true as far as particular
switch is concerned, it is not necessarily true for
dsa_mall_tc_entry struct entries. Therefore, replace port
index member of dsa_mall_mirror_tc_entry with dsa_port struct
and limit its scope to dsa core only.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/b53/b53_common.c       | 20 +++++++++---------
 drivers/net/dsa/b53/b53_priv.h         |  8 +++----
 drivers/net/dsa/microchip/ksz8.h       | 10 ++++-----
 drivers/net/dsa/microchip/ksz8795.c    | 36 ++++++++++++++++----------------
 drivers/net/dsa/microchip/ksz9477.c    | 26 +++++++++++------------
 drivers/net/dsa/microchip/ksz9477.h    | 10 ++++-----
 drivers/net/dsa/microchip/ksz_common.c | 14 ++++++-------
 drivers/net/dsa/microchip/ksz_common.h |  7 +++----
 drivers/net/dsa/mt7530.c               | 34 +++++++++++++++---------------
 drivers/net/dsa/mv88e6xxx/chip.c       | 25 +++++++++++-----------
 drivers/net/dsa/ocelot/felix.c         | 14 ++++++-------
 drivers/net/dsa/qca/qca8k-common.c     | 38 +++++++++++++++++-----------------
 drivers/net/dsa/qca/qca8k.h            | 10 ++++-----
 drivers/net/dsa/sja1105/sja1105_main.c | 13 ++++++------
 include/net/dsa.h                      | 12 +++++------
 net/dsa/user.c                         | 13 ++++++++----
 16 files changed, 146 insertions(+), 144 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0d628b35fd5c..993adbc81339 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2128,8 +2128,8 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_get_tag_protocol);
 
-int b53_mirror_add(struct dsa_switch *ds, int port,
-		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
+int b53_mirror_add(struct dsa_switch *ds, int from_port,
+		   int to_port, bool ingress,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
@@ -2141,12 +2141,12 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		loc = B53_EG_MIR_CTL;
 
 	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
-	reg |= BIT(port);
+	reg |= BIT(from_port);
 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 
 	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
 	reg &= ~CAP_PORT_MASK;
-	reg |= mirror->to_local_port;
+	reg |= to_port;
 	reg |= MIRROR_EN;
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 
@@ -2154,21 +2154,21 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_mirror_add);
 
-void b53_mirror_del(struct dsa_switch *ds, int port,
-		    struct dsa_mall_mirror_tc_entry *mirror)
+void b53_mirror_del(struct dsa_switch *ds, int from_port,
+		    int to_port, bool ingress)
 {
 	struct b53_device *dev = ds->priv;
 	bool loc_disable = false, other_loc_disable = false;
 	u16 reg, loc;
 
-	if (mirror->ingress)
+	if (ingress)
 		loc = B53_IG_MIR_CTL;
 	else
 		loc = B53_EG_MIR_CTL;
 
 	/* Update the desired ingress/egress register */
 	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
-	reg &= ~BIT(port);
+	reg &= ~BIT(from_port);
 	if (!(reg & MIRROR_MASK))
 		loc_disable = true;
 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
@@ -2176,7 +2176,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	/* Now look at the other one to know if we can disable mirroring
 	 * entirely
 	 */
-	if (mirror->ingress)
+	if (ingress)
 		b53_read16(dev, B53_MGMT_PAGE, B53_EG_MIR_CTL, &reg);
 	else
 		b53_read16(dev, B53_MGMT_PAGE, B53_IG_MIR_CTL, &reg);
@@ -2187,7 +2187,7 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 	/* Both no longer have ports, let's disable mirroring */
 	if (loc_disable && other_loc_disable) {
 		reg &= ~MIRROR_EN;
-		reg &= ~mirror->to_local_port;
+		reg &= ~to_port;
 	}
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index fdcfd5081c28..625dafcd757b 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -385,13 +385,13 @@ int b53_mdb_add(struct dsa_switch *ds, int port,
 int b53_mdb_del(struct dsa_switch *ds, int port,
 		const struct switchdev_obj_port_mdb *mdb,
 		struct dsa_db db);
-int b53_mirror_add(struct dsa_switch *ds, int port,
-		   struct dsa_mall_mirror_tc_entry *mirror, bool ingress,
+int b53_mirror_add(struct dsa_switch *ds, int from_port,
+		   int to_port, bool ingress,
 		   struct netlink_ext_ack *extack);
 enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 					   enum dsa_tag_protocol mprot);
-void b53_mirror_del(struct dsa_switch *ds, int port,
-		    struct dsa_mall_mirror_tc_entry *mirror);
+void b53_mirror_del(struct dsa_switch *ds, int from_port, int to_port,
+		    bool ingress);
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 1a5225264e6a..3fce8a9e99e7 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -43,11 +43,11 @@ int ksz8_port_vlan_add(struct ksz_device *dev, int port,
 		       struct netlink_ext_ack *extack);
 int ksz8_port_vlan_del(struct ksz_device *dev, int port,
 		       const struct switchdev_obj_port_vlan *vlan);
-int ksz8_port_mirror_add(struct ksz_device *dev, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror,
-			 bool ingress, struct netlink_ext_ack *extack);
-void ksz8_port_mirror_del(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror);
+int ksz8_port_mirror_add(struct ksz_device *dev, int from_port,
+			 int to_port, bool ingress,
+			 struct netlink_ext_ack *extack);
+void ksz8_port_mirror_del(struct ksz_device *dev, int from_port,
+			  int to_port, bool ingress);
 void ksz8_get_caps(struct ksz_device *dev, int port,
 		   struct phylink_config *config);
 void ksz8_config_cpu_port(struct dsa_switch *ds);
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 61b71bcfe396..9f52137c3f38 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1312,45 +1312,45 @@ int ksz8_port_vlan_del(struct ksz_device *dev, int port,
 	return 0;
 }
 
-int ksz8_port_mirror_add(struct ksz_device *dev, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror,
-			 bool ingress, struct netlink_ext_ack *extack)
+int ksz8_port_mirror_add(struct ksz_device *dev, int from_port,
+			 int to_port, bool ingress,
+			 struct netlink_ext_ack *extack)
 {
 	if (ingress) {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, true);
-		dev->mirror_rx |= BIT(port);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_RX, true);
+		dev->mirror_rx |= BIT(from_port);
 	} else {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, true);
-		dev->mirror_tx |= BIT(port);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_TX, true);
+		dev->mirror_tx |= BIT(from_port);
 	}
 
-	ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_SNIFFER, false);
+	ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_SNIFFER, false);
 
 	/* configure mirror port */
 	if (dev->mirror_rx || dev->mirror_tx)
-		ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+		ksz_port_cfg(dev, to_port, P_MIRROR_CTRL,
 			     PORT_MIRROR_SNIFFER, true);
 
 	return 0;
 }
 
-void ksz8_port_mirror_del(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror)
+void ksz8_port_mirror_del(struct ksz_device *dev, int from_port,
+			  int to_port, bool ingress)
 {
 	u8 data;
 
-	if (mirror->ingress) {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, false);
-		dev->mirror_rx &= ~BIT(port);
+	if (ingress) {
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_RX, false);
+		dev->mirror_rx &= ~BIT(from_port);
 	} else {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, false);
-		dev->mirror_tx &= ~BIT(port);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_TX, false);
+		dev->mirror_tx &= ~BIT(from_port);
 	}
 
-	ksz_pread8(dev, port, P_MIRROR_CTRL, &data);
+	ksz_pread8(dev, from_port, P_MIRROR_CTRL, &data);
 
 	if (!dev->mirror_rx && !dev->mirror_tx)
-		ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+		ksz_port_cfg(dev, to_port, P_MIRROR_CTRL,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 7f745628c84d..a5c7e177e5d4 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1003,9 +1003,9 @@ int ksz9477_mdb_del(struct ksz_device *dev, int port,
 	return ret;
 }
 
-int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
-			    struct dsa_mall_mirror_tc_entry *mirror,
-			    bool ingress, struct netlink_ext_ack *extack)
+int ksz9477_port_mirror_add(struct ksz_device *dev, int from_port,
+			    int to_port, bool ingress,
+			    struct netlink_ext_ack *extack)
 {
 	u8 data;
 	int p;
@@ -1016,7 +1016,7 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 	 */
 	for (p = 0; p < dev->info->port_cnt; p++) {
 		/* Skip the current sniffing port */
-		if (p == mirror->to_local_port)
+		if (p == to_port)
 			continue;
 
 		ksz_pread8(dev, p, P_MIRROR_CTRL, &data);
@@ -1029,12 +1029,12 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 	}
 
 	if (ingress)
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, true);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_RX, true);
 	else
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, true);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_TX, true);
 
 	/* configure mirror port */
-	ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+	ksz_port_cfg(dev, to_port, P_MIRROR_CTRL,
 		     PORT_MIRROR_SNIFFER, true);
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
@@ -1042,17 +1042,17 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
-			     struct dsa_mall_mirror_tc_entry *mirror)
+void ksz9477_port_mirror_del(struct ksz_device *dev, int from_port,
+			     int to_port, bool ingress)
 {
 	bool in_use = false;
 	u8 data;
 	int p;
 
-	if (mirror->ingress)
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, false);
+	if (ingress)
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_RX, false);
 	else
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, false);
+		ksz_port_cfg(dev, from_port, P_MIRROR_CTRL, PORT_MIRROR_TX, false);
 
 
 	/* Check if any of the port is still referring to sniffer port */
@@ -1067,7 +1067,7 @@ void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 
 	/* delete sniffing if there are no other mirroring rules */
 	if (!in_use)
-		ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+		ksz_port_cfg(dev, to_port, P_MIRROR_CTRL,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index ce1e656b800b..2d74b30482e0 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -31,11 +31,11 @@ int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
 			  struct netlink_ext_ack *extack);
 int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
 			  const struct switchdev_obj_port_vlan *vlan);
-int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
-			    struct dsa_mall_mirror_tc_entry *mirror,
-			    bool ingress, struct netlink_ext_ack *extack);
-void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
-			     struct dsa_mall_mirror_tc_entry *mirror);
+int ksz9477_port_mirror_add(struct ksz_device *dev, int from_port,
+			    int to_port, bool ingress,
+			    struct netlink_ext_ack *extack);
+void ksz9477_port_mirror_del(struct ksz_device *dev, int from_port,
+			     int to_port, bool ingress);
 void ksz9477_get_caps(struct ksz_device *dev, int port,
 		      struct phylink_config *config);
 int ksz9477_fdb_dump(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 245dfb7a7a31..824bfb0ed0ad 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2770,25 +2770,25 @@ static int ksz_port_vlan_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->vlan_del(dev, port, vlan);
 }
 
-static int ksz_port_mirror_add(struct dsa_switch *ds, int port,
-			       struct dsa_mall_mirror_tc_entry *mirror,
-			       bool ingress, struct netlink_ext_ack *extack)
+static int ksz_port_mirror_add(struct dsa_switch *ds, int from_port,
+			       int to_port, bool ingress,
+			       struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 
 	if (!dev->dev_ops->mirror_add)
 		return -EOPNOTSUPP;
 
-	return dev->dev_ops->mirror_add(dev, port, mirror, ingress, extack);
+	return dev->dev_ops->mirror_add(dev, from_port, to_port, ingress, extack);
 }
 
-static void ksz_port_mirror_del(struct dsa_switch *ds, int port,
-				struct dsa_mall_mirror_tc_entry *mirror)
+static void ksz_port_mirror_del(struct dsa_switch *ds, int from_port,
+				int to_port, bool ingress)
 {
 	struct ksz_device *dev = ds->priv;
 
 	if (dev->dev_ops->mirror_del)
-		dev->dev_ops->mirror_del(dev, port, mirror);
+		dev->dev_ops->mirror_del(dev, from_port, to_port, ingress);
 }
 
 static int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 15612101a155..295560eea10d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -325,11 +325,10 @@ struct ksz_dev_ops {
 			 struct netlink_ext_ack *extack);
 	int  (*vlan_del)(struct ksz_device *dev, int port,
 			 const struct switchdev_obj_port_vlan *vlan);
-	int (*mirror_add)(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror,
+	int (*mirror_add)(struct ksz_device *dev, int from_port, int to_port,
 			  bool ingress, struct netlink_ext_ack *extack);
-	void (*mirror_del)(struct ksz_device *dev, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror);
+	void (*mirror_del)(struct ksz_device *dev, int from_port,
+			   int to_port, bool ingress);
 	int (*fdb_add)(struct ksz_device *dev, int port,
 		       const unsigned char *addr, u16 vid, struct dsa_db db);
 	int (*fdb_del)(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 391c4dbdff42..9e284edfbd0e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1760,16 +1760,16 @@ static int mt753x_mirror_port_set(unsigned int id, u32 val)
 				   MIRROR_PORT(val);
 }
 
-static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
-				  struct dsa_mall_mirror_tc_entry *mirror,
-				  bool ingress, struct netlink_ext_ack *extack)
+static int mt753x_port_mirror_add(struct dsa_switch *ds, int from_port,
+				  int to_port, bool ingress,
+				  struct netlink_ext_ack *extack)
 {
 	struct mt7530_priv *priv = ds->priv;
 	int monitor_port;
 	u32 val;
 
 	/* Check for existent entry */
-	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
+	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(from_port))
 		return -EEXIST;
 
 	val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
@@ -1777,42 +1777,42 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	/* MT7530 only supports one monitor port */
 	monitor_port = mt753x_mirror_port_get(priv->id, val);
 	if (val & MT753X_MIRROR_EN(priv->id) &&
-	    monitor_port != mirror->to_local_port)
+	    monitor_port != to_port)
 		return -EEXIST;
 
 	val |= MT753X_MIRROR_EN(priv->id);
 	val &= ~MT753X_MIRROR_MASK(priv->id);
-	val |= mt753x_mirror_port_set(priv->id, mirror->to_local_port);
+	val |= mt753x_mirror_port_set(priv->id, to_port);
 	mt7530_write(priv, MT753X_MIRROR_REG(priv->id), val);
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
+	val = mt7530_read(priv, MT7530_PCR_P(from_port));
 	if (ingress) {
 		val |= PORT_RX_MIR;
-		priv->mirror_rx |= BIT(port);
+		priv->mirror_rx |= BIT(from_port);
 	} else {
 		val |= PORT_TX_MIR;
-		priv->mirror_tx |= BIT(port);
+		priv->mirror_tx |= BIT(from_port);
 	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
+	mt7530_write(priv, MT7530_PCR_P(from_port), val);
 
 	return 0;
 }
 
-static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
-				   struct dsa_mall_mirror_tc_entry *mirror)
+static void mt753x_port_mirror_del(struct dsa_switch *ds, int from_port,
+				   int to_port, bool ingress)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 val;
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
-	if (mirror->ingress) {
+	val = mt7530_read(priv, MT7530_PCR_P(from_port));
+	if (ingress) {
 		val &= ~PORT_RX_MIR;
-		priv->mirror_rx &= ~BIT(port);
+		priv->mirror_rx &= ~BIT(from_port);
 	} else {
 		val &= ~PORT_TX_MIR;
-		priv->mirror_tx &= ~BIT(port);
+		priv->mirror_tx &= ~BIT(from_port);
 	}
-	mt7530_write(priv, MT7530_PCR_P(port), val);
+	mt7530_write(priv, MT7530_PCR_P(from_port), val);
 
 	if (!priv->mirror_rx && !priv->mirror_tx) {
 		val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 383b3c4d6f59..b8820b31d05b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6480,9 +6480,8 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int port,
-				     struct dsa_mall_mirror_tc_entry *mirror,
-				     bool ingress,
+static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int from_port,
+				     int to_port, bool ingress,
 				     struct netlink_ext_ack *extack)
 {
 	enum mv88e6xxx_egress_direction direction = ingress ?
@@ -6495,7 +6494,7 @@ static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int port,
 
 	mutex_lock(&chip->reg_lock);
 	if ((ingress ? chip->ingress_dest_port : chip->egress_dest_port) !=
-	    mirror->to_local_port) {
+	    to_port) {
 		for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
 			other_mirrors |= ingress ?
 					 chip->ports[i].mirror_ingress :
@@ -6508,22 +6507,22 @@ static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int port,
 		}
 
 		err = mv88e6xxx_set_egress_port(chip, direction,
-						mirror->to_local_port);
+						to_port);
 		if (err)
 			goto out;
 	}
 
-	err = mv88e6xxx_port_set_mirror(chip, port, direction, true);
+	err = mv88e6xxx_port_set_mirror(chip, from_port, direction, true);
 out:
 	mutex_unlock(&chip->reg_lock);
 
 	return err;
 }
 
-static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int port,
-				      struct dsa_mall_mirror_tc_entry *mirror)
+static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int from_port,
+				      int to_port, bool ingress)
 {
-	enum mv88e6xxx_egress_direction direction = mirror->ingress ?
+	enum mv88e6xxx_egress_direction direction = ingress ?
 						MV88E6XXX_EGRESS_DIR_INGRESS :
 						MV88E6XXX_EGRESS_DIR_EGRESS;
 	struct mv88e6xxx_chip *chip = ds->priv;
@@ -6531,18 +6530,18 @@ static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int port,
 	int i;
 
 	mutex_lock(&chip->reg_lock);
-	if (mv88e6xxx_port_set_mirror(chip, port, direction, false))
-		dev_err(ds->dev, "p%d: failed to disable mirroring\n", port);
+	if (mv88e6xxx_port_set_mirror(chip, from_port, direction, false))
+		dev_err(ds->dev, "p%d: failed to disable mirroring\n", from_port);
 
 	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
-		other_mirrors |= mirror->ingress ?
+		other_mirrors |= ingress ?
 				 chip->ports[i].mirror_ingress :
 				 chip->ports[i].mirror_egress;
 
 	/* Reset egress port when no other mirror is active */
 	if (!other_mirrors) {
 		if (mv88e6xxx_set_egress_port(chip, direction,
-					      dsa_upstream_port(ds, port)))
+					      dsa_upstream_port(ds, from_port)))
 			dev_err(ds->dev, "failed to set egress port\n");
 	}
 
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 61e95487732d..c3d21e06bde3 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1853,22 +1853,22 @@ static void felix_port_policer_del(struct dsa_switch *ds, int port)
 	ocelot_port_policer_del(ocelot, port);
 }
 
-static int felix_port_mirror_add(struct dsa_switch *ds, int port,
-				 struct dsa_mall_mirror_tc_entry *mirror,
-				 bool ingress, struct netlink_ext_ack *extack)
+static int felix_port_mirror_add(struct dsa_switch *ds, int from_port,
+				 int to_port, bool ingress,
+				 struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
 
-	return ocelot_port_mirror_add(ocelot, port, mirror->to_local_port,
+	return ocelot_port_mirror_add(ocelot, from_port, to_port,
 				      ingress, extack);
 }
 
-static void felix_port_mirror_del(struct dsa_switch *ds, int port,
-				  struct dsa_mall_mirror_tc_entry *mirror)
+static void felix_port_mirror_del(struct dsa_switch *ds, int from_port,
+				  int to_port, bool ingress)
 {
 	struct ocelot *ocelot = ds->priv;
 
-	ocelot_port_mirror_del(ocelot, port, mirror->ingress);
+	ocelot_port_mirror_del(ocelot, from_port, ingress);
 }
 
 static int felix_port_setup_tc(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 2358cd399c7e..4ff6763a81ce 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -884,16 +884,16 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 	return qca8k_fdb_search_and_del(priv, BIT(port), addr, vid);
 }
 
-int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror,
-			  bool ingress, struct netlink_ext_ack *extack)
+int qca8k_port_mirror_add(struct dsa_switch *ds, int from_port,
+			  int to_port, bool ingress,
+			  struct netlink_ext_ack *extack)
 {
 	struct qca8k_priv *priv = ds->priv;
 	int monitor_port, ret;
 	u32 reg, val;
 
 	/* Check for existent entry */
-	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
+	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(from_port))
 		return -EEXIST;
 
 	ret = regmap_read(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0, &val);
@@ -905,22 +905,22 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 	 * When no mirror port is set, the values is set to 0xF
 	 */
 	monitor_port = FIELD_GET(QCA8K_GLOBAL_FW_CTRL0_MIRROR_PORT_NUM, val);
-	if (monitor_port != 0xF && monitor_port != mirror->to_local_port)
+	if (monitor_port != 0xF && monitor_port != to_port)
 		return -EEXIST;
 
 	/* Set the monitor port */
 	val = FIELD_PREP(QCA8K_GLOBAL_FW_CTRL0_MIRROR_PORT_NUM,
-			 mirror->to_local_port);
+			 to_port);
 	ret = regmap_update_bits(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0,
 				 QCA8K_GLOBAL_FW_CTRL0_MIRROR_PORT_NUM, val);
 	if (ret)
 		return ret;
 
 	if (ingress) {
-		reg = QCA8K_PORT_LOOKUP_CTRL(port);
+		reg = QCA8K_PORT_LOOKUP_CTRL(from_port);
 		val = QCA8K_PORT_LOOKUP_ING_MIRROR_EN;
 	} else {
-		reg = QCA8K_REG_PORT_HOL_CTRL1(port);
+		reg = QCA8K_REG_PORT_HOL_CTRL1(from_port);
 		val = QCA8K_PORT_HOL_CTRL1_EG_MIRROR_EN;
 	}
 
@@ -932,25 +932,25 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
 	 * mirror port has to be disabled.
 	 */
 	if (ingress)
-		priv->mirror_rx |= BIT(port);
+		priv->mirror_rx |= BIT(from_port);
 	else
-		priv->mirror_tx |= BIT(port);
+		priv->mirror_tx |= BIT(from_port);
 
 	return 0;
 }
 
-void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror)
+void qca8k_port_mirror_del(struct dsa_switch *ds, int from_port,
+			   int to_port, bool ingress)
 {
 	struct qca8k_priv *priv = ds->priv;
 	u32 reg, val;
 	int ret;
 
-	if (mirror->ingress) {
-		reg = QCA8K_PORT_LOOKUP_CTRL(port);
+	if (ingress) {
+		reg = QCA8K_PORT_LOOKUP_CTRL(from_port);
 		val = QCA8K_PORT_LOOKUP_ING_MIRROR_EN;
 	} else {
-		reg = QCA8K_REG_PORT_HOL_CTRL1(port);
+		reg = QCA8K_REG_PORT_HOL_CTRL1(from_port);
 		val = QCA8K_PORT_HOL_CTRL1_EG_MIRROR_EN;
 	}
 
@@ -958,10 +958,10 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 	if (ret)
 		goto err;
 
-	if (mirror->ingress)
-		priv->mirror_rx &= ~BIT(port);
+	if (ingress)
+		priv->mirror_rx &= ~BIT(from_port);
 	else
-		priv->mirror_tx &= ~BIT(port);
+		priv->mirror_tx &= ~BIT(from_port);
 
 	/* No port set to send packet to mirror port. Disable mirror port */
 	if (!priv->mirror_rx && !priv->mirror_tx) {
@@ -972,7 +972,7 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
 			goto err;
 	}
 err:
-	dev_err(priv->dev, "Failed to del mirror port from %d", port);
+	dev_err(priv->dev, "Failed to del mirror port from %d", from_port);
 }
 
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 2ac7e88f8da5..7c6e75a37e13 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -569,11 +569,11 @@ int qca8k_port_mdb_del(struct dsa_switch *ds, int port,
 		       struct dsa_db db);
 
 /* Common port mirror function */
-int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror,
-			  bool ingress, struct netlink_ext_ack *extack);
-void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror);
+int qca8k_port_mirror_add(struct dsa_switch *ds, int from_port,
+			  int to_port, bool ingress,
+			  struct netlink_ext_ack *extack);
+void qca8k_port_mirror_del(struct dsa_switch *ds, int from_port,
+			   int to_port, bool ingress);
 
 /* Common port VLAN function */
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..7f4cb3a1f39d 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2895,19 +2895,18 @@ static int sja1105_mirror_apply(struct sja1105_private *priv, int from, int to,
 					    &mac[from], true);
 }
 
-static int sja1105_mirror_add(struct dsa_switch *ds, int port,
-			      struct dsa_mall_mirror_tc_entry *mirror,
+static int sja1105_mirror_add(struct dsa_switch *ds, int from_port, int to_port,
 			      bool ingress, struct netlink_ext_ack *extack)
 {
-	return sja1105_mirror_apply(ds->priv, port, mirror->to_local_port,
+	return sja1105_mirror_apply(ds->priv, from_port, to_port,
 				    ingress, true);
 }
 
-static void sja1105_mirror_del(struct dsa_switch *ds, int port,
-			       struct dsa_mall_mirror_tc_entry *mirror)
+static void sja1105_mirror_del(struct dsa_switch *ds, int from_port,
+			       int to_port, bool ingress)
 {
-	sja1105_mirror_apply(ds->priv, port, mirror->to_local_port,
-			     mirror->ingress, false);
+	sja1105_mirror_apply(ds->priv, from_port, to_port,
+			     ingress, false);
 }
 
 static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 82135fbdb1e6..c1fbe89f8f81 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -207,7 +207,7 @@ enum dsa_port_mall_action_type {
 
 /* TC mirroring entry */
 struct dsa_mall_mirror_tc_entry {
-	u8 to_local_port;
+	struct dsa_port *to_port;
 	bool ingress;
 };
 
@@ -1098,11 +1098,11 @@ struct dsa_switch_ops {
 				  struct flow_cls_offload *cls, bool ingress);
 	int	(*cls_flower_stats)(struct dsa_switch *ds, int port,
 				    struct flow_cls_offload *cls, bool ingress);
-	int	(*port_mirror_add)(struct dsa_switch *ds, int port,
-				   struct dsa_mall_mirror_tc_entry *mirror,
-				   bool ingress, struct netlink_ext_ack *extack);
-	void	(*port_mirror_del)(struct dsa_switch *ds, int port,
-				   struct dsa_mall_mirror_tc_entry *mirror);
+	int	(*port_mirror_add)(struct dsa_switch *ds, int from_port,
+				   int to_port, bool ingress,
+				   struct netlink_ext_ack *extack);
+	void	(*port_mirror_del)(struct dsa_switch *ds, int from_port,
+				   int to_port, bool ingress);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
 				    struct dsa_mall_policer_tc_entry *policer);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index b738a466e2dc..ce73d0a5140d 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1399,10 +1399,10 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 
 	to_dp = dsa_user_to_port(act->dev);
 
-	mirror->to_local_port = to_dp->index;
+	mirror->to_port = to_dp;
 	mirror->ingress = ingress;
 
-	err = ds->ops->port_mirror_add(ds, dp->index, mirror, ingress, extack);
+	err = ds->ops->port_mirror_add(ds, dp->index, to_dp->index, ingress, extack);
 	if (err) {
 		kfree(mall_tc_entry);
 		return err;
@@ -1506,9 +1506,14 @@ static void dsa_user_del_cls_matchall(struct net_device *dev,
 
 	switch (mall_tc_entry->type) {
 	case DSA_PORT_MALL_MIRROR:
-		if (ds->ops->port_mirror_del)
+		if (ds->ops->port_mirror_del) {
+			struct dsa_mall_mirror_tc_entry *mirror;
+
+			mirror = &mall_tc_entry->mirror;
 			ds->ops->port_mirror_del(ds, dp->index,
-						 &mall_tc_entry->mirror);
+						 mirror->to_port->index,
+						 mirror->ingress);
+		}
 		break;
 	case DSA_PORT_MALL_POLICER:
 		if (ds->ops->port_policer_del)
-- 
2.11.0


