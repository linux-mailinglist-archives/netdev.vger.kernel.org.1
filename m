Return-Path: <netdev+bounces-282691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NITG1QM82mSwwEAu9opvQ
	(envelope-from <netdev+bounces-282691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:01:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7949F00B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69205300D4E1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F693E0C59;
	Thu, 30 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdMTv/9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297638C2C3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536060; cv=none; b=JdwPUttLU5XswiNhrOfuGrEwNt3OZJ63L3lok7w37eWaWMhY2oc+ByXLYO/c/4rUH9agYlGGJMRzfFUvdWZM9sybaGxEhhipLYmfGsY3vAGgq5E0p5YdpmobuLLAq0ezhcbXzpnZJv3653GTj0Fs9hgirk/VsOvyV18MsL7YWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536060; c=relaxed/simple;
	bh=siGNz3pJqCS/J5AVWIOJ/Y9sJNzc7+hMqKQJ5hO44Dg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FzKx/EowhsoRtEZN99rOnM4/InXca0zIIStjNQ1LCf+OTONCJkz33eT8eOm5SS4XO1hIs78B/hR9O6NUAkOGqwqBOYO06qNs3wJSVeaqyDbr6Dpg3gi0MWMNLECeMtyxEUBO3El1myowdT77On0gwNMkDHXqk0rCfqBZh879DUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdMTv/9w; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-60558a8571eso143308137.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777536058; x=1778140858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bqj9HyHsvHbqO5tTLuDmCD/RzSux7XnnsDokFfdl1wg=;
        b=NdMTv/9wn4kJuiTU0255bfc1SV4zSkxKoUXeCZ82mE0oKW4r/Ny+msFv3TaJ4L8B06
         +LZTJf3n4F5dZ6z7H1oIX5EeDRO7BPo4xTYDc7oqE8+NITP44CoUX2SfKkPjZkMILhjH
         DLn1AdHsPFnZgiMKN/e0WBSRiVYHO+kBfUmMoJiQmQ3R5ZXifBDrFyjJoF5wg9li/e2b
         jLCf7+z99YcRr5NCF2gH7+7lJstmuegrhDL/kDU/ijDtXnN+Z+iNVK6DS2ZU5f+/9J3Q
         WWmuHihEoHFZ9XWqrTI0iiaD3O2jOcwdSWhxpG8zXM5Z+x51UKU2d0Gss/A8+AMYd8m7
         sMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777536058; x=1778140858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bqj9HyHsvHbqO5tTLuDmCD/RzSux7XnnsDokFfdl1wg=;
        b=UspibSDnn8eXCSD49qTbGg7q6DtxZmWfvqzzzpa+Xrmv82X6Ce4ng/9U8ghhWsvnEv
         9Ho56xV2K5Uw+3ulAhNqNKB+N1/sg6ni3CYjEY4XyN3xgXNXJlAO2jL/TSDpQ2Y1TeRw
         yRaSRqk2tjffPjLDWuEP4aIGSmw7iX9c/rZ8TeoOLKf4fbnnXbk4vKEHAy1Wb/KeAClZ
         1Ld2qgfbuIxOgMsuW/3wJNsbiE/Nn0cjnHQoZJM8veYBUltIYE06h4YckTUC2ABdUk/G
         xwkEYSLG6NnvbudBtLT5xgHebj5Kag3ZCcKR/hjYTECWw6cmVaP404YP951IlMWQiSz9
         lVug==
X-Forwarded-Encrypted: i=1; AFNElJ/ipMmZffgFFe65Ycmm30BCQHQE4DQ6AwWzbWVw7x9v+VaOZV/eLtkmbeN+LnnaZeQp6kWENIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c8sTJXx1/FL6NQ8v1nVdX2Ii//lgmp+SQwEPlXsrWbhrdmQC
	Q+DMpUb/A2eUhQGUkc4ijgb8CrLMftbzpVZHwKLd/lcAOrp/2VgQ5MBsiGY6EDhhMbEYvGgJ1kf
	Wo000l/kAseGkwg==
X-Received: from qvbpd2.prod.google.com ([2002:a05:6214:4902:b0:8b0:2fbd:8e2e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4421:b0:609:2cf6:51d8 with SMTP id ada2fe7eead31-62ad1620f2amr677883137.3.1777536057997;
 Thu, 30 Apr 2026 01:00:57 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:00:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430080056.35104-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_pie: annotate more data-races in pie_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 53D7949F00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282691-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

My prior patch missed few READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 5154561d9b11 ("net/sched: sch_pie: annotate data-races in pie_dump_stats()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_pie.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index fb53fbf0e328571be72b66ba4e75a938e1963422..b41f2def2e2cc5bb09b663feea30a7d884d1dabc 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -219,16 +219,14 @@ void pie_process_dequeue(struct sk_buff *skb, struct pie_params *params,
 	 * packet timestamp.
 	 */
 	if (!params->dq_rate_estimator) {
-		vars->qdelay = now - pie_get_enqueue_time(skb);
+		WRITE_ONCE(vars->qdelay,
+			   backlog ? now - pie_get_enqueue_time(skb) : 0);
 
 		if (vars->dq_tstamp != DTIME_INVALID)
 			dtime = now - vars->dq_tstamp;
 
 		vars->dq_tstamp = now;
 
-		if (backlog == 0)
-			vars->qdelay = 0;
-
 		if (dtime == 0)
 			return;
 
@@ -376,7 +374,7 @@ void pie_calculate_probability(struct pie_params *params, struct pie_vars *vars,
 	if (qdelay > (PSCHED_NS2TICKS(250 * NSEC_PER_MSEC)))
 		delta += MAX_PROB / (100 / 2);
 
-	vars->prob += delta;
+	WRITE_ONCE(vars->prob, vars->prob + delta);
 
 	if (delta > 0) {
 		/* prevent overflow */
@@ -401,7 +399,7 @@ void pie_calculate_probability(struct pie_params *params, struct pie_vars *vars,
 
 	if (qdelay == 0 && qdelay_old == 0 && update_prob)
 		/* Reduce drop probability to 98.4% */
-		vars->prob -= vars->prob / 64;
+		WRITE_ONCE(vars->prob, vars->prob - vars->prob / 64);
 
 	WRITE_ONCE(vars->qdelay, qdelay);
 	vars->backlog_old = backlog;
@@ -501,7 +499,7 @@ static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct pie_sched_data *q = qdisc_priv(sch);
 	struct tc_pie_xstats st = {
-		.prob		= q->vars.prob << BITS_PER_BYTE,
+		.prob		= READ_ONCE(q->vars.prob) << BITS_PER_BYTE,
 		.delay		= ((u32)PSCHED_TICKS2NS(READ_ONCE(q->vars.qdelay))) /
 				   NSEC_PER_USEC,
 		.packets_in	= READ_ONCE(q->stats.packets_in),
@@ -512,7 +510,7 @@ static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	};
 
 	/* avg_dq_rate is only valid if dq_rate_estimator is enabled */
-	st.dq_rate_estimating = q->params.dq_rate_estimator;
+	st.dq_rate_estimating = READ_ONCE(q->params.dq_rate_estimator);
 
 	/* unscale and return dq_rate in bytes per sec */
 	if (st.dq_rate_estimating)
-- 
2.54.0.545.g6539524ca2-goog


