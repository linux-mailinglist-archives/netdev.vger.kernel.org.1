Return-Path: <netdev+bounces-87960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5E8A5153
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC161284090
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6184E19;
	Mon, 15 Apr 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHM8vMNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505E84DEA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187277; cv=none; b=OzcmQLtbnbw4sJQ7E66NImhGIqcxwrB5jH3rEnU4NWD6QYPsjhFpBIwAstQZoVFiMUD3OVm5K2NP0r8qhQPkc9w0FB6pN1Q8KU2CwfZK/r9yAHStRKy220Uc/vjSumtozYcZpGXmCx1ybkafyaE/wQJG5jv8FKdo8GH1ZJHawYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187277; c=relaxed/simple;
	bh=5q+k7NS9vI3SEuKwoY/Rbn+q2xtRsNm+6ilKKD6RYR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IYxxcRjA0HAuHfoXfqbpVlLpfEc9yZ611mG8qnfQS8inw7eBcveLHgXPt1wsr7GdHdVROS/rdAsmE4NdAYp2k4yiW3v/DmS41DUS4vsTAnTh1xrUGvevTNb1IsMdP7CPTdRXCZt0dKzba4RKbuDtoesywcUKvppwqg9g738xJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHM8vMNJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so4147063276.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187274; x=1713792074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkbl/RvKGDbnlrh/Ut87xj2shjaLFrAnvS+ShejraVk=;
        b=rHM8vMNJcqkmZ3fbzwMrU1f+3ipym7o/ehFdtyWbR5ZSFOvs+5v3vbRlIbvsD4LHDk
         6aWYL0ny7/Sami/PNn9EdmgJN+sOTtbtshPdTQ1qPy3BjNStQBmAQM0OP3igwSpbW3Ml
         WEkQSS4jbzjyH8xByI/K+AxPuaXisU8qsUgfr2gSRtc9D39Gau2DsJ0gqWITWpZBkItx
         oj+akHWfFU2txYjFBVxki1J1pX3oveyvQwBpUgN/AxTnXV3dHZv3nsJ9fkXT3krp23uI
         L4YExhhSWbn5CVtPaSSb9kpOpFowD6aPPpM4eNWwzNH+9saVwqnnLGtwhPK5INFm9JUJ
         ggUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187274; x=1713792074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkbl/RvKGDbnlrh/Ut87xj2shjaLFrAnvS+ShejraVk=;
        b=HXetnvcFI77ucDBqZgCypP3l6/y2RkOGvmoM92oJZo8XOMgICLbHIu4TGlu2nDG0Bn
         PBmJtjGM7yW/yfMv2iMAR9WdEQ22ks/iOt8q3xWX0PNMCyXs8eNUvX5/PVvbMwvBDHTE
         wcwKzgUUPLyFNlrXNdB2cxA8KeBjjGk1I0ACGLXWTuE+57lvwXnExZqFvlEPIWlUN+4a
         Czs5o044VzfkaZbAZarcABw7KDPkEuCRmaFQQA714oI54lZhsNoLIKvdluBSYf9X0SK5
         JvuXR+4dynhkSYakANND4Rl1mMGfe3lCSnXpRVEwXYDWYJqIHzYL3ZT+G8X4h3hQPMVG
         siEA==
X-Forwarded-Encrypted: i=1; AJvYcCXa2lcMdKTTLgAjk9ivlMIHHzi2Wft4bZNUqVodVOkVL2ORL+YR8Egf8Ou291YeEQ8CRivSJSqqDycnw3bvOfjR3O+Usmcl
X-Gm-Message-State: AOJu0YzBMPoM6tRrINy8YeFlwdCxTYquFF8wQvjpS3iouiQXV8JtAOFy
	BViZe30UXgH6vaqCDqZV5vkmxDgYU87fzEgjBBEbXLIYzHUlkldcANlI0wcwI0YQU7Er5LOYc+1
	UDazh542EiQ==
X-Google-Smtp-Source: AGHT+IGrfJjlNzAyzfCLUR2NfKPN6Ut3n+9udb5RmcF6iZnfhZSo2BW4f2JaMcWxuqDgQJD2CSm7dCjWANr6Hw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1026:b0:dc2:5456:d9ac with SMTP
 id x6-20020a056902102600b00dc25456d9acmr1082322ybt.5.1713187274534; Mon, 15
 Apr 2024 06:21:14 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:53 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-14-edumazet@google.com>
Subject: [PATCH net-next 13/14] net_sched: sch_pie: implement lockless pie_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, pie_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in pie_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_pie.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 1764059b063536f619fb4a32b53adfe8c639a8e5..b3dcb845b32759357f4db1980a7cb4db531bfad5 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -156,36 +156,38 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 		u32 target = nla_get_u32(tb[TCA_PIE_TARGET]);
 
 		/* convert to pschedtime */
-		q->params.target = PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC);
+		WRITE_ONCE(q->params.target,
+			   PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC));
 	}
 
 	/* tupdate is in jiffies */
 	if (tb[TCA_PIE_TUPDATE])
-		q->params.tupdate =
-			usecs_to_jiffies(nla_get_u32(tb[TCA_PIE_TUPDATE]));
+		WRITE_ONCE(q->params.tupdate,
+			   usecs_to_jiffies(nla_get_u32(tb[TCA_PIE_TUPDATE])));
 
 	if (tb[TCA_PIE_LIMIT]) {
 		u32 limit = nla_get_u32(tb[TCA_PIE_LIMIT]);
 
-		q->params.limit = limit;
-		sch->limit = limit;
+		WRITE_ONCE(q->params.limit, limit);
+		WRITE_ONCE(sch->limit, limit);
 	}
 
 	if (tb[TCA_PIE_ALPHA])
-		q->params.alpha = nla_get_u32(tb[TCA_PIE_ALPHA]);
+		WRITE_ONCE(q->params.alpha, nla_get_u32(tb[TCA_PIE_ALPHA]));
 
 	if (tb[TCA_PIE_BETA])
-		q->params.beta = nla_get_u32(tb[TCA_PIE_BETA]);
+		WRITE_ONCE(q->params.beta, nla_get_u32(tb[TCA_PIE_BETA]));
 
 	if (tb[TCA_PIE_ECN])
-		q->params.ecn = nla_get_u32(tb[TCA_PIE_ECN]);
+		WRITE_ONCE(q->params.ecn, nla_get_u32(tb[TCA_PIE_ECN]));
 
 	if (tb[TCA_PIE_BYTEMODE])
-		q->params.bytemode = nla_get_u32(tb[TCA_PIE_BYTEMODE]);
+		WRITE_ONCE(q->params.bytemode,
+			   nla_get_u32(tb[TCA_PIE_BYTEMODE]));
 
 	if (tb[TCA_PIE_DQ_RATE_ESTIMATOR])
-		q->params.dq_rate_estimator =
-				nla_get_u32(tb[TCA_PIE_DQ_RATE_ESTIMATOR]);
+		WRITE_ONCE(q->params.dq_rate_estimator,
+			   nla_get_u32(tb[TCA_PIE_DQ_RATE_ESTIMATOR]));
 
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
@@ -469,17 +471,18 @@ static int pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 	/* convert target from pschedtime to us */
 	if (nla_put_u32(skb, TCA_PIE_TARGET,
-			((u32)PSCHED_TICKS2NS(q->params.target)) /
+			((u32)PSCHED_TICKS2NS(READ_ONCE(q->params.target))) /
 			NSEC_PER_USEC) ||
-	    nla_put_u32(skb, TCA_PIE_LIMIT, sch->limit) ||
+	    nla_put_u32(skb, TCA_PIE_LIMIT, READ_ONCE(sch->limit)) ||
 	    nla_put_u32(skb, TCA_PIE_TUPDATE,
-			jiffies_to_usecs(q->params.tupdate)) ||
-	    nla_put_u32(skb, TCA_PIE_ALPHA, q->params.alpha) ||
-	    nla_put_u32(skb, TCA_PIE_BETA, q->params.beta) ||
+			jiffies_to_usecs(READ_ONCE(q->params.tupdate))) ||
+	    nla_put_u32(skb, TCA_PIE_ALPHA, READ_ONCE(q->params.alpha)) ||
+	    nla_put_u32(skb, TCA_PIE_BETA, READ_ONCE(q->params.beta)) ||
 	    nla_put_u32(skb, TCA_PIE_ECN, q->params.ecn) ||
-	    nla_put_u32(skb, TCA_PIE_BYTEMODE, q->params.bytemode) ||
+	    nla_put_u32(skb, TCA_PIE_BYTEMODE,
+			READ_ONCE(q->params.bytemode)) ||
 	    nla_put_u32(skb, TCA_PIE_DQ_RATE_ESTIMATOR,
-			q->params.dq_rate_estimator))
+			READ_ONCE(q->params.dq_rate_estimator)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
-- 
2.44.0.683.g7961c838ac-goog


