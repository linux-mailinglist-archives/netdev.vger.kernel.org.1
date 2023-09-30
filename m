Return-Path: <netdev+bounces-37167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5F7B40F2
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1B4831C20AE5
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A79156E0;
	Sat, 30 Sep 2023 14:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55A154A8
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:01 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C91B1
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:59 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b0ffbf36aso58075136d6.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084558; x=1696689358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa81GC9k0AI9sEfvz3FntxQuMWykLk7Dj6ZXfUStsjk=;
        b=j8leKphBw+QQbDgqG8wG5zO/vk9JyTF9vzj1xAypIbnJXmFceAppB9wolLqh7Qv19g
         uYyOinXiFS2ld6XBIX1xem2H6bpNEh6uApVLesocB97ZwLUWK2viP2hRrnoMUgRHgD63
         iE1H1T1dgpPK6uq5kVM3HQp4wpxO8KKxTg2svEXdpHJ/aWDwLedd+vPTdr5QpOa7NwGm
         7CbrMqREriz8FEvAu6DILqSpz2z+w5CBNJInjfBvrmIwkjAtcXMtGkDsbru8eiKwpwsT
         6UkuvE15kzMJRxX5DklHy0uf8kClFteOprwK5AfY/R127KAONnHAUHZ3zJ9JdGbc36hz
         IADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084558; x=1696689358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa81GC9k0AI9sEfvz3FntxQuMWykLk7Dj6ZXfUStsjk=;
        b=Dz+F1B7zt5HwKxuh7JBrPbvteHz2Sf5EXGP0rKr7izoHclQjJRimcar/BOrqzM67MP
         /YM0a781kOPawLyoPwA2JzYSceoqTeYvPVxXJBau5KPju1SffLf9h5+0MGXGllpjfLrb
         bIDUcFzQ2sHIQa7lPB130WObBhEKLAhUovRtiuDrABi9zu4v1u0xyEFFdgX3xFZdv3u/
         y+YsVTnUDH0oEVJpjq6FYXGakcHRk3ukb6o8xmbJkBCD8ZPMNjVzz2vdD9NjkmhFkIM+
         CVaTQ5fyRQOsq6b7CAwYHOLbxCC8IQhQankgA9tu7PYrwrMANmOHGc2+JaGP/FrStKpQ
         palw==
X-Gm-Message-State: AOJu0YzYreNadF0y6gGMIbH6cyq+HY+3+VCb1szIvGI44mrI5SCqi2Dz
	/Gy3u0kMr6OF67xLcRYTY+Wj4WB9xuXgf/r3wfs=
X-Google-Smtp-Source: AGHT+IFOJ/1UT/sUA/iLb0YVN1CdNWeEZmS5K80ffjfQOBZEgiQtPghJV0EfiVtFTSDSIXZTxoAUxA==
X-Received: by 2002:a0c:8c0b:0:b0:656:55b0:6f55 with SMTP id n11-20020a0c8c0b000000b0065655b06f55mr5902199qvb.6.1696084557777;
        Sat, 30 Sep 2023 07:35:57 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:35:57 -0700 (PDT)
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
Subject: [PATCH RFC v6 net-next 04/17] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Sat, 30 Sep 2023 10:35:29 -0400
Message-Id: <20230930143542.101000-5-jhs@mojatatu.com>
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

For P4TC dynamic actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the dynamic action
information for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 1fdf502a5..90e215f10 100644
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
index f0ec70b42..cfa74f521 100644
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


