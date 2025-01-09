Return-Path: <netdev+bounces-156659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079CA07455
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368FE3A9076
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101C2153FE;
	Thu,  9 Jan 2025 11:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA189215F55
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421114; cv=none; b=CkRolQ/+ImHx60IsH39acUc6lisbABogcLXaSLyJnl35IuopQrv/w9nZP9JhjOaUd20A3shMiIbv22E+8h48OgjGpujoJG7vechF5hiFZkz+uMLkRz/Vf3vniv5cPmEJenXnbmZa7GenqyIoUwTfDKKBEPuRS0eFJrUKnROvBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421114; c=relaxed/simple;
	bh=p+8tuaA12qnzDxLXL3elomf6gRdwwAbsOoIxas4iErM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PT0zEG3YGaADXJDDy25PokXTF2KxRY8ww/2sQSUuqzUcAtAuhXV8HwGtzU9W/sHwj/8LC2X289u7CDwz2YcaQtu9UrwFO4t3w6hBhr3MJ9OE2SiyhzKpqTnH4A6UEyduwXaHS3pgxQbFySvztXn97sv4KVVHwUnPxaGftUWzQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kory.maincent@bootlin.com>,
	<willemb@google.com>, <aleksander.lobakin@intel.com>, <hkallweit1@gmail.com>,
	<ecree.xilinx@gmail.com>, <daniel.zahka@gmail.com>, <almasrymina@google.com>,
	<gal@nvidia.com>, <netdev@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next][v2] net: ethtool: Use hwprov under rcu_read_lock
Date: Thu, 9 Jan 2025 19:10:57 +0800
Message-ID: <20250109111057.4746-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BC-Mail-Ex14.internal.baidu.com (172.31.51.54) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-01-09 19:11:04:384
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-01-09 19:11:04:400
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

hwprov should be protected by rcu_read_lock to prevent possible UAF

Fixes: 4c61d809cf60 ("net: ethtool: Fix suspicious rcu_dereference usage")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff with v1: move and use err varialbe, instead of define a new variable 

 net/ethtool/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2607aea..2bd77c9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -869,6 +869,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
 			  struct kernel_ethtool_ts_info *info)
 {
 	struct hwtstamp_provider *hwprov;
+	int err = 0;
 
 	rcu_read_lock();
 	hwprov = rcu_dereference(dev->hwprov);
@@ -876,7 +877,6 @@ int __ethtool_get_ts_info(struct net_device *dev,
 	if (!hwprov) {
 		const struct ethtool_ops *ops = dev->ethtool_ops;
 		struct phy_device *phydev = dev->phydev;
-		int err = 0;
 
 		ethtool_init_tsinfo(info);
 		if (phy_is_default_hwtstamp(phydev) &&
@@ -892,8 +892,9 @@ int __ethtool_get_ts_info(struct net_device *dev,
 		return err;
 	}
 
+	err = ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
 	rcu_read_unlock();
-	return ethtool_get_ts_info_by_phc(dev, info, &hwprov->desc);
+	return err;
 }
 
 bool net_support_hwtstamp_qualifier(struct net_device *dev,
-- 
2.9.4


