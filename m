Return-Path: <netdev+bounces-74394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF6861282
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C91C22FF4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753377F49B;
	Fri, 23 Feb 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="h2bot8A9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16517F476
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694267; cv=none; b=r5ucWESLUklCYuql3H6BBxFWUkU4RkbQ4WbS1MBvyL7UkDAZSuJao3RCYDVlXZmb8fbxbNlzUexN+YCf7bk6Nwk4GAgyAlfOq0ibgdPo+3go2boPJEvOfMnAp0mGJUMWoRBaXDuNSixCNytYDTsdC88lj6edyKNYUD/zty+CWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694267; c=relaxed/simple;
	bh=YXSQQ0uQGokFV2UfiJU2Y96Z22+5kUS1rG2wL0NsELU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bq75hQCfFo9nI+nS3pPnX60n/DpV6XLHjr4dRxJgs89qzTp6+5rPYSRUGhzj+0wZotsnEPexRBMhVk9g5F8g9GWW8AkBtqcyYpyHpcJlG8ndDUK6lqlCrurRarWNpCt9mxlKWNmdXaAGesKN3dbJ8FxUjzzDhGWUPD1qP4ds63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=h2bot8A9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7838af983c1so29899785a.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694264; x=1709299064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=h2bot8A9NhMV8XHowOVt3RT3K1nBy5B1CureMlGrmKE9JQC0i5jFXktd+6psmm60P8
         FeQlZUnRCRUK5WkU6fFCSVyzr+ZphOrw5/UdZXNMN5P5Nld0VNK7tvY8YKdzldsVoGSH
         W+JmXCc3Zg865ziiALiripA0tL8IDKWGtFiXr4HCtd7w4PQUpE1E25Bhm19eubzjgC4F
         xFD4s2v9WEVNOevkaq7uKbk3nblnGgclCtdPrlFhhvT2S/qtadR5p1aqD80D5nZKmi+h
         iO4FnuxbTStmvuUZkRjt7N3TKOa/aJzYSgQaid66lECjCD/nCb3CMHfIaJyyJxgRjQ4g
         hhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694264; x=1709299064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGymPU1YTSNaMGYDgceX+N7ZQ90LxxvlYMbgFPW1GZA=;
        b=wLEc8yQrnnA/EGJUDNte3CeZG3DJ7ofQVP1wZkbo3ftS1m4fvYu7WXlBz4YznAq7CR
         2opyKAeLscK5skMR6n82ZYjpfpNmVKi3PxKDBo/IGjilFy9LKxadY145F5gqiKlFektP
         OpEiYcr3xlymWqKqGYpzxC4Dmh5RA+FVIktAPMcjF+hfgITlcc71vGTwN/MkiFqWMaio
         uzImNMXHAYWqqku82pi7Qj6Q1AxecksJCcMYtuGFT0IJFVGIfX5T0dCukmxJiTUGssE4
         rqYt0Sxf1rpZIohajOTMb0Y0B3HVrJKU2pN/mRqPQwaBcFlLIqHRnV8GQmZbqMcMRzbe
         ioDA==
X-Gm-Message-State: AOJu0YzVUtEijWLjW9xtQdqGCXplQ7Fctjnc3s7/0vaj0JMbB7W13rvX
	RnYbG5wPHZTnQZTe6LH3pYVZccedGBD9S93O+9+a900ogZl4ROExeJ4JlORae2G9XUvlO8G1GJs
	=
X-Google-Smtp-Source: AGHT+IE3mheVfugS1y89UaawYfATltZItVLyh0DP4+H4+xt0zPasHl0WfRp7fhmyF+KJeC2VJcqdfQ==
X-Received: by 2002:a05:620a:2881:b0:787:2b5a:31b0 with SMTP id j1-20020a05620a288100b007872b5a31b0mr1961353qkp.71.1708694264419;
        Fri, 23 Feb 2024 05:17:44 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:44 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 4/5] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Fri, 23 Feb 2024 08:17:27 -0500
Message-Id: <20240223131728.116717-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
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

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 69be5ed83..49f471c58 100644
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
index 3d1fb8da1..835ead746 100644
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


