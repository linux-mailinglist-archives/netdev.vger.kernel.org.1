Return-Path: <netdev+bounces-52564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93B7FF374
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C98281999
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687E4524AC;
	Thu, 30 Nov 2023 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="foggkRbf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6B1FE2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso895986b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701357690; x=1701962490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1ev49j8lKgYcL/1riuQZsBH5ivzlj1EKhMxs0dRW8w=;
        b=foggkRbfyf0ZmuxHuNVfRFFO1JNes4O5+hzcoFp+6GAw8MP9TaMXUVOVA/YFr1WrdP
         OGV2HcQf9hLNOo3us0UlH6yQw9ZTc7FxPEtGD3LNz6HEUw6rG7mwtr9h3kgAzz4FJvci
         XrokDqxvHts8gaR0LYeOqB6IDJG/NtomYcb8wjXKO4B1BiKhgnS74tRCkKRcKz3KTHM+
         KZHB6RJbM02rA3NPdSLG4phKdeMDSoYEqiu1OpOiKfJxrshZpL5jfNNT37CAKmvccVVD
         7Qxz6D0qv1sVe1+hO0VG6wGZDvBa7rbjOryPdiKntQW3SutqnqioPuwGFRuLBdhZk1kX
         IxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357690; x=1701962490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1ev49j8lKgYcL/1riuQZsBH5ivzlj1EKhMxs0dRW8w=;
        b=sTqHsvhyh3g0nL9uBLzH3XHpwSa/ZbaP/SJtV/XL9TzNSo+4i/IgnU1MS0y5mLiept
         S0C/r7Ks//FCc6MABxq1wQSfTbS8TiirhyVTxIW/wAImi4fHp8A/TKEpoYqB3jkZYSFW
         T02CjiZiXUnXtJ7KE95yYEJR3O3u0qqnOjYKrb4VSY46UOGfCDklYH+TCJzTCuM+Q2D7
         l/eXrI8SWRBsfSiIBEmGjnAzpthrGNQiDjiHOJtHZwYQq2Oz5U+NSTcKf+QQmIK9FkR/
         bx4xGT8nbv//smxBYyuN7p7OIvSo0Bok6iFjZDYehTtqLVK/8JoKt05JxjUTtMVb/llE
         UUIA==
X-Gm-Message-State: AOJu0YwsraslKbiKZmtrWsAr73E0EsNEx0s5M0qdnnsCFYlK00Oa1j1w
	0hgkItBnorQL1v2wxShhslWIHBSXNZ7JXoNFwiQ=
X-Google-Smtp-Source: AGHT+IHcTzRaheJZ4klHpLhVTDLj0DVUIgv96U9iQ98rLB6YjaFVu8aMnD/pEPDsyAiVNmBJMcHSLg==
X-Received: by 2002:a05:6a00:f0b:b0:68f:dd50:aef8 with SMTP id cr11-20020a056a000f0b00b0068fdd50aef8mr24460382pfb.4.1701357690082;
        Thu, 30 Nov 2023 07:21:30 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm1342579pfn.61.2023.11.30.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:29 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 2/4] net/sched: act_api: avoid non-contiguous action array
Date: Thu, 30 Nov 2023 12:20:39 -0300
Message-Id: <20231130152041.13513-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130152041.13513-1-pctammela@mojatatu.com>
References: <20231130152041.13513-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tcf_action_add, when putting the reference for the bound actions
it assigns NULLs to just created actions passing a non contiguous
array to tcf_action_put_many.
Refactor the code so the actions array is always contiguous.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 05aae374c159..2e948e5992b6 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1135,18 +1135,29 @@ static int tcf_action_put(struct tc_action *p)
 	return __tcf_action_put(p, false);
 }
 
-/* Put all actions in this array, skip those NULL's. */
 static void tcf_action_put_many(struct tc_action *actions[])
 {
+	struct tc_action *a;
 	int i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		struct tc_action *a = actions[i];
-		const struct tc_action_ops *ops;
+	tcf_act_for_each_action(i, a, actions) {
+		const struct tc_action_ops *ops = a->ops;
+
+		if (tcf_action_put(a))
+			module_put(ops->owner);
+	}
+}
 
-		if (!a)
+static void tca_put_bound_many(struct tc_action *actions[], int init_res[])
+{
+	struct tc_action *a;
+	int i;
+
+	tcf_act_for_each_action(i, a, actions) {
+		const struct tc_action_ops *ops = a->ops;
+
+		if (init_res[i] == ACT_P_CREATED)
 			continue;
-		ops = a->ops;
+
 		if (tcf_action_put(a))
 			module_put(ops->owner);
 	}
@@ -1975,7 +1986,7 @@ static int tcf_action_add(struct net *net, struct nlattr *nla,
 			  struct netlink_ext_ack *extack)
 {
 	size_t attr_size = 0;
-	int loop, ret, i;
+	int loop, ret;
 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {};
 	int init_res[TCA_ACT_MAX_PRIO] = {};
 
@@ -1988,13 +1999,11 @@ static int tcf_action_add(struct net *net, struct nlattr *nla,
 
 	if (ret < 0)
 		return ret;
+
 	ret = tcf_add_notify(net, n, actions, portid, attr_size, extack);
 
-	/* only put existing actions */
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++)
-		if (init_res[i] == ACT_P_CREATED)
-			actions[i] = NULL;
-	tcf_action_put_many(actions);
+	/* only put bound actions */
+	tca_put_bound_many(actions, init_res);
 
 	return ret;
 }
-- 
2.40.1


