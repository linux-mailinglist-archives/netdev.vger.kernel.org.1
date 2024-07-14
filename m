Return-Path: <netdev+bounces-111393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848BF930B99
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 22:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399612821D9
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF9143875;
	Sun, 14 Jul 2024 20:23:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29330143C67
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988635; cv=none; b=tCLEjX0bgKZ3FLb/1wOd8rS7j/R48CWRSCEhxy4/CATkS7G7vWuwBNP9gTZZhFggX2kpR+070C7DAHavK1nYFDcubVYshIh9wJP+MLPl95vYm92REFQQGuoThWF8gg6vtyqw+rAwcGFNp2zLAaXl9+97ekJnjOGcujknEgUY3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988635; c=relaxed/simple;
	bh=aQhm2Z1jctNsS9B+Hza+MnRm3/Bs5zkVlAso+x37it8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiJGbwyGLXF+8tKFZbOy7qclQcE7cU2pZdt0YC3qV0X4QSq7978lNUZRHkvuxWl8dKN19xLsfVHXYGKedP/zhtJ/u5F1IxbzOAWd90R9fDexmDgm4vSF2Y4uLPZL7ocP/TAmfs942cLp0Kc1JPhYqwh8pAnyhAo9k5w1+yUL280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id BC3E77D03D;
	Sun, 14 Jul 2024 20:23:52 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v5 17/17] xfrm: iptfs: add tracepoint functionality
Date: Sun, 14 Jul 2024 16:22:45 -0400
Message-ID: <20240714202246.1573817-18-chopps@chopps.org>
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

Add tracepoints to the IP-TFS code.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/trace_iptfs.h | 218 +++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_iptfs.c  |  60 ++++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 net/xfrm/trace_iptfs.h

diff --git a/net/xfrm/trace_iptfs.h b/net/xfrm/trace_iptfs.h
new file mode 100644
index 000000000000..0425f051572f
--- /dev/null
+++ b/net/xfrm/trace_iptfs.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* xfrm_trace_iptfs.h
+ *
+ * August 12 2023, Christian Hopps <chopps@labn.net>
+ *
+ * Copyright (c) 2023, LabN Consulting, L.L.C.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iptfs
+
+#if !defined(_TRACE_IPTFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IPTFS_H
+
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/tracepoint.h>
+#include <net/ip.h>
+
+struct xfrm_iptfs_data;
+
+TRACE_EVENT(iptfs_egress_recv,
+	    TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs, u16 blkoff),
+	    TP_ARGS(skb, xtfs, blkoff),
+	    TP_STRUCT__entry(__field(struct sk_buff *, skb)
+			     __field(void *, head)
+			     __field(void *, head_pg_addr)
+			     __field(void *, pg0addr)
+			     __field(u32, skb_len)
+			     __field(u32, data_len)
+			     __field(u32, headroom)
+			     __field(u32, tailroom)
+			     __field(u32, tail)
+			     __field(u32, end)
+			     __field(u32, pg0off)
+			     __field(u8, head_frag)
+			     __field(u8, frag_list)
+			     __field(u8, nr_frags)
+			     __field(u16, blkoff)),
+	    TP_fast_assign(__entry->skb = skb;
+			   __entry->head = skb->head;
+			   __entry->skb_len = skb->len;
+			   __entry->data_len = skb->data_len;
+			   __entry->headroom = skb_headroom(skb);
+			   __entry->tailroom = skb_tailroom(skb);
+			   __entry->tail = skb->tail;
+			   __entry->end = skb->end;
+			   __entry->head_frag = skb->head_frag;
+			   __entry->frag_list = (bool)skb_shinfo(skb)->frag_list;
+			   __entry->nr_frags = skb_shinfo(skb)->nr_frags;
+			   __entry->blkoff = blkoff;
+			   __entry->head_pg_addr = page_address(virt_to_head_page(skb->head));
+			   __entry->pg0addr = (__entry->nr_frags
+					       ? page_address(netmem_to_page(skb_shinfo(skb)->frags[0].netmem))
+					       : NULL);
+			   __entry->pg0off = (__entry->nr_frags
+					      ? skb_shinfo(skb)->frags[0].offset
+					      : 0);
+		    ),
+	    TP_printk("EGRESS: skb=%p len=%u data_len=%u headroom=%u head_frag=%u frag_list=%u nr_frags=%u blkoff=%u\n\t\ttailroom=%u tail=%u end=%u head=%p hdpgaddr=%p pg0->addr=%p pg0->data=%p pg0->off=%u",
+		      __entry->skb, __entry->skb_len, __entry->data_len, __entry->headroom,
+		      __entry->head_frag, __entry->frag_list, __entry->nr_frags, __entry->blkoff,
+		      __entry->tailroom, __entry->tail, __entry->end, __entry->head,
+		      __entry->head_pg_addr, __entry->pg0addr, __entry->pg0addr + __entry->pg0off,
+		      __entry->pg0off)
+	)
+
+DECLARE_EVENT_CLASS(iptfs_ingress_preq_event,
+		    TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs,
+			     u32 pmtu, u8 was_gso),
+		    TP_ARGS(skb, xtfs, pmtu, was_gso),
+		    TP_STRUCT__entry(__field(struct sk_buff *, skb)
+				     __field(u32, skb_len)
+				     __field(u32, data_len)
+				     __field(u32, pmtu)
+				     __field(u32, queue_size)
+				     __field(u32, proto_seq)
+				     __field(u8, proto)
+				     __field(u8, was_gso)
+			    ),
+		    TP_fast_assign(__entry->skb = skb;
+				   __entry->skb_len = skb->len;
+				   __entry->data_len = skb->data_len;
+				   __entry->queue_size =
+					xtfs->cfg.max_queue_size - xtfs->queue_size;
+				   __entry->proto = __trace_ip_proto(ip_hdr(skb));
+				   __entry->proto_seq = __trace_ip_proto_seq(ip_hdr(skb));
+				   __entry->pmtu = pmtu;
+				   __entry->was_gso = was_gso;
+			    ),
+		    TP_printk("INGRPREQ: skb=%p len=%u data_len=%u qsize=%u proto=%u proto_seq=%u pmtu=%u was_gso=%u",
+			      __entry->skb, __entry->skb_len, __entry->data_len,
+			      __entry->queue_size, __entry->proto, __entry->proto_seq,
+			      __entry->pmtu, __entry->was_gso));
+
+DEFINE_EVENT(iptfs_ingress_preq_event, iptfs_enqueue,
+	     TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs, u32 pmtu, u8 was_gso),
+	     TP_ARGS(skb, xtfs, pmtu, was_gso));
+
+DEFINE_EVENT(iptfs_ingress_preq_event, iptfs_no_queue_space,
+	     TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs, u32 pmtu, u8 was_gso),
+	     TP_ARGS(skb, xtfs, pmtu, was_gso));
+
+DEFINE_EVENT(iptfs_ingress_preq_event, iptfs_too_big,
+	     TP_PROTO(struct sk_buff *skb, struct xfrm_iptfs_data *xtfs, u32 pmtu, u8 was_gso),
+	     TP_ARGS(skb, xtfs, pmtu, was_gso));
+
+DECLARE_EVENT_CLASS(iptfs_ingress_postq_event,
+		    TP_PROTO(struct sk_buff *skb, u32 mtu, u16 blkoff, struct iphdr *iph),
+		    TP_ARGS(skb, mtu, blkoff, iph),
+		    TP_STRUCT__entry(__field(struct sk_buff *, skb)
+				     __field(u32, skb_len)
+				     __field(u32, data_len)
+				     __field(u32, mtu)
+				     __field(u32, proto_seq)
+				     __field(u16, blkoff)
+				     __field(u8, proto)),
+		    TP_fast_assign(__entry->skb = skb;
+				   __entry->skb_len = skb->len;
+				   __entry->data_len = skb->data_len;
+				   __entry->mtu = mtu;
+				   __entry->blkoff = blkoff;
+				   __entry->proto = iph ? __trace_ip_proto(iph) : 0;
+				   __entry->proto_seq = iph ? __trace_ip_proto_seq(iph) : 0;
+			    ),
+		    TP_printk("INGRPSTQ: skb=%p len=%u data_len=%u mtu=%u blkoff=%u proto=%u proto_seq=%u",
+			      __entry->skb, __entry->skb_len, __entry->data_len, __entry->mtu,
+			      __entry->blkoff, __entry->proto, __entry->proto_seq));
+
+DEFINE_EVENT(iptfs_ingress_postq_event, iptfs_first_dequeue,
+	     TP_PROTO(struct sk_buff *skb, u32 mtu, u16 blkoff,
+		      struct iphdr *iph),
+	     TP_ARGS(skb, mtu, blkoff, iph));
+
+DEFINE_EVENT(iptfs_ingress_postq_event, iptfs_first_fragmenting,
+	     TP_PROTO(struct sk_buff *skb, u32 mtu, u16 blkoff,
+		      struct iphdr *iph),
+	     TP_ARGS(skb, mtu, blkoff, iph));
+
+DEFINE_EVENT(iptfs_ingress_postq_event, iptfs_first_final_fragment,
+	     TP_PROTO(struct sk_buff *skb, u32 mtu, u16 blkoff,
+		      struct iphdr *iph),
+	     TP_ARGS(skb, mtu, blkoff, iph));
+
+DEFINE_EVENT(iptfs_ingress_postq_event, iptfs_first_toobig,
+	     TP_PROTO(struct sk_buff *skb, u32 mtu, u16 blkoff,
+		      struct iphdr *iph),
+	     TP_ARGS(skb, mtu, blkoff, iph));
+
+TRACE_EVENT(iptfs_ingress_nth_peek,
+	    TP_PROTO(struct sk_buff *skb, u32 remaining),
+	    TP_ARGS(skb, remaining),
+	    TP_STRUCT__entry(__field(struct sk_buff *, skb)
+			     __field(u32, skb_len)
+			     __field(u32, remaining)),
+	    TP_fast_assign(__entry->skb = skb;
+			   __entry->skb_len = skb->len;
+			   __entry->remaining = remaining;
+		    ),
+	    TP_printk("INGRPSTQ: NTHPEEK: skb=%p len=%u remaining=%u",
+		      __entry->skb, __entry->skb_len, __entry->remaining));
+
+TRACE_EVENT(iptfs_ingress_nth_add, TP_PROTO(struct sk_buff *skb, u8 share_ok),
+	    TP_ARGS(skb, share_ok),
+	    TP_STRUCT__entry(__field(struct sk_buff *, skb)
+			     __field(u32, skb_len)
+			     __field(u32, data_len)
+			     __field(u8, share_ok)
+			     __field(u8, head_frag)
+			     __field(u8, pp_recycle)
+			     __field(u8, cloned)
+			     __field(u8, shared)
+			     __field(u8, nr_frags)
+			     __field(u8, frag_list)
+		    ),
+	    TP_fast_assign(__entry->skb = skb;
+			   __entry->skb_len = skb->len;
+			   __entry->data_len = skb->data_len;
+			   __entry->share_ok = share_ok;
+			   __entry->head_frag = skb->head_frag;
+			   __entry->pp_recycle = skb->pp_recycle;
+			   __entry->cloned = skb_cloned(skb);
+			   __entry->shared = skb_shared(skb);
+			   __entry->nr_frags = skb_shinfo(skb)->nr_frags;
+			   __entry->frag_list = (bool)skb_shinfo(skb)->frag_list;
+		    ),
+	    TP_printk("INGRPSTQ: NTHADD: skb=%p len=%u data_len=%u share_ok=%u head_frag=%u pp_recycle=%u cloned=%u shared=%u nr_frags=%u frag_list=%u",
+		      __entry->skb, __entry->skb_len, __entry->data_len, __entry->share_ok,
+		      __entry->head_frag, __entry->pp_recycle, __entry->cloned, __entry->shared,
+		      __entry->nr_frags, __entry->frag_list));
+
+DECLARE_EVENT_CLASS(iptfs_timer_event,
+		    TP_PROTO(struct xfrm_iptfs_data *xtfs, u64 time_val),
+		    TP_ARGS(xtfs, time_val),
+		    TP_STRUCT__entry(__field(u64, time_val)
+				     __field(u64, set_time)),
+		    TP_fast_assign(__entry->time_val = time_val;
+				   __entry->set_time = xtfs->iptfs_settime;
+			    ),
+		    TP_printk("TIMER: set_time=%llu time_val=%llu",
+			      __entry->set_time, __entry->time_val));
+
+DEFINE_EVENT(iptfs_timer_event, iptfs_timer_start,
+	     TP_PROTO(struct xfrm_iptfs_data *xtfs, u64 time_val),
+	     TP_ARGS(xtfs, time_val));
+
+DEFINE_EVENT(iptfs_timer_event, iptfs_timer_expire,
+	     TP_PROTO(struct xfrm_iptfs_data *xtfs, u64 time_val),
+	     TP_ARGS(xtfs, time_val));
+
+#endif /* _TRACE_IPTFS_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../net/xfrm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace_iptfs
+#include <trace/define_trace.h>
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index b6e3c1a1c71c..060361479410 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -19,6 +19,7 @@
 #include <crypto/aead.h>
 
 #include "xfrm_inout.h"
+#include "trace_iptfs.h"
 
 /* IPTFS encap (header) values. */
 #define IPTFS_SUBTYPE_BASIC 0
@@ -88,6 +89,39 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me);
 /* Utility Functions */
 /* ================= */
 
+static u32 __trace_ip_proto(struct iphdr *iph)
+{
+	if (iph->version == 4)
+		return iph->protocol;
+	return ((struct ipv6hdr *)iph)->nexthdr;
+}
+
+static u32 __trace_ip_proto_seq(struct iphdr *iph)
+{
+	void *nexthdr;
+	u32 protocol = 0;
+
+	if (iph->version == 4) {
+		nexthdr = (void *)(iph + 1);
+		protocol = iph->protocol;
+	} else if (iph->version == 6) {
+		nexthdr = (void *)(((struct ipv6hdr *)(iph)) + 1);
+		protocol = ((struct ipv6hdr *)(iph))->nexthdr;
+	}
+	switch (protocol) {
+	case IPPROTO_ICMP:
+		return ntohs(((struct icmphdr *)nexthdr)->un.echo.sequence);
+	case IPPROTO_ICMPV6:
+		return ntohs(((struct icmp6hdr *)nexthdr)->icmp6_sequence);
+	case IPPROTO_TCP:
+		return ntohl(((struct tcphdr *)nexthdr)->seq);
+	case IPPROTO_UDP:
+		return ntohs(((struct udphdr *)nexthdr)->source);
+	default:
+		return 0;
+	}
+}
+
 static u64 __esp_seq(struct sk_buff *skb)
 {
 	u64 seq = ntohl(XFRM_SKB_CB(skb)->seq.input.low);
@@ -403,6 +437,13 @@ static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
 	}
 }
 
+/* ================================== */
+/* IPTFS Trace Event Definitions      */
+/* ================================== */
+
+#define CREATE_TRACE_POINTS
+#include "trace_iptfs.h"
+
 /* ================================== */
 /* IPTFS Receiving (egress) Functions */
 /* ================================== */
@@ -892,6 +933,8 @@ static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 	}
 	data = sizeof(*ipth);
 
+	trace_iptfs_egress_recv(skb, xtfs, be16_to_cpu(ipth->block_offset));
+
 	/* Set data past the basic header */
 	if (ipth->subtype == IPTFS_SUBTYPE_CC) {
 		/* Copy the rest of the CC header */
@@ -1787,6 +1830,7 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 		 */
 		if (!ok) {
 nospace:
+			trace_iptfs_no_queue_space(skb, xtfs, pmtu, was_gso);
 			if (skb->dev)
 				XFRM_INC_STATS(dev_net(skb->dev),
 					       LINUX_MIB_XFRMOUTNOQSPACE);
@@ -1798,6 +1842,7 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 		 * enqueue.
 		 */
 		if (xtfs->cfg.dont_frag && iptfs_is_too_big(sk, skb, pmtu)) {
+			trace_iptfs_too_big(skb, xtfs, pmtu, was_gso);
 			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 			continue;
 		}
@@ -1806,6 +1851,8 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 		ok = iptfs_enqueue(xtfs, skb);
 		if (!ok)
 			goto nospace;
+
+		trace_iptfs_enqueue(skb, xtfs, pmtu, was_gso);
 	}
 
 	/* Start a delay timer if we don't have one yet */
@@ -1813,6 +1860,7 @@ static int iptfs_output_collect(struct net *net, struct sock *sk,
 		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
 			      IPTFS_HRTIMER_MODE);
 		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
+		trace_iptfs_timer_start(xtfs, xtfs->init_delay_ns);
 	}
 
 	spin_unlock_bh(&x->lock);
@@ -1910,6 +1958,7 @@ static int iptfs_copy_create_frags(struct sk_buff **skbp,
 	to_copy = skb->len - offset;
 	while (to_copy) {
 		/* Send all but last fragment to allow agg. append */
+		trace_iptfs_first_fragmenting(nskb, mtu, to_copy, NULL);
 		list_add_tail(&nskb->list, &sublist);
 
 		/* FUTURE: if the packet has an odd/non-aligning length we could
@@ -1935,6 +1984,8 @@ static int iptfs_copy_create_frags(struct sk_buff **skbp,
 
 	/* return last fragment that will be unsent (or NULL) */
 	*skbp = nskb;
+	if (nskb)
+		trace_iptfs_first_final_fragment(nskb, mtu, blkoff, NULL);
 
 	/* trim the original skb to MTU */
 	if (!err)
@@ -2039,6 +2090,8 @@ static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data *xtfs,
 	/* We've split these up before queuing */
 	BUG_ON(skb_is_gso(skb));
 
+	trace_iptfs_first_dequeue(skb, mtu, 0, ip_hdr(skb));
+
 	/* Simple case -- it fits. `mtu` accounted for all the overhead
 	 * including the basic IPTFS header.
 	 */
@@ -2141,6 +2194,7 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 				XFRM_INC_STATS(dev_net(skb->dev),
 					       LINUX_MIB_XFRMOUTERROR);
 
+			trace_iptfs_first_toobig(skb, mtu, 0, ip_hdr(skb));
 			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 			continue;
 		}
@@ -2188,6 +2242,7 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 		 * case.
 		 */
 		while ((skb2 = skb_peek(list))) {
+			trace_iptfs_ingress_nth_peek(skb2, remaining);
 			if (skb2->len > remaining)
 				break;
 
@@ -2225,6 +2280,8 @@ static void iptfs_output_queued(struct xfrm_state *x, struct sk_buff_head *list)
 			skb->len += skb2->len;
 			remaining -= skb2->len;
 
+			trace_iptfs_ingress_nth_add(skb2, share_ok);
+
 			if (share_ok) {
 				iptfs_consume_frags(skb, skb2);
 			} else {
@@ -2274,6 +2331,9 @@ static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
 	 * already).
 	 */
 
+	trace_iptfs_timer_expire(
+		xtfs, (unsigned long long)(ktime_get_raw_fast_ns() - settime));
+
 	iptfs_output_queued(x, &list);
 
 	return HRTIMER_NORESTART;
-- 
2.45.2


