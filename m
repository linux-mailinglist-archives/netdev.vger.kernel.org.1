Return-Path: <netdev+bounces-89028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC948A9418
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA98E1C20A68
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16232763E0;
	Thu, 18 Apr 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lh/unBkB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8A7C6E9
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425591; cv=none; b=YQfd5pfMHqBi9ttXxg1CpVNq8qGoseaeLsYMVwH4eDSidPq7C1bWO4oKBPZtkGJzHfNChUJAwe2ATwtPW7xL1wpvdWK/uyKiAi8IjQOsB9rU60dcY+e5dOEiJLfwWJoHPHgwctNCp0tJquYLHT/U2z+DFlFfyP4ldJV1UT2S81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425591; c=relaxed/simple;
	bh=HLoq1i+V4ApQOMYBc6PZyJGfENZMo+oN8p9CzxOHy6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7HqD0a+zSWA/rqHetPdIIiYbr+cTB3rM/aDArFF4PVCI84vq439CmI99vBf4TE6wGIM4tJpUC8ocZKR7uPYFm6n9YALyVwl/N2Jz5q9TYhr+kGe8NDe641BPHycz6bBkATmpGbPNPWrfB51z4uMZBU8gb1YxFonlKCqe0Xpbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lh/unBkB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de46620afd7so775836276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425588; x=1714030388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2TA0iHMw7gZTifXWG5WTrNRKCCbxVowF92cfYPY/pw=;
        b=Lh/unBkBUhUelW2CtPmtbmSwkznmAx0FnsABHqaG+Kxw69Ua3v9g3t5HqwYG0UHQKK
         2flVnaTxVFTNxAQ0efiMZQjBassbt2ochX0rKy/6ppm4CNqJjjMcMw3VsYFwp6tFXiFi
         B4TCGiSDmL/aO0/IWDMwdG2EyCZfZbnoOk9+7h8MRkrWUJRBv61Vj7PRcvYsmGJ/Qhlh
         TvwzxMCZcXOLopCs6Q7FjH3oHKSTr+VbYkBP/U2nh0Y8eiy4qjGFATazBNbCOydQhIT4
         1Nu3kRCjawTnV7+Lem6t0i9LThv54nuGUylak/s0f9nnuQ1vqb+pkVtAoS+AFEouXrza
         3xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425588; x=1714030388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2TA0iHMw7gZTifXWG5WTrNRKCCbxVowF92cfYPY/pw=;
        b=nYrxlfDhM0uE84LorNP0BqIBF5Cg5jwn7qC4KkHBJFmn9rpcrrlZ7zR4izwtQMpYoN
         Cx/d2cJv0+JWRsgYZJNnsVPUb0SuyinKpOAeX7mSKk8fF4UznaJOPEHVEp1ctsa8llrs
         +Lk1gyTCQbPrp+3G6hfJOYNTYtLJm0/rxFp2GZM0FWltln5zaNykRcJ2I344C0kHI2df
         QavhNU4H0DrSM1zH4lyRuQtqSo7z9tXW1YNX5kqrGpzIZLwoULe3dQYTnf8yOzm+GewW
         gaU9+cGmIrYezC/t9tNthIQIis3EczjhiiX3PdCpVE41d3QTj4L355hUUNabUly4Lh4Y
         wvGA==
X-Forwarded-Encrypted: i=1; AJvYcCXcMIu/YaOaxHuUfcP0xmX9S2N8I7GuDjGYv7KbeAraQmCuOw78QJS4JSGv0lL7+8yi5ZA4ME/YXH2El8F/oXZT6nc2Q326
X-Gm-Message-State: AOJu0YxGzGDxZBm4VCC4K+cCjdtOnW27YtAYOfBrqqnidcL73t9i9uxK
	zaGx+Ul9/IlrBypp1opE0mDCkho0TUjonHr3EycW/4dv6HjhEukTvA18mOL//kGwiDeTJIEaRLy
	CVUi0a2WMTQ==
X-Google-Smtp-Source: AGHT+IGCdemKID5Ih8hkY73Nm2GNNuUItojO8QfUPVqCBKDzmRhHzkpG34NIqSXw+vWOS1nciXqGlO+vaZYt7Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:20c6:b0:dce:5218:c89b with SMTP
 id dj6-20020a05690220c600b00dce5218c89bmr206655ybb.5.1713425588684; Thu, 18
 Apr 2024 00:33:08 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:45 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/14] net_sched: sch_hfsc: implement lockless
 accesses to q->defcls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, hfsc_dump_qdisc() can use READ_ONCE()
annotation, paired with WRITE_ONCE() one in hfsc_change_qdisc().

Use READ_ONCE(q->defcls) in hfsc_classify() to
no longer acquire qdisc lock from hfsc_change_qdisc().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_hfsc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 4e626df742d7a937c219ae9755816f099b6f0680..c287bf8423b47b7ca022fc2e6ca19b77f3ec13a0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1174,7 +1174,8 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	}
 
 	/* classification failed, try default class */
-	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle), q->defcls), sch);
+	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
+				       READ_ONCE(q->defcls)), sch);
 	if (cl == NULL || cl->level > 0)
 		return NULL;
 
@@ -1443,9 +1444,7 @@ hfsc_change_qdisc(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	qopt = nla_data(opt);
 
-	sch_tree_lock(sch);
-	q->defcls = qopt->defcls;
-	sch_tree_unlock(sch);
+	WRITE_ONCE(q->defcls, qopt->defcls);
 
 	return 0;
 }
@@ -1525,7 +1524,7 @@ hfsc_dump_qdisc(struct Qdisc *sch, struct sk_buff *skb)
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tc_hfsc_qopt qopt;
 
-	qopt.defcls = q->defcls;
+	qopt.defcls = READ_ONCE(q->defcls);
 	if (nla_put(skb, TCA_OPTIONS, sizeof(qopt), &qopt))
 		goto nla_put_failure;
 	return skb->len;
-- 
2.44.0.683.g7961c838ac-goog


