Return-Path: <netdev+bounces-89021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24818A9411
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594BC1F213E9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9A76A00B;
	Thu, 18 Apr 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssCnUjNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7877F1B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425579; cv=none; b=CWJF3bIXAKf9TjdkeJavwkofDeLEvzjHQnBpsWB+1DXePVunHL7jkgtgdF/ZiCwiUNxdAIP/0gZl/QbhJHr+AMElEmog3eIhj6QFGHHyJrLHMRfiPePaTjbFzf+WsUX14zBWOqaLajQuycqBicp2mJ6rsKQkKbl6Ke8VWmGbN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425579; c=relaxed/simple;
	bh=x5VJ1Us9w79jidF/vPIqCn72gVsrgxq6aMRQh1RFXNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YXszRI2JPEi41Lj/p14Iwq7w7UPHeHUxOz/znpen/6gbckhKgoRAvcI0SPnNJOguyaxMhEOYLNnFEGL3vx0Bpq39HKZmwdc6basRPzqn8qgXFSj/UCbULPCV+go6LVSHxXoo/vBcwR/8QJTcU+/b0G7inpRySqjjw/eqEoUSwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssCnUjNm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so1105133276.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425577; x=1714030377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjV4KNU0EJXj03hKcT3S+WchClfC9oEABVsClf5q3lU=;
        b=ssCnUjNmAP0/QM5sUJY0J+4/apJdOy8CRarJIsXjA/JtARCk44xiMV9W4IcF4hnu+3
         sNpuQIDMmJ8AObYehJIxIW8+DmZEgfm7SwmneP2iJU97yF8TQOQJzMzq5HkH6cdfjgiE
         Ooh5c01PyNzrWTuNGSBi5jH8XPemZgKfmMn6d/dlGd24/wsaw4p+/xg1CwpqIWHKqKpC
         yuMSqS+5VnVe+zfNbVVUGEGhKpYmEOf7zk3QLHjqcduG5f71jCPNGbcC23gDVfTCV7iX
         ORMvdDUTXergdreVPsTrKG3swqbu2DZVEV25CtzNiOO25AVPnIgaVjum6JsBEd2/bRq6
         c56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425577; x=1714030377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjV4KNU0EJXj03hKcT3S+WchClfC9oEABVsClf5q3lU=;
        b=O0D2LY3DuTwPI5YKf9nWBAoRmalgXR8qlBpGqE41bendv56TyIHyYSjJPE+fUnivu3
         yq6MLONTEEDGFbu6IIXewPq+BFDZ9T+k0Ph7OOcciGLKsWyeoHp1n4iXZi0SeKTuAcxH
         Z1OUmc8yXIu6G0Oijxs1Go5foHXQCowgwbeybxoXyMPKd7AkhDS4k6QDCfLPrCzipJp3
         aWuk7Fok7DA7TIdMYWZ6DTDmXsEMawzlbGf6tuTAvpYOLEyeb9yDorRFuAy5KdXGM/wd
         lUdpS9ftOPavN1L0NppWu2eRW3XZ5sjSW0lylY2u2CKqwG8qAsFTA8VXAdS1WLQet6BF
         b02w==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ab11AMCc0Qzg7Ll5vUD7Nm0GypAPoaMYkwol9OpuESn+CiU9Ggkf5q0h9ewaymjlmndjTfgY3KH5GDHam+diV2circN/
X-Gm-Message-State: AOJu0Yw5FEK8rGHBQqExnmi+3mtoW8PatJoG3SXVlO3vbwQ5pTV08R60
	iBb0tzNUFQHUNj2b+uBWxGNaSikcb8H/I8b87+2gdpxpmqeH58jCj55dLEjwHdDDapElUT/GQ/n
	Z7N8Ehgo1Gw==
X-Google-Smtp-Source: AGHT+IGjzQ/PnoXPkX0BJ/dYDhjoDpAEVesCpQWZtJ6BAla+GeBDdQsHNcRBicCZpmwPChwlY9PUnns+vFxyjQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18ce:b0:ddd:7581:1825 with SMTP
 id ck14-20020a05690218ce00b00ddd75811825mr498924ybb.8.1713425577409; Thu, 18
 Apr 2024 00:32:57 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:38 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/14] net_sched: sch_choke: implement lockless choke_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, choke_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in choke_change().

v2: added a WRITE_ONCE(p->Scell_log, Scell_log)
    per Simon feedback in V1
    Removed the READ_ONCE(q->limit) in choke_enqueue()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/red.h     | 12 ++++++------
 net/sched/sch_choke.c | 21 +++++++++++----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/net/red.h b/include/net/red.h
index 425364de0df7913cdd6361a0eb8d18b418372787..802287d52c9e37e76ba9154539f511629e4b9780 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -233,10 +233,10 @@ static inline void red_set_parms(struct red_parms *p,
 	int delta = qth_max - qth_min;
 	u32 max_p_delta;
 
-	p->qth_min	= qth_min << Wlog;
-	p->qth_max	= qth_max << Wlog;
-	p->Wlog		= Wlog;
-	p->Plog		= Plog;
+	WRITE_ONCE(p->qth_min, qth_min << Wlog);
+	WRITE_ONCE(p->qth_max, qth_max << Wlog);
+	WRITE_ONCE(p->Wlog, Wlog);
+	WRITE_ONCE(p->Plog, Plog);
 	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
@@ -244,7 +244,7 @@ static inline void red_set_parms(struct red_parms *p,
 		max_P = red_maxp(Plog);
 		max_P *= delta; /* max_P = (qth_max - qth_min)/2^Plog */
 	}
-	p->max_P = max_P;
+	WRITE_ONCE(p->max_P, max_P);
 	max_p_delta = max_P / delta;
 	max_p_delta = max(max_p_delta, 1U);
 	p->max_P_reciprocal  = reciprocal_value(max_p_delta);
@@ -257,7 +257,7 @@ static inline void red_set_parms(struct red_parms *p,
 	p->target_min = qth_min + 2*delta;
 	p->target_max = qth_min + 3*delta;
 
-	p->Scell_log	= Scell_log;
+	WRITE_ONCE(p->Scell_log, Scell_log);
 	p->Scell_max	= (255 << Scell_log);
 
 	if (stab)
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index ea108030c6b410418f0b58ba7ea51e1b524d4df9..91072010923d1825e811adbb8ea2b3035dda57b3 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -405,8 +405,8 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 	} else
 		sch_tree_lock(sch);
 
-	q->flags = ctl->flags;
-	q->limit = ctl->limit;
+	WRITE_ONCE(q->flags, ctl->flags);
+	WRITE_ONCE(q->limit, ctl->limit);
 
 	red_set_parms(&q->parms, ctl->qth_min, ctl->qth_max, ctl->Wlog,
 		      ctl->Plog, ctl->Scell_log,
@@ -431,15 +431,16 @@ static int choke_init(struct Qdisc *sch, struct nlattr *opt,
 static int choke_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct choke_sched_data *q = qdisc_priv(sch);
+	u8 Wlog = READ_ONCE(q->parms.Wlog);
 	struct nlattr *opts = NULL;
 	struct tc_red_qopt opt = {
-		.limit		= q->limit,
-		.flags		= q->flags,
-		.qth_min	= q->parms.qth_min >> q->parms.Wlog,
-		.qth_max	= q->parms.qth_max >> q->parms.Wlog,
-		.Wlog		= q->parms.Wlog,
-		.Plog		= q->parms.Plog,
-		.Scell_log	= q->parms.Scell_log,
+		.limit		= READ_ONCE(q->limit),
+		.flags		= READ_ONCE(q->flags),
+		.qth_min	= READ_ONCE(q->parms.qth_min) >> Wlog,
+		.qth_max	= READ_ONCE(q->parms.qth_max) >> Wlog,
+		.Wlog		= Wlog,
+		.Plog		= READ_ONCE(q->parms.Plog),
+		.Scell_log	= READ_ONCE(q->parms.Scell_log),
 	};
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -447,7 +448,7 @@ static int choke_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_put_failure;
 
 	if (nla_put(skb, TCA_CHOKE_PARMS, sizeof(opt), &opt) ||
-	    nla_put_u32(skb, TCA_CHOKE_MAX_P, q->parms.max_P))
+	    nla_put_u32(skb, TCA_CHOKE_MAX_P, READ_ONCE(q->parms.max_P)))
 		goto nla_put_failure;
 	return nla_nest_end(skb, opts);
 
-- 
2.44.0.683.g7961c838ac-goog


