Return-Path: <netdev+bounces-26011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC6776731
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327DF281CF6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAEE1DA42;
	Wed,  9 Aug 2023 18:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DA1D31C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108CCC433D9;
	Wed,  9 Aug 2023 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605614;
	bh=0h4gQZe5t0G28SaPoTkMccmW8f6hddQp7oGqT3XFkPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFMIRG5KIM/gb/X9tAarThg8XRrWXlal87GBGKhs5a6Iljpg54d317qnmn+s6Jhzp
	 5ODLXT7qnyeHNsTmr2Xs2+jW3WFja0tUaGPJpimHeA8aCIf5lzXvKtgoGQxFxC98y3
	 FeAF+vqRh9g5ZdX9yvOpZaK+utXesW8kEc5NCFfvDjqBUWNFHa9YSfhhHMlesTkd3W
	 oYXKvbnlM5ihbjOk8wivpPa6aJKrIT8Bv46hsAVI4Y8UVbmvm4eir2DhV4DYWS2ePV
	 jPddodyeFvznQZhSjmxz6yESLFY1NyC7xw+YiFGYT2/oweJFyG1u4QPqu6KVfwubo6
	 nj0+0D7t/4CIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	jacob.e.keller@intel.com
Subject: [PATCH net-next 01/10] genetlink: use push conditional locking info dumpit/done
Date: Wed,  9 Aug 2023 11:26:39 -0700
Message-ID: <20230809182648.1816537-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
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


