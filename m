Return-Path: <netdev+bounces-55416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16EA80AD03
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF11281B0B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CFD4CB5E;
	Fri,  8 Dec 2023 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ixYdb4q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0F1706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so1927000b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063761; x=1702668561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za2V75/z2cG6z3Uv2O/AbEjyUwvGaFrmvQ0ExBrI0mg=;
        b=ixYdb4q+nIZ3i0oGRkoIDA4cny3MV2awWkP95hJQdUZyWWnXlNfZzui8DrFQX9nf6g
         Ol2U8yFZFR/B5GgNFD50+muMt2eN0vrufOZgwGdSELFLBnNUweRYqUJO8MlBDhqtIw37
         jmvNehwROqgncbFnG2chB64HkNDuVQ3OVVOf5ndLuibvmnsVa5b8ulKFbprDnC1EQqKr
         k/tIayOpqanjw9dL1Px1S43duNsLKIy7tGHrsWd8wkZFTulP9DsvTJ4h+zEfQ9LX08bV
         8IMG9E4MjyX9Ueo5S0fwcbInsTQIZ8Kf/G1PYLLN3EHCRMWTi0cQCdbdftdah1HRqjE0
         aTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063761; x=1702668561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za2V75/z2cG6z3Uv2O/AbEjyUwvGaFrmvQ0ExBrI0mg=;
        b=T8n5ta4wWO7gSMQSOxmvjF9qFE3hFK7Cv4kmPR9mvJKWv0Vlnf5wh7ldowwdA4O9sR
         hN/exP3OGI7CUUbq7vMQ7XqY18DOsJDslUz+va6CoxYt34vsmIX+P1ti04d7hCRj6mxJ
         jiRCyY2rHPeIMEdvV5hjWjf8BEuvtq/51tfm/E32EJ9XulP6uwWQPuMUiL1xcK2xQUx5
         MKjaeUTzb/62JtWtXjGzJBPYuOyG5g6GpRuQIVYx3KVRwMrCKrM76QiC/vtH2mCuVFcr
         vVIyGlwJf+oy5gQB0jq9wK8vfPhIJ9RbC/ak/Srsh1Pc9iu4oMuwmarcy6CgbbQ5kRl8
         nVxA==
X-Gm-Message-State: AOJu0YxqzHL8S1BaO4P/TxNFlULPgFrlYFl3aS8+Y/8tgnQowjwVt5eA
	e5hFsjFu56Av6qIbYNy3Uo/2VUo3WOlA7EmWouc=
X-Google-Smtp-Source: AGHT+IGW8RL5rUSEeSV/aV28GmrFPXWY1HVxNE4PYTHpELvnTHG+PDWl1i9OlhFLbxjKCVCWCAiX/A==
X-Received: by 2002:a05:6a00:27a0:b0:6ce:3f6b:638a with SMTP id bd32-20020a056a0027a000b006ce3f6b638amr494247pfb.48.1702063760989;
        Fri, 08 Dec 2023 11:29:20 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:20 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v4 4/7] net/sched: act_api: don't open code max()
Date: Fri,  8 Dec 2023 16:28:44 -0300
Message-Id: <20231208192847.714940-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208192847.714940-1-pctammela@mojatatu.com>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use max() in a couple of places that are open coding it with the
ternary operator.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index abec5c45b5a4..4f295ae4e152 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1796,8 +1796,7 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
 	struct sk_buff *skb;
 	int ret;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -1882,8 +1881,7 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 	int ret;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -1961,8 +1959,7 @@ tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
-			GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-- 
2.40.1


