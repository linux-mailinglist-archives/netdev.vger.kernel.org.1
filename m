Return-Path: <netdev+bounces-242030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C140C8BB8A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585384EE79D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C925342151;
	Wed, 26 Nov 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtPlYWba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC434028F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186780; cv=none; b=E52NkWgH1UTLe4WxMBHXluAxRDpvs6hNo0Fx4msHAGZEwhgguQzPmibssV9kl3alLXg+n9c+qVbzVYGDnk+DyCSeNJOS1jkJAF+6+J0ovrsf6w4xYvnCkZYPbrKdFhZ8eqQYawIfqk0NNaoeRokDK94+wDB8P6l3iqstnbvKcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186780; c=relaxed/simple;
	bh=4ObIb8Nr2hnmtn7Yp2+zThg7C/23U5IVs8mIQn6FeLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3oBNkH8oy+jvlb3S/7XUpqsrg80/5IlvKdKUMLc02HjMXR6Y7y95ET43lgdu4GE7GxvR8ddZgE6l+4iIuqiJQUXqtm+nVw2dhao/fYzGRSYk35aeaSaKKtZiqIjUPHTWmvh0RWgMZnTezrQKHQa34npFlWv+TojJAdFDc+q8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtPlYWba; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso79610b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186777; x=1764791577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBtuG++vzS+SsfmisshdH4uBlyieCH4bjsieINjY42U=;
        b=NtPlYWbakqz00oP78mN7uYfeCrQn2BNCBEl4xjtSUNUxLhg3qFNb5KYfAQaZyQMGph
         rNYWOlckBZ4GwWZfOcmqAL8ajuYyHb2WSGxI/Ce5r5JsknnWtHDswTVLHpUxjBK0tKpa
         tZ0nqysBfJ+Ndu+WQCXBVa966j7HbV6mvTWMcdy5x5x0NFd36Rw1vGkw/sPdZUJmnsWa
         KEFqDeDZdDchj7BCq09ku4nQl3EDHVm4Howu3QKF4IgTIk9XrbwDp9jMOhZ0zX71Oz8w
         fpDZxa2uBR5r1kdtHpXSzvPtYVlEirhMnKOsSehFP7m679droIKSGSqHOsIrA6P9GUoG
         i89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186777; x=1764791577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBtuG++vzS+SsfmisshdH4uBlyieCH4bjsieINjY42U=;
        b=sFloFpnKFa4dVNLY/B0LD2QTm4q/XW9A9gyfdAZKM9hbkW5WLlzGd99tsPb2jgMPOH
         opFVaC1RPqnQR34u0SLgmx+3BCRGXY6sExfji1ncXaaHvND7nr4V4DnN17vtO1KMp6Qq
         JOO+cGkdj2obXDxFs7FZoDqSf2zCM9lJkCdnCUcteuflY1+K1Jn9R8eEFS3q4I7xp2Uw
         EBwuA7UuqzQNfg9OORTPAQWr4kUUSaHE0qQrjvq0gZq82ABnN2pxnDvtZOaea/jgIUVl
         P6w62wjov7YWm9Y0ZgTj6JjDbDgYZljETS9KTtEfLq6oVp4f6NpA70UMChdlByMx29OU
         9e7A==
X-Gm-Message-State: AOJu0YyEhHzqSjFUX5W1PnfNAsHXdnNMk9UW8J2j3hSgopIAG+JR7tT7
	E4l//HugIYXLY0UwAd6Kx2CNMTfNvvthnS3cHx9DLVZjRB565sURAyYrqfeBxtXx
X-Gm-Gg: ASbGncsAkVHI8QirM98fXlbCYmeAQon1lByP+gt0LHV0hthZsJPR0Qw47XAG8Fx30Bl
	Wh7Rxe/D432uhN2pC/aoCZSkLrw7Tk6Szox0kj3QZecW5SL2vmpn59+ykTCUQ/FtPVAmqHsXiGj
	NSyRx4Uyy305Jb52jQLT8hUKtnpP4VOQVDQnYW1t5ROHOMsgu6pu7ygK/IpOe62tcakgHHNS3Hs
	WO9js2RPAzyrNib8b8f7DjkaSsPYUozCa6MXq25fBcj8AsHGjohiNcdZ9L9H82886j59n/TFXSI
	nK7jNGysr3q04SB2G4q5olnxEMeVANhCAq9c6qCuVaWpu3CJvUcjzXefPiryTM2F7sM9hK03ny4
	7TVvvtG/bVODRk+m8yIwbsuDM63CSWos8A4G9nti/DC1QJN83rV+DChxg4IM94pOk6ORVjqj26F
	9NddjsqEcnfsyO63fEVYaCfA==
X-Google-Smtp-Source: AGHT+IEYuS7v6z80nQpbjmyijx3u6l3pH9Kp3RptJnoA/PdI/Ub2NelAv+B0BVK+RKDULUGOB89xHQ==
X-Received: by 2002:a05:7022:638a:b0:11b:2138:4758 with SMTP id a92af1059eb24-11cb3eee159mr5865737c88.21.1764186777118;
        Wed, 26 Nov 2025 11:52:57 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:52:56 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <cwang@multikernel.io>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>
Subject: [Patch net v5 1/9] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Wed, 26 Nov 2025 11:52:36 -0800
Message-Id: <20251126195244.88124-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
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
index eafc316ae319..fdd79d3ccd8c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -973,41 +973,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
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
@@ -1066,11 +1031,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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


