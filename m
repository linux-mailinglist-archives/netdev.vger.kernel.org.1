Return-Path: <netdev+bounces-69847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21B84CCB5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20EA1C254E1
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD877F477;
	Wed,  7 Feb 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4T4Cilf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A237E78E
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316012; cv=none; b=hyROjjkF2fpqpl7cPhNHP0IE/LGj3bkfqVPLvSIy8nbODYGUwrT5abDSpJ/IWJyQwIRq/EWF6huSHzW1lXGLAao5cPXhj3Hy0BPiAdfzlXmgNaBH4h7bTwHO2eu/bkUkdL5j2epg/bSzcfGlSUKVXI7oydO/LcHarPAdkzN9suw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316012; c=relaxed/simple;
	bh=SwDFr3U2rPeF2hWWNUiqbC0QXPxvAE5vSYFtdA3Js50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLeuwfFDU35Zj8utcshQ168aYvzrCmXzOqLzUfxla3VVdc3Zr2mhKsyq3EWQfPnLSNhypcfq/lRHI/syiuHQCP9gYxwr8TkkEhEKeckfMSBeiBNl6J7tTvFuqKfcPulJ+fVOatqjVZPj05pw2a2DgJgFNnw+hOPaEZofej3d4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4T4Cilf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6fcdc1so10055447b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316009; x=1707920809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY6NVRYFT70uw+pOqEAvhmYGu+N2ydDZyZMjn8nLKEI=;
        b=p4T4CilfANRtgUy2BLbLy1OovlTiFiucRHfZCNFonPu2BfA3W9t1cXN3bSvCFsEW+R
         N07IsAo6QMNZVgoxMZ8j/NYB+u8McLfuTncD1FcSjFO6k29ENomZeyhMTIrc+UXAf3Rm
         tPzEgD5//x19UPVjJNYcWT8uVCX7k234fbc1bD2gcNe8ffBkmjFkSHvyRhw0YQdjLx+s
         JFHM9gLmblNpECEr0r2JwbCSqmy/4VAXCA0h3EbdrYVlExFHXAqcxApJHetGBWZ5QTN3
         DOxYlyXrCIDy8BuhBeGuvcddt2RXo712l4VPKtqHXyvKTgZjQ14RDijeE1W1hbthWBHS
         RORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316009; x=1707920809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY6NVRYFT70uw+pOqEAvhmYGu+N2ydDZyZMjn8nLKEI=;
        b=Yjthda/V56qxLm58tL0siWdhFqe+xN76hFOJsvh4eK+UBxj06vgXT/PITJBP85QztM
         pbX+ritlsat3gQA7KisQCpKrWE7+qbfT18a7KG6qgFS/WaiWpHcslIry6WCQaqLgyWXR
         BHRivJ8gTAgtWZIVZYZ6/dBxb9iUyRcDOFnY3Ptxksqv5GPHU5beJq7y3+5P2UlhkPfH
         K67Kt8WmqNIbw31vumYvmzlV+PdulqDiQAy9/4qkDCv/AhLjsSq3nathDre1WPRZpJmt
         5kFrrO8biLIQEzo9Wn826btkXddzxEYpCMLU5M9ZR3qnjZfIhIRuazAzPbvNX1ilyfUO
         +/6w==
X-Gm-Message-State: AOJu0YwTNP3DcdV7gMPYyE6pcOJr03AHiQhpPnPNj6KyteAvPLujZ+EH
	nY3CrpmyghAu05uVCPpYyyMPAhbRlDZyG2+ZaSqbRsz6NUqcTSPGrNoQTJbL/+oI/uzyNbJLPq/
	mVK/6dOQVoA==
X-Google-Smtp-Source: AGHT+IGj1+KXTOtFNltSNiOpXQME2HHlAGPI93Egj8675sP0JAZgc4XBwBAZEY+h4sJ+aIDYx8m0i3NbqUupnA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:248d:b0:dc2:3cf3:5471 with SMTP
 id ds13-20020a056902248d00b00dc23cf35471mr191490ybb.6.1707316009256; Wed, 07
 Feb 2024 06:26:49 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:25 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-10-edumazet@google.com>
Subject: [PATCH net-next 09/13] net: remove stale mentions of dev_base_lock in comments
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
2.43.0.594.gd9cf4e227d-goog


