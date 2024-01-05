Return-Path: <netdev+bounces-61879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DD82525F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763E31C231B6
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973725101;
	Fri,  5 Jan 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="XnFtutQw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CE28DAF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uVkE2PaB5WPvkFimUxqZdzTwgmlfHMesBq1mf//tAOQ=; b=XnFtutQwUGAPlrcBZQx/TCpdg+
	rxoQQhE123pWu4Kq2oL48lLyJ7umtEk/aRHEoy4i77qgVr3KeDhMoe2UdbYYIlct5kj2S2nwXM0WK
	UKvFwv/EXMqH+SboZpcoCadFrRf5m8zwt8WibI8DR6xJSFYSeRpuzVmtlvJfUF1O93aNwhQyroMoN
	GNHgN6olvD5VjwvHnb51g9mt0JiVeFuHRJ/VoA6EGd/LcUkuea/9sk7CD3vsov3J/X+LWnVWhe+Yg
	b6euEOnxOHgXBLsvoNa0I3b+pC5ZO30phqtZY5+E5yi44QaS49K0QcptJqt5l804CKwcTdaDp1YFl
	mJfW1LHg==;
Received: from [192.168.1.4] (port=44811 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhia-0000f2-38;
	Fri, 05 Jan 2024 11:46:25 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:24 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 4/6] net: dsa: check for busy mirror ports when removing mirroring action
Date: Fri, 5 Jan 2024 11:46:17 +0100
Message-ID: <e315723f5bf03efcf7819d1740ad2cd1b2aac2c9.1704449760.git.ante.knezic@helmholz.de>
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

Check if the source/destination mirror ports are being used by
another mirroring route. This is necessary as otherwise we
might be interfering with mirroring operation of another mirror
route.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/b53/b53_common.c       |  3 ++-
 drivers/net/dsa/b53/b53_priv.h         |  2 +-
 drivers/net/dsa/microchip/ksz_common.c |  3 ++-
 drivers/net/dsa/mt7530.c               |  3 ++-
 drivers/net/dsa/mv88e6xxx/chip.c       |  3 ++-
 drivers/net/dsa/ocelot/felix.c         |  3 ++-
 drivers/net/dsa/qca/qca8k-common.c     |  3 ++-
 drivers/net/dsa/qca/qca8k.h            |  3 ++-
 drivers/net/dsa/sja1105/sja1105_main.c |  3 ++-
 include/net/dsa.h                      | 10 +++++++++-
 net/dsa/switch.c                       | 34 +++++++++++++++++++++++++++++++++-
 11 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 993adbc81339..79b2c9dab77d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2155,7 +2155,8 @@ int b53_mirror_add(struct dsa_switch *ds, int from_port,
 EXPORT_SYMBOL(b53_mirror_add);
 
 void b53_mirror_del(struct dsa_switch *ds, int from_port,
-		    int to_port, bool ingress)
+		    int to_port, bool ingress,
+		    enum dsa_route_status route_status)
 {
 	struct b53_device *dev = ds->priv;
 	bool loc_disable = false, other_loc_disable = false;
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 625dafcd757b..d78b3d04ffe0 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -391,7 +391,7 @@ int b53_mirror_add(struct dsa_switch *ds, int from_port,
 enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 					   enum dsa_tag_protocol mprot);
 void b53_mirror_del(struct dsa_switch *ds, int from_port, int to_port,
-		    bool ingress);
+		    bool ingress, enum dsa_route_status route_status);
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 824bfb0ed0ad..ab2a65ba498c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2783,7 +2783,8 @@ static int ksz_port_mirror_add(struct dsa_switch *ds, int from_port,
 }
 
 static void ksz_port_mirror_del(struct dsa_switch *ds, int from_port,
-				int to_port, bool ingress)
+				int to_port, bool ingress,
+				enum dsa_route_status route_status)
 {
 	struct ksz_device *dev = ds->priv;
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9e284edfbd0e..aba020687427 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1799,7 +1799,8 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int from_port,
 }
 
 static void mt753x_port_mirror_del(struct dsa_switch *ds, int from_port,
-				   int to_port, bool ingress)
+			   int to_port, bool ingress,
+			   enum dsa_route_status route_status)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 val;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b8820b31d05b..1938f0b1644f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6520,7 +6520,8 @@ static int mv88e6xxx_port_mirror_add(struct dsa_switch *ds, int from_port,
 }
 
 static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int from_port,
-				      int to_port, bool ingress)
+				      int to_port, bool ingress,
+				      enum dsa_route_status route_status)
 {
 	enum mv88e6xxx_egress_direction direction = ingress ?
 						MV88E6XXX_EGRESS_DIR_INGRESS :
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index c3d21e06bde3..0ba9a79316d3 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1864,7 +1864,8 @@ static int felix_port_mirror_add(struct dsa_switch *ds, int from_port,
 }
 
 static void felix_port_mirror_del(struct dsa_switch *ds, int from_port,
-				  int to_port, bool ingress)
+				  int to_port, bool ingress,
+				  enum dsa_route_status route_status)
 {
 	struct ocelot *ocelot = ds->priv;
 
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 4ff6763a81ce..fc009f3c460a 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -940,7 +940,8 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int from_port,
 }
 
 void qca8k_port_mirror_del(struct dsa_switch *ds, int from_port,
-			   int to_port, bool ingress)
+			   int to_port, bool ingress,
+			   enum dsa_route_status route_status)
 {
 	struct qca8k_priv *priv = ds->priv;
 	u32 reg, val;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 7c6e75a37e13..7a4ac5d4a505 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -573,7 +573,8 @@ int qca8k_port_mirror_add(struct dsa_switch *ds, int from_port,
 			  int to_port, bool ingress,
 			  struct netlink_ext_ack *extack);
 void qca8k_port_mirror_del(struct dsa_switch *ds, int from_port,
-			   int to_port, bool ingress);
+			   int to_port, bool ingress,
+			   enum dsa_route_status route_status);
 
 /* Common port VLAN function */
 int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 7f4cb3a1f39d..bb4a703174c5 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2903,7 +2903,8 @@ static int sja1105_mirror_add(struct dsa_switch *ds, int from_port, int to_port,
 }
 
 static void sja1105_mirror_del(struct dsa_switch *ds, int from_port,
-			       int to_port, bool ingress)
+			       int to_port, bool ingress,
+			       enum dsa_route_status route_status)
 {
 	sja1105_mirror_apply(ds->priv, from_port, to_port,
 			     ingress, false);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index aa0e97150bc3..f17da56d138d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -88,6 +88,13 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
 };
 
+enum dsa_route_status {
+	DSA_ROUTE_UNUSED = 0,
+	DSA_ROUTE_SRC_PORT_BUSY = BIT(0),
+	DSA_ROUTE_DEST_PORT_BUSY = BIT(1),
+	DSA_ROUTE_BUSY = (BIT(0) | BIT(1))
+};
+
 struct dsa_switch;
 
 struct dsa_device_ops {
@@ -1120,7 +1127,8 @@ struct dsa_switch_ops {
 				   int to_port, bool ingress,
 				   struct netlink_ext_ack *extack);
 	void	(*port_mirror_del)(struct dsa_switch *ds, int from_port,
-				   int to_port, bool ingress);
+				   int to_port, bool ingress,
+				   enum dsa_route_status route_status);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
 				    struct dsa_mall_policer_tc_entry *policer);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 5a81742cb139..17d71bde5df5 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -148,9 +148,38 @@ static int dsa_switch_mirror_add(struct dsa_switch *ds,
 	return 0;
 }
 
+static enum dsa_route_status dsa_route_get_status(struct dsa_switch *ds,
+						  const struct dsa_mirror *dm,
+						  int from_port, int to_port)
+{
+	enum dsa_route_status ret;
+	struct dsa_mirror *m;
+	struct dsa_route *r;
+
+	ret = DSA_ROUTE_UNUSED;
+	list_for_each_entry(m, &ds->dst->mirrors, list) {
+		if (m == dm)
+			continue;
+		if (m->ingress != dm->ingress)
+			continue;
+
+		list_for_each_entry(r, &m->route, list) {
+			if (r->sw_index == ds->index) {
+				if (r->from_local_p == from_port)
+					ret |= DSA_ROUTE_SRC_PORT_BUSY;
+				if (r->to_local_p == to_port)
+					ret |= DSA_ROUTE_DEST_PORT_BUSY;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int dsa_switch_mirror_del(struct dsa_switch *ds,
 				 struct dsa_notifier_mirror_info *info)
 {
+	enum dsa_route_status status;
 	struct dsa_route *dr;
 	struct dsa_port *dp;
 	bool ingress;
@@ -162,9 +191,12 @@ static int dsa_switch_mirror_del(struct dsa_switch *ds,
 			ingress = info->mirror->ingress;
 			dp = dsa_to_port(ds, dr->to_local_p);
 			to_port = dp->index;
+			status = dsa_route_get_status(ds, info->mirror,
+						      dr->from_local_p,
+						      dr->to_local_p);
 
 			ds->ops->port_mirror_del(ds, dr->from_local_p,
-						 to_port, ingress);
+						 to_port, ingress, status);
 		}
 	}
 
-- 
2.11.0


