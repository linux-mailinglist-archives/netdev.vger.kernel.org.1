Return-Path: <netdev+bounces-37165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC227B40F1
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 07BA6282307
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7014A8E;
	Sat, 30 Sep 2023 14:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464809440
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:35:58 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B88E6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:56 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77410032cedso967418485a.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084555; x=1696689355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlohhxqwOgjpck3zgc2Dw7jr17jzv6pdd+Gm7uXJ9oM=;
        b=JGJ5rtfij0Cog5Q2lXUKfvjJCT73wA94nMM2++LpRwRUtyZd6DUxqJcltKjiyO7XZD
         rKL30J1jkyxSUKLtjWsvVfSl1uGRBRCpsYWNtKLIgWLRTsTi/pYjtpMYz5leMhenjqiY
         g1auiVKffO7sZXq7rGN/4d+AYSNovGZrIyn45UuBAd8y6C062f6rAMUtIFg+gg7Zc0dM
         eByonxjPSIbPodpEtjm5opmoCNPzm6bWvX9wIp9wuBmlt+SAqnTuAnnIu04Yw720vCFK
         ps11p36Ap3nviG/hlTpFWc71FwG96CfADzudkr/oqz3rOxz11mMh56bdSV9Hm/nc2wsh
         56pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084555; x=1696689355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlohhxqwOgjpck3zgc2Dw7jr17jzv6pdd+Gm7uXJ9oM=;
        b=iSU45HKNaElMM42MroNbV7k8UC4Wc2a4dZuc4vYoleYehKFxRoYIiqM/7VQFYl1bJa
         sF1ABdajWdne9ALRkEVWj3oJVIQXSyVPPL0SZsZDtg34fBSYwopFqFNoyAYq+b165yWi
         8lutH0MrebAFdD7xdp3301pgQ2of4CYRiSx4EmvZLvfcT22rt5JF4u5TsBV3Of5G6oUi
         pTV2K/dsnEV9UW8AsO8lDAch0+HVXQCm4+ihqyGw3neJ0dpW5vDiVIVefetpJ6V8YcIK
         mp+OUFqgbgr/yRTJM/5BLO2YUdtVL2NIOCRbRplLhKXDujB6rSCpHXm3TA5jetjXgrFN
         Bpzw==
X-Gm-Message-State: AOJu0YxofcfG0EY9CJG+TUdEsbj5PiSJL/VN3JqtdaYfqKpVkEgUJGu5
	T6GAo2q9Yuiunu0Xbbx5MY8nmK2BfxjnuoMEZV4=
X-Google-Smtp-Source: AGHT+IFzndRZVEBmZ12lwp95K5CTFlvkXETFP5y5cCikhi48RGORJVtP2XaALOfi6Ok+ybenqntXAw==
X-Received: by 2002:a05:620a:2adf:b0:774:19b6:892f with SMTP id bn31-20020a05620a2adf00b0077419b6892fmr7469002qkb.39.1696084555085;
        Sat, 30 Sep 2023 07:35:55 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:35:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
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
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 02/17] net/sched: act_api: increase action kind string length
Date: Sat, 30 Sep 2023 10:35:27 -0400
Message-Id: <20230930143542.101000-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Increase action kind string length from IFNAMSIZ to 64

The new P4TC dynamic actions, created via templates, will have longer names
of format: "pipeline_name/act_name". IFNAMSIZ is currently 16 and is most
of the times undersized for the above format.
So, to conform to this new format, we increase the maximum name length
to account for this extra string (pipeline name) and the '/' character.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h        | 2 +-
 include/uapi/linux/pkt_cls.h | 1 +
 net/sched/act_api.c          | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 3d40adef1..b38a7029a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -106,7 +106,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 struct tc_action_ops {
 	struct list_head head;
 	struct list_head dyn_head;
-	char    kind[IFNAMSIZ];
+	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
 	size_t	size;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index c7082cc60..75bf73742 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -6,6 +6,7 @@
 #include <linux/pkt_sched.h>
 
 #define TC_COOKIE_MAX_SIZE 16
+#define ACTNAMSIZ 64
 
 /* Action attributes */
 enum {
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3f3837c12..70c9eba62 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -476,7 +476,7 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 	rcu_read_unlock();
 
 	return  nla_total_size(0) /* action number nested */
-		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
+		+ nla_total_size(ACTNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
@@ -1393,7 +1393,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
-	char act_name[IFNAMSIZ];
+	char act_name[ACTNAMSIZ];
 	struct nlattr *kind;
 	int err;
 
@@ -1408,7 +1408,7 @@ struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
 			return ERR_PTR(err);
 		}
-		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
+		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
 			NL_SET_ERR_MSG(extack, "TC action name too long");
 			return ERR_PTR(err);
 		}
-- 
2.34.1


