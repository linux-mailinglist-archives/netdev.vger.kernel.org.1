Return-Path: <netdev+bounces-208039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D811B09866
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3416E022
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920062459F0;
	Thu, 17 Jul 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5hnQAgV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BF24502E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795852; cv=none; b=IKrFkqy60KP8vVL6CsbjEGPPwiFb1uQlPaiQ3+u/PCb2nLtemc5V9gvA6zNdp6gqWM6xTjqX9pNCBhI3VR6BIdPPyGDvW4tkz1swKcU0AEySCSIcXvPicHCfPoCIaTQl/dg5WPLEzZmm0SF+3EwhCbr/09V/FqLTJ9IfPzz+eWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795852; c=relaxed/simple;
	bh=aBFwLCwRg2H5mNM8BbgQHpB2UGDItYec/i2YWkXiWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njehUoVcCFaLv/cCgGjT1XNnC2BlQagNCT6mKAG0R2i92u6skzghQ8mjjkELRhiaPSlYLkipAvW8pvxpMA9WXvEkNl6/+dQitmljxAO/on0q2pYd+PMwh/WNoBpo5wvJKpgAxucTQHfa5p45mObbtMclnNAGoxg0M0P4stDVEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5hnQAgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7582C4CEF6;
	Thu, 17 Jul 2025 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795852;
	bh=aBFwLCwRg2H5mNM8BbgQHpB2UGDItYec/i2YWkXiWbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5hnQAgVWs93FQGrSVrUumBrZZOzdy423QG4mCznAz5gk8RMtaw3tVcsnZc5IogTN
	 9GLK0Ju3I9yTZLWwFYz6sFaNIGXmJpgpfDtQK4EKM92oXIy2ZKQmSsi9zaLeaLDpdZ
	 96bQDQxvCoDiFbJZlAfi0/SYEQPgxLT+2RQtN1f4czE/67AqPysfvGdyovUWYl3TxU
	 Pc2zS+0yOwxYBJIaatRXps+U8YRtU565h0hcoPIom7QZk0ZyzTZjYUWnHPRUx9Qf4p
	 mFb4JeFAYA5ZojNoYjTd6Nij7shINhlth0B4DeC6MiToGLsyQnzRjBUAjMA8HNDcTI
	 /kQSU7f0pvPBw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/8] ethtool: rejig the RSS notification machinery for more types
Date: Thu, 17 Jul 2025 16:43:37 -0700
Message-ID: <20250717234343.2328602-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In anticipation for CREATE and DELETE notifications - explicitly
pass the notification type to ethtool_rss_notify(), when calling
from the IOCTL code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/common.h |  5 +++--
 net/ethtool/ioctl.c  | 12 +++++++-----
 net/ethtool/rss.c    |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index b2718afe38b5..c8385a268ced 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -76,9 +76,10 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 bool __ethtool_dev_mm_supported(struct net_device *dev);
 
 #if IS_ENABLED(CONFIG_ETHTOOL_NETLINK)
-void ethtool_rss_notify(struct net_device *dev, u32 rss_context);
+void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context);
 #else
-static inline void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
+static inline void
+ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context)
 {
 }
 #endif
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 2dfeaaa099fb..beb17f3671a2 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1105,7 +1105,7 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (rc)
 		return rc;
 
-	ethtool_rss_notify(dev, fields.rss_context);
+	ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, fields.rss_context);
 	return 0;
 }
 
@@ -1520,8 +1520,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
-	bool mod = false;
 	u8 *rss_config;
+	int ntf = 0;
 	int ret;
 
 	if (!ops->get_rxnfc || !ops->set_rxfh)
@@ -1671,6 +1671,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
 	if (!rxfh.rss_context) {
+		ntf = ETHTOOL_MSG_RSS_NTF;
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	} else if (create) {
 		ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev, extack);
@@ -1682,9 +1683,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		ret = ops->remove_rxfh_context(dev, ctx, rxfh.rss_context,
 					       extack);
 	} else {
+		ntf = ETHTOOL_MSG_RSS_NTF;
 		ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev, extack);
 	}
 	if (ret) {
+		ntf = 0;
 		if (create) {
 			/* failed to create, free our new tracking entry */
 			xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
@@ -1692,7 +1695,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 		goto out_unlock;
 	}
-	mod = !create && !rxfh_dev.rss_delete;
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
 			 &rxfh_dev.rss_context, sizeof(rxfh_dev.rss_context)))
@@ -1732,8 +1734,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	mutex_unlock(&dev->ethtool->rss_lock);
 out_free:
 	kfree(rss_config);
-	if (mod)
-		ethtool_rss_notify(dev, rxfh.rss_context);
+	if (ntf)
+		ethtool_rss_notify(dev, ntf, rxfh.rss_context);
 	return ret;
 }
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index bf45ebc22347..3c6a070ef875 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -461,13 +461,13 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 /* RSS_NTF */
 
-void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
+void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context)
 {
 	struct rss_req_info req_info = {
 		.rss_context = rss_context,
 	};
 
-	ethnl_notify(dev, ETHTOOL_MSG_RSS_NTF, &req_info.base);
+	ethnl_notify(dev, type, &req_info.base);
 }
 
 /* RSS_SET */
-- 
2.50.1


