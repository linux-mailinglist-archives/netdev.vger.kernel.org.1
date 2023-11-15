Return-Path: <netdev+bounces-48153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493877ECA3A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6145C1C2033E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2631364CE;
	Wed, 15 Nov 2023 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 10:05:28 PST
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD85D48
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:05:27 -0800 (PST)
Received: from kero.packetmixer.de (p200300fa2706340047Bd8A14B9c54Dbb.dip0.t-ipconnect.de [IPv6:2003:fa:2706:3400:47bd:8a14:b9c5:4dbb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 384B3FB5FB;
	Wed, 15 Nov 2023 18:59:44 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/6] batman-adv: mcast: implement multicast packet generation
Date: Wed, 15 Nov 2023 18:59:29 +0100
Message-Id: <20231115175932.127605-4-sw@simonwunderlich.de>
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

Implement the preparation of a batman-adv multicast packet and use this
under certain conditions.

For one thing this implements the capability to push a complete
batman-adv multicast packet header, including a tracker TVLV with all
originator destinations that have signaled interest in it, onto a given
ethernet frame with an IP multicast packet inside.

For another checks are implemented to determine if encapsulating a
multicast packet in this new batman-adv multicast packet type and using
it is feasible. Those checks are:

1) Have all nodes signaled that they are capable of handling the new
   batman-adv multicast packet type?
2) Do all active hard interfaces of all nodes, including us, have an MTU
   of at least 1280 bytes?
3) Does a complete multicast packet header with all its destination
   addresses fit onto the given multicast packet / ethernet frame and
   does not exceed 1280 bytes?

If all checks passed then the new batman-adv multicast packet type will
be used for transmission and distribution. Otherwise we fall back to one or
more batman-adv unicast packet transmissions, if possible. Or if not
possible we will fall back to classic flooding through a batman-adv
broadcast packet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c      |  79 +++-
 net/batman-adv/multicast.h      |  25 +-
 net/batman-adv/multicast_forw.c | 732 ++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.c |   6 +-
 net/batman-adv/types.h          |   6 +
 5 files changed, 840 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index dfc2c645b13f..62288afdad49 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1169,17 +1169,62 @@ static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_mcast_forw_mode_by_count() - get forwarding mode by count
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to check
+ * @vid: the vlan identifier
+ * @is_routable: stores whether the destination is routable
+ * @count: the number of originators the multicast packet need to be sent to
+ *
+ * For a multicast packet with multiple destination originators, checks which
+ * mode to use. For BATADV_FORW_MCAST it also encapsulates the packet with a
+ * complete batman-adv multicast header.
+ *
+ * Return:
+ *	BATADV_FORW_MCAST: If all nodes have multicast packet routing
+ *	capabilities and an MTU >= 1280 on all hard interfaces (including us)
+ *	and the encapsulated multicast packet with all destination addresses
+ *	would still fit into an 1280 bytes batman-adv multicast packet
+ *	(excluding the outer ethernet frame) and we could successfully push
+ *	the full batman-adv multicast packet header.
+ *	BATADV_FORW_UCASTS: If the packet cannot be sent in a batman-adv
+ *	multicast packet and the amount of batman-adv unicast packets needed
+ *	is smaller or equal to the configured multicast fanout.
+ *	BATADV_FORW_BCAST: Otherwise.
+ */
+static enum batadv_forw_mode
+batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid,
+				int is_routable, int count)
+{
+	unsigned int mcast_hdrlen = batadv_mcast_forw_packet_hdrlen(count);
+	u8 own_tvlv_flags = bat_priv->mcast.mla_flags.tvlv_flags;
+
+	if (!atomic_read(&bat_priv->mcast.num_no_mc_ptype_capa) &&
+	    own_tvlv_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA &&
+	    skb->len + mcast_hdrlen <= IPV6_MIN_MTU &&
+	    batadv_mcast_forw_push(bat_priv, skb, vid, is_routable, count))
+		return BATADV_FORW_MCAST;
+
+	if (count <= atomic_read(&bat_priv->multicast_fanout))
+		return BATADV_FORW_UCASTS;
+
+	return BATADV_FORW_BCAST;
+}
+
 /**
  * batadv_mcast_forw_mode() - check on how to forward a multicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the multicast packet to check
+ * @vid: the vlan identifier
  * @is_routable: stores whether the destination is routable
  *
  * Return: The forwarding mode as enum batadv_forw_mode.
  */
 enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
-		       int *is_routable)
+		       unsigned short vid, int *is_routable)
 {
 	int ret, tt_count, ip_count, unsnoop_count, total_count;
 	bool is_unsnoopable = false;
@@ -1209,10 +1254,8 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	else if (unsnoop_count)
 		return BATADV_FORW_BCAST;
 
-	if (total_count <= atomic_read(&bat_priv->multicast_fanout))
-		return BATADV_FORW_UCASTS;
-
-	return BATADV_FORW_BCAST;
+	return batadv_mcast_forw_mode_by_count(bat_priv, skb, vid, *is_routable,
+					       total_count);
 }
 
 /**
@@ -1772,6 +1815,31 @@ static void batadv_mcast_want_rtr6_update(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_mcast_have_mc_ptype_update() - update multicast packet type counter
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node which multicast state might have changed of
+ * @mcast_flags: flags indicating the new multicast state
+ *
+ * If the BATADV_MCAST_HAVE_MC_PTYPE_CAPA flag of this originator, orig, has
+ * toggled then this method updates the counter accordingly.
+ */
+static void batadv_mcast_have_mc_ptype_update(struct batadv_priv *bat_priv,
+					      struct batadv_orig_node *orig,
+					      u8 mcast_flags)
+{
+	lockdep_assert_held(&orig->mcast_handler_lock);
+
+	/* switched from flag set to unset */
+	if (!(mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA) &&
+	    orig->mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA)
+		atomic_inc(&bat_priv->mcast.num_no_mc_ptype_capa);
+	/* switched from flag unset to set */
+	else if (mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA &&
+		 !(orig->mcast_flags & BATADV_MCAST_HAVE_MC_PTYPE_CAPA))
+		atomic_dec(&bat_priv->mcast.num_no_mc_ptype_capa);
+}
+
 /**
  * batadv_mcast_tvlv_flags_get() - get multicast flags from an OGM TVLV
  * @enabled: whether the originator has multicast TVLV support enabled
@@ -1840,6 +1908,7 @@ static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
 	batadv_mcast_want_ipv6_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_rtr4_update(bat_priv, orig, mcast_flags);
 	batadv_mcast_want_rtr6_update(bat_priv, orig, mcast_flags);
+	batadv_mcast_have_mc_ptype_update(bat_priv, orig, mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
 	spin_unlock_bh(&orig->mcast_handler_lock);
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index a5c0f384bb9a..d97ee51d26f2 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -11,6 +11,7 @@
 
 #include <linux/netlink.h>
 #include <linux/skbuff.h>
+#include <linux/types.h>
 
 /**
  * enum batadv_forw_mode - the way a packet should be forwarded as
@@ -28,6 +29,12 @@ enum batadv_forw_mode {
 	 */
 	BATADV_FORW_UCASTS,
 
+	/**
+	 * @BATADV_FORW_MCAST: forward the packet to some nodes via a
+	 *  batman-adv multicast packet
+	 */
+	BATADV_FORW_MCAST,
+
 	/** @BATADV_FORW_NONE: don't forward, drop it */
 	BATADV_FORW_NONE,
 };
@@ -36,7 +43,7 @@ enum batadv_forw_mode {
 
 enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
-		       int *is_routable);
+		       unsigned short vid, int *is_routable);
 
 int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			   unsigned short vid, int is_routable);
@@ -57,11 +64,18 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb);
 
+unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests);
+
+bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			    unsigned short vid, int is_routable, int count);
+
+int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv, struct sk_buff *skb);
+
 #else
 
 static inline enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
-		       int *is_routable)
+		       unsigned short vid, int *is_routable)
 {
 	return BATADV_FORW_BCAST;
 }
@@ -99,6 +113,13 @@ static inline void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
 {
 }
 
+static inline int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
+
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index d17341dfb832..a2c5c587b8fb 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -7,19 +7,30 @@
 #include "multicast.h"
 #include "main.h"
 
+#include <linux/bug.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ipv6.h>
+#include <linux/limits.h>
 #include <linux/netdevice.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
 
+#include "bridge_loop_avoidance.h"
 #include "originator.h"
 #include "send.h"
+#include "translation-table.h"
 
 #define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
 	for (; num_dests; num_dests--, (dest) += ETH_ALEN)
@@ -27,6 +38,600 @@
 #define batadv_mcast_forw_tracker_for_each_dest2(dest1, dest2, num_dests) \
 	for (; num_dests; num_dests--, (dest1) += ETH_ALEN, (dest2) += ETH_ALEN)
 
+/**
+ * batadv_mcast_forw_skb_push() - skb_push and memorize amount of pushed bytes
+ * @skb: the skb to push onto
+ * @size: the amount of bytes to push
+ * @len: stores the total amount of bytes pushed
+ *
+ * Performs an skb_push() onto the given skb and adds the amount of pushed bytes
+ * to the given len pointer.
+ *
+ * Return: the return value of the skb_push() call.
+ */
+static void *batadv_mcast_forw_skb_push(struct sk_buff *skb, size_t size,
+					unsigned short *len)
+{
+	*len += size;
+	return skb_push(skb, size);
+}
+
+/**
+ * batadv_mcast_forw_push_padding() - push 2 padding bytes to skb's front
+ * @skb: the skb to push onto
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Pushes two padding bytes to the front of the given skb.
+ *
+ * Return: On success a pointer to the first byte of the two pushed padding
+ * bytes within the skb. NULL otherwise.
+ */
+static char *
+batadv_mcast_forw_push_padding(struct sk_buff *skb, unsigned short *tvlv_len)
+{
+	const int pad_len = 2;
+	char *padding;
+
+	if (skb_headroom(skb) < pad_len)
+		return NULL;
+
+	padding = batadv_mcast_forw_skb_push(skb, pad_len, tvlv_len);
+	memset(padding, 0, pad_len);
+
+	return padding;
+}
+
+/**
+ * batadv_mcast_forw_push_est_padding() - push padding bytes if necessary
+ * @skb: the skb to potentially push the padding onto
+ * @count: the (estimated) number of originators the multicast packet needs to
+ *  be sent to
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * If the number of destination entries is even then this adds two
+ * padding bytes to the end of the tracker TVLV.
+ *
+ * Return: true on success or if no padding is needed, false otherwise.
+ */
+static bool
+batadv_mcast_forw_push_est_padding(struct sk_buff *skb, int count,
+				   unsigned short *tvlv_len)
+{
+	if (!(count % 2) && !batadv_mcast_forw_push_padding(skb, tvlv_len))
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_orig_entry() - get orig_node from an hlist node
+ * @node: the hlist node to get the orig_node from
+ * @entry_offset: the offset of the hlist node within the orig_node struct
+ *
+ * Return: The orig_node containing the hlist node on success, NULL on error.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_orig_entry(struct hlist_node *node,
+			     size_t entry_offset)
+{
+	/* sanity check */
+	switch (entry_offset) {
+	case offsetof(struct batadv_orig_node, mcast_want_all_ipv4_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_ipv6_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_rtr4_node):
+	case offsetof(struct batadv_orig_node, mcast_want_all_rtr6_node):
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return (struct batadv_orig_node *)((void *)node - entry_offset);
+}
+
+/**
+ * batadv_mcast_forw_push_dest() - push an originator MAC address onto an skb
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination address onto
+ * @vid: the vlan identifier
+ * @orig_node: the originator node to get the MAC address from
+ * @num_dests: a pointer to store the number of pushed addresses in
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * If the orig_node is a BLA backbone gateway, if there is not enough skb
+ * headroom available or if num_dests is already at its maximum (65535) then
+ * neither the skb nor num_dests is changed. Otherwise the originator's MAC
+ * address is pushed onto the given skb and num_dests incremented by one.
+ *
+ * Return: true if the orig_node is a backbone gateway or if an orig address
+ *  was pushed successfully, false otherwise.
+ */
+static bool batadv_mcast_forw_push_dest(struct batadv_priv *bat_priv,
+					struct sk_buff *skb, unsigned short vid,
+					struct batadv_orig_node *orig_node,
+					unsigned short *num_dests,
+					unsigned short *tvlv_len)
+{
+	BUILD_BUG_ON(sizeof_field(struct batadv_tvlv_mcast_tracker, num_dests)
+		     != sizeof(__be16));
+
+	/* Avoid sending to other BLA gateways - they already got the frame from
+	 * the LAN side we share with them.
+	 * TODO: Refactor to take BLA into account earlier in mode check.
+	 */
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid))
+		return true;
+
+	if (skb_headroom(skb) < ETH_ALEN || *num_dests == U16_MAX)
+		return false;
+
+	batadv_mcast_forw_skb_push(skb, ETH_ALEN, tvlv_len);
+	ether_addr_copy(skb->data, orig_node->orig);
+	(*num_dests)++;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_dests_list() - push originators from list onto an skb
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @head: the list to gather originators from
+ * @entry_offset: offset of an hlist node in an orig_node structure
+ * @num_dests: a pointer to store the number of pushed addresses in
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Push the MAC addresses of all originators in the given list onto the given
+ * skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
+					     struct sk_buff *skb,
+					     unsigned short vid,
+					     struct hlist_head *head,
+					     size_t entry_offset,
+					     unsigned short *num_dests,
+					     unsigned short *tvlv_len)
+{
+	struct hlist_node *node;
+	struct batadv_orig_node *orig_node;
+
+	rcu_read_lock();
+	__hlist_for_each_rcu(node, head) {
+		orig_node = batadv_mcast_forw_orig_entry(node, entry_offset);
+		if (!orig_node ||
+		    !batadv_mcast_forw_push_dest(bat_priv, skb, vid, orig_node,
+						 num_dests, tvlv_len)) {
+			rcu_read_unlock();
+			return false;
+		}
+	}
+	rcu_read_unlock();
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_tt() - push originators with interest through TT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Push the MAC addresses of all originators which have indicated interest in
+ * this multicast packet through the translation table onto the given skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool
+batadv_mcast_forw_push_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			  unsigned short vid, unsigned short *num_dests,
+			  unsigned short *tvlv_len)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	struct batadv_tt_global_entry *tt_global;
+	const u8 *addr = eth_hdr(skb)->h_dest;
+
+	/* ok */
+	int ret = true;
+
+	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
+	if (!tt_global)
+		goto out;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, &tt_global->orig_list, list) {
+		if (!batadv_mcast_forw_push_dest(bat_priv, skb, vid,
+						 orig_entry->orig_node,
+						 num_dests, tvlv_len)) {
+			ret = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	batadv_tt_global_entry_put(tt_global);
+
+out:
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_push_want_all() - push originators with want-all flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Push the MAC addresses of all originators which have indicated interest in
+ * this multicast packet through the want-all flag onto the given skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool batadv_mcast_forw_push_want_all(struct batadv_priv *bat_priv,
+					    struct sk_buff *skb,
+					    unsigned short vid,
+					    unsigned short *num_dests,
+					    unsigned short *tvlv_len)
+{
+	struct hlist_head *head = NULL;
+	size_t offset;
+	int ret;
+
+	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_IP):
+		head = &bat_priv->mcast.want_all_ipv4_list;
+		offset = offsetof(struct batadv_orig_node,
+				  mcast_want_all_ipv4_node);
+		break;
+	case htons(ETH_P_IPV6):
+		head = &bat_priv->mcast.want_all_ipv6_list;
+		offset = offsetof(struct batadv_orig_node,
+				  mcast_want_all_ipv6_node);
+		break;
+	default:
+		return false;
+	}
+
+	ret = batadv_mcast_forw_push_dests_list(bat_priv, skb, vid, head,
+						offset, num_dests, tvlv_len);
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_want_rtr() - push originators with want-router flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @num_dests: a pointer to store the number of pushed addresses in
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Push the MAC addresses of all originators which have indicated interest in
+ * this multicast packet through the want-all-rtr flag onto the given skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool batadv_mcast_forw_push_want_rtr(struct batadv_priv *bat_priv,
+					    struct sk_buff *skb,
+					    unsigned short vid,
+					    unsigned short *num_dests,
+					    unsigned short *tvlv_len)
+{
+	struct hlist_head *head = NULL;
+	size_t offset;
+	int ret;
+
+	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_IP):
+		head = &bat_priv->mcast.want_all_rtr4_list;
+		offset = offsetof(struct batadv_orig_node,
+				  mcast_want_all_rtr4_node);
+		break;
+	case htons(ETH_P_IPV6):
+		head = &bat_priv->mcast.want_all_rtr6_list;
+		offset = offsetof(struct batadv_orig_node,
+				  mcast_want_all_rtr6_node);
+		break;
+	default:
+		return false;
+	}
+
+	ret = batadv_mcast_forw_push_dests_list(bat_priv, skb, vid, head,
+						offset, num_dests, tvlv_len);
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_scrape() - remove bytes within skb data
+ * @skb: the skb to remove bytes from
+ * @offset: the offset from the skb data from which to scrape
+ * @len: the amount of bytes to scrape starting from the offset
+ *
+ * Scrapes/removes len bytes from the given skb at the given offset from the
+ * skb data.
+ *
+ * Caller needs to ensure that the region from the skb data's start up
+ * to/including the to be removed bytes are linearized.
+ */
+static void batadv_mcast_forw_scrape(struct sk_buff *skb,
+				     unsigned short offset,
+				     unsigned short len)
+{
+	char *to, *from;
+
+	SKB_LINEAR_ASSERT(skb);
+
+	to = skb_pull(skb, len);
+	from = to - len;
+
+	memmove(to, from, offset);
+}
+
+/**
+ * batadv_mcast_forw_push_scrape_padding() - remove TVLV padding
+ * @skb: the skb to potentially adjust the TVLV's padding on
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Remove two padding bytes from the end of the multicast tracker TVLV,
+ * from before the payload data.
+ *
+ * Caller needs to ensure that the TVLV bytes are linearized.
+ */
+static void batadv_mcast_forw_push_scrape_padding(struct sk_buff *skb,
+						  unsigned short *tvlv_len)
+{
+	const int pad_len = 2;
+
+	batadv_mcast_forw_scrape(skb, *tvlv_len - pad_len, pad_len);
+	*tvlv_len -= pad_len;
+}
+
+/**
+ * batadv_mcast_forw_push_insert_padding() - insert TVLV padding
+ * @skb: the skb to potentially adjust the TVLV's padding on
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Inserts two padding bytes at the end of the multicast tracker TVLV,
+ * before the payload data in the given skb.
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool batadv_mcast_forw_push_insert_padding(struct sk_buff *skb,
+						  unsigned short *tvlv_len)
+{
+	unsigned short offset =	*tvlv_len;
+	char *to, *from = skb->data;
+
+	to = batadv_mcast_forw_push_padding(skb, tvlv_len);
+	if (!to)
+		return false;
+
+	memmove(to, from, offset);
+	memset(to + offset, 0, *tvlv_len - offset);
+	return true;
+}
+
+/**
+ * batadv_mcast_forw_push_adjust_padding() - adjust padding if necessary
+ * @skb: the skb to potentially adjust the TVLV's padding on
+ * @count: the estimated number of originators the multicast packet needs to
+ *  be sent to
+ * @num_dests_pushed: the number of originators that were actually added to the
+ *  multicast packet's tracker TVLV
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Adjusts the padding in the multicast packet's tracker TVLV depending on the
+ * initially estimated amount of destinations versus the amount of destinations
+ * that were actually added to the tracker TVLV.
+ *
+ * If the initial estimate was correct or at least the oddness was the same then
+ * no padding adjustment is performed.
+ * If the initially estimated number was even, so padding was initially added,
+ * but it turned out to be odd then padding is removed.
+ * If the initially estimated number was odd, so no padding was initially added,
+ * but it turned out to be even then padding is added.
+ *
+ * Return: true if no padding adjustment is needed or the adjustment was
+ * successful, false otherwise.
+ */
+static bool
+batadv_mcast_forw_push_adjust_padding(struct sk_buff *skb, int *count,
+				      unsigned short num_dests_pushed,
+				      unsigned short *tvlv_len)
+{
+	int ret = true;
+
+	if (likely((num_dests_pushed % 2) == (*count % 2)))
+		goto out;
+
+	/**
+	 * estimated even number of destinations, but turned out to be odd
+	 * -> remove padding
+	 */
+	if (!(*count % 2) && (num_dests_pushed % 2))
+		batadv_mcast_forw_push_scrape_padding(skb, tvlv_len);
+	/**
+	 * estimated odd number of destinations, but turned out to be even
+	 * -> add padding
+	 */
+	else if ((*count % 2) && (!(num_dests_pushed % 2)))
+		ret = batadv_mcast_forw_push_insert_padding(skb, tvlv_len);
+
+out:
+	*count = num_dests_pushed;
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_push_dests() - push originator addresses onto an skb
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the destination addresses onto
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ * @count: the number of originators the multicast packet needs to be sent to
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Push the MAC addresses of all originators which have indicated interest in
+ * this multicast packet onto the given skb.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherwise, on
+ * success 0.
+ */
+static int
+batadv_mcast_forw_push_dests(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			     unsigned short vid, int is_routable, int *count,
+			     unsigned short *tvlv_len)
+{
+	unsigned short num_dests = 0;
+
+	if (!batadv_mcast_forw_push_est_padding(skb, *count, tvlv_len))
+		goto err;
+
+	if (!batadv_mcast_forw_push_tt(bat_priv, skb, vid, &num_dests,
+				       tvlv_len))
+		goto err;
+
+	if (!batadv_mcast_forw_push_want_all(bat_priv, skb, vid, &num_dests,
+					     tvlv_len))
+		goto err;
+
+	if (is_routable &&
+	    !batadv_mcast_forw_push_want_rtr(bat_priv, skb, vid, &num_dests,
+					     tvlv_len))
+		goto err;
+
+	if (!batadv_mcast_forw_push_adjust_padding(skb, count, num_dests,
+						   tvlv_len))
+		goto err;
+
+	return 0;
+err:
+	return -ENOMEM;
+}
+
+/**
+ * batadv_mcast_forw_push_tracker() - push a multicast tracker TVLV header
+ * @skb: the skb to push the tracker TVLV onto
+ * @num_dests: the number of destination addresses to set in the header
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Pushes a multicast tracker TVLV header onto the given skb, including the
+ * generic TVLV header but excluding the destination MAC addresses.
+ *
+ * The provided num_dests value is taken into consideration to set the
+ * num_dests field in the tracker header and to set the appropriate TVLV length
+ * value fields.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherwise, on
+ * success 0.
+ */
+static int batadv_mcast_forw_push_tracker(struct sk_buff *skb, int num_dests,
+					  unsigned short *tvlv_len)
+{
+	struct batadv_tvlv_mcast_tracker *mcast_tracker;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	unsigned int tvlv_value_len;
+
+	if (skb_headroom(skb) < sizeof(*mcast_tracker) + sizeof(*tvlv_hdr))
+		return -ENOMEM;
+
+	tvlv_value_len = sizeof(*mcast_tracker) + *tvlv_len;
+	if (tvlv_value_len + sizeof(*tvlv_hdr) > U16_MAX)
+		return -ENOMEM;
+
+	batadv_mcast_forw_skb_push(skb, sizeof(*mcast_tracker), tvlv_len);
+	mcast_tracker = (struct batadv_tvlv_mcast_tracker *)skb->data;
+	mcast_tracker->num_dests = htons(num_dests);
+
+	skb_reset_network_header(skb);
+
+	batadv_mcast_forw_skb_push(skb, sizeof(*tvlv_hdr), tvlv_len);
+	tvlv_hdr = (struct batadv_tvlv_hdr *)skb->data;
+	tvlv_hdr->type = BATADV_TVLV_MCAST_TRACKER;
+	tvlv_hdr->version = 1;
+	tvlv_hdr->len = htons(tvlv_value_len);
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_push_tvlvs() - push a multicast tracker TVLV onto an skb
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the skb to push the tracker TVLV onto
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ * @count: the number of originators the multicast packet needs to be sent to
+ * @tvlv_len: stores the amount of currently pushed TVLV bytes
+ *
+ * Pushes a multicast tracker TVLV onto the given skb, including the collected
+ * destination MAC addresses and the generic TVLV header.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherwise, on
+ * success 0.
+ */
+static int
+batadv_mcast_forw_push_tvlvs(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			     unsigned short vid, int is_routable, int count,
+			     unsigned short *tvlv_len)
+{
+	int ret;
+
+	ret = batadv_mcast_forw_push_dests(bat_priv, skb, vid, is_routable,
+					   &count, tvlv_len);
+	if (ret < 0)
+		return ret;
+
+	ret = batadv_mcast_forw_push_tracker(skb, count, tvlv_len);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_push_hdr() - push a multicast packet header onto an skb
+ * @skb: the skb to push the header onto
+ * @tvlv_len: the total TVLV length value to set in the header
+ *
+ * Pushes a batman-adv multicast packet header onto the given skb and sets
+ * the provided total TVLV length value in it.
+ *
+ * Caller needs to ensure enough skb headroom is available.
+ *
+ * Return: -ENOMEM if there is not enough skb headroom available. Otherwise, on
+ * success 0.
+ */
+static int
+batadv_mcast_forw_push_hdr(struct sk_buff *skb, unsigned short tvlv_len)
+{
+	struct batadv_mcast_packet *mcast_packet;
+
+	if (skb_headroom(skb) < sizeof(*mcast_packet))
+		return -ENOMEM;
+
+	skb_push(skb, sizeof(*mcast_packet));
+
+	mcast_packet = (struct batadv_mcast_packet *)skb->data;
+	mcast_packet->version = BATADV_COMPAT_VERSION;
+	mcast_packet->ttl = BATADV_TTL;
+	mcast_packet->packet_type = BATADV_MCAST;
+	mcast_packet->reserved = 0;
+	mcast_packet->tvlv_len = htons(tvlv_len);
+
+	return 0;
+}
+
 /**
  * batadv_mcast_forw_scrub_dests() - scrub destinations in a tracker TVLV
  * @bat_priv: the bat priv with all the soft interface information
@@ -237,3 +842,130 @@ int batadv_mcast_forw_tracker_tvlv_handler(struct batadv_priv *bat_priv,
 {
 	return batadv_mcast_forw_packet(bat_priv, skb, false);
 }
+
+/**
+ * batadv_mcast_forw_packet_hdrlen() - multicast packet header length
+ * @num_dests: number of destination nodes
+ *
+ * Calculates the total batman-adv multicast packet header length for a given
+ * number of destination nodes (excluding the outer ethernet frame).
+ *
+ * Return: The calculated total batman-adv multicast packet header length.
+ */
+unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
+{
+	/**
+	 * If the number of destination entries is even then we need to add
+	 * two byte padding to the tracker TVLV.
+	 */
+	int padding = (!(num_dests % 2)) ? 2 : 0;
+
+	return padding + num_dests * ETH_ALEN +
+	       sizeof(struct batadv_tvlv_mcast_tracker) +
+	       sizeof(struct batadv_tvlv_hdr) +
+	       sizeof(struct batadv_mcast_packet);
+}
+
+/**
+ * batadv_mcast_forw_expand_head() - expand headroom for an mcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to send
+ *
+ * Tries to expand an skb's headroom so that its head to tail is 1298
+ * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
+ *
+ * Return: -EINVAL if the given skb's length is too large or -ENOMEM on memory
+ * allocation failure. Otherwise, on success, zero is returned.
+ */
+static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
+					 struct sk_buff *skb)
+{
+	int hdr_size = VLAN_ETH_HLEN + IPV6_MIN_MTU - skb->len;
+
+	 /* TODO: Could be tightened to actual number of destination nodes?
+	  * But it's tricky, number of destinations might have increased since
+	  * we last checked.
+	  */
+	if (hdr_size < 0) {
+		/* batadv_mcast_forw_mode_check_count() should ensure we do not
+		 * end up here
+		 */
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (skb_headroom(skb) < hdr_size &&
+	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_forw_push() - encapsulate skb in a batman-adv multicast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to encapsulate and send
+ * @vid: the vlan identifier
+ * @is_routable: indicates whether the destination is routable
+ * @count: the number of originators the multicast packet needs to be sent to
+ *
+ * Encapsulates the given multicast packet in a batman-adv multicast packet.
+ * A multicast tracker TVLV with destination originator addresses for any node
+ * that signaled interest in it, that is either via the translation table or the
+ * according want-all flags, is attached accordingly.
+ *
+ * Return: true on success, false otherwise.
+ */
+bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			    unsigned short vid, int is_routable, int count)
+{
+	unsigned short tvlv_len = 0;
+	int ret;
+
+	if (batadv_mcast_forw_expand_head(bat_priv, skb) < 0)
+		goto err;
+
+	skb_reset_transport_header(skb);
+
+	ret = batadv_mcast_forw_push_tvlvs(bat_priv, skb, vid, is_routable,
+					   count, &tvlv_len);
+	if (ret < 0)
+		goto err;
+
+	ret = batadv_mcast_forw_push_hdr(skb, tvlv_len);
+	if (ret < 0)
+		goto err;
+
+	return true;
+
+err:
+	if (tvlv_len)
+		skb_pull(skb, tvlv_len);
+
+	return false;
+}
+
+/**
+ * batadv_mcast_forw_mcsend() - send a self prepared batman-adv multicast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to encapsulate and send
+ *
+ * Transmits a batman-adv multicast packet that was locally prepared and
+ * consumes/frees it.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure. NET_XMIT_SUCCESS
+ * otherwise.
+ */
+int batadv_mcast_forw_mcsend(struct batadv_priv *bat_priv,
+			     struct sk_buff *skb)
+{
+	int ret = batadv_mcast_forw_packet(bat_priv, skb, true);
+
+	if (ret < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	consume_skb(skb);
+	return NET_XMIT_SUCCESS;
+}
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1b0e2c59aef2..89c51b3cf430 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -301,12 +301,13 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
-			forw_mode = batadv_mcast_forw_mode(bat_priv, skb,
+			forw_mode = batadv_mcast_forw_mode(bat_priv, skb, vid,
 							   &mcast_is_routable);
 			switch (forw_mode) {
 			case BATADV_FORW_BCAST:
 				break;
 			case BATADV_FORW_UCASTS:
+			case BATADV_FORW_MCAST:
 				do_bcast = false;
 				break;
 			case BATADV_FORW_NONE:
@@ -365,6 +366,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		} else if (forw_mode == BATADV_FORW_UCASTS) {
 			ret = batadv_mcast_forw_send(bat_priv, skb, vid,
 						     mcast_is_routable);
+		} else if (forw_mode == BATADV_FORW_MCAST) {
+			ret = batadv_mcast_forw_mcsend(bat_priv, skb);
 		} else {
 			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
 								  skb))
@@ -762,6 +765,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
+	atomic_set(&bat_priv->mcast.num_no_mc_ptype_capa, 0);
 #endif
 	atomic_set(&bat_priv->gw.mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 850b184e5b04..00840d5784fe 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1342,6 +1342,12 @@ struct batadv_priv_mcast {
 	/** @num_want_all_rtr6: counter for items in want_all_rtr6_list */
 	atomic_t num_want_all_rtr6;
 
+	/**
+	 * @num_no_mc_ptype_capa: counter for number of nodes without the
+	 *  BATADV_MCAST_HAVE_MC_PTYPE_CAPA flag
+	 */
+	atomic_t num_no_mc_ptype_capa;
+
 	/**
 	 * @want_lists_lock: lock for protecting modifications to mcasts
 	 *  want_all_{unsnoopables,ipv4,ipv6}_list (traversals are rcu-locked)
-- 
2.39.2


