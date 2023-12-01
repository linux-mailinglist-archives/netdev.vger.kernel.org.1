Return-Path: <netdev+bounces-53021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB02801211
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21C42814E6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AA4E63F;
	Fri,  1 Dec 2023 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1yrGcL7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DCAC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:50:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc3f50504so7051665ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701453039; x=1702057839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRhesmXXYI6gg/faEEULuV9LqMXx7NbwJMsVvZWkiYw=;
        b=1yrGcL7jS4OtuwQfqZ51BQrVcWg3+lPuv24Lsm78WlpbtT4AOgfbywUUHBg3G+GD7m
         E5P0BeH2G3Yoxa2DmU9Ibk3sJxgvJrM7z7gyOaBj045lDzpizq+TUTUUD0WBF26mS5YL
         vbVHXnTzfC787VJ7IjhCIcj0kFKoB/wOY9AWU2mNOCW3Vvhkl6epSpFSvXmbzY46wXSZ
         mDKTEZ8KjsLxLqGczPBwAfS7ZVRGSZVtbYk7pCO51vwjCXmfpUFjOorMe3DK+8FTRj5o
         UnCRedaWCC8URLB2d75+oAI8zy5LYbDYaJ5070Hkz/7SBcc87/hQG2pPfhKpYe8LGlxy
         1O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453039; x=1702057839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRhesmXXYI6gg/faEEULuV9LqMXx7NbwJMsVvZWkiYw=;
        b=wbBIVxlgh094kuP+mQy3mDMAjezHo7GJM3iomA9bWdNRo9lU/URdM0bgekN3gsvkYM
         fA+gYWUgfCjVdoRTiJijWf0lWMnvJC6a3+Moy/jmA9Iueqr6YF8QOZzoSGe6+1ePdNQY
         BsNArjEQHsR5eNho4y+I0Fc0c7DWLFsLm09qvWJx6nv5ELx+/vPGrYgDO+1zmYcmBgGN
         g+to6HZMD4ljjDilK4dOv5QEXllfNq7Qpbk3KC2ayCJo9Drchollw6VEgWbsytjGKrc9
         i+N1IrSsM/jKoA8xVnoXfGBvLA9GN6c11AZAegIJnefhWgzjOFnP/6XfUmdPr0F7RjaN
         vlsA==
X-Gm-Message-State: AOJu0Yw0i0PHtyYVn4yLcB5udyZjij03oOrk65wTk9BCj+H5s0WR2Ygj
	j71S2yNj6gp6NSKEp52AAP3cnaA07ic2pzQJV9o=
X-Google-Smtp-Source: AGHT+IFKaYmuSsnTmU8+S7g1ulLc34BmwaRtgirSn/OXZ3ibQqRXeK91r+ApMWkT4NAq7kIxVG0cyg==
X-Received: by 2002:a17:902:bb17:b0:1d0:67a7:2ebe with SMTP id im23-20020a170902bb1700b001d067a72ebemr927123plb.66.1701453039208;
        Fri, 01 Dec 2023 09:50:39 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm3619729plo.278.2023.12.01.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:50:38 -0800 (PST)
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
Subject: [PATCH net-next v2 2/4] net/sched: act_api: avoid non-contiguous action array
Date: Fri,  1 Dec 2023 14:50:13 -0300
Message-Id: <20231201175015.214214-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201175015.214214-1-pctammela@mojatatu.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com>
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

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
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


