Return-Path: <netdev+bounces-223514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65CB59647
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295623205C5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E530E84B;
	Tue, 16 Sep 2025 12:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EE1EDA2C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025959; cv=none; b=dwZrOKYCWAoYsIKapZQ5QEff67GG6GJ/GmS2fFlDUU8+gjLH9gYMW+VUEbic9wP5YPnPaSjfEOjInSRB6RDcp46W2n/++aixCWNKZTrA7nH1DLg/urrH5KkC/CBS0zY6zBOwixptwRMV+EyRaKvyLVXm7ivtcyz0ouaEwqjAfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025959; c=relaxed/simple;
	bh=6rPJFh6o5xVh+MW+CrUJE5/4pFWvNY2xYHXijthsW80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoDRl4jdXOB52Ntul9slseuDJLeLQ71szCP3aS79oMO4KckFt16aawS/82mBAatsK/HJv14WJ++YQibL2ZD6GTmzOPW8RAHl20jC5FSpSO8XNmQF4bC4+dGBCYKYxSNu4tpwaSpM+u+hUO4OOlhI0+iyXtuVj21A3PdRlceUDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5972536D8604e0a64d0d3aad8.dip0.t-ipconnect.de [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 111E3FA182;
	Tue, 16 Sep 2025 14:24:51 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/4] batman-adv: remove network coding support
Date: Tue, 16 Sep 2025 14:24:39 +0200
Message-ID: <20250916122441.89246-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The Network Coding feature, introduced in 2013, is based on the master
thesis "Inter-Flow Network Coding for Wireless Mesh Networks". It relies on
the assumption that neighboring mesh nodes can reliably overhear each
other's transmissions in promiscuous mode, allowing packets to be combined
to reduce forwarding overhead.

This assumption no longer holds for modern wireless mesh networks, which
are heterogeneous and make overhearing increasingly unreliable. Factors
such as multiple spatial streams, varying data rates, beamforming, and
OFDMA all prevent nodes from consistently overhearing each other. The current
implementation in batman-adv is not able to detect these conditions and would
require a more complex layer beyond its neighbor discovery process to do so.

In addition, the feature has been unmaintained for years and is discouraged
for use. None of the current maintainers have the required test
setup to verify its functionality, and known issues remain in its data
structures (reference counting, RCU usage, and cleanup handling). Its
continued presence also blocks necessary refactoring of the core originator
infrastructure.

Remove this obsolete and unmaintained feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Acked-by: Marek Lindner <marek.lindner@mailbox.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig             |   13 -
 net/batman-adv/Makefile            |    1 -
 net/batman-adv/bat_iv_ogm.c        |    5 -
 net/batman-adv/log.h               |    3 -
 net/batman-adv/main.c              |   16 -
 net/batman-adv/main.h              |    2 -
 net/batman-adv/mesh-interface.c    |   14 -
 net/batman-adv/netlink.c           |   17 -
 net/batman-adv/network-coding.c    | 1878 ----------------------------
 net/batman-adv/network-coding.h    |  106 --
 net/batman-adv/originator.c        |    6 -
 net/batman-adv/routing.c           |    9 +-
 net/batman-adv/send.c              |   16 +-
 net/batman-adv/translation-table.c |    4 +-
 net/batman-adv/types.h             |  216 ----
 15 files changed, 4 insertions(+), 2302 deletions(-)
 delete mode 100644 net/batman-adv/network-coding.c
 delete mode 100644 net/batman-adv/network-coding.h

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 20b316207f9aa..c299e2bc87eda 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -53,19 +53,6 @@ config BATMAN_ADV_DAT
 	  mesh networks. If you think that your network does not need
 	  this option you can safely remove it and save some space.
 
-config BATMAN_ADV_NC
-	bool "Network Coding"
-	depends on BATMAN_ADV
-	help
-	  This option enables network coding, a mechanism that aims to
-	  increase the overall network throughput by fusing multiple
-	  packets in one transmission.
-	  Note that interfaces controlled by batman-adv must be manually
-	  configured to have promiscuous mode enabled in order to make
-	  network coding work.
-	  If you think that your network does not need this feature you
-	  can safely disable it and save some space.
-
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
 	depends on BATMAN_ADV && INET && !(BRIDGE=m && BATMAN_ADV=y)
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 1cc9be6de4569..d3c4d4143c144 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -23,7 +23,6 @@ batman-adv-y += mesh-interface.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast_forw.o
 batman-adv-y += netlink.o
-batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 54fe38b3b2fd3..b75c2228e69a6 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -52,7 +52,6 @@
 #include "hash.h"
 #include "log.h"
 #include "netlink.h"
-#include "network-coding.h"
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
@@ -1406,10 +1405,6 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	if (!orig_neigh_node)
 		goto out;
 
-	/* Update nc_nodes of the originator */
-	batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_node,
-				 ogm_packet, is_single_hop_neigh);
-
 	orig_neigh_router = batadv_orig_router_get(orig_neigh_node,
 						   if_outgoing);
 
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 567afaa8df998..225b747a2048e 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -51,9 +51,6 @@ enum batadv_dbg_level {
 	/** @BATADV_DBG_DAT: ARP snooping and DAT related messages */
 	BATADV_DBG_DAT		= BIT(4),
 
-	/** @BATADV_DBG_NC: network coding related messages */
-	BATADV_DBG_NC		= BIT(5),
-
 	/** @BATADV_DBG_MCAST: multicast related messages */
 	BATADV_DBG_MCAST	= BIT(6),
 
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 20346d7b6b691..1dcacfc310ee9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -53,7 +53,6 @@
 #include "mesh-interface.h"
 #include "multicast.h"
 #include "netlink.h"
-#include "network-coding.h"
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
@@ -103,7 +102,6 @@ static int __init batadv_init(void)
 
 	batadv_v_init();
 	batadv_iv_init();
-	batadv_nc_init();
 	batadv_tp_meter_init();
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
@@ -218,12 +216,6 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 		goto err_dat;
 	}
 
-	ret = batadv_nc_mesh_init(bat_priv);
-	if (ret < 0) {
-		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
-		goto err_nc;
-	}
-
 	batadv_gw_init(bat_priv);
 	batadv_mcast_init(bat_priv);
 
@@ -232,8 +224,6 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 
 	return 0;
 
-err_nc:
-	batadv_dat_free(bat_priv);
 err_dat:
 	batadv_bla_free(bat_priv);
 err_bla:
@@ -264,7 +254,6 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	batadv_gw_node_free(bat_priv);
 
 	batadv_v_mesh_free(bat_priv);
-	batadv_nc_mesh_free(bat_priv);
 	batadv_dat_free(bat_priv);
 	batadv_bla_free(bat_priv);
 
@@ -336,11 +325,6 @@ int batadv_max_header_len(void)
 	header_len = max_t(int, header_len,
 			   sizeof(struct batadv_bcast_packet));
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	header_len = max_t(int, header_len,
-			   sizeof(struct batadv_coded_packet));
-#endif
-
 	return header_len + ETH_HLEN;
 }
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 0d3ec0f1c9fb2..7352b11df968c 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -121,8 +121,6 @@
 #define BATADV_RESET_PROTECTION_MS 30000
 #define BATADV_EXPECTED_SEQNO_RANGE	65536
 
-#define BATADV_NC_NODE_TIMEOUT 10000 /* Milliseconds */
-
 /**
  * BATADV_TP_MAX_NUM - maximum number of simultaneously active tp sessions
  */
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index de2c2d9c6e4db..be55d8d87348c 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -46,7 +46,6 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "multicast.h"
-#include "network-coding.h"
 #include "send.h"
 #include "translation-table.h"
 
@@ -802,8 +801,6 @@ static int batadv_meshif_init_late(struct net_device *dev)
 
 	bat_priv->primary_if = NULL;
 
-	batadv_nc_init_bat_priv(bat_priv);
-
 	if (!bat_priv->algo_ops) {
 		ret = batadv_algo_select(bat_priv, batadv_routing_algo);
 		if (ret < 0)
@@ -947,17 +944,6 @@ static const struct {
 	{ "dat_put_rx" },
 	{ "dat_cached_reply_tx" },
 #endif
-#ifdef CONFIG_BATMAN_ADV_NC
-	{ "nc_code" },
-	{ "nc_code_bytes" },
-	{ "nc_recode" },
-	{ "nc_recode_bytes" },
-	{ "nc_buffer" },
-	{ "nc_decode" },
-	{ "nc_decode_bytes" },
-	{ "nc_decode_failed" },
-	{ "nc_sniffed" },
-#endif
 };
 
 static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data)
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index beb181b3a7d88..78c651f634cd3 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -44,7 +44,6 @@
 #include "log.h"
 #include "mesh-interface.h"
 #include "multicast.h"
-#include "network-coding.h"
 #include "originator.h"
 #include "tp_meter.h"
 #include "translation-table.h"
@@ -144,7 +143,6 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_MULTICAST_FANOUT]		= { .type = NLA_U32 },
-	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
@@ -345,12 +343,6 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	if (nla_put_u8(msg, BATADV_ATTR_NETWORK_CODING_ENABLED,
-		       !!atomic_read(&bat_priv->network_coding)))
-		goto nla_put_failure;
-#endif /* CONFIG_BATMAN_ADV_NC */
-
 	if (nla_put_u32(msg, BATADV_ATTR_ORIG_INTERVAL,
 			atomic_read(&bat_priv->orig_interval)))
 		goto nla_put_failure;
@@ -588,15 +580,6 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	if (info->attrs[BATADV_ATTR_NETWORK_CODING_ENABLED]) {
-		attr = info->attrs[BATADV_ATTR_NETWORK_CODING_ENABLED];
-
-		atomic_set(&bat_priv->network_coding, !!nla_get_u8(attr));
-		batadv_nc_status_update(bat_priv->mesh_iface);
-	}
-#endif /* CONFIG_BATMAN_ADV_NC */
-
 	if (info->attrs[BATADV_ATTR_ORIG_INTERVAL]) {
 		u32 orig_interval;
 
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
deleted file mode 100644
index af97d077369f9..0000000000000
--- a/net/batman-adv/network-coding.c
+++ /dev/null
@@ -1,1878 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Martin Hundebøll, Jeppe Ledet-Pedersen
- */
-
-#include "network-coding.h"
-#include "main.h"
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/byteorder/generic.h>
-#include <linux/compiler.h>
-#include <linux/container_of.h>
-#include <linux/errno.h>
-#include <linux/etherdevice.h>
-#include <linux/gfp.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/init.h>
-#include <linux/jhash.h>
-#include <linux/jiffies.h>
-#include <linux/kref.h>
-#include <linux/list.h>
-#include <linux/lockdep.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/printk.h>
-#include <linux/random.h>
-#include <linux/rculist.h>
-#include <linux/rcupdate.h>
-#include <linux/skbuff.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/stddef.h>
-#include <linux/string.h>
-#include <linux/workqueue.h>
-#include <uapi/linux/batadv_packet.h>
-
-#include "hash.h"
-#include "log.h"
-#include "originator.h"
-#include "routing.h"
-#include "send.h"
-#include "tvlv.h"
-
-static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
-static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
-
-static void batadv_nc_worker(struct work_struct *work);
-static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
-				       struct batadv_hard_iface *recv_if);
-
-/**
- * batadv_nc_init() - one-time initialization for network coding
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int __init batadv_nc_init(void)
-{
-	/* Register our packet type */
-	return batadv_recv_handler_register(BATADV_CODED,
-					    batadv_nc_recv_coded_packet);
-}
-
-/**
- * batadv_nc_start_timer() - initialise the nc periodic worker
- * @bat_priv: the bat priv with all the mesh interface information
- */
-static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
-{
-	queue_delayed_work(batadv_event_workqueue, &bat_priv->nc.work,
-			   msecs_to_jiffies(10));
-}
-
-/**
- * batadv_nc_tvlv_container_update() - update the network coding tvlv container
- *  after network coding setting change
- * @bat_priv: the bat priv with all the mesh interface information
- */
-static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
-{
-	char nc_mode;
-
-	nc_mode = atomic_read(&bat_priv->network_coding);
-
-	switch (nc_mode) {
-	case 0:
-		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, 1);
-		break;
-	case 1:
-		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_NC, 1,
-					       NULL, 0);
-		break;
-	}
-}
-
-/**
- * batadv_nc_status_update() - update the network coding tvlv container after
- *  network coding setting change
- * @net_dev: the mesh interface net device
- */
-void batadv_nc_status_update(struct net_device *net_dev)
-{
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-
-	batadv_nc_tvlv_container_update(bat_priv);
-}
-
-/**
- * batadv_nc_tvlv_ogm_handler_v1() - process incoming nc tvlv container
- * @bat_priv: the bat priv with all the mesh interface information
- * @orig: the orig_node of the ogm
- * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
- * @tvlv_value: tvlv buffer containing the gateway data
- * @tvlv_value_len: tvlv buffer length
- */
-static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
-					  struct batadv_orig_node *orig,
-					  u8 flags,
-					  void *tvlv_value, u16 tvlv_value_len)
-{
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		clear_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
-	else
-		set_bit(BATADV_ORIG_CAPA_HAS_NC, &orig->capabilities);
-}
-
-/**
- * batadv_nc_mesh_init() - initialise coding hash table and start housekeeping
- * @bat_priv: the bat priv with all the mesh interface information
- *
- * Return: 0 on success or negative error number in case of failure
- */
-int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
-{
-	bat_priv->nc.timestamp_fwd_flush = jiffies;
-	bat_priv->nc.timestamp_sniffed_purge = jiffies;
-
-	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
-		return 0;
-
-	bat_priv->nc.coding_hash = batadv_hash_new(128);
-	if (!bat_priv->nc.coding_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
-				   &batadv_nc_coding_hash_lock_class_key);
-
-	bat_priv->nc.decoding_hash = batadv_hash_new(128);
-	if (!bat_priv->nc.decoding_hash) {
-		batadv_hash_destroy(bat_priv->nc.coding_hash);
-		goto err;
-	}
-
-	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
-				   &batadv_nc_decoding_hash_lock_class_key);
-
-	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
-	batadv_nc_start_timer(bat_priv);
-
-	batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
-				     NULL, NULL, BATADV_TVLV_NC, 1,
-				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
-	batadv_nc_tvlv_container_update(bat_priv);
-	return 0;
-
-err:
-	return -ENOMEM;
-}
-
-/**
- * batadv_nc_init_bat_priv() - initialise the nc specific bat_priv variables
- * @bat_priv: the bat priv with all the mesh interface information
- */
-void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
-{
-	atomic_set(&bat_priv->network_coding, 0);
-	bat_priv->nc.min_tq = 200;
-	bat_priv->nc.max_fwd_delay = 10;
-	bat_priv->nc.max_buffer_time = 200;
-}
-
-/**
- * batadv_nc_init_orig() - initialise the nc fields of an orig_node
- * @orig_node: the orig_node which is going to be initialised
- */
-void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
-{
-	INIT_LIST_HEAD(&orig_node->in_coding_list);
-	INIT_LIST_HEAD(&orig_node->out_coding_list);
-	spin_lock_init(&orig_node->in_coding_list_lock);
-	spin_lock_init(&orig_node->out_coding_list_lock);
-}
-
-/**
- * batadv_nc_node_release() - release nc_node from lists and queue for free
- *  after rcu grace period
- * @ref: kref pointer of the nc_node
- */
-static void batadv_nc_node_release(struct kref *ref)
-{
-	struct batadv_nc_node *nc_node;
-
-	nc_node = container_of(ref, struct batadv_nc_node, refcount);
-
-	batadv_orig_node_put(nc_node->orig_node);
-	kfree_rcu(nc_node, rcu);
-}
-
-/**
- * batadv_nc_node_put() - decrement the nc_node refcounter and possibly
- *  release it
- * @nc_node: nc_node to be free'd
- */
-static void batadv_nc_node_put(struct batadv_nc_node *nc_node)
-{
-	if (!nc_node)
-		return;
-
-	kref_put(&nc_node->refcount, batadv_nc_node_release);
-}
-
-/**
- * batadv_nc_path_release() - release nc_path from lists and queue for free
- *  after rcu grace period
- * @ref: kref pointer of the nc_path
- */
-static void batadv_nc_path_release(struct kref *ref)
-{
-	struct batadv_nc_path *nc_path;
-
-	nc_path = container_of(ref, struct batadv_nc_path, refcount);
-
-	kfree_rcu(nc_path, rcu);
-}
-
-/**
- * batadv_nc_path_put() - decrement the nc_path refcounter and possibly
- *  release it
- * @nc_path: nc_path to be free'd
- */
-static void batadv_nc_path_put(struct batadv_nc_path *nc_path)
-{
-	if (!nc_path)
-		return;
-
-	kref_put(&nc_path->refcount, batadv_nc_path_release);
-}
-
-/**
- * batadv_nc_packet_free() - frees nc packet
- * @nc_packet: the nc packet to free
- * @dropped: whether the packet is freed because is dropped
- */
-static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet,
-				  bool dropped)
-{
-	if (dropped)
-		kfree_skb(nc_packet->skb);
-	else
-		consume_skb(nc_packet->skb);
-
-	batadv_nc_path_put(nc_packet->nc_path);
-	kfree(nc_packet);
-}
-
-/**
- * batadv_nc_to_purge_nc_node() - checks whether an nc node has to be purged
- * @bat_priv: the bat priv with all the mesh interface information
- * @nc_node: the nc node to check
- *
- * Return: true if the entry has to be purged now, false otherwise
- */
-static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
-				       struct batadv_nc_node *nc_node)
-{
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
-		return true;
-
-	return batadv_has_timed_out(nc_node->last_seen, BATADV_NC_NODE_TIMEOUT);
-}
-
-/**
- * batadv_nc_to_purge_nc_path_coding() - checks whether an nc path has timed out
- * @bat_priv: the bat priv with all the mesh interface information
- * @nc_path: the nc path to check
- *
- * Return: true if the entry has to be purged now, false otherwise
- */
-static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
-					      struct batadv_nc_path *nc_path)
-{
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
-		return true;
-
-	/* purge the path when no packets has been added for 10 times the
-	 * max_fwd_delay time
-	 */
-	return batadv_has_timed_out(nc_path->last_valid,
-				    bat_priv->nc.max_fwd_delay * 10);
-}
-
-/**
- * batadv_nc_to_purge_nc_path_decoding() - checks whether an nc path has timed
- *  out
- * @bat_priv: the bat priv with all the mesh interface information
- * @nc_path: the nc path to check
- *
- * Return: true if the entry has to be purged now, false otherwise
- */
-static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
-						struct batadv_nc_path *nc_path)
-{
-	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
-		return true;
-
-	/* purge the path when no packets has been added for 10 times the
-	 * max_buffer time
-	 */
-	return batadv_has_timed_out(nc_path->last_valid,
-				    bat_priv->nc.max_buffer_time * 10);
-}
-
-/**
- * batadv_nc_purge_orig_nc_nodes() - go through list of nc nodes and purge stale
- *  entries
- * @bat_priv: the bat priv with all the mesh interface information
- * @list: list of nc nodes
- * @lock: nc node list lock
- * @to_purge: function in charge to decide whether an entry has to be purged or
- *	      not. This function takes the nc node as argument and has to return
- *	      a boolean value: true if the entry has to be deleted, false
- *	      otherwise
- */
-static void
-batadv_nc_purge_orig_nc_nodes(struct batadv_priv *bat_priv,
-			      struct list_head *list,
-			      spinlock_t *lock,
-			      bool (*to_purge)(struct batadv_priv *,
-					       struct batadv_nc_node *))
-{
-	struct batadv_nc_node *nc_node, *nc_node_tmp;
-
-	/* For each nc_node in list */
-	spin_lock_bh(lock);
-	list_for_each_entry_safe(nc_node, nc_node_tmp, list, list) {
-		/* if an helper function has been passed as parameter,
-		 * ask it if the entry has to be purged or not
-		 */
-		if (to_purge && !to_purge(bat_priv, nc_node))
-			continue;
-
-		batadv_dbg(BATADV_DBG_NC, bat_priv,
-			   "Removing nc_node %pM -> %pM\n",
-			   nc_node->addr, nc_node->orig_node->orig);
-		list_del_rcu(&nc_node->list);
-		batadv_nc_node_put(nc_node);
-	}
-	spin_unlock_bh(lock);
-}
-
-/**
- * batadv_nc_purge_orig() - purges all nc node data attached of the given
- *  originator
- * @bat_priv: the bat priv with all the mesh interface information
- * @orig_node: orig_node with the nc node entries to be purged
- * @to_purge: function in charge to decide whether an entry has to be purged or
- *	      not. This function takes the nc node as argument and has to return
- *	      a boolean value: true is the entry has to be deleted, false
- *	      otherwise
- */
-void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
-			  struct batadv_orig_node *orig_node,
-			  bool (*to_purge)(struct batadv_priv *,
-					   struct batadv_nc_node *))
-{
-	/* Check ingoing nc_node's of this orig_node */
-	batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->in_coding_list,
-				      &orig_node->in_coding_list_lock,
-				      to_purge);
-
-	/* Check outgoing nc_node's of this orig_node */
-	batadv_nc_purge_orig_nc_nodes(bat_priv, &orig_node->out_coding_list,
-				      &orig_node->out_coding_list_lock,
-				      to_purge);
-}
-
-/**
- * batadv_nc_purge_orig_hash() - traverse entire originator hash to check if
- *  they have timed out nc nodes
- * @bat_priv: the bat priv with all the mesh interface information
- */
-static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
-{
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_head *head;
-	struct batadv_orig_node *orig_node;
-	u32 i;
-
-	if (!hash)
-		return;
-
-	/* For each orig_node */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_node, head, hash_entry)
-			batadv_nc_purge_orig(bat_priv, orig_node,
-					     batadv_nc_to_purge_nc_node);
-		rcu_read_unlock();
-	}
-}
-
-/**
- * batadv_nc_purge_paths() - traverse all nc paths part of the hash and remove
- *  unused ones
- * @bat_priv: the bat priv with all the mesh interface information
- * @hash: hash table containing the nc paths to check
- * @to_purge: function in charge to decide whether an entry has to be purged or
- *	      not. This function takes the nc node as argument and has to return
- *	      a boolean value: true is the entry has to be deleted, false
- *	      otherwise
- */
-static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
-				  struct batadv_hashtable *hash,
-				  bool (*to_purge)(struct batadv_priv *,
-						   struct batadv_nc_path *))
-{
-	struct hlist_head *head;
-	struct hlist_node *node_tmp;
-	struct batadv_nc_path *nc_path;
-	spinlock_t *lock; /* Protects lists in hash */
-	u32 i;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		lock = &hash->list_locks[i];
-
-		/* For each nc_path in this bin */
-		spin_lock_bh(lock);
-		hlist_for_each_entry_safe(nc_path, node_tmp, head, hash_entry) {
-			/* if an helper function has been passed as parameter,
-			 * ask it if the entry has to be purged or not
-			 */
-			if (to_purge && !to_purge(bat_priv, nc_path))
-				continue;
-
-			/* purging an non-empty nc_path should never happen, but
-			 * is observed under high CPU load. Delay the purging
-			 * until next iteration to allow the packet_list to be
-			 * emptied first.
-			 */
-			if (!unlikely(list_empty(&nc_path->packet_list))) {
-				net_ratelimited_function(printk,
-							 KERN_WARNING
-							 "Skipping free of non-empty nc_path (%pM -> %pM)!\n",
-							 nc_path->prev_hop,
-							 nc_path->next_hop);
-				continue;
-			}
-
-			/* nc_path is unused, so remove it */
-			batadv_dbg(BATADV_DBG_NC, bat_priv,
-				   "Remove nc_path %pM -> %pM\n",
-				   nc_path->prev_hop, nc_path->next_hop);
-			hlist_del_rcu(&nc_path->hash_entry);
-			batadv_nc_path_put(nc_path);
-		}
-		spin_unlock_bh(lock);
-	}
-}
-
-/**
- * batadv_nc_hash_key_gen() - computes the nc_path hash key
- * @key: buffer to hold the final hash key
- * @src: source ethernet mac address going into the hash key
- * @dst: destination ethernet mac address going into the hash key
- */
-static void batadv_nc_hash_key_gen(struct batadv_nc_path *key, const char *src,
-				   const char *dst)
-{
-	memcpy(key->prev_hop, src, sizeof(key->prev_hop));
-	memcpy(key->next_hop, dst, sizeof(key->next_hop));
-}
-
-/**
- * batadv_nc_hash_choose() - compute the hash value for an nc path
- * @data: data to hash
- * @size: size of the hash table
- *
- * Return: the selected index in the hash table for the given data.
- */
-static u32 batadv_nc_hash_choose(const void *data, u32 size)
-{
-	const struct batadv_nc_path *nc_path = data;
-	u32 hash = 0;
-
-	hash = jhash(&nc_path->prev_hop, sizeof(nc_path->prev_hop), hash);
-	hash = jhash(&nc_path->next_hop, sizeof(nc_path->next_hop), hash);
-
-	return hash % size;
-}
-
-/**
- * batadv_nc_hash_compare() - comparing function used in the network coding hash
- *  tables
- * @node: node in the local table
- * @data2: second object to compare the node to
- *
- * Return: true if the two entry are the same, false otherwise
- */
-static bool batadv_nc_hash_compare(const struct hlist_node *node,
-				   const void *data2)
-{
-	const struct batadv_nc_path *nc_path1, *nc_path2;
-
-	nc_path1 = container_of(node, struct batadv_nc_path, hash_entry);
-	nc_path2 = data2;
-
-	/* Return 1 if the two keys are identical */
-	if (!batadv_compare_eth(nc_path1->prev_hop, nc_path2->prev_hop))
-		return false;
-
-	if (!batadv_compare_eth(nc_path1->next_hop, nc_path2->next_hop))
-		return false;
-
-	return true;
-}
-
-/**
- * batadv_nc_hash_find() - search for an existing nc path and return it
- * @hash: hash table containing the nc path
- * @data: search key
- *
- * Return: the nc_path if found, NULL otherwise.
- */
-static struct batadv_nc_path *
-batadv_nc_hash_find(struct batadv_hashtable *hash,
-		    void *data)
-{
-	struct hlist_head *head;
-	struct batadv_nc_path *nc_path, *nc_path_tmp = NULL;
-	int index;
-
-	if (!hash)
-		return NULL;
-
-	index = batadv_nc_hash_choose(data, hash->size);
-	head = &hash->table[index];
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
-		if (!batadv_nc_hash_compare(&nc_path->hash_entry, data))
-			continue;
-
-		if (!kref_get_unless_zero(&nc_path->refcount))
-			continue;
-
-		nc_path_tmp = nc_path;
-		break;
-	}
-	rcu_read_unlock();
-
-	return nc_path_tmp;
-}
-
-/**
- * batadv_nc_send_packet() - send non-coded packet and free nc_packet struct
- * @nc_packet: the nc packet to send
- */
-static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
-{
-	batadv_send_unicast_skb(nc_packet->skb, nc_packet->neigh_node);
-	nc_packet->skb = NULL;
-	batadv_nc_packet_free(nc_packet, false);
-}
-
-/**
- * batadv_nc_sniffed_purge() - Checks timestamp of given sniffed nc_packet.
- * @bat_priv: the bat priv with all the mesh interface information
- * @nc_path: the nc path the packet belongs to
- * @nc_packet: the nc packet to be checked
- *
- * Checks whether the given sniffed (overheard) nc_packet has hit its buffering
- * timeout. If so, the packet is no longer kept and the entry deleted from the
- * queue. Has to be called with the appropriate locks.
- *
- * Return: false as soon as the entry in the fifo queue has not been timed out
- * yet and true otherwise.
- */
-static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
-				    struct batadv_nc_path *nc_path,
-				    struct batadv_nc_packet *nc_packet)
-{
-	unsigned long timeout = bat_priv->nc.max_buffer_time;
-	bool res = false;
-
-	lockdep_assert_held(&nc_path->packet_list_lock);
-
-	/* Packets are added to tail, so the remaining packets did not time
-	 * out and we can stop processing the current queue
-	 */
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE &&
-	    !batadv_has_timed_out(nc_packet->timestamp, timeout))
-		goto out;
-
-	/* purge nc packet */
-	list_del(&nc_packet->list);
-	batadv_nc_packet_free(nc_packet, true);
-
-	res = true;
-
-out:
-	return res;
-}
-
-/**
- * batadv_nc_fwd_flush() - Checks the timestamp of the given nc packet.
- * @bat_priv: the bat priv with all the mesh interface information
- * @nc_path: the nc path the packet belongs to
- * @nc_packet: the nc packet to be checked
- *
- * Checks whether the given nc packet has hit its forward timeout. If so, the
- * packet is no longer delayed, immediately sent and the entry deleted from the
- * queue. Has to be called with the appropriate locks.
- *
- * Return: false as soon as the entry in the fifo queue has not been timed out
- * yet and true otherwise.
- */
-static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
-				struct batadv_nc_path *nc_path,
-				struct batadv_nc_packet *nc_packet)
-{
-	unsigned long timeout = bat_priv->nc.max_fwd_delay;
-
-	lockdep_assert_held(&nc_path->packet_list_lock);
-
-	/* Packets are added to tail, so the remaining packets did not time
-	 * out and we can stop processing the current queue
-	 */
-	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE &&
-	    !batadv_has_timed_out(nc_packet->timestamp, timeout))
-		return false;
-
-	/* Send packet */
-	batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
-	batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
-			   nc_packet->skb->len + ETH_HLEN);
-	list_del(&nc_packet->list);
-	batadv_nc_send_packet(nc_packet);
-
-	return true;
-}
-
-/**
- * batadv_nc_process_nc_paths() - traverse given nc packet pool and free timed
- *  out nc packets
- * @bat_priv: the bat priv with all the mesh interface information
- * @hash: to be processed hash table
- * @process_fn: Function called to process given nc packet. Should return true
- *	        to encourage this function to proceed with the next packet.
- *	        Otherwise the rest of the current queue is skipped.
- */
-static void
-batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
-			   struct batadv_hashtable *hash,
-			   bool (*process_fn)(struct batadv_priv *,
-					      struct batadv_nc_path *,
-					      struct batadv_nc_packet *))
-{
-	struct hlist_head *head;
-	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
-	struct batadv_nc_path *nc_path;
-	bool ret;
-	int i;
-
-	if (!hash)
-		return;
-
-	/* Loop hash table bins */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		/* Loop coding paths */
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
-			/* Loop packets */
-			spin_lock_bh(&nc_path->packet_list_lock);
-			list_for_each_entry_safe(nc_packet, nc_packet_tmp,
-						 &nc_path->packet_list, list) {
-				ret = process_fn(bat_priv, nc_path, nc_packet);
-				if (!ret)
-					break;
-			}
-			spin_unlock_bh(&nc_path->packet_list_lock);
-		}
-		rcu_read_unlock();
-	}
-}
-
-/**
- * batadv_nc_worker() - periodic task for housekeeping related to network
- *  coding
- * @work: kernel work struct
- */
-static void batadv_nc_worker(struct work_struct *work)
-{
-	struct delayed_work *delayed_work;
-	struct batadv_priv_nc *priv_nc;
-	struct batadv_priv *bat_priv;
-	unsigned long timeout;
-
-	delayed_work = to_delayed_work(work);
-	priv_nc = container_of(delayed_work, struct batadv_priv_nc, work);
-	bat_priv = container_of(priv_nc, struct batadv_priv, nc);
-
-	batadv_nc_purge_orig_hash(bat_priv);
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
-			      batadv_nc_to_purge_nc_path_coding);
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
-			      batadv_nc_to_purge_nc_path_decoding);
-
-	timeout = bat_priv->nc.max_fwd_delay;
-
-	if (batadv_has_timed_out(bat_priv->nc.timestamp_fwd_flush, timeout)) {
-		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.coding_hash,
-					   batadv_nc_fwd_flush);
-		bat_priv->nc.timestamp_fwd_flush = jiffies;
-	}
-
-	if (batadv_has_timed_out(bat_priv->nc.timestamp_sniffed_purge,
-				 bat_priv->nc.max_buffer_time)) {
-		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.decoding_hash,
-					   batadv_nc_sniffed_purge);
-		bat_priv->nc.timestamp_sniffed_purge = jiffies;
-	}
-
-	/* Schedule a new check */
-	batadv_nc_start_timer(bat_priv);
-}
-
-/**
- * batadv_can_nc_with_orig() - checks whether the given orig node is suitable
- *  for coding or not
- * @bat_priv: the bat priv with all the mesh interface information
- * @orig_node: neighboring orig node which may be used as nc candidate
- * @ogm_packet: incoming ogm packet also used for the checks
- *
- * Return: true if:
- *  1) The OGM must have the most recent sequence number.
- *  2) The TTL must be decremented by one and only one.
- *  3) The OGM must be received from the first hop from orig_node.
- *  4) The TQ value of the OGM must be above bat_priv->nc.min_tq.
- */
-static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
-				    struct batadv_orig_node *orig_node,
-				    struct batadv_ogm_packet *ogm_packet)
-{
-	struct batadv_orig_ifinfo *orig_ifinfo;
-	u32 last_real_seqno;
-	u8 last_ttl;
-
-	orig_ifinfo = batadv_orig_ifinfo_get(orig_node, BATADV_IF_DEFAULT);
-	if (!orig_ifinfo)
-		return false;
-
-	last_ttl = orig_ifinfo->last_ttl;
-	last_real_seqno = orig_ifinfo->last_real_seqno;
-	batadv_orig_ifinfo_put(orig_ifinfo);
-
-	if (last_real_seqno != ntohl(ogm_packet->seqno))
-		return false;
-	if (last_ttl != ogm_packet->ttl + 1)
-		return false;
-	if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_sender))
-		return false;
-	if (ogm_packet->tq < bat_priv->nc.min_tq)
-		return false;
-
-	return true;
-}
-
-/**
- * batadv_nc_find_nc_node() - search for an existing nc node and return it
- * @orig_node: orig node originating the ogm packet
- * @orig_neigh_node: neighboring orig node from which we received the ogm packet
- *  (can be equal to orig_node)
- * @in_coding: traverse incoming or outgoing network coding list
- *
- * Return: the nc_node if found, NULL otherwise.
- */
-static struct batadv_nc_node *
-batadv_nc_find_nc_node(struct batadv_orig_node *orig_node,
-		       struct batadv_orig_node *orig_neigh_node,
-		       bool in_coding)
-{
-	struct batadv_nc_node *nc_node, *nc_node_out = NULL;
-	struct list_head *list;
-
-	if (in_coding)
-		list = &orig_neigh_node->in_coding_list;
-	else
-		list = &orig_neigh_node->out_coding_list;
-
-	/* Traverse list of nc_nodes to orig_node */
-	rcu_read_lock();
-	list_for_each_entry_rcu(nc_node, list, list) {
-		if (!batadv_compare_eth(nc_node->addr, orig_node->orig))
-			continue;
-
-		if (!kref_get_unless_zero(&nc_node->refcount))
-			continue;
-
-		/* Found a match */
-		nc_node_out = nc_node;
-		break;
-	}
-	rcu_read_unlock();
-
-	return nc_node_out;
-}
-
-/**
- * batadv_nc_get_nc_node() - retrieves an nc node or creates the entry if it was
- *  not found
- * @bat_priv: the bat priv with all the mesh interface information
- * @orig_node: orig node originating the ogm packet
- * @orig_neigh_node: neighboring orig node from which we received the ogm packet
- *  (can be equal to orig_node)
- * @in_coding: traverse incoming or outgoing network coding list
- *
- * Return: the nc_node if found or created, NULL in case of an error.
- */
-static struct batadv_nc_node *
-batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
-		      struct batadv_orig_node *orig_node,
-		      struct batadv_orig_node *orig_neigh_node,
-		      bool in_coding)
-{
-	struct batadv_nc_node *nc_node;
-	spinlock_t *lock; /* Used to lock list selected by "int in_coding" */
-	struct list_head *list;
-
-	/* Select ingoing or outgoing coding node */
-	if (in_coding) {
-		lock = &orig_neigh_node->in_coding_list_lock;
-		list = &orig_neigh_node->in_coding_list;
-	} else {
-		lock = &orig_neigh_node->out_coding_list_lock;
-		list = &orig_neigh_node->out_coding_list;
-	}
-
-	spin_lock_bh(lock);
-
-	/* Check if nc_node is already added */
-	nc_node = batadv_nc_find_nc_node(orig_node, orig_neigh_node, in_coding);
-
-	/* Node found */
-	if (nc_node)
-		goto unlock;
-
-	nc_node = kzalloc(sizeof(*nc_node), GFP_ATOMIC);
-	if (!nc_node)
-		goto unlock;
-
-	/* Initialize nc_node */
-	INIT_LIST_HEAD(&nc_node->list);
-	kref_init(&nc_node->refcount);
-	ether_addr_copy(nc_node->addr, orig_node->orig);
-	kref_get(&orig_neigh_node->refcount);
-	nc_node->orig_node = orig_neigh_node;
-
-	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_node %pM -> %pM\n",
-		   nc_node->addr, nc_node->orig_node->orig);
-
-	/* Add nc_node to orig_node */
-	kref_get(&nc_node->refcount);
-	list_add_tail_rcu(&nc_node->list, list);
-
-unlock:
-	spin_unlock_bh(lock);
-
-	return nc_node;
-}
-
-/**
- * batadv_nc_update_nc_node() - updates stored incoming and outgoing nc node
- *  structs (best called on incoming OGMs)
- * @bat_priv: the bat priv with all the mesh interface information
- * @orig_node: orig node originating the ogm packet
- * @orig_neigh_node: neighboring orig node from which we received the ogm packet
- *  (can be equal to orig_node)
- * @ogm_packet: incoming ogm packet
- * @is_single_hop_neigh: orig_node is a single hop neighbor
- */
-void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
-			      struct batadv_orig_node *orig_node,
-			      struct batadv_orig_node *orig_neigh_node,
-			      struct batadv_ogm_packet *ogm_packet,
-			      int is_single_hop_neigh)
-{
-	struct batadv_nc_node *in_nc_node = NULL;
-	struct batadv_nc_node *out_nc_node = NULL;
-
-	/* Check if network coding is enabled */
-	if (!atomic_read(&bat_priv->network_coding))
-		goto out;
-
-	/* check if orig node is network coding enabled */
-	if (!test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabilities))
-		goto out;
-
-	/* accept ogms from 'good' neighbors and single hop neighbors */
-	if (!batadv_can_nc_with_orig(bat_priv, orig_node, ogm_packet) &&
-	    !is_single_hop_neigh)
-		goto out;
-
-	/* Add orig_node as in_nc_node on hop */
-	in_nc_node = batadv_nc_get_nc_node(bat_priv, orig_node,
-					   orig_neigh_node, true);
-	if (!in_nc_node)
-		goto out;
-
-	in_nc_node->last_seen = jiffies;
-
-	/* Add hop as out_nc_node on orig_node */
-	out_nc_node = batadv_nc_get_nc_node(bat_priv, orig_neigh_node,
-					    orig_node, false);
-	if (!out_nc_node)
-		goto out;
-
-	out_nc_node->last_seen = jiffies;
-
-out:
-	batadv_nc_node_put(in_nc_node);
-	batadv_nc_node_put(out_nc_node);
-}
-
-/**
- * batadv_nc_get_path() - get existing nc_path or allocate a new one
- * @bat_priv: the bat priv with all the mesh interface information
- * @hash: hash table containing the nc path
- * @src: ethernet source address - first half of the nc path search key
- * @dst: ethernet destination address - second half of the nc path search key
- *
- * Return: pointer to nc_path if the path was found or created, returns NULL
- * on error.
- */
-static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
-						 struct batadv_hashtable *hash,
-						 u8 *src,
-						 u8 *dst)
-{
-	int hash_added;
-	struct batadv_nc_path *nc_path, nc_path_key;
-
-	batadv_nc_hash_key_gen(&nc_path_key, src, dst);
-
-	/* Search for existing nc_path */
-	nc_path = batadv_nc_hash_find(hash, (void *)&nc_path_key);
-
-	if (nc_path) {
-		/* Set timestamp to delay removal of nc_path */
-		nc_path->last_valid = jiffies;
-		return nc_path;
-	}
-
-	/* No existing nc_path was found; create a new */
-	nc_path = kzalloc(sizeof(*nc_path), GFP_ATOMIC);
-
-	if (!nc_path)
-		return NULL;
-
-	/* Initialize nc_path */
-	INIT_LIST_HEAD(&nc_path->packet_list);
-	spin_lock_init(&nc_path->packet_list_lock);
-	kref_init(&nc_path->refcount);
-	nc_path->last_valid = jiffies;
-	ether_addr_copy(nc_path->next_hop, dst);
-	ether_addr_copy(nc_path->prev_hop, src);
-
-	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_path %pM -> %pM\n",
-		   nc_path->prev_hop,
-		   nc_path->next_hop);
-
-	/* Add nc_path to hash table */
-	kref_get(&nc_path->refcount);
-	hash_added = batadv_hash_add(hash, batadv_nc_hash_compare,
-				     batadv_nc_hash_choose, &nc_path_key,
-				     &nc_path->hash_entry);
-
-	if (hash_added < 0) {
-		kfree(nc_path);
-		return NULL;
-	}
-
-	return nc_path;
-}
-
-/**
- * batadv_nc_random_weight_tq() - scale the receivers TQ-value to avoid unfair
- *  selection of a receiver with slightly lower TQ than the other
- * @tq: to be weighted tq value
- *
- * Return: scaled tq value
- */
-static u8 batadv_nc_random_weight_tq(u8 tq)
-{
-	/* randomize the estimated packet loss (max TQ - estimated TQ) */
-	u8 rand_tq = get_random_u32_below(BATADV_TQ_MAX_VALUE + 1 - tq);
-
-	/* convert to (randomized) estimated tq again */
-	return BATADV_TQ_MAX_VALUE - rand_tq;
-}
-
-/**
- * batadv_nc_memxor() - XOR destination with source
- * @dst: byte array to XOR into
- * @src: byte array to XOR from
- * @len: length of destination array
- */
-static void batadv_nc_memxor(char *dst, const char *src, unsigned int len)
-{
-	unsigned int i;
-
-	for (i = 0; i < len; ++i)
-		dst[i] ^= src[i];
-}
-
-/**
- * batadv_nc_code_packets() - code a received unicast_packet with an nc packet
- *  into a coded_packet and send it
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: data skb to forward
- * @ethhdr: pointer to the ethernet header inside the skb
- * @nc_packet: structure containing the packet to the skb can be coded with
- * @neigh_node: next hop to forward packet to
- *
- * Return: true if both packets are consumed, false otherwise.
- */
-static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
-				   struct sk_buff *skb,
-				   struct ethhdr *ethhdr,
-				   struct batadv_nc_packet *nc_packet,
-				   struct batadv_neigh_node *neigh_node)
-{
-	u8 tq_weighted_neigh, tq_weighted_coding, tq_tmp;
-	struct sk_buff *skb_dest, *skb_src;
-	struct batadv_unicast_packet *packet1;
-	struct batadv_unicast_packet *packet2;
-	struct batadv_coded_packet *coded_packet;
-	struct batadv_neigh_node *neigh_tmp, *router_neigh, *first_dest;
-	struct batadv_neigh_node *router_coding = NULL, *second_dest;
-	struct batadv_neigh_ifinfo *router_neigh_ifinfo = NULL;
-	struct batadv_neigh_ifinfo *router_coding_ifinfo = NULL;
-	u8 *first_source, *second_source;
-	__be32 packet_id1, packet_id2;
-	size_t count;
-	bool res = false;
-	int coding_len;
-	int unicast_size = sizeof(*packet1);
-	int coded_size = sizeof(*coded_packet);
-	int header_add = coded_size - unicast_size;
-
-	/* TODO: do we need to consider the outgoing interface for
-	 * coded packets?
-	 */
-	router_neigh = batadv_orig_router_get(neigh_node->orig_node,
-					      BATADV_IF_DEFAULT);
-	if (!router_neigh)
-		goto out;
-
-	router_neigh_ifinfo = batadv_neigh_ifinfo_get(router_neigh,
-						      BATADV_IF_DEFAULT);
-	if (!router_neigh_ifinfo)
-		goto out;
-
-	neigh_tmp = nc_packet->neigh_node;
-	router_coding = batadv_orig_router_get(neigh_tmp->orig_node,
-					       BATADV_IF_DEFAULT);
-	if (!router_coding)
-		goto out;
-
-	router_coding_ifinfo = batadv_neigh_ifinfo_get(router_coding,
-						       BATADV_IF_DEFAULT);
-	if (!router_coding_ifinfo)
-		goto out;
-
-	tq_tmp = router_neigh_ifinfo->bat_iv.tq_avg;
-	tq_weighted_neigh = batadv_nc_random_weight_tq(tq_tmp);
-	tq_tmp = router_coding_ifinfo->bat_iv.tq_avg;
-	tq_weighted_coding = batadv_nc_random_weight_tq(tq_tmp);
-
-	/* Select one destination for the MAC-header dst-field based on
-	 * weighted TQ-values.
-	 */
-	if (tq_weighted_neigh >= tq_weighted_coding) {
-		/* Destination from nc_packet is selected for MAC-header */
-		first_dest = nc_packet->neigh_node;
-		first_source = nc_packet->nc_path->prev_hop;
-		second_dest = neigh_node;
-		second_source = ethhdr->h_source;
-		packet1 = (struct batadv_unicast_packet *)nc_packet->skb->data;
-		packet2 = (struct batadv_unicast_packet *)skb->data;
-		packet_id1 = nc_packet->packet_id;
-		packet_id2 = batadv_skb_crc32(skb,
-					      skb->data + sizeof(*packet2));
-	} else {
-		/* Destination for skb is selected for MAC-header */
-		first_dest = neigh_node;
-		first_source = ethhdr->h_source;
-		second_dest = nc_packet->neigh_node;
-		second_source = nc_packet->nc_path->prev_hop;
-		packet1 = (struct batadv_unicast_packet *)skb->data;
-		packet2 = (struct batadv_unicast_packet *)nc_packet->skb->data;
-		packet_id1 = batadv_skb_crc32(skb,
-					      skb->data + sizeof(*packet1));
-		packet_id2 = nc_packet->packet_id;
-	}
-
-	/* Instead of zero padding the smallest data buffer, we
-	 * code into the largest.
-	 */
-	if (skb->len <= nc_packet->skb->len) {
-		skb_dest = nc_packet->skb;
-		skb_src = skb;
-	} else {
-		skb_dest = skb;
-		skb_src = nc_packet->skb;
-	}
-
-	/* coding_len is used when decoding the packet shorter packet */
-	coding_len = skb_src->len - unicast_size;
-
-	if (skb_linearize(skb_dest) < 0 || skb_linearize(skb_src) < 0)
-		goto out;
-
-	skb_push(skb_dest, header_add);
-
-	coded_packet = (struct batadv_coded_packet *)skb_dest->data;
-	skb_reset_mac_header(skb_dest);
-
-	coded_packet->packet_type = BATADV_CODED;
-	coded_packet->version = BATADV_COMPAT_VERSION;
-	coded_packet->ttl = packet1->ttl;
-
-	/* Info about first unicast packet */
-	ether_addr_copy(coded_packet->first_source, first_source);
-	ether_addr_copy(coded_packet->first_orig_dest, packet1->dest);
-	coded_packet->first_crc = packet_id1;
-	coded_packet->first_ttvn = packet1->ttvn;
-
-	/* Info about second unicast packet */
-	ether_addr_copy(coded_packet->second_dest, second_dest->addr);
-	ether_addr_copy(coded_packet->second_source, second_source);
-	ether_addr_copy(coded_packet->second_orig_dest, packet2->dest);
-	coded_packet->second_crc = packet_id2;
-	coded_packet->second_ttl = packet2->ttl;
-	coded_packet->second_ttvn = packet2->ttvn;
-	coded_packet->coded_len = htons(coding_len);
-
-	/* This is where the magic happens: Code skb_src into skb_dest */
-	batadv_nc_memxor(skb_dest->data + coded_size,
-			 skb_src->data + unicast_size, coding_len);
-
-	/* Update counters accordingly */
-	if (BATADV_SKB_CB(skb_src)->decoded &&
-	    BATADV_SKB_CB(skb_dest)->decoded) {
-		/* Both packets are recoded */
-		count = skb_src->len + ETH_HLEN;
-		count += skb_dest->len + ETH_HLEN;
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE, 2);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES, count);
-	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
-		   !BATADV_SKB_CB(skb_dest)->decoded) {
-		/* Both packets are newly coded */
-		count = skb_src->len + ETH_HLEN;
-		count += skb_dest->len + ETH_HLEN;
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE, 2);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES, count);
-	} else if (BATADV_SKB_CB(skb_src)->decoded &&
-		   !BATADV_SKB_CB(skb_dest)->decoded) {
-		/* skb_src recoded and skb_dest is newly coded */
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
-				   skb_src->len + ETH_HLEN);
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
-				   skb_dest->len + ETH_HLEN);
-	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
-		   BATADV_SKB_CB(skb_dest)->decoded) {
-		/* skb_src is newly coded and skb_dest is recoded */
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
-				   skb_src->len + ETH_HLEN);
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
-		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
-				   skb_dest->len + ETH_HLEN);
-	}
-
-	/* skb_src is now coded into skb_dest, so free it */
-	consume_skb(skb_src);
-
-	/* avoid duplicate free of skb from nc_packet */
-	nc_packet->skb = NULL;
-	batadv_nc_packet_free(nc_packet, false);
-
-	/* Send the coded packet and return true */
-	batadv_send_unicast_skb(skb_dest, first_dest);
-	res = true;
-out:
-	batadv_neigh_node_put(router_neigh);
-	batadv_neigh_node_put(router_coding);
-	batadv_neigh_ifinfo_put(router_neigh_ifinfo);
-	batadv_neigh_ifinfo_put(router_coding_ifinfo);
-	return res;
-}
-
-/**
- * batadv_nc_skb_coding_possible() - true if a decoded skb is available at dst.
- * @skb: data skb to forward
- * @dst: destination mac address of the other skb to code with
- * @src: source mac address of skb
- *
- * Whenever we network code a packet we have to check whether we received it in
- * a network coded form. If so, we may not be able to use it for coding because
- * some neighbors may also have received (overheard) the packet in the network
- * coded form without being able to decode it. It is hard to know which of the
- * neighboring nodes was able to decode the packet, therefore we can only
- * re-code the packet if the source of the previous encoded packet is involved.
- * Since the source encoded the packet we can be certain it has all necessary
- * decode information.
- *
- * Return: true if coding of a decoded packet is allowed.
- */
-static bool batadv_nc_skb_coding_possible(struct sk_buff *skb, u8 *dst, u8 *src)
-{
-	if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst, src))
-		return false;
-	return true;
-}
-
-/**
- * batadv_nc_path_search() - Find the coding path matching in_nc_node and
- *  out_nc_node to retrieve a buffered packet that can be used for coding.
- * @bat_priv: the bat priv with all the mesh interface information
- * @in_nc_node: pointer to skb next hop's neighbor nc node
- * @out_nc_node: pointer to skb source's neighbor nc node
- * @skb: data skb to forward
- * @eth_dst: next hop mac address of skb
- *
- * Return: true if coding of a decoded skb is allowed.
- */
-static struct batadv_nc_packet *
-batadv_nc_path_search(struct batadv_priv *bat_priv,
-		      struct batadv_nc_node *in_nc_node,
-		      struct batadv_nc_node *out_nc_node,
-		      struct sk_buff *skb,
-		      u8 *eth_dst)
-{
-	struct batadv_nc_path *nc_path, nc_path_key;
-	struct batadv_nc_packet *nc_packet_out = NULL;
-	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
-	struct batadv_hashtable *hash = bat_priv->nc.coding_hash;
-	int idx;
-
-	if (!hash)
-		return NULL;
-
-	/* Create almost path key */
-	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
-			       out_nc_node->addr);
-	idx = batadv_nc_hash_choose(&nc_path_key, hash->size);
-
-	/* Check for coding opportunities in this nc_path */
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[idx], hash_entry) {
-		if (!batadv_compare_eth(nc_path->prev_hop, in_nc_node->addr))
-			continue;
-
-		if (!batadv_compare_eth(nc_path->next_hop, out_nc_node->addr))
-			continue;
-
-		spin_lock_bh(&nc_path->packet_list_lock);
-		if (list_empty(&nc_path->packet_list)) {
-			spin_unlock_bh(&nc_path->packet_list_lock);
-			continue;
-		}
-
-		list_for_each_entry_safe(nc_packet, nc_packet_tmp,
-					 &nc_path->packet_list, list) {
-			if (!batadv_nc_skb_coding_possible(nc_packet->skb,
-							   eth_dst,
-							   in_nc_node->addr))
-				continue;
-
-			/* Coding opportunity is found! */
-			list_del(&nc_packet->list);
-			nc_packet_out = nc_packet;
-			break;
-		}
-
-		spin_unlock_bh(&nc_path->packet_list_lock);
-		break;
-	}
-	rcu_read_unlock();
-
-	return nc_packet_out;
-}
-
-/**
- * batadv_nc_skb_src_search() - Loops through the list of neighboring nodes of
- *  the skb's sender (may be equal to the originator).
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: data skb to forward
- * @eth_dst: next hop mac address of skb
- * @eth_src: source mac address of skb
- * @in_nc_node: pointer to skb next hop's neighbor nc node
- *
- * Return: an nc packet if a suitable coding packet was found, NULL otherwise.
- */
-static struct batadv_nc_packet *
-batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
-			 struct sk_buff *skb,
-			 u8 *eth_dst,
-			 u8 *eth_src,
-			 struct batadv_nc_node *in_nc_node)
-{
-	struct batadv_orig_node *orig_node;
-	struct batadv_nc_node *out_nc_node;
-	struct batadv_nc_packet *nc_packet = NULL;
-
-	orig_node = batadv_orig_hash_find(bat_priv, eth_src);
-	if (!orig_node)
-		return NULL;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(out_nc_node,
-				&orig_node->out_coding_list, list) {
-		/* Check if the skb is decoded and if recoding is possible */
-		if (!batadv_nc_skb_coding_possible(skb,
-						   out_nc_node->addr, eth_src))
-			continue;
-
-		/* Search for an opportunity in this nc_path */
-		nc_packet = batadv_nc_path_search(bat_priv, in_nc_node,
-						  out_nc_node, skb, eth_dst);
-		if (nc_packet)
-			break;
-	}
-	rcu_read_unlock();
-
-	batadv_orig_node_put(orig_node);
-	return nc_packet;
-}
-
-/**
- * batadv_nc_skb_store_before_coding() - set the ethernet src and dst of the
- *  unicast skb before it is stored for use in later decoding
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: data skb to store
- * @eth_dst_new: new destination mac address of skb
- */
-static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
-					      struct sk_buff *skb,
-					      u8 *eth_dst_new)
-{
-	struct ethhdr *ethhdr;
-
-	/* Copy skb header to change the mac header */
-	skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	/* Set the mac header as if we actually sent the packet uncoded */
-	ethhdr = eth_hdr(skb);
-	ether_addr_copy(ethhdr->h_source, ethhdr->h_dest);
-	ether_addr_copy(ethhdr->h_dest, eth_dst_new);
-
-	/* Set data pointer to MAC header to mimic packets from our tx path */
-	skb_push(skb, ETH_HLEN);
-
-	/* Add the packet to the decoding packet pool */
-	batadv_nc_skb_store_for_decoding(bat_priv, skb);
-
-	/* batadv_nc_skb_store_for_decoding() clones the skb, so we must free
-	 * our ref
-	 */
-	consume_skb(skb);
-}
-
-/**
- * batadv_nc_skb_dst_search() - Loops through list of neighboring nodes to dst.
- * @skb: data skb to forward
- * @neigh_node: next hop to forward packet to
- * @ethhdr: pointer to the ethernet header inside the skb
- *
- * Loops through the list of neighboring nodes the next hop has a good
- * connection to (receives OGMs with a sufficient quality). We need to find a
- * neighbor of our next hop that potentially sent a packet which our next hop
- * also received (overheard) and has stored for later decoding.
- *
- * Return: true if the skb was consumed (encoded packet sent) or false otherwise
- */
-static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
-				     struct batadv_neigh_node *neigh_node,
-				     struct ethhdr *ethhdr)
-{
-	struct net_device *netdev = neigh_node->if_incoming->mesh_iface;
-	struct batadv_priv *bat_priv = netdev_priv(netdev);
-	struct batadv_orig_node *orig_node = neigh_node->orig_node;
-	struct batadv_nc_node *nc_node;
-	struct batadv_nc_packet *nc_packet = NULL;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(nc_node, &orig_node->in_coding_list, list) {
-		/* Search for coding opportunity with this in_nc_node */
-		nc_packet = batadv_nc_skb_src_search(bat_priv, skb,
-						     neigh_node->addr,
-						     ethhdr->h_source, nc_node);
-
-		/* Opportunity was found, so stop searching */
-		if (nc_packet)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (!nc_packet)
-		return false;
-
-	/* Save packets for later decoding */
-	batadv_nc_skb_store_before_coding(bat_priv, skb,
-					  neigh_node->addr);
-	batadv_nc_skb_store_before_coding(bat_priv, nc_packet->skb,
-					  nc_packet->neigh_node->addr);
-
-	/* Code and send packets */
-	if (batadv_nc_code_packets(bat_priv, skb, ethhdr, nc_packet,
-				   neigh_node))
-		return true;
-
-	/* out of mem ? Coding failed - we have to free the buffered packet
-	 * to avoid memleaks. The skb passed as argument will be dealt with
-	 * by the calling function.
-	 */
-	batadv_nc_send_packet(nc_packet);
-	return false;
-}
-
-/**
- * batadv_nc_skb_add_to_path() - buffer skb for later encoding / decoding
- * @skb: skb to add to path
- * @nc_path: path to add skb to
- * @neigh_node: next hop to forward packet to
- * @packet_id: checksum to identify packet
- *
- * Return: true if the packet was buffered or false in case of an error.
- */
-static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
-				      struct batadv_nc_path *nc_path,
-				      struct batadv_neigh_node *neigh_node,
-				      __be32 packet_id)
-{
-	struct batadv_nc_packet *nc_packet;
-
-	nc_packet = kzalloc(sizeof(*nc_packet), GFP_ATOMIC);
-	if (!nc_packet)
-		return false;
-
-	/* Initialize nc_packet */
-	nc_packet->timestamp = jiffies;
-	nc_packet->packet_id = packet_id;
-	nc_packet->skb = skb;
-	nc_packet->neigh_node = neigh_node;
-	nc_packet->nc_path = nc_path;
-
-	/* Add coding packet to list */
-	spin_lock_bh(&nc_path->packet_list_lock);
-	list_add_tail(&nc_packet->list, &nc_path->packet_list);
-	spin_unlock_bh(&nc_path->packet_list_lock);
-
-	return true;
-}
-
-/**
- * batadv_nc_skb_forward() - try to code a packet or add it to the coding packet
- *  buffer
- * @skb: data skb to forward
- * @neigh_node: next hop to forward packet to
- *
- * Return: true if the skb was consumed (encoded packet sent) or false otherwise
- */
-bool batadv_nc_skb_forward(struct sk_buff *skb,
-			   struct batadv_neigh_node *neigh_node)
-{
-	const struct net_device *netdev = neigh_node->if_incoming->mesh_iface;
-	struct batadv_priv *bat_priv = netdev_priv(netdev);
-	struct batadv_unicast_packet *packet;
-	struct batadv_nc_path *nc_path;
-	struct ethhdr *ethhdr = eth_hdr(skb);
-	__be32 packet_id;
-	u8 *payload;
-
-	/* Check if network coding is enabled */
-	if (!atomic_read(&bat_priv->network_coding))
-		goto out;
-
-	/* We only handle unicast packets */
-	payload = skb_network_header(skb);
-	packet = (struct batadv_unicast_packet *)payload;
-	if (packet->packet_type != BATADV_UNICAST)
-		goto out;
-
-	/* Try to find a coding opportunity and send the skb if one is found */
-	if (batadv_nc_skb_dst_search(skb, neigh_node, ethhdr))
-		return true;
-
-	/* Find or create a nc_path for this src-dst pair */
-	nc_path = batadv_nc_get_path(bat_priv,
-				     bat_priv->nc.coding_hash,
-				     ethhdr->h_source,
-				     neigh_node->addr);
-
-	if (!nc_path)
-		goto out;
-
-	/* Add skb to nc_path */
-	packet_id = batadv_skb_crc32(skb, payload + sizeof(*packet));
-	if (!batadv_nc_skb_add_to_path(skb, nc_path, neigh_node, packet_id))
-		goto free_nc_path;
-
-	/* Packet is consumed */
-	return true;
-
-free_nc_path:
-	batadv_nc_path_put(nc_path);
-out:
-	/* Packet is not consumed */
-	return false;
-}
-
-/**
- * batadv_nc_skb_store_for_decoding() - save a clone of the skb which can be
- *  used when decoding coded packets
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: data skb to store
- */
-void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
-				      struct sk_buff *skb)
-{
-	struct batadv_unicast_packet *packet;
-	struct batadv_nc_path *nc_path;
-	struct ethhdr *ethhdr = eth_hdr(skb);
-	__be32 packet_id;
-	u8 *payload;
-
-	/* Check if network coding is enabled */
-	if (!atomic_read(&bat_priv->network_coding))
-		goto out;
-
-	/* Check for supported packet type */
-	payload = skb_network_header(skb);
-	packet = (struct batadv_unicast_packet *)payload;
-	if (packet->packet_type != BATADV_UNICAST)
-		goto out;
-
-	/* Find existing nc_path or create a new */
-	nc_path = batadv_nc_get_path(bat_priv,
-				     bat_priv->nc.decoding_hash,
-				     ethhdr->h_source,
-				     ethhdr->h_dest);
-
-	if (!nc_path)
-		goto out;
-
-	/* Clone skb and adjust skb->data to point at batman header */
-	skb = skb_clone(skb, GFP_ATOMIC);
-	if (unlikely(!skb))
-		goto free_nc_path;
-
-	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
-		goto free_skb;
-
-	if (unlikely(!skb_pull_rcsum(skb, ETH_HLEN)))
-		goto free_skb;
-
-	/* Add skb to nc_path */
-	packet_id = batadv_skb_crc32(skb, payload + sizeof(*packet));
-	if (!batadv_nc_skb_add_to_path(skb, nc_path, NULL, packet_id))
-		goto free_skb;
-
-	batadv_inc_counter(bat_priv, BATADV_CNT_NC_BUFFER);
-	return;
-
-free_skb:
-	kfree_skb(skb);
-free_nc_path:
-	batadv_nc_path_put(nc_path);
-out:
-	return;
-}
-
-/**
- * batadv_nc_skb_store_sniffed_unicast() - check if a received unicast packet
- *  should be saved in the decoding buffer and, if so, store it there
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: unicast skb to store
- */
-void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb)
-{
-	struct ethhdr *ethhdr = eth_hdr(skb);
-
-	if (batadv_is_my_mac(bat_priv, ethhdr->h_dest))
-		return;
-
-	/* Set data pointer to MAC header to mimic packets from our tx path */
-	skb_push(skb, ETH_HLEN);
-
-	batadv_nc_skb_store_for_decoding(bat_priv, skb);
-}
-
-/**
- * batadv_nc_skb_decode_packet() - decode given skb using the decode data stored
- *  in nc_packet
- * @bat_priv: the bat priv with all the mesh interface information
- * @skb: unicast skb to decode
- * @nc_packet: decode data needed to decode the skb
- *
- * Return: pointer to decoded unicast packet if the packet was decoded or NULL
- * in case of an error.
- */
-static struct batadv_unicast_packet *
-batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
-			    struct batadv_nc_packet *nc_packet)
-{
-	const int h_size = sizeof(struct batadv_unicast_packet);
-	const int h_diff = sizeof(struct batadv_coded_packet) - h_size;
-	struct batadv_unicast_packet *unicast_packet;
-	struct batadv_coded_packet coded_packet_tmp;
-	struct ethhdr *ethhdr, ethhdr_tmp;
-	u8 *orig_dest, ttl, ttvn;
-	unsigned int coding_len;
-	int err;
-
-	/* Save headers temporarily */
-	memcpy(&coded_packet_tmp, skb->data, sizeof(coded_packet_tmp));
-	memcpy(&ethhdr_tmp, skb_mac_header(skb), sizeof(ethhdr_tmp));
-
-	if (skb_cow(skb, 0) < 0)
-		return NULL;
-
-	if (unlikely(!skb_pull_rcsum(skb, h_diff)))
-		return NULL;
-
-	/* Data points to batman header, so set mac header 14 bytes before
-	 * and network to data
-	 */
-	skb_set_mac_header(skb, -ETH_HLEN);
-	skb_reset_network_header(skb);
-
-	/* Reconstruct original mac header */
-	ethhdr = eth_hdr(skb);
-	*ethhdr = ethhdr_tmp;
-
-	/* Select the correct unicast header information based on the location
-	 * of our mac address in the coded_packet header
-	 */
-	if (batadv_is_my_mac(bat_priv, coded_packet_tmp.second_dest)) {
-		/* If we are the second destination the packet was overheard,
-		 * so the Ethernet address must be copied to h_dest and
-		 * pkt_type changed from PACKET_OTHERHOST to PACKET_HOST
-		 */
-		ether_addr_copy(ethhdr->h_dest, coded_packet_tmp.second_dest);
-		skb->pkt_type = PACKET_HOST;
-
-		orig_dest = coded_packet_tmp.second_orig_dest;
-		ttl = coded_packet_tmp.second_ttl;
-		ttvn = coded_packet_tmp.second_ttvn;
-	} else {
-		orig_dest = coded_packet_tmp.first_orig_dest;
-		ttl = coded_packet_tmp.ttl;
-		ttvn = coded_packet_tmp.first_ttvn;
-	}
-
-	coding_len = ntohs(coded_packet_tmp.coded_len);
-
-	/* ensure dst buffer is large enough (payload only) */
-	if (coding_len + h_size > skb->len)
-		return NULL;
-
-	/* ensure src buffer is large enough (payload only) */
-	if (coding_len + h_size > nc_packet->skb->len)
-		return NULL;
-
-	/* Here the magic is reversed:
-	 *   extract the missing packet from the received coded packet
-	 */
-	batadv_nc_memxor(skb->data + h_size,
-			 nc_packet->skb->data + h_size,
-			 coding_len);
-
-	/* Resize decoded skb if decoded with larger packet */
-	if (nc_packet->skb->len > coding_len + h_size) {
-		err = pskb_trim_rcsum(skb, coding_len + h_size);
-		if (err)
-			return NULL;
-	}
-
-	/* Create decoded unicast packet */
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	unicast_packet->packet_type = BATADV_UNICAST;
-	unicast_packet->version = BATADV_COMPAT_VERSION;
-	unicast_packet->ttl = ttl;
-	ether_addr_copy(unicast_packet->dest, orig_dest);
-	unicast_packet->ttvn = ttvn;
-
-	batadv_nc_packet_free(nc_packet, false);
-	return unicast_packet;
-}
-
-/**
- * batadv_nc_find_decoding_packet() - search through buffered decoding data to
- *  find the data needed to decode the coded packet
- * @bat_priv: the bat priv with all the mesh interface information
- * @ethhdr: pointer to the ethernet header inside the coded packet
- * @coded: coded packet we try to find decode data for
- *
- * Return: pointer to nc packet if the needed data was found or NULL otherwise.
- */
-static struct batadv_nc_packet *
-batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
-			       struct ethhdr *ethhdr,
-			       struct batadv_coded_packet *coded)
-{
-	struct batadv_hashtable *hash = bat_priv->nc.decoding_hash;
-	struct batadv_nc_packet *tmp_nc_packet, *nc_packet = NULL;
-	struct batadv_nc_path *nc_path, nc_path_key;
-	u8 *dest, *source;
-	__be32 packet_id;
-	int index;
-
-	if (!hash)
-		return NULL;
-
-	/* Select the correct packet id based on the location of our mac-addr */
-	dest = ethhdr->h_source;
-	if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
-		source = coded->second_source;
-		packet_id = coded->second_crc;
-	} else {
-		source = coded->first_source;
-		packet_id = coded->first_crc;
-	}
-
-	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
-	index = batadv_nc_hash_choose(&nc_path_key, hash->size);
-
-	/* Search for matching coding path */
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[index], hash_entry) {
-		/* Find matching nc_packet */
-		spin_lock_bh(&nc_path->packet_list_lock);
-		list_for_each_entry(tmp_nc_packet,
-				    &nc_path->packet_list, list) {
-			if (packet_id == tmp_nc_packet->packet_id) {
-				list_del(&tmp_nc_packet->list);
-
-				nc_packet = tmp_nc_packet;
-				break;
-			}
-		}
-		spin_unlock_bh(&nc_path->packet_list_lock);
-
-		if (nc_packet)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (!nc_packet)
-		batadv_dbg(BATADV_DBG_NC, bat_priv,
-			   "No decoding packet found for %u\n", packet_id);
-
-	return nc_packet;
-}
-
-/**
- * batadv_nc_recv_coded_packet() - try to decode coded packet and enqueue the
- *  resulting unicast packet
- * @skb: incoming coded packet
- * @recv_if: pointer to interface this packet was received on
- *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
- */
-static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
-				       struct batadv_hard_iface *recv_if)
-{
-	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_unicast_packet *unicast_packet;
-	struct batadv_coded_packet *coded_packet;
-	struct batadv_nc_packet *nc_packet;
-	struct ethhdr *ethhdr;
-	int hdr_size = sizeof(*coded_packet);
-
-	/* Check if network coding is enabled */
-	if (!atomic_read(&bat_priv->network_coding))
-		goto free_skb;
-
-	/* Make sure we can access (and remove) header */
-	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		goto free_skb;
-
-	coded_packet = (struct batadv_coded_packet *)skb->data;
-	ethhdr = eth_hdr(skb);
-
-	/* Verify frame is destined for us */
-	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest) &&
-	    !batadv_is_my_mac(bat_priv, coded_packet->second_dest))
-		goto free_skb;
-
-	/* Update stat counter */
-	if (batadv_is_my_mac(bat_priv, coded_packet->second_dest))
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_SNIFFED);
-
-	nc_packet = batadv_nc_find_decoding_packet(bat_priv, ethhdr,
-						   coded_packet);
-	if (!nc_packet) {
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE_FAILED);
-		goto free_skb;
-	}
-
-	/* Make skb's linear, because decoding accesses the entire buffer */
-	if (skb_linearize(skb) < 0)
-		goto free_nc_packet;
-
-	if (skb_linearize(nc_packet->skb) < 0)
-		goto free_nc_packet;
-
-	/* Decode the packet */
-	unicast_packet = batadv_nc_skb_decode_packet(bat_priv, skb, nc_packet);
-	if (!unicast_packet) {
-		batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE_FAILED);
-		goto free_nc_packet;
-	}
-
-	/* Mark packet as decoded to do correct recoding when forwarding */
-	BATADV_SKB_CB(skb)->decoded = true;
-	batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE);
-	batadv_add_counter(bat_priv, BATADV_CNT_NC_DECODE_BYTES,
-			   skb->len + ETH_HLEN);
-	return batadv_recv_unicast_packet(skb, recv_if);
-
-free_nc_packet:
-	batadv_nc_packet_free(nc_packet, true);
-free_skb:
-	kfree_skb(skb);
-
-	return NET_RX_DROP;
-}
-
-/**
- * batadv_nc_mesh_free() - clean up network coding memory
- * @bat_priv: the bat priv with all the mesh interface information
- */
-void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
-{
-	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, 1);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1);
-	cancel_delayed_work_sync(&bat_priv->nc.work);
-
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
-	batadv_hash_destroy(bat_priv->nc.coding_hash);
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash, NULL);
-	batadv_hash_destroy(bat_priv->nc.decoding_hash);
-}
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
deleted file mode 100644
index 368cc3130e4c9..0000000000000
--- a/net/batman-adv/network-coding.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) B.A.T.M.A.N. contributors:
- *
- * Martin Hundebøll, Jeppe Ledet-Pedersen
- */
-
-#ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
-#define _NET_BATMAN_ADV_NETWORK_CODING_H_
-
-#include "main.h"
-
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/types.h>
-#include <uapi/linux/batadv_packet.h>
-
-#ifdef CONFIG_BATMAN_ADV_NC
-
-void batadv_nc_status_update(struct net_device *net_dev);
-int batadv_nc_init(void);
-int batadv_nc_mesh_init(struct batadv_priv *bat_priv);
-void batadv_nc_mesh_free(struct batadv_priv *bat_priv);
-void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
-			      struct batadv_orig_node *orig_node,
-			      struct batadv_orig_node *orig_neigh_node,
-			      struct batadv_ogm_packet *ogm_packet,
-			      int is_single_hop_neigh);
-void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
-			  struct batadv_orig_node *orig_node,
-			  bool (*to_purge)(struct batadv_priv *,
-					   struct batadv_nc_node *));
-void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
-void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
-bool batadv_nc_skb_forward(struct sk_buff *skb,
-			   struct batadv_neigh_node *neigh_node);
-void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
-				      struct sk_buff *skb);
-void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb);
-
-#else /* ifdef CONFIG_BATMAN_ADV_NC */
-
-static inline void batadv_nc_status_update(struct net_device *net_dev)
-{
-}
-
-static inline int batadv_nc_init(void)
-{
-	return 0;
-}
-
-static inline int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
-{
-	return 0;
-}
-
-static inline void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
-{
-}
-
-static inline void
-batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
-			 struct batadv_orig_node *orig_node,
-			 struct batadv_orig_node *orig_neigh_node,
-			 struct batadv_ogm_packet *ogm_packet,
-			 int is_single_hop_neigh)
-{
-}
-
-static inline void
-batadv_nc_purge_orig(struct batadv_priv *bat_priv,
-		     struct batadv_orig_node *orig_node,
-		     bool (*to_purge)(struct batadv_priv *,
-				      struct batadv_nc_node *))
-{
-}
-
-static inline void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
-{
-}
-
-static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
-{
-}
-
-static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
-					 struct batadv_neigh_node *neigh_node)
-{
-	return false;
-}
-
-static inline void
-batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb)
-{
-}
-
-static inline void
-batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb)
-{
-}
-
-#endif /* ifdef CONFIG_BATMAN_ADV_NC */
-
-#endif /* _NET_BATMAN_ADV_NETWORK_CODING_H_ */
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a464ff96b9291..c84420cb410d5 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -37,7 +37,6 @@
 #include "log.h"
 #include "multicast.h"
 #include "netlink.h"
-#include "network-coding.h"
 #include "routing.h"
 #include "translation-table.h"
 
@@ -883,9 +882,6 @@ void batadv_orig_node_release(struct kref *ref)
 	}
 	spin_unlock_bh(&orig_node->vlan_list_lock);
 
-	/* Free nc_nodes */
-	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
-
 	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
@@ -959,8 +955,6 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	spin_lock_init(&orig_node->tt_lock);
 	spin_lock_init(&orig_node->vlan_list_lock);
 
-	batadv_nc_init_orig(orig_node);
-
 	/* extra reference for return */
 	kref_init(&orig_node->refcount);
 
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 35d8c57839998..12c16f81cc51d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -31,7 +31,6 @@
 #include "hard-interface.h"
 #include "log.h"
 #include "mesh-interface.h"
-#include "network-coding.h"
 #include "originator.h"
 #include "send.h"
 #include "tp_meter.h"
@@ -956,15 +955,9 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 	/* function returns -EREMOTE for promiscuous packets */
 	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
-
-	/* Even though the packet is not for us, we might save it to use for
-	 * decoding a later received coded packet
-	 */
-	if (check == -EREMOTE)
-		batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);
-
 	if (check < 0)
 		goto free_skb;
+
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		goto free_skb;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 95849ba004e75..20d85c681064a 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -34,7 +34,6 @@
 #include "hard-interface.h"
 #include "log.h"
 #include "mesh-interface.h"
-#include "network-coding.h"
 #include "originator.h"
 #include "routing.h"
 #include "translation-table.h"
@@ -63,12 +62,9 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *hard_iface,
 			   const u8 *dst_addr)
 {
-	struct batadv_priv *bat_priv;
 	struct ethhdr *ethhdr;
 	int ret;
 
-	bat_priv = netdev_priv(hard_iface->mesh_iface);
-
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		goto send_skb_err;
 
@@ -97,9 +93,6 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 
 	skb->dev = hard_iface->net_dev;
 
-	/* Save a clone of the skb to use when decoding coded packets */
-	batadv_nc_skb_store_for_decoding(bat_priv, skb);
-
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
@@ -202,14 +195,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 		goto put_neigh_node;
 	}
 
-	/* try to network code the packet, if it is received on an interface
-	 * (i.e. being forwarded). If the packet originates from this node or if
-	 * network coding fails, then send the packet as usual.
-	 */
-	if (recv_if && batadv_nc_skb_forward(skb, neigh_node))
-		ret = -EINPROGRESS;
-	else
-		ret = batadv_send_unicast_skb(skb, neigh_node);
+	ret = batadv_send_unicast_skb(skb, neigh_node);
 
 	/* skb was consumed */
 	skb = NULL;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8d0e04e770cb6..6e95e883c2bf0 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -212,7 +212,7 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
- * @ref: kref pointer of the nc_node
+ * @ref: kref pointer of the batadv_tt_local_entry
  */
 static void batadv_tt_local_entry_release(struct kref *ref)
 {
@@ -244,7 +244,7 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 /**
  * batadv_tt_global_entry_release() - release tt_global_entry from lists and
  *  queue for free after rcu grace period
- * @ref: kref pointer of the nc_node
+ * @ref: kref pointer of the batadv_tt_global_entry
  */
 void batadv_tt_global_entry_release(struct kref *ref)
 {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0ca0fc072fc9c..ae1d7a8dc480f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -505,20 +505,6 @@ struct batadv_orig_node {
 	/** @rcu: struct used for freeing in an RCU-safe manner */
 	struct rcu_head rcu;
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	/** @in_coding_list: list of nodes this orig can hear */
-	struct list_head in_coding_list;
-
-	/** @out_coding_list: list of nodes that can hear this orig */
-	struct list_head out_coding_list;
-
-	/** @in_coding_list_lock: protects in_coding_list */
-	spinlock_t in_coding_list_lock;
-
-	/** @out_coding_list_lock: protects out_coding_list */
-	spinlock_t out_coding_list_lock;
-#endif
-
 	/** @fragments: array with heads for fragment chains */
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
 
@@ -545,9 +531,6 @@ enum batadv_orig_capabilities {
 	 */
 	BATADV_ORIG_CAPA_HAS_DAT,
 
-	/** @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled */
-	BATADV_ORIG_CAPA_HAS_NC,
-
 	/** @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability */
 	BATADV_ORIG_CAPA_HAS_TT,
 
@@ -953,60 +936,6 @@ enum batadv_counters {
 	BATADV_CNT_DAT_CACHED_REPLY_TX,
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	/**
-	 * @BATADV_CNT_NC_CODE: transmitted nc-combined traffic packet counter
-	 */
-	BATADV_CNT_NC_CODE,
-
-	/**
-	 * @BATADV_CNT_NC_CODE_BYTES: transmitted nc-combined traffic bytes
-	 *  counter
-	 */
-	BATADV_CNT_NC_CODE_BYTES,
-
-	/**
-	 * @BATADV_CNT_NC_RECODE: transmitted nc-recombined traffic packet
-	 *  counter
-	 */
-	BATADV_CNT_NC_RECODE,
-
-	/**
-	 * @BATADV_CNT_NC_RECODE_BYTES: transmitted nc-recombined traffic bytes
-	 *  counter
-	 */
-	BATADV_CNT_NC_RECODE_BYTES,
-
-	/**
-	 * @BATADV_CNT_NC_BUFFER: counter for packets buffered for later nc
-	 *  decoding
-	 */
-	BATADV_CNT_NC_BUFFER,
-
-	/**
-	 * @BATADV_CNT_NC_DECODE: received and nc-decoded traffic packet counter
-	 */
-	BATADV_CNT_NC_DECODE,
-
-	/**
-	 * @BATADV_CNT_NC_DECODE_BYTES: received and nc-decoded traffic bytes
-	 *  counter
-	 */
-	BATADV_CNT_NC_DECODE_BYTES,
-
-	/**
-	 * @BATADV_CNT_NC_DECODE_FAILED: received and decode-failed traffic
-	 *  packet counter
-	 */
-	BATADV_CNT_NC_DECODE_FAILED,
-
-	/**
-	 * @BATADV_CNT_NC_SNIFFED: counter for nc-decoded packets received in
-	 *  promisc mode.
-	 */
-	BATADV_CNT_NC_SNIFFED,
-#endif
-
 	/** @BATADV_CNT_NUM: number of traffic counters */
 	BATADV_CNT_NUM,
 };
@@ -1339,56 +1268,6 @@ struct batadv_priv_mcast {
 };
 #endif
 
-/**
- * struct batadv_priv_nc - per mesh interface network coding private data
- */
-struct batadv_priv_nc {
-	/** @work: work queue callback item for cleanup */
-	struct delayed_work work;
-
-	/**
-	 * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
-	 */
-	u8 min_tq;
-
-	/**
-	 * @max_fwd_delay: maximum packet forward delay to allow coding of
-	 *  packets
-	 */
-	u32 max_fwd_delay;
-
-	/**
-	 * @max_buffer_time: buffer time for sniffed packets used to decoding
-	 */
-	u32 max_buffer_time;
-
-	/**
-	 * @timestamp_fwd_flush: timestamp of last forward packet queue flush
-	 */
-	unsigned long timestamp_fwd_flush;
-
-	/**
-	 * @timestamp_sniffed_purge: timestamp of last sniffed packet queue
-	 *  purge
-	 */
-	unsigned long timestamp_sniffed_purge;
-
-	/**
-	 * @coding_hash: Hash table used to buffer skbs while waiting for
-	 *  another incoming skb to code it with. Skbs are added to the buffer
-	 *  just before being forwarded in routing.c
-	 */
-	struct batadv_hashtable *coding_hash;
-
-	/**
-	 * @decoding_hash: Hash table used to buffer skbs that might be needed
-	 *  to decode a received coded skb. The buffer is used for 1) skbs
-	 *  arriving on the mesh-interface; 2) skbs overheard on the
-	 *  hard-interface; and 3) skbs forwarded by batman-adv.
-	 */
-	struct batadv_hashtable *decoding_hash;
-};
-
 /**
  * struct batadv_tp_unacked - unacked packet meta-information
  *
@@ -1775,16 +1654,6 @@ struct batadv_priv {
 	struct batadv_priv_mcast mcast;
 #endif
 
-#ifdef CONFIG_BATMAN_ADV_NC
-	/**
-	 * @network_coding: bool indicating whether network coding is enabled
-	 */
-	atomic_t network_coding;
-
-	/** @nc: network coding data */
-	struct batadv_priv_nc nc;
-#endif /* CONFIG_BATMAN_ADV_NC */
-
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	/** @bat_v: B.A.T.M.A.N. V per mesh-interface private data */
 	struct batadv_priv_bat_v bat_v;
@@ -2016,96 +1885,11 @@ struct batadv_tt_roam_node {
 	struct list_head list;
 };
 
-/**
- * struct batadv_nc_node - network coding node
- */
-struct batadv_nc_node {
-	/** @list: next and prev pointer for the list handling */
-	struct list_head list;
-
-	/** @addr: the node's mac address */
-	u8 addr[ETH_ALEN];
-
-	/** @refcount: number of contexts the object is used by */
-	struct kref refcount;
-
-	/** @rcu: struct used for freeing in an RCU-safe manner */
-	struct rcu_head rcu;
-
-	/** @orig_node: pointer to corresponding orig node struct */
-	struct batadv_orig_node *orig_node;
-
-	/** @last_seen: timestamp of last ogm received from this node */
-	unsigned long last_seen;
-};
-
-/**
- * struct batadv_nc_path - network coding path
- */
-struct batadv_nc_path {
-	/** @hash_entry: next and prev pointer for the list handling */
-	struct hlist_node hash_entry;
-
-	/** @rcu: struct used for freeing in an RCU-safe manner */
-	struct rcu_head rcu;
-
-	/** @refcount: number of contexts the object is used by */
-	struct kref refcount;
-
-	/** @packet_list: list of buffered packets for this path */
-	struct list_head packet_list;
-
-	/** @packet_list_lock: access lock for packet list */
-	spinlock_t packet_list_lock;
-
-	/** @next_hop: next hop (destination) of path */
-	u8 next_hop[ETH_ALEN];
-
-	/** @prev_hop: previous hop (source) of path */
-	u8 prev_hop[ETH_ALEN];
-
-	/** @last_valid: timestamp for last validation of path */
-	unsigned long last_valid;
-};
-
-/**
- * struct batadv_nc_packet - network coding packet used when coding and
- *  decoding packets
- */
-struct batadv_nc_packet {
-	/** @list: next and prev pointer for the list handling */
-	struct list_head list;
-
-	/** @packet_id: crc32 checksum of skb data */
-	__be32 packet_id;
-
-	/**
-	 * @timestamp: field containing the info when the packet was added to
-	 *  path
-	 */
-	unsigned long timestamp;
-
-	/** @neigh_node: pointer to original next hop neighbor of skb */
-	struct batadv_neigh_node *neigh_node;
-
-	/** @skb: skb which can be encoded or used for decoding */
-	struct sk_buff *skb;
-
-	/** @nc_path: pointer to path this nc packet is attached to */
-	struct batadv_nc_path *nc_path;
-};
-
 /**
  * struct batadv_skb_cb - control buffer structure used to store private data
  *  relevant to batman-adv in the skb->cb buffer in skbs.
  */
 struct batadv_skb_cb {
-	/**
-	 * @decoded: Marks a skb as decoded, which is checked when searching for
-	 *  coding opportunities in network-coding.c
-	 */
-	unsigned char decoded:1;
-
 	/** @num_bcasts: Counter for broadcast packet retransmissions */
 	unsigned char num_bcasts;
 };
-- 
2.47.3


