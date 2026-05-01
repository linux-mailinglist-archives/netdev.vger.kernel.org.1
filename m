Return-Path: <netdev+bounces-283191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLbTK/2y9GnVDgIAu9opvQ
	(envelope-from <netdev+bounces-283191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:04:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89C4AD058
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF93B302A52E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165E3BED70;
	Fri,  1 May 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osCPjpTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0045256C70
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643960; cv=none; b=e+we/Zbjt3nG3g8iRVu37zCtLSO1L6LeiMeqbMQXxP6s9xNTlhe9KjdLMkH8wdhpp/b2L1NRVtcPJbN4RmFAhmbl63n4UUgFRgXlWXLOcuqZRjhRbPyIbfErPzjOEQiCu1NS8IOATWDXe4Ne+iYUCLNVJ4Yg+cMGcOXlHXnBA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643960; c=relaxed/simple;
	bh=APYTR+Nea49IaJ0BO30ycL7xntr97TWQqzTj99n0XBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kutr+3cqtADkRFuN4Xgt4t8PU0OhKQYUj7otk4WICvf8xor2nEMggzLmgWQnd4wSzbl+akkPOcGHLY4DANcp5qwE/dbd80KOKgsSjbBFnGK1ItLst01EitJ4y+TUTUgVCvXBaEQUDQ3+iFVb/27O4Q4JiCaex/3NMbEQzYtgkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osCPjpTA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79aa3a19ea3so34596017b3.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777643958; x=1778248758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJRK2bf5UH1r720BcY9j2IxhuPZk5fmlL+0f/AlvtzE=;
        b=osCPjpTAtOPyOeOX9CFg8Az+lYTGRYIIzt6km23R4w5kzAx8d0QsacGvseUecj/CP6
         055DfCkMy08zw52QFZF2FMFhivLH5n9B9AfMkSirc2reBgJllpcfIKq9doPQogmShlxD
         jY8ZPzxKS2kJbP+MkD5+OB2AgcAsyGZ7gRFT9cliwt88sEGli9+9tg6g37N5L5I7g5Uz
         rv36aOQhmS+uz250Ve/S7IcdQpbHmioIgqz8iY1SI28xmpa4bosI/Vz2GEcr2ZplDO5l
         wEzURYROSKJurpiYBVdodWcw+Wn3K1pklGJu4tdnwDdUhJfMIibLipXPBG99YaD+nOtp
         dUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777643958; x=1778248758;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJRK2bf5UH1r720BcY9j2IxhuPZk5fmlL+0f/AlvtzE=;
        b=jsFP5hPPEc+q/+Wkbl4wwhD3l8cGKnoK3pdkk8btVRVbDviUf3ZptZmZLvPlkX0ocR
         RFIpbul0QbcygW0nlYYreJcp69VPSejLg/u4LsS/q901UpOcLWGBHEbofk8rftSqwpkQ
         nnwKskO2zYJTOHwrCI7leNiJLgc8xzZbb12k2FJ4MRT/M4qNBSHjHY6SMBCeE6JSXmGz
         8Oba7JOBUA0B2xrvZGbFDAsEVP1cPa0r9JRf7cxBqOTg+cXLWWnPaV4sg05IoYgsYE9a
         hJeLrS6a7Qi+KWRioQZhM2xYBstPVfs0BicLc+3/M13Rev73kkkH8TBoPuZRGaLmUMRe
         SJ8w==
X-Forwarded-Encrypted: i=1; AFNElJ9PsLd6GwleSsR44Jc65grYVbVuEkU9ywYpZZkh02uox/gdTpCH+G8U25oqFJ+cjxyN7/5dihM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzGT4eQRtwRJO3PAxvZ59DmOrAnvceM6B+UFQyUKmL+PHBAqu
	nQ5Ulp1veCuAqEzkYtmjZBfe37RgrilAJfz6/gHTnyA8aPXz+0krtUln9j51Dh/w4PjEWVpABQi
	OKRWi7ULzendEYg==
X-Received: from ywii5.prod.google.com ([2002:a05:690c:a045:b0:7b1:82c5:9fc2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9a84:b0:79e:62cf:8254 with SMTP id 00721157ae682-7bd52838f33mr75422307b3.8.1777643957565;
 Fri, 01 May 2026 06:59:17 -0700 (PDT)
Date: Fri,  1 May 2026 13:59:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501135916.2566766-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: add qstats_cpu_drop_inc() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0D89C4AD058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283191-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,vmlinux.new:url]

1) Using this_cpu_inc() is better than going through this_cpu_ptr():

- Single instruction on x86.
- Store tearing prevention.

2) Change tcf_action_update_stats() to use this_cpu_add().

3) Add WRITE_ONCE() to __qdisc_qstats_drop() and qstats_drop_inc()
   in preparation for lockless "tc qdisc show".

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 3/17 up/down: 72/-216 (-144)
Function                                     old     new   delta
dualpi2_enqueue_skb                          462     511     +49
tcf_ife_act                                 1061    1077     +16
taprio_enqueue                               613     620      +7
codel_qdisc_enqueue                          149     143      -6
tcf_vlan_act                                 684     676      -8
tcf_skbedit_act                              626     618      -8
tcf_police_act                               725     717      -8
tcf_mpls_act                                1297    1289      -8
tcf_gate_act                                 310     302      -8
tcf_gact_act                                 222     214      -8
tcf_csum_act                                2438    2430      -8
tcf_bpf_act                                  709     701      -8
tcf_action_update_stats                      124     115      -9
pie_qdisc_enqueue                            865     856      -9
pfifo_enqueue                                116     107      -9
choke_enqueue                               2069    2059     -10
plug_enqueue                                 139     128     -11
bfifo_enqueue                                121     110     -11
tcf_nat_act                                 1501    1489     -12
gred_enqueue                                1743    1668     -75
Total: Before=24388609, After=24388465, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
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
index cbfe9ed435fd77422a181074980e5779190ab9c3..ccfabfac674ef8617faeabd2fcb15daf8a1ea17f 100644
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
index 13c6d1869a144738c52ffc462f06338bf8245fea..c779e72f153c93ae222ec5e57a9b859259730526 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1845,7 +1845,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		if (ack) {
 			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
-			sch->qstats.drops++;
+			qdisc_qstats_drop(sch);
 			ack_pkt_len = qdisc_pkt_len(ack);
 			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
 			q->buffer_used += skb->truesize - ack->truesize;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 0664b2f2d6f28041e5250a44fc92311116ae0cf1..8ba722faf7e3c37cabfecd58fd4937dd3c568444 100644
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
2.54.0.545.g6539524ca2-goog


