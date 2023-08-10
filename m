Return-Path: <netdev+bounces-26577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52EB778430
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A76C1C20DDE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550BC182A9;
	Thu, 10 Aug 2023 23:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E711CAA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00DEC433CA;
	Thu, 10 Aug 2023 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710730;
	bh=ZKZS3xvh9ACDpcL4R1Hew6nA2b0HdtmCLhlh7l5lDFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQw+OAaMzIDqRM1REi8Pd+gS/tfrAGDUUxSJ5BHuqb6gcXcczOPYuqZy8eeW4HpT7
	 W6tUJDc/y5bh0x+oy0T3hRrWm2MCGX4h4DCD4HKn7OJYQOjEH6FFmp27Y4zOlLR6if
	 i8Vkb/ijIi9aLrBkeXz3ArwpCrut62dyeWnhhcgQLwExjnC8vrMhwkgQCZRuY62JQM
	 XAzvnQqgaSaUsqABLBDVfVuPcA4b3OeDWTXlySFFdtGucNn4g1WR7ed5HuFelEcdDN
	 Xr/EhCDJDVNUg5ZSnjSP32D69/LXsF3IdNlu+NDWlaiviFLXHRSVLiW97HTFbY+NuF
	 MnRBQlFroktUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	jacob.e.keller@intel.com
Subject: [PATCH net-next v2 01/10] genetlink: push conditional locking into dumpit/done
Date: Thu, 10 Aug 2023 16:38:36 -0700
Message-ID: <20230810233845.2318049-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810233845.2318049-1-kuba@kernel.org>
References: <20230810233845.2318049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers which take/release the genl mutex based
on family->parallel_ops. Remove the separation between
handling of ops in locked and parallel families.

Future patches would make the duplicated code grow even more.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
CC: jacob.e.keller@intel.com
---
 net/netlink/genetlink.c | 90 ++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 6bd2ce51271f..0d4285688ab9 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -52,6 +52,18 @@ static void genl_unlock_all(void)
 	up_write(&cb_lock);
 }
 
+static void genl_op_lock(const struct genl_family *family)
+{
+	if (!family->parallel_ops)
+		genl_lock();
+}
+
+static void genl_op_unlock(const struct genl_family *family)
+{
+	if (!family->parallel_ops)
+		genl_unlock();
+}
+
 static DEFINE_IDR(genl_fam_idr);
 
 /*
@@ -838,11 +850,9 @@ static int genl_start(struct netlink_callback *cb)
 
 	cb->data = info;
 	if (ops->start) {
-		if (!ctx->family->parallel_ops)
-			genl_lock();
+		genl_op_lock(ctx->family);
 		rc = ops->start(cb);
-		if (!ctx->family->parallel_ops)
-			genl_unlock();
+		genl_op_unlock(ctx->family);
 	}
 
 	if (rc) {
@@ -853,46 +863,34 @@ static int genl_start(struct netlink_callback *cb)
 	return rc;
 }
 
-static int genl_lock_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+static int genl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	const struct genl_split_ops *ops = &genl_dumpit_info(cb)->op;
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	const struct genl_split_ops *ops = &info->op;
 	int rc;
 
-	genl_lock();
+	genl_op_lock(info->family);
 	rc = ops->dumpit(skb, cb);
-	genl_unlock();
+	genl_op_unlock(info->family);
 	return rc;
 }
 
-static int genl_lock_done(struct netlink_callback *cb)
+static int genl_done(struct netlink_callback *cb)
 {
 	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
 	const struct genl_split_ops *ops = &info->op;
 	int rc = 0;
 
 	if (ops->done) {
-		genl_lock();
+		genl_op_lock(info->family);
 		rc = ops->done(cb);
-		genl_unlock();
+		genl_op_unlock(info->family);
 	}
 	genl_family_rcv_msg_attrs_free(info->attrs);
 	genl_dumpit_info_free(info);
 	return rc;
 }
 
-static int genl_parallel_done(struct netlink_callback *cb)
-{
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
-	const struct genl_split_ops *ops = &info->op;
-	int rc = 0;
-
-	if (ops->done)
-		rc = ops->done(cb);
-	genl_family_rcv_msg_attrs_free(info->attrs);
-	genl_dumpit_info_free(info);
-	return rc;
-}
-
 static int genl_family_rcv_msg_dumpit(const struct genl_family *family,
 				      struct sk_buff *skb,
 				      struct nlmsghdr *nlh,
@@ -901,6 +899,14 @@ static int genl_family_rcv_msg_dumpit(const struct genl_family *family,
 				      int hdrlen, struct net *net)
 {
 	struct genl_start_context ctx;
+	struct netlink_dump_control c = {
+		.module = family->module,
+		.data = &ctx,
+		.start = genl_start,
+		.dump = genl_dumpit,
+		.done = genl_done,
+		.extack = extack,
+	};
 	int err;
 
 	ctx.family = family;
@@ -909,31 +915,9 @@ static int genl_family_rcv_msg_dumpit(const struct genl_family *family,
 	ctx.ops = ops;
 	ctx.hdrlen = hdrlen;
 
-	if (!family->parallel_ops) {
-		struct netlink_dump_control c = {
-			.module = family->module,
-			.data = &ctx,
-			.start = genl_start,
-			.dump = genl_lock_dumpit,
-			.done = genl_lock_done,
-			.extack = extack,
-		};
-
-		genl_unlock();
-		err = __netlink_dump_start(net->genl_sock, skb, nlh, &c);
-		genl_lock();
-	} else {
-		struct netlink_dump_control c = {
-			.module = family->module,
-			.data = &ctx,
-			.start = genl_start,
-			.dump = ops->dumpit,
-			.done = genl_parallel_done,
-			.extack = extack,
-		};
-
-		err = __netlink_dump_start(net->genl_sock, skb, nlh, &c);
-	}
+	genl_op_unlock(family);
+	err = __netlink_dump_start(net->genl_sock, skb, nlh, &c);
+	genl_op_lock(family);
 
 	return err;
 }
@@ -1065,13 +1049,9 @@ static int genl_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (family == NULL)
 		return -ENOENT;
 
-	if (!family->parallel_ops)
-		genl_lock();
-
+	genl_op_lock(family);
 	err = genl_family_rcv_msg(family, skb, nlh, extack);
-
-	if (!family->parallel_ops)
-		genl_unlock();
+	genl_op_unlock(family);
 
 	return err;
 }
-- 
2.41.0


