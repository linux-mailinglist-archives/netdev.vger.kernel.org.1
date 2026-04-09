Return-Path: <netdev+bounces-277143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMUeIvke2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B13D0026
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB168302493F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EF2192FA;
	Thu,  9 Apr 2026 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmwuAUTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D79358363
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771377; cv=none; b=aayQp/zj0YW+m/h62i5cw2rWSlePtLcX86ogXAj3FfsPtkBcXw1kMjJagjV0nR8oxOrydvj814K31hozeDdTdaTBkjaIL9IzcHhgVXlKD+kpta49WtnDYS62ktiZoxqqtWcbfBRcURBFVl9YbuUPw+G6BhRUqkjS0jxPGh+jJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771377; c=relaxed/simple;
	bh=mbqVwp44Oe8sIOKokgrfuqgPziKh5eJCA5KdDUt5rJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXGDX1qFKUhT1XFuA/FRNTV+MHnul6W5axZu+aVOFt+OUDf1M8Jjh2xT9pbTwKzL3DW5EWnwhE23+hfxII39d+th+tT/03jxj8MpgdAS4epoXClmS0V0JF8R/qbeOARfdl5tYjxBRBPRQStSVNBck3u6TNRUPAcPP91TJmCFRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmwuAUTB; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b3544bc7bso17709521cf.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771375; x=1776376175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=NmwuAUTB1uQRAF6Hz/Mg9dMg84nHhhPZC6K2qPL+75cq8S0q7ZMrUuinw2kZo5/msS
         d/VhUxGVnjD+Ti1TKLBSAmjldGeSHYHHo2Z9oMglx39WAo1N7ETyCcpccGara0qmcmQK
         CotQwOPsftREC4ZETMRurEnxuDdymAm71HYplJm3ejpz005CRIiKeGN3A1VjFlleQkzb
         7g6UNes1YeTa/gFtX45Bl2LlwSTd85whnniI8R3gTm0SRYrwjnB1KtbeAFG8Lq+8Lw3a
         hpGYWo2z/V0WWkAF1wsn6EIe5GYkj74qhVXqnlvZykT6r2VDQMzYUvFcomOQiFbcA2r0
         XqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771375; x=1776376175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=UXLi+GwrmP8L2GcRLnwWIoycrIBc+PetoYl/quQyXry1ewBIOyiLaO1Wsnqz5g37jj
         gGnOyYtEaRUWV7UUgW8ngDdsUQqHKIAswPH/MmR37SBghs35WoiNpLEwWLzm3q5TXJqt
         JwWhs9lGKZImo0+PJJ+nOtW/hnlACbQEdFUKPzlBs7L6DcRopcp0Ti9MP7gkWsAyZzYI
         A+idUOBJF+YHLxT/iVMSzdXI0NBgulK+4hAhaECRSdzDbhP45I+uCCSZ2OPH9OtLoqIE
         oGdT/ua5hER8or3tsc1KWbb/4fmGBfZ28JxUWTVVrbfY15ya7oyKUuJZ7diQp7N36VXd
         Yi/w==
X-Forwarded-Encrypted: i=1; AJvYcCVg/Vqb1Yssr0l0s7UBiZaS8nfKDDA4CsJjPjusuWOceuPEbhKxM9otfgxpLVhFskaf86uoM2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PpBP9qa2PRrPzizhHj13j0+56bLwaC62Q0qKbVNeoMHnVLaL
	fGCs53VdWcVZ92yo9/fhbJ0dGd8xFsv11xveEoM04+AlY8L+V3CkkO7V3BmOaga1apwtRE9YVGu
	zdpq1ugh0m/zTFQ==
X-Received: from qtbbp41.prod.google.com ([2002:a05:622a:1ba9:b0:509:21cc:5909])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8a0b:b0:50d:8c22:47f2 with SMTP id d75a77b69052e-50dd5bdb454mr12128201cf.44.1775771374871;
 Thu, 09 Apr 2026 14:49:34 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:09 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/15] net/sched: sch_fq_pie: annotate data-races
 in fq_pie_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 722B13D0026
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


