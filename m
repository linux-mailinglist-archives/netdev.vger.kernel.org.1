Return-Path: <netdev+bounces-107451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388691B03E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4637B1C2221E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCD19EEB8;
	Thu, 27 Jun 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGVPGXqO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF019DF68
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519482; cv=none; b=QXxSoLoK6LDD/gIBsxJQiWnB0eFbBUWn6A36r5XQwRIyMWoqdJDJjzpEr3LG7lPQuVQpxgn8mCnXWaiCS/4tnm6+0o/Qc0gHpX4DCe+UI18cmkgmTt0MbD9noBQA4hv2RC8Kpdqe97N0mmYu5nUsT0WCcmMChs7p9xIXbEch8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519482; c=relaxed/simple;
	bh=hxyRYKqLaV38beYvH5Ty1IsgLF+mxtp4cQBV7vIX7l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inhPz9h+qail/015U75XwxR+4I8pfp7FLFKri63+UJGcCoILCsZRi6JcId0fy//Ws0J8zsXNib9YaFBqN/VQetBQ2ADwMSn3HZ7/hv2dJj0DXDPFsKRGQJnJhKs2CxUIxrgeZf9yLvbxd2+8vk6W5HTRW0gpESx1Knnf1HafKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGVPGXqO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719519479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdFW+T6Gle4gMIRWUKk1+R/k/jIOr/PLCTSPo9hG8us=;
	b=ZGVPGXqOld1chDaUl3RHCgFAEbs/MvOu16gJpZiaiX9Yh6vBUK6hdvt5yRT4O5lMoiNQS8
	hFS7gNtNPQxmOl3k9lxrPW8GS9w2V+APIV18z5Km8z5xpZt88AEwmcGJszMe8CiUQA3r/d
	uE2Ip3c3zz22fORpQ+zOZXQujlHy29U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-VCCVVZOLOHOIEvTSKKdaww-1; Thu,
 27 Jun 2024 16:17:57 -0400
X-MC-Unique: VCCVVZOLOHOIEvTSKKdaww-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B69C6195C240;
	Thu, 27 Jun 2024 20:17:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82F701955BD4;
	Thu, 27 Jun 2024 20:17:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 4/5] net: shaper: implement introspection support
Date: Thu, 27 Jun 2024 22:17:21 +0200
Message-ID: <1d285cdb1d2b3a7404cc62091e7a6bd31760d3a7.1719518113.git.pabeni@redhat.com>
In-Reply-To: <cover.1719518113.git.pabeni@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The netlink op is a simple wrapper around the device callback.

Extend the existing fetch_dev() helper adding an attribute argument
for the requested device. Reuse such helper in the newly implemented
operation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - doc fix
---
 include/net/net_shaper.h |  13 +++++
 net/shaper/shaper.c      | 108 +++++++++++++++++++++++++++++++++++----
 2 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index a4d8213f8594..aac43812f684 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -49,6 +49,7 @@ struct net_shaper_info {
  * struct net_shaper_ops - Operations on device H/W shapers
  * @set: Modify the existing shaper.
  * @delete: Delete the specified shaper.
+ * @capabilities: Introspect the device shaper-related features
  *
  * The initial shaping configuration ad device initialization is empty/
  * a no-op/does not constraint the b/w in any way.
@@ -101,6 +102,18 @@ struct net_shaper_ops {
 	 */
 	int (*delete)(struct net_device *dev, int nr, const u32 *handles,
 		      struct netlink_ext_ack *extack);
+
+	/** capabilities - get the shaper features supported by the NIC
+	 * @dev: netdevice to operate on
+	 * @scope: the queried scope
+	 * @flags: bitfield of supported features for the given scope
+	 *
+	 * Return:
+	 * * %0 - Success, @flags is set according to the supported features
+	 * * %-EOPNOTSUPP - the H/W does not support the specified scope
+	 */
+	int (*capabilities)(struct net_device *dev, enum net_shaper_scope,
+			    unsigned long *flags);
 };
 
 #define NET_SHAPER_SCOPE_SHIFT	16
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 74da98aaa078..a9ac013a148c 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -102,16 +102,17 @@ net_shaper_fill_one(struct sk_buff *msg, struct net_shaper_info *shaper,
 /* On success sets pdev to the relevant device and acquires a reference
  * to it
  */
-static int fetch_dev(const struct genl_info *info, struct net_device **pdev)
+static int fetch_dev(const struct genl_info *info, int type,
+		     struct net_device **pdev)
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
@@ -161,7 +162,7 @@ int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 	u32 handle;
 	int ret;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -219,7 +220,7 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	unsigned long handle;
 	int ret;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -446,7 +447,7 @@ int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev;
 	struct nlattr *attr;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -519,7 +520,7 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr;
 	u32 *handles;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -558,15 +559,104 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
+static int
+net_shaper_cap_fill_one(struct sk_buff *msg, unsigned long flags,
+			const struct genl_info *info)
 {
+	unsigned long cur;
+	void *hdr;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	for (cur = NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_BPS;
+	     cur <= NET_SHAPER_A_CAPABILITIES_MAX; ++cur) {
+		if (flags & BIT(cur) && nla_put_flag(msg, cur))
+			goto nla_put_failure;
+	}
+
+	genlmsg_end(msg, hdr);
+
 	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	const struct net_shaper_ops *ops;
+	enum net_shaper_scope scope;
+	struct net_device *dev;
+	struct sk_buff *msg;
+	unsigned long flags;
+	int ret;
+
+	ret = fetch_dev(info, NET_SHAPER_A_CAPABILITIES_IFINDEX, &dev);
+	if (ret)
+		return ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_CAPABILITIES_SCOPE)) {
+		ret = -EINVAL;
+		goto put;
+	}
+
+	scope = nla_get_u32(info->attrs[NET_SHAPER_A_CAPABILITIES_SCOPE]);
+	ops = dev->netdev_ops->net_shaper_ops;
+	ret = ops->capabilities(dev, scope, &flags);
+	if (ret)
+		goto put;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		goto put;
+
+	ret = net_shaper_cap_fill_one(msg, flags, info);
+	if (ret)
+		goto free_msg;
+
+	ret =  genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+put:
+	dev_put(dev);
+	return ret;
+
+free_msg:
+	nlmsg_free(msg);
+	goto put;
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
+	ret = fetch_dev(info, NET_SHAPER_A_CAPABILITIES_IFINDEX, &dev);
+	if (ret)
+		return ret;
+
+	ops = dev->netdev_ops->net_shaper_ops;
+	for (scope = 0; scope <= NET_SHAPER_SCOPE_MAX; ++scope) {
+		if (ops->capabilities(dev, scope, &flags))
+			continue;
+
+		ret = net_shaper_cap_fill_one(skb, flags, info);
+		if (ret)
+			goto put;
+	}
+
+put:
+	dev_put(dev);
+	return ret;
 }
 
 void dev_shaper_flush(struct net_device *dev)
-- 
2.45.1


