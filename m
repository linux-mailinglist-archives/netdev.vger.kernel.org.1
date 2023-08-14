Return-Path: <netdev+bounces-27509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6577C2C0
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3F1C20BFD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A06101EB;
	Mon, 14 Aug 2023 21:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C2100D6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F8BC43395;
	Mon, 14 Aug 2023 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049648;
	bh=RrSOA/hWPdjEBINJu/SH51wOb0dfEja6PczjvPfZX9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLR6QhUS+O5E4O+iMJ53Akjw+A38p1cFkRkoF5O2aZLP46kPI561tKvFqWBgrMowZ
	 2rbfRjIrjjaGDTnodb3byKHL9UVtqbV/vOGTtAFmGePS7bhIqqL6MtAsRuYtKCo28d
	 bvVDPlFd38RcLtSYAk+ungPnLTrw8fNyMtjOTRkG1Ew4DJVcLVRwTUoH+TBRvSFxyc
	 GAsWz69M64K/m49bQlvJYdR0f8Qk1SXNDK6mwOf56uj2H7jOVUtb39D2bof1VS12U3
	 pvdnvTJlw8n2Qi68PXfb9LYduHSgyHSYHXnxlXnfgeLqvmG8JNchMMXF5Vstm+pDRd
	 fw9xt7L1ekVDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 04/10] genetlink: add struct genl_info to struct genl_dumpit_info
Date: Mon, 14 Aug 2023 14:47:17 -0700
Message-ID: <20230814214723.2924989-5-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214723.2924989-1-kuba@kernel.org>
References: <20230814214723.2924989-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink GET implementations must currently juggle struct genl_info
and struct netlink_callback, depending on whether they were called
from doit or dumpit.

Add genl_info to the dump state and populate the fields.
This way implementations can simply pass struct genl_info around.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/genetlink.h |  8 ++++++++
 net/netlink/genetlink.c | 16 ++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9dc21ec15734..86c8eaaa3a43 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -250,11 +250,13 @@ struct genl_split_ops {
  * @family: generic netlink family - for internal genl code usage
  * @op: generic netlink ops - for internal genl code usage
  * @attrs: netlink attributes
+ * @info: struct genl_info describing the request
  */
 struct genl_dumpit_info {
 	const struct genl_family *family;
 	struct genl_split_ops op;
 	struct nlattr **attrs;
+	struct genl_info info;
 };
 
 static inline const struct genl_dumpit_info *
@@ -263,6 +265,12 @@ genl_dumpit_info(struct netlink_callback *cb)
 	return cb->data;
 }
 
+static inline const struct genl_info *
+genl_info_dump(struct netlink_callback *cb)
+{
+	return &genl_dumpit_info(cb)->info;
+}
+
 int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index f98f730bb245..82ad26970b9b 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -847,6 +847,14 @@ static int genl_start(struct netlink_callback *cb)
 	info->family = ctx->family;
 	info->op = *ops;
 	info->attrs = attrs;
+	info->info.snd_seq	= cb->nlh->nlmsg_seq;
+	info->info.snd_portid	= NETLINK_CB(cb->skb).portid;
+	info->info.nlhdr	= cb->nlh;
+	info->info.genlhdr	= nlmsg_data(cb->nlh);
+	info->info.attrs	= attrs;
+	genl_info_net_set(&info->info, sock_net(cb->skb->sk));
+	info->info.extack	= cb->extack;
+	memset(&info->info.user_ptr, 0, sizeof(info->info.user_ptr));
 
 	cb->data = info;
 	if (ops->start) {
@@ -865,10 +873,12 @@ static int genl_start(struct netlink_callback *cb)
 
 static int genl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct genl_dumpit_info *info = cb->data;
 	const struct genl_split_ops *ops = &info->op;
 	int rc;
 
+	info->info.extack = cb->extack;
+
 	genl_op_lock(info->family);
 	rc = ops->dumpit(skb, cb);
 	genl_op_unlock(info->family);
@@ -877,10 +887,12 @@ static int genl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 static int genl_done(struct netlink_callback *cb)
 {
-	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct genl_dumpit_info *info = cb->data;
 	const struct genl_split_ops *ops = &info->op;
 	int rc = 0;
 
+	info->info.extack = cb->extack;
+
 	if (ops->done) {
 		genl_op_lock(info->family);
 		rc = ops->done(cb);
-- 
2.41.0


