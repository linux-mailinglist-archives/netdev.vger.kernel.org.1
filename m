Return-Path: <netdev+bounces-141843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578189BC828
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFDA1F23F61
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD361D174C;
	Tue,  5 Nov 2024 08:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63581D041D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795915; cv=none; b=oaIJXl2DByiaJT8Yr/YU7UbGuVAbypCKDjDvpWvYn6Q46JhMnwN+tu9xEWsiEYTi7B2xE5ZWkc1SaJPl3ovOPPGNHceCWg4Ab+iO1zfIvA7Yb0EVMMj4AWxpdnt+N9TeUcrxj0wieogJNfTXaGqnU5e59RUmhFF8Ol1A5fvAxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795915; c=relaxed/simple;
	bh=lXPemkS2pBn2l9QeXP61u3f7CUCcS3m3ez6qf8L8FZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrUDu2K4fBTFgQ0MqslDVIZPBb8h4CNwg7nmO5ZQb3UNqqSKZ8rhYXbtT1/aobrmLBJtXHH4uw3bMNBVISTxxp1k6FsFTE1fo3+57tPrHYqXoUixZSUKV1hmPO6QHquo6i3H+FyC6GLQ1iIqFEfxED72q6qmxVxIrcJOncnppEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id EB8737D12E;
	Tue,  5 Nov 2024 08:38:30 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v13 07/15] xfrm: iptfs: add user packet (tunnel ingress) handling
Date: Tue,  5 Nov 2024 03:37:51 -0500
Message-ID: <20241105083759.2172771-8-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105083759.2172771-1-chopps@chopps.org>
References: <20241105083759.2172771-1-chopps@chopps.org>
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
 net/xfrm/xfrm_iptfs.c | 563 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 560 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index e7cb8734fc0f..c4cff005ea9a 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -19,29 +19,541 @@
 
 #include "xfrm_inout.h"
 
+/* ------------------------------------------------ */
+/* IPTFS default SA values (tunnel ingress/dir-out) */
+/* ------------------------------------------------ */
+
+/**
+ * define IPTFS_DEFAULT_INIT_DELAY_USECS - default initial output delay
+ *
+ * The initial output delay is the amount of time prior to servicing the output
+ * queue after queueing the first packet on said queue. This applies anytime the
+ * output queue was previously empty.
+ *
+ * Default 0.
+ */
+#define IPTFS_DEFAULT_INIT_DELAY_USECS 0
+
+/**
+ * define IPTFS_DEFAULT_MAX_QUEUE_SIZE - default max output queue size.
+ *
+ * The default IPTFS max output queue size in octets. The output queue is where
+ * received packets destined for output over an IPTFS tunnel are stored prior to
+ * being output in aggregated/fragmented form over the IPTFS tunnel.
+ *
+ * Default 1M.
+ */
+#define IPTFS_DEFAULT_MAX_QUEUE_SIZE (1024 * 10240)
+
+#define NSECS_IN_USEC 1000
+
+#define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
+
 /**
  * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
  * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
  *	otherwise the user specified value.
+ * @max_queue_size: The maximum number of octets allowed to be queued to be sent
+ *	over the IPTFS SA. The queue size is measured as the size of all the
+ *	packets enqueued.
  */
 struct xfrm_iptfs_config {
 	u32 pkt_size;	    /* outer_packet_size or 0 */
+	u32 max_queue_size; /* octets */
 };
 
 /**
  * struct xfrm_iptfs_data - mode specific xfrm state.
  * @cfg: IPTFS tunnel config.
  * @x: owning SA (xfrm_state).
+ * @queue: queued user packets to send.
+ * @queue_size: number of octets on queue (sum of packet sizes).
+ * @ecn_queue_size: octets above with ECN mark.
+ * @init_delay_ns: nanoseconds to wait to send initial IPTFS packet.
+ * @iptfs_timer: output timer.
  * @payload_mtu: max payload size.
  */
 struct xfrm_iptfs_data {
 	struct xfrm_iptfs_config cfg;
 
 	/* Ingress User Input */
-	struct xfrm_state *x;	    /* owning state */
+	struct xfrm_state *x;	   /* owning state */
+	struct sk_buff_head queue; /* output queue */
+
+	u32 queue_size;		    /* octets */
+	u32 ecn_queue_size;	    /* octets above which ECN mark */
+	u64 init_delay_ns;	    /* nanoseconds */
+	struct hrtimer iptfs_timer; /* output timer */
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
+static int iptfs_get_cur_pmtu(struct xfrm_state *x, struct xfrm_iptfs_data *xtfs,
+			      struct sk_buff *skb)
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
+	if (sk)
+		xfrm_local_error(skb, pmtu);
+	else if (ip_hdr(skb)->version == 4)
+		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(pmtu));
+	else
+		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, pmtu);
+
+	return 1;
+}
+
+/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
+ * (i.e., aggregating or fragmenting as appropriate).
+ * This is set in dst->output for an SA.
+ */
+static int iptfs_output_collect(struct net *net, struct sock *sk, struct sk_buff *skb)
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
+			if (IS_ERR(segs))
+				return PTR_ERR(segs);
+			return -EINVAL;
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
+	skb_list_walk_safe(segs, skb, nskb) {
+		skb_mark_not_on_list(skb);
+
+		/* Once we drop due to no queue space we continue to drop the
+		 * rest of the packets from that GRO.
+		 */
+		if (!ok) {
+nospace:
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTNOQSPACE);
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
+	if (!hrtimer_is_queued(&xtfs->iptfs_timer))
+		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns, IPTFS_HRTIMER_MODE);
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
+static struct sk_buff **iptfs_rehome_fraglist(struct sk_buff **nextp, struct sk_buff *child)
+{
+	u32 fllen = 0;
+
+	/* It might be possible to account for a frag list in addition to page
+	 * fragment if it's a valid state to be in. The page fragments size
+	 * should be kept as data_len so only the frag_list size is removed,
+	 * this must be done above as well.
+	 */
+	*nextp = skb_shinfo(child)->frag_list;
+	while (*nextp) {
+		fllen += (*nextp)->len;
+		nextp = &(*nextp)->next;
+	}
+	skb_frag_list_init(child);
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
+		skb->protocol = x->outer_mode.family == AF_INET ? htons(ETH_P_IP) :
+								  htons(ETH_P_IPV6);
+
+		if (skb->len > mtu) {
+			/* We handle this case before enqueueing so we are only
+			 * here b/c MTU changed after we enqueued before we
+			 * dequeued, just drop these.
+			 */
+			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTERROR);
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
+				XFRM_INC_STATS(dev_net(skb_dst(skb)->dev), LINUX_MIB_XFRMOUTERROR);
+				kfree_skb(skb);
+				continue;
+			}
+		}
+
+		/* Consider the buffer Tx'd and no longer owned */
+		skb_orphan(skb);
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
+				nextp = iptfs_rehome_fraglist(&(*nextp)->next, *nextp);
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
+			/* Consider the buffer Tx'd and no longer owned */
+			skb_orphan(skb);
+
+			/* If we don't have a cksum in the packet we need to add
+			 * one before encapsulation.
+			 */
+			if (skb2->ip_summed == CHECKSUM_PARTIAL) {
+				if (skb_checksum_help(skb2)) {
+					XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTERROR);
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
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+static int iptfs_encap_add_ipv4(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct iphdr *top_iph;
+
+	skb_reset_inner_network_header(skb);
+	skb_reset_inner_transport_header(skb);
+
+	skb_set_network_header(skb, -(x->props.header_len - x->props.enc_hdr_len));
+	skb->mac_header = skb->network_header + offsetof(struct iphdr, protocol);
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
+#if IS_ENABLED(CONFIG_IPV6)
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
+ *
+ * Return: 0 on success or a negative error code on failure
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
+	skb_set_network_header(skb, -x->props.header_len + x->props.enc_hdr_len);
+	skb->mac_header = skb->network_header + offsetof(struct ipv6hdr, nexthdr);
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
+#endif
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
+		return -EAFNOSUPPORT;
+#endif
+	}
+	return -EOPNOTSUPP;
+}
+
 /* ========================== */
 /* State Management Functions */
 /* ========================== */
@@ -77,8 +589,11 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 {
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
 	struct xfrm_iptfs_config *xc;
+	u64 q;
 
 	xc = &xtfs->cfg;
+	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
+	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
 
 	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
 		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
@@ -92,6 +607,16 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
 			return -EINVAL;
 		}
 	}
+	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
+		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
+	if (attrs[XFRMA_IPTFS_INIT_DELAY])
+		xtfs->init_delay_ns =
+			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) * NSECS_IN_USEC;
+
+	q = (u64)xc->max_queue_size * 95;
+	do_div(q, 100);
+	xtfs->ecn_queue_size = (u32)q;
+
 	return 0;
 }
 
@@ -101,8 +626,11 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
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
@@ -112,9 +640,21 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
 	struct xfrm_iptfs_config *xc = &xtfs->cfg;
 	int ret = 0;
+	u64 q;
+
+	if (x->dir == XFRM_SA_DIR_OUT) {
+		q = xtfs->init_delay_ns;
+		do_div(q, NSECS_IN_USEC);
+		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, xc->max_queue_size);
+		if (ret)
+			return ret;
 
-	if (x->dir == XFRM_SA_DIR_OUT)
 		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
+	}
 
 	return ret;
 }
@@ -122,6 +662,10 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 static void __iptfs_init_state(struct xfrm_state *x,
 			       struct xfrm_iptfs_data *xtfs)
 {
+	__skb_queue_head_init(&xtfs->queue);
+	hrtimer_init(&xtfs->iptfs_timer, CLOCK_MONOTONIC, IPTFS_HRTIMER_MODE);
+	xtfs->iptfs_timer.function = iptfs_delay_timer;
+
 	/* Modify type (esp) adjustment values */
 
 	if (x->props.family == AF_INET)
@@ -172,10 +716,21 @@ static int iptfs_init_state(struct xfrm_state *x)
 static void iptfs_destroy_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs = x->mode_data;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
 
 	if (!xtfs)
 		return;
 
+	spin_lock_bh(&xtfs->x->lock);
+	hrtimer_cancel(&xtfs->iptfs_timer);
+	__skb_queue_head_init(&list);
+	skb_queue_splice_init(&xtfs->queue, &list);
+	spin_unlock_bh(&xtfs->x->lock);
+
+	while ((skb = __skb_dequeue(&list)))
+		kfree_skb(skb);
+
 	kfree_sensitive(xtfs);
 
 	module_put(x->mode_cbs->owner);
@@ -190,6 +745,8 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.copy_to_user = iptfs_copy_to_user,
 	.sa_len = iptfs_sa_len,
 	.get_inner_mtu = iptfs_get_inner_mtu,
+	.output = iptfs_output_collect,
+	.prepare_output = iptfs_prepare_output,
 };
 
 static int __init xfrm_iptfs_init(void)
-- 
2.47.0


