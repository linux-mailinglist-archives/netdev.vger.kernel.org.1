Return-Path: <netdev+bounces-276526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAgWCr9Q1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6ED3BC795
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41825305ED99
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313183C6609;
	Wed,  8 Apr 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYBiyWJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668A3C8700
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652996; cv=none; b=IG+QYdPm/bBaRI5awxi5aSfPuhEHtwL1Jz5ne5aMa0PbD3ZMS+KETxo9DLOq3WkQ0wzw4+BhAuylWY1kJ6nJdTUrlB9O3rB5cFHxA4aqcRyeQi+0BtnD1d4qfc+DWEgPoaHyA4i7UqrzYd8RXtzLjbaewp32fqfE8tnSJsxZ/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652996; c=relaxed/simple;
	bh=T9tmsoNDi9EwJ9IudjdOmWW1iLs+gy8wbVDhf+VDlTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPjTV91MLM4NrhSq2V08uRtN8/12YxYptVuv+s5Kk/k+UlNBIvk4xbrLqZ6KDljR3O88Pt8bOzUQg9gCYos8rSprlqqJcP39ZkTbRfVuRj3PZEbAqEdvkcz+OuOWPH1rwYXrmGmXjFE/Eilo4pBJlkphZgUlCQGhpp0O3Upes6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYBiyWJq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50da529ff48so46890691cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652994; x=1776257794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=dYBiyWJq4+t8mVIep4I3fx0p8WHbaBgSF9ageLjJWUOGulcnqWniJiL4x1XasKfkN5
         75vlutAQPSrcTSM5ZcQuq/Hr0rPebWBcTY12Rfw4f42askLcYKBR9lwDjCEU1bMWBYrP
         /XQC4iHgCuMvjNuj0HJXBogTW/QCRYG3v8IuMx2ZG3zA9hOPmx9H3fxGZqyBzu/7Kmtn
         vd6ifZyZxFYWFruvj29Njy9xEN8WFvATF1GGK/OboZqD4zoeeIzm6Tz6lwldHehiXqNF
         6SGiOJIelFbqoqwPJEWqeO6pQWDwEZzSxMVAvhJS9bU7VrX3wwd52k5LWF6wUhfxQl8I
         pv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652994; x=1776257794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=GTwtszaQIr59gxVqIzKWCL2jasPOPnNUofpET6UzxEy4MjiSaiCqIJmIa3mG876LGI
         Jzhk8F6eXKizOVYQfXZ6Y1o596hdsQzmrOwHIYWjQ7HsjALDP770VONOUzfrjvYs/ayA
         RiDsgPzkNrKU2s+7HyPXAJcYHExz9pnw8RZIukjzxu3oXj0OBTuOmzaXLoVHJXGuhPdM
         a1W4pJ9ksN0tHu3WauR2NKSYE1KpOvWhI2FQce4Q46C5045Js9JoBKKlM1j2tEr+MeLE
         MWiKBjhBsDt8h/rMD+q6gbpK185Iy+2leHLVdNJwxUc5NXNWfkXsQ9sozFgBWqLol7Az
         x9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVNo42T7SP5mF+mHe5HcVEbKCnbaxv/OF5FbWI3dnfbLTPNS/mGAjqOl03D/YAx1+/6lfjyVZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdJeeAoTsKQGHeEZgm8NA0Yr2EzqlWAlrkUDebhYqhEam6ynl
	ZJTiDvG8hELiEbYF43fmRq+S9SfxajsX6VMzIydkCbTpwrEdDgSzvdjhi2ei0kN40pndxzDCXVA
	toeTjQmPEwqXiEA==
X-Received: from qtwv14.prod.google.com ([2002:a05:622a:14e:b0:50d:9e35:765b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5703:0:b0:50d:743e:439e with SMTP id d75a77b69052e-50d743e51e7mr235656131cf.3.1775652993410;
 Wed, 08 Apr 2026 05:56:33 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:07 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-12-edumazet@google.com>
Subject: [PATCH net-next 11/15] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE6ED3BC795
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


