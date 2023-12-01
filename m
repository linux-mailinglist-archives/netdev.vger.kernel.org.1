Return-Path: <netdev+bounces-53023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02291801213
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB81C1C20F52
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4604E635;
	Fri,  1 Dec 2023 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="j2s96Z+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129BFE
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:50:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d06d4d685aso317705ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701453045; x=1702057845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8UbiZzVKTY2CyZBpGCSMO183vb/TeddNACUB/GPxAk=;
        b=j2s96Z+pMmSGtYPrVeXPg9X6BlEgfhZLoxjA0XEtMMbVbbN6PkKM6Xb44XvxZrh5tG
         12F3KGySh2peVHg3IVHSIyoaJrwNz7z3ba8r5R1RJHQ9+tCUAZ80m5tZAmn5oO2LaEFr
         FBFOIG3Xmh5wILAt1b/XZOwamMeY1JbGhGxkcLT6JIKTj9efMVS/wTYIUQ9VUuqkneH8
         Fjv0ZTku/L8xIHHjv1ZigKBbkTTm0VtLhTp/9Jxk60EiBPWpdMam5U0fnxTkJq0rxDhr
         2SV3QwlPFlJM6vLm3AIkfRhi6fDg0qJ0N4cRQuCfAi+stonuwBjFeMzC8UhPbFo7HE9j
         C8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453045; x=1702057845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8UbiZzVKTY2CyZBpGCSMO183vb/TeddNACUB/GPxAk=;
        b=LITR6Rh/jRTK/nuOgyK/yAXeNTxOZCyHzrUlX+u1Ztz9LdGOuaZhXH4oIdz7dpwYfL
         pxe4PcpYGoA6rd8N6Ma2ZrWORbPVZ8D+fodmIO2HceF9gOB4oiaIiIoQI99O/ZSeI4Aj
         WovoM/e+BlxfZQB+jTrgpdASIrcAwWZiyR5YhmTJtENvDgoidZs+jmRCRQtyDNlk0JR6
         iSmFGW5JXEab4q74JcvIq1SBqUgC9f0uE3OOtT/YOgFBbdiel4wuwlywuuqs6sgfkRYw
         qG50PngwZ00bhuOVxZk8CwZv2EBks+R3bisCe0qSz3fOPZLpUg/JbCarzec6fkx16ciZ
         3o1Q==
X-Gm-Message-State: AOJu0YxYFZt5Vt5CnZS20dYXp6JRClyvQ1rr/MmLZF6dTnnORMnihmA2
	dGm6T60KheKW3+T4X6L9NRaXLXZNNSl2+o0A8i8=
X-Google-Smtp-Source: AGHT+IFwr71re8/A+xmXcVnBVZ41QVq+Lvn+k9uQ7Gz2mxpaju+WnLa3Ok1u4ZXIbgnQdaitJ48OTA==
X-Received: by 2002:a17:902:c408:b0:1cf:7c3d:df68 with SMTP id k8-20020a170902c40800b001cf7c3ddf68mr28263310plk.39.1701453045476;
        Fri, 01 Dec 2023 09:50:45 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm3619729plo.278.2023.12.01.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:50:45 -0800 (PST)
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
Subject: [PATCH net-next v2 4/4] net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many
Date: Fri,  1 Dec 2023 14:50:15 -0300
Message-Id: <20231201175015.214214-5-pctammela@mojatatu.com>
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

The actions array is contiguous, so stop processing whenever a NULL
is found. This is already the assumption for tcf_action_destroy[1],
which is called from tcf_actions_init.

[1] https://elixir.bootlin.com/linux/v6.7-rc3/source/net/sched/act_api.c#L1115

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index d3cb9f5b25da..abec5c45b5a4 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1285,14 +1285,12 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 
 void tcf_idr_insert_many(struct tc_action *actions[])
 {
+	struct tc_action *a;
 	int i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		struct tc_action *a = actions[i];
+	tcf_act_for_each_action(i, a, actions) {
 		struct tcf_idrinfo *idrinfo;
 
-		if (!a)
-			continue;
 		idrinfo = a->idrinfo;
 		mutex_lock(&idrinfo->lock);
 		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
-- 
2.40.1


