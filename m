Return-Path: <netdev+bounces-53053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B620F8012A7
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319D1B21413
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290C51C36;
	Fri,  1 Dec 2023 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sIsZcRA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CFC1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:29:13 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58de42d0ff7so1319395eaf.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455352; x=1702060152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QxvUzYS1W8RYq6mM2bceYbwgM8SdKWnwgWEo++oLE=;
        b=sIsZcRA+fOkg14GK2PlkHx8+ztoJDFAFjPe/+KPW+oJ1aNTrjWfPt0ISlg7K0mb4ZA
         Olhlc99HZjbQ1Kr/vCNzS9EUUAa/qgI24jHl+qG2sO2OYmznBu7JQ434+F27XuMI+UnN
         D1HJBFwS5LfIDE/ZCXZQRGGcFqqHCsrZ4Tg942LN4VQo/svLpAd90pVuH/1DokSRIRR9
         0z+2+Waqlio17xv1iCPE/RSrFexc0vamTi+wPq1JzBeOpKxgu57TnDEVWrH/Y++z68D5
         6eL5FzfqpI3Cojc5W+uR1YoWRknOgc7kh6vDrqxtO340k3O5kLHg62g6lQNwHWcp0TkD
         R52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455352; x=1702060152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QxvUzYS1W8RYq6mM2bceYbwgM8SdKWnwgWEo++oLE=;
        b=rUG7HtgsHy1MxKUZLQQFy4LLz9Y3fu9ogr3jfpgheBham8TRn3mbdNYqNxl86zxjLk
         /dJEjofbKF87gV9D5ou488qju4cHdGeAMfGxUfgfmo3hLLgZW8/O3v5w+u6PHhN8JLGp
         7x3tiBFlk51nheWtCdeoV5xqukM55fsciTDY6jDfdk+4Fg6jzs9cHuiyWr0gh0j0sa8V
         MlPIxzgSjWxyolGhNNoyhX75VNHbu6nAJJfLxFMv+83VAILx7pJRhDQsAr3MT782YtnG
         rWp+97tjxkKshPJ/WnoHWlgUEKZqPx7u+M7UO+kqgWhOAtHYuwwcTaIMzc1tHcU21rjf
         Hl3w==
X-Gm-Message-State: AOJu0YyoKQHZ9dvTKls5qmkCXru0iSXF4u2RsY2hpZ/+DjNu+fDW6rqG
	HqbAHcf8AR5DA56hQmldbuqy2kZpTFFq3qgb/sQ=
X-Google-Smtp-Source: AGHT+IGg5LOeHL7X7aynu+Wi3/58B0QLIG/KMb/snNl3J9F6+yAQa9qW+6MnCuabOPOktO255SARSQ==
X-Received: by 2002:a05:6358:33a6:b0:16d:e151:a7d8 with SMTP id i38-20020a05635833a600b0016de151a7d8mr29676214rwd.14.1701455352433;
        Fri, 01 Dec 2023 10:29:12 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:11 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Fri,  1 Dec 2023 13:28:53 -0500
Message-Id: <20231201182904.532825-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index baba63d02..c59bc8053 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -116,7 +116,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 5ab1c75ce..ddef91233 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


