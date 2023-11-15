Return-Path: <netdev+bounces-48152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9007ECA39
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF25B1C20981
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22656364BF;
	Wed, 15 Nov 2023 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5FAD46
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:27 -0800 (PST)
Received: from kero.packetmixer.de (p200300fa2706340047Bd8a14b9C54dbb.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 73FE9FB5FA;
	Wed, 15 Nov 2023 18:59:42 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/6] batman-adv: mcast: implement multicast packet reception and forwarding
Date: Wed, 15 Nov 2023 18:59:28 +0100
Message-Id: <20231115175932.127605-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115175932.127605-1-sw@simonwunderlich.de>
References: <20231115175932.127605-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

Implement functionality to receive and forward a new TVLV capable
multicast packet type.

The new batman-adv multicast packet type allows to contain several
originator destination addresses within a TVLV. Routers on the way will
potentially split the batman-adv multicast packet and adjust its tracker
TVLV contents.

Routing decisions are still based on the selected BATMAN IV or BATMAN V
routing algorithm. So this new batman-adv multicast packet type retains
the same loop-free properties.

Also a new OGM multicast TVLV flag is introduced to signal to other
nodes that we are capable of handling a batman-adv multicast packet and
multicast tracker TVLV. And that all of our hard interfaces have an MTU
of at least 1280 bytes (IPv6 minimum MTU), as a simple solution for now
to avoid MTU issues while forwarding.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h |  45 +++++-
 net/batman-adv/Makefile            |   1 +
 net/batman-adv/fragmentation.c     |   8 +-
 net/batman-adv/main.c              |   2 +
 net/batman-adv/multicast.c         |  48 +++++-
 net/batman-adv/multicast.h         |   5 +
 net/batman-adv/multicast_forw.c    | 239 +++++++++++++++++++++++++++++
 net/batman-adv/originator.c        |  28 ++++
 net/batman-adv/originator.h        |   3 +
 net/batman-adv/routing.c           |  70 +++++++++
 net/batman-adv/routing.h           |  11 ++
 net/batman-adv/soft-interface.c    |  12 ++
 net/batman-adv/types.h             |  64 ++++++++
 13 files changed, 518 insertions(+), 18 deletions(-)
 create mode 100644 net/batman-adv/multicast_forw.c

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 9204e4494b25..6e25753015df 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -116,6 +116,9 @@ enum batadv_icmp_packettype {
  * only need routable IPv4 multicast packets we signed up for explicitly
  * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and therefore
  * only need routable IPv6 multicast packets we signed up for explicitly
+ * @BATADV_MCAST_HAVE_MC_PTYPE_CAPA: we can parse, receive and forward
+ * batman-adv multicast packets with a multicast tracker TVLV. And all our
+ * hard interfaces have an MTU of at least 1280 bytes.
  */
 enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= 1UL << 0,
@@ -123,6 +126,7 @@ enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_IPV6		= 1UL << 2,
 	BATADV_MCAST_WANT_NO_RTR4		= 1UL << 3,
 	BATADV_MCAST_WANT_NO_RTR6		= 1UL << 4,
+	BATADV_MCAST_HAVE_MC_PTYPE_CAPA		= 1UL << 5,
 };
 
 /* tt data subtypes */
@@ -174,14 +178,16 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
  * @BATADV_TVLV_MCAST: multicast capability tvlv
+ * @BATADV_TVLV_MCAST_TRACKER: multicast tracker tvlv
  */
 enum batadv_tvlv_type {
-	BATADV_TVLV_GW		= 0x01,
-	BATADV_TVLV_DAT		= 0x02,
-	BATADV_TVLV_NC		= 0x03,
-	BATADV_TVLV_TT		= 0x04,
-	BATADV_TVLV_ROAM	= 0x05,
-	BATADV_TVLV_MCAST	= 0x06,
+	BATADV_TVLV_GW			= 0x01,
+	BATADV_TVLV_DAT			= 0x02,
+	BATADV_TVLV_NC			= 0x03,
+	BATADV_TVLV_TT			= 0x04,
+	BATADV_TVLV_ROAM		= 0x05,
+	BATADV_TVLV_MCAST		= 0x06,
+	BATADV_TVLV_MCAST_TRACKER	= 0x07,
 };
 
 #pragma pack(2)
@@ -487,6 +493,25 @@ struct batadv_bcast_packet {
 	 */
 };
 
+/**
+ * struct batadv_mcast_packet - multicast packet for network payload
+ * @packet_type: batman-adv packet type, part of the general header
+ * @version: batman-adv protocol version, part of the general header
+ * @ttl: time to live for this packet, part of the general header
+ * @reserved: reserved byte for alignment
+ * @tvlv_len: length of the appended tvlv buffer (in bytes)
+ */
+struct batadv_mcast_packet {
+	__u8 packet_type;
+	__u8 version;
+	__u8 ttl;
+	__u8 reserved;
+	__be16 tvlv_len;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
+
 /**
  * struct batadv_coded_packet - network coded packet
  * @packet_type: batman-adv packet type, part of the general header
@@ -628,6 +653,14 @@ struct batadv_tvlv_mcast_data {
 	__u8 reserved[3];
 };
 
+/**
+ * struct batadv_tvlv_mcast_tracker - payload of a multicast tracker tvlv
+ * @num_dests: number of subsequent destination originator MAC addresses
+ */
+struct batadv_tvlv_mcast_tracker {
+	__be16	num_dests;
+};
+
 #pragma pack()
 
 #endif /* _UAPI_LINUX_BATADV_PACKET_H_ */
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 3bd0760c76a2..b51d8b071b56 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -20,6 +20,7 @@ batman-adv-y += hash.o
 batman-adv-$(CONFIG_BATMAN_ADV_DEBUG) += log.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast_forw.o
 batman-adv-y += netlink.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index c120c7c6d25f..757c084ac2d1 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -25,7 +25,6 @@
 
 #include "hard-interface.h"
 #include "originator.h"
-#include "routing.h"
 #include "send.h"
 
 /**
@@ -351,18 +350,14 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_orig_node *orig_node_src)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct batadv_orig_node *orig_node_dst;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_frag_packet *packet;
 	u16 total_size;
 	bool ret = false;
 
 	packet = (struct batadv_frag_packet *)skb->data;
-	orig_node_dst = batadv_orig_hash_find(bat_priv, packet->dest);
-	if (!orig_node_dst)
-		goto out;
 
-	neigh_node = batadv_find_router(bat_priv, orig_node_dst, recv_if);
+	neigh_node = batadv_orig_to_router(bat_priv, packet->dest, recv_if);
 	if (!neigh_node)
 		goto out;
 
@@ -381,7 +376,6 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	}
 
 out:
-	batadv_orig_node_put(orig_node_dst);
 	batadv_neigh_node_put(neigh_node);
 	return ret;
 }
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a449915566..50b2bf2b748c 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -532,6 +532,8 @@ static void batadv_recv_handler_init(void)
 
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
+	/* multicast packet */
+	batadv_rx_handler[BATADV_MCAST] = batadv_recv_mcast_packet;
 
 	/* unicast packets ... */
 	/* unicast with 4 addresses packet */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 315394f12c55..dfc2c645b13f 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -235,6 +235,37 @@ static u8 batadv_mcast_mla_rtr_flags_get(struct batadv_priv *bat_priv,
 	return flags;
 }
 
+/**
+ * batadv_mcast_mla_forw_flags_get() - get multicast forwarding flags
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Checks if all active hard interfaces have an MTU larger or equal to 1280
+ * bytes (IPv6 minimum MTU).
+ *
+ * Return: BATADV_MCAST_HAVE_MC_PTYPE_CAPA if yes, BATADV_NO_FLAGS otherwise.
+ */
+static u8 batadv_mcast_mla_forw_flags_get(struct batadv_priv *bat_priv)
+{
+	const struct batadv_hard_iface *hard_iface;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		if (hard_iface->net_dev->mtu < IPV6_MIN_MTU) {
+			rcu_read_unlock();
+			return BATADV_NO_FLAGS;
+		}
+	}
+	rcu_read_unlock();
+
+	return BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
+}
+
 /**
  * batadv_mcast_mla_flags_get() - get the new multicast flags
  * @bat_priv: the bat priv with all the soft interface information
@@ -256,6 +287,7 @@ batadv_mcast_mla_flags_get(struct batadv_priv *bat_priv)
 	mla_flags.enabled = 1;
 	mla_flags.tvlv_flags |= batadv_mcast_mla_rtr_flags_get(bat_priv,
 							       bridge);
+	mla_flags.tvlv_flags |= batadv_mcast_mla_forw_flags_get(bat_priv);
 
 	if (!bridge)
 		return mla_flags;
@@ -806,23 +838,25 @@ static void batadv_mcast_flags_log(struct batadv_priv *bat_priv, u8 flags)
 {
 	bool old_enabled = bat_priv->mcast.mla_flags.enabled;
 	u8 old_flags = bat_priv->mcast.mla_flags.tvlv_flags;
-	char str_old_flags[] = "[.... . ]";
+	char str_old_flags[] = "[.... . .]";
 
-	sprintf(str_old_flags, "[%c%c%c%s%s]",
+	sprintf(str_old_flags, "[%c%c%c%s%s%c]",
 		(old_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
 		(old_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
 		(old_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
 		!(old_flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-		!(old_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+		!(old_flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+		!(old_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 
 	batadv_dbg(BATADV_DBG_MCAST, bat_priv,
-		   "Changing multicast flags from '%s' to '[%c%c%c%s%s]'\n",
+		   "Changing multicast flags from '%s' to '[%c%c%c%s%s%c]'\n",
 		   old_enabled ? str_old_flags : "<undefined>",
 		   (flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
 		   (flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
 		   (flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
 		   !(flags & BATADV_MCAST_WANT_NO_RTR4) ? "R4" : ". ",
-		   !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ");
+		   !(flags & BATADV_MCAST_WANT_NO_RTR6) ? "R6" : ". ",
+		   !(flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) ? 'P' : '.');
 }
 
 /**
@@ -1820,6 +1854,10 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
 				     NULL, NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_tvlv_handler_register(bat_priv, NULL, NULL,
+				     batadv_mcast_forw_tracker_tvlv_handler,
+				     BATADV_TVLV_MCAST_TRACKER, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 
 	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
 	batadv_mcast_start_timer(bat_priv);
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index a9770d8d6d36..a5c0f384bb9a 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -52,6 +52,11 @@ void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
+/* multicast_forw.c */
+
+int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb);
+
 #else
 
 static inline enum batadv_forw_mode
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
new file mode 100644
index 000000000000..d17341dfb832
--- /dev/null
+++ b/net/batman-adv/multicast_forw.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ */
+
+#include "multicast.h"
+#include "main.h"
+
+#include <linux/byteorder/generic.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/gfp.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <uapi/linux/batadv_packet.h>
+
+#include "originator.h"
+#include "send.h"
+
+#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
+	for (; num_dests; num_dests--, (dest) += ETH_ALEN)
+
+#define batadv_mcast_forw_tracker_for_each_dest2(dest1, dest2, num_dests) \
+	for (; num_dests; num_dests--, (dest1) += ETH_ALEN, (dest2) += ETH_ALEN)
+
+/**
+ * batadv_mcast_forw_scrub_dests() - scrub destinations in a tracker TVLV
+ * @bat_priv: the bat priv with all the soft interface information
+ * @comp_neigh: next hop neighbor to scrub+collect destinations for
+ * @dest: start MAC entry in original skb's tracker TVLV
+ * @next_dest: start MAC entry in to be sent skb's tracker TVLV
+ * @num_dests: number of remaining destination MAC entries to iterate over
+ *
+ * This sorts destination entries into either the original batman-adv
+ * multicast packet or the skb (copy) that is going to be sent to comp_neigh
+ * next.
+ *
+ * In preparation for the next, to be (unicast) transmitted batman-adv multicast
+ * packet skb to be sent to the given neighbor node, tries to collect all
+ * originator MAC addresses that have the given neighbor node as their next hop
+ * in the to be transmitted skb (copy), which next_dest points into. That is we
+ * zero all destination entries in next_dest which do not have comp_neigh as
+ * their next hop. And zero all destination entries in the original skb that
+ * would have comp_neigh as their next hop (to avoid redundant transmissions and
+ * duplicated payload later).
+ */
+static void
+batadv_mcast_forw_scrub_dests(struct batadv_priv *bat_priv,
+			      struct batadv_neigh_node *comp_neigh, u8 *dest,
+			      u8 *next_dest, u16 num_dests)
+{
+	struct batadv_neigh_node *next_neigh;
+
+	/* skip first entry, this is what we are comparing with */
+	eth_zero_addr(dest);
+	dest += ETH_ALEN;
+	next_dest += ETH_ALEN;
+	num_dests--;
+
+	batadv_mcast_forw_tracker_for_each_dest2(dest, next_dest, num_dests) {
+		if (is_zero_ether_addr(next_dest))
+			continue;
+
+		/* sanity check, we expect unicast destinations */
+		if (is_multicast_ether_addr(next_dest)) {
+			eth_zero_addr(dest);
+			eth_zero_addr(next_dest);
+			continue;
+		}
+
+		next_neigh = batadv_orig_to_router(bat_priv, next_dest, NULL);
+		if (!next_neigh) {
+			eth_zero_addr(next_dest);
+			continue;
+		}
+
+		if (!batadv_compare_eth(next_neigh->addr, comp_neigh->addr)) {
+			eth_zero_addr(next_dest);
+			batadv_neigh_node_put(next_neigh);
+			continue;
+		}
+
+		/* found an entry for our next packet to transmit, so remove it
+		 * from the original packet
+		 */
+		eth_zero_addr(dest);
+		batadv_neigh_node_put(next_neigh);
+	}
+}
+
+/**
+ * batadv_mcast_forw_packet() - forward a batman-adv multicast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the received or locally generated batman-adv multicast packet
+ * @local_xmit: indicates that the packet was locally generated and not received
+ *
+ * Parses the tracker TVLV of a batman-adv multicast packet and forwards the
+ * packet as indicated in this TVLV.
+ *
+ * Caller needs to set the skb network header to the start of the multicast
+ * tracker TVLV (excluding the generic TVLV header) and the skb transport header
+ * to the next byte after this multicast tracker TVLV.
+ *
+ * Caller needs to free the skb.
+ *
+ * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
+ * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
+ * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ */
+static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb, bool local_xmit)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	struct batadv_neigh_node *neigh_node;
+	unsigned long offset, num_dests_off;
+	struct sk_buff *nexthop_skb;
+	unsigned char *skb_net_hdr;
+	bool local_recv = false;
+	unsigned int tvlv_len;
+	bool xmitted = false;
+	u8 *dest, *next_dest;
+	u16 num_dests;
+	int ret;
+
+	/* (at least) TVLV part needs to be linearized */
+	SKB_LINEAR_ASSERT(skb);
+
+	/* check if num_dests is within skb length */
+	num_dests_off = offsetof(struct batadv_tvlv_mcast_tracker, num_dests);
+	if (num_dests_off > skb_network_header_len(skb))
+		return -EINVAL;
+
+	skb_net_hdr = skb_network_header(skb);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb_net_hdr;
+	num_dests = ntohs(mcast_tracker->num_dests);
+
+	dest = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
+
+	/* check if full tracker tvlv is within skb length */
+	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
+	if (tvlv_len > skb_network_header_len(skb))
+		return -EINVAL;
+
+	/* invalidate checksum: */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) {
+		if (is_zero_ether_addr(dest))
+			continue;
+
+		/* only unicast originator addresses supported */
+		if (is_multicast_ether_addr(dest)) {
+			eth_zero_addr(dest);
+			continue;
+		}
+
+		if (batadv_is_my_mac(bat_priv, dest)) {
+			eth_zero_addr(dest);
+			local_recv = true;
+			continue;
+		}
+
+		neigh_node = batadv_orig_to_router(bat_priv, dest, NULL);
+		if (!neigh_node) {
+			eth_zero_addr(dest);
+			continue;
+		}
+
+		nexthop_skb = skb_copy(skb, GFP_ATOMIC);
+		if (!nexthop_skb) {
+			batadv_neigh_node_put(neigh_node);
+			return -ENOMEM;
+		}
+
+		offset = dest - skb->data;
+		next_dest = nexthop_skb->data + offset;
+
+		batadv_mcast_forw_scrub_dests(bat_priv, neigh_node, dest,
+					      next_dest, num_dests);
+
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_TX_BYTES,
+				   nexthop_skb->len + ETH_HLEN);
+		xmitted = true;
+		ret = batadv_send_unicast_skb(nexthop_skb, neigh_node);
+
+		batadv_neigh_node_put(neigh_node);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	if (xmitted) {
+		if (local_xmit) {
+			batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_TX_LOCAL);
+			batadv_add_counter(bat_priv,
+					   BATADV_CNT_MCAST_TX_LOCAL_BYTES,
+					   skb->len -
+					   skb_transport_offset(skb));
+		} else {
+			batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_FWD);
+			batadv_add_counter(bat_priv, BATADV_CNT_MCAST_FWD_BYTES,
+					   skb->len + ETH_HLEN);
+		}
+	}
+
+	if (local_recv)
+		return NET_RX_SUCCESS;
+	else
+		return NET_RX_DROP;
+}
+
+/**
+ * batadv_mcast_forw_tracker_tvlv_handler() - handle an mcast tracker tvlv
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the received batman-adv multicast packet
+ *
+ * Parses the tracker TVLV of an incoming batman-adv multicast packet and
+ * forwards the packet as indicated in this TVLV.
+ *
+ * Caller needs to set the skb network header to the start of the multicast
+ * tracker TVLV (excluding the generic TVLV header) and the skb transport header
+ * to the next byte after this multicast tracker TVLV.
+ *
+ * Caller needs to free the skb.
+ *
+ * Return: NET_RX_SUCCESS or NET_RX_DROP on success or a negative error
+ * code on failure. NET_RX_SUCCESS if the received packet is supposed to be
+ * decapsulated and forwarded to the own soft interface, NET_RX_DROP otherwise.
+ */
+int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	return batadv_mcast_forw_packet(bat_priv, skb, false);
+}
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 34903df4fe93..71c143d4b6d0 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -311,6 +311,33 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
 	return router;
 }
 
+/**
+ * batadv_orig_to_router() - get next hop neighbor to an orig address
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_addr: the originator MAC address to search the best next hop router for
+ * @if_outgoing: the interface where the payload packet has been received or
+ *  the OGM should be sent to
+ *
+ * Return: A neighbor node which is the best router towards the given originator
+ * address.
+ */
+struct batadv_neigh_node *
+batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+		      struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+	if (!orig_node)
+		return NULL;
+
+	neigh_node = batadv_find_router(bat_priv, orig_node, if_outgoing);
+	batadv_orig_node_put(orig_node);
+
+	return neigh_node;
+}
+
 /**
  * batadv_orig_ifinfo_get() - find the ifinfo from an orig_node
  * @orig_node: the orig node to be queried
@@ -942,6 +969,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	orig_node->mcast_flags = BATADV_MCAST_WANT_NO_RTR4;
 	orig_node->mcast_flags |= BATADV_MCAST_WANT_NO_RTR6;
+	orig_node->mcast_flags |= BATADV_MCAST_HAVE_MC_PTYPE_CAPA;
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_unsnoopables_node);
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv4_node);
 	INIT_HLIST_NODE(&orig_node->mcast_want_all_ipv6_node);
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index ea3d69e4e670..db0c55128170 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -36,6 +36,9 @@ void batadv_neigh_node_release(struct kref *ref);
 struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
 		       const struct batadv_hard_iface *if_outgoing);
+struct batadv_neigh_node *
+batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+		      struct batadv_hard_iface *if_outgoing);
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 163cd43c4821..f1061985149f 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1270,3 +1270,73 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	batadv_orig_node_put(orig_node);
 	return ret;
 }
+
+#ifdef CONFIG_BATMAN_ADV_MCAST
+/**
+ * batadv_recv_mcast_packet() - process received batman-adv multicast packet
+ * @skb: the received batman-adv multicast packet
+ * @recv_if: interface that the skb is received on
+ *
+ * Parses the given, received batman-adv multicast packet. Depending on the
+ * contents of its TVLV forwards it and/or decapsulates it to hand it to the
+ * soft interface.
+ *
+ * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ */
+int batadv_recv_mcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_mcast_packet *mcast_packet;
+	int hdr_size = sizeof(*mcast_packet);
+	unsigned char *tvlv_buff;
+	int ret = NET_RX_DROP;
+	u16 tvlv_buff_len;
+
+	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
+		goto free_skb;
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	/* packet needs to be linearized to access the tvlv content */
+	if (skb_linearize(skb) < 0)
+		goto free_skb;
+
+	mcast_packet = (struct batadv_mcast_packet *)skb->data;
+	if (mcast_packet->ttl-- < 2)
+		goto free_skb;
+
+	tvlv_buff = (unsigned char *)(skb->data + hdr_size);
+	tvlv_buff_len = ntohs(mcast_packet->tvlv_len);
+
+	if (tvlv_buff_len > skb->len - hdr_size)
+		goto free_skb;
+
+	ret = batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL, skb,
+					     tvlv_buff, tvlv_buff_len);
+	if (ret >= 0) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_RX);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_RX_BYTES,
+				   skb->len + ETH_HLEN);
+	}
+
+	hdr_size += tvlv_buff_len;
+
+	if (ret == NET_RX_SUCCESS && (skb->len - hdr_size >= ETH_HLEN)) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_MCAST_RX_LOCAL);
+		batadv_add_counter(bat_priv, BATADV_CNT_MCAST_RX_LOCAL_BYTES,
+				   skb->len - hdr_size);
+
+		batadv_interface_rx(bat_priv->soft_iface, skb, hdr_size, NULL);
+		/* skb was consumed */
+		skb = NULL;
+	}
+
+free_skb:
+	kfree_skb(skb);
+
+	return ret;
+}
+#endif /* CONFIG_BATMAN_ADV_MCAST */
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index afd15b3879f1..e9849f032a24 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -27,6 +27,17 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
+#ifdef CONFIG_BATMAN_ADV_MCAST
+int batadv_recv_mcast_packet(struct sk_buff *skb,
+			     struct batadv_hard_iface *recv_if);
+#else
+static inline int batadv_recv_mcast_packet(struct sk_buff *skb,
+					   struct batadv_hard_iface *recv_if)
+{
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+#endif
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1bf1232a4f75..1b0e2c59aef2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -925,6 +925,18 @@ static const struct {
 	{ "tt_response_rx" },
 	{ "tt_roam_adv_tx" },
 	{ "tt_roam_adv_rx" },
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	{ "mcast_tx" },
+	{ "mcast_tx_bytes" },
+	{ "mcast_tx_local" },
+	{ "mcast_tx_local_bytes" },
+	{ "mcast_rx" },
+	{ "mcast_rx_bytes" },
+	{ "mcast_rx_local" },
+	{ "mcast_rx_local_bytes" },
+	{ "mcast_fwd" },
+	{ "mcast_fwd_bytes" },
+#endif
 #ifdef CONFIG_BATMAN_ADV_DAT
 	{ "dat_get_tx" },
 	{ "dat_get_rx" },
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 17d5ea1d8e84..850b184e5b04 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -862,6 +862,70 @@ enum batadv_counters {
 	 */
 	BATADV_CNT_TT_ROAM_ADV_RX,
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	/**
+	 * @BATADV_CNT_MCAST_TX: transmitted batman-adv multicast packets
+	 *  counter
+	 */
+	BATADV_CNT_MCAST_TX,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_BYTES: transmitted batman-adv multicast packets
+	 *  bytes counter
+	 */
+	BATADV_CNT_MCAST_TX_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_LOCAL: counter for multicast packets which
+	 *  were locally encapsulated and transmitted as batman-adv multicast
+	 *  packets
+	 */
+	BATADV_CNT_MCAST_TX_LOCAL,
+
+	/**
+	 * @BATADV_CNT_MCAST_TX_LOCAL_BYTES: bytes counter for multicast packets
+	 *  which were locally encapsulated and transmitted as batman-adv
+	 *  multicast packets
+	 */
+	BATADV_CNT_MCAST_TX_LOCAL_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX: received batman-adv multicast packet counter
+	 */
+	BATADV_CNT_MCAST_RX,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_BYTES: received batman-adv multicast packet
+	 *  bytes counter
+	 */
+	BATADV_CNT_MCAST_RX_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_LOCAL: counter for received batman-adv multicast
+	 *  packets which were forwarded to the local soft interface
+	 */
+	BATADV_CNT_MCAST_RX_LOCAL,
+
+	/**
+	 * @BATADV_CNT_MCAST_RX_LOCAL_BYTES: bytes counter for received
+	 *  batman-adv multicast packets which were forwarded to the local soft
+	 *  interface
+	 */
+	BATADV_CNT_MCAST_RX_LOCAL_BYTES,
+
+	/**
+	 * @BATADV_CNT_MCAST_FWD: counter for received batman-adv multicast
+	 *  packets which were forwarded to other, neighboring nodes
+	 */
+	BATADV_CNT_MCAST_FWD,
+
+	/**
+	 * @BATADV_CNT_MCAST_FWD_BYTES: bytes counter for received batman-adv
+	 *  multicast packets which were forwarded to other, neighboring nodes
+	 */
+	BATADV_CNT_MCAST_FWD_BYTES,
+#endif
+
 #ifdef CONFIG_BATMAN_ADV_DAT
 	/**
 	 * @BATADV_CNT_DAT_GET_TX: transmitted dht GET traffic packet counter
-- 
2.39.2


