Return-Path: <netdev+bounces-249752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9430D1D2A2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58783012DFA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAE37F8AA;
	Wed, 14 Jan 2026 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TJ5NEW9C"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1937F110;
	Wed, 14 Jan 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379935; cv=none; b=ANBAu8vsfhD6fVOTFU4t5o2EGtU9di7giVUxBr99zXFFTPINZ5n5MzLhVsHkec99Gltp1f7b91FVVHT1kFT94WbyEdYcvQttffKQxv0Ird926cPDNw0LtsvLa+vNgM+cyCXz9ysf5yVbBrhSsI4XwOhVYytE9PgdUuWHItxklsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379935; c=relaxed/simple;
	bh=s22g5+jxOqR02Qmp6OC7IGT9GLJa48aKgh4CxU2sJ3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQSdY29bKzhVnZZrvlftMugefoY7MF0jQ5cyUsbV2MXgttI5+mwibQMWLV6jYqVhw2wl3YoarwEt3kHHy/9vPsfkRTDh9hIRfdcThPkLQuk/zWyulMlJEb4OUE0rOdKjOClCHRyhCxkOqWkol9WtAu8PdPH0k+aD0yDY7ZwoGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TJ5NEW9C; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uJr0hoJSerQP2Wukbf7ZtkbcNPih8BtsQOSFE3llIMI=;
	b=TJ5NEW9C6tzCPKS6mhKZ+N5kcsegW/4uV+I9T7W6A7IJ62O56YhzBrGPkuWvroJtqSm+gq2Eo
	LrAC5jU0Mc0mfJaVBgduJk/gfXQQdM9kSVEv9/0bcAgDyOeaFRqOcndbrGlsMDKjrVeOW3pp7mc
	rG4sBdG8/xuFFzkOX8nST8Y=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4drfZ82Tj1zpSt8;
	Wed, 14 Jan 2026 16:35:12 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C96F940569;
	Wed, 14 Jan 2026 16:38:45 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 14 Jan 2026 16:38:44 +0800
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
Subject: [PATCH net-next v11 5/9] hinic3: Add .ndo_features_check
Date: Wed, 14 Jan 2026 16:38:24 +0800
Message-ID: <3879b20b7ffa20106a3f8f56dbf2d5eb389f260a.1768375903.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768375903.git.zhuyikai1@h-partners.com>
References: <cover.1768375903.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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


