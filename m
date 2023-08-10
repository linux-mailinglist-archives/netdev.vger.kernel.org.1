Return-Path: <netdev+bounces-26581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8C778434
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5111C20A91
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A218AE5;
	Thu, 10 Aug 2023 23:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C591ADCF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2953C433AB;
	Thu, 10 Aug 2023 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710733;
	bh=ipCYduD5IWphIcHahDO5BwCi+YU71xnU3tJzhC8Ocyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCDvb0R/lpLKd6v9KNtCI+oWrIqET1Sacy8vu7IozBT8FitoBHejfA021kMO0/Iqx
	 huepp+00pQNs7LHmd55MV6vZlGzojWlAk1TBZkfHd1r5J9UuaHljYOhAvkmsn9Ls5+
	 kjaY4emG7ChA7BOU9Ewg3+lFMi16fsv37K6tvdtGFDtGCHRAa5c0AJr6ZLvobwFuGS
	 aDtWFnv6ymT7Yfciee5hxWgjK9uB1aFZIfKGV5pR/0g0luJH+vCW+FJVCXgswHUFrm
	 pe0E+87Xnktst5R0J284j3bm25AFI3MhSM8UKBzQ7pHW3Vr5CHu/eI/k+APLBfF4Qb
	 H6wyyYM3LXFpw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/10] genetlink: add a family pointer to struct genl_info
Date: Thu, 10 Aug 2023 16:38:41 -0700
Message-ID: <20230810233845.2318049-7-kuba@kernel.org>
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

Having family in struct genl_info is quite useful. It cuts
down the number of arguments which need to be passed to
helpers which already take struct genl_info.

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


