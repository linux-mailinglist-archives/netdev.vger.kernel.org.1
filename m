Return-Path: <netdev+bounces-201676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F53AEA83A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A3A4A59CD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABA2F004A;
	Thu, 26 Jun 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTGD7BLb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334672EFDA5
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969732; cv=none; b=PS22P3T5uhw3CehcRRWP75gJ6ReKQzhq/B0f3o2yGaMw8vIEkdgc3JmKcmf8MDOqsxExRUVTCB3glFxoMUZ55IGL53jTue2P19vG9V5wFMGpuNYrSlWO34SckNJsoOZJp03dMtQBAJ/iU2Zr6CAinJ7EAToAMMEVWUaNLXCe0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969732; c=relaxed/simple;
	bh=yzu6iOl9S34RX6NbDiYZHtVqHgngji1FaB20gX3Yg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlViG7PkfGnttpXVRVyMUvjVVdRJtzy6jE+1KD2y73XWxrmmA+fkDgz1covc9CURY8zBfzHh3VGRyQq7alQjaHKbHTPppLFsXKig0golsFDfQ5pR8R/pyHzaCm4hqzFjqqg8ccFXehjEF6KfHME2xRtKH7BjWcZqq/R5SqKUkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTGD7BLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6630BC4CEF2;
	Thu, 26 Jun 2025 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750969731;
	bh=yzu6iOl9S34RX6NbDiYZHtVqHgngji1FaB20gX3Yg3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTGD7BLb1Ec34uYaDZCUwbPSKn6CR/ztdohMWbqFUzCXY5B8AfS0TdlsmZr7z5Vqs
	 5dfi+WXGSQI6+OB8vT4YhgHFliGcOOmDzQ7dYsDamNFDj5gVwC9G5zLJr86uc7kcna
	 5+DADKC/sf6loD3Ay7v6qZSs3Yeaj/NDTjNrFSFKXubfRFx/vg5UnweijHQUdhuJR6
	 YpycbOrM2yGxQ5nmuJoJzTxKhnvgBuKSIifuzwmYsjuLlYjCg2BuT5BQ/u0Qr0TUh3
	 MKeg4DLnVTwlrCbgalm9dBqpj5KOq7SUt8Z2QYj+4udswnDCcG1SR+7RTp8p0l/FeZ
	 9QCoRTCxeULhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] net: ethtool: move get_rxfh callback under the rss_lock
Date: Thu, 26 Jun 2025 13:28:48 -0700
Message-ID: <20250626202848.104457-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626202848.104457-1-kuba@kernel.org>
References: <20250626202848.104457-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already call get_rxfh under the rss_lock when we read back
context state after changes. Let's be consistent and always
hold the lock. The existing callers are all under rtnl_lock
so this should make no difference in practice, but it makes
the locking rules far less confusing IMHO. Any RSS callback
and any access to the RSS XArray should hold the lock.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/common.c |  2 ++
 net/ethtool/ioctl.c  | 11 ++++++++---
 net/ethtool/rss.c    | 23 +++++++++++++++++------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index eb253e0fd61b..d62dc56f2f5b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -707,7 +707,9 @@ static u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 	if (!rxfh.indir)
 		return U32_MAX;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh);
+	mutex_unlock(&dev->ethtool->rss_lock);
 	if (ret) {
 		current_max = U32_MAX;
 		goto out_free;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index df376628ba19..b6d96e562c9a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1079,16 +1079,17 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	    !ops->rxfh_per_ctx_fields)
 		return -EINVAL;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 
 		rc = ops->get_rxfh(dev, &rxfh);
 		if (rc)
-			return rc;
+			goto exit_unlock;
 
 		rc = ethtool_check_xfrm_rxfh(rxfh.input_xfrm, info.data);
 		if (rc)
-			return rc;
+			goto exit_unlock;
 	}
 
 	fields.data = info.data;
@@ -1096,8 +1097,8 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (info.flow_type & FLOW_RSS)
 		fields.rss_context = info.rss_context;
 
-	mutex_lock(&dev->ethtool->rss_lock);
 	rc = ops->set_rxfh_fields(dev, &fields, NULL);
+exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
 	return rc;
 }
@@ -1274,7 +1275,9 @@ static noinline_for_stack int ethtool_get_rxfh_indir(struct net_device *dev,
 	if (!rxfh.indir)
 		return -ENOMEM;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh);
+	mutex_unlock(&dev->ethtool->rss_lock);
 	if (ret)
 		goto out;
 	if (copy_to_user(useraddr +
@@ -1413,6 +1416,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (user_key_size)
 		rxfh_dev.key = rss_config + indir_bytes;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	if (rxfh.rss_context) {
 		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
@@ -1458,6 +1462,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 		ret = -EFAULT;
 	}
 out:
+	mutex_unlock(&dev->ethtool->rss_lock);
 	kfree(rss_config);
 
 	return ret;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 3adddca7e215..e717f23cbc10 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -138,6 +138,15 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	return 0;
 }
 
+static int
+rss_prepare(const struct rss_req_info *request, struct net_device *dev,
+	    struct rss_reply_data *data, const struct genl_info *info)
+{
+	if (request->rss_context)
+		return rss_prepare_ctx(request, dev, data, info);
+	return rss_prepare_get(request, dev, data, info);
+}
+
 static int
 rss_prepare_data(const struct ethnl_req_info *req_base,
 		 struct ethnl_reply_data *reply_base,
@@ -147,20 +156,22 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 	struct rss_req_info *request = RSS_REQINFO(req_base);
 	struct net_device *dev = reply_base->dev;
 	const struct ethtool_ops *ops;
+	int ret;
 
 	ops = dev->ethtool_ops;
 	if (!ops->get_rxfh)
 		return -EOPNOTSUPP;
 
 	/* Some drivers don't handle rss_context */
-	if (request->rss_context) {
-		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
-			return -EOPNOTSUPP;
+	if (request->rss_context &&
+	    !ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
+		return -EOPNOTSUPP;
 
-		return rss_prepare_ctx(request, dev, data, info);
-	}
+	mutex_lock(&dev->ethtool->rss_lock);
+	ret = rss_prepare(request, dev, data, info);
+	mutex_unlock(&dev->ethtool->rss_lock);
 
-	return rss_prepare_get(request, dev, data, info);
+	return ret;
 }
 
 static int
-- 
2.50.0


