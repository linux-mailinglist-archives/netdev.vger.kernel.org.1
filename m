Return-Path: <netdev+bounces-246151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03268CE018E
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3B3300BA05
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF1328633;
	Sat, 27 Dec 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEv+ePq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C95328616
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864509; cv=none; b=ZjKKPI7qbCRBDt9T/vXAjW0+50L9/Zbp6itXctalfeJ8gS+uDXtWW6bDKNl6K10rdefFJ6eBJJrgAA3aNK7Zso9Qof6ZlsUUBKodEw5K6FNhtRXaE4BB9RxLd2RR9Udwj690NDxEB8Zv5hZouWhR5iyBHQWE/HkpJ6rY2H/aO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864509; c=relaxed/simple;
	bh=+qawgLYywjRvIq+MV8PSmrjgcvwoN/wT+5tXJDifDmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQbv9ToUpwaDqTSwYnB4HHJhvfcu/SqHE43Y6W8hlORdeqG4SxI4IeipukWSpJFwUOOx6fas/jjpQa2+vQ7gitgF8YdFvqkWvDyTjqIxo4SExSFT+U5cfk1rLiCdzaCtbMmnlj3RqPIcOz2A4ibyAiq/JUgJnFhtIRE2mSKI464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEv+ePq3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c2dc870e194so1616748a12.2
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864507; x=1767469307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=CEv+ePq3uKX4mWwN5t4HofNQGK8dUW78aPc6FfOptOnN4cEMQksfLjTrwLDYiMX8cO
         2qR3f/VDhuPq/7gVM28LqSQNyb1QMUyO9UP7QIUJK/wuxLe0YYYsPxQokoe/mKNncxr7
         vWc0tek8GBTuauNDli4+2KGz5hrTEpjH1MTZQ8JfOw6bgRZrfFQUS8UWfMsmnx7rGrHz
         4/un0y8TFKDdSyFSfc266Ec9HSGr00OgnEVpjmcZILehpdKRwRo2epHw4z1dCZgotYnX
         yVVdHGcrrosaoV82Qq8U37Kx0Mh3PVLlZ06CKgH9dNVHP3DwrNLyPdio/Mq1B/J4xqHX
         UTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864507; x=1767469307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbOh/n2Ke0qUO6yeC9pva9DZtbquwXtOBVoJ67Q/RvY=;
        b=q/Ahxx65Y5lXOJx329VFMbYnRHCXo6Cv/qrhB6H/SxbbAWAB8mNiZsSYJsAFmeU32P
         oylF1rG0xxnNA/6SoH5LYWGhUXxl1ZhXlYO6wke3K+aUpmZRkEeNOWuQ7ScxmsQQdQKE
         RvtQQtLESeQ6X2lMnf36uLxrTmiplvLxaCkxo8MGb0tbLMyZ0+dD7KuJEGE7CZkSDxeL
         Y/LkGpONR2zFux9cZf4qai3S8C7hNfmFm88s3ayWaj3ULRqE1UVToILBZdvTH50dKSbo
         PraWr6bNtAWBoi1XyexMeWUHNJENyRWx8Sztpxj1ZkA5UawIrli+2B5QS4PB/aKRaBX8
         URgw==
X-Gm-Message-State: AOJu0YyxLpUUFxww1gZ0LrBOeEcqFcLmODGE3h1bt4uQ/GaeUd5P7rX0
	8y/mhIXbnfqRGDWRgG5yELgCyjNwOeLXFa70fPb8YaB0wMlD1EXEggyjyfaBjA==
X-Gm-Gg: AY/fxX5U19rs4R8zOhBNDkJdxxjx6IIsG31SBQQQk7Nta9E0+KVttBMwTDO/EdBpOQI
	14o7qxE8CM8RwEdYRkWIuTo/pXgfULFYlLD94lI9vJFc/q39N9znJ/he+qtDmA4j4J4U2OqEPAy
	ne9bxJCAsgKo6Qpccd3I4CLbdEnE60qo3+xc8DiwOEkp/Eqk3F0CzObG87Tyratkne+FByOOt2m
	fKRS1FCFbj+zizGi+CbNjrpP9LiiGn6LfA/egLBhrN0Iufl7eVK4NmkizOYAo4zhd/xEL5C/RBt
	WE9/olfcHFb4gZ5tLCaV2fxrRWXgW0NsA50EI/fCjkTxhFVhcYfRxZXD4SMZ+lBf7E7yPJL0DNv
	VFskBusXeRCqjvoJere37fT6FcDSH9oXwvGOyFEQKGtUO0vCZ4MkXzb9FQxldDQ2OWiW/RjnqGI
	/3eb7EBPFDYQSpz/A7
X-Google-Smtp-Source: AGHT+IFF49IX0GQeHbGrX3s2BZS9queL4fEJmtotMxjJRa9gqDw25DVeJFi5sL5+iXPs9msDmYmBjw==
X-Received: by 2002:a05:7300:fd04:b0:2b0:5735:25a1 with SMTP id 5a478bee46e88-2b05ebdbe3emr24576319eec.7.1766864507218;
        Sat, 27 Dec 2025 11:41:47 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:46 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cwang@multikernel.io>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>
Subject: [Patch net v6 2/8] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sat, 27 Dec 2025 11:41:29 -0800
Message-Id: <20251227194135.1111972-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
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


