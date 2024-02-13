Return-Path: <netdev+bounces-71184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF27852908
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BB42843F1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0817999;
	Tue, 13 Feb 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ3dkF7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9617981
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805985; cv=none; b=hDsXveKGgUaD4mDceLcbZu2kY8gepHLpubwFbaI5L5EbIv8hMA7sVsj3Rz1JnjcsPx4mCae3sVwY8ZcYNQidJX8v7D4n+864rxDOhmsT0rDyWXr30Zo1FVNyTUtNZJqTJg0qjmNc4emhxmS31lzn11RX/3fOvAC0pGddJ5sbiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805985; c=relaxed/simple;
	bh=bkA6LpEyf4ynruGmcKu4Fn8AVdk38mhPKYfrv2KW6vA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3Fj6D3TZsLhGLdv1J7+w+5utuH8YemWzRdQzXYLgS+K9b4jtmvXsJsxfTxPZMd5Xx6bDeaxjSWiqUq4ASGYpHBG73Qml+kTkBr11KJBGngK4dSi8vVZ3dVw5eNdwsebWnRozolTAB9lCwJ+nRkbKkWwTSY0cwvtN3mfuDWrKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ3dkF7j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so4779327276.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805983; x=1708410783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYMUVb5DAWkrWMbDjui3feJfJ97QtmDCkRsv3LxWbBk=;
        b=aQ3dkF7jSqlHI/oEN1PDdGWJXN0d3OdYwW/V97VC+5OuNWZw0frSoFsl8IUlicZJUA
         647mtJyEaSbnR1yhVxp5z9DlWD+So3WDga4YCgdiIFGnun8die2TVTEhufGOBCxqRgkl
         kkZcuuL29TONEjrk7j0bip0i/aUeS8tBhd88uWXp0op0u+tFPGf/8dpiD2bn0RZpxC7W
         LunrsQgFh2pd/1QgGDzA5vJn8gTotBtIgssTRCrHxTnfyoYqZMHwmYFRrEHKzIi01nUS
         TFMLngmLFE3VyDt9t36cpkbkrLPsq1rH/qrBnc/xWL+iI4UTGDZVAtk78DboNayVI/nX
         R4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805983; x=1708410783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYMUVb5DAWkrWMbDjui3feJfJ97QtmDCkRsv3LxWbBk=;
        b=HuqRiydo3jdSc2kVYvP/GGAErhoi82UjeKTC8cvEx/x675oJ+evONP5HVvZix/rKbN
         iCYedGfxhBCpPUYcm1n1wvqRTv5HRxKJOVicwxsul2Bk8I59nBSfF5EaqzjeZXFewAe5
         wsuPggfwRSD355da9AgREKvyJkL3p+srRHVRrRXz7xVXPPBCzpcIPYhnQE3Do4HLCmw0
         qxUCaXYlfmDjJiE7NBmru1nkPnJjhCvtZsQtZYaNbeLfAdmMxJ4E30cbsjF5TGI9FRsO
         vbH5Y554/srFZbMrTIaixGaNSgKPt+5JEDEONmGExHMecmefaKzRMedVc6v7oFqtAfDV
         RsOQ==
X-Gm-Message-State: AOJu0YzR9lVd5Px8bRDxIXeG2G9IP2kP1GcNGrchFrA4ti0Pm+NATPLa
	7z1xRm9W+kIXObrSYnSNj4JiLwTh0XH6skmEhNfuBlG7l5DJejZCe5Vz8JAGUR67ba5QeIpiWXP
	wFCh9HgNfbQ==
X-Google-Smtp-Source: AGHT+IEsyEsZrboGb3IjNBOnlsh/6DUPO6iPHajuvNu+T0QcjZObLYkiOPSRfzxuJ0lYwMWdxepY+cWHYooJMA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1887:b0:dc6:c94e:fb85 with SMTP
 id cj7-20020a056902188700b00dc6c94efb85mr327519ybb.2.1707805983478; Mon, 12
 Feb 2024 22:33:03 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:41 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-10-edumazet@google.com>
Subject: [PATCH v4 net-next 09/13] net: remove stale mentions of dev_base_lock
 in comments
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change comments incorrectly mentioning dev_base_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/netdevices.rst     | 4 ++--
 drivers/net/ethernet/cisco/enic/enic_main.c | 2 +-
 drivers/net/ethernet/nvidia/forcedeth.c     | 4 ++--
 drivers/net/ethernet/sfc/efx_common.c       | 2 +-
 drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
 drivers/net/ethernet/sfc/siena/efx_common.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 9e4cccb90b8700aea49bb586ca0da79f2fe185b9..c2476917a6c37d9b87e8b5d59f2e00fa0a30e26a 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -252,8 +252,8 @@ ndo_eth_ioctl:
 	Context: process
 
 ndo_get_stats:
-	Synchronization: rtnl_lock() semaphore, dev_base_lock rwlock, or RCU.
-	Context: atomic (can't sleep under rwlock or RCU)
+	Synchronization: rtnl_lock() semaphore, or RCU.
+	Context: atomic (can't sleep under RCU)
 
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 37bd38d772e80967e50342f8b87dfa331192c5a0..d266a87297a5e3a5281acda9243a024fc2f7d742 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -872,7 +872,7 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-/* dev_base_lock rwlock held, nominally process context */
+/* rcu_read_lock potentially held, nominally process context */
 static void enic_get_stats(struct net_device *netdev,
 			   struct rtnl_link_stats64 *net_stats)
 {
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 7a549b834e970a5ac40330513e3220466d78acef..31f896c4aa266032cbabdd3c0086eae5969d203a 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -1761,7 +1761,7 @@ static void nv_get_stats(int cpu, struct fe_priv *np,
 /*
  * nv_get_stats64: dev->ndo_get_stats64 function
  * Get latest stats value from the nic.
- * Called with read_lock(&dev_base_lock) held for read -
+ * Called with rcu_read_lock() held -
  * only synchronized against unregister_netdevice.
  */
 static void
@@ -3090,7 +3090,7 @@ static void set_bufsize(struct net_device *dev)
 
 /*
  * nv_change_mtu: dev->change_mtu function
- * Called with dev_base_lock held for read.
+ * Called with RTNL held for read.
  */
 static int nv_change_mtu(struct net_device *dev, int new_mtu)
 {
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 175bd9cdfdac3ac8183e52f2e76b99839b9c2ed7..551f890db90a609319dca95af9b464bddb252121 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -595,7 +595,7 @@ void efx_stop_all(struct efx_nic *efx)
 	efx_stop_datapath(efx);
 }
 
-/* Context: process, dev_base_lock or RTNL held, non-blocking. */
+/* Context: process, rcu_read_lock or RTNL held, non-blocking. */
 void efx_net_stats(struct net_device *net_dev, struct rtnl_link_stats64 *stats)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index e001f27085c6614374a0e5e1493b215d6c55e9db..1cb32aedd89c7393c7881efb11963cf334bca3ae 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2085,7 +2085,7 @@ int ef4_net_stop(struct net_device *net_dev)
 	return 0;
 }
 
-/* Context: process, dev_base_lock or RTNL held, non-blocking. */
+/* Context: process, rcu_read_lock or RTNL held, non-blocking. */
 static void ef4_net_stats(struct net_device *net_dev,
 			  struct rtnl_link_stats64 *stats)
 {
diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
index e4b294b8e9acb15f68b6597047d493add699196f..88e5bc347a44cea66e36dcc6afe10ef10c1383fa 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -605,7 +605,7 @@ static size_t efx_siena_update_stats_atomic(struct efx_nic *efx, u64 *full_stats
 	return efx->type->update_stats(efx, full_stats, core_stats);
 }
 
-/* Context: process, dev_base_lock or RTNL held, non-blocking. */
+/* Context: process, rcu_read_lock or RTNL held, non-blocking. */
 void efx_siena_net_stats(struct net_device *net_dev,
 			 struct rtnl_link_stats64 *stats)
 {
-- 
2.43.0.687.g38aa6559b0-goog


