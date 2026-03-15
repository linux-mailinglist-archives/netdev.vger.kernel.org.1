Return-Path: <netdev+bounces-267877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHRIB4T6tWkI8AAAu9opvQ
	(envelope-from <netdev+bounces-267877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5128F9E3
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40F6530BCC28
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46517BEBF;
	Sun, 15 Mar 2026 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bjpCBaCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D21C84CB
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533822; cv=none; b=CEHbrEOkqymSIcAW1k4f3L9q/DR1hszYE6PXj4A6mgZg9pih3bdY5ExZXrsE+yWk81Am56X3ZjmC1WSC2/n1eBeG78RpUD4XQreJ4geL8j87o81ow6So5oa8gMDmDNzguGeqHkIppuyi3bHQFFaECBs4vtU+hAfCubcOMkLmXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533822; c=relaxed/simple;
	bh=wwGrUQgxU7uePMbyqhRtqzF8vy1orYlCZoYEmlnK1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL+OuffyzVDAPjcJWd4fsY+zQlaCO6sq+7s9C+GCyslXE2AqabsQQSIyxmsJm9bEwykmEVNuHqX7rPjnEaKHO7UJm5ZfTC7YmeDNu4K1u7ATJykqxlqgFM3Y87ulU5TT4zSUdQbne1moRcvW3F37nU3OEDwHyYy+UwtJIJkH2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bjpCBaCP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c738d327336so2092997a12.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533820; x=1774138620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=bjpCBaCPYM1/cvLKmBEcvETznrv6nBY+9p3xO//DCajOP6TyRK9DYwWz98UMrJwa8m
         7Ruc7RAJ0lzc44b/X4wHP4hp9uAsnm+7PypKkki9meEUb+IhaQRKWLaQ4jYRnzPFwK2P
         GIxZQwPs+XQqAnwTOV4zWY8QwcebRlczLNLNXi5nPrCzdjnjxZ1Rwx17NViip7ccSpyE
         TDs+M9mt1hTvaslTW/sixj+tN2rpAwJ6waBMBbH8I7tKHybXiL47zMEctSS0h3GdhtCr
         c/FsLX96aoh4HfB/55N8jOwpH2baAH7fPguMN2lLf1U3u3PM40RkTA7/LhawzJ8XksSY
         ek8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533820; x=1774138620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=LZ9jpB4xzik5j6sWaZl3YTJ8r1eG46+y7Krjh8iOtSsF1qC4BpdmQZfyuPCF/aHTHx
         Mjv6t6g1KEcSNKprRPsN2X5ZL1bCQpXlVdVgLxiyjiUKr4VIdyPL/BFpniuGQsbZjZJ/
         Hxt39mXltUHjjJqKfeIMUsodNZU0uxTE0qOlUkhf8HxJLT/aQ9HZm9q2lrH8TFBFEaq/
         jPLOOhA3LfvKKfetJ+J42uCVOHuJ6azUZd+UXn3MUwZgfrA2BTbQhwZDIRWNYtFicGzz
         aCnnxSVH7LQn9PKf4Iph1euYqbJOrJ2rjqCSX6C0OrylkCT3HjaG5kbjhhbTlGsvxPzo
         JsWg==
X-Gm-Message-State: AOJu0YwfdwGl+mMdZ6YFkrWDdG088B3JCLVfBVBmFsGHnhCe7Hmg8BHn
	tt91Bs1GfDG2tLeK2wVsnciVQIihAQpNXyny09v/IalgA99l16pQa5YMMy5qEKgbN1ORumSE18o
	TQo+d
X-Gm-Gg: ATEYQzwnHsKXZa1taJnLXsubgnuxhmIxBYj8t42AjKqur65GnqJXkN09LzAT8O+o+o6
	TbDxF00HzemAIHQ4qVlCQoPHQpgcWMmyv5Foa9f0LgFy3HW/ZJKGj+hYJ1fmsuF+JE1Y210DMwo
	puXiv5po1iRg77Qp0uoFpqfXAO0IrlxWdMjS48APk/WK69XYAPTvV+VeKPzEnRKUvdDLh3rUTYe
	HPqoDlRt17CcKsePsXf/CZq32dIyc0SQNb6nN12rqnpAo/dHUZp2cFsddO2sr1HC+8IaKQ9z8ww
	BB44AUJJyn6mIFz+QsisLuEn/UXAIe918bsM+fDLbBY83bms8IwptG6ID1NNhVrUlHeY2Tn/sMh
	f57GMH9sV0pnOjBZpQcuqGqOJNSoDSO8Suhw3pfhk5HQnBE6NH5MjUMD1r43+q6Vmt50VNHVEVg
	51jIQTxbboAEGYMuQVR+O2vxZLOwtNiZpD
X-Received: by 2002:a17:902:d549:b0:2ae:809d:71c3 with SMTP id d9443c01a7336-2aecac65878mr80971755ad.50.1773533820617;
        Sat, 14 Mar 2026 17:17:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	stable@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net v2 01/10] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sat, 14 Mar 2026 17:14:05 -0700
Message-ID: <20260315001649.23931-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267877-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,proton.me,mailfence.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: 95C5128F9E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

The restriction breaks valid uses of netem such as using different
netem values on different branches of HTB. This even broke some
of the examples in the netem documentation.

The intent of blocking recursion is handled in next patch.

Fixes: ec8e0e3d7adef ("net/sched: Restrict conditions for adding duplicating netems to qdisc tree")
Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Cc: stable@vger.kernel.org
Originally-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..0ccf74a9cb82 100644
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
2.51.0


