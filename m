Return-Path: <netdev+bounces-120246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952AE958AD7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE96282ACA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F97191F8F;
	Tue, 20 Aug 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEuoAp3y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58E191F8B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166816; cv=none; b=FAsZow8rP1SP9+7AlxW2TJurco15vsrg+knRCuXQgLq4AHRUfgqY/LfWqvNY2hy+wxr+SmdFPIflMYNNGtrMSCDv5HJtx7yGmlWxQ0SYnD9ZgZvVtXyC3xLo3aA7aYKCjd5OzbbyYOqFBwZGuOr6L5zU9vUijgGZ+rqxh7+H3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166816; c=relaxed/simple;
	bh=OiPwb1YpFLzCgXSzQ2b43NpttXbawBPKwtFX5elXrdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDWhrXYUEWBbH0GIeErSHZVwBDdvt2vbf9WfJXEFHVJegfNY9MxACOhcFm4byk0f430mrDhmHGnZ88kqOeA/CmSZ7AjJfo4dJgth+NaE4C1pE9wougichVUBmbjyxRjGEWmT/0xXxqQKPK+Qo0fcay4niC/SanqItSHz0ghYsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEuoAp3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pF6GhNPWtO0LRfidlOv/AZk9T5SgfL0JWVzL5DPsQE=;
	b=KEuoAp3yHaR2qFOdAZO+WHXbOS8Dduyg/IZU6Wl3rEdW07Z5nNsUOyNg3FR/YkR1pXy8k+
	jV2MYFve9Fbcmr7AJzPSQ1drwwbLUla8v2PrZ7qFKZkkk5eMweiQWkQ5OmZtslv9MEGPQo
	V3ssVwFhIt3Ij9Z0LON4uXtaBEK6PUk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-eYF5NHNQMe6cFuzT9Vjg-A-1; Tue,
 20 Aug 2024 11:13:29 -0400
X-MC-Unique: eYF5NHNQMe6cFuzT9Vjg-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971DF1955D52;
	Tue, 20 Aug 2024 15:13:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F38B919560AD;
	Tue, 20 Aug 2024 15:13:23 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 08/12] net: shaper: implement introspection support
Date: Tue, 20 Aug 2024 17:12:29 +0200
Message-ID: <d90fdf8da62da13ce677a248cbf0bb0fe9b29472.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The netlink op is a simple wrapper around the device callback.

Extend the existing fetch_dev() helper adding an attribute argument
for the requested device. Reuse such helper in the newly implemented
operation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - another dev_put() -> netdev_put() conversion, missed in previous
   iteration

RFC v2 -> v3:
 - dev_put() -> netdev_put()
---
 include/net/net_shaper.h |  11 ++++
 net/shaper/shaper.c      | 111 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index bfb521d31c78..1610bc33d476 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -99,6 +99,17 @@ struct net_shaper_ops {
 	int (*delete)(struct net_device *dev,
 		      const struct net_shaper_handle *handle,
 		      struct netlink_ext_ack *extack);
+
+	/**
+	 * @capabilities: get the shaper features supported by the NIC
+	 *
+	 * Fills the bitmask @cap with the supported cababilites for the
+	 * specified @scope and device @dev.
+	 *
+	 * Returns 0 on success or a negative error value otherwise.
+	 */
+	int (*capabilities)(struct net_device *dev,
+			    enum net_shaper_scope scope, unsigned long *cap);
 };
 
 #endif
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index d3bb0ee1a18a..a119898d4ce0 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -117,17 +117,17 @@ net_shaper_fill_one(struct sk_buff *msg,
 /* On success sets pdev to the relevant device and acquires a reference
  * to it.
  */
-static int net_shaper_fetch_dev(const struct genl_info *info,
+static int net_shaper_fetch_dev(const struct genl_info *info, int type,
 				struct net_device **pdev)
 {
 	struct net *ns = genl_info_net(info);
 	struct net_device *dev;
 	int ifindex;
 
-	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_IFINDEX))
+	if (GENL_REQ_ATTR_CHECK(info, type))
 		return -EINVAL;
 
-	ifindex = nla_get_u32(info->attrs[NET_SHAPER_A_IFINDEX]);
+	ifindex = nla_get_u32(info->attrs[type]);
 	dev = dev_get_by_index(ns, ifindex);
 	if (!dev) {
 		GENL_SET_ERR_MSG_FMT(info, "device %d not found", ifindex);
@@ -485,7 +485,7 @@ int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 	struct net_device *dev;
 	int ret;
 
-	ret = net_shaper_fetch_dev(info, &dev);
+	ret = net_shaper_fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -504,12 +504,23 @@ void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev;
+	int ret;
+
+	ret = net_shaper_fetch_dev(info, NET_SHAPER_A_CAPABILITIES_IFINDEX, &dev);
+	if (ret)
+		return ret;
+
+	info->user_ptr[0] = dev;
+	return 0;
 }
 
 void net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info)
 {
+	struct net_device *dev = info->user_ptr[0];
+
+	netdev_put(dev, NULL);
 }
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -565,7 +576,7 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	unsigned long index;
 	int ret;
 
-	ret = net_shaper_fetch_dev(info, &dev);
+	ret = net_shaper_fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -1063,15 +1074,101 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int
+net_shaper_cap_fill_one(struct sk_buff *msg, int ifindex,
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
+	if (nla_put_u32(msg, NET_SHAPER_A_CAPABILITIES_IFINDEX, ifindex) ||
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
+	struct net_device *dev = info->user_ptr[0];
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
+	ops = dev->netdev_ops->net_shaper_ops;
+	ret = ops->capabilities(dev, scope, &flags);
+	if (ret)
+		return ret;
+
+	msg = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = net_shaper_cap_fill_one(msg, dev->ifindex, scope, flags, info);
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
-	return 0;
+	const struct genl_info *info = genl_info_dump(cb);
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	struct net_device *dev;
+	unsigned long flags;
+	int ret;
+
+	ret = net_shaper_fetch_dev(info, NET_SHAPER_A_CAPABILITIES_IFINDEX, &dev);
+	if (ret)
+		return ret;
+
+	ops = dev->netdev_ops->net_shaper_ops;
+	for (scope = 0; scope <= NET_SHAPER_SCOPE_MAX; ++scope) {
+		if (ops->capabilities(dev, scope, &flags))
+			continue;
+
+		ret = net_shaper_cap_fill_one(skb, dev->ifindex, scope, flags,
+					      info);
+		if (ret)
+			goto put;
+	}
+
+put:
+	netdev_put(dev, NULL);
+	return ret;
 }
 
 void net_shaper_flush(struct net_device *dev)
-- 
2.45.2


