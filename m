Return-Path: <netdev+bounces-249556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD0D1AF10
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D747C303C139
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D503A3590AC;
	Tue, 13 Jan 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt5tobkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88323358D0A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331216; cv=none; b=a1pretmk7DYYQkPNk3OrOmATtbub/mUR217pwHRWWd5Vp+0bCBYvR7dDuo75EwbOJBe7gjUlkRBdQ0qIudfaIZGP9nt95ZW0vqhjJZ3VtFdreouqJsuocBajfvEsHJpb0maO8DEf+IdoSMJlRl2wWWwubrWqufaLwqF8ViOX+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331216; c=relaxed/simple;
	bh=+qawgLYywjRvIq+MV8PSmrjgcvwoN/wT+5tXJDifDmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZZhouhsrq6diTzIGGTbH21SymDfb8406IKQ6UPLe9/G7nY9kfspIT3ciw3kTLQxMH6izfuV9m/IOHFXYXRQ4W7xNVN8BgIVNkKPezu/sBtYbW4LZPnK2EQavk5Ropm2Ad8KVk3N/gbm84Ctbvx0dzs5nVjSfvE8iWbg3a/hBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt5tobkx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f3b4ae67bso1843279b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331214; x=1768936014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=jt5tobkxxBcBb66zueCTZL8802BncateujWq4K6a7ifF7lmGG3Eh6bXVytYqeTaZSF
         Xj+fOFcs7I2Pv6ehQ5Tp5OrFwUmO1x0acWSf6jOO/lLz/CI5GbgZkC1ar2sfEjrwV+aD
         nqYoh7n6mCXYcnAvQqu+dE1gDuAeIvI/B7Restk5zXpnSqtiX4xEaHyIk1t7Ga+XvdC3
         dmENERDkphxRceLCnnAx/TUQ0Ha9sq0jYilT50Jldu7J1Hnw+Q5YkQsapLC24vzWfFbd
         eDl26pjUrYlmr7rallK4TGLivJlm/gnCAEHt3wSSonOc+SgeMIFs41ryOHtR6CK8CoUI
         0p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331214; x=1768936014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=RuErWspUX55J2udWE0PhKcAcGa3MSSDBExuDGzZuvwTFx1IyUERyFjDMlcWmIkvyFR
         qdZZJrVR/yyhav2Za34j+6yQ4nObBHvjiKM/cDXl88K5epkMqZMxfkl8Rr+nOFCwFdCj
         0+oWK01gI2kck9aTiZnGkuV24VxnVfC87El3EJSfG0uX8HKBZFmVxeOxU0V4rcHUk8cW
         h1UkoJkQcDRvlxMIxbWOXfQzaLbcneO5qimA6FeVsB7oobyFdJlHih/31wfoSTFf0SLa
         AUGedCau9RimmIiskxbVA/rLCXvWl4ZZAN+ROWQ0meeux7nYsIlRI/k1hX7H2EJpmxYb
         aaGA==
X-Gm-Message-State: AOJu0Yz/lDYt0MzQzTypA0R24VJrHlG2cHRost5bzjeZTKndwWEU7Rg2
	oYs50mH4/ZEGij/xnB29260AEibjYwoPhMGaO4kG6Yg3CwUhBERByJTTrDlbWQ==
X-Gm-Gg: AY/fxX5jZcIJabp+cMhqgCYWOm2XCQEesrLM5T0sIag32jWOQJTKlcmv4YzyS9DH/Ft
	Z+qF5guiYjx03NCzQN2XxPz5krOafAIOqCnfW0FPEIV3OM6pwhZy92mTJykoIHfjoRAKCb1LjzZ
	XxXCPN/o09U25P54ZuRXfDLjzKQp4hH0ojA/a1WU7AMCQ9oIS1c4jE2itUsy5TaQU5KTGPMFOIb
	bVuHlUXffg+OzdfsLMJ+AS1sMEeBjCViB0iurzQi/Hz7UGD2acqwJNGXh9kfXe51f8ui0OwILaJ
	pVRfRtUtyXklV0XTHDQ8scel0ThT6KfRKVG+HeGUF1ai9BlCq3sBiZ1RkbgbiwOIl6Mjtb3FzYv
	EMUiAhvuMWhdZOjw8pnrOfEYNedVe8t7WaIdsGs0ZcpkfI+tc4g73DMAZAmaGD1UtqqzuoNfcQb
	qB1tnOOPDsVdhKyNqQ
X-Google-Smtp-Source: AGHT+IHGW11PTumXoldP7PiuLbprRKR3Ekvr5aihEULg5CHRJRGb7TFIRyRvzI4OXc+j2XVcFke4cA==
X-Received: by 2002:a05:6a00:e8c:b0:7fb:c6ce:a858 with SMTP id d2e1a72fcca58-81b81197415mr18225213b3a.68.1768331214445;
        Tue, 13 Jan 2026 11:06:54 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:53 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>
Subject: [Patch net v7 2/9] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Tue, 13 Jan 2026 11:06:27 -0800
Message-Id: <20260113190634.681734-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e since it
breaks mq+netem.

Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Signed-off-by: Cong Wang <cwang@multikernel.io>
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


