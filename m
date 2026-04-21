Return-Path: <netdev+bounces-280157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB2zDFqM52m89wEAu9opvQ
	(envelope-from <netdev+bounces-280157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFAB43C302
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75DC3086425
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A43D6CB6;
	Tue, 21 Apr 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLv2aWMh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF9387590
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782033; cv=none; b=OjEPqqivY7sTkib5BFKpJhi2FGyufbBcJvqHs/MatnsjeeBl6/X/5Tai+hKBFNWcf02A/4z+OAqO0HgHBmoOsXGcqe/lANRWqZXfAaW6YC0Hj9Eje505AGn0IJ7AhF87mtjedP3PTLA+5CtHxcG8lcltwyX1FpWAm7IlZDQor/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782033; c=relaxed/simple;
	bh=TkLjXVNRAceZKbFadq/HTx1I100PlhqvAC42FjFtx1M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TidM7KjSs0cKRsIzFpOb8cDNpeAzlKLP2sOpMJGQ/SXxF0jBmnzbp64IRUtAtBjpKETnT+h05NutqdEPHaex2l89bqvMDe6rNZwB+jnTA3W+hMx/gfzp/SBKkwFiWsoxjvDE0udW6gnz5CEBfBGbmpg4B0lNI2YgccZJ197qs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLv2aWMh; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eb55e55362so405748985a.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776782031; x=1777386831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=phBdw9+Q6ElvsmtyvIcgjAwkVvsTjBh7rGzHGQPHpmU=;
        b=lLv2aWMhdN1ChwwTJDDY2Br2p2Uvb0AohUdSS+NCAnJ/paP9qH2lw1JANHE7/kNTiN
         aCrI2B4q/oL8OOLcKS/MKUNRbHj32cO1tx9Be50BHn3jPIU5HyGzDifFZUKuXbzDVOo8
         B0SldZMA3mZDM3+Ahwa/HWi+wZAiycnxQeeh0vhnmVeVwxuv3KsBJYMPvyg/fSPENdFq
         vbWuv3vdU+RR7Jze/GDZJGrK11vsYg45KUMhL7Zqqvi8c33vaePFkq21Q+kn3jr0Yd0W
         5fnlCO9T4E6zkSiN7SlKxfcHtPzyW5HnbSHp0urNi+cNMUr40DK1ZKnXkW65T4Kw+H6n
         QvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782031; x=1777386831;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phBdw9+Q6ElvsmtyvIcgjAwkVvsTjBh7rGzHGQPHpmU=;
        b=Cu2wKhBk74UE2YAQGfRPmOwSZXDrwYZlfnKDn5Cj+d6DV5jBaXujgBDjsCLG/Izamg
         UkymEjvIIc6Cn7GB7qoN+VcjGZ4/9G/I/st7bIvORsMH3ObkL03kXGmXfBOETtu0kxDa
         zwpDnWanOrtdLvf3r5CCMJ+IABGlvNH4QLDMiEpWCv31eJDaaa7yHRBUN85roQIZSv+y
         yAU+HBNsZX7ZyunNtASZLL+uAid//0JZQzGe84zOxtZBSk2/eW69EzPgtGdVyLAmZnch
         2HWjCORyxOoHIc4hViTTwU2p+qgJK96miDg7ejULw62Y9A9bR5Jg3iE0aMK/gidjHKEw
         QIew==
X-Forwarded-Encrypted: i=1; AFNElJ8lgOl2ODDegnazN1GisdhKWg4um1YcaOvHw1lrfLV2PyCSZGW/rSNCKxozJealz8BkR49iQCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSSw+ETsb0EY6C/oKHF7OgUplo+8vh6pbJa+IeGdhmwnNlbEl
	wgCHcyXId8RpU07xTRb2U10qjrr418cSGF+3zy1xtggfu6d5BpkuVPN4Txm6pTD3KbQndxA/zNV
	VCW5CZFCgA7e0ag==
X-Received: from qknry8.prod.google.com ([2002:a05:620a:9148:b0:8eb:5e05:751c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:458e:b0:8d3:ccef:b2c6 with SMTP id af79cd13be357-8e790014bd1mr2671798385a.24.1776782030637;
 Tue, 21 Apr 2026 07:33:50 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:33:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421143349.4052215-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280157-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9FFAB43C302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hhf_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 95e5d9bfd9c8c0cac08e080b8f1e0332e722aa3b..96021f52d835b56339509565ca03fe796593e231 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -198,7 +198,8 @@ static struct hh_flow_state *seek_list(const u32 hash,
 				return NULL;
 			list_del(&flow->flowchain);
 			kfree(flow);
-			q->hh_flows_current_cnt--;
+			WRITE_ONCE(q->hh_flows_current_cnt,
+				   q->hh_flows_current_cnt - 1);
 		} else if (flow->hash_id == hash) {
 			return flow;
 		}
@@ -226,7 +227,7 @@ static struct hh_flow_state *alloc_new_hh(struct list_head *head,
 	}
 
 	if (q->hh_flows_current_cnt >= q->hh_flows_limit) {
-		q->hh_flows_overlimit++;
+		WRITE_ONCE(q->hh_flows_overlimit, q->hh_flows_overlimit + 1);
 		return NULL;
 	}
 	/* Create new entry. */
@@ -234,7 +235,7 @@ static struct hh_flow_state *alloc_new_hh(struct list_head *head,
 	if (!flow)
 		return NULL;
 
-	q->hh_flows_current_cnt++;
+	WRITE_ONCE(q->hh_flows_current_cnt, q->hh_flows_current_cnt + 1);
 	INIT_LIST_HEAD(&flow->flowchain);
 	list_add_tail(&flow->flowchain, head);
 
@@ -309,7 +310,7 @@ static enum wdrr_bucket_idx hhf_classify(struct sk_buff *skb, struct Qdisc *sch)
 			return WDRR_BUCKET_FOR_NON_HH;
 		flow->hash_id = hash;
 		flow->hit_timestamp = now;
-		q->hh_flows_total_cnt++;
+		WRITE_ONCE(q->hh_flows_total_cnt, q->hh_flows_total_cnt + 1);
 
 		/* By returning without updating counters in q->hhf_arrays,
 		 * we implicitly implement "shielding" (see Optimization O1).
@@ -403,7 +404,7 @@ static int hhf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
-	q->drop_overlimit++;
+	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
 	/* Return Congestion Notification only if we dropped a packet from this
 	 * bucket.
 	 */
@@ -686,10 +687,10 @@ static int hhf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct hhf_sched_data *q = qdisc_priv(sch);
 	struct tc_hhf_xstats st = {
-		.drop_overlimit = q->drop_overlimit,
-		.hh_overlimit	= q->hh_flows_overlimit,
-		.hh_tot_count	= q->hh_flows_total_cnt,
-		.hh_cur_count	= q->hh_flows_current_cnt,
+		.drop_overlimit = READ_ONCE(q->drop_overlimit),
+		.hh_overlimit	= READ_ONCE(q->hh_flows_overlimit),
+		.hh_tot_count	= READ_ONCE(q->hh_flows_total_cnt),
+		.hh_cur_count	= READ_ONCE(q->hh_flows_current_cnt),
 	};
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.54.0.rc2.533.g4f5dca5207-goog


