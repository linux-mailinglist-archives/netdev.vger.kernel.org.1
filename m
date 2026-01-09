Return-Path: <netdev+bounces-248338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF240D0712F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E333D300E8CE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FC3033E8;
	Fri,  9 Jan 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TJ5NEW9C"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A72D978B;
	Fri,  9 Jan 2026 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931828; cv=none; b=kInb0taljJ8Ees1QlZyX5lSJNhrYZZxbdALRoeotc6uyKpe9r7kSOU76glvuEKrNCQa8qHiCfqNTOqXMIQ1Zb6JAPnomxQkstf71fL65azmbVCm9nN+dv5I3jtUYcPoaBrhI2ILCIEXJFXtDd9+KMAvhZ8aBLyaZgJzULcX4IPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931828; c=relaxed/simple;
	bh=s22g5+jxOqR02Qmp6OC7IGT9GLJa48aKgh4CxU2sJ3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmkPSoLQa8H314YdUWjt0iKHUb6zn4spFcplhk/FdLrh3FCeTzkR45bMKzM4Jsx0MSlUwQE0adooLaBMUjJaodRfmeGNl72Ya4I1H6/K6qpW1/i2z9tsQ1gfRk54YWtht5B9rkKJVxWhYr407pr5FPPAXmzrLH7PsacBpPBtn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TJ5NEW9C; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uJr0hoJSerQP2Wukbf7ZtkbcNPih8BtsQOSFE3llIMI=;
	b=TJ5NEW9C6tzCPKS6mhKZ+N5kcsegW/4uV+I9T7W6A7IJ62O56YhzBrGPkuWvroJtqSm+gq2Eo
	LrAC5jU0Mc0mfJaVBgduJk/gfXQQdM9kSVEv9/0bcAgDyOeaFRqOcndbrGlsMDKjrVeOW3pp7mc
	rG4sBdG8/xuFFzkOX8nST8Y=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dnSsM434vznTWm;
	Fri,  9 Jan 2026 12:07:19 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C7F2240565;
	Fri,  9 Jan 2026 12:10:22 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 12:10:21 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v10 5/9] hinic3: Add .ndo_features_check
Date: Fri, 9 Jan 2026 10:35:55 +0800
Message-ID: <46d339958b7765a9141b916445c6c682c54e77f1.1767861236.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767861236.git.zhuyikai1@h-partners.com>
References: <cover.1767861236.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

As we cannot solve packets with multiple stacked vlan, so we use
.ndo_features_check to check for these packets and return a smaller
feature without offload features.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 2e1ca9571e7c..87ada13b8f96 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -2,7 +2,9 @@
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
+#include <net/vxlan.h>
 
 #include "hinic3_hwif.h"
 #include "hinic3_nic_cfg.h"
@@ -624,6 +626,16 @@ static netdev_features_t hinic3_fix_features(struct net_device *netdev,
 	return features_tmp;
 }
 
+static netdev_features_t hinic3_features_check(struct sk_buff *skb,
+					       struct net_device *dev,
+					       netdev_features_t features)
+{
+	features = vlan_features_check(skb, features);
+	features = vxlan_features_check(skb, features);
+
+	return features;
+}
+
 int hinic3_set_hw_features(struct net_device *netdev)
 {
 	netdev_features_t wanted, curr;
@@ -756,6 +768,7 @@ static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_stop             = hinic3_close,
 	.ndo_set_features     = hinic3_ndo_set_features,
 	.ndo_fix_features     = hinic3_fix_features,
+	.ndo_features_check   = hinic3_features_check,
 	.ndo_change_mtu       = hinic3_change_mtu,
 	.ndo_set_mac_address  = hinic3_set_mac_addr,
 	.ndo_tx_timeout       = hinic3_tx_timeout,
-- 
2.43.0


