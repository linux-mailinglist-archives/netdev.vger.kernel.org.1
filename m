Return-Path: <netdev+bounces-123358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA789649C5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1792A283922
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEE1B2EF8;
	Thu, 29 Aug 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1TrX35W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDA1B29D5
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944693; cv=none; b=Sr7meUdcF3L6FZpbPa4n8eqOI2WxRNs3jRT9fw/g9ZIupr4rC65SwG47v3kqF8gPEF6taNPMGUSu6MiEPS2Dh3Y4XB1acuRxkYd4BfXUF3PjfJVsTe1ZDeM/1rYJ5qfM4j/+7VAUr+Qcw00ObDx7sLM5/kaTXMX10uglsbXvX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944693; c=relaxed/simple;
	bh=0oaXGAuLDbtKW8b1wniE/CbB5QGe4MkRqjpa+P5yjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTDF5/dX/2idOhWhUeaJ/yiGAup37ReHoET7s9GQAvaJ42md7AGyKD3OqvwuXgPVD+2vSrNTJQd0JpunoXN6x2hvHuwE+gvjpNFESc/KpzJgy95F+iI8HdswZ9h145XMaQeFpPm+hfsk1YGNsJATJib1KMKSLjZ2OMX+inWIjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1TrX35W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+AHJEKfihouwzHxsuo69tpJA2c+4waL3jCHXyEoGf0=;
	b=i1TrX35WPWqVmI7wjocP90VVrf5aocEfMdQHANfsyQyMvSkjwsANsycZhsbBNJI6R6LtbX
	mWVCldp+Acwuf0YGFcSdhf+JCs1SYkLPYNwOrU8tr08bCQfFyf2BDsII5xGkZnYED4MW6e
	yg/abfhORrOr2bmr3wNP+k8PAfQBgHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-R0aMnxT9OlOXXsBxaBq1Iw-1; Thu,
 29 Aug 2024 11:18:06 -0400
X-MC-Unique: R0aMnxT9OlOXXsBxaBq1Iw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 526681955BF4;
	Thu, 29 Aug 2024 15:18:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 429CB300019C;
	Thu, 29 Aug 2024 15:17:58 +0000 (UTC)
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
	edumazet@google.com
Subject: [PATCH v5 net-next 07/12] net: shaper: implement introspection support
Date: Thu, 29 Aug 2024 17:17:00 +0200
Message-ID: <2ddedcd3f4dd4d9986c3a3bc995a2c410c20440e.1724944117.git.pabeni@redhat.com>
In-Reply-To: <cover.1724944116.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The netlink op is a simple wrapper around the device callback.

Extend the existing fetch_dev() helper adding an attribute argument
for the requested device. Reuse such helper in the newly implemented
operation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - replace net_device* with binding* in most functions
 - de-deplicate some code thanks to more generic helpers in previous
   patches

v3 -> v4:
 - another dev_put() -> netdev_put() conversion, missed in previous
   iteration

RFC v2 -> v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 96 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 98e17a95f39f..b7e5a3990328 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -629,22 +629,29 @@ int net_shaper_nl_post_dumpit(struct netlink_callback *cb)
 int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	return net_shaper_generic_pre(info, NET_SHAPER_A_CAPABILITIES_IFINDEX);
 }
 
 void net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
+	net_shaper_generic_post(info);
 }
 
 int net_shaper_nl_cap_pre_dumpit(struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+
+	return net_shaper_ctx_init(genl_info_dump(cb),
+				   NET_SHAPER_A_CAPABILITIES_IFINDEX, ctx);
 }
 
 int net_shaper_nl_cap_post_dumpit(struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
+
+	net_shaper_ctx_cleanup(ctx);
+	return 0;
 }
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1196,14 +1203,97 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int
+net_shaper_cap_fill_one(struct sk_buff *msg,
+			struct net_shaper_binding *binding,
+			enum net_shaper_scope scope, unsigned long flags,
+			const struct genl_info *info)
+{
+	unsigned long cur;
+	void *hdr;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (net_shaper_fill_binding(msg, binding,
+				    NET_SHAPER_A_CAPABILITIES_IFINDEX) ||
+	    nla_put_u32(msg, NET_SHAPER_A_CAPABILITIES_SCOPE, scope))
+		goto nla_put_failure;
+
+	for (cur = NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_BPS;
+	     cur <= NET_SHAPER_A_CAPABILITIES_MAX; ++cur) {
+		if (flags & BIT(cur) && nla_put_flag(msg, cur))
+			goto nla_put_failure;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
 int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct net_shaper_binding *binding = info->user_ptr[0];
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	struct sk_buff *msg;
+	unsigned long flags;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_CAPABILITIES_SCOPE))
+		return -EINVAL;
+
+	scope = nla_get_u32(info->attrs[NET_SHAPER_A_CAPABILITIES_SCOPE]);
+	ops = net_shaper_binding_ops(binding);
+	ret = ops->capabilities(binding, scope, &flags);
+	if (ret)
+		return ret;
+
+	msg = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = net_shaper_cap_fill_one(msg, binding, scope, flags, info);
+	if (ret)
+		goto free_msg;
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
 	return 0;
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
 				 struct netlink_callback *cb)
 {
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net_shaper_binding *binding;
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	unsigned long flags;
+	int ret;
+
+	binding = net_shaper_binding_from_ctx(cb->ctx);
+	ops = net_shaper_binding_ops(binding);
+	for (scope = 0; scope <= NET_SHAPER_SCOPE_MAX; ++scope) {
+		if (ops->capabilities(binding, scope, &flags))
+			continue;
+
+		ret = net_shaper_cap_fill_one(skb, binding, scope, flags,
+					      info);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.45.2


