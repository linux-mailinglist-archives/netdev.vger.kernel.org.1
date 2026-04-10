Return-Path: <netdev+bounces-277505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pz8JixA2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A33DB6E8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E190A301E95D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56583E123C;
	Fri, 10 Apr 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSRsD+xX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384E2877F4
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845391; cv=none; b=TW8cxOpXOtTUQZPvAVFCrTnm2EldzdHMNAmzc/h93KX77remJ2ggGUyu3beqmaErzPxSkal5smfjYo9vhCFgI0Ol9Z2KEV7smgiKXdPbVGJ1ERlGOwsi4vYsfkdbwV7iS+NwHyzaokrWX8icycplY2eDhNR/FHrin0ZZngg6muQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845391; c=relaxed/simple;
	bh=X+vt6jjR7/2cx4RsWhXtcmOx5dlnyDTcxc1LV5pLMIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScCvC2tNNyGHm136aAjuUbWiFNWZP3CfbDz2k3ieNd5+/EgBHPg5MNxuK2GxFlgZRBM4uNWwb0E6QKBIMJQ8K97v/YGEpinDntcdaDfXmALl2MZXMU91A39DWeZIzaUY22WU+ak7Da5WTlAe+7JH1rHu+IKjoZ23XJoTyev2wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSRsD+xX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8dbc9af20edso479414985a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845389; x=1776450189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTUjACk8xa6xS0KhzoR2tLwU9N5QCEGog/c4qXac2Ic=;
        b=wSRsD+xX8ONuw1VQNu+JPj4b9Nmdn1P8Dfs2ci2/vCIAX9nT64NBjwwXB7QnFxNLhm
         uQ6j6t1pIjXy3RA3vTXspxTmagWrrLyxaSBAiL8nOulgaeoYs3NoURH5cL31TNdvA5AF
         5mnC/2MjHtdAfoB/0zjyZ5LlPEWmZizr5m/Yc0gnEhJiaLIbxMoVnn7MRzRkHDj3CCu3
         J7FUueX53JesU23XBjZgqjh2duafg1XKt3SjZmucctjIuuDpOp60lqys+P9v+3MIr0ck
         D7/2R2AuiYDM9f7YY0ERBrZ03FUWFgPyuO+ylE/DtFM5O9QulSEq7XqluEjGe7Wy6DSG
         uXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845389; x=1776450189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTUjACk8xa6xS0KhzoR2tLwU9N5QCEGog/c4qXac2Ic=;
        b=inUpgUOQiNjXhndqMDlQC4wTo/P3qmec9f2AIRMPjLUNn2xyNUUZDauBCYL9WD5XQr
         pOquNXS82uECuSyoUmOz5fDA0q2Ga/B29zJVEfCKVckhlipPY6aAGOC5jjOB+lKb099E
         Ewe6xNOpl6GthwbU4G+X5h+NWWGThYQ3b1Ys1FgTBTwow5KQdXHVL8zbsR27a5i+9rJq
         tnDt9vJZuQeoIUVtSTSkvCiKGc5C5VXPHPVsWDK0F9Hfu2uJFpPVG9mPqsF4iTTGZsy7
         Yv4u8XHAjhSer5NwiWHhqkOI5rCPYsBHoi1nFThCPJ9ZNK7u0FJspyx/RKeguWfjevSA
         WLGA==
X-Forwarded-Encrypted: i=1; AJvYcCX4aIu4Qx+oabEMLyjNsNOGPDqzYQ0Unf7cKSGWPW9EfftmdFYD5wt73l1p/Z/5c+xvUqGUyD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtWvW5LhxJ4Ee8WjO+MHY5oyrBbTTdEigK+wiYQev/191LC4O
	jNDC8zJmf+RDejMinqTcZ5Y/CxEev4CgFbX71AEQ4bkKMQGWoL7GODKwTzqcJsS/ohAp8mcsFbG
	XCeK6ntl41yDXOQ==
X-Received: from qvbjv9.prod.google.com ([2002:a05:6214:29e9:b0:8a2:2d7f:573f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4442:b0:8cd:9281:6be9 with SMTP id af79cd13be357-8dc467da740mr1053989085a.31.1775845388816;
 Fri, 10 Apr 2026 11:23:08 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:44 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/15] net/sched: add qstats_cpu_drop_inc() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0C2A33DB6E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) Using this_cpu_inc() is better than going through this_cpu_ptr():

- Single instruction on x86.
- Store tearing prevention.

2) Change tcf_action_update_stats() to use this_cpu_add().

3) Add WRITE_ONCE() to __qdisc_qstats_drop() and qstats_drop_inc().

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 0/0 grow/shrink: 1/10 up/down: 16/-97 (-81)
Function                                     old     new   delta
tcf_ife_act                                 1061    1077     +16
tcf_vlan_act                                 684     676      -8
tcf_skbedit_act                              626     618      -8
tcf_police_act                               725     717      -8
tcf_mpls_act                                1297    1289      -8
tcf_gate_act                                 310     302      -8
tcf_gact_act                                 195     187      -8
tcf_csum_act                                2905    2897      -8
tcf_bpf_act                                  749     741      -8
tcf_action_update_stats                      124     115      -9
tcf_ct_act                                  2154    2130     -24
Total: Before=29739602, After=29739521, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h     | 2 +-
 include/net/sch_generic.h | 9 +++++++--
 net/sched/act_api.c       | 2 +-
 net/sched/act_bpf.c       | 2 +-
 net/sched/act_ife.c       | 8 ++++----
 net/sched/act_mpls.c      | 2 +-
 net/sched/act_police.c    | 2 +-
 net/sched/act_skbedit.c   | 2 +-
 net/sched/sch_cake.c      | 2 +-
 net/sched/sch_fq_codel.c  | 2 +-
 net/sched/sch_gred.c      | 2 +-
 11 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 2ec4ef9a5d0c8e9110f92f135cc3c31a38af0479..167435c5615e09f491a05d01ec86b0c9f9f4fd5b 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -241,7 +241,7 @@ static inline void tcf_action_update_bstats(struct tc_action *a,
 static inline void tcf_action_inc_drop_qstats(struct tc_action *a)
 {
 	if (likely(a->cpu_qstats)) {
-		qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
+		qstats_cpu_drop_inc(a->cpu_qstats);
 		return;
 	}
 	atomic_inc(&a->tcfa_drops);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 3ee383c6fc3f66f1aecd9ebc675fbd143852c150..b22579671e4b4dd04c5dfa810b714daaac74af2a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -996,12 +996,17 @@ static inline void qdisc_qstats_cpu_requeues_inc(struct Qdisc *sch)
 
 static inline void __qdisc_qstats_drop(struct Qdisc *sch, int count)
 {
-	sch->qstats.drops += count;
+	WRITE_ONCE(sch->qstats.drops, sch->qstats.drops + count);
 }
 
 static inline void qstats_drop_inc(struct gnet_stats_queue *qstats)
 {
-	qstats->drops++;
+	WRITE_ONCE(qstats->drops, qstats->drops + 1);
+}
+
+static inline void qstats_cpu_drop_inc(struct gnet_stats_queue __percpu *qstats)
+{
+	this_cpu_inc(qstats->drops);
 }
 
 static inline void qstats_cpu_overlimit_inc(struct gnet_stats_queue __percpu *qstats)
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 332fd9695e54a1fc63bb869c28cacf5f2ed14971..551992683d9e69c247b8d9c613a69e2a897a1e79 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1578,7 +1578,7 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 	if (a->cpu_bstats) {
 		_bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
 
-		this_cpu_ptr(a->cpu_qstats)->drops += drops;
+		this_cpu_add(a->cpu_qstats->drops, drops);
 
 		if (hw)
 			_bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index c2b5bc19e09118857d1ef3c4aed566b8225f2e9a..58a074651176730fd1bd370ba8420dfbed0d4e9c 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -76,7 +76,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		break;
 	case TC_ACT_SHOT:
 		action = filter_res;
-		qstats_drop_inc(this_cpu_ptr(prog->common.cpu_qstats));
+		qstats_cpu_drop_inc(prog->common.cpu_qstats);
 		break;
 	case TC_ACT_UNSPEC:
 		action = prog->tcf_action;
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index e1b825e14900d6f46bbfd1b7f72ab6cd554d8a73..065228026c58eb0f8ff3b3a08758e4ef0d6ea708 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -727,7 +727,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	tlv_data = ife_decode(skb, &metalen);
 	if (unlikely(!tlv_data)) {
-		qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+		qstats_cpu_drop_inc(ife->common.cpu_qstats);
 		return TC_ACT_SHOT;
 	}
 
@@ -740,7 +740,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 		curr_data = ife_tlv_meta_decode(tlv_data, ifehdr_end, &mtype,
 						&dlen, NULL);
 		if (!curr_data) {
-			qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+			qstats_cpu_drop_inc(ife->common.cpu_qstats);
 			return TC_ACT_SHOT;
 		}
 
@@ -755,7 +755,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (WARN_ON(tlv_data != ifehdr_end)) {
-		qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+		qstats_cpu_drop_inc(ife->common.cpu_qstats);
 		return TC_ACT_SHOT;
 	}
 
@@ -821,7 +821,7 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 	 * so lets be conservative.. */
 	if ((action == TC_ACT_SHOT) || exceed_mtu) {
 drop:
-		qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+		qstats_cpu_drop_inc(ife->common.cpu_qstats);
 		return TC_ACT_SHOT;
 	}
 
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 1abfaf9d99f1fce0fe7cafa2a9e35c80a3969ce7..4ea8b2e08c3a4dddfe1670af72a5d487a5219f5e 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -123,7 +123,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	return p->action;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(m->common.cpu_qstats));
+	qstats_cpu_drop_inc(m->common.cpu_qstats);
 	return TC_ACT_SHOT;
 }
 
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 8060f43e4d11c0a26e1475db06b76426f50c5975..b16468a98c55e32260e8d4cb1fe3d771fca65120 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -310,7 +310,7 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	qstats_cpu_overlimit_inc(police->common.cpu_qstats);
 inc_drops:
 	if (ret == TC_ACT_SHOT)
-		qstats_drop_inc(this_cpu_ptr(police->common.cpu_qstats));
+		qstats_cpu_drop_inc(police->common.cpu_qstats);
 end:
 	return ret;
 }
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index a778cdba9258c2c776ee5ba0751cca1b73c984df..bfec6b66841031cd566d0c2bdc3d120cec41e3e4 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -86,7 +86,7 @@ TC_INDIRECT_SCOPE int tcf_skbedit_act(struct sk_buff *skb,
 	return params->action;
 
 err:
-	qstats_drop_inc(this_cpu_ptr(d->common.cpu_qstats));
+	qstats_cpu_drop_inc(d->common.cpu_qstats);
 	return TC_ACT_SHOT;
 }
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index ffea9fbd522d8dd3311cbca0a55a3d133eaceae4..30c881dda6a366af40e94f746cf95af83d2f10d2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1844,7 +1844,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		if (ack) {
 			b->ack_drops++;
-			sch->qstats.drops++;
+			qdisc_qstats_drop(sch);
 			ack_pkt_len = qdisc_pkt_len(ack);
 			b->bytes += ack_pkt_len;
 			q->buffer_used += skb->truesize - ack->truesize;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a3d758f67ab43d17128442fd8b51c6ba7775d52..f9ef95e69f72870c8a6a16b7e7911d1287b8e83e 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -176,7 +176,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	flow->cvars.count += i;
 	q->backlogs[idx] -= len;
 	q->memory_usage -= mem;
-	sch->qstats.drops += i;
+	__qdisc_qstats_drop(sch, i);
 	sch->qstats.backlog -= len;
 	sch->q.qlen -= i;
 	return idx;
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 36d0cafac2063f3ba1133ad9b8fab08ce4468550..8ae65572162c188cca5ac8f030dc6f2054a7fcd0 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -389,7 +389,7 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 		packets += u64_stats_read(&hw_stats->stats.bstats[i].packets);
 		sch->qstats.qlen += hw_stats->stats.qstats[i].qlen;
 		sch->qstats.backlog += hw_stats->stats.qstats[i].backlog;
-		sch->qstats.drops += hw_stats->stats.qstats[i].drops;
+		__qdisc_qstats_drop(sch, hw_stats->stats.qstats[i].drops);
 		sch->qstats.requeues += hw_stats->stats.qstats[i].requeues;
 		sch->qstats.overlimits += hw_stats->stats.qstats[i].overlimits;
 	}
-- 
2.53.0.1213.gd9a14994de-goog


