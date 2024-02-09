Return-Path: <netdev+bounces-70640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4C84FDB2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC18B2990A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B089168AA;
	Fri,  9 Feb 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMox9x5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1D171D5
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510912; cv=none; b=n6Qvvk4+dsbxi6pmT3hXzcsPwSZsZ7BiR/3ZF8I+Ul5/rjZL8BbWnT2BzhajOulj0mPWK1Q7srxAWi8EA07JXpE+U7gMTXxNm9zxKOcc2xiLC6tBOIAh3YYrUpBeHsObmXQHBU6GahmmaOgU/M4dvJMPF6v/n2tS2g/mg9grnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510912; c=relaxed/simple;
	bh=bkA6LpEyf4ynruGmcKu4Fn8AVdk38mhPKYfrv2KW6vA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nwntdkc9itj8DG/UgWE1A+6ot7bxkyowq9cT6MlNjnh4JXEbfJ7E8YsXE4kAWi+F422G/1j8p207o6eDlSla/yavertWwS2G7XRXSU2O1kBd9SRBkVl926AEHYHzMImJttpNgJk2/Kd9pKhyPa/AKcBl8PeDQBex/Z8E1KSbs84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMox9x5S; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78346521232so172839785a.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510909; x=1708115709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYMUVb5DAWkrWMbDjui3feJfJ97QtmDCkRsv3LxWbBk=;
        b=ZMox9x5SAGwuiSgKrYF2wnuWTLlBv/MXcaZN/HnVyZM+B+19a0skBix/+aqdUSMTHY
         wlXMCeDWnwNcrm9VSWm4w8LFdioWhzbEGB9XDEwxp2can0HXNaTpuco5oAuMioiZ/xor
         tAZWcy6rIucukw+PDcA1jIGIpEzWPWp5DY0j6mliNmfnLqDGyCn52rqUvD0HGcZYMVur
         yb8h2Ea8k8+yIYMpiqv2idvszor4zwDzRyN1jn+wBiF+gkNQPPtGlMiNY83AlRcuB9Y7
         gQTvYK39MFEqTarESa10tyL0bnWhNOd5P9WH4LVz8XH50p0JVBuSvyFWh10KBawUjsDy
         n2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510909; x=1708115709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYMUVb5DAWkrWMbDjui3feJfJ97QtmDCkRsv3LxWbBk=;
        b=BeeXr8iz7uQl1iFbap2LAxMHWlWepfUg1WEKZppgMXs5OEBISfKzO2SZwKZqPhWqEJ
         Aw5S/6L5KHii/QV0QsJly1YoS7V0emhoxsctPbktqSs/XkgyFf6wQYiCPBCFLKuB4lfo
         D94OmyOLHBCvIwfBiXQX5rkvULisnORebvHMPfGds0GvHWlCbWCAnmtNITljLP52CAUs
         kC27456yZlD6uok4LPvJICeI8xs6jBZJKS5cvlGWD1HEiaApY2wuGzKfgkZbFFyJq933
         wlASfFceOaQCy6PcQ7c0fFasXgYLVgly87w36FaRVNgspfjT6WDC+0ujQ7EjFUZ5kOSe
         1dkQ==
X-Gm-Message-State: AOJu0YzWoOrhDJzLogilWZ575RbmdlcmGmJJ2dt0z/qUjzajkwfs/H7y
	aOUFSOoD7Mewdx8/V5mgtnF96gv/hkUTfjSdxRmnQgntXcHcSmH5QxQ9D33pI+ueoJZ67Qu2Mc4
	FzQ1hR6SHKw==
X-Google-Smtp-Source: AGHT+IFgfzmEx1ExbjzMny7/b+5jiz404bTwOcywy7Rmt27gnliwdw+1zmIpzNxqRYihGr2ml7FCOLdkR8QFXA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:6189:b0:785:ae7c:1530 with SMTP
 id or9-20020a05620a618900b00785ae7c1530mr647qkn.2.1707510909781; Fri, 09 Feb
 2024 12:35:09 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:24 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/13] net: remove stale mentions of dev_base_lock
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


