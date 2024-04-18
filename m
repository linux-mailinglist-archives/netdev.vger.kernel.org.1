Return-Path: <netdev+bounces-89030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8D8A941A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810511F21727
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219087D3E3;
	Thu, 18 Apr 2024 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcWDly8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFA76413
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425594; cv=none; b=NTv0uvWtMP/cYiYxtpZDwreB/ACIWSLNMEeQbVOQ4/ktiuE122jcYsfX0gFsS9Qz4KRWNh/8mSXMy7/znD76L6CIIVwx0eSdGpIWkKtU7EAdfurkKy61CFI5leM5JIkRu2QRf3fCduU/AleFaZC5QiAggKGD5bgD9lLyq88yyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425594; c=relaxed/simple;
	bh=wrXy/PV/Lsgi1DF+BVNGyixdSpb26Ldc/jEQJnK9Iws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nodZtrx+5I3x6h2TXj8R72kO/agtkZXGI2Bjd1f0/kncJQH5S/UT1ko1huUuRK32sb6DytzWWafCXDQNOkGYVypHghQsDOB53RJ3BeYZkhTIYjgQaA9awULJdG5dMMnQlCjqgNenr44PleNDd/+kUsnXa82ioK4ryjn5ZByysqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcWDly8Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1201365276.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425591; x=1714030391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1C3+w31/OE8eGi0fp5VXsJt9kUQGzlsndAxqYP/W1dM=;
        b=QcWDly8Z6Em6r3nwnY57zbG4H19EwmI/eeX2P84L+5kfQiSY/ZTsOcazzVesXTpwex
         iU+GSLtqNf8Awo0PFRHYcjqPiKQ1ayZQTrpKVl5efx6Nt073h/FCC4hnSNBdl1huRAgc
         8UTU2XJcoCIsdMFm38DdX5ZXFOrBLbxrNYHojMmWmFbPffWdqLMBrjAzCM5rmuieFvZX
         A42be4BsJ/Y3VIv0nmz32TPQx5OGhN24YuSGlV2lowzw+JxjjOZTs0a4+tIc5vyNF+Q5
         C1JvMuvj2q48TFd5r3bnu/dMQRpu+jfRnLET4BpnhW8oURKaTy+uxeXVLYfSOyqKIFOs
         7h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425591; x=1714030391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C3+w31/OE8eGi0fp5VXsJt9kUQGzlsndAxqYP/W1dM=;
        b=C8LFbO6UOzYdxYO8SQm23Po/kWf+RSYOea8wZy0WVasuqWxgpzD7Vj5t4dtZcrT8ch
         JN7jSwIIvz9t6dYSn3ujWxy7ZiOah1CAfx5vnAhhsX5+P5EdE0CvAXd0OH67xgy0nUzL
         gWRC6+4BI/HGiN65tbO8b4HxB7ZUNMOFaUHyfEAoz8Yb/Oup0wFpAaGzJX9qtaqPAmXa
         umfUpJ7IXEMnG0gM81Pi3mxcSrQ3/ALxkX8pDy74iET92gwtKzeeLpr5Z0PRfTZwi2ZV
         hYcZwcrHZ0SPDiD28WqLetJFZYTvsWP/c7VG+Hkod40g5YEeHY+d92nvuti9HDN1EsqI
         elaA==
X-Forwarded-Encrypted: i=1; AJvYcCWVKILzsVelNLGO8fVZ3heRZfynY/pbSoUBAft0WfZAESr69ewEaE+sq05GN4JOjGmoyTjhQ5TDNAq8eBLHuHaJuIxj/M25
X-Gm-Message-State: AOJu0YyblS1qW4w44aqcbOZR7Lcw3LxtgkodFThhqAVBARRioccndZ0j
	GuJ3Nr3hDajGOh+RQ0KVzQMehnfS9z4Q7SXK3Fo0oSH0e+SYZ4m6TtN/zK5o60k9vzLSMUYET76
	RLntRBvRm8g==
X-Google-Smtp-Source: AGHT+IHzAnMBckNs581oisgT1gEYkmGLUuXsG6GSAMHJ9yffFaNVeoyRFnwHsRwXE5hTHthbiTIkPj2k0gkj+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:20c6:b0:dce:5218:c89b with SMTP
 id dj6-20020a05690220c600b00dce5218c89bmr206659ybb.5.1713425591703; Thu, 18
 Apr 2024 00:33:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:47 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/14] net_sched: sch_pie: implement lockless pie_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, pie_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in pie_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


