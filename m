Return-Path: <netdev+bounces-177256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F599A6E6BC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990381744F1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B31F0E51;
	Mon, 24 Mar 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRX5zGVN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4714EC46
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856357; cv=none; b=JshbnsoB+WIDOj4iukKBUDM377vDN9gGPWZgw5sGfthh0VL8MxYrUpfocGs9IYPPQf+94Jc3DtjCXLbnmD+7zKX4l4sq3qKgr5WOWUBMWtEKMxZTcAT5z5InfhNN3rZ3O6gQhngiyNcQReFevJPr9G4VZwDhsWvYFhhBDlsCKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856357; c=relaxed/simple;
	bh=3TNQTLCEchXvr4LgWzTBDaHw8oUkTo4bLAcHl+BfFQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8zZIiNdqeAZf6qyPr/+ak+nMqW++zWJhRlQ5UaVH4JXY9zLNmDTSoE/dllq17HW9Eu0Bt8R/0Zfn+A+z2jRv4oYnw+LNJwCoj49fA7bwPg3J9xoiTsfLuUfOSrm7G43uGeWAeiWVedhy8ilak7HdD6BWemubOhv32UJWdAXu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRX5zGVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22007C4CEE4;
	Mon, 24 Mar 2025 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856357;
	bh=3TNQTLCEchXvr4LgWzTBDaHw8oUkTo4bLAcHl+BfFQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRX5zGVNiyEW+Qvi/Cm4CnYrUM97Ol19tIdyg+s9pqC1rWVX2Qcaq7HDm+QpmJeEz
	 xXSpBSHBPS2gliu9s94fHxasWcbE5Ns+mlE4zICpqT7Z7CA0EudHxOIsFmDa0A5vCu
	 G50A4uiwCnixkhl9uwi0dzdt+Qm9GiT1Iq/WGL0MEU9BLP8O7Zsul9QQnbThpxbqLk
	 wx8H3vzivtnZ5dStXd2CETHzvg3x5nrkz/SPYpSCxOJHJShFnHMOQAYl2SzbIblNXa
	 ZhX1IHDtXvcEksVXfgTZnaM2SFXY+p8KAcu2a+0RTQCLg12Nu+Ytos8UVDHDTHgBJJ
	 oAGXGPa1ofH+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 02/11] net: remove netif_set_real_num_rx_queues() helper for when SYSFS=n
Date: Mon, 24 Mar 2025 15:45:28 -0700
Message-ID: <20250324224537.248800-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a953be53ce40 ("net-sysfs: add support for device-specific
rx queue sysfs attributes"), so for at least a decade now it is safe
to call net_rx_queue_update_kobjects() when SYSFS=n. That function
does its own ifdef-inery and will return 0. Remove the unnecessary
stub for netif_set_real_num_rx_queues().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 10 ----------
 net/core/dev.c            |  2 --
 2 files changed, 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f22cca7c03ad..55859c565f84 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4062,17 +4062,7 @@ static inline bool netif_is_multiqueue(const struct net_device *dev)
 }
 
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq);
-
-#ifdef CONFIG_SYSFS
 int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq);
-#else
-static inline int netif_set_real_num_rx_queues(struct net_device *dev,
-						unsigned int rxqs)
-{
-	dev->real_num_rx_queues = rxqs;
-	return 0;
-}
-#endif
 int netif_set_real_num_queues(struct net_device *dev,
 			      unsigned int txq, unsigned int rxq);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index bcf81c3ff6a3..1a6e62792bb5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3160,7 +3160,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
 
-#ifdef CONFIG_SYSFS
 /**
  *	netif_set_real_num_rx_queues - set actual number of RX queues used
  *	@dev: Network device
@@ -3191,7 +3190,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_rx_queues);
-#endif
 
 /**
  *	netif_set_real_num_queues - set actual number of RX and TX queues used
-- 
2.49.0


