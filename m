Return-Path: <netdev+bounces-53020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717BC801210
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF61828148F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067074EB32;
	Fri,  1 Dec 2023 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dWGL38WU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE68FC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:50:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfbce92362so6031795ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701453036; x=1702057836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPiKsCCgA2C4rEsExgFz/FQnyM6xy20WmctuQWGyukM=;
        b=dWGL38WUimaB0IKg/4WDwF2XMIte8nnduDltskwQcIMpgu9usljhaDLSmjeumOKuGo
         Xf8VCMBIHQKWm+4cd77eBnEFdJCdqReuhuKF4UADUR8pg5nCepPoS3LYE4h7rwTXehRF
         jUlCj5J1reXez9DONKPn/PrMuMJ9LhVtccjG1Ktd3B39Sk2H0tFmcKtq1f5YnYhYvVeF
         +PK1yjKMcVa0zfg6SnCHMmvySTuhP69q0ICkclQbanhMruf3a2yRGj5ukeGMWYxEH7z7
         IsABYSzPolqMCUMSYaAZGJkW0lUbr2CwQRkcT1UUaXad6q/u5lYlqH4wvvTg1rF45bgN
         imyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453036; x=1702057836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPiKsCCgA2C4rEsExgFz/FQnyM6xy20WmctuQWGyukM=;
        b=PCwh9Gbrw80KCyqKjtyt0w8/TKkZjM3zN0mdIVKJTCPhw+A4zFGRL304d32uFFcnzs
         IXFeYndy5j++JL+CxG0GK6JRRGVSQJldCqumq1x6ySeKbulZms1udDkiIc8GHX1k5HJ+
         vcOJSBOMLgla0WTkhJM5yN8+FIUCF2SQmUlmMt7kXBLrOi6CqadSUJYyb87UfXXGcGAZ
         OyTx0ULtfWoclk7ml60+RshD9SgCed4KvH+KIxdVDPpm5G8SV5VjKbIJ74tM41oknWg0
         ExLg6MlJUiXrsR2puLQniuN5RtGb6gwqTWpHXRxqLm+8TzCp0a8RH58aA3tF7bpp/Uv7
         iilA==
X-Gm-Message-State: AOJu0YwLNPpOodtckWzWeTAz9f/QepDO06TJsrCLABSqgdhqX5zWclh8
	JsftG48BO5G632f9cMtF9OPjfTEgIaBXjdwewQQ=
X-Google-Smtp-Source: AGHT+IF+gV41Y1G+V1C0T7kMSJnGIip8P9qm/tIHzKz42jzMWffVWpIePQzMAC5nBRIg4AiLkjlcWQ==
X-Received: by 2002:a17:903:184:b0:1cf:bd98:633f with SMTP id z4-20020a170903018400b001cfbd98633fmr28782615plg.30.1701453036024;
        Fri, 01 Dec 2023 09:50:36 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm3619729plo.278.2023.12.01.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:50:35 -0800 (PST)
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
Subject: [PATCH net-next v2 1/4] net/sched: act_api: use tcf_act_for_each_action
Date: Fri,  1 Dec 2023 14:50:12 -0300
Message-Id: <20231201175015.214214-2-pctammela@mojatatu.com>
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

Use the auxiliary macro tcf_act_for_each_action in all the
functions that expect a contiguous action array

Suggested-by: Marcelo Ricardo Leitner <mleitner@redhat.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..05aae374c159 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1118,8 +1118,7 @@ int tcf_action_destroy(struct tc_action *actions[], int bind)
 	struct tc_action *a;
 	int ret = 0, i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
-		a = actions[i];
+	tcf_act_for_each_action(i, a, actions) {
 		actions[i] = NULL;
 		ops = a->ops;
 		ret = __tcf_idr_release(a, bind, true);
@@ -1211,8 +1210,7 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
 	int err = -EINVAL, i;
 	struct nlattr *nest;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
-		a = actions[i];
+	tcf_act_for_each_action(i, a, actions) {
 		nest = nla_nest_start_noflag(skb, i + 1);
 		if (nest == NULL)
 			goto nla_put_failure;
@@ -1753,10 +1751,10 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 static int tcf_action_delete(struct net *net, struct tc_action *actions[])
 {
+	struct tc_action *a;
 	int i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
-		struct tc_action *a = actions[i];
+	tcf_act_for_each_action(i, a, actions) {
 		const struct tc_action_ops *ops = a->ops;
 		/* Actions can be deleted concurrently so we must save their
 		 * type and id to search again after reference is released.
@@ -1768,7 +1766,7 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
 		if (tcf_action_put(a)) {
 			/* last reference, action was deleted concurrently */
 			module_put(ops->owner);
-		} else  {
+		} else {
 			int ret;
 
 			/* now do the delete */
-- 
2.40.1


