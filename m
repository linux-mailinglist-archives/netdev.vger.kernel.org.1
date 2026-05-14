Return-Path: <netdev+bounces-287900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ3uAS2dBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 954625400D9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7001D301DEE7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA63ADB97;
	Thu, 14 May 2026 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYbjyQzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD53AF67F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752810; cv=none; b=S182uRQ2gMFkWu/RV4H+BIVyXieVhVbvuw8KweNC9F9ar+LZ6NgVB2BXRQk9OB/gcjUl1FPYLDGKIqnhTUSEI4dIPc1Y1Ey+JZxWUVJTeBqoyFTIL+7Lw9LPodZQ1k8i5SovxwKkSTrWq6ThbJ2WgryKnHfUWL5dzrfeTZt6WMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752810; c=relaxed/simple;
	bh=rvktTITJ8zj7wzidA7wlLa3wLkKE3IbX7QT/QhMyo5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+flMUAj1AYsqobUc1feItZEuK3J1o9Au1vv5N6YYJx7IidqlIYopOlApzx1IaBOglzrWnkiA7Mz1VoUROXE037a8XbNsftyROWWjhUlCoTQaQgu3esIBuayqGp8nKE1JLer3r7IWiqx1J8y5ZwaEkHrR9XgF5Bl4N3bwke3BQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYbjyQzi; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-515224a8aa0so74209841cf.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752808; x=1779357608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcGAkIxFZdpLJjImXoFmMHgCi68syCGK6Uwobiw+T/k=;
        b=CYbjyQziU3Sr9kin6BhMEYThU/sE7DWwV9SNyuWmXQQVkF9uM3aUbeouIRRsw8gd6Q
         mxqkCh8v45PA1ylejkmnT1GAQp3AE8fnCXJNKWyddLHTYECEGNiLe+ZhBtFr6KvdKZCz
         De/4RotLOgC5jUXqBa7mavGAMUcGRwgveb3PbRbTyofAFVWtQdP+T6k8+qqMjakyJj37
         DowQ9EZpLCaprd1xS0bAgms2JwGwyoPyWrGCmA4IY9kZx8FL+wcS++6irXQ6KqOchQgF
         r6j0TpMJ5tnWYz0evVUQCpYZ/DVrCVsKhF4HnTqave5gRQVTLA8/+CZlkVEfVZ74tsi2
         Pe/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752808; x=1779357608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcGAkIxFZdpLJjImXoFmMHgCi68syCGK6Uwobiw+T/k=;
        b=UHBiHriKq7sGlJUUNre/TSKtJo6RYFQhF5lsA0obDcZA6BE6md3zFF3wQdzVBeLEph
         sd1Np1xSKY3dGGWzpgaEXy6zC8nE5xSN0o59r8UQAL80AQlHEiP+7bt5T8CReIw9c9X0
         VuGBL5WRkhaNjZ62zM/5hrC8xTvzbeFM0O+Q0dCeQELoyRKlyJnYq8ySwsFrgiL2DrZl
         s66HJ5j57Iyi9IXkOXsP5AofK+LSEj1wn1OxQyHWetpXZxTyyAELulrOrQLo83f+RuYe
         zTZOFLHNXIPUNpjVJLALpSPd7DRGJ/BMvlDUD30+Uk7gagc0QfjpmXLKGgBNhN7stV9z
         7Wtg==
X-Forwarded-Encrypted: i=1; AFNElJ9cyDyoplELKvwYRz5SAckZ8QDXp3QDnqFI3wK23WOvxNpyNv0tnMv5LfuooTrjfTzWc4r7wzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56b8D8iy3AqKNkTNtQRq5VfIDDAP8DBDaXT286UHhK0LPesKu
	MVwV4B6w/lMEZBjrbRhPqdX9sModjZK3CkeDk9JyRCVJunUcYam8r35Lf7TwIE2SrbvS+ZZa6rG
	X4DFyKerNemhJ7Q==
X-Received: from qtix12.prod.google.com ([2002:ac8:120c:0:b0:50f:e336:3dd8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:188d:b0:50b:6cc1:38c6 with SMTP id d75a77b69052e-5162f6690e9mr96729221cf.55.1778752808162;
 Thu, 14 May 2026 03:00:08 -0700 (PDT)
Date: Thu, 14 May 2026 09:59:35 +0000
In-Reply-To: <20260514095935.3926276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514095935.3926276-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095935.3926276-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net/sched: sch_htb: annotate data-races (III)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 954625400D9
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287900-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

htb_dump_class_stats() will soon run locklessly.

(no RTNL, not qdisc spinlock).

Add READ_ONCE()/WRITE_ONCE() annotations on these fields:

- cl->overlimits
- cl->drops
- cl->tokens
- cl->ctokens

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_htb.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 353467eb7611be45c6a9c92a0dcd4357d136a232..d8ef3efbe0d5eab42c535e48d95d9005ac9682be 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -568,7 +568,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
 		return;
 
 	if (new_mode == HTB_CANT_SEND) {
-		cl->overlimits++;
+		WRITE_ONCE(cl->overlimits, cl->overlimits + 1);
 		WRITE_ONCE(q->overlimits, q->overlimits + 1);
 	}
 
@@ -644,7 +644,7 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 					to_free)) != NET_XMIT_SUCCESS) {
 		if (net_xmit_drop_count(ret)) {
 			qdisc_qstats_drop(sch);
-			cl->drops++;
+			WRITE_ONCE(cl->drops, cl->drops + 1);
 		}
 		return ret;
 	} else {
@@ -666,7 +666,7 @@ static inline void htb_accnt_tokens(struct htb_class *cl, int bytes, s64 diff)
 	if (toks <= -cl->mbuffer)
 		toks = 1 - cl->mbuffer;
 
-	cl->tokens = toks;
+	WRITE_ONCE(cl->tokens, toks);
 }
 
 static inline void htb_accnt_ctokens(struct htb_class *cl, int bytes, s64 diff)
@@ -679,7 +679,7 @@ static inline void htb_accnt_ctokens(struct htb_class *cl, int bytes, s64 diff)
 	if (toks <= -cl->mbuffer)
 		toks = 1 - cl->mbuffer;
 
-	cl->ctokens = toks;
+	WRITE_ONCE(cl->ctokens, toks);
 }
 
 /**
@@ -712,7 +712,8 @@ static void htb_charge_class(struct htb_sched *q, struct htb_class *cl,
 			htb_accnt_tokens(cl, bytes, diff);
 		} else {
 			WRITE_ONCE(cl->xstats_borrows, cl->xstats_borrows + 1);
-			cl->tokens += diff;	/* we moved t_c; update tokens */
+			/* we moved t_c; update tokens */
+			WRITE_ONCE(cl->tokens, cl->tokens + diff);
 		}
 		htb_accnt_ctokens(cl, bytes, diff);
 		cl->t_c = q->now;
@@ -1325,17 +1326,17 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 		.borrows = READ_ONCE(cl->xstats_borrows),
 	};
 	struct gnet_stats_queue qs = {
-		.drops = cl->drops,
-		.overlimits = cl->overlimits,
+		.drops = READ_ONCE(cl->drops),
+		.overlimits = READ_ONCE(cl->overlimits),
 	};
 	__u32 qlen = 0;
 
 	if (!cl->level && cl->leaf.q)
 		qdisc_qstats_qlen_backlog(cl->leaf.q, &qlen, &qs.backlog);
 
-	xstats.tokens = clamp_t(s64, PSCHED_NS2TICKS(cl->tokens),
+	xstats.tokens = clamp_t(s64, PSCHED_NS2TICKS(READ_ONCE(cl->tokens)),
 				INT_MIN, INT_MAX);
-	xstats.ctokens = clamp_t(s64, PSCHED_NS2TICKS(cl->ctokens),
+	xstats.ctokens = clamp_t(s64, PSCHED_NS2TICKS(READ_ONCE(cl->ctokens)),
 				 INT_MIN, INT_MAX);
 
 	if (q->offload) {
@@ -1517,8 +1518,8 @@ static void htb_parent_to_leaf(struct Qdisc *sch, struct htb_class *cl,
 	parent->level = 0;
 	memset(&parent->inner, 0, sizeof(parent->inner));
 	parent->leaf.q = new_q ? new_q : &noop_qdisc;
-	parent->tokens = parent->buffer;
-	parent->ctokens = parent->cbuffer;
+	WRITE_ONCE(parent->tokens, parent->buffer);
+	WRITE_ONCE(parent->ctokens, parent->cbuffer);
 	parent->t_c = ktime_get_ns();
 	parent->cmode = HTB_CAN_SEND;
 	if (q->offload)
-- 
2.54.0.563.g4f69b47b94-goog


