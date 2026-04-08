Return-Path: <netdev+bounces-276525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMNQOLJQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B03BC78C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D080D305389A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EF36495D;
	Wed,  8 Apr 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CurRE3nM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B93C73DE
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652994; cv=none; b=sNCde0fBOpXZLyx7mP9dBvqlfCqisEpB0FWnUASD6PmYA2WdA52d3cxTaWGf3HnH5T1GOC7lpWUKgkp5Ou4UDn6ohKNAWQDzP5CNjwVq2wyC6cCRKJDQUcn7UZnusRPD/I9LYdDcikqyO9L952jy65K9+vcFcNAyWrurDlNDkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652994; c=relaxed/simple;
	bh=mbqVwp44Oe8sIOKokgrfuqgPziKh5eJCA5KdDUt5rJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXlAyLxyY+7gAtPOO4oxiRvqiaQxch7KxAPQ0AJLPIrPdaIswpPBb2ZFbecINbn2pNg95Fg+NyOtSQuOdDdgXFkRPY7eG/kjEvjYHrONe+OSRjr4eTLzVdUNf7zcimHzhR0vp4651WUusTIhGISY4FRssE0ZSzuOkUBWeEky7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CurRE3nM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b220c72bbso78331841cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652992; x=1776257792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=CurRE3nMlCVwTO0cRXrm5n9uvRcpbdSJHzmdwJW5+ybnMcANs27hwHIpYQhKYnQKYQ
         lo/Zo2sq8srw+P3oTVwCfuNo8+NJ8aKT5d1kLnu2OJ0XwubnypA8YDDe2g4HNap9Crtt
         YrgXZAV+LedVZFAKyZGAeqORM0lpisOzL02XzaljZOVIQ+1X6XCkPxn1NRcaIoTH813c
         i+e9w0E4wr8zadouSXOOsKPYIQex/lSsYu9NUILncx33fHnh7kXD2xkMKlwoZR2GjTsb
         U10TjiB32WHp0G4Omt/2AluqFK4ViisHXLfy7Hi4uCfD2fqELARpm0IbaT2zE/2pvqe+
         i2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652992; x=1776257792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcTpqml0j/U62Pzfu8UVtw0hoiGQLBZPgq0EQc4ozA=;
        b=cdKaW8McEuVDdJUZG8JlNJIg9LfVkwC5UgomEtl0pIiM43SakyCvaB993gOeS7aFLe
         AA2VaWVBlgnqn2qnyQZfYAYP5s5+uygY/NUGq+N5n6oWnHEsBY3O7d/pHiVneH4UCMkw
         Rc7RgysnC7sEerYDD/QAnEq3OTZ14x1GFKx63bG+34hxV3trR/JIjcyOUWgg2QVjDJNu
         C/LQp/oXR1Vr1QBMKEV6+IsbxzWFM+SrwJjJ9XN7karsiUlFe50qV3mpig30fFeQwKKa
         jU29ndLLORstyJR5+uD3HAz+OMJxe7W7Pu/AWaWmh903siRgXzmq5W2vnJidjG5B1iTg
         8EJw==
X-Forwarded-Encrypted: i=1; AJvYcCVX0apPTcDzHUSp1z7wxjVMOJR8ZFLboSesgCoYlvJETInM536LomtyI3McNeJcXU+oD8ECo6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyunvOuP983qRsyyikdtKUf2314hTpat2dKJ+eDUs0HN0AVWiWL
	QJ1F2rjqvzIssFVNmVhRmOmjDlwwOAwYScCU3I+fLdID5qrYcbOnr3QdD8yOZJeA6WZ7YsSG46r
	TVrRjYbwrRrIOAw==
X-Received: from qvss8.prod.google.com ([2002:a05:6214:ca8:b0:89a:1e36:3aac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f07:0:b0:509:3940:30ea with SMTP id d75a77b69052e-50d62ab1ff7mr312612511cf.55.1775652991775;
 Wed, 08 Apr 2026 05:56:31 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:06 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-11-edumazet@google.com>
Subject: [PATCH net-next 10/15] net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
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
	TAGGED_FROM(0.00)[bounces-276525-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 5B8B03BC78C
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


