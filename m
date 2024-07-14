Return-Path: <netdev+bounces-111386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A13AB930B92
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E721F229ED
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE8143895;
	Sun, 14 Jul 2024 20:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137A13DB88
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988632; cv=none; b=pC2ghgKEeNtb9PB/JYtb/9gKfw9mqA3JjwPKLPgbA8UHciB66sK8ijQl4n/tkeBYqN7VwGs5J4g7vSR8HRK6AQ/L695iJ2ItSLcjYcVnvy9Kgz7LcSc/XeauQSQ9AAKQOjijj01fNEusqI9opIe7RnqAjfJCFCQ+F1OG8Ukiqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988632; c=relaxed/simple;
	bh=xooh9eEQlESjwLTTACbWCTwZGe07Mfp9trbE0p6OEss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fycHoVnnQ5QzB4nLDbLYBnziY2Z3+YIW1mPmzyqs2eaSaOZfjdP/5E/IkIq2lnFrWKAKkI9hncitcYx0A4TjLrrYXbL9qpx+9Q1Mu8pNnd7tbAuAVWc6MZSt7N/NPQgj5hxVibNqa1e8p/ejvZKvzEkQNtvLnV+hhoeAcY2iH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0708B7D129;
	Sun, 14 Jul 2024 20:23:49 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user packet (tunnel ingress) handling
Date: Sun, 14 Jul 2024 16:22:37 -0400
Message-ID: <20240714202246.1573817-10-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714202246.1573817-1-chopps@chopps.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add tunnel packet output functionality. This is code handles
the ingress to the tunnel.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 535 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 532 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 414035a7a208..82c9027b85f1 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -19,8 +19,13 @@
 
 #include "xfrm_inout.h"
 
+#define NSECS_IN_USEC 1000
+
+#define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
+
 struct xfrm_iptfs_config {
 	u32 pkt_size;	    /* outer_packet_size or 0 */
+	u32 max_queue_size; /* octets */
 };
 
 struct xfrm_iptfs_data {
@@ -28,9 +33,498 @@ struct xfrm_iptfs_data {
 
 	/* Ingress User Input */
 	struct xfrm_state *x;	    /* owning state */
+	struct sk_buff_head queue;  /* output queue */
+	u32 queue_size;		    /* octets */
+	u32 ecn_queue_size;	    /* octets above which ECN mark */
+	u64 init_delay_ns;	    /* nanoseconds */
+	struct hrtimer iptfs_timer; /* output timer */
+	time64_t iptfs_settime;	    /* time timer was set */
 	u32 payload_mtu;	    /* max payload size */
 };
 
+static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
+static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
+
+/* ================================= */
+/* IPTFS Sending (ingress) Functions */
+/* ================================= */
+
+/* ------------------------- */
+/* Enqueue to send functions */
+/* ------------------------- */
+
+/**
+ * iptfs_enqueue() - enqueue packet if ok to send.
+ * @xtfs: xtfs state
+ * @skb: the packet
+ *
+ * Return: true if packet enqueued.
+ */
+static bool iptfs_enqueue(struct xfrm_iptfs_data *xtfs, struct sk_buff *skb)
+{
+	u64 newsz = xtfs->queue_size + skb->len;
+	struct iphdr *iph;
+
+	assert_spin_locked(&xtfs->x->lock);
+
+	if (newsz > xtfs->cfg.max_queue_size)
+		return false;
+
+	/* Set ECN CE if we are above our ECN queue threshold */
+	if (newsz > xtfs->ecn_queue_size) {
+		iph = ip_hdr(skb);
+		if (iph->version == 4)
+			IP_ECN_set_ce(iph);
+		else if (iph->version == 6)
+			IP6_ECN_set_ce(skb, ipv6_hdr(skb));
+	}
+
+	__skb_queue_tail(&xtfs->queue, skb);
+	xtfs->queue_size += skb->len;
+	return true;
+}
+
+static int iptfs_get_cur_pmtu(struct xfrm_state *x,
+			      struct xfrm_iptfs_data *xtfs, struct sk_buff *skb)
+{
+	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
+	u32 payload_mtu = xtfs->payload_mtu;
+	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
+
+	if (payload_mtu && payload_mtu < pmtu)
+		pmtu = payload_mtu;
+
+	return pmtu;
+}
+
+static int iptfs_is_too_big(struct sock *sk, struct sk_buff *skb, u32 pmtu)
+{
+	if (skb->len <= pmtu)
+		return 0;
+
+	/* We only send ICMP too big if the user has configured us as
+	 * dont-fragment.
+	 */
+	if (skb->dev)
+		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
+
+	if (sk) {
+		xfrm_local_error(skb, pmtu);
+	} else if (ip_hdr(skb)->version == 4) {
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
+			  htonl(pmtu));
+	} else {
+		WARN_ON_ONCE(ip_hdr(skb)->version != 6);
+		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, pmtu);
+	}
+	return 1;
+}
+
+/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
+ * (i.e., aggregating or fragmenting as appropriate).
+ * This is set in dst->output for an SA.
+ */
+static int iptfs_output_collect(struct net *net, struct sock *sk,
+				struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct xfrm_state *x = dst->xfrm;
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct sk_buff *segs, *nskb;
+	u32 pmtu = 0;
+	bool ok = true;
+	bool was_gso;
+
+	/* We have hooked into dst_entry->output which means we have skipped the
+	 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
+	 * when our timer runs we will end up calling xfrm_output directly on
+	 * the encapsulated traffic.
+	 *
+	 * For both cases this is the NF_INET_POST_ROUTING hook which allows
+	 * changing the skb->dst entry which then may not be xfrm based anymore
+	 * in which case a REROUTED flag is set. and dst_output is called.
+	 *
+	 * For IPv6 we are also skipping fragmentation handling for local
+	 * sockets, which may or may not be good depending on our tunnel DF
+	 * setting. Normally with fragmentation supported we want to skip this
+	 * fragmentation.
+	 */
+
+	BUG_ON(!xtfs);
+
+	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
+
+	/* Break apart GSO skbs. If the queue is nearing full then we want the
+	 * accounting and queuing to be based on the individual packets not on the
+	 * aggregate GSO buffer.
+	 */
+	was_gso = skb_is_gso(skb);
+	if (!was_gso) {
+		segs = skb;
+	} else {
+		segs = skb_gso_segment(skb, 0);
+		if (IS_ERR_OR_NULL(segs)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return PTR_ERR(segs);
+		}
+		consume_skb(skb);
+		skb = NULL;
+	}
+
+	/* We can be running on multiple cores and from the network softirq or
+	 * from user context depending on where the packet is coming from.
+	 */
+	spin_lock_bh(&x->lock);
+
+	skb_list_walk_safe(segs, skb, nskb)
+	{
+		skb_mark_not_on_list(skb);
+
+		/* Once we drop due to no queue space we continue to drop the
+		 * rest of the packets from that GRO.
+		 */
+		if (!ok) {
+nospace:
+			if (skb->dev)
+				XFRM_INC_STATS(dev_net(skb->dev),
+					       LINUX_MIB_XFRMOUTNOQSPACE);
+			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
+			continue;
+		}
+
+		/* Fragmenting handled in following commits. */
+		if (iptfs_is_too_big(sk, skb, pmtu)) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
+			continue;
+		}
+
+		/* Enqueue to send in tunnel */
+		ok = iptfs_enqueue(xtfs, skb);
+		if (!ok)
+			goto nospace;
+	}
+
+	/* Start a delay timer if we don't have one yet */
+	if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
+		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
+			      IPTFS_HRTIMER_MODE);
+		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
+	}
+
+	spin_unlock_bh(&x->lock);
+	return 0;
+}
+
+/* -------------------------- */
+/* Dequeue and send functions */
+/* -------------------------- */
+
+static void iptfs_output_prepare_skb(struct sk_buff *skb, u32 blkoff)
+{
+	struct ip_iptfs_hdr *h;
+	size_t hsz = sizeof(*h);
+
+	/* now reset values to be pointing at the rest of the packets */
+	h = skb_push(skb, hsz);
+	memset(h, 0, hsz);
+	if (blkoff)
+		h->block_offset = htons(blkoff);
+
+	/* network_header current points at the inner IP packet
+	 * move it to the iptfs header
+	 */
+	skb->transport_header = skb->network_header;
+	skb->network_header -= hsz;
+
+	IPCB(skb)->flags |= IPSKB_XFRM_TUNNEL_SIZE;
+}
+
+static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp,
+					      struct sk_buff *child)
+{
+	u32 fllen = 0;
+
+	/* It might be possible to account for a frag list in addition to page
+	 * fragment if it's a valid state to be in. The page fragments size
+	 * should be kept as data_len so only the frag_list size is removed,
+	 * this must be done above as well.
+	 */
+	BUG_ON(skb_shinfo(child)->nr_frags);
+	*nextp = skb_shinfo(child)->frag_list;
+	while (*nextp) {
+		fllen += (*nextp)->len;
+		nextp = &(*nextp)->next;
+	}
+	skb_frag_list_init(child);
+	BUG_ON(fllen > child->data_len);
+	child->len -= fllen;
+	child->data_len -= fllen;
+
+	return nextp;
+}
+
+static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct sk_buff *skb, *skb2, **nextp;
+	struct skb_shared_info *shi;
+
+	while ((skb = __skb_dequeue(list))) {
+		u32 mtu = iptfs_get_cur_pmtu(x, xtfs, skb);
+		int remaining;
+
+		/* protocol comes to us cleared sometimes */
+		skb->protocol = x->outer_mode.family == AF_INET ?
+					      htons(ETH_P_IP) :
+					      htons(ETH_P_IPV6);
+
+		if (skb->len > mtu) {
+			/* We handle this case before enqueueing so we are only
+			 * here b/c MTU changed after we enqueued before we
+			 * dequeued, just drop these.
+			 */
+			if (skb->dev)
+				XFRM_INC_STATS(dev_net(skb->dev),
+					       LINUX_MIB_XFRMOUTERROR);
+
+			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
+			continue;
+		}
+
+		/* If we don't have a cksum in the packet we need to add one
+		 * before encapsulation.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			if (skb_checksum_help(skb)) {
+				XFRM_INC_STATS(dev_net(skb_dst(skb)->dev),
+					       LINUX_MIB_XFRMOUTERROR);
+				kfree_skb(skb);
+				continue;
+			}
+		}
+
+		/* Convert first inner packet into an outer IPTFS packet */
+		iptfs_output_prepare_skb(skb, 0);
+
+		/* The space remaining to send more inner packet data is `mtu` -
+		 * (skb->len - sizeof iptfs header). This is b/c the `mtu` value
+		 * has the basic IPTFS header len accounted for, and we added
+		 * that header to the skb so it is a part of skb->len, thus we
+		 * subtract it from the skb length.
+		 */
+		remaining = mtu - (skb->len - sizeof(struct ip_iptfs_hdr));
+
+		/* Re-home (un-nest) nested fragment lists. We need to do this
+		 * b/c we will simply be appending any following aggregated
+		 * inner packets to the frag list.
+		 */
+		shi = skb_shinfo(skb);
+		nextp = &shi->frag_list;
+		while (*nextp) {
+			if (skb_has_frag_list(*nextp))
+				nextp = iptfs_rehome_fraglist(&(*nextp)->next,
+							      *nextp);
+			else
+				nextp = &(*nextp)->next;
+		}
+
+		/* See if we have enough space to simply append.
+		 *
+		 * NOTE: Maybe do not append if we will be mis-aligned,
+		 * SW-based endpoints will probably have to copy in this
+		 * case.
+		 */
+		while ((skb2 = skb_peek(list))) {
+			if (skb2->len > remaining)
+				break;
+
+			__skb_unlink(skb2, list);
+
+			/* If we don't have a cksum in the packet we need to add
+			 * one before encapsulation.
+			 */
+			if (skb2->ip_summed == CHECKSUM_PARTIAL) {
+				if (skb_checksum_help(skb2)) {
+					XFRM_INC_STATS(
+						dev_net(skb_dst(skb2)->dev),
+						LINUX_MIB_XFRMOUTERROR);
+					kfree_skb(skb2);
+					continue;
+				}
+			}
+
+			/* Do accounting */
+			skb->data_len += skb2->len;
+			skb->len += skb2->len;
+			remaining -= skb2->len;
+
+			/* Append to the frag_list */
+			*nextp = skb2;
+			nextp = &skb2->next;
+			BUG_ON(*nextp);
+			if (skb_has_frag_list(skb2))
+				nextp = iptfs_rehome_fraglist(nextp, skb2);
+			skb->truesize += skb2->truesize;
+		}
+
+		xfrm_output(NULL, skb);
+	}
+}
+
+static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
+{
+	struct sk_buff_head list;
+	struct xfrm_iptfs_data *xtfs;
+	struct xfrm_state *x;
+	time64_t settime;
+
+	xtfs = container_of(me, typeof(*xtfs), iptfs_timer);
+	x = xtfs->x;
+
+	/* Process all the queued packets
+	 *
+	 * softirq execution order: timer > tasklet > hrtimer
+	 *
+	 * Network rx will have run before us giving one last chance to queue
+	 * ingress packets for us to process and transmit.
+	 */
+
+	spin_lock(&x->lock);
+	__skb_queue_head_init(&list);
+	skb_queue_splice_init(&xtfs->queue, &list);
+	xtfs->queue_size = 0;
+	settime = xtfs->iptfs_settime;
+	spin_unlock(&x->lock);
+
+	/* After the above unlock, packets can begin queuing again, and the
+	 * timer can be set again, from another CPU either in softirq or user
+	 * context (not from this one since we are running at softirq level
+	 * already).
+	 */
+
+	iptfs_output_queued(x, &list);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * iptfs_encap_add_ipv4() - add outer encaps
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * This was originally taken from xfrm4_tunnel_encap_add. The reason for the
+ * copy is that IP-TFS/AGGFRAG can have different functionality for how to set
+ * the TOS/DSCP bits. Sets the protocol to a different value and doesn't do
+ * anything with inner headers as they aren't pointing into a normal IP
+ * singleton inner packet.
+ */
+static int iptfs_encap_add_ipv4(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct iphdr *top_iph;
+
+	skb_reset_inner_network_header(skb);
+	skb_reset_inner_transport_header(skb);
+
+	skb_set_network_header(skb,
+			       -(x->props.header_len - x->props.enc_hdr_len));
+	skb->mac_header =
+		skb->network_header + offsetof(struct iphdr, protocol);
+	skb->transport_header = skb->network_header + sizeof(*top_iph);
+
+	top_iph = ip_hdr(skb);
+	top_iph->ihl = 5;
+	top_iph->version = 4;
+	top_iph->protocol = IPPROTO_AGGFRAG;
+
+	/* As we have 0, fractional, 1 or N inner packets there's no obviously
+	 * correct DSCP mapping to inherit. ECN should be cleared per RFC9347
+	 * 3.1.
+	 */
+	top_iph->tos = 0;
+
+	top_iph->frag_off = htons(IP_DF);
+	top_iph->ttl = ip4_dst_hoplimit(xfrm_dst_child(dst));
+	top_iph->saddr = x->props.saddr.a4;
+	top_iph->daddr = x->id.daddr.a4;
+	ip_select_ident(dev_net(dst->dev), skb, NULL);
+
+	return 0;
+}
+
+/**
+ * iptfs_encap_add_ipv6() - add outer encaps
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * This was originally taken from xfrm6_tunnel_encap_add. The reason for the
+ * copy is that IP-TFS/AGGFRAG can have different functionality for how to set
+ * the flow label and TOS/DSCP bits. It also sets the protocol to a different
+ * value and doesn't do anything with inner headers as they aren't pointing into
+ * a normal IP singleton inner packet.
+ */
+static int iptfs_encap_add_ipv6(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct ipv6hdr *top_iph;
+	int dsfield;
+
+	skb_reset_inner_network_header(skb);
+	skb_reset_inner_transport_header(skb);
+
+	skb_set_network_header(skb,
+			       -x->props.header_len + x->props.enc_hdr_len);
+	skb->mac_header =
+		skb->network_header + offsetof(struct ipv6hdr, nexthdr);
+	skb->transport_header = skb->network_header + sizeof(*top_iph);
+
+	top_iph = ipv6_hdr(skb);
+	top_iph->version = 6;
+	top_iph->priority = 0;
+	memset(top_iph->flow_lbl, 0, sizeof(top_iph->flow_lbl));
+	top_iph->nexthdr = IPPROTO_AGGFRAG;
+
+	/* As we have 0, fractional, 1 or N inner packets there's no obviously
+	 * correct DSCP mapping to inherit. ECN should be cleared per RFC9347
+	 * 3.1.
+	 */
+	dsfield = 0;
+	ipv6_change_dsfield(top_iph, 0, dsfield);
+
+	top_iph->hop_limit = ip6_dst_hoplimit(xfrm_dst_child(dst));
+	top_iph->saddr = *(struct in6_addr *)&x->props.saddr;
+	top_iph->daddr = *(struct in6_addr *)&x->id.daddr;
+
+	return 0;
+}
+
+/**
+ * iptfs_prepare_output() -  prepare the skb for output
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * Return: Error value, if 0 then skb values should be as follows:
+ *    - transport_header should point at ESP header
+ *    - network_header should point at Outer IP header
+ *    - mac_header should point at protocol/nexthdr of the outer IP
+ */
+static int iptfs_prepare_output(struct xfrm_state *x, struct sk_buff *skb)
+{
+	if (x->outer_mode.family == AF_INET)
+		return iptfs_encap_add_ipv4(x, skb);
+	if (x->outer_mode.family == AF_INET6) {
+#if IS_ENABLED(CONFIG_IPV6)
+		return iptfs_encap_add_ipv6(x, skb);
+#else
+		WARN_ON_ONCE(1);
+		return -EAFNOSUPPORT;
+#endif
+	}
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+
 /* ========================== */
 /* State Management Functions */
 /* ========================== */
@@ -66,6 +560,9 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 	struct xfrm_iptfs_config *xc;
 
 	xc = &xtfs->cfg;
+	xc->max_queue_size = net->xfrm.sysctl_iptfs_max_qsize;
+	xtfs->init_delay_ns =
+		(u64)net->xfrm.sysctl_iptfs_init_delay * NSECS_IN_USEC;
 
 	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
 		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
@@ -79,6 +576,15 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 			return -EINVAL;
 		}
 	}
+	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
+		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
+	if (attrs[XFRMA_IPTFS_INIT_DELAY])
+		xtfs->init_delay_ns =
+			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
+			NSECS_IN_USEC;
+
+	xtfs->ecn_queue_size = (u64)xc->max_queue_size * 95 / 100;
+
 	return 0;
 }
 
@@ -88,8 +594,11 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 	struct xfrm_iptfs_config *xc = &xtfs->cfg;
 	unsigned int l = 0;
 
-	if (x->dir == XFRM_SA_DIR_OUT)
+	if (x->dir == XFRM_SA_DIR_OUT) {
+		l += nla_total_size(sizeof(u32)); /* init delay usec */
+		l += nla_total_size(sizeof(xc->max_queue_size));
 		l += nla_total_size(sizeof(xc->pkt_size));
+	}
 
 	return l;
 }
@@ -98,10 +607,23 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 {
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
 	struct xfrm_iptfs_config *xc = &xtfs->cfg;
-	int ret = 0;
+	int ret;
+	u64 q;
+
+	if (x->dir == XFRM_SA_DIR_OUT) {
+		q = xtfs->init_delay_ns;
+		(void)do_div(q, NSECS_IN_USEC);
+		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
+				  xc->max_queue_size);
+		if (ret)
+			return ret;
 
-	if (x->dir == XFRM_SA_DIR_OUT)
 		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
+	}
 
 	return ret;
 }
@@ -109,6 +631,10 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 static int __iptfs_init_state(struct xfrm_state *x,
 			      struct xfrm_iptfs_data *xtfs)
 {
+	__skb_queue_head_init(&xtfs->queue);
+	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
+	xtfs->iptfs_timer.function = iptfs_delay_timer;
+
 	/* Modify type (esp) adjustment values */
 
 	if (x->props.family == AF_INET)
@@ -166,6 +692,7 @@ static void iptfs_delete_state(struct xfrm_state *x)
 	if (!xtfs)
 		return;
 
+	hrtimer_cancel(&xtfs->iptfs_timer);
 	kfree_sensitive(xtfs);
 
 	module_put(x->mode_cbs->owner);
@@ -180,6 +707,8 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.sa_len = iptfs_sa_len,
 	.clone = iptfs_clone,
 	.get_inner_mtu = iptfs_get_inner_mtu,
+	.output = iptfs_output_collect,
+	.prepare_output = iptfs_prepare_output,
 };
 
 static int __init xfrm_iptfs_init(void)
-- 
2.45.2


