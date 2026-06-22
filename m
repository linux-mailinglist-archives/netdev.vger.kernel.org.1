Return-Path: <netdev+bounces-301015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cNOSFzUCOWpnlQcAu9opvQ
	(envelope-from <netdev+bounces-301015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:36:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75B6AE4CC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301015-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFD430AE4B4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5839E9CB;
	Mon, 22 Jun 2026 09:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430A35F5ED;
	Mon, 22 Jun 2026 09:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120020; cv=none; b=VW4p81MUPC5aLB6Linwi1KKUA0bQc/5/ragwFlyUbIpYAHehj2Y5uOmnKLREJgM5Ac4HuJ398mtQKcZEPIuxV40wMBWvvXkGFrhl0svCC+c/O0it1YjUL6mnkYH6Fnp2uCYnzlK90VSSb/lhGkjVejFA/CvqYh6QlLyYyoYrlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120020; c=relaxed/simple;
	bh=WnsK+pdKKPRHOvMYgicUXPfzOzXiZYVPa2xaoFdSpCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=irCTzaldPVVHsAB0jY6u0sMj0aGmDNBEUbAo0hqu1SViAskxCeYMEWdGNlmRDgVzCDUl0gqxhoAhrGRkDV6wU9sljf1BY6FulFN/RirTyZ5mTHIQcZO9zm9HRPpEfl6iOcSwNES0H0yetE/j8yuu+oLIfQaaFvfBUG0oI/no9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92E46200309;
	Mon, 22 Jun 2026 11:20:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A58620030C;
	Mon, 22 Jun 2026 11:20:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D9CFD1800087;
	Mon, 22 Jun 2026 17:20:07 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	shuah@kernel.org,
	vladimir.oltean@nxp.com,
	vinicius.gomes@intel.com,
	fejes@inf.elte.hu,
	xiaoliang.yang_1@nxp.com
Subject: [PATCH net-next 4/6] net: sched: act_frer: add FRER tc action
Date: Mon, 22 Jun 2026 17:21:16 +0800
Message-Id: <20260622092118.6846-5-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
References: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:shuah@kernel.org,m:vladimir.oltean@nxp.com,m:vinicius.gomes@intel.com,m:fejes@inf.elte.hu,m:xiaoliang.yang_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301015-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD75B6AE4CC

Introduce the FRER tc action for IEEE 802.1CB.  This patch adds the
module skeleton, the shared sequence-generator infrastructure, the
TCA_FRER_FUNC_PUSH data path, and the TCA_FRER_FUNC_RECOVER data path.

Sequence generation (IEEE 802.1CB Section 7.4.1):
  Each push action embeds a struct frer_seqgen directly in tcf_frer,
  protected by a per-action spinlock.  The sequence counter wraps at
  65536 (16-bit R-TAG field).  When a Talker chains "action frer push"
  with "action mirred egress mirror", both the primary and the mirrored
  frame carry the same R-TAG because mirred copies the already-modified
  skb.  No changes to act_mirred are required (Split function,
  Section 7.7).

Sequence Recovery vs. Individual Recovery (IEEE 802.1CB Section 7.5):

  Sequence Recovery (cross-port deduplication):
    Multiple ingress filters on different ports share one recover
    action by referencing the same action index.  They all operate on
    the same struct frer_rcvy embedded in that tcf_frer instance and
    protected by a spinlock.  A frame arriving on any port is checked
    against the shared sequence history; the first copy passes and all
    later copies with the same sequence number are discarded.

  Individual Recovery (per-port independent deduplication):
    Each action uses its own frer_rcvy embedded directly in tcf_frer.
    Selected when the user sets the "individual" flag.

Recovery algorithms:
  Vector (7.4.3.4, default): 32-bit history bit-vector, handles
    out-of-order delivery within the window.
  Match (7.4.3.5): remembers only the last accepted sequence number.

Reset timer:
  An hrtimer fires after frerSeqRcvyResetMSec ms of inactivity.
  CLOCK_MONOTONIC is used throughout.  The reset runs in a workqueue
  to avoid holding the spinlock in the hrtimer callback.

R-TAG wire format (IEEE 802.1CB 7.8, EtherType 0xF1C1):
  [Dst MAC 6B][Src MAC 6B][Optional 802.1Q tag 4B][0xF1C1 2B]
  [Reserved 2B][Sequence Number 2B][Encapsulated EtherType 2B][Payload]

Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 include/net/flow_offload.h   |  11 +
 include/net/tc_act/tc_frer.h |  71 +++
 net/sched/Kconfig            |  16 +
 net/sched/Makefile           |   1 +
 net/sched/act_frer.c         | 835 +++++++++++++++++++++++++++++++++++
 5 files changed, 934 insertions(+)
 create mode 100644 include/net/tc_act/tc_frer.h
 create mode 100644 net/sched/act_frer.c

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 70a02ee14308..8d97a5f293e6 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -184,6 +184,7 @@ enum flow_action_id {
 	FLOW_ACTION_VLAN_PUSH_ETH,
 	FLOW_ACTION_VLAN_POP_ETH,
 	FLOW_ACTION_CONTINUE,
+	FLOW_ACTION_FRER,
 	NUM_FLOW_ACTIONS,
 };
 
@@ -329,6 +330,16 @@ struct flow_action_entry {
 		struct {				/* FLOW_ACTION_PPPOE_PUSH */
 			u16		sid;
 		} pppoe;
+		struct {                                /* FLOW_ACTION_FRER */
+			u8		func;
+			u8		tag_type;
+			bool		individual;
+			u8		rcvy_alg;
+			u8		rcvy_history_len;
+			u32		rcvy_reset_msec;
+			bool		tag_pop;
+			bool		take_no_seq;
+		} frer;
 	};
 	struct flow_action_cookie *user_cookie; /* user defined action cookie */
 };
diff --git a/include/net/tc_act/tc_frer.h b/include/net/tc_act/tc_frer.h
new file mode 100644
index 000000000000..5f6f8ca70813
--- /dev/null
+++ b/include/net/tc_act/tc_frer.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2026 NXP */
+
+#ifndef __NET_TC_FRER_H
+#define __NET_TC_FRER_H
+
+#include <net/act_api.h>
+#include <linux/tc_act/tc_frer.h>
+
+/**
+ * struct frer_seqgen - sequence number generator state (embedded in tcf_frer)
+ */
+struct frer_seqgen {
+	u32		gen_seq_num;
+	u64		seq_space;	/* 1 << 16 */
+	spinlock_t	lock;		/* protects frer_seqgen state */
+	u64		stats_pkts;	/* frerCpsSeqGenPackets */
+};
+
+/**
+ * struct frer_rcvy - sequence recovery state (embedded in tcf_frer)
+ *
+ */
+struct frer_rcvy {
+	u8		alg;
+	u8		history_len;	/* 1-32 */
+	u32		reset_msec;
+	u64		seq_space;
+	u32		rcvy_seq_num;
+	u32		seq_history;
+	bool		take_any;
+	bool		take_no_seq;
+	struct hrtimer	hrtimer;
+	spinlock_t	lock;		/* protects frer_rcvy state */
+	/* statistics */
+	u64		stats_tagless_pkts;
+	u64		stats_out_of_order_pkts;
+	u64		stats_rogue_pkts;
+	u64		stats_lost_pkts;
+	u64		stats_resets;
+	u64		stats_passed_pkts;
+	u64		stats_discarded_pkts;
+};
+
+/**
+ * struct tcf_frer - per tc_action FRER private data
+ */
+struct tcf_frer {
+	struct tc_action	common;
+	u8			func;
+	u8			tag_type;
+	bool			tag_pop;
+	bool			individual;	/* Individual Recovery flag */
+	/* push path */
+	struct frer_seqgen	seqgen;
+	/* recover path */
+	struct frer_rcvy	rcvy;
+};
+
+#define to_frer(a) ((struct tcf_frer *)(a))
+
+static inline bool is_tcf_frer(const struct tc_action *a)
+{
+#ifdef CONFIG_NET_CLS_ACT
+	if (a->ops && a->ops->id == TCA_ID_FRER)
+		return true;
+#endif
+	return false;
+}
+
+#endif /* __NET_TC_FRER_H */
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 6ddff028b81a..7ca79b3eb5b3 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -939,6 +939,22 @@ config NET_ACT_GATE
 	  To compile this code as a module, choose M here: the
 	  module will be called act_gate.
 
+config NET_ACT_FRER
+	tristate "IEEE 802.1CB FRER tc action"
+	depends on NET_CLS_ACT
+	help
+	  Say Y here to enable the IEEE 802.1CB FRER tc action.  The action
+	  implements the Sequence Generation Function (egress R-TAG insertion
+	  with shared per-stream sequence counter) and the Sequence Recovery
+	  Function (ingress duplicate detection and elimination) described in
+	  IEEE 802.1CB-2017.
+
+	  Both Sequence Recovery (cross-port shared state via rcvy-id) and
+	  Individual Recovery (per-port independent state) are supported.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called act_frer.
+
 config NET_IFE_SKBMARK
 	tristate "Support to encoding decoding skb mark on IFE action"
 	depends on NET_ACT_IFE
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 5078ea84e6ad..d9f60434e7d7 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_NET_IFE_SKBTCINDEX)	+= act_meta_skbtcindex.o
 obj-$(CONFIG_NET_ACT_TUNNEL_KEY)+= act_tunnel_key.o
 obj-$(CONFIG_NET_ACT_CT)	+= act_ct.o
 obj-$(CONFIG_NET_ACT_GATE)	+= act_gate.o
+obj-$(CONFIG_NET_ACT_FRER)	+= act_frer.o
 obj-$(CONFIG_NET_SCH_FIFO)	+= sch_fifo.o
 obj-$(CONFIG_NET_SCH_HTB)	+= sch_htb.o
 obj-$(CONFIG_NET_SCH_HFSC)	+= sch_hfsc.o
diff --git a/net/sched/act_frer.c b/net/sched/act_frer.c
new file mode 100644
index 000000000000..7b6db643788d
--- /dev/null
+++ b/net/sched/act_frer.c
@@ -0,0 +1,835 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright 2026 NXP */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/if_vlan.h>
+#include <linux/hrtimer.h>
+#include <linux/workqueue.h>
+#include <net/act_api.h>
+#include <net/netlink.h>
+#include <net/pkt_cls.h>
+#include <net/tc_act/tc_frer.h>
+
+/* ------------------------------------------------------------------ */
+/* R-TAG wire structures (IEEE 802.1CB 7.8)                          */
+/* ------------------------------------------------------------------ */
+
+struct r_tag {
+	__be16 reserved;
+	__be16 sequence_nr;
+	__be16 encap_proto;
+} __packed;
+
+static struct tc_action_ops act_frer_ops;
+
+/* ------------------------------------------------------------------ */
+/* Recovery reset machinery                                            */
+/* ------------------------------------------------------------------ */
+
+struct frer_rcvy_work {
+	struct work_struct	work;
+	struct frer_rcvy	*rcvy;
+};
+
+static void frer_rcvy_reset(struct frer_rcvy *rcvy)
+{
+	if (rcvy->alg == TCA_FRER_RCVY_VECTOR_ALG) {
+		rcvy->rcvy_seq_num = (u32)(rcvy->seq_space - 1);
+		rcvy->seq_history  = 0;
+	}
+	rcvy->take_any = true;
+	rcvy->stats_resets++;
+}
+
+static void frer_rcvy_reset_work_fn(struct work_struct *work)
+{
+	struct frer_rcvy_work *rw =
+		container_of(work, struct frer_rcvy_work, work);
+	struct frer_rcvy *rcvy = rw->rcvy;
+
+	spin_lock_bh(&rcvy->lock);
+	frer_rcvy_reset(rcvy);
+	spin_unlock_bh(&rcvy->lock);
+	kfree(rw);
+}
+
+static enum hrtimer_restart frer_rcvy_hrtimer_fn(struct hrtimer *timer)
+{
+	struct frer_rcvy *rcvy =
+		container_of(timer, struct frer_rcvy, hrtimer);
+	struct frer_rcvy_work *rw;
+
+	/* Allocate in GFP_ATOMIC context; if it fails the state is not
+	 * reset this cycle - the next frame will attempt again.
+	 */
+	rw = kmalloc_obj(*rw);
+	if (rw) {
+		INIT_WORK(&rw->work, frer_rcvy_reset_work_fn);
+		rw->rcvy = rcvy;
+		schedule_work(&rw->work);
+	}
+	return HRTIMER_NORESTART;
+}
+
+static void frer_rcvy_timer_restart(struct frer_rcvy *rcvy)
+{
+	if (rcvy->reset_msec)
+		hrtimer_start(&rcvy->hrtimer,
+			      ms_to_ktime(rcvy->reset_msec),
+			      HRTIMER_MODE_REL_SOFT);
+}
+
+static void frer_rcvy_init_state(struct frer_rcvy *rcvy, u8 alg,
+				 u8 history_len, u32 reset_msec,
+				 bool take_no_seq)
+{
+	rcvy->alg          = alg;
+	rcvy->history_len  = history_len;
+	rcvy->reset_msec   = reset_msec;
+	rcvy->seq_space    = 1 << 16;
+	rcvy->take_no_seq  = take_no_seq;
+	rcvy->take_any     = true;
+	rcvy->rcvy_seq_num = (u32)(rcvy->seq_space - 1);
+	rcvy->seq_history  = 0;
+	spin_lock_init(&rcvy->lock);
+	hrtimer_setup(&rcvy->hrtimer, frer_rcvy_hrtimer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
+}
+
+/* ------------------------------------------------------------------ */
+/* R-TAG helpers                                                       */
+/* ------------------------------------------------------------------ */
+
+static int frer_rtag_push(struct sk_buff *skb, u16 seq_num)
+{
+	unsigned char *new_mac_header;
+	unsigned int data_offset;
+	unsigned int head_len;
+	struct vlan_ethhdr *vh;
+	struct ethhdr *eh;
+	struct r_tag *rtag;
+	__be16 *proto_ptr;
+	__be16 saved_proto;
+
+	if (!skb_mac_header_was_set(skb))
+		return -EINVAL;
+
+	data_offset = skb->data - skb_mac_header(skb);
+
+	if (skb_cow_head(skb, data_offset + sizeof(*rtag)))
+		return -ENOMEM;
+
+	if (data_offset > 0)
+		skb_push(skb, data_offset);
+
+	eh = eth_hdr(skb);
+	if (eth_type_vlan(eh->h_proto)) {
+		if (!pskb_may_pull(skb, sizeof(*vh)))
+			return -EINVAL;
+		eh = eth_hdr(skb);
+		vh = (struct vlan_ethhdr *)eh;
+		proto_ptr = &vh->h_vlan_encapsulated_proto;
+		head_len = sizeof(*vh);
+	} else {
+		if (!pskb_may_pull(skb, sizeof(*eh)))
+			return -EINVAL;
+		eh = eth_hdr(skb);
+		proto_ptr = &eh->h_proto;
+		head_len = sizeof(*eh);
+	}
+
+	saved_proto = *proto_ptr;
+	*proto_ptr = htons(ETH_P_RTAG);
+
+	skb_push(skb, sizeof(*rtag));
+	skb_reset_mac_header(skb);
+
+	new_mac_header = skb_mac_header(skb);
+	memmove(new_mac_header, (unsigned char *)eh, head_len);
+
+	skb->protocol = htons(ETH_P_RTAG);
+	skb_set_network_header(skb, head_len);
+	if (data_offset > 0)
+		skb_pull(skb, data_offset);
+
+	/* Write R-TAG after the Ethernet / VLAN header */
+	rtag = (struct r_tag *)(new_mac_header + head_len);
+	rtag->reserved    = 0;
+	rtag->sequence_nr = htons(seq_num);
+	rtag->encap_proto = saved_proto;
+
+	return 0;
+}
+
+static void frer_rtag_pop(struct sk_buff *skb)
+{
+	unsigned char *new_mac_header;
+	unsigned int data_offset;
+	unsigned int head_len;
+	struct vlan_ethhdr *vh;
+	struct ethhdr *eh;
+	struct r_tag *rtag;
+	__be16 *proto_ptr;
+
+	data_offset = skb->data - skb_mac_header(skb);
+	if (data_offset > 0)
+		skb_push(skb, data_offset);
+
+	eh = eth_hdr(skb);
+	if (eth_type_vlan(eh->h_proto)) {
+		vh = (struct vlan_ethhdr *)eh;
+		proto_ptr = &vh->h_vlan_encapsulated_proto;
+		head_len = sizeof(*vh);
+	} else {
+		proto_ptr = &eh->h_proto;
+		head_len = sizeof(*eh);
+	}
+
+	if (*proto_ptr != htons(ETH_P_RTAG))
+		return;
+
+	rtag = (struct r_tag *)((unsigned char *)eh + head_len);
+	*proto_ptr = rtag->encap_proto;
+
+	skb->protocol = rtag->encap_proto;
+
+	skb_postpull_rcsum(skb, rtag, sizeof(struct r_tag));
+	skb_pull(skb, sizeof(*rtag));
+	skb_reset_mac_header(skb);
+
+	new_mac_header = skb_mac_header(skb);
+	memmove(new_mac_header, (unsigned char *)eh, head_len);
+
+	skb_set_network_header(skb, head_len);
+	if (data_offset > 0)
+		skb_pull(skb, data_offset);
+}
+
+static int frer_rtag_decode(struct sk_buff *skb, int *seq)
+{
+	unsigned int data_offset;
+	struct vlan_ethhdr *vh;
+	unsigned int head_len;
+	struct ethhdr *eh;
+	struct r_tag *rtag;
+	__be16 *proto_ptr;
+
+	if (!skb_mac_header_was_set(skb))
+		return -EINVAL;
+
+	data_offset = skb->data - skb_mac_header(skb);
+
+	if (skb_cow_head(skb, data_offset))
+		return -ENOMEM;
+
+	if (data_offset > 0)
+		skb_push(skb, data_offset);
+
+	eh = eth_hdr(skb);
+	if (eth_type_vlan(eh->h_proto)) {
+		if (!pskb_may_pull(skb, sizeof(*vh) + sizeof(*rtag)))
+			return -EINVAL;
+		eh = eth_hdr(skb);
+		vh = (struct vlan_ethhdr *)eh;
+		proto_ptr = &vh->h_vlan_encapsulated_proto;
+		head_len = sizeof(*vh);
+	} else {
+		if (!pskb_may_pull(skb, sizeof(*eh) + sizeof(*rtag)))
+			return -EINVAL;
+		eh = eth_hdr(skb);
+		proto_ptr = &eh->h_proto;
+		head_len = sizeof(*eh);
+	}
+
+	if (data_offset > 0)
+		skb_pull(skb, data_offset);
+
+	if (*proto_ptr != htons(ETH_P_RTAG)) {
+		*seq = -1;
+		return 0;
+	}
+
+	rtag = (struct r_tag *)((unsigned char *)eh + head_len);
+
+	*seq = (int)ntohs(rtag->sequence_nr);
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Recovery algorithms (called with rcvy->lock held)                  */
+/* ------------------------------------------------------------------ */
+
+/* Returns true = pass frame, false = discard frame.
+ * @individual: when true, restart the reset timer even on discarded frames
+ *   (rogue/duplicate), as required for Individual Recovery (IEEE 802.1CB 7.5).
+ */
+static bool frer_vector_alg(struct frer_rcvy *rcvy, int seq, bool individual)
+{
+	int delta;
+	bool restart_timer = false;
+	bool pass;
+
+	if (seq < 0) {
+		/* No R-TAG present */
+		rcvy->stats_tagless_pkts++;
+		if (rcvy->take_no_seq) {
+			restart_timer = true;
+			pass = true;
+		} else {
+			pass = false;
+		}
+		goto out;
+	}
+
+	if (rcvy->take_any) {
+		/* First frame after reset: accept unconditionally */
+		rcvy->take_any     = false;
+		rcvy->rcvy_seq_num = (u32)seq;
+		rcvy->seq_history  = BIT(0);
+		restart_timer = true;
+		pass = true;
+		goto out;
+	}
+
+	delta = (seq - (int)rcvy->rcvy_seq_num) &
+		(int)(rcvy->seq_space - 1);
+	/* Map delta > seq_space/2 to negative (signed wrap) */
+	if ((u32)delta & (u32)(rcvy->seq_space / 2))
+		delta -= (int)rcvy->seq_space;
+
+	if (delta >= (int)rcvy->history_len ||
+	    delta <= -(int)rcvy->history_len) {
+		/* Packet is out-of-range (rogue). */
+		rcvy->stats_rogue_pkts++;
+		if (individual)
+			restart_timer = true;
+		pass = false;
+		goto out;
+	}
+
+	if (delta <= 0) {
+		/* Packet is old: check whether already seen. */
+		if (rcvy->seq_history & BIT(-delta)) {
+			if (individual)
+				restart_timer = true;
+			/* Already received */
+			pass = false;
+		} else {
+			/* Out-of-order but not yet seen */
+			rcvy->seq_history |= BIT(-delta);
+			rcvy->stats_out_of_order_pkts++;
+			restart_timer = true;
+			pass = true;
+		}
+		goto out;
+	}
+
+	/* delta > 0: frame is newer than expected */
+	if (delta != 1)
+		rcvy->stats_out_of_order_pkts++;
+
+	/* Shift history forward, counting any gaps as lost */
+	while (--delta) {
+		if (!(rcvy->seq_history & BIT(rcvy->history_len - 1)))
+			rcvy->stats_lost_pkts++;
+		rcvy->seq_history <<= 1;
+	}
+	if (!(rcvy->seq_history & BIT(rcvy->history_len - 1)))
+		rcvy->stats_lost_pkts++;
+	rcvy->seq_history = (rcvy->seq_history << 1) | BIT(0);
+	rcvy->rcvy_seq_num = (u32)seq;
+	restart_timer = true;
+	pass = true;
+
+out:
+	if (restart_timer)
+		frer_rcvy_timer_restart(rcvy);
+	return pass;
+}
+
+static bool frer_match_alg(struct frer_rcvy *rcvy, int seq, bool individual)
+{
+	if (seq < 0) {
+		/* No R-TAG: Match alg cannot deduplicate, always pass. */
+		rcvy->stats_tagless_pkts++;
+		return true;
+	}
+
+	if (rcvy->take_any) {
+		rcvy->take_any     = false;
+		rcvy->rcvy_seq_num = (u32)seq;
+		frer_rcvy_timer_restart(rcvy);
+		return true;
+	}
+
+	if ((u32)seq == rcvy->rcvy_seq_num) {
+		/* Duplicate */
+		if (individual)
+			frer_rcvy_timer_restart(rcvy);
+		return false;
+	}
+
+	/* New sequence number: accept and update */
+	if ((u32)seq != ((rcvy->rcvy_seq_num + 1) % rcvy->seq_space))
+		rcvy->stats_out_of_order_pkts++;
+	rcvy->rcvy_seq_num = (u32)seq;
+	frer_rcvy_timer_restart(rcvy);
+	return true;
+}
+
+/* ------------------------------------------------------------------ */
+/* Netlink policy                                                      */
+/* ------------------------------------------------------------------ */
+
+static const struct nla_policy frer_policy[TCA_FRER_MAX + 1] = {
+	[TCA_FRER_PARMS]            = NLA_POLICY_EXACT_LEN(sizeof(struct tc_frer)),
+	[TCA_FRER_FUNC]             = { .type = NLA_U8 },
+	[TCA_FRER_TAG_TYPE]         = { .type = NLA_U8 },
+	[TCA_FRER_RCVY_INDIVIDUAL]  = { .type = NLA_FLAG },
+	[TCA_FRER_RCVY_ALG]         = { .type = NLA_U8 },
+	[TCA_FRER_RCVY_HISTORY_LEN] = NLA_POLICY_RANGE(NLA_U8, 1, 32),
+	[TCA_FRER_RCVY_RESET_MSEC]  = { .type = NLA_U32 },
+	[TCA_FRER_RCVY_TAKE_NO_SEQ] = { .type = NLA_FLAG },
+	[TCA_FRER_RCVY_TAG_POP]     = { .type = NLA_FLAG },
+};
+
+/* ------------------------------------------------------------------ */
+/* Action init                                                         */
+/* ------------------------------------------------------------------ */
+
+static int tcf_frer_init(struct net *net, struct nlattr *nla,
+			 struct nlattr *est, struct tc_action **a,
+			 struct tcf_proto *tp, u32 flags,
+			 struct netlink_ext_ack *extack)
+{
+	struct tc_action_net *tn = net_generic(net, act_frer_ops.net_id);
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct nlattr *tb[TCA_FRER_MAX + 1];
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_frer *f;
+	struct tc_frer *parm;
+	bool exists = false;
+	int ret = 0, err, index;
+	u8 func, tag_type;
+
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: attributes required");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, TCA_FRER_MAX, nla, frer_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[TCA_FRER_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: TCA_FRER_PARMS missing");
+		return -EINVAL;
+	}
+	if (!tb[TCA_FRER_FUNC]) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: TCA_FRER_FUNC missing");
+		return -EINVAL;
+	}
+	if (!tb[TCA_FRER_TAG_TYPE]) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: TCA_FRER_TAG_TYPE missing");
+		return -EINVAL;
+	}
+
+	func     = nla_get_u8(tb[TCA_FRER_FUNC]);
+	tag_type = nla_get_u8(tb[TCA_FRER_TAG_TYPE]);
+
+	if (func != TCA_FRER_FUNC_PUSH && func != TCA_FRER_FUNC_RECOVER) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: unknown func");
+		return -EINVAL;
+	}
+	if (tag_type != TCA_FRER_TAG_RTAG) {
+		NL_SET_ERR_MSG_MOD(extack, "frer: only rtag supported");
+		return -EOPNOTSUPP;
+	}
+
+	parm  = nla_data(tb[TCA_FRER_PARMS]);
+	index = parm->index;
+
+	err = tcf_idr_check_alloc(tn, &index, a, bind);
+	if (err < 0)
+		return err;
+	exists = err;
+
+	if (exists && bind)
+		return ACT_P_BOUND;
+
+	if (!exists) {
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_frer_ops, bind, flags);
+		if (ret) {
+			tcf_idr_cleanup(tn, index);
+			return ret;
+		}
+		ret = ACT_P_CREATED;
+	} else if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
+		tcf_idr_release(*a, bind);
+		return -EEXIST;
+	}
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	f = to_frer(*a);
+
+	spin_lock_bh(&f->tcf_lock);
+	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+	f->func     = func;
+	f->tag_type = tag_type;
+	f->tag_pop  = !!tb[TCA_FRER_RCVY_TAG_POP];
+
+	if (func == TCA_FRER_FUNC_PUSH) {
+		if (ret == ACT_P_CREATED) {
+			spin_lock_init(&f->seqgen.lock);
+			f->seqgen.seq_space = 1 << 16;
+		}
+		/* gen_seq_num starts at 0 on creation; preserved on replace */
+	} else {
+		u8 alg = tb[TCA_FRER_RCVY_ALG] ?
+			 nla_get_u8(tb[TCA_FRER_RCVY_ALG]) :
+			 TCA_FRER_RCVY_VECTOR_ALG;
+		u8 history_len = tb[TCA_FRER_RCVY_HISTORY_LEN] ?
+				 nla_get_u8(tb[TCA_FRER_RCVY_HISTORY_LEN]) : 32;
+		u32 reset_msec = tb[TCA_FRER_RCVY_RESET_MSEC] ?
+				 nla_get_u32(tb[TCA_FRER_RCVY_RESET_MSEC]) : 0;
+		bool take_no_seq = !!tb[TCA_FRER_RCVY_TAKE_NO_SEQ];
+
+		if (alg != TCA_FRER_RCVY_VECTOR_ALG &&
+		    alg != TCA_FRER_RCVY_MATCH_ALG) {
+			spin_unlock_bh(&f->tcf_lock);
+			NL_SET_ERR_MSG_MOD(extack, "frer: unknown recovery algorithm");
+			err = -EINVAL;
+			goto release_idr;
+		}
+
+		f->individual = !!tb[TCA_FRER_RCVY_INDIVIDUAL];
+
+		/* Cancel any running reset timer before re-initialising. */
+		if (ret != ACT_P_CREATED && f->rcvy.reset_msec) {
+			spin_unlock_bh(&f->tcf_lock);
+			hrtimer_cancel(&f->rcvy.hrtimer);
+			spin_lock_bh(&f->tcf_lock);
+		}
+
+		frer_rcvy_init_state(&f->rcvy, alg, history_len,
+				     reset_msec, take_no_seq);
+	}
+
+	spin_unlock_bh(&f->tcf_lock);
+
+	if (goto_ch)
+		tcf_chain_put_by_act(goto_ch);
+
+	return ret;
+
+release_idr:
+	tcf_idr_release(*a, bind);
+	return err;
+}
+
+/* ------------------------------------------------------------------ */
+/* Data path                                                           */
+/* ------------------------------------------------------------------ */
+
+static int tcf_frer_act(struct sk_buff *skb, const struct tc_action *a,
+			struct tcf_result *res)
+{
+	struct tcf_frer *f = to_frer(a);
+	int retval;
+
+	tcf_lastuse_update(&f->tcf_tm);
+	tcf_action_update_bstats(&f->common, skb);
+	retval = READ_ONCE(f->tcf_action);
+
+	if (f->func == TCA_FRER_FUNC_PUSH) {
+		struct frer_seqgen *sg = &f->seqgen;
+		u16 seq;
+
+		spin_lock(&sg->lock);
+		seq = (u16)sg->gen_seq_num;
+		if (++sg->gen_seq_num >= sg->seq_space)
+			sg->gen_seq_num = 0;
+		sg->stats_pkts++;
+		spin_unlock(&sg->lock);
+
+		if (frer_rtag_push(skb, seq) < 0) {
+			tcf_action_inc_drop_qstats(&f->common);
+			return TC_ACT_SHOT;
+		}
+	} else {
+		struct frer_rcvy *rcvy = &f->rcvy;
+		bool pass;
+		int seq;
+
+		if (frer_rtag_decode(skb, &seq) < 0) {
+			tcf_action_inc_drop_qstats(&f->common);
+			return TC_ACT_SHOT;
+		}
+
+		spin_lock(&rcvy->lock);
+		if (rcvy->alg == TCA_FRER_RCVY_VECTOR_ALG)
+			pass = frer_vector_alg(rcvy, seq, f->individual);
+		else
+			pass = frer_match_alg(rcvy, seq, f->individual);
+
+		if (pass) {
+			rcvy->stats_passed_pkts++;
+			spin_unlock(&rcvy->lock);
+			if (f->tag_pop)
+				frer_rtag_pop(skb);
+			return retval;
+		}
+
+		rcvy->stats_discarded_pkts++;
+		spin_unlock(&rcvy->lock);
+		return TC_ACT_SHOT;
+	}
+
+	return retval;
+}
+
+/* ------------------------------------------------------------------ */
+/* Dump                                                                */
+/* ------------------------------------------------------------------ */
+
+static int tcf_frer_dump(struct sk_buff *skb, struct tc_action *a,
+			 int bind, int ref)
+{
+	unsigned char *b = skb_tail_pointer(skb);
+	struct tcf_frer *f = to_frer(a);
+	struct tc_frer opt = {
+		.index   = f->tcf_index,
+		.refcnt  = refcount_read(&f->tcf_refcnt) - ref,
+		.bindcnt = atomic_read(&f->tcf_bindcnt) - bind,
+	};
+	struct tcf_t t;
+
+	spin_lock_bh(&f->tcf_lock);
+	opt.action = f->tcf_action;
+
+	if (nla_put(skb, TCA_FRER_PARMS, sizeof(opt), &opt))
+		goto nla_put_failure;
+	if (nla_put_u8(skb, TCA_FRER_FUNC, f->func))
+		goto nla_put_failure;
+	if (nla_put_u8(skb, TCA_FRER_TAG_TYPE, f->tag_type))
+		goto nla_put_failure;
+	if (f->tag_pop && nla_put_flag(skb, TCA_FRER_RCVY_TAG_POP))
+		goto nla_put_failure;
+
+	if (f->func == TCA_FRER_FUNC_PUSH) {
+		spin_lock(&f->seqgen.lock);
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_SEQGEN_PKTS,
+				      f->seqgen.stats_pkts, TCA_FRER_PAD)) {
+			spin_unlock(&f->seqgen.lock);
+			goto nla_put_failure;
+		}
+		spin_unlock(&f->seqgen.lock);
+	} else {
+		u64 tagless, ooo, rogue, lost, resets, passed, discarded;
+		struct frer_rcvy *rcvy = &f->rcvy;
+
+		spin_lock(&rcvy->lock);
+		tagless    = rcvy->stats_tagless_pkts;
+		ooo        = rcvy->stats_out_of_order_pkts;
+		rogue      = rcvy->stats_rogue_pkts;
+		lost       = rcvy->stats_lost_pkts;
+		resets     = rcvy->stats_resets;
+		passed     = rcvy->stats_passed_pkts;
+		discarded  = rcvy->stats_discarded_pkts;
+		spin_unlock(&rcvy->lock);
+
+		if (f->individual && nla_put_flag(skb, TCA_FRER_RCVY_INDIVIDUAL))
+			goto nla_put_failure;
+		if (nla_put_u8(skb, TCA_FRER_RCVY_ALG, rcvy->alg))
+			goto nla_put_failure;
+		if (nla_put_u8(skb, TCA_FRER_RCVY_HISTORY_LEN, rcvy->history_len))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, TCA_FRER_RCVY_RESET_MSEC, rcvy->reset_msec))
+			goto nla_put_failure;
+		if (rcvy->take_no_seq && nla_put_flag(skb, TCA_FRER_RCVY_TAKE_NO_SEQ))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_TAGLESS_PKTS,
+				      tagless, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_OUT_OF_ORDER_PKTS,
+				      ooo, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_ROGUE_PKTS,
+				      rogue, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_LOST_PKTS,
+				      lost, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_RESETS,
+				      resets, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_PASSED_PKTS,
+				      passed, TCA_FRER_PAD))
+			goto nla_put_failure;
+		if (nla_put_u64_64bit(skb, TCA_FRER_STATS_DISCARDED_PKTS,
+				      discarded, TCA_FRER_PAD))
+			goto nla_put_failure;
+	}
+
+	tcf_tm_dump(&t, &f->tcf_tm);
+	if (nla_put_64bit(skb, TCA_FRER_TM, sizeof(t), &t, TCA_FRER_PAD))
+		goto nla_put_failure;
+
+	spin_unlock_bh(&f->tcf_lock);
+	return skb->len;
+
+nla_put_failure:
+	spin_unlock_bh(&f->tcf_lock);
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+/* ------------------------------------------------------------------ */
+/* Cleanup                                                             */
+/* ------------------------------------------------------------------ */
+
+static void tcf_frer_cleanup(struct tc_action *a)
+{
+	struct tcf_frer *f = to_frer(a);
+
+	if (f->func == TCA_FRER_FUNC_RECOVER)
+		hrtimer_cancel(&f->rcvy.hrtimer);
+}
+
+/* ------------------------------------------------------------------ */
+/* Walker / search / stats / fill-size / offload                      */
+/* ------------------------------------------------------------------ */
+
+static int tcf_frer_walker(struct net *net, struct sk_buff *skb,
+			   struct netlink_callback *cb, int type,
+			   const struct tc_action_ops *ops,
+			   struct netlink_ext_ack *extack)
+{
+	struct tc_action_net *tn = net_generic(net, act_frer_ops.net_id);
+
+	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
+}
+
+static void tcf_frer_stats_update(struct tc_action *a, u64 bytes, u64 packets,
+				  u64 drops, u64 lastuse, bool hw)
+{
+	struct tcf_frer *f = to_frer(a);
+	struct tcf_t *tm = &f->tcf_tm;
+
+	tcf_action_update_stats(a, bytes, packets, drops, hw);
+	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
+}
+
+static size_t tcf_frer_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_frer)) /* TCA_FRER_PARMS */
+		+ nla_total_size(sizeof(u8)) /* TCA_FRER_FUNC */
+		+ nla_total_size(sizeof(u8)) /* TCA_FRER_TAG_TYPE */
+		+ nla_total_size(0) /* TCA_FRER_RCVY_TAG_POP (flag) */
+		+ nla_total_size(0) /* TCA_FRER_RCVY_INDIVIDUAL (flag) */
+		+ nla_total_size(sizeof(u8)) /* TCA_FRER_RCVY_ALG */
+		+ nla_total_size(sizeof(u8)) /* TCA_FRER_RCVY_HISTORY_LEN */
+		+ nla_total_size(sizeof(u32)) /* TCA_FRER_RCVY_RESET_MSEC */
+		+ nla_total_size(0) /* TCA_FRER_RCVY_TAKE_NO_SEQ (flag) */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_TAGLESS_PKTS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_OUT_OF_ORDER_PKTS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_ROGUE_PKTS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_LOST_PKTS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_RESETS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_PASSED_PKTS */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_FRER_STATS_DISCARDED_PKTS */
+		+ nla_total_size_64bit(sizeof(struct tcf_t)); /* TCA_FRER_TM */
+}
+
+static int tcf_frer_offload_act_setup(struct tc_action *act, void *entry_data,
+				      u32 *index_inc, bool bind,
+				      struct netlink_ext_ack *extack)
+{
+	if (bind) {
+		struct flow_action_entry *entry = entry_data;
+		struct tcf_frer *f = to_frer(act);
+
+		entry->id            = FLOW_ACTION_FRER;
+		entry->frer.func     = f->func;
+		entry->frer.tag_type = f->tag_type;
+		entry->frer.tag_pop  = f->tag_pop;
+
+		if (f->func != TCA_FRER_FUNC_PUSH) {
+			entry->frer.individual       = f->individual;
+			entry->frer.rcvy_alg         = f->rcvy.alg;
+			entry->frer.rcvy_history_len = f->rcvy.history_len;
+			entry->frer.rcvy_reset_msec  = f->rcvy.reset_msec;
+			entry->frer.take_no_seq      = f->rcvy.take_no_seq;
+		}
+		*index_inc = 1;
+	} else {
+		struct flow_offload_action *fl_action = entry_data;
+
+		fl_action->id = FLOW_ACTION_FRER;
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* Module glue                                                         */
+/* ------------------------------------------------------------------ */
+
+static struct tc_action_ops act_frer_ops = {
+	.kind		    = "frer",
+	.id		    = TCA_ID_FRER,
+	.owner		    = THIS_MODULE,
+	.act		    = tcf_frer_act,
+	.init		    = tcf_frer_init,
+	.cleanup	    = tcf_frer_cleanup,
+	.dump		    = tcf_frer_dump,
+	.walk		    = tcf_frer_walker,
+	.stats_update	    = tcf_frer_stats_update,
+	.get_fill_size	    = tcf_frer_get_fill_size,
+	.offload_act_setup  = tcf_frer_offload_act_setup,
+	.size		    = sizeof(struct tcf_frer),
+};
+
+static __net_init int frer_init_net(struct net *net)
+{
+	struct tc_action_net *tn = net_generic(net, act_frer_ops.net_id);
+
+	return tc_action_net_init(net, tn, &act_frer_ops);
+}
+
+static void __net_exit frer_exit_net(struct list_head *net_list)
+{
+	tc_action_net_exit(net_list, act_frer_ops.net_id);
+}
+
+static struct pernet_operations frer_net_ops = {
+	.init       = frer_init_net,
+	.exit_batch = frer_exit_net,
+	.id         = &act_frer_ops.net_id,
+	.size       = sizeof(struct tc_action_net),
+};
+
+static int __init frer_init_module(void)
+{
+	return tcf_register_action(&act_frer_ops, &frer_net_ops);
+}
+
+static void __exit frer_cleanup_module(void)
+{
+	tcf_unregister_action(&act_frer_ops, &frer_net_ops);
+}
+
+module_init(frer_init_module);
+module_exit(frer_cleanup_module);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IEEE 802.1CB FRER tc action");
-- 
2.17.1


