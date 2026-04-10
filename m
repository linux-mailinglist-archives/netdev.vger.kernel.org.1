Return-Path: <netdev+bounces-277518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLhqM1VC2WnCnwgAu9opvQ
	(envelope-from <netdev+bounces-277518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:32:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACF3DB789
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32A3301DE0B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EB33F8A2;
	Fri, 10 Apr 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKrF/S5J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D226A0D5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845908; cv=none; b=UEP/X8FFQv0u0kQKheoZtCiIZdqSUKcS2RekElf7gYlqyOjCa1gSVU+Sr4GWTgCIuopZZUSXo0bgWf8oZQSHcZbZPOweVxsmNYZvDMA0Bq/EUhjnx3K/4RncV8i9GETuFvzA1lTJFbyOxFITsPoM2jjtA9wXDZeVpKUCFTqp14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845908; c=relaxed/simple;
	bh=mbqVwp44Oe8sIOKokgrfuqgPziKh5eJCA5KdDUt5rJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g39+yJYXEXpBK1aagbJFkgEIzJLUKfXiolGqovFTMaQxCwm1bWUxzTEaPk1owQbUDmApDxQxwnEpr0ejzbcm2GPl/dfFFRmOOwoGRq5qzB1DOiqFYKqFR/76/6hrTAiVGJ6LZIDa3qLab4CprhUUsmwu/Uh9r6ul/V1yOKZ0L/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKrF/S5J; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7d7efc5a904so5108802a34.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845906; x=1776450706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=CKrF/S5J0RL0/Mn+Lrdd8o+A3dw8VbaUeNIvR3uzSHXYH+C18Qd5H3eM+atKsBlXtG
         u08o7HAWvBrU8zwKODrCmtt/bAMXUBv3dpB1KdiPYamgpPP2+WsiuGSMbQEbsCN2VCze
         hkjY4ZIhMTkKQNoUCfjS3o8jPnGohURhN2ZrO7l53/i8vbQIT5VowphZYDkvqqt1jmY+
         I9RSFIQSG04e5rYscyxxR6XY1UN5ITJJ3s7a23DX07lKq4lirk93OPvaPnyL3vEA4OhC
         E9VamOw7xqhStnZTfCD1wJA8Oteu4+/O4U/QguPRqKg4XJpKapjzO1QoRPOGFTxLeIKr
         U2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845906; x=1776450706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=kDCGzDz2jK8nptaZ7u7k/NGeBge4QqJ4VzyHpsDQELXpWOWiwEscz8SsnAer7yYk69
         BAaqw84rsD4wrMXDPPiAdVQMoW9rpbKi1sixqe0bWfwfgt+hFcDntSTDYrReAY6l3cKA
         1+9UIDv7shxn0PEwwA+lhi+9u5kXHAa/K01VPHiaAPrFpeOxSCJO9wZcZluM663J/W3h
         h5w2hJh+XznvFT9nS7/rTeyIs8x7Ji4tQ5gGQqGHEYw/FFVeDVVse8oMJo3C+CmRnCBn
         D8DQUBVd50VbC/+bhcd6TzgMqTzLYIEqShQ//Fv2Qk055ajpNAMAYD2PW0ez+UMJCuNk
         +5pw==
X-Forwarded-Encrypted: i=1; AJvYcCURvVptqDa1nMimXCwWkI3a1PqRJpzYZGbHhVD9MB7lN2E/JlXg1r3wsDg7M9sDIUVQNLqmqCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf08hVHzoQ7BJ/9D5GAf29NIr7kRGNdMAoIgMMTnyw8HNFe8kx
	/1fRuXG/vnHdlqplrU12MqmrSNn0suTuajpaWEfPwJwfDYLXJTDTJ2BGn39GQDQyjEDvr2MVw2B
	IdKyoZPs1X2/NHw==
X-Received: from qtbfg10.prod.google.com ([2002:a05:622a:580a:b0:50b:3c2a:bdb3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:20e:b0:50b:9024:53bd with SMTP id d75a77b69052e-50dd5a80623mr62348501cf.6.1775845401933;
 Fri, 10 Apr 2026 11:23:21 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:52 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/15] net/sched: sch_fq_pie: annotate data-races
 in fq_pie_dump_stats()
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
	TAGGED_FROM(0.00)[bounces-277518-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 25ACF3DB789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill tc_fq_pie_xstats with live data.

Alternative would be to add READ_ONCE() and WRITE_ONCE() annotations,
but the spinlock is needed anyway.

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_pie.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 197f0df0a6eb06ab4ce25eefe01d32a35dbd84af..72f48fa4010bebbe6be212938b457db21ff3c5a0 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -509,18 +509,19 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_pie_xstats st = {
-		.packets_in	= q->stats.packets_in,
-		.overlimit	= q->stats.overlimit,
-		.overmemory	= q->overmemory,
-		.dropped	= q->stats.dropped,
-		.ecn_mark	= q->stats.ecn_mark,
-		.new_flow_count = q->new_flow_count,
-		.memory_usage   = q->memory_usage,
-	};
+	struct tc_fq_pie_xstats st = { 0 };
 	struct list_head *pos;
 
 	sch_tree_lock(sch);
+
+	st.packets_in	= q->stats.packets_in;
+	st.overlimit	= q->stats.overlimit;
+	st.overmemory	= q->overmemory;
+	st.dropped	= q->stats.dropped;
+	st.ecn_mark	= q->stats.ecn_mark;
+	st.new_flow_count = q->new_flow_count;
+	st.memory_usage   = q->memory_usage;
+
 	list_for_each(pos, &q->new_flows)
 		st.new_flows_len++;
 
-- 
2.53.0.1213.gd9a14994de-goog


