Return-Path: <netdev+bounces-201049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A7AE7EAD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EB17B2D75
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871832882CE;
	Wed, 25 Jun 2025 10:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DB29C352;
	Wed, 25 Jun 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846083; cv=none; b=Nzpfi+ALTcONxqJZnS3StGUNB7keeQ8tBzge6UeTGZjoMrIKiQL7+GOKrIzgd5BqP49KejxSmKQYPyNTWuJR2q3W4A0wLyGjpgr/0pDam37+mQrQ3TEPF+GnHAzTlHHAKh2JjjDJ0TqXWmFbEAVJGIEwGMzmbI4hLse+wBSuCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846083; c=relaxed/simple;
	bh=kMxe1IHoqXviFECo0NKuCfqjgpHzYP3h12Li81qEz7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gORBeIZEwfIASO15eGqd1GGg8rJztDSuujmqDZB9c92h9SyhoELzKqtvQFH1mJq4AmrHq8Im1Q3iJBQ3JoQpALdIgcUu7Nhy53Nlj2uLeGAlBPZGbOmymrq4gFFC9gZkBA+7SUpXLhP+VRE+ICiW773syeCRRGb4pqVs1xljta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bRyB44FdLz1d1hq;
	Wed, 25 Jun 2025 18:05:32 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B8DF180480;
	Wed, 25 Jun 2025 18:07:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 18:07:52 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] lwtunnel: Add lwtunnel_encap_type_check() helper
Date: Wed, 25 Jun 2025 18:24:13 +0800
Message-ID: <20250625102413.483743-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Consolidate encap_type check to dedicated helper for code clean.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/core/lwtunnel.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index f9d76d85d04f..f9453f278715 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -79,10 +79,18 @@ EXPORT_SYMBOL_GPL(lwtunnel_state_alloc);
 static const struct lwtunnel_encap_ops __rcu *
 		lwtun_encaps[LWTUNNEL_ENCAP_MAX + 1] __read_mostly;
 
+static inline int lwtunnel_encap_type_check(unsigned int encap_type)
+{
+	if (encap_type == LWTUNNEL_ENCAP_NONE ||
+	    encap_type > LWTUNNEL_ENCAP_MAX)
+		return -EINVAL;
+	return 0;
+}
+
 int lwtunnel_encap_add_ops(const struct lwtunnel_encap_ops *ops,
 			   unsigned int num)
 {
-	if (num > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(num) < 0)
 		return -ERANGE;
 
 	return !cmpxchg((const struct lwtunnel_encap_ops **)
@@ -96,8 +104,7 @@ int lwtunnel_encap_del_ops(const struct lwtunnel_encap_ops *ops,
 {
 	int ret;
 
-	if (encap_type == LWTUNNEL_ENCAP_NONE ||
-	    encap_type > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(encap_type) < 0)
 		return -ERANGE;
 
 	ret = (cmpxchg((const struct lwtunnel_encap_ops **)
@@ -117,10 +124,10 @@ int lwtunnel_build_state(struct net *net, u16 encap_type,
 {
 	const struct lwtunnel_encap_ops *ops;
 	bool found = false;
-	int ret = -EINVAL;
+	int ret;
 
-	if (encap_type == LWTUNNEL_ENCAP_NONE ||
-	    encap_type > LWTUNNEL_ENCAP_MAX) {
+	ret = lwtunnel_encap_type_check(encap_type);
+	if (ret < 0) {
 		NL_SET_ERR_MSG_ATTR(extack, encap,
 				    "Unknown LWT encapsulation type");
 		return ret;
@@ -152,10 +159,10 @@ EXPORT_SYMBOL_GPL(lwtunnel_build_state);
 int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack)
 {
 	const struct lwtunnel_encap_ops *ops;
-	int ret = -EINVAL;
+	int ret;
 
-	if (encap_type == LWTUNNEL_ENCAP_NONE ||
-	    encap_type > LWTUNNEL_ENCAP_MAX) {
+	ret = lwtunnel_encap_type_check(encap_type);
+	if (ret < 0) {
 		NL_SET_ERR_MSG(extack, "Unknown lwt encapsulation type");
 		return ret;
 	}
@@ -236,8 +243,7 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 	if (!lwtstate)
 		return 0;
 
-	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(lwtstate->type) < 0)
 		return 0;
 
 	nest = nla_nest_start_noflag(skb, encap_attr);
@@ -275,8 +281,7 @@ int lwtunnel_get_encap_size(struct lwtunnel_state *lwtstate)
 	if (!lwtstate)
 		return 0;
 
-	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(lwtstate->type) < 0)
 		return 0;
 
 	rcu_read_lock();
@@ -303,8 +308,7 @@ int lwtunnel_cmp_encap(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	if (a->type != b->type)
 		return 1;
 
-	if (a->type == LWTUNNEL_ENCAP_NONE ||
-	    a->type > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(a->type) < 0)
 		return 0;
 
 	rcu_read_lock();
@@ -339,9 +343,7 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 	lwtstate = dst->lwtstate;
-
-	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+	if (lwtunnel_encap_type_check(lwtstate->type) < 0) {
 		ret = 0;
 		goto out;
 	}
@@ -393,9 +395,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	}
 
 	lwtstate = dst->lwtstate;
-
-	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX) {
+	if (lwtunnel_encap_type_check(lwtstate->type) < 0) {
 		ret = 0;
 		goto out;
 	}
@@ -446,9 +446,7 @@ int lwtunnel_input(struct sk_buff *skb)
 		goto drop;
 	}
 	lwtstate = dst->lwtstate;
-
-	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
-	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
+	if (lwtunnel_encap_type_check(lwtstate->type) < 0)
 		return 0;
 
 	ret = -EOPNOTSUPP;
-- 
2.34.1


