Return-Path: <netdev+bounces-170006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE96A46D1E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1E61887F92
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD725A2AB;
	Wed, 26 Feb 2025 21:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7703257440
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604273; cv=none; b=TG71b3x6Lxf206IU9EqEf0vUx90Syk/6WzSO+11sONFcBYiVwA7NJIvgK/MOmEVYwP1zV3C1yb++IPdI8is9AgWo9SErRmMSGS7wgTqjimOpiP/dBsZiM9cmETmp46iDC7AqadKX5h1jE1b7mKuowFYiWkIUWNnPRua8a3GyI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604273; c=relaxed/simple;
	bh=xlgbDJXDGLwzfjnEKxSuAGdMI572+pIRIoYrWpAd1EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9kyp1wkuR6Cl7e0r6o8ixeBecqOaDLIZFzVxRM//3Ucs4LyhWZZaAROCyEbaqDpNUmVUVWHE19Au5r9D/8VIbSRD6KkKuMiSFDsKryG5wOkh8s6MA03t+3LmjIZ4d9wwPiD+HbQrbebSq0uFf67CWvvbaDKt6i8KXOgM8K/ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c92c857aso5045885ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604271; x=1741209071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrQGQGpkhMZEwiGxI0nqs9TuNMdTxCrX+2AGTrWSNYo=;
        b=Utpz5+FUIByUDUFuHbXpDw2lMzwq9eEpYeCdNGC32PQN1P4Lbn6zhdDU6aV4h3twy/
         OyQohP8qKmBs0YD6fbYutMbX07ubiuj3ZYxhyHOR2KS3ooeqY9zxQxBB7tnyjFRIGxf+
         k+02zeXoMee7pZGWLwYeKIzdvfD6HFaZlBX4QdjjUlRDN9DwzH6VWs0gqwf/4aZVk4uL
         cfMb9ZOw9vjgOkZskOcnqU98X1ikVJvssQpZurKaOc3A2q7TYBBS3ZBn6t4ZuLUb6j1s
         bbVRb07fq3iLcWnhh4uOyK2KwL+ITykZ9DqMoT6u+m127anIjMIoWh5jDRkRaN9NRh9i
         NuNQ==
X-Gm-Message-State: AOJu0YzzvWr6HQsjqGC6KpdMIxnA/RodK3zgxrRBH2lnAlNiUfCOGzWE
	EKG+KvUrwEWHQg9OCierFVgPCT2h2ZfRgirEJrLn53nBhubKSivHqaHv
X-Gm-Gg: ASbGnct3DoRnaTW7MbW8qXl5oDnMnr3fk0yn4cApYJ89D/kFDh3BBJaLJ4WqZYuaQrl
	okWvCuuRkN0Dr9PhNijklII0dPcYTKnFoOzsQDD7gmnG19SCDLzlIvQsP6K2XZL/ThY9uUKqiGR
	9GGaj8dXalegjQYrbLTb8bx3zwzqlATU9oXDUwRsgFzg1sIA6E4vEwH+zfWzvoXR9oP+5uakxNI
	Yjg0ksQp0twUlYanGOeZDJT4SLHihkqkARGwEVi3XpflV8F58BzAHW6cBjYOVGIhrt865CsfZVS
	AjuwL6mQ25HQQLvt+KywTg/0xQ==
X-Google-Smtp-Source: AGHT+IGi6vNtB6wcF/u+FJXWbVvG+wgYwEFuIe3w85nfme2nbINsOn7fr/+4KX/jDFX1w25ZaQBldw==
X-Received: by 2002:a17:902:ef81:b0:223:4dab:97e1 with SMTP id d9443c01a7336-2234dab9800mr5467085ad.24.1740604270522;
        Wed, 26 Feb 2025 13:11:10 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a7f9b8asm4131998b3a.103.2025.02.26.13.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:10 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v8 01/12] net: hold netdev instance lock during ndo_open/ndo_stop
Date: Wed, 26 Feb 2025 13:10:57 -0800
Message-ID: <20250226211108.387727-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211108.387727-1-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
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
index 4c29739780bd..4cc8c55b8f95 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4558,22 +4558,21 @@ static int iavf_open(struct net_device *netdev)
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
@@ -4622,7 +4621,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return 0;
 
@@ -4635,7 +4633,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return err;
 }
@@ -4657,12 +4654,12 @@ static int iavf_close(struct net_device *netdev)
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
 
@@ -4715,6 +4712,7 @@ static int iavf_close(struct net_device *netdev)
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
index 9a387d456592..d074ad66766e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2724,6 +2724,29 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
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
 static inline void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
diff --git a/net/core/dev.c b/net/core/dev.c
index 3f525278a871..7b31d826a089 100644
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


