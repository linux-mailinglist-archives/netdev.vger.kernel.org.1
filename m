Return-Path: <netdev+bounces-199232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4AADF7DD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241EF7A9FA3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4C21FF31;
	Wed, 18 Jun 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1+xUTWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F621FF2A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279150; cv=none; b=ZHmUszEd+opSOXxV+W8BE2eLUPy4y6Td6/zQbF7W4vf/692qwROIu+VmpzYm9cSwOmC0zY72Cm5qUaon0QQSDVMeP7olZIcJf9J4YWzdD2I+y/ZJdOEUcC0bKUNSpQDg6fGz4yaIpPjYSRn1BFbKgEq9PbbVRHZ+YmdLaTLY20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279150; c=relaxed/simple;
	bh=R36eUYjCC2cXVuTJy0YHf9kqMoaYOj3NkQPqauhCwY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP4MnyqJW4IoPniaflPdkiAEOBjFfOYMepcC+1L8/kz6zAOXmpaJ0qbaEzMxoUDRadhZsZ4kIUpJOLpIsIhl++qz2t+7p4pQHtct4p8hUMX60OhfF/Eo0z/S72wOcxqO7AYPjc7yViKUc3oA+dV/Pub56l4uCOg6VVFZUVFvf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1+xUTWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E85C4CEF4;
	Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279149;
	bh=R36eUYjCC2cXVuTJy0YHf9kqMoaYOj3NkQPqauhCwY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1+xUTWESPpjMArvLQ8GQCJpihMXId2OKFqDZWdN/Bkk4XLt/y0nL0HqHAEP8+nF1
	 rVEMYh5BYd2PInH5HOtbDOfXQBEpzUi5KeTOlcz3QJmSgcn8kF4tmW0Rj9E4GgIv4b
	 K0nSk/leL77U3gTLYgg9/cyfj15T+Cusklx+Af9K/+yY+gdjIcnWo1cnN8XTsGW88I
	 5Q1QD5iRhnoejnp1XYOgMfLnbPJtVlrhred/9R8ju5mfip8oYCIN5CYiGLLGYS5Nt6
	 bs/mt86fC4hnIVA6sh9Z2RdKpZrk+h2EubiaUHB70NHlTo1AxY2ozVtiT2Xk/JV834
	 JsN45fspRrHCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 10/10] net: ethtool: don't mux RXFH via rxnfc callbacks
Date: Wed, 18 Jun 2025 13:38:23 -0700
Message-ID: <20250618203823.1336156-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers have been converted. Stop using the rxnfc fallbacks
for Rx Flow Hashing configuration.

Joe pointed out in earlier review that in ethtool_set_rxfh()
we need both .get_rxnfc and .get_rxfh_fields, because we need
both the ring count and flow hashing (because we call
ethtool_check_flow_types()). IOW the existing check added
for transitioning drivers was buggy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 59 ++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a14cf901c32d..82cde640aa87 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1037,33 +1037,21 @@ static int ethtool_check_xfrm_rxfh(u32 input_xfrm, u64 rxfh)
 static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	struct ethtool_rxnfc info = {
-		.cmd = ETHTOOL_GRXFH,
-	};
 	int err;
 	u32 i;
 
 	for (i = 0; i < __FLOW_TYPE_COUNT; i++) {
+		struct ethtool_rxfh_fields fields = {
+			.flow_type	= i,
+		};
+
 		if (!flow_type_hashable(i))
 			continue;
 
-		info.flow_type = i;
+		if (ops->get_rxfh_fields(dev, &fields))
+			continue;
 
-		if (ops->get_rxfh_fields) {
-			struct ethtool_rxfh_fields fields = {
-				.flow_type	= info.flow_type,
-			};
-
-			if (ops->get_rxfh_fields(dev, &fields))
-				continue;
-
-			info.data = fields.data;
-		} else {
-			if (ops->get_rxnfc(dev, &info, NULL))
-				continue;
-		}
-
-		err = ethtool_check_xfrm_rxfh(input_xfrm, info.data);
+		err = ethtool_check_xfrm_rxfh(input_xfrm, fields.data);
 		if (err)
 			return err;
 	}
@@ -1080,7 +1068,7 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!ops->set_rxnfc && !ops->set_rxfh_fields)
+	if (!ops->set_rxfh_fields)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
@@ -1103,9 +1091,6 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 			return rc;
 	}
 
-	if (!ops->set_rxfh_fields)
-		return ops->set_rxnfc(dev, &info);
-
 	fields.data = info.data;
 	fields.flow_type = info.flow_type & ~FLOW_RSS;
 	if (info.flow_type & FLOW_RSS)
@@ -1120,9 +1105,10 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	struct ethtool_rxnfc info;
 	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxfh_fields fields = {};
 	int ret;
 
-	if (!ops->get_rxnfc && !ops->get_rxfh_fields)
+	if (!ops->get_rxfh_fields)
 		return -EOPNOTSUPP;
 
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
@@ -1133,24 +1119,15 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	    !ops->rxfh_per_ctx_fields)
 		return -EINVAL;
 
-	if (ops->get_rxfh_fields) {
-		struct ethtool_rxfh_fields fields = {
-			.flow_type	= info.flow_type & ~FLOW_RSS,
-		};
+	fields.flow_type = info.flow_type & ~FLOW_RSS;
+	if (info.flow_type & FLOW_RSS)
+		fields.rss_context = info.rss_context;
 
-		if (info.flow_type & FLOW_RSS)
-			fields.rss_context = info.rss_context;
+	ret = ops->get_rxfh_fields(dev, &fields);
+	if (ret < 0)
+		return ret;
 
-		ret = ops->get_rxfh_fields(dev, &fields);
-		if (ret < 0)
-			return ret;
-
-		info.data = fields.data;
-	} else {
-		ret = ops->get_rxnfc(dev, &info, NULL);
-		if (ret < 0)
-			return ret;
-	}
+	info.data = fields.data;
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
@@ -1528,7 +1505,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *rss_config;
 	int ret;
 
-	if ((!ops->get_rxnfc && !ops->get_rxfh_fields) || !ops->set_rxfh)
+	if (!ops->get_rxnfc || !ops->get_rxfh_fields || !ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
-- 
2.49.0


