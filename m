Return-Path: <netdev+bounces-166613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F82A36938
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E278170F6C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD881FDE19;
	Fri, 14 Feb 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAnucAQa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0281FDE12
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577129; cv=none; b=F7mRfKpEwhMBqaojGtrjgeZTKgRACkvd/kNKSDTl3xIcxvZrkSTvv/4GhAYZG1mlPHRB/aRBY7AtbE6sqGZsOUstvb9Vw1b6YR3LzM0sqPdhdYQ4uJKB9BUNZwGsWb2pFAWMyRWho6aDSbtSxHCgBtPNRJ4cMj+yjzHB4zNlHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577129; c=relaxed/simple;
	bh=SFjvlXEzJ94s/NAKA9PgRi0g+lTx0tWm3rxEGLipXPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGLMmXpYO6W0vWfPGPoR9Kj1WtIleP/r/LtI/GoSBLT/0giMCHNhE4jpmDJ2bWgwMo8pSw9uU507LgFNxJCbOfCZBmZuZwxCfhGS8ZdNyER9DE9/OqY8A3JjzITfDXJmvOSs1VucQpiUNyKsuUE7+xHmLOLVaBPfDDJZRjB9UDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAnucAQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A0C4CED1;
	Fri, 14 Feb 2025 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739577129;
	bh=SFjvlXEzJ94s/NAKA9PgRi0g+lTx0tWm3rxEGLipXPM=;
	h=From:To:Cc:Subject:Date:From;
	b=LAnucAQaHV6+Yff5hDuIElEJqOem+fvpQQxn05CrnGwiJ9lkVzq7XfsJ/1juw2rkd
	 yqjhkPin5DNUeriv8LGxNHZj52T5cu7pZ5E9Av1fPuQ8QVcM50Rcs97Qxtis+1r5cf
	 IF7utHK2bnGH5DWcDMBfGOd6WBfzQMIcxjE+2FY1oRxF77I07tGaHmybgGjzL/Ikrs
	 s6Uovpa8QCUHoBY0eRFFGRKKiBZhkCRvUgZky6j+oM6gymuSaCDJC5W91zjOKaCc1N
	 5ahkAOHCxp2uo/44FXq4/B+Gs/EPqz2BXgrqKc1C726Rea/P00nm0uLFTJtpfDaKTC
	 q07Tu78qZIu3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	jdamato@fastly.com
Subject: [PATCH net-next v2] eth: fbnic: support TCP segmentation offload
Date: Fri, 14 Feb 2025 15:52:07 -0800
Message-ID: <20250214235207.2312352-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TSO support to the driver. Device can handle unencapsulated or
IPv6-in-IPv6 packets. Any other tunnel stacks are handled with
GSO partial.

Validate that the packet can be offloaded in ndo_features_check.
Main thing we need to check for is that the header geometry can
be expressed in the decriptor fields (offsets aren't too large).

Report number of TSO super-packets via the qstat API.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - checkpatch -> whitespace
v1: https://lore.kernel.org/20250213005540.1345735-1-kuba@kernel.org

CC: alexanderduyck@fb.com
CC: jdamato@fastly.com
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   1 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  25 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 144 +++++++++++++++++-
 4 files changed, 162 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index a392ac1cc4f2..4c907e7d7b24 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -13,6 +13,9 @@
 
 #define FBNIC_MAX_NAPI_VECTORS		128u
 
+/* Natively supported tunnel GSO features (not thru GSO_PARTIAL) */
+#define FBNIC_TUN_GSO_FEATURES         NETIF_F_GSO_IPXIP6
+
 struct fbnic_net {
 	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index b53a7d28ecd3..89a5c394f846 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -59,6 +59,7 @@ struct fbnic_queue_stats {
 	union {
 		struct {
 			u64 csum_partial;
+			u64 lso;
 			u64 ts_packets;
 			u64 ts_lost;
 			u64 stop;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b12672d1607e..c59f1ce8de32 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -517,7 +517,7 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct fbnic_net *fbn = netdev_priv(dev);
 	struct fbnic_ring *txr = fbn->tx[idx];
 	struct fbnic_queue_stats *stats;
-	u64 stop, wake, csum;
+	u64 stop, wake, csum, lso;
 	unsigned int start;
 	u64 bytes, packets;
 
@@ -530,13 +530,15 @@ static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
 		bytes = stats->bytes;
 		packets = stats->packets;
 		csum = stats->twq.csum_partial;
+		lso = stats->twq.lso;
 		stop = stats->twq.stop;
 		wake = stats->twq.wake;
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
-	tx->needs_csum = csum;
+	tx->needs_csum = csum + lso;
+	tx->hw_gso_wire_packets = lso;
 	tx->stop = stop;
 	tx->wake = wake;
 }
@@ -549,7 +551,8 @@ static void fbnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = fbn->tx_stats.bytes;
 	tx->packets = fbn->tx_stats.packets;
-	tx->needs_csum = fbn->tx_stats.twq.csum_partial;
+	tx->needs_csum = fbn->tx_stats.twq.csum_partial + fbn->tx_stats.twq.lso;
+	tx->hw_gso_wire_packets = fbn->tx_stats.twq.lso;
 	tx->stop = fbn->tx_stats.twq.stop;
 	tx->wake = fbn->tx_stats.twq.wake;
 
@@ -650,11 +653,25 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
+	netdev->gso_partial_features =
+		NETIF_F_GSO_GRE |
+		NETIF_F_GSO_GRE_CSUM |
+		NETIF_F_GSO_IPXIP4 |
+		NETIF_F_GSO_UDP_TUNNEL |
+		NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
 	netdev->features |=
+		netdev->gso_partial_features |
+		FBNIC_TUN_GSO_FEATURES |
 		NETIF_F_RXHASH |
 		NETIF_F_SG |
 		NETIF_F_HW_CSUM |
-		NETIF_F_RXCSUM;
+		NETIF_F_RXCSUM |
+		NETIF_F_TSO |
+		NETIF_F_TSO_ECN |
+		NETIF_F_TSO6 |
+		NETIF_F_GSO_PARTIAL |
+		NETIF_F_GSO_UDP_L4;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 24d2b528b66c..a996d7257594 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
+#include <net/tcp.h>
 
 #include "fbnic.h"
 #include "fbnic_csr.h"
@@ -18,6 +19,7 @@ enum {
 
 struct fbnic_xmit_cb {
 	u32 bytecount;
+	u16 gso_segs;
 	u8 desc_count;
 	u8 flags;
 	int hw_head;
@@ -178,9 +180,73 @@ static bool fbnic_tx_tstamp(struct sk_buff *skb)
 	return true;
 }
 
+static bool
+fbnic_tx_lso(struct fbnic_ring *ring, struct sk_buff *skb,
+	     struct skb_shared_info *shinfo, __le64 *meta,
+	     unsigned int *l2len, unsigned int *i3len)
+{
+	unsigned int l3_type, l4_type, l4len, hdrlen;
+	unsigned char *l4hdr;
+	__be16 payload_len;
+
+	if (unlikely(skb_cow_head(skb, 0)))
+		return true;
+
+	if (shinfo->gso_type & SKB_GSO_PARTIAL) {
+		l3_type = FBNIC_TWD_L3_TYPE_OTHER;
+	} else if (!skb->encapsulation) {
+		if (ip_hdr(skb)->version == 4)
+			l3_type = FBNIC_TWD_L3_TYPE_IPV4;
+		else
+			l3_type = FBNIC_TWD_L3_TYPE_IPV6;
+	} else {
+		unsigned int o3len;
+
+		o3len = skb_inner_network_header(skb) - skb_network_header(skb);
+		*i3len -= o3len;
+		*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_L3_OHLEN_MASK,
+						o3len / 2));
+		l3_type = FBNIC_TWD_L3_TYPE_V6V6;
+	}
+
+	l4hdr = skb_checksum_start(skb);
+	payload_len = cpu_to_be16(skb->len - (l4hdr - skb->data));
+
+	if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+		struct tcphdr *tcph = (struct tcphdr *)l4hdr;
+
+		l4_type = FBNIC_TWD_L4_TYPE_TCP;
+		l4len = __tcp_hdrlen((struct tcphdr *)l4hdr);
+		csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);
+	} else {
+		struct udphdr *udph = (struct udphdr *)l4hdr;
+
+		l4_type = FBNIC_TWD_L4_TYPE_UDP;
+		l4len = sizeof(struct udphdr);
+		csum_replace_by_diff(&udph->check, (__force __wsum)payload_len);
+	}
+
+	hdrlen = (l4hdr - skb->data) + l4len;
+	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_L3_TYPE_MASK, l3_type) |
+			     FIELD_PREP(FBNIC_TWD_L4_TYPE_MASK, l4_type) |
+			     FIELD_PREP(FBNIC_TWD_L4_HLEN_MASK, l4len / 4) |
+			     FIELD_PREP(FBNIC_TWD_MSS_MASK, shinfo->gso_size) |
+			     FBNIC_TWD_FLAG_REQ_LSO);
+
+	FBNIC_XMIT_CB(skb)->bytecount += (shinfo->gso_segs - 1) * hdrlen;
+	FBNIC_XMIT_CB(skb)->gso_segs = shinfo->gso_segs;
+
+	u64_stats_update_begin(&ring->stats.syncp);
+	ring->stats.twq.lso += shinfo->gso_segs;
+	u64_stats_update_end(&ring->stats.syncp);
+
+	return false;
+}
+
 static bool
 fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int l2len, i3len;
 
 	if (fbnic_tx_tstamp(skb))
@@ -195,10 +261,15 @@ fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_CSUM_OFFSET_MASK,
 					skb->csum_offset / 2));
 
-	*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_CSO);
-	u64_stats_update_begin(&ring->stats.syncp);
-	ring->stats.twq.csum_partial++;
-	u64_stats_update_end(&ring->stats.syncp);
+	if (shinfo->gso_size) {
+		if (fbnic_tx_lso(ring, skb, shinfo, meta, &l2len, &i3len))
+			return true;
+	} else {
+		*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_CSO);
+		u64_stats_update_begin(&ring->stats.syncp);
+		ring->stats.twq.csum_partial++;
+		u64_stats_update_end(&ring->stats.syncp);
+	}
 
 	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_L2_HLEN_MASK, l2len / 2) |
 			     FIELD_PREP(FBNIC_TWD_L3_IHLEN_MASK, i3len / 2));
@@ -341,7 +412,9 @@ fbnic_xmit_frame_ring(struct sk_buff *skb, struct fbnic_ring *ring)
 
 	/* Write all members within DWORD to condense this into 2 4B writes */
 	FBNIC_XMIT_CB(skb)->bytecount = skb->len;
+	FBNIC_XMIT_CB(skb)->gso_segs = 1;
 	FBNIC_XMIT_CB(skb)->desc_count = 0;
+	FBNIC_XMIT_CB(skb)->flags = 0;
 
 	if (fbnic_tx_offloads(ring, skb, meta))
 		goto err_free;
@@ -368,6 +441,59 @@ netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 	return fbnic_xmit_frame_ring(skb, fbn->tx[q_map]);
 }
 
+static netdev_features_t
+fbnic_features_check_encap_gso(struct sk_buff *skb, struct net_device *dev,
+			       netdev_features_t features, unsigned int l3len)
+{
+	netdev_features_t skb_gso_features;
+	struct ipv6hdr *ip6_hdr;
+	unsigned char l4_hdr;
+	unsigned int start;
+	__be16 frag_off;
+
+	/* Require MANGLEID for GSO_PARTIAL of IPv4.
+	 * In theory we could support TSO with single, innermost v4 header
+	 * by pretending everything before it is L2, but that needs to be
+	 * parsed case by case.. so leaving it for when the need arises.
+	 */
+	if (!(features & NETIF_F_TSO_MANGLEID))
+		features &= ~NETIF_F_TSO;
+
+	skb_gso_features = skb_shinfo(skb)->gso_type;
+	skb_gso_features <<= NETIF_F_GSO_SHIFT;
+
+	/* We'd only clear the native GSO features, so don't bother validating
+	 * if the match can only be on those supported thru GSO_PARTIAL.
+	 */
+	if (!(skb_gso_features & FBNIC_TUN_GSO_FEATURES))
+		return features;
+
+	/* We can only do IPv6-in-IPv6, not v4-in-v6. It'd be nice
+	 * to fall back to partial for this, or any failure below.
+	 * This is just an optimization, UDPv4 will be caught later on.
+	 */
+	if (skb_gso_features & NETIF_F_TSO)
+		return features & ~FBNIC_TUN_GSO_FEATURES;
+
+	/* Inner headers multiple of 2 */
+	if ((skb_inner_network_header(skb) - skb_network_header(skb)) % 2)
+		return features & ~FBNIC_TUN_GSO_FEATURES;
+
+	/* Encapsulated GSO packet, make 100% sure it's IPv6-in-IPv6. */
+	ip6_hdr = ipv6_hdr(skb);
+	if (ip6_hdr->version != 6)
+		return features & ~FBNIC_TUN_GSO_FEATURES;
+
+	l4_hdr = ip6_hdr->nexthdr;
+	start = (unsigned char *)ip6_hdr - skb->data + sizeof(struct ipv6hdr);
+	start = ipv6_skip_exthdr(skb, start, &l4_hdr, &frag_off);
+	if (frag_off || l4_hdr != IPPROTO_IPV6 ||
+	    skb->data + start != skb_inner_network_header(skb))
+		return features & ~FBNIC_TUN_GSO_FEATURES;
+
+	return features;
+}
+
 netdev_features_t
 fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
 		     netdev_features_t features)
@@ -390,7 +516,10 @@ fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
 	    !FIELD_FIT(FBNIC_TWD_CSUM_OFFSET_MASK, skb->csum_offset / 2))
 		return features & ~NETIF_F_CSUM_MASK;
 
-	return features;
+	if (likely(!skb->encapsulation) || !skb_is_gso(skb))
+		return features;
+
+	return fbnic_features_check_encap_gso(skb, dev, features, l3len);
 }
 
 static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
@@ -441,7 +570,7 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 		}
 
 		total_bytes += FBNIC_XMIT_CB(skb)->bytecount;
-		total_packets += 1;
+		total_packets += FBNIC_XMIT_CB(skb)->gso_segs;
 
 		napi_consume_skb(skb, napi_budget);
 	}
@@ -1105,12 +1234,13 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 	fbn->tx_stats.packets += stats->packets;
 	fbn->tx_stats.dropped += stats->dropped;
 	fbn->tx_stats.twq.csum_partial += stats->twq.csum_partial;
+	fbn->tx_stats.twq.lso += stats->twq.lso;
 	fbn->tx_stats.twq.ts_lost += stats->twq.ts_lost;
 	fbn->tx_stats.twq.ts_packets += stats->twq.ts_packets;
 	fbn->tx_stats.twq.stop += stats->twq.stop;
 	fbn->tx_stats.twq.wake += stats->twq.wake;
 	/* Remember to add new stats here */
-	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 5);
+	BUILD_BUG_ON(sizeof(fbn->tx_stats.twq) / 8 != 6);
 }
 
 static void fbnic_remove_tx_ring(struct fbnic_net *fbn,
-- 
2.48.1


