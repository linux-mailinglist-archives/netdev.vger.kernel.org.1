Return-Path: <netdev+bounces-52563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2707FF373
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C301C21013
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD3524B4;
	Thu, 30 Nov 2023 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VUvOuehO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76D19BC
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:27 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdd584591eso1048366b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701357687; x=1701962487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW07eus+osHtKsR/VuZells8epXacZLWW+VuGK4+DyY=;
        b=VUvOuehO6PjaXuh7j7uny7iuU/zkQaAb3S1dzjwXpRPPJbVOhdVkCCLzhQaJ/gvHEX
         ZRaNQMIMhw/dJJ2A5ECySKqzbJwPmCpHYQUhpoHw0huVQ/7sCS4JICHY2vclLpzl38My
         TtE/auoH7ukEFcpla3h1D3OXXsyb88DpxO5yJ45QyPSf5Ky6w/ps8+nzo6h9BX93E37N
         V8N4F3Yj5dX3pDoPRDYIVxwZVO1cy1D5mU/s51IJHi8R5EeLg5Sllaex40GFutLK/apy
         Ne73o1eQVHVvuLKf5BIyk8mTm3NicmmRY4yrRXAYD9ClFT07EUkNxwqSw28ceXaOpPh0
         do0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357687; x=1701962487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QW07eus+osHtKsR/VuZells8epXacZLWW+VuGK4+DyY=;
        b=Nt3043pEn9sduESsBRBamT+EyH/SP+95VB/AkUPkohlK35KPXKs0ATmCziRVBBBJnZ
         xQlIw4GUpY6Z4MFthnHaN//PmM3ew0eEB6gcnI2xmlaXKzcoOjGTl6PT+jxWHve5pkRH
         ENnOhz5q0qxXz3cDxyZg9HF+a9sunXA8GbJSojzaSlXd/0xD/7hcCTonSOofdxG2sQ7V
         5UmDb37xvhY+ObSID2PZn/5lrO5X1XQ5qT/+O+6LokKzu9S2dnjVUMa0YWUkDiS1MgAj
         rqpXoNSnOJzVq9c3RlaN4kUA7SJ70ZQJBeaSPhEkeOMvahYvK9mw0ys2vS+4wQpjsEcm
         VsqA==
X-Gm-Message-State: AOJu0YxGC5ZS1jeWFF11Oew6gSIKn27XGFWHOXHGM+MeSqtMcfbtsY2L
	qP6lgLKkeTfwHnUggZSDTUiwWM6QIJmL26AWilM=
X-Google-Smtp-Source: AGHT+IHWAPPXZZv1PbTRcK1bORhdOMA4P5xyo6Ksluj2zyzUu23ioLCbOS/uSdj69cwjlu04WX2WcA==
X-Received: by 2002:aa7:981d:0:b0:6cd:f399:be00 with SMTP id e29-20020aa7981d000000b006cdf399be00mr940156pfl.28.1701357687048;
        Thu, 30 Nov 2023 07:21:27 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm1342579pfn.61.2023.11.30.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:26 -0800 (PST)
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
Subject: [PATCH net-next 1/4] net/sched: act_api: use tcf_act_for_each_action
Date: Thu, 30 Nov 2023 12:20:38 -0300
Message-Id: <20231130152041.13513-2-pctammela@mojatatu.com>
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

Use the auxiliary macro tcf_act_for_each_action in all the
functions that expect a contiguous action array

Suggested-by: Marcelo Ricardo Leitner <mleitner@redhat.com>
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


