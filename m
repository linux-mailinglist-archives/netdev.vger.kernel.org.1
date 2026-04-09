Return-Path: <netdev+bounces-277140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCqaOvAe2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B213D0018
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2184301BA4B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683E339719;
	Thu,  9 Apr 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rq98F+io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403D358363
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771372; cv=none; b=Ubmno+bNt+ntIvyhB0bPY/j8p3Ff5RyyQFyWTDXHoJ6kgkf+/oZTHw5uCgjt3DKUKjILN7KeIUERomndAY1U0/QZZnCezSWYt1V4rxmVvJ68qBOGwZGjxEhnFXIEZpjXjs6Vd239AYDMhazCszoqPdysOevo5rdgcBhBvpFHnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771372; c=relaxed/simple;
	bh=1V3vqvi/JBOLyCskOpWmHzYqj/ULhNcAebQht7m3ogE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dXuN+H9it779UoSMdrytiXIcEbFxLUBlHi/M+Rp+oX5Mu1+cuPFwdjwtGBFWsWmGo9Wg/JY03gjoe4fLXqwqySVJwLpB/ia3GlOqU8SrfhxUQfbxhGajFp2Fybhl0d2LtC9OfsD1/GPxZZJSj6mEp14V3xwfMAgrOZucv6qTisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rq98F+io; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d3bea3aa34so301925285a.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771370; x=1776376170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=Rq98F+ioDyKnpbOpOV16l7eX35Xw8+XDziE8O8N2bJCzN87ydbp3xjTNtOTO0MCmzd
         WcNR/FoePSs3414Oixsw3gJfzcnquXp48rvfLZ8q/KWXGG8fgM0UCFZt6yuMcJTRQHH2
         xKlg02M8+OFbA0KeskTw6dH7i56f61XlH5+nz7BsWBg3lTCn7uAp0vnpJt/nFRyG2Aje
         oNgmsSrxvpaVzjd0hupjpElgViU1z5XF5mN+Dns+8W/ZYx7U8CQQVwSb+BgF6AV8kjWV
         FYrv0uMKCkIWIusELCbsbwgkbDBK5t+IZ4SWM0BPALnIit+SmfOqIXVldK94pSQn41Bh
         pWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771370; x=1776376170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=fFIf60YUFQNkosvcBIPaT7RH1o9qqLd/nGDdZ3gY4cFB/WWVFU2TsLA/HfR9xugww2
         XhX45o4w9JDbJx3UKsbNhMCZgWfCnDiXTUhK7VkZXYw5UssSWaYUnnvtAV3UxMR7E3tJ
         9atkcDtxvfFP4YGixYfZe9OTafbtz+2wq1/1cF/xbBJEiaeHyWsOvXyMatWB6J2NIiNw
         kah00em7+9n7xxENzMkG9mo+T7+hf82//3GqnfdY6g0jTIo9xSVwKbU07X7dKlr2KDEU
         d2a7Wl452h6WznU8BU7EM3agUzk/syQVm6Sd6Zj5EZW70IS5soqHBu7djHGEjgAfIZWz
         TIXg==
X-Forwarded-Encrypted: i=1; AJvYcCUcAeVNBQJaJ7pYOUrC0KxZ6MptQn0SKp9/KmlnMdK6MEfXMg/Lo5rWyZ6iMieG29+jm+HqTA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROzsHIz+0McEUqzIWY6EEyV3zd662oqGhteQnEq40I6LD41wa
	GpRfb0uGXFCMFHew0w0omFJJnSbbV1qfY+QNarzqH2l0hDFEaVFpQHteW8RDFo35Tav51HjyljT
	J/kXwRhya6eC3lg==
X-Received: from qkah27.prod.google.com ([2002:a05:620a:21db:b0:8d3:bb62:c8af])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4443:b0:8cf:cc52:635f with SMTP id af79cd13be357-8ddce2c6f10mr94342685a.29.1775771369720;
 Thu, 09 Apr 2026 14:49:29 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:06 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/15] net/sched: sch_red: annotate data-races in red_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96B213D0018
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


