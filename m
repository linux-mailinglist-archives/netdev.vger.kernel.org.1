Return-Path: <netdev+bounces-174677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CADA5FC78
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4323B235E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0356269D1A;
	Thu, 13 Mar 2025 16:45:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405426A0E4
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884341; cv=none; b=U0B9uorkx3JgQj6qpIwmtNCM5f1de3qy6WZJwMthF1V39T082PdDB7No4MoIcboCDtoroErT2gIUU7KNKYa10yNOgPwrQo2mYjKUmQwenduxa9rw2qaUHCDdAzlJZhZ9qSEUO0D9gIIGiYAEBvbljVNpGhbG9BmwVejiUMQBaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884341; c=relaxed/simple;
	bh=TIJxzFo9i4g4QCserR6D5UVrZh9TQy5o6cFE3hxwc1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzyzl4Guk3r9ycGcv/ulLt2r7C89ATa/vtVUTru0FkuJ47Nwa6HALxoNdoS/5GrR7kCVwUPX5Wh7fp7kKzE/2xsEdVpTuSvWf2T5wK7329cNYodD2YmSBQxBhlWvqjq102J/YyPQU3WAd6VICn6HmWc27nwJS/aSa4rmiiEJhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fA272413901A38A4bc9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E3B3FA449;
	Thu, 13 Mar 2025 17:45:27 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 05/10] batman-adv: Use consistent name for mesh interface
Date: Thu, 13 Mar 2025 17:45:14 +0100
Message-Id: <20250313164519.72808-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The way how the virtual interface is called inside the batman-adv source
code is not consistent. The genl headers call it meshif and the rest of the
code calls is (mostly) softif.

The genl definitions cannot be touched because they are part of the UAPI.
But the rest of the batman-adv code can be touched to have a consistent
name again.

The bulk of the renaming was done using

  sed -i -e 's/soft\(-\|\_\| \|\)i\([nf]\)/mesh\1i\2/g' \
         -e 's/SOFT\(-\|\_\| \|\)I\([NF]\)/MESH\1I\2/g'

and then it was adjusted slightly when proofreading the changes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/networking/batman-adv.rst       |   2 +-
 include/uapi/linux/batman_adv.h               |  18 +-
 net/batman-adv/Makefile                       |   2 +-
 net/batman-adv/bat_algo.c                     |   8 +-
 net/batman-adv/bat_iv_ogm.c                   |  64 +++---
 net/batman-adv/bat_v.c                        |  28 +--
 net/batman-adv/bat_v_elp.c                    |  16 +-
 net/batman-adv/bat_v_ogm.c                    |  42 ++--
 net/batman-adv/bitarray.c                     |   2 +-
 net/batman-adv/bridge_loop_avoidance.c        | 106 +++++-----
 net/batman-adv/distributed-arp-table.c        |  68 +++---
 net/batman-adv/distributed-arp-table.h        |   4 +-
 net/batman-adv/fragmentation.c                |   2 +-
 net/batman-adv/gateway_client.c               |  38 ++--
 net/batman-adv/gateway_common.c               |   8 +-
 net/batman-adv/hard-interface.c               | 140 ++++++-------
 net/batman-adv/hard-interface.h               |  12 +-
 net/batman-adv/log.c                          |   2 +-
 net/batman-adv/log.h                          |  10 +-
 net/batman-adv/main.c                         |  42 ++--
 net/batman-adv/main.h                         |  16 +-
 .../{soft-interface.c => mesh-interface.c}    | 194 ++++++++---------
 .../{soft-interface.h => mesh-interface.h}    |  22 +-
 net/batman-adv/multicast.c                    | 182 ++++++++--------
 net/batman-adv/multicast_forw.c               |  30 +--
 net/batman-adv/netlink.c                      | 178 ++++++++--------
 net/batman-adv/netlink.h                      |   2 +-
 net/batman-adv/network-coding.c               |  64 +++---
 net/batman-adv/originator.c                   |  58 ++---
 net/batman-adv/routing.c                      |  42 ++--
 net/batman-adv/send.c                         |  34 +--
 net/batman-adv/send.h                         |   4 +-
 net/batman-adv/tp_meter.c                     |  30 +--
 net/batman-adv/trace.h                        |   2 +-
 net/batman-adv/translation-table.c            | 198 +++++++++---------
 net/batman-adv/translation-table.h            |   4 +-
 net/batman-adv/tvlv.c                         |  26 +--
 net/batman-adv/types.h                        |  46 ++--
 38 files changed, 873 insertions(+), 873 deletions(-)
 rename net/batman-adv/{soft-interface.c => mesh-interface.c} (84%)
 rename net/batman-adv/{soft-interface.h => mesh-interface.h} (50%)

diff --git a/Documentation/networking/batman-adv.rst b/Documentation/networking/batman-adv.rst
index 44b9b5cc0e24..ec53a42499c1 100644
--- a/Documentation/networking/batman-adv.rst
+++ b/Documentation/networking/batman-adv.rst
@@ -27,7 +27,7 @@ Load the batman-adv module into your kernel::
   $ insmod batman-adv.ko
 
 The module is now waiting for activation. You must add some interfaces on which
-batman-adv can operate. The batman-adv soft-interface can be created using the
+batman-adv can operate. The batman-adv mesh-interface can be created using the
 iproute2 tool ``ip``::
 
   $ ip link add name bat0 type batadv
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 35dc016c9bb4..936bcac270b5 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -342,7 +342,7 @@ enum batadv_nl_attrs {
 	BATADV_ATTR_MCAST_FLAGS_PRIV,
 
 	/**
-	 * @BATADV_ATTR_VLANID: VLAN id on top of soft interface
+	 * @BATADV_ATTR_VLANID: VLAN id on top of mesh interface
 	 */
 	BATADV_ATTR_VLANID,
 
@@ -380,7 +380,7 @@ enum batadv_nl_attrs {
 	/**
 	 * @BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED: whether the bridge loop
 	 *  avoidance feature is enabled. This feature detects and avoids loops
-	 *  between the mesh and devices bridged with the soft interface
+	 *  between the mesh and devices bridged with the mesh interface
 	 */
 	BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
 
@@ -509,7 +509,7 @@ enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
 
 	/**
-	 * @BATADV_CMD_GET_MESH: Get attributes from softif/mesh
+	 * @BATADV_CMD_GET_MESH: Get attributes from mesh(if)
 	 */
 	BATADV_CMD_GET_MESH,
 
@@ -535,7 +535,7 @@ enum batadv_nl_commands {
 
 	/**
 	 * @BATADV_CMD_GET_HARDIF: Get attributes from a hardif of the
-	 *  current softif
+	 *  current mesh(if)
 	 */
 	BATADV_CMD_GET_HARDIF,
 
@@ -591,25 +591,25 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_MCAST_FLAGS,
 
 	/**
-	 * @BATADV_CMD_SET_MESH: Set attributes for softif/mesh
+	 * @BATADV_CMD_SET_MESH: Set attributes for mesh(if)
 	 */
 	BATADV_CMD_SET_MESH,
 
 	/**
 	 * @BATADV_CMD_SET_HARDIF: Set attributes for hardif of the
-	 *  current softif
+	 *  current mesh(if)
 	 */
 	BATADV_CMD_SET_HARDIF,
 
 	/**
 	 * @BATADV_CMD_GET_VLAN: Get attributes from a VLAN of the
-	 *  current softif
+	 *  current mesh(if)
 	 */
 	BATADV_CMD_GET_VLAN,
 
 	/**
 	 * @BATADV_CMD_SET_VLAN: Set attributes for VLAN of the
-	 *  current softif
+	 *  current mesh(if)
 	 */
 	BATADV_CMD_SET_VLAN,
 
@@ -691,7 +691,7 @@ enum batadv_ifla_attrs {
 	 */
 	IFLA_BATADV_ALGO_NAME,
 
-	/* add attributes above here, update the policy in soft-interface.c */
+	/* add attributes above here, update the policy in mesh-interface.c */
 
 	/**
 	 * @__IFLA_BATADV_MAX: internal use
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index b51d8b071b56..1cc9be6de456 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -19,6 +19,7 @@ batman-adv-y += hard-interface.o
 batman-adv-y += hash.o
 batman-adv-$(CONFIG_BATMAN_ADV_DEBUG) += log.o
 batman-adv-y += main.o
+batman-adv-y += mesh-interface.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast_forw.o
 batman-adv-y += netlink.o
@@ -26,7 +27,6 @@ batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
-batman-adv-y += soft-interface.o
 batman-adv-$(CONFIG_BATMAN_ADV_TRACING) += trace.o
 batman-adv-y += tp_meter.o
 batman-adv-y += translation-table.o
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 4eee53d19eb0..c0c982b6f029 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -90,15 +90,15 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 }
 
 /**
- * batadv_algo_select() - Select algorithm of soft interface
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_algo_select() - Select algorithm of mesh interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @name: name of the algorithm to select
  *
- * The algorithm callbacks for the soft interface will be set when the algorithm
+ * The algorithm callbacks for the mesh interface will be set when the algorithm
  * with the correct name was found. Any previous selected algorithm will not be
  * deinitialized and the new selected algorithm will also not be initialized.
  * It is therefore not allowed to call batadv_algo_select outside the creation
- * function of the soft interface.
+ * function of the mesh interface.
  *
  * Return: 0 on success or negative error number in case of failure
  */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07ae5dd1f150..8513f6661dd1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -129,7 +129,7 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
 /**
  * batadv_iv_ogm_orig_get() - retrieve or create (if does not exist) an
  *  originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: mac address of the originator
  *
  * Return: the originator object corresponding to the passed mac address or NULL
@@ -333,7 +333,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 				     struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
 	s16 buff_pos;
@@ -396,20 +396,20 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
-	soft_iface = forw_packet->if_incoming->soft_iface;
+	mesh_iface = forw_packet->if_incoming->mesh_iface;
 
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
-	if (forw_packet->if_outgoing->soft_iface != soft_iface) {
-		pr_warn("%s: soft interface switch for queued OGM\n", __func__);
+	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
+		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
 		return;
 	}
 
@@ -424,7 +424,7 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
  * batadv_iv_ogm_can_aggregate() - find out if an OGM can be aggregated on an
  *  existing forward packet
  * @new_bat_ogm_packet: OGM packet to be aggregated
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @packet_len: (total) length of the OGM
  * @send_time: timestamp (jiffies) when the packet is to be sent
  * @directlink: true if this is a direct link packet
@@ -540,7 +540,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					struct batadv_hard_iface *if_outgoing,
 					int own_packet)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
 	struct sk_buff *skb;
 	unsigned char *skb_buff;
@@ -607,7 +607,7 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 
 /**
  * batadv_iv_ogm_queue_add() - queue up an OGM for transmission
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @packet_buff: pointer to the OGM
  * @packet_len: (total) length of the OGM
  * @if_incoming: interface where the packet was received
@@ -686,7 +686,7 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				  struct batadv_hard_iface *if_incoming,
 				  struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	u16 tvlv_len;
 
 	if (batadv_ogm_packet->ttl <= 1) {
@@ -739,7 +739,7 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 static void
 batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -778,7 +778,7 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
  */
 static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	unsigned char **ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
@@ -840,7 +840,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
-		if (tmp_hard_iface->soft_iface != hard_iface->soft_iface)
+		if (tmp_hard_iface->mesh_iface != hard_iface->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
@@ -901,7 +901,7 @@ static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
 /**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the orig node who originally emitted the ogm packet
  * @orig_ifinfo: ifinfo for the outgoing interface of the orig_node
  * @ethhdr: Ethernet header of the OGM
@@ -1065,7 +1065,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 				  struct batadv_hard_iface *if_incoming,
 				  struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	u8 total_count;
@@ -1207,7 +1207,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    const struct batadv_hard_iface *if_incoming,
 			    struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
 	struct batadv_neigh_node *neigh_node;
@@ -1309,7 +1309,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 				struct batadv_hard_iface *if_incoming,
 				struct batadv_hard_iface *if_outgoing)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_neigh_node *router_router = NULL;
@@ -1549,7 +1549,7 @@ static void batadv_iv_ogm_process_reply(struct batadv_ogm_packet *ogm_packet,
 static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				  struct batadv_hard_iface *if_incoming)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_orig_node *orig_neigh_node, *orig_node;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm_packet *ogm_packet;
@@ -1599,7 +1599,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != if_incoming->soft_iface)
+		if (hard_iface->mesh_iface != if_incoming->mesh_iface)
 			continue;
 
 		if (batadv_compare_eth(ethhdr->h_source,
@@ -1664,7 +1664,7 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
@@ -1690,7 +1690,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
-	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
@@ -1721,7 +1721,7 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
 				 struct batadv_hard_iface *if_incoming)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_ogm_packet *ogm_packet;
 	u8 *packet_pos;
 	int ogm_offset;
@@ -1800,7 +1800,7 @@ batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @orig_node: Originator to dump
  * @neigh_node: Single hops neighbour
@@ -1863,7 +1863,7 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @orig_node: Originator to dump
  * @sub_s: Number of sub entries to skip
@@ -1925,7 +1925,7 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @head: Bucket to be dumped
  * @idx_s: Number of entries to be skipped
@@ -1966,7 +1966,7 @@ batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  * batadv_iv_ogm_orig_dump() - Dump the originators into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  */
 static void
@@ -2088,7 +2088,7 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @hard_iface: Hard interface to dump the neighbours for
  * @idx_s: Number of entries to skip
  *
@@ -2125,7 +2125,7 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
  * batadv_iv_ogm_neigh_dump() - Dump the neighbours into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @single_hardif: Limit dump to this hard interface
  */
 static void
@@ -2152,7 +2152,7 @@ batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	} else {
 		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list,
 					list) {
-			if (hard_iface->soft_iface != bat_priv->soft_iface)
+			if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 				continue;
 
 			if (i_hardif++ < i_hardif_s)
@@ -2236,7 +2236,7 @@ static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_iv_init_sel_class() - initialize GW selection class
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
 {
@@ -2391,7 +2391,7 @@ static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @gw_node: Gateway to be dumped
  *
  * Return: Error code, or 0 on success
@@ -2466,7 +2466,7 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid,
  * batadv_iv_gw_dump() - Dump gateways into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  */
 static void batadv_iv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			      struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index d35479c465e2..c16c2e60889d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -43,7 +43,7 @@
 
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hard_iface *primary_if;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -97,7 +97,7 @@ static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
  */
 static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hard_iface *primary_if;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -166,7 +166,7 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @hard_iface: The hard interface to be dumped
  * @idx_s: Entries to be skipped
  *
@@ -203,7 +203,7 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
  *  message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @single_hardif: Limit dumping to this hard interface
  */
 static void
@@ -228,7 +228,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		}
 	} else {
 		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-			if (hard_iface->soft_iface != bat_priv->soft_iface)
+			if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 				continue;
 
 			if (i_hardif++ < i_hardif_s)
@@ -254,7 +254,7 @@ batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @orig_node: Originator to dump
  * @neigh_node: Single hops neighbour
@@ -322,7 +322,7 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @orig_node: Originator to dump
  * @sub_s: Number of sub entries to skip
@@ -374,7 +374,7 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  * @head: Bucket to be dumped
  * @idx_s: Number of entries to be skipped
@@ -414,7 +414,7 @@ batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  * batadv_v_orig_dump() - Dump the originators into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @if_outgoing: Limit dump to entries with this outgoing interface
  */
 static void
@@ -502,7 +502,7 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 
 /**
  * batadv_v_init_sel_class() - initialize GW selection class
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_v_init_sel_class(struct batadv_priv *bat_priv)
 {
@@ -553,7 +553,7 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
 
 /**
  * batadv_v_gw_get_best_gw_node() - retrieve the best GW node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: the GW node having the best GW-metric, NULL if no GW is known
  */
@@ -590,7 +590,7 @@ batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_gw_is_eligible() - check if a originator would be selected as GW
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @curr_gw_orig: originator representing the currently selected GW
  * @orig_node: the originator representing the new candidate
  *
@@ -647,7 +647,7 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @gw_node: Gateway to be dumped
  *
  * Return: Error code, or 0 on success
@@ -746,7 +746,7 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid,
  * batadv_v_gw_dump() - Dump gateways into a message
  * @msg: Netlink message to dump into
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  */
 static void batadv_v_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			     struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index b065578b4436..70d6778da0d7 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -82,7 +82,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 					u32 *pthroughput)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
-	struct net_device *soft_iface = hard_iface->soft_iface;
+	struct net_device *mesh_iface = hard_iface->mesh_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
@@ -92,7 +92,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* don't query throughput when no longer associated with any
 	 * batman-adv interface
 	 */
-	if (!soft_iface)
+	if (!mesh_iface)
 		return false;
 
 	/* if the user specified a customised value for this interface, then
@@ -180,7 +180,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(soft_iface,
+		batadv_info(mesh_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
@@ -226,7 +226,7 @@ static bool
 batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	unsigned long last_tx_diff;
 	struct sk_buff *skb;
 	int probe_len, i;
@@ -295,7 +295,7 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
-	bat_priv = netdev_priv(hard_iface->soft_iface);
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
@@ -476,7 +476,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 	/* update orig field of every elp iface belonging to this mesh */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (primary_iface->soft_iface != hard_iface->soft_iface)
+		if (primary_iface->mesh_iface != hard_iface->mesh_iface)
 			continue;
 
 		batadv_v_elp_iface_activate(primary_iface, hard_iface);
@@ -486,7 +486,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 
 /**
  * batadv_v_elp_neigh_update() - update an ELP neighbour node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @neigh_addr: the neighbour interface address
  * @if_incoming: the interface the packet was received through
  * @elp_packet: the received ELP packet
@@ -552,7 +552,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
 	struct ethhdr *ethhdr;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e503ee0d896b..3b9065a3c746 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -45,7 +45,7 @@
 
 /**
  * batadv_v_ogm_orig_get() - retrieve and possibly create an originator node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the address of the originator
  *
  * Return: the orig_node corresponding to the specified address. If such an
@@ -96,7 +96,7 @@ static void batadv_v_ogm_start_queue_timer(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_v_ogm_start_timer() - restart the OGM sending timer
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 {
@@ -121,7 +121,7 @@ static void batadv_v_ogm_start_timer(struct batadv_priv *bat_priv)
 static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 				    struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
 		kfree_skb(skb);
@@ -239,7 +239,7 @@ static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
 static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 				     struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (!atomic_read(&bat_priv->aggregated_ogms)) {
 		batadv_v_ogm_send_to_if(skb, hard_iface);
@@ -256,10 +256,10 @@ static void batadv_v_ogm_queue_on_if(struct sk_buff *skb,
 }
 
 /**
- * batadv_v_ogm_send_softif() - periodic worker broadcasting the own OGM
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_v_ogm_send_meshif() - periodic worker broadcasting the own OGM
+ * @bat_priv: the bat priv with all the mesh interface information
  */
-static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
+static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
@@ -302,7 +302,7 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 	/* broadcast on every interface */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
@@ -373,7 +373,7 @@ static void batadv_v_ogm_send(struct work_struct *work)
 	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
-	batadv_v_ogm_send_softif(bat_priv);
+	batadv_v_ogm_send_meshif(bat_priv);
 	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
 }
 
@@ -408,7 +408,7 @@ void batadv_v_ogm_aggr_work(struct work_struct *work)
  */
 int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	batadv_v_ogm_start_queue_timer(hard_iface);
 	batadv_v_ogm_start_timer(bat_priv);
@@ -435,7 +435,7 @@ void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
  */
 void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(primary_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(primary_iface->mesh_iface);
 	struct batadv_ogm2_packet *ogm_packet;
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
@@ -452,7 +452,7 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 /**
  * batadv_v_forward_penalty() - apply a penalty to the throughput metric
  *  forwarded with B.A.T.M.A.N. V OGMs
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @if_incoming: the interface where the OGM has been received
  * @if_outgoing: the interface where the OGM has to be forwarded to
  * @throughput: the current throughput
@@ -505,7 +505,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 /**
  * batadv_v_ogm_forward() - check conditions and forward an OGM to the given
  *  outgoing interface
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ogm_received: previously received OGM to be forwarded
  * @orig_node: the originator which has been updated
  * @neigh_node: the neigh_node through with the OGM has been received
@@ -592,7 +592,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 
 /**
  * batadv_v_ogm_metric_update() - update route metric based on OGM
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
  * @neigh_node: the neigh_node through with the OGM has been received
@@ -675,7 +675,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_v_ogm_route_update() - update routes based on OGM
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
@@ -770,7 +770,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_v_ogm_process_per_outif() - process a batman v OGM for an outgoing if
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
@@ -852,7 +852,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 				 struct batadv_hard_iface *if_incoming)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
@@ -926,7 +926,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
@@ -985,7 +985,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)
 {
-	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_ogm2_packet *ogm_packet;
 	struct ethhdr *ethhdr;
 	int ogm_offset;
@@ -1036,7 +1036,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 
 /**
  * batadv_v_ogm_init() - initialise the OGM2 engine
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or a negative error code in case of failure
  */
@@ -1071,7 +1071,7 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_v_ogm_free() - free OGM private resources
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 649c41f393e1..2c49b2711650 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -23,7 +23,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
 /**
  * batadv_bit_get_packet() - receive and process one packet within the sequence
  *  number window
- * @priv: the bat priv with all the soft interface information
+ * @priv: the bat priv with all the mesh interface information
  * @seq_bits: pointer to the sequence number receive packet
  * @seq_num_diff: difference between the current/received sequence number and
  *  the last sequence number
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8c814f790d17..747755647c6a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -209,7 +209,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
 
 /**
  * batadv_claim_hash_find() - looks for a claim in the claim hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @data: search data (may be local/static data)
  *
  * Return: claim if found or NULL otherwise.
@@ -248,7 +248,7 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
 
 /**
  * batadv_backbone_hash_find() - looks for a backbone gateway in the hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
@@ -332,7 +332,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 
 /**
  * batadv_bla_send_claim() - sends a claim frame according to the provided info
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @mac: the mac address to be announced within the claim
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
@@ -343,7 +343,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	struct sk_buff *skb;
 	struct ethhdr *ethhdr;
 	struct batadv_hard_iface *primary_if;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	u8 *hw_src;
 	struct batadv_bla_claim_dst local_claim_dest;
 	__be32 zeroip = 0;
@@ -356,12 +356,12 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	soft_iface = primary_if->soft_iface;
+	mesh_iface = primary_if->mesh_iface;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->soft_iface,
+			 primary_if->mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
@@ -439,7 +439,7 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	}
 
 	skb_reset_mac_header(skb);
-	skb->protocol = eth_type_trans(skb, soft_iface);
+	skb->protocol = eth_type_trans(skb, mesh_iface);
 	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
 			   skb->len + ETH_HLEN);
@@ -466,7 +466,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
 				   report_work);
 	bat_priv = backbone_gw->bat_priv;
 
-	batadv_info(bat_priv->soft_iface,
+	batadv_info(bat_priv->mesh_iface,
 		    "Possible loop on VLAN %d detected which can't be handled by BLA - please check your network setup!\n",
 		    batadv_print_vid(backbone_gw->vid));
 	snprintf(vid_str, sizeof(vid_str), "%d",
@@ -481,7 +481,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
 
 /**
  * batadv_bla_get_backbone_gw() - finds or creates a backbone gateway
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
  * @own_backbone: set if the requested backbone is local
@@ -554,7 +554,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 
 /**
  * batadv_bla_update_own_backbone_gw() - updates the own backbone gw for a VLAN
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: the selected primary interface
  * @vid: VLAN identifier
  *
@@ -580,7 +580,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_answer_request() - answer a bla request by sending own claims
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: interface where the request came on
  * @vid: the vid where the request came on
  *
@@ -657,7 +657,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 
 /**
  * batadv_bla_send_announce() - Send an announcement frame
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @backbone_gw: our backbone gateway which should be announced
  */
 static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
@@ -678,7 +678,7 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_add_claim() - Adds a claim in the claim hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @mac: the mac address of the claim
  * @vid: the VLAN ID of the frame
  * @backbone_gw: the backbone gateway which claims it
@@ -788,7 +788,7 @@ batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
 
 /**
  * batadv_bla_del_claim() - delete a claim from the claim hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @mac: mac address of the claim to be removed
  * @vid: VLAN id for the claim to be removed
  */
@@ -826,7 +826,7 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_announce() - check for ANNOUNCE frame
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @an_addr: announcement mac address (ARP Sender HW address)
  * @backbone_addr: originator address of the sender (Ethernet source MAC)
  * @vid: the VLAN ID of the frame
@@ -884,8 +884,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 /**
  * batadv_handle_request() - check for REQUEST frame
- * @bat_priv: the bat priv with all the soft interface information
- * @primary_if: the primary hard interface of this batman soft interface
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @primary_if: the primary hard interface of this batman mesh interface
  * @backbone_addr: backbone address to be requested (ARP sender HW MAC)
  * @ethhdr: ethernet header of a packet
  * @vid: the VLAN ID of the frame
@@ -917,8 +917,8 @@ static bool batadv_handle_request(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_unclaim() - check for UNCLAIM frame
- * @bat_priv: the bat priv with all the soft interface information
- * @primary_if: the primary hard interface of this batman soft interface
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @primary_if: the primary hard interface of this batman mesh interface
  * @backbone_addr: originator address of the backbone (Ethernet source)
  * @claim_addr: Client to be unclaimed (ARP sender HW MAC)
  * @vid: the VLAN ID of the frame
@@ -955,8 +955,8 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_claim() - check for CLAIM frame
- * @bat_priv: the bat priv with all the soft interface information
- * @primary_if: the primary hard interface of this batman soft interface
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @primary_if: the primary hard interface of this batman mesh interface
  * @backbone_addr: originator address of the backbone (Ethernet Source)
  * @claim_addr: client mac address to be claimed (ARP sender HW MAC)
  * @vid: the VLAN ID of the frame
@@ -992,7 +992,7 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_check_claim_group() - check for claim group membership
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
  * @hw_dst: the Hardware destination in the ARP Header
@@ -1067,8 +1067,8 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_process_claim() - Check if this is a claim frame, and process it
- * @bat_priv: the bat priv with all the soft interface information
- * @primary_if: the primary hard interface of this batman soft interface
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @primary_if: the primary hard interface of this batman mesh interface
  * @skb: the frame to be checked
  *
  * Return: true if it was a claim frame, otherwise return false to
@@ -1210,7 +1210,7 @@ static bool batadv_bla_process_claim(struct batadv_priv *bat_priv,
 /**
  * batadv_bla_purge_backbone_gw() - Remove backbone gateways after a timeout or
  *  immediately
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @now: whether the whole hash shall be wiped now
  *
  * Check when we last heard from other nodes, and remove them in case of
@@ -1262,7 +1262,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 /**
  * batadv_bla_purge_claims() - Remove claims after a timeout or immediately
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
  *
@@ -1321,7 +1321,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 /**
  * batadv_bla_update_orig_address() - Update the backbone gateways when the own
  *  originator address changes
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: the new selected primary_if
  * @oldif: the old primary interface, may be NULL
  */
@@ -1376,7 +1376,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_send_loopdetect() - send a loopdetect frame
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @backbone_gw: the backbone gateway for which a loop should be detected
  *
  * To detect loops that the bridge loop avoidance can't handle, send a loop
@@ -1396,7 +1396,7 @@ batadv_bla_send_loopdetect(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_status_update() - purge bla interfaces if necessary
- * @net_dev: the soft interface net device
+ * @net_dev: the mesh interface net device
  */
 void batadv_bla_status_update(struct net_device *net_dev)
 {
@@ -1520,7 +1520,7 @@ static struct lock_class_key batadv_backbone_hash_lock_class_key;
 
 /**
  * batadv_bla_init() - initialize all bla structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success, < 0 on error.
  */
@@ -1586,7 +1586,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the multicast packet to be checked
  * @payload_ptr: pointer to position inside the head buffer of the skb
  *  marking the start of the data to be CRC'ed
@@ -1680,7 +1680,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_check_ucast_duplist() - Check if a frame is in the broadcast dup.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the multicast packet to be checked, decapsulated from a
  *  unicast_packet
  *
@@ -1698,7 +1698,7 @@ static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
 
 /**
  * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadcast dup.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the bcast_packet to be checked
  *
  * Check if it is on our broadcast list. Another gateway might have sent the
@@ -1723,7 +1723,7 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 /**
  * batadv_bla_is_backbone_gw_orig() - Check if the originator is a gateway for
  *  the VLAN identified by vid.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: originator mac address
  * @vid: VLAN identifier
  *
@@ -1766,7 +1766,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
- * Return: true if the orig_node is also a gateway on the soft interface,
+ * Return: true if the orig_node is also a gateway on the mesh interface,
  * otherwise it returns false.
  */
 bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
@@ -1796,9 +1796,9 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 
 /**
  * batadv_bla_free() - free all bla structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
- * for softinterface free or module unload
+ * for meshinterface free or module unload
  */
 void batadv_bla_free(struct batadv_priv *bat_priv)
 {
@@ -1822,7 +1822,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 
 /**
  * batadv_bla_loopdetect_check() - check and handle a detected loop
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the packet to check
  * @primary_if: interface where the request came on
  * @vid: the VLAN ID of the frame
@@ -1877,7 +1877,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_bla_rx() - check packets coming from the mesh.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  * @packet_type: the batman packet type this frame came in
@@ -2010,7 +2010,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_bla_tx() - check packets going into the mesh
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
  *
@@ -2232,18 +2232,18 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 	hash = bat_priv->bla.claim_hash;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -2267,7 +2267,7 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 out:
 	batadv_hardif_put(primary_if);
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	return ret;
 }
@@ -2393,18 +2393,18 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 	hash = bat_priv->bla.backbone_hash;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -2428,7 +2428,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 out:
 	batadv_hardif_put(primary_if);
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	return ret;
 }
@@ -2437,7 +2437,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 /**
  * batadv_bla_check_claim() - check if address is claimed
  *
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: mac address of which the claim status is checked
  * @vid: the VLAN ID
  *
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e5a07152d4ec..8b8132eb0a79 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -96,7 +96,7 @@ static void batadv_dat_purge(struct work_struct *work);
 
 /**
  * batadv_dat_start_timer() - initialise the DAT periodic worker
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
@@ -145,7 +145,7 @@ static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 
 /**
  * __batadv_dat_purge() - delete entries from the DAT local storage
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the dat_entry as argument and has to
  *	      returns a boolean value: true is the entry has to be deleted,
@@ -315,7 +315,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
 /**
  * batadv_dat_entry_hash_find() - look for a given dat_entry in the local hash
  * table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ip: search key
  * @vid: VLAN identifier
  *
@@ -357,7 +357,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 
 /**
  * batadv_dat_entry_add() - add a new dat entry or update it if already exists
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
  * @vid: VLAN identifier
@@ -414,7 +414,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 /**
  * batadv_dbg_arp() - print a debug message containing all the ARP packet
  *  details
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: ARP packet
  * @hdr_size: size of the possible header before the ARP packet
  * @msg: message to print together with the debugging information
@@ -549,7 +549,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 
 /**
  * batadv_choose_next_candidate() - select the next DHT candidate
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @cands: candidates array
  * @select: number of candidates already present in the array
  * @ip_key: key to look up in the DHT
@@ -613,7 +613,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 /**
  * batadv_dat_select_candidates() - select the nodes which the DHT message has
  *  to be sent to
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ip_dst: ipv4 to look up in the DHT
  * @vid: VLAN identifier
  *
@@ -658,7 +658,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 
 /**
  * batadv_dat_forward_data() - copy and send payload to the selected candidates
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: payload to send
  * @ip: the DHT key
  * @vid: VLAN identifier
@@ -734,7 +734,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 /**
  * batadv_dat_tvlv_container_update() - update the dat tvlv container after dat
  *  setting change
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 {
@@ -756,7 +756,7 @@ static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 /**
  * batadv_dat_status_update() - update the dat tvlv container after dat
  *  setting change
- * @net_dev: the soft interface net device
+ * @net_dev: the mesh interface net device
  */
 void batadv_dat_status_update(struct net_device *net_dev)
 {
@@ -767,7 +767,7 @@ void batadv_dat_status_update(struct net_device *net_dev)
 
 /**
  * batadv_dat_tvlv_ogm_handler_v1() - process incoming dat tvlv container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the gateway data
@@ -786,7 +786,7 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 /**
  * batadv_dat_hash_free() - free the local DAT hash table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 {
@@ -802,7 +802,7 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 
 /**
  * batadv_dat_init() - initialise the DAT internals
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 in case of success, a negative error code otherwise
  */
@@ -828,7 +828,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_dat_free() - free the DAT internals
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_dat_free(struct batadv_priv *bat_priv)
 {
@@ -936,18 +936,18 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int ret = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 	hash = bat_priv->dat.hash;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -973,14 +973,14 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 out:
 	batadv_hardif_put(primary_if);
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	return ret;
 }
 
 /**
  * batadv_arp_get_type() - parse an ARP packet and gets the type
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
  *
@@ -1080,7 +1080,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
 
 /**
  * batadv_dat_arp_create_reply() - create an ARP Reply
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ip_src: ARP sender IP
  * @ip_dst: ARP target IP
  * @hw_src: Ethernet source and ARP sender MAC
@@ -1099,7 +1099,7 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 {
 	struct sk_buff *skb;
 
-	skb = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_dst, bat_priv->soft_iface,
+	skb = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_dst, bat_priv->mesh_iface,
 			 ip_src, hw_dst, hw_src, hw_dst);
 	if (!skb)
 		return NULL;
@@ -1116,7 +1116,7 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 /**
  * batadv_dat_snoop_outgoing_arp_request() - snoop the ARP request and try to
  * answer using DAT
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  *
  * Return: true if the message has been sent to the dht candidates, false
@@ -1132,7 +1132,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
-	struct net_device *soft_iface = bat_priv->soft_iface;
+	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	int hdr_size = 0;
 	unsigned short vid;
 
@@ -1162,7 +1162,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
 		 *
-		 * Moreover, if the soft-interface is enslaved into a bridge, an
+		 * Moreover, if the mesh-interface is enslaved into a bridge, an
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
@@ -1191,7 +1191,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		if (!skb_new)
 			goto out;
 
-		skb_new->protocol = eth_type_trans(skb_new, soft_iface);
+		skb_new->protocol = eth_type_trans(skb_new, mesh_iface);
 
 		batadv_inc_counter(bat_priv, BATADV_CNT_RX);
 		batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
@@ -1213,7 +1213,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 /**
  * batadv_dat_snoop_incoming_arp_request() - snoop the ARP request and try to
  * answer using the local DAT storage
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
@@ -1281,7 +1281,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 
 /**
  * batadv_dat_snoop_outgoing_arp_reply() - snoop the ARP reply and fill the DHT
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  */
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
@@ -1324,7 +1324,7 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 /**
  * batadv_dat_snoop_incoming_arp_reply() - snoop the ARP reply and fill the
  *  local DAT storage only
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
@@ -1605,7 +1605,7 @@ static bool batadv_dat_get_dhcp_chaddr(struct sk_buff *skb, u8 *buf)
 /**
  * batadv_dat_put_dhcp() - puts addresses from a DHCP packet into the DHT and
  *  DAT cache
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @chaddr: the DHCP client MAC address
  * @yiaddr: the DHCP client IP address
  * @hw_dst: the DHCP server MAC address
@@ -1690,7 +1690,7 @@ batadv_dat_check_dhcp_ack(struct sk_buff *skb, __be16 proto, __be32 *ip_src,
 
 /**
  * batadv_dat_snoop_outgoing_dhcp_ack() - snoop DHCPACK and fill DAT with it
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the packet to snoop
  * @proto: ethernet protocol hint (behind a potential vlan)
  * @vid: VLAN identifier
@@ -1723,7 +1723,7 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 
 /**
  * batadv_dat_snoop_incoming_dhcp_ack() - snoop DHCPACK and fill DAT cache
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the packet to snoop
  * @hdr_size: header size, up to the tail of the batman-adv header
  *
@@ -1771,7 +1771,7 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 /**
  * batadv_dat_drop_broadcast_packet() - check if an ARP request has to be
  *  dropped (because the node has already obtained the reply via DAT) or not
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the broadcast packet
  *
  * Return: true if the node can drop the packet, false otherwise.
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index bed7f3d20844..e7b75e82eb1d 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -56,7 +56,7 @@ batadv_dat_init_orig_node_addr(struct batadv_orig_node *orig_node)
 
 /**
  * batadv_dat_init_own_addr() - assign a DAT address to the node itself
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @primary_if: a pointer to the primary interface
  */
 static inline void
@@ -77,7 +77,7 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
 /**
  * batadv_dat_inc_counter() - increment the correct DAT packet counter
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @subtype: the 4addr subtype of the packet to be counted
  *
  * Updates the ethtool statistics for the received packet if it is a DAT subtype
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 757c084ac2d1..cc14bc41381e 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -349,7 +349,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
 			 struct batadv_orig_node *orig_node_src)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_frag_packet *packet;
 	u16 total_size;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index f68e34ed1f62..7a11b245e9f4 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -71,7 +71,7 @@ void batadv_gw_node_release(struct kref *ref)
 
 /**
  * batadv_gw_get_selected_gw_node() - Get currently selected gateway
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: selected gateway (with increased refcnt), NULL on errors
  */
@@ -95,7 +95,7 @@ batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_get_selected_orig() - Get originator of currently selected gateway
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: orig_node of selected gateway (with increased refcnt), NULL on errors
  */
@@ -144,7 +144,7 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 
 /**
  * batadv_gw_reselect() - force a gateway reselection
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Set a flag to remind the GW component to perform a new gateway reselection.
  * However this function does not ensure that the current gateway is going to be
@@ -160,7 +160,7 @@ void batadv_gw_reselect(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_check_client_stop() - check if client mode has been switched off
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * This function assumes the caller has checked that the gw state *is actually
  * changing*. This function is not supposed to be called when there is no state
@@ -192,7 +192,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_election() - Elect the best gateway
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_gw_election(struct batadv_priv *bat_priv)
 {
@@ -280,7 +280,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_check_election() - Elect orig node as best gateway when eligible
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be checked
  */
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
@@ -314,7 +314,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 
 /**
  * batadv_gw_node_add() - add gateway node to list of available gateways
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
  *
@@ -361,7 +361,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 
 /**
  * batadv_gw_node_get() - retrieve gateway node from list of available gateways
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: originator announcing gateway capabilities
  *
  * Return: gateway node if found or NULL otherwise.
@@ -391,7 +391,7 @@ struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 /**
  * batadv_gw_node_update() - update list of available gateways with changed
  *  bandwidth information
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
  */
@@ -458,7 +458,7 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_gw_node_delete() - Remove orig_node from gateway list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is currently in process of being removed
  */
 void batadv_gw_node_delete(struct batadv_priv *bat_priv,
@@ -473,8 +473,8 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_gw_node_free() - Free gateway information from soft interface
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_gw_node_free() - Free gateway information from mesh interface
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_gw_node_free(struct batadv_priv *bat_priv)
 {
@@ -501,15 +501,15 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
@@ -528,7 +528,7 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 out:
 	batadv_hardif_put(primary_if);
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	return ret;
 }
@@ -657,7 +657,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 /**
  * batadv_gw_out_of_range() - check if the dhcp request destination is the best
  *  gateway
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the outgoing packet
  *
  * Check if the skb is a DHCP request and if it is sent to the current best GW
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 2dd36ef03c84..315fa90f0c94 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -20,7 +20,7 @@
 /**
  * batadv_gw_tvlv_container_update() - update the gw tvlv container after
  *  gateway setting change
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 {
@@ -48,7 +48,7 @@ void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_tvlv_ogm_handler_v1() - process incoming gateway tvlv container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the gateway data
@@ -89,7 +89,7 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 /**
  * batadv_gw_init() - initialise the gateway handling internals
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_gw_init(struct batadv_priv *bat_priv)
 {
@@ -105,7 +105,7 @@ void batadv_gw_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_gw_free() - free the gateway handling internals
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_gw_free(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index e7e7f14da03c..f145f9662653 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -36,9 +36,9 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "originator.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 /**
@@ -141,7 +141,7 @@ static bool batadv_mutual_parents(const struct net_device *dev1,
  * is important to prevent this new interface from being used to create a new
  * mesh network (this behaviour would lead to a batman-over-batman
  * configuration). This function recursively checks all the fathers of the
- * device passed as argument looking for a batman-adv soft interface.
+ * device passed as argument looking for a batman-adv mesh interface.
  *
  * Return: true if the device is descendant of a batman-adv mesh interface (or
  * if it is a batman-adv interface itself), false otherwise
@@ -155,7 +155,7 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	bool ret;
 
 	/* check if this is a batman-adv mesh interface */
-	if (batadv_softif_is_valid(net_dev))
+	if (batadv_meshif_is_valid(net_dev))
 		return true;
 
 	iflink = dev_get_iflink(net_dev);
@@ -233,10 +233,10 @@ static struct net_device *batadv_get_real_netdevice(struct net_device *netdev)
 	}
 
 	hard_iface = batadv_hardif_get_by_netdev(netdev);
-	if (!hard_iface || !hard_iface->soft_iface)
+	if (!hard_iface || !hard_iface->mesh_iface)
 		goto out;
 
-	net = dev_net(hard_iface->soft_iface);
+	net = dev_net(hard_iface->mesh_iface);
 	real_net = batadv_getlink_net(netdev, net);
 
 	/* iflink to itself, most likely physical device */
@@ -438,13 +438,13 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 }
 
 static struct batadv_hard_iface *
-batadv_hardif_get_active(const struct net_device *soft_iface)
+batadv_hardif_get_active(const struct net_device *mesh_iface)
 {
 	struct batadv_hard_iface *hard_iface;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != soft_iface)
+		if (hard_iface->mesh_iface != mesh_iface)
 			continue;
 
 		if (hard_iface->if_status == BATADV_IF_ACTIVE &&
@@ -532,9 +532,9 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 
 /**
  * batadv_hardif_recalc_extra_skbroom() - Recalculate skbuff extra head/tailroom
- * @soft_iface: netdev struct of the mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  */
-static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
+static void batadv_hardif_recalc_extra_skbroom(struct net_device *mesh_iface)
 {
 	const struct batadv_hard_iface *hard_iface;
 	unsigned short lower_header_len = ETH_HLEN;
@@ -547,7 +547,7 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
-		if (hard_iface->soft_iface != soft_iface)
+		if (hard_iface->mesh_iface != mesh_iface)
 			continue;
 
 		lower_header_len = max_t(unsigned short, lower_header_len,
@@ -567,20 +567,20 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 	/* fragmentation headers don't strip the unicast/... header */
 	needed_headroom += sizeof(struct batadv_frag_packet);
 
-	soft_iface->needed_headroom = needed_headroom;
-	soft_iface->needed_tailroom = lower_tailroom;
+	mesh_iface->needed_headroom = needed_headroom;
+	mesh_iface->needed_tailroom = lower_tailroom;
 }
 
 /**
- * batadv_hardif_min_mtu() - Calculate maximum MTU for soft interface
- * @soft_iface: netdev struct of the soft interface
+ * batadv_hardif_min_mtu() - Calculate maximum MTU for mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  *
- * Return: MTU for the soft-interface (limited by the minimal MTU of all active
+ * Return: MTU for the mesh-interface (limited by the minimal MTU of all active
  *  slave interfaces)
  */
-int batadv_hardif_min_mtu(struct net_device *soft_iface)
+int batadv_hardif_min_mtu(struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	const struct batadv_hard_iface *hard_iface;
 	int min_mtu = INT_MAX;
 
@@ -590,7 +590,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
 			continue;
 
-		if (hard_iface->soft_iface != soft_iface)
+		if (hard_iface->mesh_iface != mesh_iface)
 			continue;
 
 		min_mtu = min_t(int, hard_iface->net_dev->mtu, min_mtu);
@@ -616,7 +616,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	 */
 	atomic_set(&bat_priv->packet_size_max, min_mtu);
 
-	/* the real soft-interface MTU is computed by removing the payload
+	/* the real mesh-interface MTU is computed by removing the payload
 	 * overhead from the maximum amount of bytes that was just computed.
 	 */
 	return min_t(int, min_mtu - batadv_max_header_len(), BATADV_MAX_MTU);
@@ -625,15 +625,15 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 /**
  * batadv_update_min_mtu() - Adjusts the MTU if a new interface with a smaller
  *  MTU appeared
- * @soft_iface: netdev struct of the soft interface
+ * @mesh_iface: netdev struct of the mesh interface
  */
-void batadv_update_min_mtu(struct net_device *soft_iface)
+void batadv_update_min_mtu(struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int limit_mtu;
 	int mtu;
 
-	mtu = batadv_hardif_min_mtu(soft_iface);
+	mtu = batadv_hardif_min_mtu(mesh_iface);
 
 	if (bat_priv->mtu_set_by_user)
 		limit_mtu = bat_priv->mtu_set_by_user;
@@ -641,12 +641,12 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
 		limit_mtu = ETH_DATA_LEN;
 
 	mtu = min(mtu, limit_mtu);
-	dev_set_mtu(soft_iface, mtu);
+	dev_set_mtu(mesh_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
 	 */
-	batadv_tt_local_resize_to_mtu(soft_iface);
+	batadv_tt_local_resize_to_mtu(mesh_iface);
 }
 
 static void
@@ -658,7 +658,7 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
-	bat_priv = netdev_priv(hard_iface->soft_iface);
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	bat_priv->algo_ops->iface.update_mac(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_ACTIVATED;
@@ -670,10 +670,10 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 	if (!primary_if)
 		batadv_primary_if_select(bat_priv, hard_iface);
 
-	batadv_info(hard_iface->soft_iface, "Interface activated: %s\n",
+	batadv_info(hard_iface->mesh_iface, "Interface activated: %s\n",
 		    hard_iface->net_dev->name);
 
-	batadv_update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->mesh_iface);
 
 	if (bat_priv->algo_ops->iface.activate)
 		bat_priv->algo_ops->iface.activate(hard_iface);
@@ -691,21 +691,21 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 
-	batadv_info(hard_iface->soft_iface, "Interface deactivated: %s\n",
+	batadv_info(hard_iface->mesh_iface, "Interface deactivated: %s\n",
 		    hard_iface->net_dev->name);
 
-	batadv_update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->mesh_iface);
 }
 
 /**
- * batadv_hardif_enable_interface() - Enslave hard interface to soft interface
- * @hard_iface: hard interface to add to soft interface
- * @soft_iface: netdev struct of the mesh interface
+ * batadv_hardif_enable_interface() - Enslave hard interface to mesh interface
+ * @hard_iface: hard interface to add to mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  *
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   struct net_device *soft_iface)
+				   struct net_device *mesh_iface)
 {
 	struct batadv_priv *bat_priv;
 	__be16 ethertype = htons(ETH_P_BATMAN);
@@ -715,7 +715,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	int ret;
 
 	hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
-	required_mtu = READ_ONCE(soft_iface->mtu) + max_header_len;
+	required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
 
 	if (hardif_mtu < ETH_MIN_MTU + max_header_len)
 		return -EINVAL;
@@ -725,13 +725,13 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(soft_iface);
-	netdev_hold(soft_iface, &hard_iface->softif_dev_tracker, GFP_ATOMIC);
-	hard_iface->soft_iface = soft_iface;
-	bat_priv = netdev_priv(hard_iface->soft_iface);
+	dev_hold(mesh_iface);
+	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
+	hard_iface->mesh_iface = mesh_iface;
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
-					   soft_iface, NULL, NULL, NULL);
+					   mesh_iface, NULL, NULL, NULL);
 	if (ret)
 		goto err_dev;
 
@@ -747,19 +747,19 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
 	dev_add_pack(&hard_iface->batman_adv_ptype);
 
-	batadv_info(hard_iface->soft_iface, "Adding interface: %s\n",
+	batadv_info(hard_iface->mesh_iface, "Adding interface: %s\n",
 		    hard_iface->net_dev->name);
 
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    hardif_mtu < required_mtu)
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
 	if (!atomic_read(&bat_priv->fragmentation) &&
 	    hardif_mtu < required_mtu)
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(hard_iface->mesh_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
@@ -767,11 +767,11 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
 	else
-		batadv_err(hard_iface->soft_iface,
+		batadv_err(hard_iface->mesh_iface,
 			   "Not using interface %s (retrying later): interface not active\n",
 			   hard_iface->net_dev->name);
 
-	batadv_hardif_recalc_extra_skbroom(soft_iface);
+	batadv_hardif_recalc_extra_skbroom(mesh_iface);
 
 	if (bat_priv->algo_ops->iface.enabled)
 		bat_priv->algo_ops->iface.enabled(hard_iface);
@@ -780,17 +780,17 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return 0;
 
 err_upper:
-	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
+	netdev_upper_dev_unlink(hard_iface->net_dev, mesh_iface);
 err_dev:
-	hard_iface->soft_iface = NULL;
-	netdev_put(soft_iface, &hard_iface->softif_dev_tracker);
+	hard_iface->mesh_iface = NULL;
+	netdev_put(mesh_iface, &hard_iface->meshif_dev_tracker);
 	batadv_hardif_put(hard_iface);
 	return ret;
 }
 
 /**
- * batadv_hardif_cnt() - get number of interfaces enslaved to soft interface
- * @soft_iface: soft interface to check
+ * batadv_hardif_cnt() - get number of interfaces enslaved to mesh interface
+ * @mesh_iface: mesh interface to check
  *
  * This function is only using RCU for locking - the result can therefore be
  * off when another function is modifying the list at the same time. The
@@ -798,14 +798,14 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
  *
  * Return: number of connected/enslaved hard interfaces
  */
-static size_t batadv_hardif_cnt(const struct net_device *soft_iface)
+static size_t batadv_hardif_cnt(const struct net_device *mesh_iface)
 {
 	struct batadv_hard_iface *hard_iface;
 	size_t count = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != soft_iface)
+		if (hard_iface->mesh_iface != mesh_iface)
 			continue;
 
 		count++;
@@ -816,12 +816,12 @@ static size_t batadv_hardif_cnt(const struct net_device *soft_iface)
 }
 
 /**
- * batadv_hardif_disable_interface() - Remove hard interface from soft interface
+ * batadv_hardif_disable_interface() - Remove hard interface from mesh interface
  * @hard_iface: hard interface to be removed
  */
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 
 	batadv_hardif_deactivate_interface(hard_iface);
@@ -829,7 +829,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
-	batadv_info(hard_iface->soft_iface, "Removing interface: %s\n",
+	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
 	batadv_hardif_put(hard_iface);
@@ -838,7 +838,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	if (hard_iface == primary_if) {
 		struct batadv_hard_iface *new_if;
 
-		new_if = batadv_hardif_get_active(hard_iface->soft_iface);
+		new_if = batadv_hardif_get_active(hard_iface->mesh_iface);
 		batadv_primary_if_select(bat_priv, new_if);
 
 		batadv_hardif_put(new_if);
@@ -850,16 +850,16 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
 	batadv_purge_outstanding_packets(bat_priv, hard_iface);
-	netdev_put(hard_iface->soft_iface, &hard_iface->softif_dev_tracker);
+	netdev_put(hard_iface->mesh_iface, &hard_iface->meshif_dev_tracker);
 
-	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
-	batadv_hardif_recalc_extra_skbroom(hard_iface->soft_iface);
+	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
+	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
 	/* nobody uses this interface anymore */
-	if (batadv_hardif_cnt(hard_iface->soft_iface) <= 1)
+	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
 		batadv_gw_check_client_stop(bat_priv);
 
-	hard_iface->soft_iface = NULL;
+	hard_iface->mesh_iface = NULL;
 	batadv_hardif_put(hard_iface);
 
 out:
@@ -883,7 +883,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
 	hard_iface->net_dev = net_dev;
 
-	hard_iface->soft_iface = NULL;
+	hard_iface->mesh_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
 	INIT_LIST_HEAD(&hard_iface->list);
@@ -926,13 +926,13 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_hard_if_event_softif() - Handle events for soft interfaces
+ * batadv_hard_if_event_meshif() - Handle events for mesh interfaces
  * @event: NETDEV_* event to handle
  * @net_dev: net_device which generated an event
  *
  * Return: NOTIFY_* result
  */
-static int batadv_hard_if_event_softif(unsigned long event,
+static int batadv_hard_if_event_meshif(unsigned long event,
 				       struct net_device *net_dev)
 {
 	struct batadv_priv *bat_priv;
@@ -940,7 +940,7 @@ static int batadv_hard_if_event_softif(unsigned long event,
 	switch (event) {
 	case NETDEV_REGISTER:
 		bat_priv = netdev_priv(net_dev);
-		batadv_softif_create_vlan(bat_priv, BATADV_NO_FLAGS);
+		batadv_meshif_create_vlan(bat_priv, BATADV_NO_FLAGS);
 		break;
 	}
 
@@ -955,8 +955,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_priv *bat_priv;
 
-	if (batadv_softif_is_valid(net_dev))
-		return batadv_hard_if_event_softif(event, net_dev);
+	if (batadv_meshif_is_valid(net_dev))
+		return batadv_hard_if_event_meshif(event, net_dev);
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && (event == NETDEV_REGISTER ||
@@ -982,8 +982,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_hardif_remove_interface(hard_iface);
 		break;
 	case NETDEV_CHANGEMTU:
-		if (hard_iface->soft_iface)
-			batadv_update_min_mtu(hard_iface->soft_iface);
+		if (hard_iface->mesh_iface)
+			batadv_update_min_mtu(hard_iface->mesh_iface);
 		break;
 	case NETDEV_CHANGEADDR:
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
@@ -991,7 +991,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 
 		batadv_check_known_mac_addr(hard_iface->net_dev);
 
-		bat_priv = netdev_priv(hard_iface->soft_iface);
+		bat_priv = netdev_priv(hard_iface->mesh_iface);
 		bat_priv->algo_ops->iface.update_mac(hard_iface);
 
 		primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 64f660dbbe54..262a78364742 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -23,12 +23,12 @@
 enum batadv_hard_if_state {
 	/**
 	 * @BATADV_IF_NOT_IN_USE: interface is not used as slave interface of a
-	 * batman-adv soft interface
+	 * batman-adv mesh interface
 	 */
 	BATADV_IF_NOT_IN_USE,
 
 	/**
-	 * @BATADV_IF_TO_BE_REMOVED: interface will be removed from soft
+	 * @BATADV_IF_TO_BE_REMOVED: interface will be removed from mesh
 	 * interface
 	 */
 	BATADV_IF_TO_BE_REMOVED,
@@ -74,10 +74,10 @@ bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   struct net_device *soft_iface);
+				   struct net_device *mesh_iface);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface);
-int batadv_hardif_min_mtu(struct net_device *soft_iface);
-void batadv_update_min_mtu(struct net_device *soft_iface);
+int batadv_hardif_min_mtu(struct net_device *mesh_iface);
+void batadv_update_min_mtu(struct net_device *mesh_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh);
@@ -97,7 +97,7 @@ static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
 
 /**
  * batadv_primary_if_get_selected() - Get reference to primary interface
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: primary interface (with increased refcnt), otherwise NULL
  */
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 7a93a1e94c40..c19d07eeb070 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -13,7 +13,7 @@
 
 /**
  * batadv_debug_log() - Add debug log entry
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @fmt: format string
  *
  * Return: 0 on success or negative error number in case of failure
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 6717c965f0fa..567afaa8df99 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -71,7 +71,7 @@ __printf(2, 3);
 /**
  * _batadv_dbg() - Store debug output with(out) rate limiting
  * @type: type of debug message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ratelimited: whether output should be rate limited
  * @fmt: format string
  * @arg: variable arguments
@@ -97,7 +97,7 @@ static inline void _batadv_dbg(int type __always_unused,
 /**
  * batadv_dbg() - Store debug output without rate limiting
  * @type: type of debug message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @arg: format string and variable arguments
  */
 #define batadv_dbg(type, bat_priv, arg...) \
@@ -106,7 +106,7 @@ static inline void _batadv_dbg(int type __always_unused,
 /**
  * batadv_dbg_ratelimited() - Store debug output with rate limiting
  * @type: type of debug message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @arg: format string and variable arguments
  */
 #define batadv_dbg_ratelimited(type, bat_priv, arg...) \
@@ -114,7 +114,7 @@ static inline void _batadv_dbg(int type __always_unused,
 
 /**
  * batadv_info() - Store message in debug buffer and print it to kmsg buffer
- * @net_dev: the soft interface net device
+ * @net_dev: the mesh interface net device
  * @fmt: format string
  * @arg: variable arguments
  */
@@ -128,7 +128,7 @@ static inline void _batadv_dbg(int type __always_unused,
 
 /**
  * batadv_err() - Store error in debug buffer and print it to kmsg buffer
- * @net_dev: the soft interface net device
+ * @net_dev: the mesh interface net device
  * @fmt: format string
  * @arg: variable arguments
  */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 333e947afcce..a08132888a3d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -51,13 +51,13 @@
 #include "gateway_common.h"
 #include "hard-interface.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "multicast.h"
 #include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
 
@@ -143,14 +143,14 @@ static void __exit batadv_exit(void)
 }
 
 /**
- * batadv_mesh_init() - Initialize soft interface
- * @soft_iface: netdev struct of the soft interface
+ * batadv_mesh_init() - Initialize mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  *
  * Return: 0 on success or negative error number in case of failure
  */
-int batadv_mesh_init(struct net_device *soft_iface)
+int batadv_mesh_init(struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int ret;
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
@@ -167,7 +167,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 #endif
 	spin_lock_init(&bat_priv->tvlv.container_list_lock);
 	spin_lock_init(&bat_priv->tvlv.handler_list_lock);
-	spin_lock_init(&bat_priv->softif_vlan_list_lock);
+	spin_lock_init(&bat_priv->meshif_vlan_list_lock);
 	spin_lock_init(&bat_priv->tp_list_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
@@ -186,7 +186,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 #endif
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
-	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
+	INIT_HLIST_HEAD(&bat_priv->meshif_vlan_list);
 	INIT_HLIST_HEAD(&bat_priv->tp_list);
 
 	bat_priv->gw.generation = 0;
@@ -253,12 +253,12 @@ int batadv_mesh_init(struct net_device *soft_iface)
 }
 
 /**
- * batadv_mesh_free() - Deinitialize soft interface
- * @soft_iface: netdev struct of the soft interface
+ * batadv_mesh_free() - Deinitialize mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  */
-void batadv_mesh_free(struct net_device *soft_iface)
+void batadv_mesh_free(struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
@@ -297,7 +297,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 /**
  * batadv_is_my_mac() - check if the given mac address belongs to any of the
  *  real interfaces in the current mesh
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the address to check
  *
  * Return: 'true' if the mac address was found, false otherwise.
@@ -312,7 +312,7 @@ bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr)
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
@@ -457,10 +457,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(skb->mac_len != ETH_HLEN || !skb_mac_header(skb)))
 		goto err_free;
 
-	if (!hard_iface->soft_iface)
+	if (!hard_iface->mesh_iface)
 		goto err_free;
 
-	bat_priv = netdev_priv(hard_iface->soft_iface);
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto err_free;
@@ -651,7 +651,7 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 
 /**
  * batadv_vlan_ap_isola_get() - return AP isolation status for the given vlan
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier for which the AP isolation attributed as to be
  *  looked up
  *
@@ -661,15 +661,15 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
 bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	bool ap_isolation_enabled = false;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
 	/* if the AP isolation is requested on a VLAN, then check for its
 	 * setting in the proper VLAN private data structure
 	 */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_put(vlan);
+		batadv_meshif_vlan_put(vlan);
 	}
 
 	return ap_isolation_enabled;
@@ -677,7 +677,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 
 /**
  * batadv_throw_uevent() - Send an uevent with batman-adv specific env data
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: subsystem type of event. Stored in uevent's BATTYPE
  * @action: action type of event. Stored in uevent's BATACTION
  * @data: string with additional information to the event (ignored for
@@ -692,7 +692,7 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
 
-	bat_kobj = &bat_priv->soft_iface->dev.kobj;
+	bat_kobj = &bat_priv->mesh_iface->dev.kobj;
 
 	uevent_env[0] = kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 4ecc304eaddd..5adefdfc69bc 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -131,10 +131,10 @@
 #define BATADV_TP_MAX_NUM 5
 
 /**
- * enum batadv_mesh_state - State of a soft interface
+ * enum batadv_mesh_state - State of a mesh interface
  */
 enum batadv_mesh_state {
-	/** @BATADV_MESH_INACTIVE: soft interface is not yet running */
+	/** @BATADV_MESH_INACTIVE: mesh interface is not yet running */
 	BATADV_MESH_INACTIVE,
 
 	/** @BATADV_MESH_ACTIVE: interface is up and running */
@@ -240,8 +240,8 @@ extern unsigned int batadv_hardif_generation;
 extern unsigned char batadv_broadcast_addr[];
 extern struct workqueue_struct *batadv_event_workqueue;
 
-int batadv_mesh_init(struct net_device *soft_iface);
-void batadv_mesh_free(struct net_device *soft_iface);
+int batadv_mesh_init(struct net_device *mesh_iface);
+void batadv_mesh_free(struct net_device *mesh_iface);
 bool batadv_is_my_mac(struct batadv_priv *bat_priv, const u8 *addr);
 int batadv_max_header_len(void);
 void batadv_skb_set_priority(struct sk_buff *skb, int offset);
@@ -347,8 +347,8 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
 #define batadv_seq_after(x, y) batadv_seq_before(y, x)
 
 /**
- * batadv_add_counter() - Add to per cpu statistics counter of soft interface
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_add_counter() - Add to per cpu statistics counter of mesh interface
+ * @bat_priv: the bat priv with all the mesh interface information
  * @idx: counter index which should be modified
  * @count: value to increase counter by
  *
@@ -361,8 +361,8 @@ static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 }
 
 /**
- * batadv_inc_counter() - Increase per cpu statistics counter of soft interface
- * @b: the bat priv with all the soft interface information
+ * batadv_inc_counter() - Increase per cpu statistics counter of mesh interface
+ * @b: the bat priv with all the mesh interface information
  * @i: counter index which should be modified
  */
 #define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/mesh-interface.c
similarity index 84%
rename from net/batman-adv/soft-interface.c
rename to net/batman-adv/mesh-interface.c
index b1127e6e8900..c0a2a2a8fbb5 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -4,7 +4,7 @@
  * Marek Lindner, Simon Wunderlich
  */
 
-#include "soft-interface.h"
+#include "mesh-interface.h"
 #include "main.h"
 
 #include <linux/atomic.h>
@@ -91,7 +91,7 @@ static int batadv_interface_release(struct net_device *dev)
 
 /**
  * batadv_sum_counter() - Sum the cpu-local counters for index 'idx'
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @idx: index of counter to sum up
  *
  * Return: sum of all cpu-local counters
@@ -125,7 +125,7 @@ static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	struct sockaddr *addr = p;
 	u8 old_addr[ETH_ALEN];
 
@@ -140,7 +140,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 		return 0;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
 		batadv_tt_local_remove(bat_priv, old_addr, vlan->vid,
 				       "mac address changed", false);
 		batadv_tt_local_add(dev, addr->sa_data, vlan->vid,
@@ -170,7 +170,7 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
  * @dev: registered network device to modify
  *
  * We do not actually need to set any rx filters for the virtual batman
- * soft interface. However a dummy handler enables a user to set static
+ * mesh interface. However a dummy handler enables a user to set static
  * multicast listeners for instance.
  */
 static void batadv_interface_set_rx_mode(struct net_device *dev)
@@ -178,10 +178,10 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 }
 
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
-				       struct net_device *soft_iface)
+				       struct net_device *mesh_iface)
 {
 	struct ethhdr *ethhdr;
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	static const u8 stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
@@ -209,7 +209,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	/* reset control block to avoid left overs from previous users */
 	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
 
-	netif_trans_update(soft_iface);
+	netif_trans_update(mesh_iface);
 	vid = batadv_get_vid(skb, 0);
 
 	skb_reset_mac_header(skb);
@@ -246,7 +246,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source) &&
 	    !batadv_bla_is_loopdetect_mac(ethhdr->h_source)) {
-		client_added = batadv_tt_local_add(soft_iface, ethhdr->h_source,
+		client_added = batadv_tt_local_add(mesh_iface, ethhdr->h_source,
 						   vid, skb->skb_iif,
 						   skb->mark);
 		if (!client_added)
@@ -397,12 +397,12 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 /**
  * batadv_interface_rx() - receive ethernet frame on local batman-adv interface
- * @soft_iface: local interface which will receive the ethernet frame
- * @skb: ethernet frame for @soft_iface
+ * @mesh_iface: local interface which will receive the ethernet frame
+ * @skb: ethernet frame for @mesh_iface
  * @hdr_size: size of already parsed batman-adv header
  * @orig_node: originator from which the batman-adv packet was sent
  *
- * Sends an ethernet frame to the receive path of the local @soft_iface.
+ * Sends an ethernet frame to the receive path of the local @mesh_iface.
  * skb->data has still point to the batman-adv header with the size @hdr_size.
  * The caller has to have parsed this header already and made sure that at least
  * @hdr_size bytes are still available for pull in @skb.
@@ -412,12 +412,12 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
  * unicast packets will be dropped directly when it was sent between two
  * isolated clients.
  */
-void batadv_interface_rx(struct net_device *soft_iface,
+void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node)
 {
 	struct batadv_bcast_packet *batadv_bcast_packet;
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct vlan_ethhdr *vhdr;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
@@ -457,7 +457,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	}
 
 	/* skb->dev & skb->pkt_type are set here */
-	skb->protocol = eth_type_trans(skb, soft_iface);
+	skb->protocol = eth_type_trans(skb, mesh_iface);
 	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
@@ -502,38 +502,38 @@ void batadv_interface_rx(struct net_device *soft_iface,
 }
 
 /**
- * batadv_softif_vlan_release() - release vlan from lists and queue for free
+ * batadv_meshif_vlan_release() - release vlan from lists and queue for free
  *  after rcu grace period
  * @ref: kref pointer of the vlan object
  */
-void batadv_softif_vlan_release(struct kref *ref)
+void batadv_meshif_vlan_release(struct kref *ref)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
-	vlan = container_of(ref, struct batadv_softif_vlan, refcount);
+	vlan = container_of(ref, struct batadv_meshif_vlan, refcount);
 
-	spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+	spin_lock_bh(&vlan->bat_priv->meshif_vlan_list_lock);
 	hlist_del_rcu(&vlan->list);
-	spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+	spin_unlock_bh(&vlan->bat_priv->meshif_vlan_list_lock);
 
 	kfree_rcu(vlan, rcu);
 }
 
 /**
- * batadv_softif_vlan_get() - get the vlan object for a specific vid
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_meshif_vlan_get() - get the vlan object for a specific vid
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the identifier of the vlan object to retrieve
  *
  * Return: the private data of the vlan matching the vid passed as argument or
  * NULL otherwise. The refcounter of the returned object is incremented by 1.
  */
-struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
+struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid)
 {
-	struct batadv_softif_vlan *vlan_tmp, *vlan = NULL;
+	struct batadv_meshif_vlan *vlan_tmp, *vlan = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(vlan_tmp, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan_tmp, &bat_priv->meshif_vlan_list, list) {
 		if (vlan_tmp->vid != vid)
 			continue;
 
@@ -549,28 +549,28 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_softif_create_vlan() - allocate the needed resources for a new vlan
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_meshif_create_vlan() - allocate the needed resources for a new vlan
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
  *
  * Return: 0 on success, a negative error otherwise.
  */
-int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
+int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_softif_vlan_put(vlan);
-		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+		batadv_meshif_vlan_put(vlan);
+		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 		return -EEXIST;
 	}
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan) {
-		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 		return -ENOMEM;
 	}
 
@@ -581,37 +581,37 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	atomic_set(&vlan->ap_isolation, 0);
 
 	kref_get(&vlan->refcount);
-	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+	hlist_add_head_rcu(&vlan->list, &bat_priv->meshif_vlan_list);
+	spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
+	batadv_tt_local_add(bat_priv->mesh_iface,
+			    bat_priv->mesh_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
-	/* don't return reference to new softif_vlan */
-	batadv_softif_vlan_put(vlan);
+	/* don't return reference to new meshif_vlan */
+	batadv_meshif_vlan_put(vlan);
 
 	return 0;
 }
 
 /**
- * batadv_softif_destroy_vlan() - remove and destroy a softif_vlan object
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_meshif_destroy_vlan() - remove and destroy a meshif_vlan object
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vlan: the object to remove
  */
-static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
-				       struct batadv_softif_vlan *vlan)
+static void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
+				       struct batadv_meshif_vlan *vlan)
 {
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
-	batadv_tt_local_remove(bat_priv, bat_priv->soft_iface->dev_addr,
+	batadv_tt_local_remove(bat_priv, bat_priv->mesh_iface->dev_addr,
 			       vlan->vid, "vlan interface destroyed", false);
 
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 }
 
 /**
@@ -629,7 +629,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 				    unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported.
 	 * batman-adv does not know how to handle other types
@@ -648,21 +648,21 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	vid |= BATADV_VLAN_HAS_TAG;
 
 	/* if a new vlan is getting created and it already exists, it means that
-	 * it was not deleted yet. batadv_softif_vlan_get() increases the
+	 * it was not deleted yet. batadv_meshif_vlan_get() increases the
 	 * refcount in order to revive the object.
 	 *
 	 * if it does not exist then create it.
 	 */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (!vlan)
-		return batadv_softif_create_vlan(bat_priv, vid);
+		return batadv_meshif_create_vlan(bat_priv, vid);
 
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag. This must be added again, even if the vlan object already
 	 * exists, because the entry was deleted by kill_vid()
 	 */
-	batadv_tt_local_add(bat_priv->soft_iface,
-			    bat_priv->soft_iface->dev_addr, vid,
+	batadv_tt_local_add(bat_priv->mesh_iface,
+			    bat_priv->mesh_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
 
 	return 0;
@@ -684,7 +684,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 				     unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
 	/* only 802.1Q vlans are supported. batman-adv does not know how to
 	 * handle other types
@@ -693,19 +693,19 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 		return -EINVAL;
 
 	/* "priority tag" frames are handled like "untagged" frames
-	 * and no softif_vlan needs to be destroyed
+	 * and no meshif_vlan needs to be destroyed
 	 */
 	if (vid == 0)
 		return 0;
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	if (!vlan)
 		return -ENOENT;
 
-	batadv_softif_destroy_vlan(bat_priv, vlan);
+	batadv_meshif_destroy_vlan(bat_priv, vlan);
 
 	/* finally free the vlan object */
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 
 	return 0;
 }
@@ -741,12 +741,12 @@ static void batadv_set_lockdep_class(struct net_device *dev)
 }
 
 /**
- * batadv_softif_init_late() - late stage initialization of soft interface
+ * batadv_meshif_init_late() - late stage initialization of mesh interface
  * @dev: registered network device to modify
  *
  * Return: error code on failures
  */
-static int batadv_softif_init_late(struct net_device *dev)
+static int batadv_meshif_init_late(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv;
 	u32 random_seqno;
@@ -756,7 +756,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	batadv_set_lockdep_class(dev);
 
 	bat_priv = netdev_priv(dev);
-	bat_priv->soft_iface = dev;
+	bat_priv->mesh_iface = dev;
 
 	/* batadv_interface_stats() needs to be available as soon as
 	 * register_netdevice() has been called
@@ -837,14 +837,14 @@ static int batadv_softif_init_late(struct net_device *dev)
 }
 
 /**
- * batadv_softif_slave_add() - Add a slave interface to a batadv_soft_interface
- * @dev: batadv_soft_interface used as master interface
+ * batadv_meshif_slave_add() - Add a slave interface to a batadv_mesh_interface
+ * @dev: batadv_mesh_interface used as master interface
  * @slave_dev: net_device which should become the slave interface
  * @extack: extended ACK report struct
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_slave_add(struct net_device *dev,
+static int batadv_meshif_slave_add(struct net_device *dev,
 				   struct net_device *slave_dev,
 				   struct netlink_ext_ack *extack)
 {
@@ -852,7 +852,7 @@ static int batadv_softif_slave_add(struct net_device *dev,
 	int ret = -EINVAL;
 
 	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
-	if (!hard_iface || hard_iface->soft_iface)
+	if (!hard_iface || hard_iface->mesh_iface)
 		goto out;
 
 	ret = batadv_hardif_enable_interface(hard_iface, dev);
@@ -863,13 +863,13 @@ static int batadv_softif_slave_add(struct net_device *dev,
 }
 
 /**
- * batadv_softif_slave_del() - Delete a slave iface from a batadv_soft_interface
- * @dev: batadv_soft_interface used as master interface
+ * batadv_meshif_slave_del() - Delete a slave iface from a batadv_mesh_interface
+ * @dev: batadv_mesh_interface used as master interface
  * @slave_dev: net_device which should be removed from the master interface
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_slave_del(struct net_device *dev,
+static int batadv_meshif_slave_del(struct net_device *dev,
 				   struct net_device *slave_dev)
 {
 	struct batadv_hard_iface *hard_iface;
@@ -877,7 +877,7 @@ static int batadv_softif_slave_del(struct net_device *dev,
 
 	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
 
-	if (!hard_iface || hard_iface->soft_iface != dev)
+	if (!hard_iface || hard_iface->mesh_iface != dev)
 		goto out;
 
 	batadv_hardif_disable_interface(hard_iface);
@@ -889,7 +889,7 @@ static int batadv_softif_slave_del(struct net_device *dev,
 }
 
 static const struct net_device_ops batadv_netdev_ops = {
-	.ndo_init = batadv_softif_init_late,
+	.ndo_init = batadv_meshif_init_late,
 	.ndo_open = batadv_interface_open,
 	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
@@ -900,8 +900,8 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_set_rx_mode = batadv_interface_set_rx_mode,
 	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr,
-	.ndo_add_slave = batadv_softif_slave_add,
-	.ndo_del_slave = batadv_softif_slave_del,
+	.ndo_add_slave = batadv_meshif_slave_add,
+	.ndo_del_slave = batadv_meshif_slave_del,
 };
 
 static void batadv_get_drvinfo(struct net_device *dev,
@@ -1009,10 +1009,10 @@ static const struct ethtool_ops batadv_ethtool_ops = {
 };
 
 /**
- * batadv_softif_free() - Deconstructor of batadv_soft_interface
+ * batadv_meshif_free() - Deconstructor of batadv_mesh_interface
  * @dev: Device to cleanup and remove
  */
-static void batadv_softif_free(struct net_device *dev)
+static void batadv_meshif_free(struct net_device *dev)
 {
 	batadv_mesh_free(dev);
 
@@ -1024,16 +1024,16 @@ static void batadv_softif_free(struct net_device *dev)
 }
 
 /**
- * batadv_softif_init_early() - early stage initialization of soft interface
+ * batadv_meshif_init_early() - early stage initialization of mesh interface
  * @dev: registered network device to modify
  */
-static void batadv_softif_init_early(struct net_device *dev)
+static void batadv_meshif_init_early(struct net_device *dev)
 {
 	ether_setup(dev);
 
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->needs_free_netdev = true;
-	dev->priv_destructor = batadv_softif_free;
+	dev->priv_destructor = batadv_meshif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->lltx = true;
@@ -1052,14 +1052,14 @@ static void batadv_softif_init_early(struct net_device *dev)
 }
 
 /**
- * batadv_softif_validate() - validate configuration of new batadv link
+ * batadv_meshif_validate() - validate configuration of new batadv link
  * @tb: IFLA_INFO_DATA netlink attributes
  * @data: enum batadv_ifla_attrs attributes
  * @extack: extended ACK report struct
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
+static int batadv_meshif_validate(struct nlattr *tb[], struct nlattr *data[],
 				  struct netlink_ext_ack *extack)
 {
 	struct batadv_algo_ops *algo_ops;
@@ -1077,14 +1077,14 @@ static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
 }
 
 /**
- * batadv_softif_newlink() - pre-initialize and register new batadv link
+ * batadv_meshif_newlink() - pre-initialize and register new batadv link
  * @dev: network device to register
  * @params: rtnl newlink parameters
  * @extack: extended ACK report struct
  *
  * Return: 0 if successful or error otherwise.
  */
-static int batadv_softif_newlink(struct net_device *dev,
+static int batadv_meshif_newlink(struct net_device *dev,
 				 struct rtnl_newlink_params *params,
 				 struct netlink_ext_ack *extack)
 {
@@ -1104,40 +1104,40 @@ static int batadv_softif_newlink(struct net_device *dev,
 }
 
 /**
- * batadv_softif_destroy_netlink() - deletion of batadv_soft_interface via
+ * batadv_meshif_destroy_netlink() - deletion of batadv_mesh_interface via
  *  netlink
- * @soft_iface: the to-be-removed batman-adv interface
+ * @mesh_iface: the to-be-removed batman-adv interface
  * @head: list pointer
  */
-static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
+static void batadv_meshif_destroy_netlink(struct net_device *mesh_iface,
 					  struct list_head *head)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface == soft_iface)
+		if (hard_iface->mesh_iface == mesh_iface)
 			batadv_hardif_disable_interface(hard_iface);
 	}
 
 	/* destroy the "untagged" VLAN */
-	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (vlan) {
-		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_put(vlan);
+		batadv_meshif_destroy_vlan(bat_priv, vlan);
+		batadv_meshif_vlan_put(vlan);
 	}
 
-	unregister_netdevice_queue(soft_iface, head);
+	unregister_netdevice_queue(mesh_iface, head);
 }
 
 /**
- * batadv_softif_is_valid() - Check whether device is a batadv soft interface
+ * batadv_meshif_is_valid() - Check whether device is a batadv mesh interface
  * @net_dev: device which should be checked
  *
  * Return: true when net_dev is a batman-adv interface, false otherwise
  */
-bool batadv_softif_is_valid(const struct net_device *net_dev)
+bool batadv_meshif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == batadv_interface_tx)
 		return true;
@@ -1152,10 +1152,10 @@ static const struct nla_policy batadv_ifla_policy[IFLA_BATADV_MAX + 1] = {
 struct rtnl_link_ops batadv_link_ops __read_mostly = {
 	.kind		= "batadv",
 	.priv_size	= sizeof(struct batadv_priv),
-	.setup		= batadv_softif_init_early,
+	.setup		= batadv_meshif_init_early,
 	.maxtype	= IFLA_BATADV_MAX,
 	.policy		= batadv_ifla_policy,
-	.validate	= batadv_softif_validate,
-	.newlink	= batadv_softif_newlink,
-	.dellink	= batadv_softif_destroy_netlink,
+	.validate	= batadv_meshif_validate,
+	.newlink	= batadv_meshif_newlink,
+	.dellink	= batadv_meshif_destroy_netlink,
 };
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/mesh-interface.h
similarity index 50%
rename from net/batman-adv/soft-interface.h
rename to net/batman-adv/mesh-interface.h
index 9f2003f1a497..7ba055b2bc26 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -4,8 +4,8 @@
  * Marek Lindner
  */
 
-#ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
-#define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
+#ifndef _NET_BATMAN_ADV_MESH_INTERFACE_H_
+#define _NET_BATMAN_ADV_MESH_INTERFACE_H_
 
 #include "main.h"
 
@@ -16,27 +16,27 @@
 #include <net/rtnetlink.h>
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
-void batadv_interface_rx(struct net_device *soft_iface,
+void batadv_interface_rx(struct net_device *mesh_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node);
-bool batadv_softif_is_valid(const struct net_device *net_dev);
+bool batadv_meshif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
-int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
-void batadv_softif_vlan_release(struct kref *ref);
-struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
+int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
+void batadv_meshif_vlan_release(struct kref *ref);
+struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 
 /**
- * batadv_softif_vlan_put() - decrease the vlan object refcounter and
+ * batadv_meshif_vlan_put() - decrease the vlan object refcounter and
  *  possibly release it
  * @vlan: the vlan object to release
  */
-static inline void batadv_softif_vlan_put(struct batadv_softif_vlan *vlan)
+static inline void batadv_meshif_vlan_put(struct batadv_meshif_vlan *vlan)
 {
 	if (!vlan)
 		return;
 
-	kref_put(&vlan->refcount, batadv_softif_vlan_release);
+	kref_put(&vlan->refcount, batadv_meshif_vlan_release);
 }
 
-#endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
+#endif /* _NET_BATMAN_ADV_MESH_INTERFACE_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d95c418484fa..5786680aff30 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -63,7 +63,7 @@ static void batadv_mcast_mla_update(struct work_struct *work);
 
 /**
  * batadv_mcast_start_timer() - schedule the multicast periodic worker
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
 {
@@ -72,18 +72,18 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_mcast_get_bridge() - get the bridge on top of the softif if it exists
- * @soft_iface: netdev struct of the mesh interface
+ * batadv_mcast_get_bridge() - get the bridge on top of the meshif if it exists
+ * @mesh_iface: netdev struct of the mesh interface
  *
- * If the given soft interface has a bridge on top then the refcount
+ * If the given mesh interface has a bridge on top then the refcount
  * of the according net device is increased.
  *
  * Return: NULL if no such bridge exists. Otherwise the net device of the
  * bridge.
  */
-static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
+static struct net_device *batadv_mcast_get_bridge(struct net_device *mesh_iface)
 {
-	struct net_device *upper = soft_iface;
+	struct net_device *upper = mesh_iface;
 
 	rcu_read_lock();
 	do {
@@ -97,7 +97,7 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
 }
 
 /**
- * batadv_mcast_mla_rtr_flags_softif_get_ipv4() - get mcast router flags from
+ * batadv_mcast_mla_rtr_flags_meshif_get_ipv4() - get mcast router flags from
  *  node for IPv4
  * @dev: the interface to check
  *
@@ -107,7 +107,7 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
  *
  * Return: BATADV_NO_FLAGS if present, BATADV_MCAST_WANT_NO_RTR4 otherwise.
  */
-static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv4(struct net_device *dev)
+static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv4(struct net_device *dev)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 
@@ -118,7 +118,7 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv4(struct net_device *dev)
 }
 
 /**
- * batadv_mcast_mla_rtr_flags_softif_get_ipv6() - get mcast router flags from
+ * batadv_mcast_mla_rtr_flags_meshif_get_ipv6() - get mcast router flags from
  *  node for IPv6
  * @dev: the interface to check
  *
@@ -129,7 +129,7 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv4(struct net_device *dev)
  * Return: BATADV_NO_FLAGS if present, BATADV_MCAST_WANT_NO_RTR6 otherwise.
  */
 #if IS_ENABLED(CONFIG_IPV6_MROUTE)
-static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv6(struct net_device *dev)
+static u8 batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
 {
 	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 
@@ -140,16 +140,16 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get_ipv6(struct net_device *dev)
 }
 #else
 static inline u8
-batadv_mcast_mla_rtr_flags_softif_get_ipv6(struct net_device *dev)
+batadv_mcast_mla_rtr_flags_meshif_get_ipv6(struct net_device *dev)
 {
 	return BATADV_MCAST_WANT_NO_RTR6;
 }
 #endif
 
 /**
- * batadv_mcast_mla_rtr_flags_softif_get() - get mcast router flags from node
- * @bat_priv: the bat priv with all the soft interface information
- * @bridge: bridge interface on top of the soft_iface if present,
+ * batadv_mcast_mla_rtr_flags_meshif_get() - get mcast router flags from node
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @bridge: bridge interface on top of the mesh_iface if present,
  *  otherwise pass NULL
  *
  * Checks the presence of IPv4 and IPv6 multicast routers on this
@@ -161,16 +161,16 @@ batadv_mcast_mla_rtr_flags_softif_get_ipv6(struct net_device *dev)
  *	BATADV_MCAST_WANT_NO_RTR6: No IPv6 multicast router is present
  *	The former two OR'd: no multicast router is present
  */
-static u8 batadv_mcast_mla_rtr_flags_softif_get(struct batadv_priv *bat_priv,
+static u8 batadv_mcast_mla_rtr_flags_meshif_get(struct batadv_priv *bat_priv,
 						struct net_device *bridge)
 {
-	struct net_device *dev = bridge ? bridge : bat_priv->soft_iface;
+	struct net_device *dev = bridge ? bridge : bat_priv->mesh_iface;
 	u8 flags = BATADV_NO_FLAGS;
 
 	rcu_read_lock();
 
-	flags |= batadv_mcast_mla_rtr_flags_softif_get_ipv4(dev);
-	flags |= batadv_mcast_mla_rtr_flags_softif_get_ipv6(dev);
+	flags |= batadv_mcast_mla_rtr_flags_meshif_get_ipv4(dev);
+	flags |= batadv_mcast_mla_rtr_flags_meshif_get_ipv6(dev);
 
 	rcu_read_unlock();
 
@@ -179,8 +179,8 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_mla_rtr_flags_bridge_get() - get mcast router flags from bridge
- * @bat_priv: the bat priv with all the soft interface information
- * @bridge: bridge interface on top of the soft_iface if present,
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @bridge: bridge interface on top of the mesh_iface if present,
  *  otherwise pass NULL
  *
  * Checks the presence of IPv4 and IPv6 multicast routers behind a bridge.
@@ -194,7 +194,7 @@ static u8 batadv_mcast_mla_rtr_flags_softif_get(struct batadv_priv *bat_priv,
 static u8 batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_priv,
 						struct net_device *bridge)
 {
-	struct net_device *dev = bat_priv->soft_iface;
+	struct net_device *dev = bat_priv->mesh_iface;
 	u8 flags = BATADV_NO_FLAGS;
 
 	if (!bridge)
@@ -210,8 +210,8 @@ static u8 batadv_mcast_mla_rtr_flags_bridge_get(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_mla_rtr_flags_get() - get multicast router flags
- * @bat_priv: the bat priv with all the soft interface information
- * @bridge: bridge interface on top of the soft_iface if present,
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @bridge: bridge interface on top of the mesh_iface if present,
  *  otherwise pass NULL
  *
  * Checks the presence of IPv4 and IPv6 multicast routers on this
@@ -228,7 +228,7 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
 {
 	u8 flags = BATADV_MCAST_WANT_NO_RTR4 | BATADV_MCAST_WANT_NO_RTR6;
 
-	flags &= batadv_mcast_mla_rtr_flags_softif_get(bat_priv, bridge);
+	flags &= batadv_mcast_mla_rtr_flags_meshif_get(bat_priv, bridge);
 	flags &= batadv_mcast_mla_rtr_flags_bridge_get(bat_priv, bridge);
 
 	return flags;
@@ -236,7 +236,7 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_mla_forw_flags_get() - get multicast forwarding flags
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Checks if all active hard interfaces have an MTU larger or equal to 1280
  * bytes (IPv6 minimum MTU).
@@ -252,7 +252,7 @@ static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (hard_iface->net_dev->mtu < IPV6_MIN_MTU) {
@@ -267,7 +267,7 @@ static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
 
 /**
  * batadv_mcast_mla_flags_get() - get the new multicast flags
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: A set of flags for the current/next TVLV, querier and
  * bridge state.
@@ -275,7 +275,7 @@ static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
 static struct batadv_mcast_mla_flags
 batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 {
-	struct net_device *dev = bat_priv->soft_iface;
+	struct net_device *dev = bat_priv->mesh_iface;
 	struct batadv_mcast_querier_state *qr4, *qr6;
 	struct batadv_mcast_mla_flags mla_flags;
 	struct net_device *bridge;
@@ -351,13 +351,13 @@ static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
 }
 
 /**
- * batadv_mcast_mla_softif_get_ipv4() - get softif IPv4 multicast listeners
+ * batadv_mcast_mla_meshif_get_ipv4() - get meshif IPv4 multicast listeners
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  * @flags: flags indicating the new multicast state
  *
  * Collects multicast addresses of IPv4 multicast listeners residing
- * on this kernel on the given soft interface, dev, in
+ * on this kernel on the given mesh interface, dev, in
  * the given mcast_list. In general, multicast listeners provided by
  * your multicast receiving applications run directly on this node.
  *
@@ -365,7 +365,7 @@ static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
  * items added to the mcast_list otherwise.
  */
 static int
-batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
+batadv_mcast_mla_meshif_get_ipv4(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
@@ -417,13 +417,13 @@ batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
 }
 
 /**
- * batadv_mcast_mla_softif_get_ipv6() - get softif IPv6 multicast listeners
+ * batadv_mcast_mla_meshif_get_ipv6() - get meshif IPv6 multicast listeners
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  * @flags: flags indicating the new multicast state
  *
  * Collects multicast addresses of IPv6 multicast listeners residing
- * on this kernel on the given soft interface, dev, in
+ * on this kernel on the given mesh interface, dev, in
  * the given mcast_list. In general, multicast listeners provided by
  * your multicast receiving applications run directly on this node.
  *
@@ -432,7 +432,7 @@ batadv_mcast_mla_softif_get_ipv4(struct net_device *dev,
  */
 #if IS_ENABLED(CONFIG_IPV6)
 static int
-batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
+batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
@@ -490,7 +490,7 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
 }
 #else
 static inline int
-batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
+batadv_mcast_mla_meshif_get_ipv6(struct net_device *dev,
 				 struct hlist_head *mcast_list,
 				 struct batadv_mcast_mla_flags *flags)
 {
@@ -499,13 +499,13 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
 #endif
 
 /**
- * batadv_mcast_mla_softif_get() - get softif multicast listeners
+ * batadv_mcast_mla_meshif_get() - get meshif multicast listeners
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  * @flags: flags indicating the new multicast state
  *
  * Collects multicast addresses of multicast listeners residing
- * on this kernel on the given soft interface, dev, in
+ * on this kernel on the given mesh interface, dev, in
  * the given mcast_list. In general, multicast listeners provided by
  * your multicast receiving applications run directly on this node.
  *
@@ -518,7 +518,7 @@ batadv_mcast_mla_softif_get_ipv6(struct net_device *dev,
  * items added to the mcast_list otherwise.
  */
 static int
-batadv_mcast_mla_softif_get(struct net_device *dev,
+batadv_mcast_mla_meshif_get(struct net_device *dev,
 			    struct hlist_head *mcast_list,
 			    struct batadv_mcast_mla_flags *flags)
 {
@@ -528,11 +528,11 @@ batadv_mcast_mla_softif_get(struct net_device *dev,
 	if (bridge)
 		dev = bridge;
 
-	ret4 = batadv_mcast_mla_softif_get_ipv4(dev, mcast_list, flags);
+	ret4 = batadv_mcast_mla_meshif_get_ipv4(dev, mcast_list, flags);
 	if (ret4 < 0)
 		goto out;
 
-	ret6 = batadv_mcast_mla_softif_get_ipv6(dev, mcast_list, flags);
+	ret6 = batadv_mcast_mla_meshif_get_ipv6(dev, mcast_list, flags);
 	if (ret6 < 0) {
 		ret4 = 0;
 		goto out;
@@ -576,7 +576,7 @@ static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
  *
  * Collects multicast addresses of multicast listeners residing
  * on foreign, non-mesh devices which we gave access to our mesh via
- * a bridge on top of the given soft interface, dev, in the given
+ * a bridge on top of the given mesh interface, dev, in the given
  * mcast_list.
  *
  * Return: -ENOMEM on memory allocation error or the number of
@@ -672,7 +672,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
 
 /**
  * batadv_mcast_mla_tt_retract() - clean up multicast listener announcements
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @mcast_list: a list of addresses which should _not_ be removed
  *
  * Retracts the announcement of any multicast listener from the
@@ -704,7 +704,7 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_mla_tt_add() - add multicast listener announcements
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @mcast_list: a list of addresses which are going to get added
  *
  * Adds multicast listener announcements from the given mcast_list to the
@@ -724,7 +724,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 						  &bat_priv->mcast.mla_list))
 			continue;
 
-		if (!batadv_tt_local_add(bat_priv->soft_iface,
+		if (!batadv_tt_local_add(bat_priv->mesh_iface,
 					 mcast_entry->addr, BATADV_NO_FLAGS,
 					 BATADV_NULL_IFINDEX, BATADV_NO_MARK))
 			continue;
@@ -737,7 +737,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
 /**
  * batadv_mcast_querier_log() - debug output regarding the querier status on
  *  link
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @str_proto: a string for the querier protocol (e.g. "IGMP" or "MLD")
  * @old_state: the previous querier state on our link
  * @new_state: the new querier state on our link
@@ -754,7 +754,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
  * potentially shadowing listeners from us then.
  *
  * This is only interesting for nodes with a bridge on top of their
- * soft interface.
+ * mesh interface.
  */
 static void
 batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
@@ -762,14 +762,14 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 			 struct batadv_mcast_querier_state *new_state)
 {
 	if (!old_state->exists && new_state->exists)
-		batadv_info(bat_priv->soft_iface, "%s Querier appeared\n",
+		batadv_info(bat_priv->mesh_iface, "%s Querier appeared\n",
 			    str_proto);
 	else if (old_state->exists && !new_state->exists)
-		batadv_info(bat_priv->soft_iface,
+		batadv_info(bat_priv->mesh_iface,
 			    "%s Querier disappeared - multicast optimizations disabled\n",
 			    str_proto);
 	else if (!bat_priv->mcast.mla_flags.bridged && !new_state->exists)
-		batadv_info(bat_priv->soft_iface,
+		batadv_info(bat_priv->mesh_iface,
 			    "No %s Querier present - multicast optimizations disabled\n",
 			    str_proto);
 
@@ -789,7 +789,7 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
 /**
  * batadv_mcast_bridge_log() - debug output for topology changes in bridged
  *  setups
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @new_flags: flags indicating the new multicast state
  *
  * If no bridges are ever used on this node, then this function does nothing.
@@ -798,7 +798,7 @@ batadv_mcast_querier_log(struct batadv_priv *bat_priv, char *str_proto,
  * which might be relevant to our multicast optimizations.
  *
  * More precisely, it outputs information when a bridge interface is added or
- * removed from a soft interface. And when a bridge is present, it further
+ * removed from a mesh interface. And when a bridge is present, it further
  * outputs information about the querier state which is relevant for the
  * multicast flags this node is going to set.
  */
@@ -827,7 +827,7 @@ batadv_mcast_bridge_log(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_flags_log() - output debug information about mcast flag changes
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @flags: TVLV flags indicating the new multicast state
  *
  * Whenever the multicast TVLV flags this node announces change, this function
@@ -860,7 +860,7 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 
 /**
  * batadv_mcast_mla_flags_update() - update multicast flags
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @flags: flags indicating the new multicast state
  *
  * Updates the own multicast tvlv with our current multicast related settings,
@@ -889,7 +889,7 @@ batadv_mcast_mla_flags_update(struct batadv_priv *bat_priv,
 
 /**
  * __batadv_mcast_mla_update() - update the own MLAs
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Updates the own multicast listener announcements in the translation
  * table as well as the own, announced multicast tvlv container.
@@ -901,18 +901,18 @@ batadv_mcast_mla_flags_update(struct batadv_priv *bat_priv,
  */
 static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 {
-	struct net_device *soft_iface = bat_priv->soft_iface;
+	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct hlist_head mcast_list = HLIST_HEAD_INIT;
 	struct batadv_mcast_mla_flags flags;
 	int ret;
 
 	flags = batadv_mcast_mla_flags_get(bat_priv);
 
-	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list, &flags);
+	ret = batadv_mcast_mla_meshif_get(mesh_iface, &mcast_list, &flags);
 	if (ret < 0)
 		goto out;
 
-	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list, &flags);
+	ret = batadv_mcast_mla_bridge_get(mesh_iface, &mcast_list, &flags);
 	if (ret < 0)
 		goto out;
 
@@ -977,7 +977,7 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
 /**
  * batadv_mcast_forw_mode_check_ipv4() - check for optimized forwarding
  *  potential
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
  * @is_routable: stores whether the destination is routable
@@ -1042,7 +1042,7 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
 /**
  * batadv_mcast_forw_mode_check_ipv6() - check for optimized forwarding
  *  potential
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
  * @is_routable: stores whether the destination is routable
@@ -1084,7 +1084,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_mode_check() - check for optimized forwarding potential
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
  * @is_routable: stores whether the destination is routable
@@ -1124,7 +1124,7 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 /**
  * batadv_mcast_forw_want_all_ip_count() - count nodes with unspecific mcast
  *  interest
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ethhdr: ethernet header of a packet
  *
  * Return: the number of nodes which want all IPv4 multicast traffic if the
@@ -1147,7 +1147,7 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_rtr_count() - count nodes with a multicast router
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @protocol: the ethernet protocol type to count multicast routers for
  *
  * Return: the number of nodes which want all routable IPv4 multicast traffic
@@ -1170,7 +1170,7 @@ static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_mode_by_count() - get forwarding mode by count
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
  * @is_routable: stores whether the destination is routable
@@ -1214,7 +1214,7 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_mode() - check on how to forward a multicast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
  * @is_routable: stores whether the destination is routable
@@ -1259,7 +1259,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_mcast_forw_send_orig() - send a multicast packet to an originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to send
  * @vid: the vlan identifier
  * @orig_node: the originator to send the packet to
@@ -1288,7 +1288,7 @@ static int batadv_mcast_forw_send_orig(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_tt() - forwards a packet to multicast listeners
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1336,7 +1336,7 @@ batadv_mcast_forw_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_mcast_forw_want_all_ipv4() - forward to nodes with want-all-ipv4
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1373,7 +1373,7 @@ batadv_mcast_forw_want_all_ipv4(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_want_all_ipv6() - forward to nodes with want-all-ipv6
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: The multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1410,7 +1410,7 @@ batadv_mcast_forw_want_all_ipv6(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_want_all() - forward packet to nodes in a want-all list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1439,7 +1439,7 @@ batadv_mcast_forw_want_all(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_want_all_rtr4() - forward to nodes with want-all-rtr4
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1476,7 +1476,7 @@ batadv_mcast_forw_want_all_rtr4(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_want_all_rtr6() - forward to nodes with want-all-rtr6
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: The multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1513,7 +1513,7 @@ batadv_mcast_forw_want_all_rtr6(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_want_rtr() - forward packet to nodes in a want-all-rtr list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  *
@@ -1542,7 +1542,7 @@ batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_send() - send packet to any detected multicast recipient
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
  * @is_routable: stores whether the destination is routable
@@ -1590,7 +1590,7 @@ int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_mcast_want_unsnoop_update() - update unsnoop counter and list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1636,7 +1636,7 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_want_ipv4_update() - update want-all-ipv4 counter and list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1681,7 +1681,7 @@ static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_want_ipv6_update() - update want-all-ipv6 counter and list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1726,7 +1726,7 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_want_rtr4_update() - update want-all-rtr4 counter and list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1771,7 +1771,7 @@ static void batadv_mcast_want_rtr4_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_want_rtr6_update() - update want-all-rtr6 counter and list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1816,7 +1816,7 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_have_mc_ptype_update() - update multicast packet type counter
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node which multicast state might have changed of
  * @mcast_flags: flags indicating the new multicast state
  *
@@ -1872,7 +1872,7 @@ batadv_mcast_tvlv_flags_get(bool enabled, void *tvlv_value, u16 tvlv_value_len)
 
 /**
  * batadv_mcast_tvlv_ogm_handler() - process incoming multicast tvlv container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the multicast data
@@ -1915,7 +1915,7 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_init() - initialize the multicast optimizations structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
@@ -1934,7 +1934,7 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 /**
  * batadv_mcast_mesh_info_put() - put multicast info into a netlink message
  * @msg: buffer for the message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 or error code.
  */
@@ -2060,7 +2060,7 @@ batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid,
  * @msg: buffer for the message
  * @portid: netlink port
  * @cb: Control block containing additional options
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @bucket: current bucket to dump
  * @idx: index in current bucket to the next entry to dump
  *
@@ -2103,15 +2103,15 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 				 struct batadv_hard_iface **primary_if)
 {
 	struct batadv_hard_iface *hard_iface = NULL;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	hard_iface = batadv_primary_if_get_selected(bat_priv);
 	if (!hard_iface || hard_iface->if_status != BATADV_IF_ACTIVE) {
@@ -2120,7 +2120,7 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 	}
 
 out:
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	if (!ret && primary_if)
 		*primary_if = hard_iface;
@@ -2150,7 +2150,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	if (ret)
 		return ret;
 
-	bat_priv = netdev_priv(primary_if->soft_iface);
+	bat_priv = netdev_priv(primary_if->mesh_iface);
 	ret = __batadv_mcast_flags_dump(msg, portid, cb, bat_priv, bucket, idx);
 
 	batadv_hardif_put(primary_if);
@@ -2159,7 +2159,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 /**
  * batadv_mcast_free() - free the multicast optimizations structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index fafd6ba8c056..b8668a80b94a 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -131,7 +131,7 @@ batadv_mcast_forw_orig_entry(struct hlist_node *node,
 
 /**
  * batadv_mcast_forw_push_dest() - push an originator MAC address onto an skb
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination address onto
  * @vid: the vlan identifier
  * @orig_node: the originator node to get the MAC address from
@@ -174,7 +174,7 @@ static bool batadv_mcast_forw_push_dest(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_push_dests_list() - push originators from list onto an skb
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
  * @head: the list to gather originators from
@@ -215,7 +215,7 @@ static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_push_tt() - push originators with interest through TT
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
  * @num_dests: a pointer to store the number of pushed addresses in
@@ -262,7 +262,7 @@ batadv_mcast_forw_push_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_mcast_forw_push_want_all() - push originators with want-all flag
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
  * @num_dests: a pointer to store the number of pushed addresses in
@@ -308,7 +308,7 @@ static bool batadv_mcast_forw_push_want_all(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_push_want_rtr() - push originators with want-router flag
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
  * @num_dests: a pointer to store the number of pushed addresses in
@@ -475,7 +475,7 @@ batadv_mcast_forw_push_adjust_padding(struct sk_buff *skb, int *count,
 
 /**
  * batadv_mcast_forw_push_dests() - push originator addresses onto an skb
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
  * @is_routable: indicates whether the destination is routable
@@ -567,7 +567,7 @@ static int batadv_mcast_forw_push_tracker(struct sk_buff *skb, int num_dests,
 
 /**
  * batadv_mcast_forw_push_tvlvs() - push a multicast tracker TVLV onto an skb
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the tracker TVLV onto
  * @vid: the vlan identifier
  * @is_routable: indicates whether the destination is routable
@@ -634,7 +634,7 @@ batadv_mcast_forw_push_hdr(struct sk_buff *skb, unsigned short tvlv_len)
 
 /**
  * batadv_mcast_forw_scrub_dests() - scrub destinations in a tracker TVLV
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @comp_neigh: next hop neighbor to scrub+collect destinations for
  * @dest: start MAC entry in original skb's tracker TVLV
  * @next_dest: start MAC entry in to be sent skb's tracker TVLV
@@ -905,7 +905,7 @@ static void batadv_mcast_forw_shrink_tracker(struct sk_buff *skb)
 
 /**
  * batadv_mcast_forw_packet() - forward a batman-adv multicast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the received or locally generated batman-adv multicast packet
  * @local_xmit: indicates that the packet was locally generated and not received
  *
@@ -920,7 +920,7 @@ static void batadv_mcast_forw_shrink_tracker(struct sk_buff *skb)
  *
  * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
  * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
- * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ * decapsulated and forwarded to the own mesh interface, NET_RX_DROP otherwise.
  */
 static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, bool local_xmit)
@@ -1028,7 +1028,7 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_tracker_tvlv_handler() - handle an mcast tracker tvlv
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the received batman-adv multicast packet
  *
  * Parses the tracker TVLV of an incoming batman-adv multicast packet and
@@ -1042,7 +1042,7 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
  *
  * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
  * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
- * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ * decapsulated and forwarded to the own mesh interface, NET_RX_DROP otherwise.
  */
 int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
@@ -1075,7 +1075,7 @@ unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
 
 /**
  * batadv_mcast_forw_expand_head() - expand headroom for an mcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to send
  *
  * Tries to expand an skb's headroom so that its head to tail is 1298
@@ -1110,7 +1110,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 
 /**
  * batadv_mcast_forw_push() - encapsulate skb in a batman-adv multicast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to encapsulate and send
  * @vid: the vlan identifier
  * @is_routable: indicates whether the destination is routable
@@ -1154,7 +1154,7 @@ bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_mcast_forw_mcsend() - send a self prepared batman-adv multicast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to encapsulate and send
  *
  * Transmits a batman-adv multicast packet that was locally prepared and
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index eefba5600ded..13935570fae1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -43,10 +43,10 @@
 #include "gateway_common.h"
 #include "hard-interface.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "multicast.h"
 #include "network-coding.h"
 #include "originator.h"
-#include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
 
@@ -63,7 +63,7 @@ enum batadv_netlink_multicast_groups {
  */
 enum batadv_genl_ops_flags {
 	/**
-	 * @BATADV_FLAG_NEED_MESH: request requires valid soft interface in
+	 * @BATADV_FLAG_NEED_MESH: request requires valid mesh interface in
 	 *  attribute BATADV_ATTR_MESH_IFINDEX and expects a pointer to it to be
 	 *  saved in info->user_ptr[0]
 	 */
@@ -166,24 +166,24 @@ static int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 }
 
 /**
- * batadv_netlink_mesh_fill_ap_isolation() - Add ap_isolation softif attribute
+ * batadv_netlink_mesh_fill_ap_isolation() - Add ap_isolation meshif attribute
  * @msg: Netlink message to dump into
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or negative error number in case of failure
  */
 static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
 						 struct batadv_priv *bat_priv)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	u8 ap_isolation;
 
-	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (!vlan)
 		return 0;
 
 	ap_isolation = atomic_read(&vlan->ap_isolation);
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 
 	return nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
 			  !!ap_isolation);
@@ -192,21 +192,21 @@ static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
 /**
  * batadv_netlink_set_mesh_ap_isolation() - Set ap_isolation from genl msg
  * @attr: parsed BATADV_ATTR_AP_ISOLATION_ENABLED attribute
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or negative error number in case of failure
  */
 static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
 						struct batadv_priv *bat_priv)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
-	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	vlan = batadv_meshif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (!vlan)
 		return -ENOENT;
 
 	atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 
 	return 0;
 }
@@ -214,7 +214,7 @@ static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
 /**
  * batadv_netlink_mesh_fill() - Fill message with mesh attributes
  * @msg: Netlink message to dump into
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @cmd: type of message to generate
  * @portid: Port making netlink request
  * @seq: sequence number for message
@@ -227,7 +227,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 				    enum batadv_nl_commands cmd,
 				    u32 portid, u32 seq, int flags)
 {
-	struct net_device *soft_iface = bat_priv->soft_iface;
+	struct net_device *mesh_iface = bat_priv->mesh_iface;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct net_device *hard_iface;
 	void *hdr;
@@ -239,10 +239,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
 			   bat_priv->algo_ops->name) ||
-	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, soft_iface->ifindex) ||
-	    nla_put_string(msg, BATADV_ATTR_MESH_IFNAME, soft_iface->name) ||
+	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, mesh_iface->ifindex) ||
+	    nla_put_string(msg, BATADV_ATTR_MESH_IFNAME, mesh_iface->name) ||
 	    nla_put(msg, BATADV_ATTR_MESH_ADDRESS, ETH_ALEN,
-		    soft_iface->dev_addr) ||
+		    mesh_iface->dev_addr) ||
 	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN,
 		       (u8)atomic_read(&bat_priv->tt.vn)))
 		goto nla_put_failure;
@@ -369,8 +369,8 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 }
 
 /**
- * batadv_netlink_notify_mesh() - send softif attributes to listener
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_netlink_notify_mesh() - send meshif attributes to listener
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success, < 0 on error
  */
@@ -391,14 +391,14 @@ static int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
 	}
 
 	genlmsg_multicast_netns(&batadv_netlink_family,
-				dev_net(bat_priv->soft_iface), msg, 0,
+				dev_net(bat_priv->mesh_iface), msg, 0,
 				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
 
 	return 0;
 }
 
 /**
- * batadv_netlink_get_mesh() - Get softif attributes
+ * batadv_netlink_get_mesh() - Get meshif attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
@@ -427,7 +427,7 @@ static int batadv_netlink_get_mesh(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_set_mesh() - Set softif attributes
+ * batadv_netlink_set_mesh() - Set meshif attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
@@ -474,7 +474,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 
 		atomic_set(&bat_priv->bridge_loop_avoidance,
 			   !!nla_get_u8(attr));
-		batadv_bla_status_update(bat_priv->soft_iface);
+		batadv_bla_status_update(bat_priv->mesh_iface);
 	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
@@ -484,7 +484,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 
 		atomic_set(&bat_priv->distributed_arp_table,
 			   !!nla_get_u8(attr));
-		batadv_dat_status_update(bat_priv->soft_iface);
+		batadv_dat_status_update(bat_priv->mesh_iface);
 	}
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
@@ -494,7 +494,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
 
 		rtnl_lock();
-		batadv_update_min_mtu(bat_priv->soft_iface);
+		batadv_update_min_mtu(bat_priv->mesh_iface);
 		rtnl_unlock();
 	}
 
@@ -594,7 +594,7 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_NETWORK_CODING_ENABLED];
 
 		atomic_set(&bat_priv->network_coding, !!nla_get_u8(attr));
-		batadv_nc_status_update(bat_priv->soft_iface);
+		batadv_nc_status_update(bat_priv->mesh_iface);
 	}
 #endif /* CONFIG_BATMAN_ADV_NC */
 
@@ -633,7 +633,7 @@ batadv_netlink_tp_meter_put(struct sk_buff *msg, u32 cookie)
 
 /**
  * batadv_netlink_tpmeter_notify() - send tp_meter result via netlink to client
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: destination of tp_meter session
  * @result: reason for tp meter session stop
  * @test_time: total time of the tp_meter session
@@ -680,7 +680,7 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&batadv_netlink_family,
-				dev_net(bat_priv->soft_iface), msg, 0,
+				dev_net(bat_priv->mesh_iface), msg, 0,
 				BATADV_NL_MCGRP_TPMETER, GFP_KERNEL);
 
 	return 0;
@@ -778,7 +778,7 @@ batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 /**
  * batadv_netlink_hardif_fill() - Fill message with hardif attributes
  * @msg: Netlink message to dump into
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: hard interface which was modified
  * @cmd: type of message to generate
  * @portid: Port making netlink request
@@ -806,11 +806,11 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
 		genl_dump_check_consistent(cb, hdr);
 
 	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
-			bat_priv->soft_iface->ifindex))
+			bat_priv->mesh_iface->ifindex))
 		goto nla_put_failure;
 
 	if (nla_put_string(msg, BATADV_ATTR_MESH_IFNAME,
-			   bat_priv->soft_iface->name))
+			   bat_priv->mesh_iface->name))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
@@ -850,7 +850,7 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
 
 /**
  * batadv_netlink_notify_hardif() - send hardif attributes to listener
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: hard interface which was modified
  *
  * Return: 0 on success, < 0 on error
@@ -873,7 +873,7 @@ static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
 	}
 
 	genlmsg_multicast_netns(&batadv_netlink_family,
-				dev_net(bat_priv->soft_iface), msg, 0,
+				dev_net(bat_priv->mesh_iface), msg, 0,
 				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
 
 	return 0;
@@ -963,24 +963,24 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 static int
 batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
 	int i = 0;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	rtnl_lock();
 	cb->seq = batadv_hardif_generation << 1 | 1;
 
 	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != soft_iface)
+		if (hard_iface->mesh_iface != mesh_iface)
 			continue;
 
 		if (i++ < skip)
@@ -997,7 +997,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 
 	rtnl_unlock();
 
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	cb->args[0] = i;
 
@@ -1007,7 +1007,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 /**
  * batadv_netlink_vlan_fill() - Fill message with vlan attributes
  * @msg: Netlink message to dump into
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vlan: vlan which was modified
  * @cmd: type of message to generate
  * @portid: Port making netlink request
@@ -1018,7 +1018,7 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
  */
 static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 				    struct batadv_priv *bat_priv,
-				    struct batadv_softif_vlan *vlan,
+				    struct batadv_meshif_vlan *vlan,
 				    enum batadv_nl_commands cmd,
 				    u32 portid, u32 seq, int flags)
 {
@@ -1029,11 +1029,11 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 		return -ENOBUFS;
 
 	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
-			bat_priv->soft_iface->ifindex))
+			bat_priv->mesh_iface->ifindex))
 		goto nla_put_failure;
 
 	if (nla_put_string(msg, BATADV_ATTR_MESH_IFNAME,
-			   bat_priv->soft_iface->name))
+			   bat_priv->mesh_iface->name))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_VLANID, vlan->vid & VLAN_VID_MASK))
@@ -1053,13 +1053,13 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 
 /**
  * batadv_netlink_notify_vlan() - send vlan attributes to listener
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vlan: vlan which was modified
  *
  * Return: 0 on success, < 0 on error
  */
 static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-				      struct batadv_softif_vlan *vlan)
+				      struct batadv_meshif_vlan *vlan)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -1076,7 +1076,7 @@ static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
 	}
 
 	genlmsg_multicast_netns(&batadv_netlink_family,
-				dev_net(bat_priv->soft_iface), msg, 0,
+				dev_net(bat_priv->mesh_iface), msg, 0,
 				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
 
 	return 0;
@@ -1091,7 +1091,7 @@ static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
  */
 static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
 {
-	struct batadv_softif_vlan *vlan = info->user_ptr[1];
+	struct batadv_meshif_vlan *vlan = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
 	struct sk_buff *msg;
 	int ret;
@@ -1121,7 +1121,7 @@ static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
  */
 static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 {
-	struct batadv_softif_vlan *vlan = info->user_ptr[1];
+	struct batadv_meshif_vlan *vlan = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
 	struct nlattr *attr;
 
@@ -1137,43 +1137,43 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_get_softif_from_ifindex() - Get soft-iface from ifindex
+ * batadv_netlink_get_meshif_from_ifindex() - Get mesh-iface from ifindex
  * @net: the applicable net namespace
- * @ifindex: index of the soft interface
+ * @ifindex: index of the mesh interface
  *
- * Return: Pointer to soft interface (with increased refcnt) on success, error
+ * Return: Pointer to mesh interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct net_device *
-batadv_netlink_get_softif_from_ifindex(struct net *net, int ifindex)
+batadv_netlink_get_meshif_from_ifindex(struct net *net, int ifindex)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface)
+	mesh_iface = dev_get_by_index(net, ifindex);
+	if (!mesh_iface)
 		return ERR_PTR(-ENODEV);
 
-	if (!batadv_softif_is_valid(soft_iface))
-		goto err_put_softif;
+	if (!batadv_meshif_is_valid(mesh_iface))
+		goto err_put_meshif;
 
-	return soft_iface;
+	return mesh_iface;
 
-err_put_softif:
-	dev_put(soft_iface);
+err_put_meshif:
+	dev_put(mesh_iface);
 
 	return ERR_PTR(-EINVAL);
 }
 
 /**
- * batadv_netlink_get_softif_from_info() - Get soft-iface from genl attributes
+ * batadv_netlink_get_meshif_from_info() - Get mesh-iface from genl attributes
  * @net: the applicable net namespace
  * @info: receiver information
  *
- * Return: Pointer to soft interface (with increased refcnt) on success, error
+ * Return: Pointer to mesh interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct net_device *
-batadv_netlink_get_softif_from_info(struct net *net, struct genl_info *info)
+batadv_netlink_get_meshif_from_info(struct net *net, struct genl_info *info)
 {
 	int ifindex;
 
@@ -1182,30 +1182,30 @@ batadv_netlink_get_softif_from_info(struct net *net, struct genl_info *info)
 
 	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
 
-	return batadv_netlink_get_softif_from_ifindex(net, ifindex);
+	return batadv_netlink_get_meshif_from_ifindex(net, ifindex);
 }
 
 /**
- * batadv_netlink_get_softif() - Retrieve soft interface from netlink callback
+ * batadv_netlink_get_meshif() - Retrieve mesh interface from netlink callback
  * @cb: callback structure containing arguments
  *
- * Return: Pointer to soft interface (with increased refcnt) on success, error
+ * Return: Pointer to mesh interface (with increased refcnt) on success, error
  *  pointer on error
  */
-struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb)
+struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb)
 {
 	int ifindex = batadv_netlink_get_ifindex(cb->nlh,
 						 BATADV_ATTR_MESH_IFINDEX);
 	if (!ifindex)
 		return ERR_PTR(-ENONET);
 
-	return batadv_netlink_get_softif_from_ifindex(sock_net(cb->skb->sk),
+	return batadv_netlink_get_meshif_from_ifindex(sock_net(cb->skb->sk),
 						      ifindex);
 }
 
 /**
  * batadv_netlink_get_hardif_from_ifindex() - Get hard-iface from ifindex
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @net: the applicable net namespace
  * @ifindex: index of the hard interface
  *
@@ -1227,7 +1227,7 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
 	if (!hard_iface)
 		goto err_put_harddev;
 
-	if (hard_iface->soft_iface != bat_priv->soft_iface)
+	if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 		goto err_put_hardif;
 
 	/* hard_dev is referenced by hard_iface and not needed here */
@@ -1245,7 +1245,7 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
 
 /**
  * batadv_netlink_get_hardif_from_info() - Get hard-iface from genl attributes
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @net: the applicable net namespace
  * @info: receiver information
  *
@@ -1268,7 +1268,7 @@ batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
 
 /**
  * batadv_netlink_get_hardif() - Retrieve hard interface from netlink callback
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @cb: callback structure containing arguments
  *
  * Return: Pointer to hard interface (with increased refcnt) on success, error
@@ -1290,18 +1290,18 @@ batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
 
 /**
  * batadv_get_vlan_from_info() - Retrieve vlan from genl attributes
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @net: the applicable net namespace
  * @info: receiver information
  *
  * Return: Pointer to vlan on success (with increased refcnt), error pointer
  *  on error
  */
-static struct batadv_softif_vlan *
+static struct batadv_meshif_vlan *
 batadv_get_vlan_from_info(struct batadv_priv *bat_priv, struct net *net,
 			  struct genl_info *info)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	u16 vid;
 
 	if (!info->attrs[BATADV_ATTR_VLANID])
@@ -1309,7 +1309,7 @@ batadv_get_vlan_from_info(struct batadv_priv *bat_priv, struct net *net,
 
 	vid = nla_get_u16(info->attrs[BATADV_ATTR_VLANID]);
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
 	if (!vlan)
 		return ERR_PTR(-ENOENT);
 
@@ -1331,8 +1331,8 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 	struct net *net = genl_info_net(info);
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv = NULL;
-	struct batadv_softif_vlan *vlan;
-	struct net_device *soft_iface;
+	struct batadv_meshif_vlan *vlan;
+	struct net_device *mesh_iface;
 	u8 user_ptr1_flags;
 	u8 mesh_dep_flags;
 	int ret;
@@ -1347,11 +1347,11 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 		return -EINVAL;
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
-		soft_iface = batadv_netlink_get_softif_from_info(net, info);
-		if (IS_ERR(soft_iface))
-			return PTR_ERR(soft_iface);
+		mesh_iface = batadv_netlink_get_meshif_from_info(net, info);
+		if (IS_ERR(mesh_iface))
+			return PTR_ERR(mesh_iface);
 
-		bat_priv = netdev_priv(soft_iface);
+		bat_priv = netdev_priv(mesh_iface);
 		info->user_ptr[0] = bat_priv;
 	}
 
@@ -1360,7 +1360,7 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 								 info);
 		if (IS_ERR(hard_iface)) {
 			ret = PTR_ERR(hard_iface);
-			goto err_put_softif;
+			goto err_put_meshif;
 		}
 
 		info->user_ptr[1] = hard_iface;
@@ -1370,7 +1370,7 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 		vlan = batadv_get_vlan_from_info(bat_priv, net, info);
 		if (IS_ERR(vlan)) {
 			ret = PTR_ERR(vlan);
-			goto err_put_softif;
+			goto err_put_meshif;
 		}
 
 		info->user_ptr[1] = vlan;
@@ -1378,9 +1378,9 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 
 	return 0;
 
-err_put_softif:
+err_put_meshif:
 	if (bat_priv)
-		dev_put(bat_priv->soft_iface);
+		dev_put(bat_priv->mesh_iface);
 
 	return ret;
 }
@@ -1396,7 +1396,7 @@ static void batadv_post_doit(const struct genl_split_ops *ops,
 			     struct genl_info *info)
 {
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	struct batadv_priv *bat_priv;
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_HARDIF &&
@@ -1408,12 +1408,12 @@ static void batadv_post_doit(const struct genl_split_ops *ops,
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_VLAN && info->user_ptr[1]) {
 		vlan = info->user_ptr[1];
-		batadv_softif_vlan_put(vlan);
+		batadv_meshif_vlan_put(vlan);
 	}
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH && info->user_ptr[0]) {
 		bat_priv = info->user_ptr[0];
-		dev_put(bat_priv->soft_iface);
+		dev_put(bat_priv->mesh_iface);
 	}
 }
 
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 2097c2ae98f1..fe4548b974bb 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -15,7 +15,7 @@
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb);
+struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb);
 struct batadv_hard_iface *
 batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
 			  struct netlink_callback *cb);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 71ebd0284f95..9f56308779cc 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -65,7 +65,7 @@ int __init batadv_nc_init(void)
 
 /**
  * batadv_nc_start_timer() - initialise the nc periodic worker
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 {
@@ -76,7 +76,7 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 /**
  * batadv_nc_tvlv_container_update() - update the network coding tvlv container
  *  after network coding setting change
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
 {
@@ -98,7 +98,7 @@ static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
 /**
  * batadv_nc_status_update() - update the network coding tvlv container after
  *  network coding setting change
- * @net_dev: the soft interface net device
+ * @net_dev: the mesh interface net device
  */
 void batadv_nc_status_update(struct net_device *net_dev)
 {
@@ -109,7 +109,7 @@ void batadv_nc_status_update(struct net_device *net_dev)
 
 /**
  * batadv_nc_tvlv_ogm_handler_v1() - process incoming nc tvlv container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the gateway data
@@ -128,7 +128,7 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 /**
  * batadv_nc_mesh_init() - initialise coding hash table and start housekeeping
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or negative error number in case of failure
  */
@@ -171,7 +171,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_nc_init_bat_priv() - initialise the nc specific bat_priv variables
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
@@ -267,7 +267,7 @@ static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
 
 /**
  * batadv_nc_to_purge_nc_node() - checks whether an nc node has to be purged
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @nc_node: the nc node to check
  *
  * Return: true if the entry has to be purged now, false otherwise
@@ -283,7 +283,7 @@ static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
 
 /**
  * batadv_nc_to_purge_nc_path_coding() - checks whether an nc path has timed out
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @nc_path: the nc path to check
  *
  * Return: true if the entry has to be purged now, false otherwise
@@ -304,7 +304,7 @@ static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_to_purge_nc_path_decoding() - checks whether an nc path has timed
  *  out
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @nc_path: the nc path to check
  *
  * Return: true if the entry has to be purged now, false otherwise
@@ -325,7 +325,7 @@ static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_purge_orig_nc_nodes() - go through list of nc nodes and purge stale
  *  entries
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @list: list of nc nodes
  * @lock: nc node list lock
  * @to_purge: function in charge to decide whether an entry has to be purged or
@@ -363,7 +363,7 @@ batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_purge_orig() - purges all nc node data attached of the given
  *  originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig_node with the nc node entries to be purged
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the nc node as argument and has to return
@@ -389,7 +389,7 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_purge_orig_hash() - traverse entire originator hash to check if
  *  they have timed out nc nodes
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 {
@@ -416,7 +416,7 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 /**
  * batadv_nc_purge_paths() - traverse all nc paths part of the hash and remove
  *  unused ones
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hash: hash table containing the nc paths to check
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the nc node as argument and has to return
@@ -579,7 +579,7 @@ static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
 
 /**
  * batadv_nc_sniffed_purge() - Checks timestamp of given sniffed nc_packet.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @nc_path: the nc path the packet belongs to
  * @nc_packet: the nc packet to be checked
  *
@@ -618,7 +618,7 @@ static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
 
 /**
  * batadv_nc_fwd_flush() - Checks the timestamp of the given nc packet.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @nc_path: the nc path the packet belongs to
  * @nc_packet: the nc packet to be checked
  *
@@ -657,7 +657,7 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_process_nc_paths() - traverse given nc packet pool and free timed
  *  out nc packets
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hash: to be processed hash table
  * @process_fn: Function called to process given nc packet. Should return true
  *	        to encourage this function to proceed with the next packet.
@@ -744,7 +744,7 @@ static void batadv_nc_worker(struct work_struct *work)
 /**
  * batadv_can_nc_with_orig() - checks whether the given orig node is suitable
  *  for coding or not
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: neighboring orig node which may be used as nc candidate
  * @ogm_packet: incoming ogm packet also used for the checks
  *
@@ -825,7 +825,7 @@ batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
 /**
  * batadv_nc_get_nc_node() - retrieves an nc node or creates the entry if it was
  *  not found
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node originating the ogm packet
  * @orig_neigh_node: neighboring orig node from which we received the ogm packet
  *  (can be equal to orig_node)
@@ -888,7 +888,7 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_update_nc_node() - updates stored incoming and outgoing nc node
  *  structs (best called on incoming OGMs)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node originating the ogm packet
  * @orig_neigh_node: neighboring orig node from which we received the ogm packet
  *  (can be equal to orig_node)
@@ -940,7 +940,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 
 /**
  * batadv_nc_get_path() - get existing nc_path or allocate a new one
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hash: hash table containing the nc path
  * @src: ethernet source address - first half of the nc path search key
  * @dst: ethernet destination address - second half of the nc path search key
@@ -1032,7 +1032,7 @@ static void batadv_nc_memxor(char *dst, const char *src, unsigned int len)
 /**
  * batadv_nc_code_packets() - code a received unicast_packet with an nc packet
  *  into a coded_packet and send it
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: data skb to forward
  * @ethhdr: pointer to the ethernet header inside the skb
  * @nc_packet: structure containing the packet to the skb can be coded with
@@ -1245,7 +1245,7 @@ static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, u8 *src)
 /**
  * batadv_nc_path_search() - Find the coding path matching in_nc_node and
  *  out_nc_node to retrieve a buffered packet that can be used for coding.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @in_nc_node: pointer to skb next hop's neighbor nc node
  * @out_nc_node: pointer to skb source's neighbor nc node
  * @skb: data skb to forward
@@ -1313,7 +1313,7 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_skb_src_search() - Loops through the list of neighboring nodes of
  *  the skb's sender (may be equal to the originator).
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: data skb to forward
  * @eth_dst: next hop mac address of skb
  * @eth_src: source mac address of skb
@@ -1359,7 +1359,7 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_skb_store_before_coding() - set the ethernet src and dst of the
  *  unicast skb before it is stored for use in later decoding
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: data skb to store
  * @eth_dst_new: new destination mac address of skb
  */
@@ -1408,7 +1408,7 @@ static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
 				     struct batadv_neigh_node *neigh_node,
 				     struct ethhdr *ethhdr)
 {
-	struct net_device *netdev = neigh_node->if_incoming->soft_iface;
+	struct net_device *netdev = neigh_node->if_incoming->mesh_iface;
 	struct batadv_priv *bat_priv = netdev_priv(netdev);
 	struct batadv_orig_node *orig_node = neigh_node->orig_node;
 	struct batadv_nc_node *nc_node;
@@ -1495,7 +1495,7 @@ static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
 bool batadv_nc_skb_forward(struct sk_buff *skb,
 			   struct batadv_neigh_node *neigh_node)
 {
-	const struct net_device *netdev = neigh_node->if_incoming->soft_iface;
+	const struct net_device *netdev = neigh_node->if_incoming->mesh_iface;
 	struct batadv_priv *bat_priv = netdev_priv(netdev);
 	struct batadv_unicast_packet *packet;
 	struct batadv_nc_path *nc_path;
@@ -1544,7 +1544,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 /**
  * batadv_nc_skb_store_for_decoding() - save a clone of the skb which can be
  *  used when decoding coded packets
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: data skb to store
  */
 void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
@@ -1605,7 +1605,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_skb_store_sniffed_unicast() - check if a received unicast packet
  *  should be saved in the decoding buffer and, if so, store it there
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: unicast skb to store
  */
 void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
@@ -1625,7 +1625,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_skb_decode_packet() - decode given skb using the decode data stored
  *  in nc_packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: unicast skb to decode
  * @nc_packet: decode data needed to decode the skb
  *
@@ -1719,7 +1719,7 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 /**
  * batadv_nc_find_decoding_packet() - search through buffered decoding data to
  *  find the data needed to decode the coded packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @ethhdr: pointer to the ethernet header inside the coded packet
  * @coded: coded packet we try to find decode data for
  *
@@ -1793,7 +1793,7 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_coded_packet *coded_packet;
 	struct batadv_nc_packet *nc_packet;
@@ -1858,7 +1858,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 
 /**
  * batadv_nc_mesh_free() - clean up network coding memory
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bcc2e20e0cd6..d9cfc5c6b208 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -47,7 +47,7 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
 
 /**
  * batadv_orig_hash_find() - Find and return originator from orig_hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @data: mac address of the originator
  *
  * Return: orig_node (with increased refcnt), NULL on errors
@@ -213,7 +213,7 @@ void batadv_orig_node_vlan_release(struct kref *ref)
 
 /**
  * batadv_originator_init() - Initialize all originator structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or negative error number in case of failure
  */
@@ -338,7 +338,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
 
 /**
  * batadv_orig_to_router() - get next hop neighbor to an orig address
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_addr: the originator MAC address to search the best next hop router for
  * @if_outgoing: the interface where the payload packet has been received or
  *  the OGM should be sent to
@@ -567,7 +567,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   const u8 *neigh_addr,
 			   struct batadv_orig_node *orig_node)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	struct batadv_hardif_neigh_node *hardif_neigh;
 
 	spin_lock_bh(&hard_iface->neigh_list_lock);
@@ -754,20 +754,20 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if, *hard_iface;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out_put_soft_iface;
+		goto out_put_mesh_iface;
 	}
 
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
@@ -794,8 +794,8 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	batadv_hardif_put(hard_iface);
 out_put_primary_if:
 	batadv_hardif_put(primary_if);
-out_put_soft_iface:
-	dev_put(soft_iface);
+out_put_mesh_iface:
+	dev_put(mesh_iface);
 
 	return ret;
 }
@@ -892,7 +892,7 @@ void batadv_orig_node_release(struct kref *ref)
 
 /**
  * batadv_originator_free() - Free all originator structures
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
@@ -928,7 +928,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 
 /**
  * batadv_orig_node_new() - creates a new orig_node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the originator
  *
  * Creates a new originator object and initialises all the generic fields.
@@ -1009,7 +1009,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 
 /**
  * batadv_purge_neigh_ifinfo() - purge obsolete ifinfo entries from neighbor
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @neigh: orig node which is to be checked
  */
 static void
@@ -1050,7 +1050,7 @@ batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
 
 /**
  * batadv_purge_orig_ifinfo() - purge obsolete ifinfo entries from originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be checked
  *
  * Return: true if any ifinfo entry was purged, false otherwise.
@@ -1102,7 +1102,7 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 
 /**
  * batadv_purge_orig_neighbors() - purges neighbors from originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be checked
  *
  * Return: true if any neighbor was purged, false otherwise
@@ -1160,7 +1160,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 /**
  * batadv_find_best_neighbor() - finds the best neighbor after purging
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be checked
  * @if_outgoing: the interface for which the metric should be compared
  *
@@ -1194,7 +1194,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 
 /**
  * batadv_purge_orig_node() - purges obsolete information from an orig_node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be checked
  *
  * This function checks if the orig_node or substructures of it have become
@@ -1236,7 +1236,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
@@ -1258,7 +1258,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
 /**
  * batadv_purge_orig_ref() - Purge all outdated originators
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 {
@@ -1325,20 +1325,20 @@ static void batadv_purge_orig(struct work_struct *work)
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if, *hard_iface;
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	int ret;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out_put_soft_iface;
+		goto out_put_mesh_iface;
 	}
 
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
@@ -1365,8 +1365,8 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	batadv_hardif_put(hard_iface);
 out_put_primary_if:
 	batadv_hardif_put(primary_if);
-out_put_soft_iface:
-	dev_put(soft_iface);
+out_put_mesh_iface:
+	dev_put(mesh_iface);
 
 	return ret;
 }
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index f1061985149f..35d8c5783999 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -30,10 +30,10 @@
 #include "fragmentation.h"
 #include "hard-interface.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "tp_meter.h"
 #include "translation-table.h"
 #include "tvlv.h"
@@ -43,7 +43,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 /**
  * _batadv_update_route() - set the router for this originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be configured
  * @recv_if: the receive interface for which this route is set
  * @neigh_node: neighbor which should be the next router
@@ -106,7 +106,7 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 
 /**
  * batadv_update_route() - set the router for this originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which is to be configured
  * @recv_if: the receive interface for which this route is set
  * @neigh_node: neighbor which should be the next router
@@ -133,7 +133,7 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 /**
  * batadv_window_protected() - checks whether the host restarted and is in the
  *  protection time.
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @seq_num_diff: difference between the current/received sequence number and
  *  the last sequence number
  * @seq_old_max_diff: maximum age of sequence number not considered as restart
@@ -207,7 +207,7 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 
 /**
  * batadv_recv_my_icmp_packet() - receive an icmp packet locally
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: icmp packet to process
  *
  * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
@@ -338,7 +338,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_icmp_header *icmph;
 	struct batadv_icmp_packet_rr *icmp_packet_rr;
 	struct ethhdr *ethhdr;
@@ -428,7 +428,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 /**
  * batadv_check_unicast_packet() - Check for malformed unicast packets
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  * @hdr_size: size of header to pull
  *
@@ -511,7 +511,7 @@ batadv_last_bonding_replace(struct batadv_orig_node *orig_node,
 
 /**
  * batadv_find_router() - find a suitable router for this originator
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the destination node
  * @recv_if: pointer to interface this packet was received on
  *
@@ -656,7 +656,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
@@ -727,7 +727,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 /**
  * batadv_reroute_unicast_packet() - update the unicast header for re-routing
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: unicast packet to process
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
@@ -879,7 +879,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		return false;
 
 	/* update the header in order to let the packet be delivered to this
-	 * node's soft interface
+	 * node's mesh interface
 	 */
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -909,7 +909,7 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if)
 {
 	struct batadv_unicast_packet *unicast_packet;
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	int check, hdr_size = sizeof(*unicast_packet);
 
 	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
@@ -938,7 +938,7 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 	u8 *orig_addr, *orig_addr_gw;
@@ -1017,7 +1017,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
 
-		batadv_interface_rx(recv_if->soft_iface, skb, hdr_size,
+		batadv_interface_rx(recv_if->mesh_iface, skb, hdr_size,
 				    orig_node);
 
 rx_success:
@@ -1047,7 +1047,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
 	unsigned char *tvlv_buff;
 	u16 tvlv_buff_len;
@@ -1103,7 +1103,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_orig_node *orig_node_src = NULL;
 	struct batadv_frag_packet *frag_packet;
 	int ret = NET_RX_DROP;
@@ -1165,7 +1165,7 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
@@ -1255,7 +1255,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
 
 	/* broadcast for me */
-	batadv_interface_rx(recv_if->soft_iface, skb, hdr_size, orig_node);
+	batadv_interface_rx(recv_if->mesh_iface, skb, hdr_size, orig_node);
 
 rx_success:
 	ret = NET_RX_SUCCESS;
@@ -1279,14 +1279,14 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  *
  * Parses the given, received batman-adv multicast packet. Depending on the
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
- * soft interface.
+ * mesh interface.
  *
  * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
 {
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_mcast_packet *mcast_packet;
 	int hdr_size = sizeof(*mcast_packet);
 	unsigned char *tvlv_buff;
@@ -1329,7 +1329,7 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
 		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_RX_LOCAL_BYTES,
 				   skb->len - hdr_size);
 
-		batadv_interface_rx(bat_priv->soft_iface, skb, hdr_size, NULL);
+		batadv_interface_rx(bat_priv->mesh_iface, skb, hdr_size, NULL);
 		/* skb was consumed */
 		skb = NULL;
 	}
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 0379b126865d..85478fdc8ce8 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -34,10 +34,10 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "routing.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
@@ -68,7 +68,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	struct ethhdr *ethhdr;
 	int ret;
 
-	bat_priv = netdev_priv(hard_iface->soft_iface);
+	bat_priv = netdev_priv(hard_iface->mesh_iface);
 
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		goto send_skb_err;
@@ -272,7 +272,7 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
 /**
  * batadv_send_skb_prepare_unicast_4addr() - encapsulate an skb with a
  *  unicast 4addr header
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb containing the payload to encapsulate
  * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
@@ -314,7 +314,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_skb_unicast() - encapsulate and send an skb via unicast
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: payload to send
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
@@ -384,7 +384,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_skb_via_tt_generic() - send an skb via TT lookup
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: payload to send
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
@@ -430,7 +430,7 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_skb_via_gw() - send an skb via gateway lookup
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: payload to send
  * @vid: the vid to be used to search the translation table
  *
@@ -695,7 +695,7 @@ static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_packet,
 
 /**
  * batadv_forw_packet_bcast_queue() - try to queue a broadcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the forwarding packet to queue
  * @send_time: timestamp (jiffies) when the packet is to be sent
  *
@@ -714,7 +714,7 @@ batadv_forw_packet_bcast_queue(struct batadv_priv *bat_priv,
 
 /**
  * batadv_forw_packet_ogmv1_queue() - try to queue an OGMv1 packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the forwarding packet to queue
  * @send_time: timestamp (jiffies) when the packet is to be sent
  *
@@ -732,7 +732,7 @@ void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 
 /**
  * batadv_forw_bcast_packet_to_list() - queue broadcast packet for transmissions
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
@@ -787,7 +787,7 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 /**
  * batadv_forw_bcast_packet_if() - forward and queue a broadcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
@@ -838,7 +838,7 @@ static int batadv_forw_bcast_packet_if(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_no_broadcast() - check whether (re)broadcast is necessary
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to check
  * @own_packet: true if it is a self-generated broadcast packet
  * @if_out: the outgoing interface checked and considered for (re)broadcast
@@ -900,7 +900,7 @@ static bool batadv_send_no_broadcast(struct batadv_priv *bat_priv,
 
 /**
  * __batadv_forw_bcast_packet() - forward and queue a broadcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
@@ -930,7 +930,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
+		if (hard_iface->mesh_iface != bat_priv->mesh_iface)
 			continue;
 
 		if (!kref_get_unless_zero(&hard_iface->refcount))
@@ -958,7 +958,7 @@ static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 
 /**
  * batadv_forw_bcast_packet() - forward and queue a broadcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
@@ -979,7 +979,7 @@ int batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_bcast_packet() - send and queue a broadcast packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
@@ -1060,7 +1060,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
-	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+	bat_priv = netdev_priv(forw_packet->if_incoming->mesh_iface);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
@@ -1095,7 +1095,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 /**
  * batadv_purge_outstanding_packets() - stop/purge scheduled bcast/OGMv1 packets
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hard_iface: the hard interface to cancel and purge bcast/ogm packets on
  *
  * This method cancels and purges any broadcast and OGMv1 packet on the given
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 08af251b765c..3415afec4a0c 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -68,7 +68,7 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 /**
  * batadv_send_skb_via_tt() - send an skb via TT lookup
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the payload to send
  * @dst_hint: can be used to override the destination contained in the skb
  * @vid: the vid to be used to search the translation table
@@ -89,7 +89,7 @@ static inline int batadv_send_skb_via_tt(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_skb_via_tt_4addr() - send an skb via TT lookup
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
  * @dst_hint: can be used to override the destination contained in the skb
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 7f3dd3c393e0..9fb14e40e156 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -206,7 +206,7 @@ static void batadv_tp_update_rto(struct batadv_tp_vars *tp_vars,
  * batadv_tp_batctl_notify() - send client status result to client
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @start_time: start of transmission in jiffies
  * @total_sent: bytes acked to the receiver
  * @cookie: cookie of tp_meter session
@@ -238,7 +238,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
  * batadv_tp_batctl_error_notify() - send client error result to client
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @cookie: cookie of tp_meter session
  */
 static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
@@ -251,7 +251,7 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 
 /**
  * batadv_tp_list_find() - find a tp_vars object in the global list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
  *
  * Look for a tp_vars object matching dst as end_point and return it after
@@ -287,7 +287,7 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 /**
  * batadv_tp_list_find_session() - find tp_vars session object in the global
  *  list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
  * @session: session identifier
  *
@@ -366,7 +366,7 @@ static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
 
 /**
  * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tp_vars: the private data of the current TP meter session to cleanup
  */
 static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
@@ -396,7 +396,7 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tp_sender_end() - print info about ended session and inform client
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
@@ -619,7 +619,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 
 /**
  * batadv_tp_recv_ack() - ACK receiving function
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the buffer containing the received packet
  *
  * Process a received TP ACK packet
@@ -832,7 +832,7 @@ static int batadv_tp_send(void *arg)
 	}
 
 	/* assume that all the hard_interfaces have a correctly
-	 * configured MTU, so use the soft_iface MTU as MSS.
+	 * configured MTU, so use the mesh_iface MTU as MSS.
 	 * This might not be true and in that case the fragmentation
 	 * should be used.
 	 * Now, try to send the packet as it is
@@ -927,7 +927,7 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 
 /**
  * batadv_tp_start() - start a new tp meter session
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the receiver MAC address
  * @test_length: test length in milliseconds
  * @cookie: session cookie
@@ -993,7 +993,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* initialise the CWND to 3*MSS (Section 3.1 in RFC5681).
 	 * For batman-adv the MSS is the size of the payload received by the
-	 * soft_interface, hence its MTU
+	 * mesh_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
 	/* at the beginning initialise the SS threshold to the biggest possible
@@ -1052,7 +1052,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 /**
  * batadv_tp_stop() - stop currently running tp meter session
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the receiver MAC address
  * @return_value: reason for tp meter session stop
  */
@@ -1141,7 +1141,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 
 /**
  * batadv_tp_send_ack() - send an ACK packet
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the mac address of the destination originator
  * @seq: the sequence number to ACK
  * @timestamp: the timestamp to echo back in the ACK
@@ -1320,7 +1320,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 
 /**
  * batadv_tp_init_recv() - return matching or create new receiver tp_vars
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @icmp: received icmp tp msg
  *
  * Return: corresponding tp_vars or NULL on errors
@@ -1373,7 +1373,7 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tp_recv_msg() - process a single data message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the buffer containing the received packet
  *
  * Process a received TP MSG packet
@@ -1457,7 +1457,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tp_meter_recv() - main TP Meter receiving function
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the buffer containing the received packet
  */
 void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 6b816cf1a953..7da692ec38e9 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -34,7 +34,7 @@ TRACE_EVENT(batadv_dbg,
 	    TP_ARGS(bat_priv, vaf),
 
 	    TP_STRUCT__entry(
-		    __string(device, bat_priv->soft_iface->name)
+		    __string(device, bat_priv->mesh_iface->name)
 		    __string(driver, KBUILD_MODNAME)
 		    __vstring(msg, vaf->fmt, vaf->va)
 	    ),
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d4b71d34310f..4a3165920de1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -47,9 +47,9 @@
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
+#include "mesh-interface.h"
 #include "netlink.h"
 #include "originator.h"
-#include "soft-interface.h"
 #include "tvlv.h"
 
 static struct kmem_cache *batadv_tl_cache __read_mostly;
@@ -161,7 +161,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 
 /**
  * batadv_tt_local_hash_find() - search the local table for a given client
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
  *
@@ -186,7 +186,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 
 /**
  * batadv_tt_global_hash_find() - search the global table for a given client
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
  *
@@ -221,7 +221,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 	tt_local_entry = container_of(ref, struct batadv_tt_local_entry,
 				      common.refcount);
 
-	batadv_softif_vlan_put(tt_local_entry->vlan);
+	batadv_meshif_vlan_put(tt_local_entry->vlan);
 
 	kfree_rcu(tt_local_entry, common.rcu);
 }
@@ -260,7 +260,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 /**
  * batadv_tt_global_hash_count() - count the number of orig entries
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -286,28 +286,28 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_size_mod() - change the size by v of the local table
  *  identified by vid
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier of the sub-table to change
  * @v: the amount to sum to the local table size
  */
 static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
 				     unsigned short vid, int v)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (!vlan)
 		return;
 
 	atomic_add(v, &vlan->tt.num_entries);
 
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 }
 
 /**
  * batadv_tt_local_size_inc() - increase by one the local table size for the
  *  given vid
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
  */
 static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
@@ -319,7 +319,7 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_size_dec() - decrease by one the local table size for the
  *  given vid
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
@@ -412,7 +412,7 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 
 /**
  * batadv_tt_local_event() - store a local TT event (ADD/DEL)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: the TT entry involved in the event
  * @event_flags: flags to store in the event structure
  */
@@ -504,7 +504,7 @@ static u16 batadv_tt_entries(u16 tt_len)
 /**
  * batadv_tt_local_table_transmit_size() - calculates the local translation
  *  table size when transmitted over the air
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: local translation table size in bytes.
  */
@@ -512,11 +512,11 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 {
 	u16 num_vlan = 0;
 	u16 tt_local_entries = 0;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	int hdr_size;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
 		num_vlan++;
 		tt_local_entries += atomic_read(&vlan->tt.num_entries);
 	}
@@ -576,7 +576,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
- * @soft_iface: netdev struct of the mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  * @addr: the mac address of the client to add
  * @vid: VLAN identifier
  * @ifindex: index of the interface where the client is connected to (useful to
@@ -586,14 +586,14 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
  *
  * Return: true if the client was successfully added, false otherwise.
  */
-bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
+bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
-	struct net *net = dev_net(soft_iface);
-	struct batadv_softif_vlan *vlan;
+	struct net *net = dev_net(mesh_iface);
+	struct batadv_meshif_vlan *vlan;
 	struct net_device *in_dev = NULL;
 	struct batadv_hard_iface *in_hardif = NULL;
 	struct hlist_head *head;
@@ -650,7 +650,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	table_size += batadv_tt_len(1);
 	packet_size_max = atomic_read(&bat_priv->packet_size_max);
 	if (table_size > packet_size_max) {
-		net_ratelimited_function(batadv_info, soft_iface,
+		net_ratelimited_function(batadv_info, mesh_iface,
 					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
 					 table_size, packet_size_max, addr);
 		goto out;
@@ -661,9 +661,9 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		goto out;
 
 	/* increase the refcounter of the related vlan */
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (!vlan) {
-		net_ratelimited_function(batadv_info, soft_iface,
+		net_ratelimited_function(batadv_info, mesh_iface,
 					 "adding TT local entry %pM to non-existent VLAN %d\n",
 					 addr, batadv_print_vid(vid));
 		kmem_cache_free(batadv_tl_cache, tt_local);
@@ -693,7 +693,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	/* the batman interface mac and multicast addresses should never be
 	 * purged
 	 */
-	if (batadv_compare_eth(addr, soft_iface->dev_addr) ||
+	if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
@@ -849,7 +849,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 /**
  * batadv_tt_prepare_tvlv_local_data() - allocate and prepare the TT TVLV for
  *  this node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_data: uninitialised pointer to the address of the TVLV buffer
  * @tt_change: uninitialised pointer to the address of the area where the TT
  *  changes can be stored
@@ -871,7 +871,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 				  s32 *tt_len)
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
@@ -879,8 +879,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	u8 *tt_change_ptr;
 	int change_offset;
 
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
+	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
+	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
 			continue;
@@ -909,7 +909,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (*tt_data)->vlan_data;
-	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
 			continue;
@@ -925,14 +925,14 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 
 out:
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+	spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 	return tvlv_len;
 }
 
 /**
  * batadv_tt_tvlv_container_update() - update the translation table tvlv
  *  container after local tt changes have been committed
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 {
@@ -956,7 +956,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	 * The local change history should still be cleaned up so the next
 	 * TT round can start again with a clean state.
 	 */
-	if (tt_diff_len > bat_priv->soft_iface->mtu) {
+	if (tt_diff_len > bat_priv->mesh_iface->mtu) {
 		tt_diff_len = 0;
 		tt_diff_entries_num = 0;
 		drop_changes = true;
@@ -1025,7 +1025,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
  * @msg :Netlink message to dump into
  * @portid: Port making netlink request
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @common: tt local & tt global common data
  *
  * Return: Error code, or 0 on success
@@ -1037,7 +1037,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 			   struct batadv_tt_common_entry *common)
 {
 	void *hdr;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	struct batadv_tt_local_entry *local;
 	unsigned int last_seen_msecs;
 	u32 crc;
@@ -1045,13 +1045,13 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
 	local = container_of(common, struct batadv_tt_local_entry, common);
 	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
 
-	vlan = batadv_softif_vlan_get(bat_priv, common->vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, common->vid);
 	if (!vlan)
 		return 0;
 
 	crc = vlan->tt.crc;
 
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 
 	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
 			  &batadv_netlink_family,  NLM_F_MULTI,
@@ -1084,7 +1084,7 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @cb: Control block containing additional options
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @hash: hash to dump
  * @bucket: bucket index to dump
  * @idx_s: Number of entries to skip
@@ -1130,7 +1130,7 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
  */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
@@ -1139,11 +1139,11 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int idx = cb->args[1];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
@@ -1165,7 +1165,7 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
  out:
 	batadv_hardif_put(primary_if);
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	cb->args[0] = bucket;
 	cb->args[1] = idx;
@@ -1194,7 +1194,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the MAC address of the client to remove
  * @vid: VLAN identifier
  * @message: message to append to the log on deletion
@@ -1259,7 +1259,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 
 /**
  * batadv_tt_local_purge_list() - purge inactive tt local entries
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @head: pointer to the list containing the local tt entries
  * @timeout: parameter deciding whether a given tt local entry is considered
  *  inactive or not
@@ -1294,7 +1294,7 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_local_purge() - purge inactive tt local entries
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @timeout: parameter deciding whether a given tt local entry is considered
  *  inactive or not
  */
@@ -1529,7 +1529,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 /**
  * batadv_tt_global_add() - add a new TT global entry or update an existing one
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the originator announcing the client
  * @tt_addr: the mac address of the non-mesh client
  * @vid: VLAN identifier
@@ -1702,7 +1702,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 /**
  * batadv_transtable_best_orig() - Get best originator list entry from tt entry
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_global_entry: global translation table entry to be analyzed
  *
  * This function assumes the caller holds rcu_read_lock().
@@ -1809,7 +1809,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @common: tt local & tt global common data
  * @sub_s: Number of entries to skip
  *
@@ -1854,7 +1854,7 @@ batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
  * @seq: Sequence number of netlink message
- * @bat_priv: The bat priv with all the soft interface information
+ * @bat_priv: The bat priv with all the mesh interface information
  * @head: Pointer to the list containing the global tt entries
  * @idx_s: Number of entries to skip
  * @sub: Number of entries to skip
@@ -1897,7 +1897,7 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
@@ -1908,11 +1908,11 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int sub = cb->args[2];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	soft_iface = batadv_netlink_get_softif(cb);
-	if (IS_ERR(soft_iface))
-		return PTR_ERR(soft_iface);
+	mesh_iface = batadv_netlink_get_meshif(cb);
+	if (IS_ERR(mesh_iface))
+		return PTR_ERR(mesh_iface);
 
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
@@ -1937,7 +1937,7 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
  out:
 	batadv_hardif_put(primary_if);
-	dev_put(soft_iface);
+	dev_put(mesh_iface);
 
 	cb->args[0] = bucket;
 	cb->args[1] = idx;
@@ -1990,7 +1990,7 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_del_orig_node() - remove orig_node from a global tt entry
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_global_entry: the global entry to remove the orig_node from
  * @orig_node: the originator announcing the client
  * @message: message to append to the log on deletion
@@ -2069,7 +2069,7 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_global_del() - remove a client from the global table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: an originator serving this client
  * @addr: the mac address of the client
  * @vid: VLAN identifier
@@ -2134,7 +2134,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_del_orig() - remove all the TT global entries belonging to
  *  the given originator matching the provided vid
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the originator owning the entries to remove
  * @match_vid: the VLAN identifier to match. If negative all the entries will be
  *  removed
@@ -2305,7 +2305,7 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 
 /**
  * batadv_transtable_search() - get the mesh destination for a given client
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @src: mac address of the source client
  * @addr: mac address of the destination client
  * @vid: VLAN identifier
@@ -2364,7 +2364,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_crc() - calculates the checksum of the local table belonging
  *  to the given orig_node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: originator for which the CRC should be computed
  * @vid: VLAN identifier for which the CRC32 has to be computed
  *
@@ -2458,7 +2458,7 @@ static u32 batadv_tt_global_crc(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_local_crc() - calculates the checksum of the local table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @vid: VLAN identifier for which the CRC32 has to be computed
  *
  * For details about the computation, please refer to the documentation for
@@ -2593,7 +2593,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 
 /**
  * batadv_tt_req_node_new() - search and possibly create a tt_req_node object
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node this request is being issued for
  *
  * Return: the pointer to the new tt_req_node struct if no request
@@ -2689,7 +2689,7 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
 /**
  * batadv_tt_tvlv_generate() - fill the tvlv buff with the tt entries from the
  *  specified tt hash
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @hash: hash table containing the tt entries
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
@@ -2810,15 +2810,15 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 
 /**
  * batadv_tt_local_update_crc() - update all the local CRCs
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 static void batadv_tt_local_update_crc(struct batadv_priv *bat_priv)
 {
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 
 	/* recompute the global CRC for each VLAN */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+	hlist_for_each_entry_rcu(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan->tt.crc = batadv_tt_local_crc(bat_priv, vlan->vid);
 	}
 	rcu_read_unlock();
@@ -2826,7 +2826,7 @@ static void batadv_tt_local_update_crc(struct batadv_priv *bat_priv)
 
 /**
  * batadv_tt_global_update_crc() - update all the global CRCs for this orig_node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the orig_node for which the CRCs have to be updated
  */
 static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
@@ -2853,7 +2853,7 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_tt_request() - send a TT Request message to a given node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @dst_orig_node: the destination of the message
  * @ttvn: the version number that the source of the message is looking for
  * @tt_vlan: pointer to the first tvlv VLAN object to request
@@ -2938,7 +2938,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 /**
  * batadv_send_other_tt_response() - send reply to tt request concerning another
  *  node's translation table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
  * @req_dst: mac address of tt request recipient
@@ -3029,7 +3029,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	/* Don't send the response, if larger than fragmented packet. */
 	tt_len = sizeof(struct batadv_unicast_tvlv_packet) + tvlv_len;
 	if (tt_len > atomic_read(&bat_priv->packet_size_max)) {
-		net_ratelimited_function(batadv_info, bat_priv->soft_iface,
+		net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
 					 "Ignoring TT_REQUEST from %pM; Response size exceeds max packet size.\n",
 					 res_dst_orig_node->orig);
 		goto out;
@@ -3068,7 +3068,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 /**
  * batadv_send_my_tt_response() - send reply to tt request concerning this
  *  node's translation table
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
  *
@@ -3185,7 +3185,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 /**
  * batadv_send_tt_response() - send reply to tt request
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_data: tt data containing the tt request information
  * @req_src: mac address of tt request sender
  * @req_dst: mac address of tt request recipient
@@ -3280,7 +3280,7 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 
 /**
  * batadv_is_my_client() - check if a client is served by the local node
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
  *
@@ -3309,7 +3309,7 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 
 /**
  * batadv_handle_tt_response() - process incoming tt reply
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tt_data: tt data containing the tt request information
  * @resp_src: mac address of tt reply sender
  * @num_entries: number of tt change entries appended to the tt data
@@ -3397,7 +3397,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 
 /**
  * batadv_tt_check_roam_count() - check if a client has roamed too frequently
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @client: mac address of the roaming client
  *
  * This function checks whether the client already reached the
@@ -3452,7 +3452,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 
 /**
  * batadv_send_roam_adv() - send a roaming advertisement message
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @client: mac address of the roaming client
  * @vid: VLAN identifier
  * @orig_node: message destination
@@ -3516,8 +3516,8 @@ static void batadv_tt_purge(struct work_struct *work)
 }
 
 /**
- * batadv_tt_free() - Free translation table of soft interface
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_tt_free() - Free translation table of mesh interface
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_tt_free(struct batadv_priv *bat_priv)
 {
@@ -3540,7 +3540,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 /**
  * batadv_tt_local_set_flags() - set or unset the specified flags on the local
  *  table and possibly count them in the TT size
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @flags: the flag to switch
  * @enable: whether to set or unset the flag
  * @count: whether to increase the TT size by the number of changed entries
@@ -3626,7 +3626,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 /**
  * batadv_tt_local_commit_changes_nolock() - commit all pending local tt changes
  *  which have been queued in the time since the last commit
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Caller must hold tt->commit_lock.
  */
@@ -3659,7 +3659,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 /**
  * batadv_tt_local_commit_changes() - commit all pending local tt changes which
  *  have been queued in the time since the last commit
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  */
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 {
@@ -3670,7 +3670,7 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 
 /**
  * batadv_is_ap_isolated() - Check if packet from upper layer should be dropped
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @src: source mac address of packet
  * @dst: destination mac address of packet
  * @vid: vlan id of packet
@@ -3682,10 +3682,10 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_global_entry *tt_global_entry;
-	struct batadv_softif_vlan *vlan;
+	struct batadv_meshif_vlan *vlan;
 	bool ret = false;
 
-	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
 	if (!vlan)
 		return false;
 
@@ -3707,14 +3707,14 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 local_entry_put:
 	batadv_tt_local_entry_put(tt_local_entry);
 vlan_put:
-	batadv_softif_vlan_put(vlan);
+	batadv_meshif_vlan_put(vlan);
 	return ret;
 }
 
 /**
  * batadv_tt_update_orig() - update global translation table with new tt
  *  information received via ogms
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: the orig_node of the ogm
  * @tt_buff: pointer to the first tvlv VLAN entry
  * @tt_num_vlan: number of tvlv VLAN entries
@@ -3798,7 +3798,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_global_client_is_roaming() - check if a client is marked as roaming
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client to check
  * @vid: VLAN identifier
  *
@@ -3824,7 +3824,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_local_client_is_roaming() - tells whether the client is roaming
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the local client to query
  * @vid: VLAN identifier
  *
@@ -3850,7 +3850,7 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_add_temporary_global_entry() - Add temporary entry to global TT
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig_node: orig node which the temporary entry should be associated with
  * @addr: mac address of the client
  * @vid: VLAN id of the new temporary global translation table
@@ -3883,14 +3883,14 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_resize_to_mtu() - resize the local translation table fit the
  *  maximum packet size that can be transported through the mesh
- * @soft_iface: netdev struct of the mesh interface
+ * @mesh_iface: netdev struct of the mesh interface
  *
  * Remove entries older than 'timeout' and half timeout if more entries need
  * to be removed.
  */
-void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
+void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	int packet_size_max = atomic_read(&bat_priv->packet_size_max);
 	int table_size, timeout = BATADV_TT_LOCAL_TIMEOUT / 2;
 	bool reduced = false;
@@ -3907,7 +3907,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 
 		timeout /= 2;
 		reduced = true;
-		net_ratelimited_function(batadv_info, soft_iface,
+		net_ratelimited_function(batadv_info, mesh_iface,
 					 "Forced to purge local tt entries to fit new maximum fragment MTU (%i)\n",
 					 packet_size_max);
 	}
@@ -3923,7 +3923,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 
 /**
  * batadv_tt_tvlv_ogm_handler_v1() - process incoming tt tvlv container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the gateway data
@@ -3962,7 +3962,7 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_tvlv_unicast_handler_v1() - process incoming (unicast) tt tvlv
  *  container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @src: mac address of tt tvlv sender
  * @dst: mac address of tt tvlv recipient
  * @tvlv_value: tvlv buffer containing the tt data
@@ -4044,7 +4044,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 /**
  * batadv_roam_tvlv_unicast_handler_v1() - process incoming tt roam tvlv
  *  container
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @src: mac address of tt tvlv sender
  * @dst: mac address of tt tvlv recipient
  * @tvlv_value: tvlv buffer containing the tt data
@@ -4093,7 +4093,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 /**
  * batadv_tt_init() - initialise the translation table internals
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Return: 0 on success or negative error number in case of failure.
  */
@@ -4131,7 +4131,7 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 
 /**
  * batadv_tt_global_is_isolated() - check if a client is marked as isolated
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the mac address of the client
  * @vid: the identifier of the VLAN where this client is connected
  *
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index d18740d9a22b..618d9dbca5ea 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -16,7 +16,7 @@
 #include <linux/types.h>
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
-bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
+bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 unsigned short vid, int ifindex, u32 mark);
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			   const u8 *addr, unsigned short vid,
@@ -45,7 +45,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					u8 *addr, unsigned short vid);
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 				       u8 *addr, unsigned short vid);
-void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface);
+void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface);
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr,
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 2a583215d439..76dff1f9c559 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -59,7 +59,7 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
 /**
  * batadv_tvlv_handler_get() - retrieve tvlv handler from the tvlv handler list
  *  based on the provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: tvlv handler type to look for
  * @version: tvlv handler version to look for
  *
@@ -118,7 +118,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
 /**
  * batadv_tvlv_container_get() - retrieve tvlv container from the tvlv container
  *  list based on the provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: tvlv container type to look for
  * @version: tvlv container version to look for
  *
@@ -152,7 +152,7 @@ batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 /**
  * batadv_tvlv_container_list_size() - calculate the size of the tvlv container
  *  list entries
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  *
  * Has to be called with the appropriate locks being acquired
  * (tvlv.container_list_lock).
@@ -177,7 +177,7 @@ static u16 batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 /**
  * batadv_tvlv_container_remove() - remove tvlv container from the tvlv
  *  container list
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tvlv: the to be removed tvlv container
  *
  * Has to be called with the appropriate locks being acquired
@@ -201,7 +201,7 @@ static void batadv_tvlv_container_remove(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_container_unregister() - unregister tvlv container based on the
  *  provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: tvlv container type to unregister
  * @version: tvlv container type to unregister
  */
@@ -219,7 +219,7 @@ void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_container_register() - register tvlv type, version and content
  *  to be propagated with each (primary interface) OGM
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: tvlv container type
  * @version: tvlv container version
  * @tvlv_value: tvlv container content
@@ -297,7 +297,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
 /**
  * batadv_tvlv_container_ogm_append() - append tvlv container content to given
  *  OGM packet buffer
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @packet_buff: ogm packet buffer
  * @packet_buff_len: ogm packet buffer size including ogm header and tvlv
  *  content
@@ -350,7 +350,7 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_call_handler() - parse the given tvlv buffer to call the
  *  appropriate handlers
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @tvlv_handler: tvlv callback function handling the tvlv content
  * @packet_type: indicates for which packet type the TVLV handler is called
  * @orig_node: orig node emitting the ogm packet
@@ -421,7 +421,7 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_containers_process() - parse the given tvlv buffer to call the
  *  appropriate handlers
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @packet_type: indicates for which packet type the TVLV handler is called
  * @orig_node: orig node emitting the ogm packet
  * @skb: the skb the TVLV handler is called for
@@ -490,7 +490,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_ogm_receive() - process an incoming ogm and call the appropriate
  *  handlers
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @batadv_ogm_packet: ogm packet containing the tvlv containers
  * @orig_node: orig node emitting the ogm packet
  */
@@ -518,7 +518,7 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
  * batadv_tvlv_handler_register() - register tvlv handler based on the provided
  *  type and version (both need to match) for ogm tvlv payload and/or unicast
  *  payload
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @optr: ogm tvlv handler callback function. This function receives the orig
  *  node, flags and the tvlv content as argument to process.
  * @uptr: unicast tvlv handler callback function. This function receives the
@@ -583,7 +583,7 @@ void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_handler_unregister() - unregister tvlv handler based on the
  *  provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @type: tvlv handler type to be unregistered
  * @version: tvlv handler version to be unregistered
  */
@@ -606,7 +606,7 @@ void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_unicast_send() - send a unicast packet with tvlv payload to the
  *  specified host
- * @bat_priv: the bat priv with all the soft interface information
+ * @bat_priv: the bat priv with all the mesh interface information
  * @src: source mac address of the unicast packet
  * @dst: destination mac address of the unicast packet
  * @type: tvlv type
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3b4f71f6dec..b222f8a80ed9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -199,13 +199,13 @@ struct batadv_hard_iface {
 	struct packet_type batman_adv_ptype;
 
 	/**
-	 * @soft_iface: the batman-adv interface which uses this network
+	 * @mesh_iface: the batman-adv interface which uses this network
 	 *  interface
 	 */
-	struct net_device *soft_iface;
+	struct net_device *mesh_iface;
 
-	/** @softif_dev_tracker: device tracker for @soft_iface */
-	netdevice_tracker softif_dev_tracker;
+	/** @meshif_dev_tracker: device tracker for @mesh_iface */
+	netdevice_tracker meshif_dev_tracker;
 
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
@@ -493,7 +493,7 @@ struct batadv_orig_node {
 	/** @hash_entry: hlist node for &batadv_priv.orig_hash */
 	struct hlist_node hash_entry;
 
-	/** @bat_priv: pointer to soft_iface this orig node belongs to */
+	/** @bat_priv: pointer to mesh_iface this orig node belongs to */
 	struct batadv_priv *bat_priv;
 
 	/** @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno */
@@ -905,13 +905,13 @@ enum batadv_counters {
 
 	/**
 	 * @BATADV_CNT_MCAST_RX_LOCAL: counter for received batman-adv multicast
-	 *  packets which were forwarded to the local soft interface
+	 *  packets which were forwarded to the local mesh interface
 	 */
 	BATADV_CNT_MCAST_RX_LOCAL,
 
 	/**
 	 * @BATADV_CNT_MCAST_RX_LOCAL_BYTES: bytes counter for received
-	 *  batman-adv multicast packets which were forwarded to the local soft
+	 *  batman-adv multicast packets which were forwarded to the local mesh
 	 *  interface
 	 */
 	BATADV_CNT_MCAST_RX_LOCAL_BYTES,
@@ -1247,7 +1247,7 @@ struct batadv_mcast_mla_flags {
 	/** @enabled: whether the multicast tvlv is currently enabled */
 	unsigned char enabled:1;
 
-	/** @bridged: whether the soft interface has a bridge on top */
+	/** @bridged: whether the mesh interface has a bridge on top */
 	unsigned char bridged:1;
 
 	/** @tvlv_flags: the flags we have last sent in our mcast tvlv */
@@ -1383,7 +1383,7 @@ struct batadv_priv_nc {
 	/**
 	 * @decoding_hash: Hash table used to buffer skbs that might be needed
 	 *  to decode a received coded skb. The buffer is used for 1) skbs
-	 *  arriving on the soft-interface; 2) skbs overheard on the
+	 *  arriving on the mesh-interface; 2) skbs overheard on the
 	 *  hard-interface; and 3) skbs forwarded by batman-adv.
 	 */
 	struct batadv_hashtable *decoding_hash;
@@ -1536,9 +1536,9 @@ struct batadv_tp_vars {
 };
 
 /**
- * struct batadv_softif_vlan - per VLAN attributes set
+ * struct batadv_meshif_vlan - per VLAN attributes set
  */
-struct batadv_softif_vlan {
+struct batadv_meshif_vlan {
 	/** @bat_priv: pointer to the mesh object */
 	struct batadv_priv *bat_priv;
 
@@ -1551,7 +1551,7 @@ struct batadv_softif_vlan {
 	/** @tt: TT private attributes (VLAN specific) */
 	struct batadv_vlan_tt tt;
 
-	/** @list: list node for &bat_priv.softif_vlan_list */
+	/** @list: list node for &bat_priv.meshif_vlan_list */
 	struct hlist_node list;
 
 	/**
@@ -1564,7 +1564,7 @@ struct batadv_softif_vlan {
 };
 
 /**
- * struct batadv_priv_bat_v - B.A.T.M.A.N. V per soft-interface private data
+ * struct batadv_priv_bat_v - B.A.T.M.A.N. V per mesh-interface private data
  */
 struct batadv_priv_bat_v {
 	/** @ogm_buff: buffer holding the OGM packet */
@@ -1593,8 +1593,8 @@ struct batadv_priv {
 	 */
 	atomic_t mesh_state;
 
-	/** @soft_iface: net device which holds this struct as private data */
-	struct net_device *soft_iface;
+	/** @mesh_iface: net device which holds this struct as private data */
+	struct net_device *mesh_iface;
 
 	/**
 	 * @mtu_set_by_user: MTU was set once by user
@@ -1743,13 +1743,13 @@ struct batadv_priv {
 	struct batadv_algo_ops *algo_ops;
 
 	/**
-	 * @softif_vlan_list: a list of softif_vlan structs, one per VLAN
+	 * @meshif_vlan_list: a list of meshif_vlan structs, one per VLAN
 	 *  created on top of the mesh interface represented by this object
 	 */
-	struct hlist_head softif_vlan_list;
+	struct hlist_head meshif_vlan_list;
 
-	/** @softif_vlan_list_lock: lock protecting softif_vlan_list */
-	spinlock_t softif_vlan_list_lock;
+	/** @meshif_vlan_list_lock: lock protecting meshif_vlan_list */
+	spinlock_t meshif_vlan_list_lock;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	/** @bla: bridge loop avoidance data */
@@ -1786,7 +1786,7 @@ struct batadv_priv {
 #endif /* CONFIG_BATMAN_ADV_NC */
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
-	/** @bat_v: B.A.T.M.A.N. V per soft-interface private data */
+	/** @bat_v: B.A.T.M.A.N. V per mesh-interface private data */
 	struct batadv_priv_bat_v bat_v;
 #endif
 };
@@ -1809,7 +1809,7 @@ struct batadv_bla_backbone_gw {
 	/** @hash_entry: hlist node for &batadv_priv_bla.backbone_hash */
 	struct hlist_node hash_entry;
 
-	/** @bat_priv: pointer to soft_iface this backbone gateway belongs to */
+	/** @bat_priv: pointer to mesh_iface this backbone gateway belongs to */
 	struct batadv_priv *bat_priv;
 
 	/** @lasttime: last time we heard of this backbone gw */
@@ -1914,8 +1914,8 @@ struct batadv_tt_local_entry {
 	/** @last_seen: timestamp used for purging stale tt local entries */
 	unsigned long last_seen;
 
-	/** @vlan: soft-interface vlan of the entry */
-	struct batadv_softif_vlan *vlan;
+	/** @vlan: mesh-interface vlan of the entry */
+	struct batadv_meshif_vlan *vlan;
 };
 
 /**
-- 
2.39.5


