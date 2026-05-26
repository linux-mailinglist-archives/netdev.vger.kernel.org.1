Return-Path: <netdev+bounces-291702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJeDIZ+jFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:43:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1695D6BFD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E33F1302EAB9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A13BB125;
	Tue, 26 May 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dplwvnbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3C3090C5
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802878; cv=none; b=aECHAWZs32YZ8lMTBfuWkiXiwiGs2lx+HtYTVjhr+DaWBuUyunkOn9xnp+JV9VL4UGM4s0BThSDWant54pAI4ucEqKKHMAI5JrJYbu0AuGYoh2AJaUgrfgIlbBYFHqh4VMDjHf98ADHlBc6mdnyCuWQP29lBqaQz2nsR5VCYs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802878; c=relaxed/simple;
	bh=9v1sUMdfYkmbYt9CppkeA7b8Zxa1uakTQYtE13SyF2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayfmfrKsVcQ3bFnsUOGUmRidduI72bXdflI/1ckBGg48AeuOqlj5hD0A7rO+VKSNzzdEmj5WuR8Co2SSmAa80XssZSXEzcuFncO5YHRBdBUyUd0Wy3acLreeurE0oAvTxHddfY7S49w5i81yviT7mwgocRb+F9XwaHOOsdU9Gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dplwvnbI; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7d1bcb92072so54829197b3.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802875; x=1780407675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JffHk4bxOZhtUUQQrN+vUeO1yaGwS7D/G1yhVu3O9KI=;
        b=dplwvnbILWvUhALkpJa5O6I8Ls9MjysYtNH+Ew0KToCty9FNYdEDfWdNFHLl8Tl+xc
         Cy1jWyB3sTmoofs3ehNHt2TjPZmSEgJxuw4qWW0Q0NCsfNc8lTknKhDB5w4T/rB24Fsn
         w7gPkiLz53uvzRv1SnCD/Gkur5zviLjNgK/zopVCLF1Y0db2rV0WETamtAbLK7bbJjM9
         P3ssWmSV5raUfCrG+O1uBLU/D5fKERtHxiZdUfaMtNW7T9ZIDxzhyRUvCCzE9IKLHqNL
         m55pQQNGO3V7oxXFKf986yR4UnbOekTxkE9pCbxai8AzbFzD/kwuCKwvmlMwCyS2Hjnh
         7V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802875; x=1780407675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JffHk4bxOZhtUUQQrN+vUeO1yaGwS7D/G1yhVu3O9KI=;
        b=VwngfAZxcwYURMX2QVOlT1ANPw73L/Z6zA22alrIr3ebS7m+ncu1Ud5mfhojkE59Fa
         xJPDHTPfoObbPpSQ/yly217sMYqDe5DwYGxgnkvrnOn01JysWlutYtexU/K3zTkbFA1+
         Qb/7PPyrUlMqni33z5bYow8CHIKxtGUnkMPiDs5bvMY8hkuQ/mP8r4uNuXIE6/4xvou8
         BebS8wMusiLmkJ6KKEKGvKeVvxM6HrDYV+oaHplr3MyqEbJTfr31QAONVNUqctDvdKLN
         nPxubj/lWqLCUG3olJO6tKY8YqauBJm+73PSBJBOvVu2d/M8zt6cqa6Grbqbxx6XL79B
         1CmQ==
X-Gm-Message-State: AOJu0Yw04/+XS2hrb3IYfzHC2qO2ROXNjxaRkm9e6IqLsrhNrIHjHCrO
	eaE0SpwvOf8r5KHti9mNoQ09r0/VVhW2Yh7Ssq0PMDbt5vDbqPs3QGGDyrKQzw==
X-Gm-Gg: Acq92OF8D7VYAvUpLjjAdEoKodKYrlXoA7RyQmXN0sjFauLILGbfN1wUDP6shZtZGL1
	bhr+eHJWa6sIeJsVvqthoGncyz+Maf4A0CAarH/wgVYzwnTGHlNqiIbZmum6nGPTOoQKMylxcTM
	NvTXK1jXGMVJYRNWTpQvWu7/pqcw7S4UssD2Xte855ZUpaRehBSTqVuGuQjUlSEgHqAVbjuuZ61
	xx0wAAWHBHQSVycXSyrjq2Ys+5HG7LBxlAOl/Pxz5jO7Z9hjKniGwNaMrem6MU9c2pOYNxZs9+d
	TTPmPjDl6anxAMblY8513pi3pg+W6saHlErp0yEHO8/Gs+6ws72D4MruTBL9ESPx2bqWB2kyMYI
	cFDjDnn3saCFPQ20e24mjWzivscO+zSMoZvQ4DMLn2AjwiDTBLaLmLeFe1vO9P16WJogH7Fp2A6
	NZYE2UNL7IRG2zsiRl5QC+V2ps1CeBl02UDvgs6nNs7XCjpC6vOrOVookijhSY34rlMxUxD7qzL
	ZsThlfU70BLaFWzvBMFiOeoQRrlng==
X-Received: by 2002:a05:690c:d19:b0:7bd:a4dc:c262 with SMTP id 00721157ae682-7d33b3490d5mr177361427b3.50.1779802875401;
        Tue, 26 May 2026 06:41:15 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38bf2f84esm60663957b3.31.2026.05.26.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:41:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: update flow delivery time on earlier EDT packet
Date: Tue, 26 May 2026 09:40:37 -0400
Message-ID: <20260526134109.2624493-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291702-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,so_txtime.py:url]
X-Rspamd-Queue-Id: EB1695D6BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Willem de Bruijn <willemb@google.com>

When inserting an EDT packet with time before flow->time_next_packet,
update the flow and possibly queue next delivery time.

Reinsert the flow into the q->delayed rb-tree to position correctly
and to have fq_check_throttled set wake-up at the right next time.

Factor RB tree insertion out fq_flow_set_throttled to avoid open
coding twice.

EDT packets do not take precedence over queue rate limit. Skip this
new step if a queue limit is set. EDT packets do take precedence over
per-socket rate limits, as can be seen from fq_dequeue reading
sk_pacing_rate if !skb->tstamp.

With this change the so_txtime selftest sends packets in the expected
order.

Fixes: eeb84aa0d0af ("net_sched: sch_fq: do not assume EDT packets are ordered")
Assisted-by: Gemini:gemini-3
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

On net this has a conflict on so_txtime.py. Treat this as an
improvement and send to net-next only (not stable material).
---
 net/sched/sch_fq.c                            | 34 ++++++++++++++++---
 .../selftests/drivers/net/so_txtime.py        |  2 +-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 796cb8046a90..33783c9f8e16 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -217,7 +217,7 @@ static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flow *f)
 	fq_flow_add_tail(q, f, OLD_FLOW);
 }
 
-static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
+static void fq_flow_rb_insert(struct fq_sched_data *q, struct fq_flow *f)
 {
 	struct rb_node **p = &q->delayed.rb_node, *parent = NULL;
 
@@ -233,14 +233,18 @@ static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 	}
 	rb_link_node(&f->rate_node, parent, p);
 	rb_insert_color(&f->rate_node, &q->delayed);
-	q->throttled_flows++;
-	q->stat_throttled++;
 
-	f->next = &throttled;
 	if (q->time_next_delayed_flow > f->time_next_packet)
 		q->time_next_delayed_flow = f->time_next_packet;
 }
 
+static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
+{
+	fq_flow_rb_insert(q, f);
+	q->throttled_flows++;
+	q->stat_throttled++;
+	f->next = &throttled;
+}
 
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
@@ -539,6 +543,24 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
+static void fq_flow_adjust_timer(struct fq_sched_data *q, struct fq_flow *flow,
+				 u64 time_to_send, u64 now)
+{
+	if (time_to_send <= now) {
+		fq_flow_unset_throttled(q, flow);
+		if (q->time_next_delayed_flow == flow->time_next_packet) {
+			struct rb_node *p = rb_first(&q->delayed);
+
+			q->time_next_delayed_flow = p ? rb_entry(p, struct fq_flow, rate_node)->time_next_packet : ~0ULL;
+		}
+		flow->time_next_packet = time_to_send;
+	} else {
+		rb_erase(&flow->rate_node, &q->delayed);
+		flow->time_next_packet = time_to_send;
+		fq_flow_rb_insert(q, flow);
+	}
+}
+
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
 {
@@ -596,6 +618,10 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Note: this overwrites f->age */
 	flow_queue_add(f, skb);
 
+	if (fq_skb_cb(skb)->time_to_send < f->time_next_packet && skb->tstamp &&
+	    fq_flow_is_throttled(f) && q->flow_max_rate == ~0UL)
+		fq_flow_adjust_timer(q, f, fq_skb_cb(skb)->time_to_send, now);
+
 	qdisc_qstats_backlog_inc(sch, skb);
 	qdisc_qlen_inc(sch);
 
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index e7de8fe22c1e..5d4388bfc6dd 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -53,7 +53,7 @@ def _test_variants_mono():
             ["zero_delay", "a,0", "a,0"],
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
-            ["reverse_order", "a,20,b,10", "b,20,a,20"],
+            ["reverse_order", "a,20,b,10", "b,10,a,20"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
-- 
2.54.0.746.g67dd491aae-goog


