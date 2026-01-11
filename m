Return-Path: <netdev+bounces-248831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D8D0F752
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F406300B015
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA034CFAF;
	Sun, 11 Jan 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="R4+306aK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E534D384
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149612; cv=none; b=j9svikCXcS5lDsdw5m5Jlv+y6bUZZoYmiDBP5CWkb0ZDcAF/94vfEAtkDzp8AsYeou6YDcfnucgm5ynBXE+KtS0/7+Zv1qSnhePAgeDv+b+5wOn8eF/LQPURx86UrBBH4pcRiMJiFaupV1LI8dh8eYSS8WEfGyS4t4bQmapvewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149612; c=relaxed/simple;
	bh=awXvZ1A71UfcYDRdKlq/EuSVOy+E3bLoSReBcOuAvUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQ3L73AJzK1e3lFM8pjHpMYIKL1PWTqttt9GRwVv/LwLrXssHio2ic71kGdVWSpwqPvopDtWe0z5/33hka7UcTGk5Hv3igyRskcSRjvBToAXKKthYACgkAHdQyq2h8IG8kjDNEyMZfJVh0rq5zlHA/AdifDuijIAvgsnEPE06Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=R4+306aK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ba3ffd54dbso864235985a.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149610; x=1768754410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ/cSikLvbI3hXJPKoBuG8+prqN+wus2UjaGRinM+Zc=;
        b=R4+306aKcRkTavVJgKshF5OGubKTSIvbyDEnWARlw53MLMN0tNFtZqkX/vwVwYAqJW
         mxQmNhI0Wt9GpG4y02tPLdWSESwYfdQuvx/CLcK8XEL2teZfELGcJ0798LO7Rw4v8Khx
         p49Q5jMHEPFXw79WBGPwlB0WmRA1qWd1c7bsGCTPPPphPRKboyb/XiWiDfiYJlUWJeUR
         vesrTgZI0r6rJpm4ayoELhmGuyEVdoatEAo3OhS8R/CZQkmGp+E53Pw4pd3LoHFZIIBn
         HCy+vaCupnEHWD6P4FDZ+x4KNPDo8wkGXBkdLB+nHuehgKcIcyZftcxhSWqkGbjjMqDx
         q62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149610; x=1768754410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQ/cSikLvbI3hXJPKoBuG8+prqN+wus2UjaGRinM+Zc=;
        b=r2pWaI00cBnY+lu4wA+KvAh50lvBKgt+dEVHrc9bUhNLRJciPjGi+YVjzzD12Jmt+w
         /JQGJem3Xakqh1brfabF02GVGGyqNdk1BWro21Q1HI6ZpAGw/HBFZsUAEqV/a1D0apTA
         hc9/8OnrfTaWdDZmoxg08jCfwlNjSZ5e5PWWARSQdgbYvWNsbabzm0dhYiYp6qTqq/Bi
         NLHCdv5O2jI5lhIS4Vqv5Q4cm6Ebk4f2j12funZFXlWsyvF6W6SC7XisPsSVAq3tDlCU
         5D5xRPonugZfikbGHZd5nKE5z4zvVHv+DIG/9xCzpUM6lE76fUXhGJaUZTvf0SEdMyQR
         HIew==
X-Gm-Message-State: AOJu0YyHzOQOpTmvztojfpIoLcDBKOSbDTAlYMQbVqQmsCoee1gomJc1
	J0RTwyKYTXGWkDysYwjFlcGzB/f5qwiuawrA8nbxOX48yp+MTnIJRGKBScy1P8BqOQ==
X-Gm-Gg: AY/fxX43UdvZQsQVz4Qia6Y2vzOtJ5dyEw9vUxEhmqasfIQqVz6SdLmCAod+guPKdYP
	i9YnxKwJ1+TZLOY+GCi4Woa45LA2pj/HYFtFFcyRTqzQlmYBdkFSaT0+uZF/ZmfZCT6XJv6SBK8
	4wd0yQxjCjgQrqkNm1B70scNETLLk9JX7kQkPa4Xyk6DZvL2fpnLYv/qWAgaBN4AApLwaW0bUc6
	jbPZFpH9CLYSpPnbimlWTQwLhQv1riizyaTGQ1hnKPC/5/EsYRX8B7AhogagiFhdrwxT9IXsdDA
	F7nl2YXqu5+ZfzJzHGVQJSAjWHZRsWRaYSFHR5TDR7l3hY3nWp3tynhuHpz6BhPjuXh2jcRLrCM
	lQzWL+L/ik26iWrVYU+Hxg3Dxl9qkyIFZavTFbtrrrczpv5VjqCSRfAdeK584K68Cs6uQTvXeiY
	uG3Ujq5eTyMOk=
X-Google-Smtp-Source: AGHT+IH8eQLPUqqvtM3zcUhfnrqqyrUCdSxRKj6x4w0G4bkcCcHfrId3b1V5LyA7v8lexn8lAaU/Rg==
X-Received: by 2002:a05:620a:3911:b0:8c1:6018:b186 with SMTP id af79cd13be357-8c38942e90amr2024853185a.87.1768149610105;
        Sun, 11 Jan 2026 08:40:10 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:08 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 3/6] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sun, 11 Jan 2026 11:39:44 -0500
Message-Id: <20260111163947.811248-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
References: <20260111163947.811248-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Reported-by: zyc zyc <zyc199902@zohomail.cn>
Closes: https://lore.kernel.org/all/19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 32a5f3304046..a9ea40c13527 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -974,41 +974,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
-static const struct Qdisc_class_ops netem_class_ops;
-
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
-{
-	struct Qdisc *root, *q;
-	unsigned int i;
-
-	root = qdisc_root_sleeping(sch);
-
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
-
-	if (!qdisc_dev(root))
-		return 0;
-
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
-	return -EINVAL;
-}
-
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1067,11 +1032,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
-- 
2.34.1


