Return-Path: <netdev+bounces-70259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCE84E2DE
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E67289DD1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53278B47;
	Thu,  8 Feb 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jja0WIUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B337F7AE48
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401549; cv=none; b=WjUZ7XeicLN3Yc6rZwAceGQjfkUAIR2Bz3F0UZDDfysBe/TKg5WjsOl9qhVuJb5vuQ8dk94gigD6p2fL4suTzx72JD8T0p5d25SOBO2bGJqHBZmnfOdVMtsAOleo445LDTfadGWMPD++GasCqTKM0ykPRLsBVmGskKBpM4RSNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401549; c=relaxed/simple;
	bh=SwDFr3U2rPeF2hWWNUiqbC0QXPxvAE5vSYFtdA3Js50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAm87nN1iQpJf6fqjur9ubHQ7XkzO2+hfJE7cmLoZTHoN2WhPVZtM6tCdl0TfZNvIcwDMaNh3e1U1t8PKHLBWbJNRC59+cdJfAJuaMs0WRJfOLF4/bfFN8+QX4OiXJcIJ3Z86QoVASaoUHanYN4C7+GgH4yDtgRGiIGc4U0ksEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jja0WIUU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so14040997b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401547; x=1708006347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY6NVRYFT70uw+pOqEAvhmYGu+N2ydDZyZMjn8nLKEI=;
        b=jja0WIUUwaKn5fJAItvQJi3+6qCv8o137isfqyk4SRls/8nVp2Bj+smmNR0mGmms7y
         v4z+ZsLFIRLbBCpoOa9SQET1Ptut3/ztHGCXPN+Cg+gTdl6EgQfSjn5QHYivj/2brqV3
         XD7EiuAG9sDfsJppA99y6kcT87BPxttsCyA7HuPKB76khPa78et/qrjq46C9NXPDdhza
         +wz3As89wvep2oHkZhCMYPb+KiBU/ORdBJtVacoBYkHwE1qwcUZwT5Ct1H6RHbPg5Tb/
         eMLUPokGIOkuRYT4VXoy8sz6EA3bVRfE6NKokOzClU0RrG58Oo/YuNvFPilGIiIdmUX9
         kZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401547; x=1708006347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xY6NVRYFT70uw+pOqEAvhmYGu+N2ydDZyZMjn8nLKEI=;
        b=OJchm5Iuj9fqZNTo5MHQUsD3ANKm9MRhfQtRy+bD/PWUiiuguZQF/sYEuPul7Xl7ua
         nyoOY8MI6xPl5CurTAeB4wLMxLbli1xtZxmwij/iMm/twAuMfjyJrQ2YlSMuGXFjPwJM
         AZdWIIVoSgUb6T4/oMyUPv2TEps/T9CElXDnbThgCPjlZEELH7KnC2ixl3kastlA9y9B
         wdYKJZZfLwXUKJ8knm+8/e2AyIVaRM8UE68JfTKkELeiWYugw/EBdHUuXNAGcldOBaUS
         04du4aLcTxLag/0KVUSlpNyRCXz6noB463VQnWUTjGUsN37sxBkAlhfJyPpiaWLKpVF3
         cgGw==
X-Gm-Message-State: AOJu0Yx9f5mBowmvUUQAFfil5u/cS2oG6U0hmpD5IBL1a3+oa5FU7FzE
	GjgCTg3zoPMxXnSQN0gDbfyZtcuv4MQUVjx2nS3WhY+8BnxQCrM1ryImK1whtKQZXAFD9r91rAI
	dkfDXi8hqUQ==
X-Google-Smtp-Source: AGHT+IFvam0nqcstrIhnuYng8paHl9bNReGlCMQFMly0uhXP4KcYQp3MB1RcOJ6hyMOVh7Wd3GY1pqKcqXyF/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:e254:0:b0:604:982c:3c26 with SMTP id
 l81-20020a0de254000000b00604982c3c26mr491501ywe.3.1707401546796; Thu, 08 Feb
 2024 06:12:26 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:50 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/13] net: remove stale mentions of dev_base_lock
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
2.43.0.594.gd9cf4e227d-goog


