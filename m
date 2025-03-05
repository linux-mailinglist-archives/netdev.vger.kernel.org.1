Return-Path: <netdev+bounces-172137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5AA50512
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C43162AAC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404A219885F;
	Wed,  5 Mar 2025 16:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693311779AE
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192658; cv=none; b=T8JVsJa3ETgTnIFwCIGtpnc7nF+zgPrMX5BUR1sKyE5l79rssI7VnQ3qB5O4EU7gaGP0EtMrbpyUyDnD/CXlzNYgSHrDmEfHsvzBWCnBTw2WFDwDZbragYZZgd9WuoceiPVwphVnn2h6lvYRL0Wsa3RSjVslwXPny5+vTVng2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192658; c=relaxed/simple;
	bh=79I/ZdtUus6Uyvuy4JWaX0g5E4W0zdowAoaNCVxI0Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqXGrnAevkyNZ2E8wYs3QCBLMHNDMOWOwY+kDLCX1dKbjhM1eQego+aCOGEjVJVTtJPUU5lvo3009WZQrmCB21I2a2kzQfVk9Hk73B3FgLmvBa9DSf0izXC6Os6a4LVP8GFcTBYiEopnltxSgFoGb/6ZkxKgc7X8EwhDWQ+TdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso10568875ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192655; x=1741797455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uSHSMLcQQbwM8PwEkajortsqD+nyQIU36wLm/2ezF0=;
        b=kEL6Ruiqx335/LW12S8O28oWAUsMQEuG22lXO+p39zWNERkiDw47vH+0W5gPwEt9mo
         P1MPJLzULibimwWrTYfEcdZLPXMnhkrnZ5LBI600eE4K7VfyOvZe13+YiWFZG1s/oyup
         aJlPU1T9ULYb3fNT8SafGXZQsfV3SfTY2rGlK3J1Xai9JwtZwI/6dqLaujWUNCAotjX7
         5kBWwiUs9K1MQW7WRInUppdS+QkKi2Inb/p7fEi96SXrYAh5K98JIwywdGa0c/OyY6Xs
         WeghcLHwQp53n0czaeHyVv3cj17hf8L+M8hJ+BuG6QRM8JSE12w42ZUu+42+8zeSTHki
         nPtQ==
X-Gm-Message-State: AOJu0YwY6Ha9k2GkraZAvH9/mcIpuYlkygAaGMvrHPxH7ySlzxn097oi
	oNWHtnchXEuDR1Zp4Ih9ixDXWDdW5G6+hm7cePFyOjbcQ0YuGfcWQw+o
X-Gm-Gg: ASbGncsDMmslufhOY94ESiPdTacrYhLcr6UQzm6Snhoy4ZyPGZ8gJ26/3n+nrAbkqjT
	3ZDIvVTJLQUzj+Ie2lKh4llxzr2mFyy/vC6g/8oECHTGWrLOQMFG0Te2xVBdMV63l6vHhM1vgLd
	t0AxhaWncauy2EdPD/ixUwfoWVUqR2gHRIVvuR2mVFEO1dqQcHlRwbZYuNXW9P+WAL5xPLet7Tf
	zUAgcX6z2Ty2rmRp9VemT0xH6zDflGrpmVd4EArBMeVfh6S6nUk0JK+DMO+DJ6MbbFHaN2gXQgt
	6P9uMw3F+XSdgRUr9aDRIC4qOOZkJuL2/4HFlmN90xaS
X-Google-Smtp-Source: AGHT+IGHMNd41JW4xsMe5SanoKPk+E+Ci2AUAOIqOO6/Es9Tp/vJBih3lO1SIi/Aiwhq6wFL3gqbSw==
X-Received: by 2002:a17:902:f64c:b0:223:432b:5932 with SMTP id d9443c01a7336-223f1d1690amr54327595ad.51.1741192655316;
        Wed, 05 Mar 2025 08:37:35 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7362e3b1c61sm9838978b3a.22.2025.03.05.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:34 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 01/14] net: hold netdev instance lock during ndo_open/ndo_stop
Date: Wed,  5 Mar 2025 08:37:19 -0800
Message-ID: <20250305163732.2766420-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the drivers that use shaper API, switch to the mode where
core stack holds the netdev lock. This affects two drivers:

* iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
         remove these
* netdevsim - switch to _locked APIs to avoid deadlock

iavf_close diff is a bit confusing, the existing call looks like this:
  iavf_close() {
    netdev_lock()
    ..
    netdev_unlock()
    wait_event_timeout(down_waitqueue)
  }

I change it to the following:
  netdev_lock()
  iavf_close() {
    ..
    netdev_unlock()
    wait_event_timeout(down_waitqueue)
    netdev_lock() // reusing this lock call
  }
  netdev_unlock()

Since I'm reusing existing netdev_lock call, so it looks like I only
add netdev_unlock.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
 drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
 include/linux/netdevice.h                   | 23 +++++++++++++++++++++
 net/core/dev.c                              | 12 +++++++++++
 net/core/dev.h                              |  6 ++++--
 5 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 71f11f64b13d..9f4d223dffcf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4562,22 +4562,21 @@ static int iavf_open(struct net_device *netdev)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	int err;
 
+	netdev_assert_locked(netdev);
+
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
 		return -EIO;
 	}
 
-	netdev_lock(netdev);
 	while (!mutex_trylock(&adapter->crit_lock)) {
 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
 		 * is already taken and iavf_open is called from an upper
 		 * device's notifier reacting on NETDEV_REGISTER event.
 		 * We have to leave here to avoid dead lock.
 		 */
-		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
-			netdev_unlock(netdev);
+		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER)
 			return -EBUSY;
-		}
 
 		usleep_range(500, 1000);
 	}
@@ -4626,7 +4625,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return 0;
 
@@ -4639,7 +4637,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return err;
 }
@@ -4661,12 +4658,12 @@ static int iavf_close(struct net_device *netdev)
 	u64 aq_to_restore;
 	int status;
 
-	netdev_lock(netdev);
+	netdev_assert_locked(netdev);
+
 	mutex_lock(&adapter->crit_lock);
 
 	if (adapter->state <= __IAVF_DOWN_PENDING) {
 		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
 		return 0;
 	}
 
@@ -4719,6 +4716,7 @@ static int iavf_close(struct net_device *netdev)
 	if (!status)
 		netdev_warn(netdev, "Device resources not yet released\n");
 
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 	adapter->aq_required |= aq_to_restore;
 	mutex_unlock(&adapter->crit_lock);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a41dc79e9c2e..aaa3b58e2e3e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -402,7 +402,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
+		netif_napi_add_config_locked(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
@@ -422,7 +422,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		__netif_napi_del(&ns->rq[i]->napi);
+		__netif_napi_del_locked(&ns->rq[i]->napi);
 
 	return err;
 }
@@ -452,7 +452,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 		struct nsim_rq *rq = ns->rq[i];
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
-		napi_enable(&rq->napi);
+		napi_enable_locked(&rq->napi);
 	}
 }
 
@@ -461,6 +461,8 @@ static int nsim_open(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	int err;
 
+	netdev_assert_locked(dev);
+
 	err = nsim_init_napi(ns);
 	if (err)
 		return err;
@@ -478,8 +480,8 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
-		napi_disable(&rq->napi);
-		__netif_napi_del(&rq->napi);
+		napi_disable_locked(&rq->napi);
+		__netif_napi_del_locked(&rq->napi);
 	}
 	synchronize_net();
 
@@ -494,6 +496,8 @@ static int nsim_stop(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	struct netdevsim *peer;
 
+	netdev_assert_locked(dev);
+
 	netif_carrier_off(dev);
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ab86ec228b7..33066b155c84 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2753,6 +2753,29 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 		netdev_assert_locked(dev);
 }
 
+static inline bool netdev_need_ops_lock(struct net_device *dev)
+{
+	bool ret = false;
+
+#if IS_ENABLED(CONFIG_NET_SHAPER)
+	ret |= !!dev->netdev_ops->net_shaper_ops;
+#endif
+
+	return ret;
+}
+
+static inline void netdev_lock_ops(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+}
+
+static inline void netdev_unlock_ops(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+}
+
 void netif_napi_set_irq_locked(struct napi_struct *napi, int irq);
 
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
diff --git a/net/core/dev.c b/net/core/dev.c
index 2dc705604509..7a327c782ea4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1627,6 +1627,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		return ret;
 
+	netdev_lock_ops(dev);
+
 	set_bit(__LINK_STATE_START, &dev->state);
 
 	if (ops->ndo_validate_addr)
@@ -1646,6 +1648,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 		add_device_randomness(dev->dev_addr, dev->addr_len);
 	}
 
+	netdev_unlock_ops(dev);
+
 	return ret;
 }
 
@@ -1716,11 +1720,19 @@ static void __dev_close_many(struct list_head *head)
 		 *	We allow it to be called even after a DETACH hot-plug
 		 *	event.
 		 */
+
+		/* TODO: move the lock up before clearing __LINK_STATE_START.
+		 * Generates spurious lockdep warning.
+		 */
+		netdev_lock_ops(dev);
+
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
 		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
+
+		netdev_unlock_ops(dev);
 	}
 }
 
diff --git a/net/core/dev.h b/net/core/dev.h
index caa13e431a6b..25bb9d6afbce 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -134,9 +134,11 @@ static inline void netif_set_up(struct net_device *dev, bool value)
 	else
 		dev->flags &= ~IFF_UP;
 
-	netdev_lock(dev);
+	if (!netdev_need_ops_lock(dev))
+		netdev_lock(dev);
 	dev->up = value;
-	netdev_unlock(dev);
+	if (!netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
 }
 
 static inline void netif_set_gso_max_size(struct net_device *dev,
-- 
2.48.1


