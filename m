Return-Path: <netdev+bounces-245932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF65CDB122
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F07B3009942
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60925A2C9;
	Wed, 24 Dec 2025 01:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257920298C
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539382; cv=none; b=Wp/9ta1soLyPU0hh7XeWTcQYMlR+5GG3GcxSWBv+CunEM4pIyQMIMngyPSam6DTHOiKVjtKat0js4lYj3V0wWVlko5E7VIPNDtd0L7SwN1Q7ZshIDm02lYZ46uyY1jBzM8zmdCDLd5lmZ2e0EVdEv4z/156GjURmsBKvKjzzrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539382; c=relaxed/simple;
	bh=jSXEVmSFxZeuqnQ56lZ4aqg1k3qJbQPk3zoaXFm9238=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+MO6SSWH2wEWK+Hp7+G8f/i3mwnLYhnGIYthIVKk74PxkHiYpTRALQ35EM3Nd8dXUMr+lmbgqUhRb4wKJbtEQUDyswn0BI8Ce76Xblym6Jb7ke7ZddNGdsfXvwSfeeKzs7TULSUiYs+nsPIP9TfLhAlmdDAcdszGkF1Vl8kxcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dbYym3HsNz1YQpmG;
	Wed, 24 Dec 2025 09:22:40 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dbYyl1dkwz1YQpmG;
	Wed, 24 Dec 2025 09:22:39 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id CF641363A1B8;
	Wed, 24 Dec 2025 09:18:09 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 24 Dec
 2025 09:22:39 +0800
From: Di Zhu <zhud@hygon.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net v2] netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates
Date: Wed, 24 Dec 2025 09:22:24 +0800
Message-ID: <20251224012224.56185-1-zhud@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Directly increment the TSO features incurs a side effect: it will also
directly clear the flags in NETIF_F_ALL_FOR_ALL on the master device,
which can cause issues such as the inability to enable the nocache copy
feature on the bonding driver.

The fix is to include NETIF_F_ALL_FOR_ALL in the update mask, thereby
preventing it from being cleared.

Fixes: b0ce3508b25e ("bonding: allow TSO being set on bonding master")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
/* v1 */
Link: https://lore.kernel.org/netdev/20251216085210.132387-1-zhud@hygon.cn/

/* v2 */
-update commit message
-modify the code as suggested by Eric Dumazet
---
 include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5870a9e514a5..d99b0fbc1942 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5323,7 +5323,8 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 static inline netdev_features_t netdev_add_tso_features(netdev_features_t features,
 							netdev_features_t mask)
 {
-	return netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
+	return netdev_increment_features(features, NETIF_F_ALL_TSO |
+					 NETIF_F_ALL_FOR_ALL, mask);
 }
 
 int __netdev_update_features(struct net_device *dev);
-- 
2.34.1



