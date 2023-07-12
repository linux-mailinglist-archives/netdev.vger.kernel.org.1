Return-Path: <netdev+bounces-17201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102FA750CCF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402211C20E34
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B024183;
	Wed, 12 Jul 2023 15:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381934CFE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:11 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35AB1989
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:06 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6348a8045a2so46567416d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176405; x=1691768405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLJTf91kf9mBMFKTG4CoNQ02ft7+5tLeK9pmMvMG+Lc=;
        b=Bv1BtZ5r2wC/z9+PCKJrhN06fztqLKGyFVVWjyTFpiXss3SLqeznq/UFOEGC+U91+K
         rNgbC02tm5O6BLYToIGQS0ye/vn70rTJpO99m6UFd8vZMR4mP+NeuTQdENSyNkguMVXM
         66Br06ChJAvJuD+mW/70yrAP5o9ryTNmhP5rJnDaQTHbJABxhAID+tis7U+CT79uOslZ
         Xke2bEPqzP+Vhg07blM9t55L6XBE2dD6y+GHKCOSSeOiEpzTucI0Su8F54njLScwjKpO
         T4Pm1hpgXL4TxNcr3pM9FT+CWWT91AeZqbf9h2rFxbcXvzlbUe33Yqg0RH+AMyERr7EE
         xssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176405; x=1691768405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLJTf91kf9mBMFKTG4CoNQ02ft7+5tLeK9pmMvMG+Lc=;
        b=HubRbeOEW1eqkWKU/d+vg1EexKk2b7mBylckA9uFLHyZJqxySOaAMoZ32L20O+S4HD
         pV+SoRNgcpyW9drnV2aCNTmgvirTGEbt1aDesaJi9/EeUSOMsoNqPV+mZKZzGpvxnrCO
         CsaHkVBDNpe0rpsfvSV0NCc4aFNZJj4ra641fTkBDIAKT1QGWILxjdaqi7G+TmS69CJN
         CctRhlzuZ+gOQ1pKGyWnM84lv+/jst3yovyy4oOkaEcJXnVi3LExjzql+lotFX+EsMzE
         mkZKH6Q+9bJOHtfmAy8o0x93eQ2BcETPGYMYKNXBG23aMgFdNALcIDAHRmXMgC34FIb0
         dRkQ==
X-Gm-Message-State: ABy/qLaFrkzUzbklE0HTXehNadqK2W6p61nMDCGgeVtIX5DqPkhZ7xN7
	F5nxu5ajO+7Muf9AHguSN6dTAu6S0lTLApAbQAsvdA==
X-Google-Smtp-Source: APBJJlEY4t3Es59RPnLilCdQFeCviDaVZwl3k/WlTYK3FrKxylhhY/gNzumBSQSnMBPib9nKHtcdfw==
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id d13-20020a0ce44d000000b0062def66ff1cmr16225484qvm.24.1689176405483;
        Wed, 12 Jul 2023 08:40:05 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:04 -0700 (PDT)
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
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 04/22] net/sched: act_api: export generic tc action searcher
Date: Wed, 12 Jul 2023 11:39:31 -0400
Message-Id: <20230712153949.6894-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In P4TC we need to query the tc actions directly in a net namespace.
Therefore export __tcf_idr_search().

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h | 2 ++
 net/sched/act_api.c   | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 363f7f8b5..c2236274a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -190,6 +190,8 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 		       const struct tc_action_ops *ops,
 		       struct netlink_ext_ack *extack);
 int tcf_idr_search(struct tc_action_net *tn, struct tc_action **a, u32 index);
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index);
 int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
 		   int bind, bool cpustats, u32 flags);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 6749f8d94..19d948fd0 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -722,9 +722,8 @@ static int __tcf_generic_walker(struct net *net, struct sk_buff *skb,
 	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
 }
 
-static int __tcf_idr_search(struct net *net,
-			    const struct tc_action_ops *ops,
-			    struct tc_action **a, u32 index)
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index)
 {
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
@@ -733,6 +732,7 @@ static int __tcf_idr_search(struct net *net,
 
 	return tcf_idr_search(tn, a, index);
 }
+EXPORT_SYMBOL(__tcf_idr_search);
 
 static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 {
-- 
2.34.1


