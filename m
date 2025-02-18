Return-Path: <netdev+bounces-167175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71968A390AF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D2A18918D7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088D161302;
	Tue, 18 Feb 2025 02:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DC155CBA
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844595; cv=none; b=VVF20X1AgZL9tC4tsM1DhHXAvhZabEWYvSLD9uzQ7UHA0wL205pYHl50ak6w0+QC4MhjCsWtKZayWb8unH4T1xsw0VeiqIUiAjD9b/qfIOXy5pUoPDQOWrpVqAgDOmDhCUWxokjZGjvK4e50TxNmEI2/+h/Wk6EwCqnNpqDXaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844595; c=relaxed/simple;
	bh=offnW4kd5kDrv1ZsWuym9MVPN9wm6CvKsz1fLxTx7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaGXbMAoyHQeEtPnH9OyVVdOBwHgw+2/UMveV8QAXxnwKEEuEnaZ+priV63kEI+DkOrTdbCL/fTDnqyrXMNZ4wkdQYKEwvlOrEsFSULypBp1i6T5aOaTSUHtG5IPWhbwQCUVCiXvWtgzONwtXGzEIyKym/1lGLvieCWn+I7qPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221057b6ac4so39745525ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844591; x=1740449391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=livm1DlHdAm05hDUwd++yeSftV5vCtYGz/ux3lSOPaQ=;
        b=CoMyduCRxFKGerEQoxcVVNUZNV9aKuLjzHsKAKUUuz+Nz2Q01cf72RpPGetvmut+ME
         wDZkhde+pZgcmDUoYL1JyNKqlKf/OV1RBxEUj28vahPu3anW51yJsKTf3VGv/JKVsKYJ
         KfwFstgf1e4CQXau3m1PzVv+xx3a+Tk2W4oUKhqPaQqof2nNJgrIxGEeQuoP+CmQKwcS
         TMWeli/Fhmm+cFtK22O6XDipBaCqFMq2ZlZrx4FeUnS9dRva5SCjq6YTljqqiDKfFlos
         vYaLRDd4iZ14Eiy8AllIc3XeGMaFw5fn5diyVeUPFZsBtgx55NRMqodj6WP/oM2HjbXX
         fzkg==
X-Gm-Message-State: AOJu0YwT9HPnpvWCeekaBoJoZQOvXp6YFATPrM9zoJUM90Ndcwdv72Oz
	adE/YjPGLqc2CvLq8Xs4o2B03o3uok/ylKavrsW0LBRTEJHv8BZeISOR
X-Gm-Gg: ASbGnctezAGXCEzf9LJmZiKlX3L+HdGWB3vQvrsGOR/10dRcsAn2CUIfZCH/fWcVvgZ
	5NMKPGapw+LSbs9GB3cj6U3wz6qkDnD9t577rhLidcXfMIYgHxiovrchqV+TZ3Bf3CTTtIeFaV+
	ktPdYHq9RdDQZGHvOGpDnph/1PNT9I0MZi2DWvHYxkpZuFHoXiGey1NJAodQq1VPrDKq6KM4iZY
	sHW6WJfZt2XJ8j4eH6ASYysfyagv+lBmZu7RAsts2VLKAHgMhikM9QYuF5UUGgEw3FTagRimq/q
	89hfCt2p99GLrXE=
X-Google-Smtp-Source: AGHT+IEi4O2dV/TpEujG1i1zIXtuDhqfBbYEtzUPVo6JmZcFMnHc8tYlK3w4C6V1Th3zQbLo+u7piA==
X-Received: by 2002:a17:902:e5d0:b0:220:d601:a6dc with SMTP id d9443c01a7336-2210405ccbamr183249205ad.22.1739844591122;
        Mon, 17 Feb 2025 18:09:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491a6sm77684065ad.20.2025.02.17.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:09:50 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 01/12] net: hold netdev instance lock during ndo_open/ndo_stop
Date: Mon, 17 Feb 2025 18:09:37 -0800
Message-ID: <20250218020948.160643-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218020948.160643-1-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
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


