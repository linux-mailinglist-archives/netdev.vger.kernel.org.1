Return-Path: <netdev+bounces-250809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B2D392FD
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A4E3013551
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1B1F4CBB;
	Sun, 18 Jan 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACadoKKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C8234994
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716963; cv=none; b=WBEeHsYMdblFk1H0nYS3YqqWZ0T/Bx+MKrTVA69+lWZuw0SYkaVhlG64DJ8+olRqyVrmTBQE1KvrkjdcpyPGOqGh6QZ1E315Bm3fHWBH2NFa63CjrcQWDShB32lgEDSSq0emWB1AZARtdMW53O8gqsMb/DaSkMxQoAVdW5L2OPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716963; c=relaxed/simple;
	bh=+qawgLYywjRvIq+MV8PSmrjgcvwoN/wT+5tXJDifDmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvAUNp2g05jbu0zo3vyznlPzcGc+0zUGAky08xGKkaKafTtq9EkoQXZjTRYdbUZ4SKmkfwiP7Rcn0amo0nghhr1bPOfDnln0xncs12oe7mSVNivnViGOj7LxGVL+mfawTZ1GQfCeggLux7ftDWh9WJ/TuDUcjh8ZxwRTX5To2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACadoKKQ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233702afd3so4100987c88.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716960; x=1769321760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=ACadoKKQGBEPwFzKQ8E5EDZ6ulo4cocMH+1ItgiZibDAursPMBE4G2cxPpT//G4bru
         yQyFgRInLtQzTg7xs0SxQUOCfS5+zudqHPWiz60JOgu2RddBLQ9izpKO0hXmQ5sRf+Ft
         a/0dGuw2ooNzWKLc/G10vZiuyXSTDqOyhkoBIzvmaLzZtDO6qcx+qjBGOazAHrvvweap
         r95k7qJ1BN8JWrPtKm46f0ZAxJThZC6Xx1BQgiTq6aWxu1c8e7l0gHNzpM8Lgwpj98mS
         JwZXGCmXMpAD4vaHr8IuDVQcjc8Kmx/D2Lp+l0qe77TtK4c1o+h4sITOc0eDD+gnlZ/9
         6p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716960; x=1769321760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=vQuj+FOZSNTp9gychU/wfy8NfiU+mSN1n/mmAlqcHGBqecxnuHrzutdXZU0F6fX4DG
         ACtc0FkENDf3ZaUhRrkK5Ro3VzrqjHcvEkHCcyer6H4olCnRF6y2cc5vIEECB99LzWWD
         VZJh9lgJ1wZjFl4bitPtfOohkq1Mj4IjhYdHPUHd8XslQJxvZ0EIc3Y9Pd5vCJDCX0/3
         Eu8DsUSMH5wIMOcqHWsHnpvUdfANs/6rKFJyB7IWj99ChHm4GEE8Pw8R/qUwdnmxrma4
         +g8VGClnn8sWwAeoqrngsgCMVXVuVrJWvoZh7OjOMpSXy6erOnUBMNISkciXBK6XukUS
         9/aQ==
X-Gm-Message-State: AOJu0YzQOCk96HzJ3MTaHw+XKtlhXSyYs+03NwjxHlsFf6fBePBDtN3P
	B/YyBajgrPcp0iRN2Wioq4uGsc/vYrr7ZjB8d2fz/ri/7Ec9ZjXTdQtmrTfdXw==
X-Gm-Gg: AY/fxX4qfLeFiAb5b8cKYtA1N/lTOjd4Fbgyq5OhNlhXNqbu1aDxGW22P/Gqp8rUYKo
	QZacLt1wRf0Xj8TfJ7Y14SYtagUJi9amKMt6vgg+5ys7lZIu+BAHYfoZGxNHEiH5Br5j7J+VrIO
	hFvTmgHPACE0EfP5BhYubmsFeWirGE+G5lnkq8KSkgWFjbxSP4L9O+iZHdoxk9UG31AN9gIwliz
	KU4/IapdHOzaTNwrIA8LI3SD3XPkAwYpJnP+KmLPGCrLMobpYxjifrQAXl4l03UoLJcxBb4bLA1
	2I7k8TIJ/aVZDV/0fPxd9j+Q4Hjs6uEq1FhMzSQCTNkP+zj6sDB9GoRCMkiGsfpvsS1yoAjsv0v
	Wal4cNo7V9Wn2KRN/vHcEcnw2tKXjY5xrT/Hq1T16FtvX4Lgl8PRcWc7DLv617O8Bz/Clr4Ki6Q
	541RwNxKoxZkNmMYFh
X-Received: by 2002:a05:7300:2d06:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b6b40b5ac8mr6063841eec.27.1768716960272;
        Sat, 17 Jan 2026 22:16:00 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:15:58 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>
Subject: [Patch net v8 2/9] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sat, 17 Jan 2026 22:15:08 -0800
Message-Id: <20260118061515.930322-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
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


