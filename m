Return-Path: <netdev+bounces-122236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D196296082C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021481C2249F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB419E7F7;
	Tue, 27 Aug 2024 11:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50220155CBD;
	Tue, 27 Aug 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756969; cv=none; b=JjWfTtP3IcVjvyqN3C0fCtdNBZqOMpj88/CRJnZ4e9Qe3nHWu7vccvXoVvzJbgL3pk7p8kWI1SS4UiIPa16Z2JopGu3RNlv1b0OnXQxNM8xZTER3FjbDzCJJ+AEC3rWkRkl9RWqsqyXYzelde6+Zw3ILgAxGseWNKw9Os+n28vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756969; c=relaxed/simple;
	bh=PdMJ5jq94W/cyeA0sG/y6XtCYIzmRzUqoU7jpguSzxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+FvwYWvo7n5CtSaxB6Gn6EblqGz3mPyeJW0KfZlLIryBF9G/3WIcbKmXFW69V95PoUocx1JR96B06Fv7K0JsCA7TuaATUxIfnCS0DPqPz/nIu7MDZ544+rhCEeC3fha9YmpKzCcVv+2wZ5DxjZMA0vmoVcGn0UYT3dKV4drEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai; spf=pass smtp.mailfrom=inceptio.ai; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inceptio.ai
Received: from localhost.localdomain(mailfrom:junjie.wan@inceptio.ai fp:SMTPD_---.Z3h7DYF_1724756935)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 19:09:14 +0800
From: Wan Junjie <junjie.wan@inceptio.ai>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"junjie.wan" <junjie.wan@inceptio.ai>
Subject: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
Date: Tue, 27 Aug 2024 19:08:55 +0800
Message-Id: <20240827110855.3186502-1-junjie.wan@inceptio.ai>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "junjie.wan" <junjie.wan@inceptio.ai>

Currently, dpaa2 switch only cares dst mac and egress interface
in fdb. And all ports with different vlans share the same FDB.

This will make things messed up when one device connected to
dpaa2 switch via two interfaces. Ports get two different vlans
assigned. These two ports will race for a same dst mac entry
since multiple vlans share one FDB.

Fdb below may not show up at the same time.
02:00:77:88:99:aa dev swp0 self
02:00:77:88:99:aa dev swp1 self
But in fact, for rules on the bridge, they should be:
02:00:77:88:99:aa dev swp0 vlan 10 master br0
02:00:77:88:99:aa dev swp1 vlan 20 master br0

This patch address this by borrowing unused form ports' fdb
when ports join bridge. And append offload flag to hardware
offloaded rules so we can tell them from those on bridges.

Signed-off-by: junjie.wan <junjie.wan@inceptio.ai>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 217 ++++++++++++++----
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |   3 +-
 2 files changed, 169 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a293b08f36d4..8b8feb19579d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -25,8 +25,17 @@
 
 #define DEFAULT_VLAN_ID			1
 
-static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
+static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)
 {
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int i;
+
+	if (port_priv->fdb->bridge_dev) {
+		for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
+			if (ethsw->fdbs[i].vid == vid)
+				return ethsw->fdbs[i].fdb_id;
+	}
+	/* Default vlan, use port's fdb id directly*/
 	return port_priv->fdb->fdb_id;
 }
 
@@ -34,7 +43,7 @@ static struct dpaa2_switch_fdb *dpaa2_switch_fdb_get_unused(struct ethsw_core *e
 {
 	int i;
 
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
 		if (!ethsw->fdbs[i].in_use)
 			return &ethsw->fdbs[i];
 	return NULL;
@@ -126,16 +135,28 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
 					   struct dpsw_egress_flood_cfg *cfg)
 {
 	int i = 0, j;
+	u16 vid = 4096;
 
 	memset(cfg, 0, sizeof(*cfg));
 
+	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
+		if (ethsw->fdbs[i].fdb_id == fdb_id) {
+			vid = ethsw->fdbs[i].vid;
+			break;
+		}
+	}
+
+	i = 0;
 	/* Add all the DPAA2 switch ports found in the same bridging domain to
 	 * the egress flooding domain
 	 */
 	for (j = 0; j < ethsw->sw_attr.num_ifs; j++) {
 		if (!ethsw->ports[j])
 			continue;
-		if (ethsw->ports[j]->fdb->fdb_id != fdb_id)
+
+		if (vid == 4096 && ethsw->ports[j]->fdb->fdb_id != fdb_id)
+			continue;
+		if (vid < 4096 && !(ethsw->ports[j]->vlans[vid] & ETHSW_VLAN_MEMBER))
 			continue;
 
 		if (type == DPSW_BROADCAST && ethsw->ports[j]->bcast_flood)
@@ -155,7 +176,7 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
 static int dpaa2_switch_fdb_set_egress_flood(struct ethsw_core *ethsw, u16 fdb_id)
 {
 	struct dpsw_egress_flood_cfg flood_cfg;
-	int err;
+	int err, i;
 
 	/* Setup broadcast flooding domain */
 	dpaa2_switch_fdb_get_flood_cfg(ethsw, fdb_id, DPSW_BROADCAST, &flood_cfg);
@@ -191,10 +212,38 @@ static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
 static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_fdb_cfg fdb_cfg = {0};
 	struct dpsw_vlan_cfg vcfg = {0};
+	struct dpaa2_switch_fdb *fdb;
+	u16 fdb_id;
 	int err;
 
-	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	/* If ports are under a bridge, then
+	 * Every VLAN domain should use a different fdb,
+	 * If port are standalone, and
+	 * vid is 1 this should reuse the allocated port fdb
+	 */
+	if (port_priv->fdb->bridge_dev) {
+		fdb = dpaa2_switch_fdb_get_unused(ethsw);
+		if (!fdb) {
+			/* if not available, create a new fdb */
+			err = dpsw_fdb_add(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					   &fdb_id, &fdb_cfg);
+			if (err) {
+				netdev_err(netdev, "dpsw_fdb_add err %d\n", err);
+				return err;
+			}
+			fdb->fdb_id = fdb_id;
+		}
+		fdb->vid = vid;
+		fdb->in_use = true;
+		fdb->bridge_dev = NULL;
+		vcfg.fdb_id = fdb->fdb_id;
+	} else {
+		/* Standalone, port's private fdb shared */
+		vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
+	}
 	err = dpsw_vlan_add(ethsw->mc_io, 0,
 			    ethsw->dpsw_handle, vid, &vcfg);
 	if (err) {
@@ -298,7 +347,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 	 */
 	vcfg.num_ifs = 1;
 	vcfg.if_id[0] = port_priv->idx;
-	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
 	vcfg.options |= DPSW_VLAN_ADD_IF_OPT_FDB_ID;
 	err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle, vid, &vcfg);
 	if (err) {
@@ -326,6 +375,10 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 			return err;
 	}
 
+	err = dpaa2_switch_fdb_set_egress_flood(ethsw, vcfg.fdb_id);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -379,6 +432,7 @@ static int dpaa2_switch_port_set_stp_state(struct ethsw_port_priv *port_priv, u8
 static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
 {
 	struct ethsw_port_priv *ppriv_local = NULL;
+	struct dpaa2_switch_fdb *fdb = NULL;
 	int i, err;
 
 	if (!ethsw->vlans[vid])
@@ -391,6 +445,14 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
 	}
 	ethsw->vlans[vid] = 0;
 
+	/* mark fdb as unsued for this vlan */
+	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
+		fdb = ethsw->fdbs;
+		if (fdb[i].vid == vid) {
+			fdb[i].in_use = false;
+		}
+	}
+
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		ppriv_local = ethsw->ports[i];
 		if (ppriv_local)
@@ -401,7 +463,7 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
 }
 
 static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
-					const unsigned char *addr)
+					const unsigned char *addr, u16 vid)
 {
 	struct dpsw_fdb_unicast_cfg entry = {0};
 	u16 fdb_id;
@@ -411,7 +473,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
 	entry.type = DPSW_FDB_ENTRY_STATIC;
 	ether_addr_copy(entry.mac_addr, addr);
 
-	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
 	err = dpsw_fdb_add_unicast(port_priv->ethsw_data->mc_io, 0,
 				   port_priv->ethsw_data->dpsw_handle,
 				   fdb_id, &entry);
@@ -422,7 +484,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
 }
 
 static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
-					const unsigned char *addr)
+					const unsigned char *addr, u16 vid)
 {
 	struct dpsw_fdb_unicast_cfg entry = {0};
 	u16 fdb_id;
@@ -432,10 +494,11 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
 	entry.type = DPSW_FDB_ENTRY_STATIC;
 	ether_addr_copy(entry.mac_addr, addr);
 
-	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
 	err = dpsw_fdb_remove_unicast(port_priv->ethsw_data->mc_io, 0,
 				      port_priv->ethsw_data->dpsw_handle,
 				      fdb_id, &entry);
+
 	/* Silently discard error for calling multiple times the del command */
 	if (err && err != -ENXIO)
 		netdev_err(port_priv->netdev,
@@ -444,7 +507,7 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
 }
 
 static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
-					const unsigned char *addr)
+					const unsigned char *addr, u16 vid)
 {
 	struct dpsw_fdb_multicast_cfg entry = {0};
 	u16 fdb_id;
@@ -455,7 +518,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
 	entry.num_ifs = 1;
 	entry.if_id[0] = port_priv->idx;
 
-	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
 	err = dpsw_fdb_add_multicast(port_priv->ethsw_data->mc_io, 0,
 				     port_priv->ethsw_data->dpsw_handle,
 				     fdb_id, &entry);
@@ -467,7 +530,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
 }
 
 static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
-					const unsigned char *addr)
+					const unsigned char *addr, u16 vid)
 {
 	struct dpsw_fdb_multicast_cfg entry = {0};
 	u16 fdb_id;
@@ -478,7 +541,7 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 	entry.num_ifs = 1;
 	entry.if_id[0] = port_priv->idx;
 
-	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
+	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
 	err = dpsw_fdb_remove_multicast(port_priv->ethsw_data->mc_io, 0,
 					port_priv->ethsw_data->dpsw_handle,
 					fdb_id, &entry);
@@ -778,11 +841,12 @@ struct ethsw_dump_ctx {
 };
 
 static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
-				    struct ethsw_dump_ctx *dump)
+				    struct ethsw_dump_ctx *dump, u16 vid)
 {
 	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
 	u32 seq = dump->cb->nlh->nlmsg_seq;
+	struct ethsw_port_priv *port_priv;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
 
@@ -798,7 +862,7 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
 	ndm->ndm_family  = AF_BRIDGE;
 	ndm->ndm_pad1    = 0;
 	ndm->ndm_pad2    = 0;
-	ndm->ndm_flags   = NTF_SELF;
+	ndm->ndm_flags   = NTF_SELF | NTF_OFFLOADED;
 	ndm->ndm_type    = 0;
 	ndm->ndm_ifindex = dump->dev->ifindex;
 	ndm->ndm_state   = is_dynamic ? NUD_REACHABLE : NUD_NOARP;
@@ -806,6 +870,15 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
 	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, entry->mac_addr))
 		goto nla_put_failure;
 
+	port_priv = netdev_priv(dump->dev);
+	if (port_priv->fdb && port_priv->fdb->bridge_dev) {
+		if (nla_put_u32(dump->skb, NDA_MASTER, port_priv->fdb->bridge_dev->ifindex))
+			goto nla_put_failure;
+	}
+
+	if (vid && nla_put(dump->skb, NDA_VLAN, sizeof(u16), &vid))
+		goto nla_put_failure;
+
 	nlmsg_end(dump->skb, nlh);
 
 skip:
@@ -845,6 +918,7 @@ static int dpaa2_switch_fdb_iterate(struct ethsw_port_priv *port_priv,
 	int err = 0, i;
 	u8 *dma_mem;
 	u16 fdb_id;
+	u16 vid;
 
 	fdb_dump_size = ethsw->sw_attr.max_fdb_entries * sizeof(fdb_entry);
 	dma_mem = kzalloc(fdb_dump_size, GFP_KERNEL);
@@ -859,23 +933,25 @@ static int dpaa2_switch_fdb_iterate(struct ethsw_port_priv *port_priv,
 		goto err_map;
 	}
 
-	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
-	err = dpsw_fdb_dump(ethsw->mc_io, 0, ethsw->dpsw_handle, fdb_id,
-			    fdb_dump_iova, fdb_dump_size, &num_fdb_entries);
-	if (err) {
-		netdev_err(net_dev, "dpsw_fdb_dump() = %d\n", err);
-		goto err_dump;
-	}
-
-	dma_unmap_single(dev, fdb_dump_iova, fdb_dump_size, DMA_FROM_DEVICE);
-
-	fdb_entries = (struct fdb_dump_entry *)dma_mem;
-	for (i = 0; i < num_fdb_entries; i++) {
-		fdb_entry = fdb_entries[i];
-
-		err = cb(port_priv, &fdb_entry, data);
-		if (err)
-			goto end;
+	for (vid = 0; vid <= VLAN_VID_MASK; vid++) {
+		if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER) {
+			fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
+			err = dpsw_fdb_dump(ethsw->mc_io, 0, ethsw->dpsw_handle, fdb_id,
+					    fdb_dump_iova, fdb_dump_size, &num_fdb_entries);
+			if (err) {
+				netdev_err(net_dev, "dpsw_fdb_dump() = %d\n", err);
+				goto err_dump;
+			}
+			dma_unmap_single(dev, fdb_dump_iova, fdb_dump_size, DMA_FROM_DEVICE);
+			fdb_entries = (struct fdb_dump_entry *)dma_mem;
+			for (i = 0; i < num_fdb_entries; i++) {
+				fdb_entry = fdb_entries[i];
+
+				err = cb(port_priv, &fdb_entry, vid, data);
+				if (err)
+					goto end;
+			}
+		}
 	}
 
 end:
@@ -891,13 +967,13 @@ static int dpaa2_switch_fdb_iterate(struct ethsw_port_priv *port_priv,
 }
 
 static int dpaa2_switch_fdb_entry_dump(struct ethsw_port_priv *port_priv,
-				       struct fdb_dump_entry *fdb_entry,
+				       struct fdb_dump_entry *fdb_entry, u16 vid,
 				       void *data)
 {
 	if (!dpaa2_switch_port_fdb_valid_entry(fdb_entry, port_priv))
 		return 0;
 
-	return dpaa2_switch_fdb_dump_nl(fdb_entry, data);
+	return dpaa2_switch_fdb_dump_nl(fdb_entry, data, vid);
 }
 
 static int dpaa2_switch_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
@@ -920,7 +996,7 @@ static int dpaa2_switch_port_fdb_dump(struct sk_buff *skb, struct netlink_callba
 }
 
 static int dpaa2_switch_fdb_entry_fast_age(struct ethsw_port_priv *port_priv,
-					   struct fdb_dump_entry *fdb_entry,
+					   struct fdb_dump_entry *fdb_entry, u16 vid,
 					   void *data __always_unused)
 {
 	if (!dpaa2_switch_port_fdb_valid_entry(fdb_entry, port_priv))
@@ -930,17 +1006,23 @@ static int dpaa2_switch_fdb_entry_fast_age(struct ethsw_port_priv *port_priv,
 		return 0;
 
 	if (fdb_entry->type & DPSW_FDB_ENTRY_TYPE_UNICAST)
-		dpaa2_switch_port_fdb_del_uc(port_priv, fdb_entry->mac_addr);
+		dpaa2_switch_port_fdb_del_uc(port_priv, fdb_entry->mac_addr, vid);
 	else
-		dpaa2_switch_port_fdb_del_mc(port_priv, fdb_entry->mac_addr);
+		dpaa2_switch_port_fdb_del_mc(port_priv, fdb_entry->mac_addr, vid);
 
 	return 0;
 }
 
 static void dpaa2_switch_port_fast_age(struct ethsw_port_priv *port_priv)
 {
-	dpaa2_switch_fdb_iterate(port_priv,
-				 dpaa2_switch_fdb_entry_fast_age, NULL);
+	u16 vid;
+
+	for (vid = 0; vid <= VLAN_VID_MASK; vid++) {
+		if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER) {
+			dpaa2_switch_fdb_iterate(port_priv,
+						 dpaa2_switch_fdb_entry_fast_age, NULL);
+		}
+	}
 }
 
 static int dpaa2_switch_port_vlan_add(struct net_device *netdev, __be16 proto,
@@ -1670,10 +1752,24 @@ static int dpaa2_switch_port_attr_stp_state_set(struct net_device *netdev,
 	return err;
 }
 
+static int dpaa2_switch_port_flood_vlan(struct net_device *vdev, int vid, void *arg)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(arg);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+
+	if (!vdev)
+		return -ENODEV;
+
+	return dpaa2_switch_fdb_set_egress_flood(ethsw,
+						  dpaa2_switch_port_get_fdb_id(port_priv, vid));
+}
+
 static int dpaa2_switch_port_flood(struct ethsw_port_priv *port_priv,
 				   struct switchdev_brport_flags flags)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	int err;
 
 	if (flags.mask & BR_BCAST_FLOOD)
 		port_priv->bcast_flood = !!(flags.val & BR_BCAST_FLOOD);
@@ -1681,6 +1777,12 @@ static int dpaa2_switch_port_flood(struct ethsw_port_priv *port_priv,
 	if (flags.mask & BR_FLOOD)
 		port_priv->ucast_flood = !!(flags.val & BR_FLOOD);
 
+	/* Recreate the egress flood domain of every vlan domain */
+	err = vlan_for_each(netdev, dpaa2_switch_port_flood_vlan, netdev);
+	if (err)
+		netdev_err(netdev, "Unable to restore vlan flood err (%d)\n", err);
+		return err;
+
 	return dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
 }
 
@@ -1838,14 +1940,14 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr, mdb->vid);
 	if (err)
 		return err;
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr, mdb->vid);
 	}
 
 	return err;
@@ -1879,6 +1981,7 @@ static int dpaa2_switch_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid
 	struct net_device *netdev = port_priv->netdev;
 	struct dpsw_vlan_if_cfg vcfg;
 	int i, err;
+	u16 fdb_id;
 
 	if (!port_priv->vlans[vid])
 		return -ENOENT;
@@ -1917,6 +2020,12 @@ static int dpaa2_switch_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid
 		}
 		port_priv->vlans[vid] &= ~ETHSW_VLAN_MEMBER;
 
+		/* VLAN's member changes, recreate the egress flood domain */
+		fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
+		err = dpaa2_switch_fdb_set_egress_flood(ethsw, fdb_id);
+		if (err)
+			return err;
+
 		/* Delete VLAN from switch if it is no longer configured on
 		 * any port
 		 */
@@ -1956,7 +2065,7 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr, mdb->vid);
 	if (err)
 		return err;
 
@@ -2010,7 +2119,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	int err;
 
 	/* Delete the previously manually installed VLAN 1 */
-	err = dpaa2_switch_port_del_vlan(port_priv, 1);
+	err = dpaa2_switch_port_del_vlan(port_priv, DEFAULT_VLAN_ID);
 	if (err)
 		return err;
 
@@ -2027,6 +2136,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	/* Recreate the egress flood domain of the FDB that we just left. */
+	/* Not really need, since standalone fdb will be used by others */
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
 	if (err)
 		goto err_egress_flood;
@@ -2109,7 +2219,10 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	if (err)
 		return err;
 
-	/* Recreate the egress flood domain of the FDB that we just left */
+	/* Recreate the egress flood domain of the FDB that we just left,
+	 * only recreate for the default one, as for vlan domain, already created
+	 * in the restore process.
+	 */
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, old_fdb->fdb_id);
 	if (err)
 		return err;
@@ -2278,10 +2391,10 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
-							   fdb_info->addr);
+							   fdb_info->addr, fdb_info->vid);
 		else
 			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
-							   fdb_info->addr);
+							   fdb_info->addr, fdb_info->vid);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
@@ -2292,9 +2405,11 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 		if (!fdb_info->added_by_user || fdb_info->is_local)
 			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
-			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
+			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr,
+						     fdb_info->vid);
 		else
-			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr,
+						     fdb_info->vid);
 		break;
 	}
 
@@ -3183,6 +3298,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	fdb->fdb_id = fdb_id;
 	fdb->in_use = true;
 	fdb->bridge_dev = NULL;
+	fdb->vid = 4096;	// a mark as default standalone
 	port_priv->fdb = fdb;
 
 	/* We need to add VLAN 1 as the PVID on this port until it is under a
@@ -3194,6 +3310,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 		return err;
 
 	/* Setup the egress flooding domains (broadcast, unknown unicast */
+	/* not under bridge yet, using port_priv fdb */
 	err = dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
 	if (err)
 		return err;
@@ -3395,7 +3512,7 @@ static int dpaa2_switch_probe(struct fsl_mc_device *sw_dev)
 		goto err_teardown;
 	}
 
-	ethsw->fdbs = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->fdbs),
+	ethsw->fdbs = kcalloc(ethsw->sw_attr.max_fdbs, sizeof(*ethsw->fdbs),
 			      GFP_KERNEL);
 	if (!ethsw->fdbs) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
index 42b3ca73f55d..026ba2cf0e35 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h
@@ -102,6 +102,7 @@ struct dpaa2_switch_fq {
 struct dpaa2_switch_fdb {
 	struct net_device	*bridge_dev;
 	u16			fdb_id;
+	u16			vid;
 	bool			in_use;
 };
 
@@ -249,7 +250,7 @@ int dpaa2_switch_port_vlans_del(struct net_device *netdev,
 				const struct switchdev_obj_port_vlan *vlan);
 
 typedef int dpaa2_switch_fdb_cb_t(struct ethsw_port_priv *port_priv,
-				  struct fdb_dump_entry *fdb_entry,
+				  struct fdb_dump_entry *fdb_entry, u16 vid,
 				  void *data);
 
 /* TC offload */
-- 
2.25.1


