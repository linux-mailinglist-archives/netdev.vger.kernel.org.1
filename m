Return-Path: <netdev+bounces-257310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AME7F+8JhWmj7gMAu9opvQ
	(envelope-from <netdev+bounces-257310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE71F795F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EA53300231B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55D633065B;
	Thu,  5 Feb 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYrIMf/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BE329E46;
	Thu,  5 Feb 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326509; cv=none; b=D+7kvlzyn6MmeZT30a9Ne748wcHJhuxFPapXU854yFFta+gDdxGJtBBEBRNrNW2sWCOZUAfxEG6fLysg2MqjoNlO8untqD4FtsbMoswpXBYO2yZsIldT0BBYtpftZnnj1JRNbUouU/8s7E1rLwBxNX/fUmh1k/eXMC1KiyerhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326509; c=relaxed/simple;
	bh=Bup6bqy51nLskK4r7e6B2aiti4ZAaB1Rsbevgd7k5i4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyw/9rQNFYJwKRjI//vlqaPNI8ygALEweNuo7+kT2aLROhjSej4w1zmzE+OahasX//5of09BtHn4TdPaOntW396TCMT/BK4fpVhxbO/NqcN/2Lbt097sdhlOTM+XyT+UNq8G+mzOZmIU7Bx1VXKhbViNKPjuZy4UpUx9F9JidrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYrIMf/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED29FC4CEF7;
	Thu,  5 Feb 2026 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770326509;
	bh=Bup6bqy51nLskK4r7e6B2aiti4ZAaB1Rsbevgd7k5i4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tYrIMf/QfebQ94RXURtsaX0NgpWK4ZUdneZeMYfvLyaeBE2PbXJc6h8OyRf8v5f/J
	 A3FPWwAko1uJyi7IMMNZEpOaLkxluabdyKx4SSeS3h465HtlrFe4XWxzrpPQAtYzUi
	 XJB06TlVCjP3RSY9hC+0jHl9lyvcQhu9SXy018kHak57qXmaFEqVApTj79/O5gzzLu
	 ciHmyNOctjFZs8x1Wqjp0FgaPtD6mHsl0CpQQ8MQ1Bl1O5X95CXqG8Oi9nJBL3KktX
	 Ec+4zBmqI04GBRlD0YJhEdRSLkV6diN/4Tv3n/QmP3yHy0lJxUY5YcbncgWEmNVrgP
	 VItk3418pZs+w==
Subject: [PATCH net-next v2 3/6] net: sched: sch_cake: use enum
 qdisc_drop_reason for cobalt_should_drop
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 05 Feb 2026 22:21:43 +0100
Message-ID: <177032650389.1975497.10621533594128432316.stgit@firesoul>
In-Reply-To: <177032644012.1975497.16411100029657607833.stgit@firesoul>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257310-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE71F795F
X-Rspamd-Action: no action

Change cobalt_should_drop() return type from enum skb_drop_reason to
enum qdisc_drop_reason to fix implicit enum conversion warnings.

Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
comparison logic remains semantically equivalent.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 net/sched/sch_cake.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a2d1b292600d..da3c347574d2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -497,13 +497,13 @@ static bool cobalt_queue_empty(struct cobalt_vars *vars,
 /* Call this with a freshly dequeued packet for possible congestion marking.
  * Returns true as an instruction to drop the packet, false for delivery.
  */
-static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
-					       struct cobalt_params *p,
-					       ktime_t now,
-					       struct sk_buff *skb,
-					       u32 bulk_flows)
+static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
+						 struct cobalt_params *p,
+						 ktime_t now,
+						 struct sk_buff *skb,
+						 u32 bulk_flows)
 {
-	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
+	enum qdisc_drop_reason reason = QDISC_DROP_UNSPEC;
 	bool next_due, over_target;
 	ktime_t schedule;
 	u64 sojourn;
@@ -571,14 +571,14 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	}
 
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
-	if (vars->p_drop && reason == SKB_NOT_DROPPED_YET &&
+	if (vars->p_drop && reason == QDISC_DROP_UNSPEC &&
 	    get_random_u32() < vars->p_drop)
 		reason = QDISC_DROP_CAKE_FLOOD;
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
 		vars->drop_next = ktime_add_ns(now, p->interval);
-	else if (ktime_to_ns(schedule) > 0 && reason == SKB_NOT_DROPPED_YET)
+	else if (ktime_to_ns(schedule) > 0 && reason == QDISC_DROP_UNSPEC)
 		vars->drop_next = now;
 
 	return reason;
@@ -2004,7 +2004,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	enum skb_drop_reason reason;
+	enum qdisc_drop_reason reason;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
@@ -2225,7 +2225,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 					     !!(q->config->rate_flags &
 						CAKE_FLAG_INGRESS)));
 		/* Last packet in queue may be marked, shouldn't be dropped */
-		if (reason == SKB_NOT_DROPPED_YET || !flow->head)
+		if (reason == QDISC_DROP_UNSPEC || !flow->head)
 			break;
 
 		/* drop this packet, get another one */



