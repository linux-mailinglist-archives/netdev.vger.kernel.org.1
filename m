Return-Path: <netdev+bounces-130409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8B98A65D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D548D284BDD
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BB19048D;
	Mon, 30 Sep 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK7piw5E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1F192D60
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704490; cv=none; b=uitP+9m2DhAnlGmJK7Ukb2CAL/pC9XjiGlRtC5HkC5+Amj7GYYtENNjRXqjRXccZLVRlqu1tPTgc4+UyInp1z85pasZ87ZvxJG9jIYV7dPfKhNCz3WeGphbfhWQ74DGxfZ26dTuX5Iu411h/Dbb8LSvxZ6o6jhbDZYuohaX6MRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704490; c=relaxed/simple;
	bh=S0xsFNhoX5TeWq4na5izngkJ9Zy7x+q4d4X+Q6UOZhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV76wcztCz1/K2aadV9C0qgLJgP15xgZcIydnzU8NeLzPdd380d/iTV4vqP4fzDjvJ3W0OtHZ9qLZB5Ic88zLKiWHZzQCAWHmJ1rYwRil2Pg88LDrEkJMDYV/tyil9BVQOv3ht4/mrwpu6egJhn5GFuSrYxVJp5kyLsFz+7mg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK7piw5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727704488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHF/kXVu4tqnOBlnKENt9hsSlFNKEAg3X28gEIBw6OI=;
	b=RK7piw5EAywrTjrDCcH9+3mVDoy6NQ7xlnLWWB7CI6rWTlPSbPWNsQDzFM63/6c7uCRWnI
	VgiqL2Z7QcpYpVKv2pBEIm1IyK/VVjBE+qW03wLfo2ZZoszWtnensn24QmrjretGQEotTI
	nu3OuivswNXnTHnVlnpqmgBWRFYqSWg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-e6UQuYCDMsicYFRM3GP1Zg-1; Mon,
 30 Sep 2024 09:54:42 -0400
X-MC-Unique: e6UQuYCDMsicYFRM3GP1Zg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8526B1944CEE;
	Mon, 30 Sep 2024 13:54:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6065C1954B0F;
	Mon, 30 Sep 2024 13:54:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v8 net-next 01/15] genetlink: extend info user-storage to match NL cb ctx
Date: Mon, 30 Sep 2024 15:53:48 +0200
Message-ID: <4cea743b9af39fc312d838f9dffec4a3fa9c5865.1727704215.git.pabeni@redhat.com>
In-Reply-To: <cover.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This allows a more uniform implementation of non-dump and dump
operations, and will be used later in the series to avoid some
per-operation allocation.

Additionally rename the NL_ASSERT_DUMP_CTX_FITS macro, to
fit a more extended usage.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/vxlan/vxlan_mdb.c        | 2 +-
 include/linux/netlink.h              | 5 +++--
 include/net/genetlink.h              | 8 ++++++--
 net/core/netdev-genl.c               | 2 +-
 net/core/rtnetlink.c                 | 2 +-
 net/devlink/devl_internal.h          | 2 +-
 net/ethtool/rss.c                    | 2 +-
 net/netfilter/nf_conntrack_netlink.c | 2 +-
 net/netlink/genetlink.c              | 4 ++--
 9 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d55..ebed05a2804c 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -284,7 +284,7 @@ int vxlan_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 
 	ASSERT_RTNL();
 
-	NL_ASSERT_DUMP_CTX_FITS(struct vxlan_mdb_dump_ctx);
+	NL_ASSERT_CTX_FITS(struct vxlan_mdb_dump_ctx);
 
 	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid,
 			cb->nlh->nlmsg_seq, RTM_NEWMDB, sizeof(*bpm),
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index b332c2048c75..a3ca198a3a9e 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -34,6 +34,7 @@ struct netlink_skb_parms {
 
 #define NETLINK_CB(skb)		(*(struct netlink_skb_parms*)&((skb)->cb))
 #define NETLINK_CREDS(skb)	(&NETLINK_CB((skb)).creds)
+#define NETLINK_CTX_SIZE	48
 
 
 void netlink_table_grab(void);
@@ -293,7 +294,7 @@ struct netlink_callback {
 	int			flags;
 	bool			strict_check;
 	union {
-		u8		ctx[48];
+		u8		ctx[NETLINK_CTX_SIZE];
 
 		/* args is deprecated. Cast a struct over ctx instead
 		 * for proper type safety.
@@ -302,7 +303,7 @@ struct netlink_callback {
 	};
 };
 
-#define NL_ASSERT_DUMP_CTX_FITS(type_name)				\
+#define NL_ASSERT_CTX_FITS(type_name)					\
 	BUILD_BUG_ON(sizeof(type_name) >				\
 		     sizeof_field(struct netlink_callback, ctx))
 
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ab49bfeae78..9d3726e8f90e 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -124,7 +124,8 @@ struct genl_family {
  * @genlhdr: generic netlink message header
  * @attrs: netlink attributes
  * @_net: network namespace
- * @user_ptr: user pointers
+ * @ctx: storage space for the use by the family
+ * @user_ptr: user pointers (deprecated, use ctx instead)
  * @extack: extended ACK report struct
  */
 struct genl_info {
@@ -135,7 +136,10 @@ struct genl_info {
 	struct genlmsghdr *	genlhdr;
 	struct nlattr **	attrs;
 	possible_net_t		_net;
-	void *			user_ptr[2];
+	union {
+		u8		ctx[NETLINK_CTX_SIZE];
+		void *		user_ptr[2];
+	};
 	struct netlink_ext_ack *extack;
 };
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..358cba248796 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -24,7 +24,7 @@ struct netdev_nl_dump_ctx {
 
 static struct netdev_nl_dump_ctx *netdev_dump_ctx(struct netlink_callback *cb)
 {
-	NL_ASSERT_DUMP_CTX_FITS(struct netdev_nl_dump_ctx);
+	NL_ASSERT_CTX_FITS(struct netdev_nl_dump_ctx);
 
 	return (struct netdev_nl_dump_ctx *)cb->ctx;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..472d1a27cdf8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6169,7 +6169,7 @@ static int rtnl_mdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	int idx, s_idx;
 	int err;
 
-	NL_ASSERT_DUMP_CTX_FITS(struct rtnl_mdb_dump_ctx);
+	NL_ASSERT_CTX_FITS(struct rtnl_mdb_dump_ctx);
 
 	if (cb->strict_check) {
 		err = rtnl_mdb_valid_dump_req(cb->nlh, cb->extack);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index c7a8e13f917c..a9f064ab9ed9 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -166,7 +166,7 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 static inline struct devlink_nl_dump_state *
 devlink_dump_state(struct netlink_callback *cb)
 {
-	NL_ASSERT_DUMP_CTX_FITS(struct devlink_nl_dump_state);
+	NL_ASSERT_CTX_FITS(struct devlink_nl_dump_state);
 
 	return (struct devlink_nl_dump_state *)cb->ctx;
 }
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index e07386275e14..7cb106b590ab 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -224,7 +224,7 @@ struct rss_nl_dump_ctx {
 
 static struct rss_nl_dump_ctx *rss_dump_ctx(struct netlink_callback *cb)
 {
-	NL_ASSERT_DUMP_CTX_FITS(struct rss_nl_dump_ctx);
+	NL_ASSERT_CTX_FITS(struct rss_nl_dump_ctx);
 
 	return (struct rss_nl_dump_ctx *)cb->ctx;
 }
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 6a1239433830..36168f8b6efa 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3870,7 +3870,7 @@ static int __init ctnetlink_init(void)
 {
 	int ret;
 
-	NL_ASSERT_DUMP_CTX_FITS(struct ctnetlink_list_dump_ctx);
+	NL_ASSERT_CTX_FITS(struct ctnetlink_list_dump_ctx);
 
 	ret = nfnetlink_subsys_register(&ctnl_subsys);
 	if (ret < 0) {
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a116..29387b605f3e 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -997,7 +997,7 @@ static int genl_start(struct netlink_callback *cb)
 	info->info.attrs	= attrs;
 	genl_info_net_set(&info->info, sock_net(cb->skb->sk));
 	info->info.extack	= cb->extack;
-	memset(&info->info.user_ptr, 0, sizeof(info->info.user_ptr));
+	memset(&info->info.ctx, 0, sizeof(info->info.ctx));
 
 	cb->data = info;
 	if (ops->start) {
@@ -1104,7 +1104,7 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 	info.attrs = attrbuf;
 	info.extack = extack;
 	genl_info_net_set(&info, net);
-	memset(&info.user_ptr, 0, sizeof(info.user_ptr));
+	memset(&info.ctx, 0, sizeof(info.ctx));
 
 	if (ops->pre_doit) {
 		err = ops->pre_doit(ops, skb, &info);
-- 
2.45.2


