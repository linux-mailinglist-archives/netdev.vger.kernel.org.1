Return-Path: <netdev+bounces-84832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84789874C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DE1F29390
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E8128811;
	Thu,  4 Apr 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JKszwRdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51141272A3
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233429; cv=none; b=AyG/ugPsTJ37JeZCAt2ijDGgfLeYSU80PddgmxZ9z+Um9lL/YO3htLvqwuwq0S/Yy7d+UJuKOBEV5FX+t9/FeZUZ/pbDCw8x9J7Gp+q7thRGQmFNNPs4pDb506RrcMYVtqs7ymP7cYIS44VAjECi1LV9RBdu4/9iMrQiadkPZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233429; c=relaxed/simple;
	bh=0Rqjx80lQrZE7wZ+6UaTpRU7AKiDD72DIxmJmCIh9E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMX9xzJ5bRawSr7xKNQeBfHd34W9+xT4bg7Txq/G6/osjbA7hhiIEsUciX/Kkmq+wMpDlHZBdF2JvdapCKtwpFoy0W/UoA7viHSkpxt76up/a1tmkuzM+IMU4BBQ8tYeX14bgjAlhHPVgA8yHMVvDcJfYOwJk3MY8FYzk5hiE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JKszwRdr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42f4b66dc9eso4124841cf.2
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712233426; x=1712838226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWvw+VNSEb8FXhGNcVsqL23nMeH8Qk2hFaJebNGTIg0=;
        b=JKszwRdrTryoNgXU7XrmKNwUET5CsYpPslYzNuLfVz2/jADIfsLMyIMr/O+pZ1Av/y
         skqs+llSMYx1Oimi7RHrtb0ricGt5Miy5CTeAuvUmNUp4XaiDkZ0bcWrZ8f1DoYPupJC
         E8l4SXkb+zGOClvsE+HE8T3YA74DHqPsJGXEqpYogPWJ4tHrICZ0RaaN4Ogs6hU5SxfW
         CO+F9KGQJQLO+3Ff/OaLa23fFP3plR8laVRxeuzfFy+RglEAC8T2TdTIWdbcp77zjAsT
         hLh2x/gp0CFFNLu1yvh0ve+O6xd/gdZ0yfpwL6M+HtkxVMuBrDXEzjapCQpM/F+Ws/y/
         c/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233426; x=1712838226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWvw+VNSEb8FXhGNcVsqL23nMeH8Qk2hFaJebNGTIg0=;
        b=JsKABcQ4A+UB5HbIBZilpEMfmndajFwRnsP1nuWqWDdaB/72Y4VzpBURzAeCelGN92
         pt6ylODsu/TaixZApoOYU8OHyVRqK3nwbxnf1D0d3z1Px1zWNoqpiH7ES3PkgaKedm5c
         mhjOJqHD7WhnqGIZKVnVf40NEQFqUFPYg3bCSoHNSeLFyIrudw8x/wxBOt/SJnovBqQQ
         84Od/vrv3seIXAk/8jgJrV57U7bE9XuXKhEsF40p7qwjg2PkU95x+8ar7IxoKZ/89Hn1
         gC66jGzOZMhyWaJFxJVHVcnGsw6CqsG9BTkB3B1c4HyyuxHhRJLebgTJn6HE5wfR/LhF
         0RgQ==
X-Gm-Message-State: AOJu0YwhEV5uiuLfaD0WyIRf1RWBa1ZlAZ2hgyS0cE6kZ51/+i0fFRy0
	Ce/ecxfG0ZQ76L98wueaknt09CLO1oww3SeUipvdj93r4+sgF6cflbJZH0Em/F/G00uY7B7duRU
	=
X-Google-Smtp-Source: AGHT+IEtfpTUyvydbI0YakyljlEBummeUgT7B4FQTuG6YSYFwvBfwXXOSlfVxoHwcpVqZqJEzg73oA==
X-Received: by 2002:a05:622a:13c8:b0:434:40e4:2fd1 with SMTP id p8-20020a05622a13c800b0043440e42fd1mr2307994qtk.56.1712233426332;
        Thu, 04 Apr 2024 05:23:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id bb19-20020a05622a1b1300b00434508cfb62sm584945qtb.79.2024.04.04.05.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:23:45 -0700 (PDT)
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
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v14  03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Thu,  4 Apr 2024 08:23:26 -0400
Message-Id: <20240404122338.372945-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404122338.372945-1-jhs@mojatatu.com>
References: <20240404122338.372945-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the P4 action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are P4 and are net namespace specific and
not global like standard tc actions.
The init callback from tc_action_ops parameters had no way of
supplying us that information. To solve this issue, we decided to create a
new tc_action_ops callback (init_ops), that provies us with the
tc_action_ops  struct which then provides us with the pipeline and action
name. In addition we add a new refcount to struct tc_action_ops called
dyn_ref, which accounts for how many action instances we have of a specific
action.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c839ff57c1..59f62c2a6e 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -120,6 +120,12 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp,
+			   const struct tc_action_ops *ops, u32 flags,
+			   struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 87eb09121c..c094a57ab7 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1044,7 +1044,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1517,8 +1517,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			}
 		}
 
-		err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
-				userflags.value | flags, extack);
+		/* When we arrive here we guarantee that a_o->init or
+		 * a_o->init_ops exist.
+		 */
+		if (a_o->init)
+			err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
+					userflags.value | flags, extack);
+		else
+			err = a_o->init_ops(net, tb[TCA_ACT_OPTIONS], est, &a,
+					    tp, a_o, userflags.value | flags,
+					    extack);
 	} else {
 		err = a_o->init(net, nla, est, &a, tp, userflags.value | flags,
 				extack);
-- 
2.34.1


