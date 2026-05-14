Return-Path: <netdev+bounces-287899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LnECxydBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:59:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EAC5400D0
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 889983047BDF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526833ADB97;
	Thu, 14 May 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDHSu6ye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0323B0AF8
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752783; cv=none; b=sC/GxDoYsjrTRc8axGrLQoy9RjbonUEK4+dsDBuB9GnUcqbzgYK6pwM5gkSWlj/eZjHNItvAoIFgqHv9e1Qp3B2TU8wnnCWppqsKnX/tMPh9/RGJYv5YzshTKoC1vfOnThwCY10roW7cozYX0UkcOiiQRD44d8W1ZuU0B4vhsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752783; c=relaxed/simple;
	bh=8llEgmXqHeTlgJAsa1KoYfqGcJvx5aG8Fkmr9RMCiPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A7qhnetLTKGITjWvjTO7A5I2e5MrehtOHMzmuk+FHnTEEEBCUBjCLg12zzSqHvyWyPUcF/F4nbIZ5JdplxyDqM0UUYJC8NIduxch2zUAdQrelg3U75YqRFfoGEsKbiY98f/wlvXbJqlYMFT44GS75Sh0t006qPPoZBb3im1vZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDHSu6ye; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b552610488so148509486d6.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752781; x=1779357581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=soWwvHhlhtVlbDzHz96Y6IsK1CCvxJdzA0jJsssxvsY=;
        b=jDHSu6yeinWv4i+IYd//eIfW1Q1z0rd6x3BE2CILaRE6afpvQpIH95Zkkn1FyEoZwF
         pEkU9sPyj5G5M2miGVBLIg5SrurRSGnDmpAy7L2RysLAxGv8qXjLzjhlkR7KPghIoVIc
         cmFR+6ku17zlBtVwW2GtiQeUJmFGQeTUBF99lvCb2s79wJN1efQ8MnDvPtnWvm3/KxU1
         ZHHm+39BabLe6SS9OctEFh21hxAwhf9Jl3BgdiHHRQnJz60/7U7+ldZOLC8nMSHq/kD6
         kJT7CEmiZijOQgmZoQZKFPvNO9/4MFpEg5r22CkgQ3JvoL37ILaLpnk8CJh+ueCPsnC1
         fIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752781; x=1779357581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soWwvHhlhtVlbDzHz96Y6IsK1CCvxJdzA0jJsssxvsY=;
        b=BX9KLRkGyQdCSUTGXIVkxf+1HBIHG+E6BqJIORrbt4p+lIB9YLeMM5sHCgTkzOfO6J
         NlWiJwP+TaW/ukClPSZkmAGwuP0108N8VLMj4T0E4mkQh4p/wNi2blISxFjJzlUjc6yk
         +NTtkS8+USmb2nb0yV1q2LPVtL1fq/ICqL/9dalNWTEixEOwWBrtOb9gmSfAg5kAmhKj
         4zdzL2t1EmptkjREDNJ5ZPUp4Y8QnXixC0Ya12anBAGsTCgItA4huxsmIXgUUy5OH9Rm
         t/InbfywFvo2i2prmbritTDuws5iuFp2MOW7+h1IQRMwi9zQb2Iv4l1ZZwJq6o1fIVYm
         Swpg==
X-Forwarded-Encrypted: i=1; AFNElJ+L8uVLXH+yeom227XgPeuVwu9r4aBujXXz3FA4fKE0/Fd1c4iPBY/hGDQi3DSQe4/bp/Y7wMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/pWxngShgsvKoDrEQd3vo6MCkd4ZttfpPey2+dyrMnii0HNCO
	+YxRi6zzpMaqUakjPOs0aMYnaFKWHg9Y4+k5DhavxNyt4l6qGv0scm31Vy3WW+Wa50RtyqTEPqY
	GFP0UH0Ko+JT7bQ==
X-Received: from qtwq6.prod.google.com ([2002:a05:622a:306:b0:50e:60ab:11c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5889:0:b0:50f:b821:9c3a with SMTP id d75a77b69052e-5162fe09123mr96641671cf.11.1778752780650;
 Thu, 14 May 2026 02:59:40 -0700 (PDT)
Date: Thu, 14 May 2026 09:59:34 +0000
In-Reply-To: <20260514095935.3926276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514095935.3926276-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095935.3926276-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net/sched: sch_htb: annotate data-races (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D9EAC5400D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

htb_dump_class_stats() will soon run locklessly.
(no RTNL, not qdisc spinlock).

Remove cl->xstats and replace it with two fields:

-	xstats_lends
-	xstats_borrows

Then use READ_ONCE()/WRITE_ONCE() annotations on them, and change
htb_dump_class_stats to use a private struct tc_htb_xstats.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_htb.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 5bf1889bc0300e8e3a61d56ddcf1bb1402955107..353467eb7611be45c6a9c92a0dcd4357d136a232 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -114,7 +114,8 @@ struct htb_class {
 	 */
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_basic_sync bstats_bias;
-	struct tc_htb_xstats	xstats;	/* our special stats */
+	u32			xstats_lends;
+	u32			xstats_borrows;
 
 	/* token bucket parameters */
 	s64			tokens, ctokens;/* current number of tokens */
@@ -707,10 +708,10 @@ static void htb_charge_class(struct htb_sched *q, struct htb_class *cl,
 		diff = min_t(s64, q->now - cl->t_c, cl->mbuffer);
 		if (cl->level >= level) {
 			if (cl->level == level)
-				cl->xstats.lends++;
+				WRITE_ONCE(cl->xstats_lends, cl->xstats_lends + 1);
 			htb_accnt_tokens(cl, bytes, diff);
 		} else {
-			cl->xstats.borrows++;
+			WRITE_ONCE(cl->xstats_borrows, cl->xstats_borrows + 1);
 			cl->tokens += diff;	/* we moved t_c; update tokens */
 		}
 		htb_accnt_ctokens(cl, bytes, diff);
@@ -1319,6 +1320,10 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 	struct htb_sched *q = qdisc_priv(sch);
+	struct tc_htb_xstats xstats = {
+		.lends = READ_ONCE(cl->xstats_lends),
+		.borrows = READ_ONCE(cl->xstats_borrows),
+	};
 	struct gnet_stats_queue qs = {
 		.drops = cl->drops,
 		.overlimits = cl->overlimits,
@@ -1328,10 +1333,10 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 	if (!cl->level && cl->leaf.q)
 		qdisc_qstats_qlen_backlog(cl->leaf.q, &qlen, &qs.backlog);
 
-	cl->xstats.tokens = clamp_t(s64, PSCHED_NS2TICKS(cl->tokens),
-				    INT_MIN, INT_MAX);
-	cl->xstats.ctokens = clamp_t(s64, PSCHED_NS2TICKS(cl->ctokens),
-				     INT_MIN, INT_MAX);
+	xstats.tokens = clamp_t(s64, PSCHED_NS2TICKS(cl->tokens),
+				INT_MIN, INT_MAX);
+	xstats.ctokens = clamp_t(s64, PSCHED_NS2TICKS(cl->ctokens),
+				 INT_MIN, INT_MAX);
 
 	if (q->offload) {
 		if (!cl->level) {
@@ -1352,7 +1357,7 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
 	    gnet_stats_copy_queue(d, NULL, &qs, qlen) < 0)
 		return -1;
 
-	return gnet_stats_copy_app(d, &cl->xstats, sizeof(cl->xstats));
+	return gnet_stats_copy_app(d, &xstats, sizeof(xstats));
 }
 
 static struct netdev_queue *
-- 
2.54.0.563.g4f69b47b94-goog


