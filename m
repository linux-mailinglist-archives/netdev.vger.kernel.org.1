Return-Path: <netdev+bounces-112849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCF93B801
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435111F216DC
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E716D4D1;
	Wed, 24 Jul 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvuqgZgf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233316DEA8
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852755; cv=none; b=nj720gPnfcYTomHLrOQfnHhdJV9js6greTZG0XnL+Mx097fCRXlNx0+9by69lpH3gsqHNHzZbMjqhdbjEsVOS7KvHEUHp2YJdbB0q+ZV8Qe8/3KA0G3Wnod7sBaOM+dW6Ppv9BdgfZWBaPJKtmkvJeSf9JGpLliDNKYL7fGA2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852755; c=relaxed/simple;
	bh=uwOvR5XbdfkEQ7J9wnP/kjvnLajTcMg1QbDL2uPolrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcQWuKVPu4dGJlMpCVQMseXoUqxsMmb8u/erjJngHOB8UPSga6XbtpEOOKRQlCKeeb46LvtPybxEdCQA9exdJGTSgPCY8+jCgne+404EL7d57UXkengE/XVIIhm0TJZGre+kAleJjgWQB+qqoKXUGgQoeGDZhwkmYU42DJYvF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvuqgZgf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721852752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwPFKhhWU+yQfRbmrUU8tUeTcbFZzVs9QKz64SQsFEE=;
	b=DvuqgZgffRAW60q88EcGxAl1YCylRzx1GIjVkD6tJKRHImHd8DbZNE2VoYQpPt+97Txfce
	Q+S57rYjz1WdPNUkgugQSNgwajhgBY3G2wz8h+oXxZanoURzfvg4RhwIvsg1owo5LYdMpu
	ChbCCP4Rfp79EYkLL4zGEhFzv671ANU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-_hDnafnEMbyfIZWuE7NJiA-1; Wed,
 24 Jul 2024 16:25:50 -0400
X-MC-Unique: _hDnafnEMbyfIZWuE7NJiA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69E9919560AA;
	Wed, 24 Jul 2024 20:25:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3F8719560AE;
	Wed, 24 Jul 2024 20:25:43 +0000 (UTC)
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
Subject: [PATCH RFC v2 06/11] net: shaper: implement introspection support
Date: Wed, 24 Jul 2024 22:24:52 +0200
Message-ID: <e7a1b28418cd74829e8b4a1bad893d13520c4f4f.1721851988.git.pabeni@redhat.com>
In-Reply-To: <cover.1721851988.git.pabeni@redhat.com>
References: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The netlink op is a simple wrapper around the device callback.

Extend the existing fetch_dev() helper adding an attribute argument
for the requested device. Reuse such helper in the newly implemented
operation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/net_shaper.h |  11 ++++
 net/shaper/shaper.c      | 108 +++++++++++++++++++++++++++++++++++----
 2 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 8cd65d727e52..402f9d8476ee 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -103,6 +103,17 @@ struct net_shaper_ops {
 	 */
 	int (*delete)(struct net_device *dev, u32 handle,
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
 
 #define NET_SHAPER_SCOPE_SHIFT	26
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 7b7e9a777929..01f34681ad4e 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -118,16 +118,17 @@ net_shaper_fill_one(struct sk_buff *msg, struct net_shaper_info *shaper,
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
@@ -425,7 +426,7 @@ int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 	u32 handle;
 	int ret;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -476,7 +477,7 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	unsigned long handle;
 	int ret;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -543,7 +544,7 @@ int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
 		return -EINVAL;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -616,7 +617,7 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
 		return -EINVAL;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -785,7 +786,7 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	    GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_OUTPUT))
 		return -EINVAL;
 
-	ret = fetch_dev(info, &dev);
+	ret = fetch_dev(info, NET_SHAPER_A_IFINDEX, &dev);
 	if (ret)
 		return ret;
 
@@ -836,15 +837,102 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
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
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_CAPABILITIES_SCOPE))
+		return -EINVAL;
+
+	ret = fetch_dev(info, NET_SHAPER_A_CAPABILITIES_IFINDEX, &dev);
+	if (ret)
+		return ret;
+
+	scope = nla_get_u32(info->attrs[NET_SHAPER_A_CAPABILITIES_SCOPE]);
+	ops = dev->netdev_ops->net_shaper_ops;
+	ret = ops->capabilities(dev, scope, &flags);
+	if (ret)
+		goto put;
+
+	msg = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
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
2.45.2


