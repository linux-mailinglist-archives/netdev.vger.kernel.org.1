Return-Path: <netdev+bounces-196622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86EAD5970
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8266E188B9C1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8E2BDC35;
	Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk4qoIyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791862BDC2D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653996; cv=none; b=jscmQg4VCxWejR/4NhnVo7cL025NuTHwL/mXp4dH15GfMoTQx3Rhezc+Q4BBpyXewSk8chKTcNPU0Kj5cP0+5rwa8tY36l3d+2m30ApGobRvz9IcAGJ78a3Rpx1v1UZIOIc4Jo2OkFOLVdAjg284QhqWohhEPoP4Em9vptji1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653996; c=relaxed/simple;
	bh=vf0SrRqSJKsk+hxZ1lPa9n3z6RTUd+maU0he34GuoV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d006corl6RxHN5jBZuhOfd9fZ/Dn2uGoA6d0bPEokwe9buTP5SuIpG2rD7/J0wxbU+CEWZUZA0kXx1cD0etz5mKZwYWonWsOj5or8K/t/8OVkDXAOGBBAsFL/UarLNosd74uNBnDUG9t1Cx3C1oMBl3lrNL0y1dLbxLVA2s5ceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk4qoIyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4437C4CEF0;
	Wed, 11 Jun 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653996;
	bh=vf0SrRqSJKsk+hxZ1lPa9n3z6RTUd+maU0he34GuoV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pk4qoIynitagM7inLw3s/EQil0Woh+DfTa5pfgUyB3MMi2pRbcG3t9tVj5FQMIp0l
	 rRgxm5jvo8HfSU+hjeBc81hdxykMOUzQo4t+nKSmV+Nf1P42J+U4MAQCvpvdzA/qzB
	 gjL1CE3LRpVpoa6QwiRdGBkzbdVElISfz8ofiKXTsq5p6pmxoqiXGtmGz2qtArD63E
	 JxfMFbKOWAUlIxQ8Pugr6Mdb21seXv64yzxFp7mVlie8/ZLD2Xq8XuSFMzY8r7d6+n
	 qNVA4WY2MGFUTvx8rl6UNgPObBXDIDijD3SHxLwW9zqAgFKQRF7/xGK+YBNRA0/W1N
	 NzuWMucyYCbEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net-next 4/9] net: ethtool: add dedicated callbacks for getting and setting rxfh fields
Date: Wed, 11 Jun 2025 07:59:44 -0700
Message-ID: <20250611145949.2674086-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We mux multiple calls to the drivers via the .get_nfc and .set_nfc
callbacks. This is slightly inconvenient to the drivers as they
have to de-mux them back. It will also be awkward for netlink code
to construct struct ethtool_rxnfc when it wants to get info about
RX Flow Hash, from the RSS module.

Add dedicated driver callbacks. Create struct ethtool_rxfh_fields
which contains only data relevant to RXFH. Maintain the names of
the fields to avoid having to heavily modify the drivers.

For now support both callbacks, once all drivers are converted
ethtool_*et_rxfh_fields() will stop using the rxnfc callbacks.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
---
 include/linux/ethtool.h | 20 +++++++++++++++
 net/ethtool/ioctl.c     | 55 +++++++++++++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index fc1c2379e7ff..b2e71e641f62 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -825,6 +825,19 @@ struct ethtool_rxfh_param {
 	u8	input_xfrm;
 };
 
+/**
+ * struct ethtool_rxfh_fields - Rx Flow Hashing (RXFH) header field config
+ * @data: which header fields are used for hashing, bitmask of RXH_* defines
+ * @flow_type: L2-L4 network traffic flow type
+ * @rss_context: RSS context, will only be used if rxfh_per_ctx_fields is
+ *	set in struct ethtool_ops
+ */
+struct ethtool_rxfh_fields {
+	u32 data;
+	u32 flow_type;
+	u32 rss_context;
+};
+
 /**
  * struct kernel_ethtool_ts_info - kernel copy of struct ethtool_ts_info
  * @cmd: command number = %ETHTOOL_GET_TS_INFO
@@ -970,6 +983,8 @@ struct kernel_ethtool_ts_info {
  *	will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
+ * @get_rxfh_fields: Get header fields used for flow hashing.
+ * @set_rxfh_fields: Set header fields used for flow hashing.
  * @create_rxfh_context: Create a new RSS context with the specified RX flow
  *	hash indirection table, hash key, and hash function.
  *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
@@ -1156,6 +1171,11 @@ struct ethtool_ops {
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
 	int	(*set_rxfh)(struct net_device *, struct ethtool_rxfh_param *,
 			    struct netlink_ext_ack *extack);
+	int	(*get_rxfh_fields)(struct net_device *,
+				   struct ethtool_rxfh_fields *);
+	int	(*set_rxfh_fields)(struct net_device *,
+				   const struct ethtool_rxfh_fields *,
+				   struct netlink_ext_ack *extack);
 	int	(*create_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
 				       const struct ethtool_rxfh_param *rxfh,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index bd9fd95bb82f..f4d4d60275f8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1048,9 +1048,20 @@ static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
 			continue;
 
 		info.flow_type = i;
-		err = ops->get_rxnfc(dev, &info, NULL);
-		if (err)
-			continue;
+
+		if (ops->get_rxfh_fields) {
+			struct ethtool_rxfh_fields fields = {
+				.flow_type	= info.flow_type,
+			};
+
+			if (ops->get_rxfh_fields(dev, &fields))
+				continue;
+
+			info.data = fields.data;
+		} else {
+			if (ops->get_rxnfc(dev, &info, NULL))
+				continue;
+		}
 
 		err = ethtool_check_xfrm_rxfh(input_xfrm, info.data);
 		if (err)
@@ -1064,11 +1075,12 @@ static noinline_for_stack int
 ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxfh_fields fields = {};
 	struct ethtool_rxnfc info;
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!ops->set_rxnfc)
+	if (!ops->set_rxnfc && !ops->set_rxfh_fields)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
@@ -1091,7 +1103,15 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 			return rc;
 	}
 
-	return ops->set_rxnfc(dev, &info);
+	if (!ops->set_rxfh_fields)
+		return ops->set_rxnfc(dev, &info);
+
+	fields.data = info.data;
+	fields.flow_type = info.flow_type & ~FLOW_RSS;
+	if (info.flow_type & FLOW_RSS)
+		fields.rss_context = info.rss_context;
+
+	return ops->set_rxfh_fields(dev, &fields, NULL);
 }
 
 static noinline_for_stack int
@@ -1102,7 +1122,7 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rxfh_fields)
 		return -EOPNOTSUPP;
 
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
@@ -1113,9 +1133,24 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	    !ops->rxfh_per_ctx_fields)
 		return -EINVAL;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
-	if (ret < 0)
-		return ret;
+	if (ops->get_rxfh_fields) {
+		struct ethtool_rxfh_fields fields = {
+			.flow_type	= info.flow_type & ~FLOW_RSS,
+		};
+
+		if (info.flow_type & FLOW_RSS)
+			fields.rss_context = info.rss_context;
+
+		ret = ops->get_rxfh_fields(dev, &fields);
+		if (ret < 0)
+			return ret;
+
+		info.data = fields.data;
+	} else {
+		ret = ops->get_rxnfc(dev, &info, NULL);
+		if (ret < 0)
+			return ret;
+	}
 
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
@@ -1492,7 +1527,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *rss_config;
 	int ret;
 
-	if (!ops->get_rxnfc || !ops->set_rxfh)
+	if ((!ops->get_rxnfc && !ops->get_rxfh_fields) || !ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
-- 
2.49.0


