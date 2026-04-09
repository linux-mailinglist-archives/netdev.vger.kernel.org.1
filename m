Return-Path: <netdev+bounces-277144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE+SBxYf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A35133D004C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 359BA300C25F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0A358363;
	Thu,  9 Apr 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRYSFWwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3A355F47
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771379; cv=none; b=fabJgoWhJQLiDf+JBCYb4TvywHmirLe8QtjFUxm8dTjCnv3oMubapy5Ma5ii2bb9rjiPGJ37Albd8OrkYeCLlYMhPINQBUlrh7ZDAfTwzs2wR1ywl0iU5oZYDsCrXk0tq2Erd0PqTObhn7jlo9mQeOcitLd12Cw11ansoJjiMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771379; c=relaxed/simple;
	bh=T9tmsoNDi9EwJ9IudjdOmWW1iLs+gy8wbVDhf+VDlTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jodiu0gYxwG5f53EgQgX9j3C8ha9y/emcOEmQBhLKBSBHmZNItbzZjrGKt9kRBE1E58umg5BKkVa2wTgX3Q+EDEnot05DLUIIKPqujm9fgB+Z37J3k7kfH8SUwc+FEl6SK5kGmaucrbrI4ZCKlXOiWRsSlAl630p86HTRDaWkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRYSFWwx; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d9a6a853bso37199261cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771377; x=1776376177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=rRYSFWwx0iBWgF7P/Zl8PV7xMhKH96AoVuRxi7QFOTlHIs60obKP9tunEU2jY4354q
         2CbV8pyAcB3V9pgp2Ll41UZv26staJa902vcbC9FykjWnxbgUTmeVO+v/zuTvlotqJxm
         wjM+Hv+wQL94Pq2NUjL/w3E5vGurMgVl0LELAuAlu78RZVwt2QE0ke+Zia4lK03qGt4j
         Nyg0snneHrJK4gNZf7Meui06bXm4EL7cljJrHi7b/sQjrxOZy53V8dxFbs609W4cZvYA
         74VWPOf8dK0QwB1H2v71kPrufF95sOvUFpwWhU6THcbRfbQsJ+c2rIdLfn2XF3b87EHh
         997g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771377; x=1776376177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=IQy67mx8UQShayjpXYkhX2cAnDMn48sF5+l2HISA4b5rwWmPd6j7vHUhI+G7wtt8y1
         TwtvZeNEA6oNTZ7RqxRVb5RZ6xOdPqZkjsTZrNQsRdeGpEDbN5TNCefvRHYvfUPqyFq+
         TtimaGRBfa4q/lGHray+Ha0zn4MxbmB6MABvGLrWqRrYntCrZOTBSSTjZFgeHnjhStVc
         Iuh/7yXTQwb8ohlt0X4o/rjxQolDyf97ZMcKzVG6sq+XU5SNJ0GAgT2Jw2PEvUMEGqIU
         53TMwu2a1NuhVnp0u8nqM2hro6romrgCL3SDNPlEqReJtEnR6TRlyOHHftFflpY3W0w3
         h3aA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QEFoRjZOPVRQOB6nOtf8uJo0dy1XKKcduvU2/EFosrYuOtE9NwHVOPt0RnYx4gxGOG40rPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzu8ZjvAo6aEFvdP5IteUqNkW/Bu5PDTkfgWmfski+ch7w0S6q
	OGbzqXS9P95z3HD3XupwXGN6aZsFfo7wuCsjYwbic4R6c3c1XWDzadgHxXLz1Si5XExlHYr/rQg
	WnaHvnqqTCf3MMw==
X-Received: from qtcr10.prod.google.com ([2002:ac8:7eea:0:b0:509:c07:57ff])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8a04:b0:50d:855a:8909 with SMTP id d75a77b69052e-50dd5b7cca7mr12577991cf.32.1775771376587;
 Thu, 09 Apr 2026 14:49:36 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:10 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/15] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277144-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A35133D004C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hhf_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_hhf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 69b6f0a5471cb9a3b7b760144683f2b249091d89..1e25b75daae2e5de31bd212dfa1f6d7aea927174 100644
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
@@ -404,7 +405,7 @@ static int hhf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
-	q->drop_overlimit++;
+	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
 	/* Return Congestion Notification only if we dropped a packet from this
 	 * bucket.
 	 */
@@ -687,10 +688,10 @@ static int hhf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
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
2.53.0.1213.gd9a14994de-goog


