Return-Path: <netdev+bounces-244911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4CCCC1BBE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23BA3049B1C
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F331DD97;
	Tue, 16 Dec 2025 09:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF72367D5
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876507; cv=none; b=H7Y4udKSzmkoYIDFebHbvdtunjeRA7nA5MX3sL9yz72Gn0EreUBzjRbgX9alIvsJd7f+/1XpxuwfkPXEy5GGi7lj7TGs/1i7Toszknqk06GntLbNfXJd8Et/B1jSH2ha1L0CdxeBIxuWTLztpd7DLixIJPNcuzSt6gr/umFRyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876507; c=relaxed/simple;
	bh=8Kh8xWAxD5HPy0jKubMNvaGktf0e442TkeHOv8qpSQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pRgV3/pirFjbdQ3euECneuq2iAO/VWnlCrKOmEN9Nw9TVs25azmij3t5NJE9YvAYhUBZhW/uw404Nl5No0+5nuIOF42b9tW0TqssJEg5P9HABF1GTIKngNDXO34DzQqf9EwNi2U9Q97HGKPGLf5u3VtPgukkH7/fBIrd01epGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4dVrKP1dcfzvMBs;
	Tue, 16 Dec 2025 16:52:25 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4dVrKP1DMRzvMBs;
	Tue, 16 Dec 2025 16:52:25 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id D898C300B6F1;
	Tue, 16 Dec 2025 16:48:04 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Dec
 2025 16:52:24 +0800
From: Di Zhu <zhud@hygon.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net] netdev: increment TSO only if TSO is not enabled on any slave device
Date: Tue, 16 Dec 2025 16:52:10 +0800
Message-ID: <20251216085210.132387-1-zhud@hygon.cn>
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

Unconditionally increment the TSO flag has a side effect: it will also
directly clear the flags in NETIF_F_ALL_FOR_ALL on the master device,
which can cause issues such as the inability to enable the nocache copy
feature on the bonding network card.

So, when at least one slave device's TSO is enabled, there is no need to
explicitly increment the TSO flag to the master device.

Fixes: b0ce3508b25e ("bonding: allow TSO being set on bonding master")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
 include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf99fe8622da..2aca39f7f9e1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5322,7 +5322,8 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 static inline netdev_features_t netdev_add_tso_features(netdev_features_t features,
 							netdev_features_t mask)
 {
-	return netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
+	return (features & NETIF_F_ALL_TSO) ? features :
+		netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
 }
 
 int __netdev_update_features(struct net_device *dev);
-- 
2.34.1



