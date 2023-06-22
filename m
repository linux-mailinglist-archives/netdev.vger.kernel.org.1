Return-Path: <netdev+bounces-13153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BD73A800
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577891C21179
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0A2068A;
	Thu, 22 Jun 2023 18:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9A1F182
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:15:06 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA991BF6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:15:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc7267224adso1967094276.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687457704; x=1690049704;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3rG6uVeaKtv1/Xu/3jg6lBkHawFtmhxN0wlD0cxVUw=;
        b=hQgSowyJtZ1pnol2iqjsYteVqMh1/T3R2tg6JFE/7BJGDmHR5nRPCf7X3TjmqZtSCz
         uXecHIKfHs4CvFCQA4sr4qoNDQNtoO1VBap9XLU7VzF0AVuz/2aCanh7B869pAQkS0Nv
         pMEZTqjAYkt/clPmWCIFmQ9sVI90r1MPjIKSV1oRPj2VAXwwgaQNxL5HhycQa7koLTIV
         oFGeYeBLDLFlzz8clFGx/aJqkXdfZzWC3rnpO6uWWun7iaOR/3Yox00JZVVQAPo3iQoN
         L+doQngvuNP3VTUo3utKe+oRQjdv1cENqNJgRRBMo+nLb7mTBHhqT69gTbyAwLmbTHX9
         i02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687457704; x=1690049704;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3rG6uVeaKtv1/Xu/3jg6lBkHawFtmhxN0wlD0cxVUw=;
        b=TgXUSr1k/l1ly8gyjOO223QR2rIOzDySmwDyfy2cMps3ka8tOy5fzbNsATuC0zbJje
         7Q/uTy7jSb8W8HfeQcn+1i1cwORumIPC8Xu5VR+z3rgSoqm1qkDPc1LpEgtyHpRlHhsI
         6yazX0OCcTL4elEkwdyLybACOq7wzk04vutj76Q9Sz+7117goLG/4COnfbtCu3PNfpdD
         SJEX7jsOe6RNaj94Wsl/u8FdFF1We8hcA68y2vcJdQRLF1h6JAqGwjTZ7zYF9+a4pohB
         gjidN/ba6qhh+r88HjsxiDQFVJr4SHJ3BMfkk2l7/VkQB/lo81QIcq91aupDJi8psLmo
         nQLQ==
X-Gm-Message-State: AC+VfDxMajkPbiXl7WJperPX2LKgVYIXKuL8nLEWs55Xw+xXxtwdhs90
	vmTTB3n2hxUGquf/3+VG+9xLwakbttD/1A==
X-Google-Smtp-Source: ACHHUZ7dlHMhQ9sqkWtHtuW9iRf0gTPGj87ieGflS4BFYjxCTWdS/5F+rizeMSetkfCIanahxn2m8kAFMdbaPg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:92:b0:bc4:a660:528f with SMTP id
 h18-20020a056902009200b00bc4a660528fmr4935999ybs.5.1687457704589; Thu, 22 Jun
 2023 11:15:04 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:15:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230622181503.2327695-1-edumazet@google.com>
Subject: [PATCH net] sch_netem: fix issues in netem_change() vs get_dist_table()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In blamed commit, I missed that get_dist_table() was allocating
memory using GFP_KERNEL, and acquiring qdisc lock to perform
the swap of newly allocated table with current one.

In this patch, get_dist_table() is allocating memory and
copy user data before we acquire the qdisc lock.

Then we perform swap operations while being protected by the lock.

Note that after this patch netem_change() no longer can do partial changes.
If an error is returned, qdisc conf is left unchanged.

Fixes: 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <simon.horman@corigine.com>
---
 net/sched/sch_netem.c | 59 ++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e79be1b3e74da3c154f7ee23e16cc9e8da8f7106..b93ec2a3454ebceea559299f90533cbf1c0f7c26 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -773,12 +773,10 @@ static void dist_free(struct disttable *d)
  * signed 16 bit values.
  */
 
-static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
-			  const struct nlattr *attr)
+static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 {
 	size_t n = nla_len(attr)/sizeof(__s16);
 	const __s16 *data = nla_data(attr);
-	spinlock_t *root_lock;
 	struct disttable *d;
 	int i;
 
@@ -793,13 +791,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
 	for (i = 0; i < n; i++)
 		d->table[i] = data[i];
 
-	root_lock = qdisc_root_sleeping_lock(sch);
-
-	spin_lock_bh(root_lock);
-	swap(*tbl, d);
-	spin_unlock_bh(root_lock);
-
-	dist_free(d);
+	*tbl = d;
 	return 0;
 }
 
@@ -956,6 +948,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_NETEM_MAX + 1];
+	struct disttable *delay_dist = NULL;
+	struct disttable *slot_dist = NULL;
 	struct tc_netem_qopt *qopt;
 	struct clgstate old_clg;
 	int old_loss_model = CLG_RANDOM;
@@ -966,6 +960,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	if (tb[TCA_NETEM_DELAY_DIST]) {
+		ret = get_dist_table(&delay_dist, tb[TCA_NETEM_DELAY_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
+	if (tb[TCA_NETEM_SLOT_DIST]) {
+		ret = get_dist_table(&slot_dist, tb[TCA_NETEM_SLOT_DIST]);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
@@ -975,26 +981,17 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
+			q->clg = old_clg;
 			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
 	}
 
-	if (tb[TCA_NETEM_DELAY_DIST]) {
-		ret = get_dist_table(sch, &q->delay_dist,
-				     tb[TCA_NETEM_DELAY_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
-	if (tb[TCA_NETEM_SLOT_DIST]) {
-		ret = get_dist_table(sch, &q->slot_dist,
-				     tb[TCA_NETEM_SLOT_DIST]);
-		if (ret)
-			goto get_table_failure;
-	}
-
+	if (delay_dist)
+		swap(q->delay_dist, delay_dist);
+	if (slot_dist)
+		swap(q->slot_dist, slot_dist);
 	sch->limit = qopt->limit;
 
 	q->latency = PSCHED_TICKS2NS(qopt->latency);
@@ -1044,17 +1041,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 
 unlock:
 	sch_tree_unlock(sch);
-	return ret;
 
-get_table_failure:
-	/* recover clg and loss_model, in case of
-	 * q->clg and q->loss_model were modified
-	 * in get_loss_clg()
-	 */
-	q->clg = old_clg;
-	q->loss_model = old_loss_model;
-
-	goto unlock;
+table_free:
+	dist_free(delay_dist);
+	dist_free(slot_dist);
+	return ret;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
-- 
2.41.0.178.g377b9f9a00-goog


