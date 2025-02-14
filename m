Return-Path: <netdev+bounces-166470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A307A361DE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973EF170E3D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B5266EF0;
	Fri, 14 Feb 2025 15:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477AA266B64
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547286; cv=none; b=BTLAV2arZ6jvXDzudNqimPil02aaN40FqYDQDUXr8p6OSz+xmQmxoSIMM4PXBG8c6iSiak2uihFmvtZFt4z2pezLBTqRW0qpEJNKPB2e9E0NZKP+nRFu+3p+RQuQNZnJW87optvMxHvd4oo1A+Zl/NdEpOUvQpHrNezVSudltww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547286; c=relaxed/simple;
	bh=offnW4kd5kDrv1ZsWuym9MVPN9wm6CvKsz1fLxTx7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCaUxH6opQHceeEF14JhhtwFguVm80KsaboeWV7idN6chSHPexs4toYOR9sh0yD1flPN/Q8THMMRQ8QEXjK7Cd0vdq1hd91sKRAyyYNUnInXKrU8BpbcgKPO5t+/Vjb7dHIwqCGNiR1vX9gRnAhHOqsSnb8NH7JS2U3yf1sApXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso1826281a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547283; x=1740152083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=livm1DlHdAm05hDUwd++yeSftV5vCtYGz/ux3lSOPaQ=;
        b=ffc+Gx+i196EkSwb4CV4TwABhQVFAxxT5Zyj/oTUCix7DhmFudX60a8NdgVZIKVY24
         JeFj0UoVifZESJsDxQxBfS44CYdYLyGsu9QDzzvVuigfywOIy6VYpdb8oZErvFpUgQZX
         QatIgDtMQ1636j6tlOPkVaCJ13svAmNVM8mRXJZyOe+FLmsuqU+ZiIO3gfZaYqSwfY25
         oZ2cM0/Ow8ia2tkn2WAiQC5+aV5hXB1Pf4u/i96K6FVJmL8yQig21vXdIVuXc8IKBMoA
         JNa8EGsI1zq0QA3hHdSv8ydR55kozliTg6qTgjDbjL/2WTr/IqEkzpSOd5gs+eeMbm3R
         jZJA==
X-Gm-Message-State: AOJu0Ywc/NygRa4poM/y22FEIECKSiNx7txCdszsrPL0bIRQDxzaU5Ac
	zedbsz9j7JfkoTTeFZEYtGNjcW+eEh/j9klE+VIDOx+e7rV+FRT6Vpuc
X-Gm-Gg: ASbGncuDBm9LQgyknelvEfGgCPkWv75GIRcvsSsCoiCaZwwL2P1p3zWhhDHfH0Fn+QN
	pPG+TDiAg0FPVu/WwWjACIdIjz//y4cJGFO8D9f4KWAfxayYPNNOEUuZ4kh1a0uEZ6NfPyH2kr2
	PmbJGrWBx0oGyoi+irLSBv+8Ci99BB95aP5ku5DEjMVR398PKcRYYpgiDhR8kXL2MmHktoKRh6P
	ndmj11r4hWp6CQvuCSzXaXqFZ09QK2aRrTrv+jkZctriKAq2uGzlb/YOlstkCOQMM4HC/e+2eeT
	LpxbKEx6rKP2NfY=
X-Google-Smtp-Source: AGHT+IEcABZ13vtm1PPON/iG7OCVAGCGJfkoCqH+IUqIY0cUzeZOBlCKgT/rIqTOzY8zYJKFBIa/gA==
X-Received: by 2002:a05:6a00:cca:b0:732:5a8f:f51a with SMTP id d2e1a72fcca58-7325a8ff800mr2496400b3a.8.1739547283061;
        Fri, 14 Feb 2025 07:34:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242549ceasm3273646b3a.7.2025.02.14.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:42 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 01/11] net: hold netdev instance lock during ndo_open/ndo_stop
Date: Fri, 14 Feb 2025 07:34:30 -0800
Message-ID: <20250214153440.1994910-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
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
index 852e5b62f0a5..2396932f073d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4375,22 +4375,21 @@ static int iavf_open(struct net_device *netdev)
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
@@ -4439,7 +4438,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return 0;
 
@@ -4452,7 +4450,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
 
 	return err;
 }
@@ -4474,12 +4471,12 @@ static int iavf_close(struct net_device *netdev)
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
 
@@ -4532,6 +4529,7 @@ static int iavf_close(struct net_device *netdev)
 	if (!status)
 		netdev_warn(netdev, "Device resources not yet released\n");
 
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 	adapter->aq_required |= aq_to_restore;
 	mutex_unlock(&adapter->crit_lock);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 9b394ddc5206..d857ae3c8f06 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -401,7 +401,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
+		netif_napi_add_config_locked(dev, &rq->napi, nsim_poll, i);
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++) {
@@ -421,7 +421,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	}
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		__netif_napi_del(&ns->rq[i]->napi);
+		__netif_napi_del_locked(&ns->rq[i]->napi);
 
 	return err;
 }
@@ -435,7 +435,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 		struct nsim_rq *rq = ns->rq[i];
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
-		napi_enable(&rq->napi);
+		napi_enable_locked(&rq->napi);
 	}
 }
 
@@ -444,6 +444,8 @@ static int nsim_open(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	int err;
 
+	netdev_assert_locked(dev);
+
 	err = nsim_init_napi(ns);
 	if (err)
 		return err;
@@ -461,8 +463,8 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
-		napi_disable(&rq->napi);
-		__netif_napi_del(&rq->napi);
+		napi_disable_locked(&rq->napi);
+		__netif_napi_del_locked(&rq->napi);
 	}
 	synchronize_net();
 
@@ -477,6 +479,8 @@ static int nsim_stop(struct net_device *dev)
 	struct netdevsim *ns = netdev_priv(dev);
 	struct netdevsim *peer;
 
+	netdev_assert_locked(dev);
+
 	netif_carrier_off(dev);
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fccc03cd2164..759a035d2740 100644
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
+	ret |= !!(dev)->netdev_ops->net_shaper_ops;
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
index d5ab9a4b318e..23262f1d8839 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1596,6 +1596,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		return ret;
 
+	netdev_lock_ops(dev);
+
 	set_bit(__LINK_STATE_START, &dev->state);
 
 	if (ops->ndo_validate_addr)
@@ -1615,6 +1617,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 		add_device_randomness(dev->dev_addr, dev->addr_len);
 	}
 
+	netdev_unlock_ops(dev);
+
 	return ret;
 }
 
@@ -1685,11 +1689,19 @@ static void __dev_close_many(struct list_head *head)
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


