Return-Path: <netdev+bounces-27511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94177C2C2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798C12812F8
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08401107A3;
	Mon, 14 Aug 2023 21:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491C1078D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25755C433B7;
	Mon, 14 Aug 2023 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049650;
	bh=If3zNFjbklJ2rsbgQ0OefgfAbG/18eZ9Zn2gCeXr78g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqIUvXahJJyVunbGTc5BpvW7BjZ3os1zgaURY6YM0kEYMib7rnMjNP7kIJ53ycyJ/
	 y2XEzxObsnC8+5mjbklozWbt4BuBDSEcdbqUZSXBKyH8QjVLsWm7bEae/EWf/BkRAv
	 6lCdoiSfjN1VWhaUMVHDAKWTbVwHxEMPXmgxJqIwJPBtet+/6ShWy1nAZNO0K/FLpE
	 IMEC56n2RpdE6hNFGJYfkCC4gH3MWCtzyuVGMGRD1R3p+xF9KseA0/Zku8fu6u8M0j
	 v4SVpzKChV6fwxb6FpuxwcpytJs0ZRP2psGxOxM21kcZ30AEXJMb5djIzbi/cNg1E3
	 95fNyaKPmClSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 06/10] genetlink: add a family pointer to struct genl_info
Date: Mon, 14 Aug 2023 14:47:19 -0700
Message-ID: <20230814214723.2924989-7-kuba@kernel.org>
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

Having family in struct genl_info is quite useful. It cuts
down the number of arguments which need to be passed to
helpers which already take struct genl_info.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/genetlink.h |  4 ++--
 net/netlink/genetlink.c | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index a8a15b9c22c8..6b858c4cba5b 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -93,6 +93,7 @@ struct genl_family {
  * struct genl_info - receiving information
  * @snd_seq: sending sequence number
  * @snd_portid: netlink portid of sender
+ * @family: generic netlink family
  * @nlhdr: netlink message header
  * @genlhdr: generic netlink message header
  * @attrs: netlink attributes
@@ -103,6 +104,7 @@ struct genl_family {
 struct genl_info {
 	u32			snd_seq;
 	u32			snd_portid;
+	const struct genl_family *family;
 	const struct nlmsghdr *	nlhdr;
 	struct genlmsghdr *	genlhdr;
 	struct nlattr **	attrs;
@@ -247,13 +249,11 @@ struct genl_split_ops {
 
 /**
  * struct genl_dumpit_info - info that is available during dumpit op call
- * @family: generic netlink family - for internal genl code usage
  * @op: generic netlink ops - for internal genl code usage
  * @attrs: netlink attributes
  * @info: struct genl_info describing the request
  */
 struct genl_dumpit_info {
-	const struct genl_family *family;
 	struct genl_split_ops op;
 	struct genl_info info;
 };
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index d47879d5a74c..8315d31b53db 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -844,8 +844,8 @@ static int genl_start(struct netlink_callback *cb)
 		genl_family_rcv_msg_attrs_free(attrs);
 		return -ENOMEM;
 	}
-	info->family = ctx->family;
 	info->op = *ops;
+	info->info.family	= ctx->family;
 	info->info.snd_seq	= cb->nlh->nlmsg_seq;
 	info->info.snd_portid	= NETLINK_CB(cb->skb).portid;
 	info->info.nlhdr	= cb->nlh;
@@ -872,11 +872,12 @@ static int genl_start(struct netlink_callback *cb)
 
 static int genl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct genl_dumpit_info *info = cb->data;
-	const struct genl_split_ops *ops = &info->op;
+	struct genl_dumpit_info *dump_info = cb->data;
+	const struct genl_split_ops *ops = &dump_info->op;
+	struct genl_info *info = &dump_info->info;
 	int rc;
 
-	info->info.extack = cb->extack;
+	info->extack = cb->extack;
 
 	genl_op_lock(info->family);
 	rc = ops->dumpit(skb, cb);
@@ -886,19 +887,20 @@ static int genl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 static int genl_done(struct netlink_callback *cb)
 {
-	struct genl_dumpit_info *info = cb->data;
-	const struct genl_split_ops *ops = &info->op;
+	struct genl_dumpit_info *dump_info = cb->data;
+	const struct genl_split_ops *ops = &dump_info->op;
+	struct genl_info *info = &dump_info->info;
 	int rc = 0;
 
-	info->info.extack = cb->extack;
+	info->extack = cb->extack;
 
 	if (ops->done) {
 		genl_op_lock(info->family);
 		rc = ops->done(cb);
 		genl_op_unlock(info->family);
 	}
-	genl_family_rcv_msg_attrs_free(info->info.attrs);
-	genl_dumpit_info_free(info);
+	genl_family_rcv_msg_attrs_free(info->attrs);
+	genl_dumpit_info_free(dump_info);
 	return rc;
 }
 
@@ -952,6 +954,7 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 
 	info.snd_seq = nlh->nlmsg_seq;
 	info.snd_portid = NETLINK_CB(skb).portid;
+	info.family = family;
 	info.nlhdr = nlh;
 	info.genlhdr = nlmsg_data(nlh);
 	info.attrs = attrbuf;
-- 
2.41.0


