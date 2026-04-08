Return-Path: <netdev+bounces-276522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDq5KYtQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7753BC760
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80035302257F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A63C6609;
	Wed,  8 Apr 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0P846hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C23C73DE
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652988; cv=none; b=mcbDWA4OTayhqgU2naGrLStg6ocL+Yx0nfRvLbCB8BYfB2ezFniRrBX31MtMzF4x+NunJqexDtBc9w3BcnsGFYN+d9m1cXo+cB9osEeXFZ1mhDlXDd8SIU0MS0PcHTnVGjxz7aq6gedLv6r51aeGmvIblQBsKFlqAthItnScI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652988; c=relaxed/simple;
	bh=1V3vqvi/JBOLyCskOpWmHzYqj/ULhNcAebQht7m3ogE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJYWtathiC5U+2ZIjD8g5O7bedPvsqzjtnvJy9d47hs2CJTja6eikfJrDcfNxXL/LgJCfO8q2N+iADb382sQTB9OKQe+k5bpO33Lkx0f/FZq2GI/qUskMiXXhA/Mpa96TdNRDvF2tU7rVflSk2QXIwNv+uApMa/hOKyahzLUuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0P846hN; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d9a6a853bso69548361cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652986; x=1776257786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=F0P846hNJPh3Cvzz0txNbTDn8/SBWcFWRr5WCrasP2Xqs8fNVW+TvH2JT2ArNy0Al9
         2BFMnyymPPFt5l5nWJ31c2XKKsE2HZqy9cix8CMBZKrCHNqd5ymsKqC48r8HHwOubgtE
         91Zql7hq6vJEFznMNWMVwntTGgDpQ3/Tmeecb8Li3wxnCiogTBaomiN43ps2oNFVVVSd
         nkodUTGTno3lCQzT6HDtzkwS6cCZf9++UET08WvOvbRDzUeP8Pp0G6FWft8wACDJJP7m
         gaAHdV15Gvq28c6taQqCTjbtqawWpvohg/4WSwKYAwPcd8tEgOszWDfUl0x8EWtJhdGC
         CDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652986; x=1776257786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=HxuKmUt5pERq69LdCewr8ft0iayuPyq+RsMHc76uwX+r2RaqzkaDqBri3IQntrubnY
         8GymyBrSQXIQCl8uKrRbhyKmym+yi3O94P1wmaQxq99NWwhLlheUgCJc+Cv6+lwOIfje
         TL+fSJcWb76w+9+YBx9w0hEC/6TZFS79C4b8lLHkGr0hdZVgEA74CBDqvxY1a1foG86W
         akdM5gfrVfkVm0itHa5yDXNT5i6268QRtOsKN+jzFSHaVH2Cmwsj/nvkmEOGq2KPiPRS
         9D+DAkFi47IaT1n05SvP8tZrMZ1OR2aQ2EauMhG2j9WVBvU5BLF/mNmNL6Uta1/QXwFb
         GdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSMR027od57+GsCAEpCsR2QiIFUirQ5zdaZB5J7kgq6v0V+MYWTcUW5L8/3qnmMmvdRYml2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFh4cs90mq9lQ9hGMxGEeH4R9NOHc9QM19wjmfEv4FhDvmj1cN
	OD9LQya7GByWoCaWsPcqQk0/e97uMRTT9DXQP+flA0W0nMFpCYKMP+PledsgZt7gcG+mDUJO8Nf
	raMq2kS94Yuz/Cg==
X-Received: from qtns1.prod.google.com ([2002:ac8:5281:0:b0:509:5140:c6c1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:684d:10b0:509:1a36:6ad9 with SMTP id d75a77b69052e-50d629c3819mr239515931cf.30.1775652986375;
 Wed, 08 Apr 2026 05:56:26 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:03 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-8-edumazet@google.com>
Subject: [PATCH net-next 07/15] net/sched: sch_red: annotate data-races in red_dump_stats()
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
	TAGGED_FROM(0.00)[bounces-276522-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6A7753BC760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

red_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Alternative would be to acquire the qdisc spinlock, but our long-term
goal is to make qdisc dump operations lockless as much as we can.

tc_red_xstats fields don't need to be latched atomically,
otherwise this bug would have been caught earlier.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_red.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 7db97c96351309bc3e64fa50570a1928f2b2ce55..268f1ba4520cd74da60e7b1ca08974fcfdced680 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -90,17 +90,20 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	case RED_PROB_MARK:
 		qdisc_qstats_overlimit(sch);
 		if (!red_use_ecn(q)) {
-			q->stats.prob_drop++;
+			WRITE_ONCE(q->stats.prob_drop,
+				   q->stats.prob_drop + 1);
 			goto congestion_drop;
 		}
 
 		if (INET_ECN_set_ce(skb)) {
-			q->stats.prob_mark++;
+			WRITE_ONCE(q->stats.prob_mark,
+				   q->stats.prob_mark + 1);
 			skb = tcf_qevent_handle(&q->qe_mark, sch, skb, to_free, &ret);
 			if (!skb)
 				return NET_XMIT_CN | ret;
 		} else if (!red_use_nodrop(q)) {
-			q->stats.prob_drop++;
+			WRITE_ONCE(q->stats.prob_drop,
+				   q->stats.prob_drop + 1);
 			goto congestion_drop;
 		}
 
@@ -111,17 +114,20 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		reason = QDISC_DROP_OVERLIMIT;
 		qdisc_qstats_overlimit(sch);
 		if (red_use_harddrop(q) || !red_use_ecn(q)) {
-			q->stats.forced_drop++;
+			WRITE_ONCE(q->stats.forced_drop,
+				   q->stats.forced_drop + 1);
 			goto congestion_drop;
 		}
 
 		if (INET_ECN_set_ce(skb)) {
-			q->stats.forced_mark++;
+			WRITE_ONCE(q->stats.forced_mark,
+				   q->stats.forced_mark + 1);
 			skb = tcf_qevent_handle(&q->qe_mark, sch, skb, to_free, &ret);
 			if (!skb)
 				return NET_XMIT_CN | ret;
 		} else if (!red_use_nodrop(q)) {
-			q->stats.forced_drop++;
+			WRITE_ONCE(q->stats.forced_drop,
+				   q->stats.forced_drop + 1);
 			goto congestion_drop;
 		}
 
@@ -135,7 +141,8 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 	} else if (net_xmit_drop_count(ret)) {
-		q->stats.pdrop++;
+		WRITE_ONCE(q->stats.pdrop,
+			   q->stats.pdrop + 1);
 		qdisc_qstats_drop(sch);
 	}
 	return ret;
@@ -463,9 +470,13 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
 					      &hw_stats_request);
 	}
-	st.early = q->stats.prob_drop + q->stats.forced_drop;
-	st.pdrop = q->stats.pdrop;
-	st.marked = q->stats.prob_mark + q->stats.forced_mark;
+	st.early = READ_ONCE(q->stats.prob_drop) +
+		   READ_ONCE(q->stats.forced_drop);
+
+	st.pdrop = READ_ONCE(q->stats.pdrop);
+
+	st.marked = READ_ONCE(q->stats.prob_mark) +
+		    READ_ONCE(q->stats.forced_mark);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }
-- 
2.53.0.1213.gd9a14994de-goog


