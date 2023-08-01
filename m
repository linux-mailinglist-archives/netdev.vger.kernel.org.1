Return-Path: <netdev+bounces-23162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FA76B36B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7797F1C20359
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391EA214FE;
	Tue,  1 Aug 2023 11:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C746A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:28 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B82E7A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d0d38ff97so24865066d6.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889904; x=1691494704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CApZ8mvmFQLHdcJUVcsE9K4VNDBv6pfouZIfcHkr5QI=;
        b=VvtANBmeF7uzpQssvBjDX+js2IkrjnTCE16uzcBimSdVkoo79oGeABBhjNjnZJAkto
         K9VwffrEsx8swuas0AAIG3fMumJB5O1hwg90kV7CvghvnROhcZNhK8ddaOZIhzX79dwh
         ibtQpE9KL+nj/eZgu0TJuu86oJeYE3BWzue6cOwgfuuqhPScwDaIWZ6TVvIojtU+29z8
         5Gwy1/OA3cln0LtyenwvjUsrytlUvEyx7lWrNM2bR4PkZR627XdyQJ1LDML0tnuGDOdx
         kjkgwumH4Ze3JZHiYK9rRwBZiRzkQI6gP6td1autTV+gtkw0J9lp4K2kbGiG5lhDdRpO
         mb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889904; x=1691494704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CApZ8mvmFQLHdcJUVcsE9K4VNDBv6pfouZIfcHkr5QI=;
        b=FmyWCrNd2dmO0wUbEpgCU9vu6puCG3Cxuetga1pDYtqUuxDABnF9t6kuRUoeFC6Xea
         LxRLWfIl4QW9w80qNklwytlac2o3obYh4uSN5al3IHETCN9kuOD1DyK+eo82aDAeEKOj
         TtG5osMQnKfmYSvuopQddB1dQ1CwXXwqqPr51CjtoZCFuQdMKhZx4mwClvX7IWnwGGPG
         Q7l9gYxggWgQfXs4DdMJ1ZIsjwFj2AsxgAridF2ruROlHe1ZcbBzCN3lDj2AVVqgQkyj
         hjT5++UhYDPWqjM3PBBIYfY/OTRgVHxX4QKTQNL2pidy2CvlPcpWXn8t/shjT9hTYMTl
         ej+w==
X-Gm-Message-State: ABy/qLb3G7gIhYWuhMDgGk0GSPHKEYDtl7B8CXcGPEQyWXB7OOUtM4Dr
	B7H65CAAllnf2HhUaKWz56sxBNxBARvvt91FQkS8HA==
X-Google-Smtp-Source: APBJJlGKEYyTrtjd/+PsIphkEZk3o5ZBIoBeBxfaIHv2G7gLzs+dBGsWqTN0O+37u+b3zvJTg5Mxug==
X-Received: by 2002:a0c:ab46:0:b0:630:34f:80d5 with SMTP id i6-20020a0cab46000000b00630034f80d5mr15420966qvb.15.1690889904518;
        Tue, 01 Aug 2023 04:38:24 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:23 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 04/23] net/sched: act_api: export generic tc action searcher
Date: Tue,  1 Aug 2023 07:37:48 -0400
Message-Id: <20230801113807.85473-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
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
index 1fdf502a5..395b68865 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -191,6 +191,8 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 		       const struct tc_action_ops *ops,
 		       struct netlink_ext_ack *extack);
 int tcf_idr_search(struct tc_action_net *tn, struct tc_action **a, u32 index);
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index);
 int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
 		   int bind, bool cpustats, u32 flags);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c868ec0ea..bb8a00cc1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -719,9 +719,8 @@ static int __tcf_generic_walker(struct net *net, struct sk_buff *skb,
 	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
 }
 
-static int __tcf_idr_search(struct net *net,
-			    const struct tc_action_ops *ops,
-			    struct tc_action **a, u32 index)
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index)
 {
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
@@ -730,6 +729,7 @@ static int __tcf_idr_search(struct net *net,
 
 	return tcf_idr_search(tn, a, index);
 }
+EXPORT_SYMBOL(__tcf_idr_search);
 
 static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 {
-- 
2.34.1


