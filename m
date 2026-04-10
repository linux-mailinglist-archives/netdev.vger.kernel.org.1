Return-Path: <netdev+bounces-277511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG72KdFA2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111113DB71F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7786130179D4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF93E2758;
	Fri, 10 Apr 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+epxBNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D178F29
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845406; cv=none; b=aUkAXAyYJ3j/PkswX7WiWFlzALIJl/2d8pW5nQTTV9ZDNQweVg/lSgintDVmsjbfW4zS2dWYKdFpDiDd2SqA2NRy+uISQVX07gbmlXHM9AVkaI/XO9JzUaK0fc4qSTQ0JkIMqj85+XrmonRXnpEPHrHAes6aBaWGJ2pIQTzkxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845406; c=relaxed/simple;
	bh=T9tmsoNDi9EwJ9IudjdOmWW1iLs+gy8wbVDhf+VDlTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZ6ry2avLa4ua9eIalvt/zGMEe3haXjMgDTw9j2oxJszpAc8HbPs5Wiz4GwvhwYB/TtCjGJzOxUz4WkbK299DGXmgoi4re4P/J1j7NRRZINpc6pcyq4TVy9GuJqe/7tn/L2p/G+WclSO5tfDwO2kfjXJHamHCzz95WKlj8LUkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+epxBNY; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8d57516c889so128799085a.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845404; x=1776450204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=G+epxBNYK57zdd7buzWVqD+aSjctY1+gLmb4ck4JEtcpPDjeLshCqnG9lhnZhsHH6R
         kkAB9Q/XsLo/NNcV5kZ2oPeNqIK6E6Eo40TjPZE614lSUTOXEXNixgaIn7Up+WkVszAN
         VEnmDzo+ip9neOGqmuxCtDC5Hmg/F4muPNpeJ2/yidC0qcmIfhesK80FX/CR7qSdwwwL
         gCDjIQPQTiYM4insOXzNOFTMjxYA9Rnwf8rp8EkVFRBg2gB6bshN3NHmnb/M2HKBOkwB
         W7dUbdxe02MQj62c63cvnA79medCemr/zPDN8gde50eBCzouzYZMsulrKCOiODt59ohy
         Qatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845404; x=1776450204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfIeb29DIYWv7AbwoDoluUX/yJHqHXJP8AnpkO+hKw=;
        b=sEqYl3FN1r9qQHBocQh9TFwd/1z/MtEfMZCEVFlxobgBd4RuXnJXOKLH6idJZ3Oyrs
         /R1xbnbaWE50/JvCa6YeVia0hgNopqfgKuYJnf3RRJxcG0jWWqIHbwRhuY93VSM1htnN
         BBt888/qHnWvr1VBkMtGpjTePWhplRuRo+8E4FztRVlEBPlX4QOciQB4Fgmn/IaLN5JL
         ubcCswwMODtzHZkqjbFnOSBvS2uiuZ9ovFsYsXaUIpeQB263pj0408pBENKKrPs73yJS
         T/rl1NVrVcZrYQh7XLoXa0ix92rtrYHMJGGDM2VsqHR4lyFurP+qRH1qVhFd+GnNxa7a
         WFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDRyb2KfhmsjsDBtKx/nsBGeRJgXJd3RvYn23uGNopfBwYgsfjyDsR/J6nTbLGMm6sDnKiPws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJQwshvkYGnc8h+2B6x8b5MLF/IrOPbb9v9LAMMAve/m8xzBI
	l7mMlxUd/+AO9eF7nqxrYu7Bh8ANRUDAVy/zqQUoPmvjDJnN/s4idKPBKwGUA3uUZENuoFVuzX8
	PItFrp4HAUNUWuQ==
X-Received: from qkag9.prod.google.com ([2002:a05:620a:2189:b0:8cd:8684:7bad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2953:b0:8cd:c01f:fd25 with SMTP id af79cd13be357-8ddcd5ff659mr582266985a.14.1775845403716;
 Fri, 10 Apr 2026 11:23:23 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:53 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/15] net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277511-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 111113DB71F
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


