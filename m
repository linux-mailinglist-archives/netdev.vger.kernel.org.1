Return-Path: <netdev+bounces-173932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70984A5C414
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABAC189943F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EC25D549;
	Tue, 11 Mar 2025 14:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E825D1F6;
	Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704034; cv=none; b=sdDtvP8uVNoJE3rphB3OZM0QDbsCK94Y76aB9tuAy9IFEQcTx58plSxE9k0Aj4QjJ2dxGkUXrXtjeTBg5Yw770AfnX1vsHlsFrp5S2Ctw9mBBpxe1htcXs/SdQAqA8m4rgzjTdOpBk65mfIzmm4nhtjTwXWdxIpOOx1ljbTeNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704034; c=relaxed/simple;
	bh=QMphvet5eBPxtNopzD5wT6LsCAIRbvNlrStOVAsDg8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiSRtR5jHM2mdPQOZCtJQh1II65cHs/WVD0TV7lFMuYo2cU9LwZvdHRgqY9qoV3dhwef+Rs1lCn7AlC96qrc9WUTQQkpsN85OJX/jGWdbWbX/PWIZFdRlAGSd3HrTqh/8DYm6ugJNRPs9vV86nx/JRMN1lc9eQerxW38Qb16GY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22349bb8605so104128065ad.0;
        Tue, 11 Mar 2025 07:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704032; x=1742308832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIHHeAoRhvw6w3l3FTSqNbvDp20Th7TJeuEgauSJLT8=;
        b=QHcgcIaoB/dDxTaanN5Xd8P4tI78Ofpuy1V/xRzJVpr2iKhN+a32UQOZOQOMTD40HS
         VmnPV4QkvbtP5KS7YbHMnc44oj0Yxye7gDbdPc8rQ0le0iD92y0w9L8F/mFLsGmSmAS6
         VA/ptb2ELD97O84YMwSzi5epSMbwJ9FypIvfTxGeRkbihS70xvqhfoQhYCSPr9VZC8Zr
         vtowLsQ6LnUim/vnh8eInbt8ZX9FgmA9M910mAigdXI9KAXc2zOY5WgOKfbTvqvpFUha
         HseLROy+gABH6cGBleU6P/g7SBMndsSltqq2wljLM7f271X3qcr9be5f4huCc5uWBV4X
         C0kA==
X-Forwarded-Encrypted: i=1; AJvYcCUqNSWwG6iHBGt8m+iNqMjVsZal+U7G6u5DO6EnbDjUzbhgNPyTGYaY67eyaxGAes3rfQcZYHdnjx+wab4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykiJfpjArk1rI9luqelQT9Wouuank59uoiiiHNEaEKXg7PN4T7
	HEJB8R3+PCKFkfL1P7UgMfvTfmtm5hwzKSaYp8snYxI9U8gPYGKPMrwicgB+iw==
X-Gm-Gg: ASbGncuZcn2ob0YyK1Mf/2GEU+MeXMpnsd8XAaE67NIdSloIKo8I5da929Nx1mZx8tt
	xfAaeIEFYlUFNeGYrdZrQUEcOE7gyhisjCqUVla+zeW/4yJKHj71eZRizJ9Aprk/wnXRPPQqk+7
	EtospwZ44PT1OdBI8ZktLjzZJVQSUjuzrJ0lyBo01qk40Xli6MMas4ahNcCCNvVtw66lv5MCtDT
	sNOHbZ+eb1wSC2qENHNvsgOyxNML/vmztGLuzBhJ4tLMc00arYoNhNPDpeNF7F5Z69NOdJc4tG4
	6b6FiEgQGwPALNMelnL/dSIxe5GUabgPZysu3T2NFQJz
X-Google-Smtp-Source: AGHT+IEFxfj8I+/mo12Ns57fmpJwTSgZj5lu8yWMR82LD8rfOYKXXLDheg0O1eYwZXZZ5FoJrxRnUQ==
X-Received: by 2002:a17:902:ce0a:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22428c055ecmr275160985ad.36.1741704031992;
        Tue, 11 Mar 2025 07:40:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736bb5fcd68sm7311843b3a.135.2025.03.11.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:40:31 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v2 3/3] net: drop rtnl_lock for queue_mgmt operations
Date: Tue, 11 Mar 2025 07:40:26 -0700
Message-ID: <20250311144026.4154277-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311144026.4154277-1-sdf@fomichev.me>
References: <20250311144026.4154277-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers that use queue API are already converted to use
netdev instance lock. Move netdev instance lock management to
the netlink layer and drop rtnl_lock.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  4 ++--
 drivers/net/netdevsim/netdev.c            |  4 ++--
 net/core/devmem.c                         |  4 ++--
 net/core/netdev-genl.c                    | 13 ++++++-------
 net/core/netdev_rx_queue.c                | 16 ++++++----------
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b09171110ec4..fed08aaf68e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11381,14 +11381,14 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
 		return;
 
-	rtnl_lock();
+	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
 		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
 	}
-	rtnl_unlock();
+	netdev_unlock(irq->bp->dev);
 }
 
 static void bnxt_irq_affinity_release(struct kref *ref)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d71fd2907cc8..e3152ebe98a2 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -787,7 +787,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	if (ret != 2)
 		return -EINVAL;
 
-	rtnl_lock();
+	netdev_lock(ns->netdev);
 	if (queue >= ns->netdev->real_num_rx_queues) {
 		ret = -EINVAL;
 		goto exit_unlock;
@@ -801,7 +801,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 
 	ret = count;
 exit_unlock:
-	rtnl_unlock();
+	netdev_unlock(ns->netdev);
 	return ret;
 }
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7c6e0b5b6acb..5c4d79a1bcd8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -25,7 +25,6 @@
 
 /* Device memory support */
 
-/* Protected by rtnl_lock() */
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
@@ -128,9 +127,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		rxq->mp_params.mp_priv = NULL;
 		rxq->mp_params.mp_ops = NULL;
 
+		netdev_lock(binding->dev);
 		rxq_idx = get_netdev_rx_queue_index(rxq);
-
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		netdev_unlock(binding->dev);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 63e10717efc5..a186fea63c09 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -860,12 +860,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	mutex_lock(&priv->lock);
-	rtnl_lock();
 
-	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
 	if (!netdev || !netif_device_present(netdev)) {
 		err = -ENODEV;
-		goto err_unlock;
+		goto err_unlock_sock;
 	}
 
 	if (dev_xdp_prog_count(netdev)) {
@@ -918,7 +917,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
-	rtnl_unlock();
+	netdev_unlock(netdev);
+
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -926,7 +926,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
 err_unlock:
-	rtnl_unlock();
+	netdev_unlock(netdev);
+err_unlock_sock:
 	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
@@ -946,9 +947,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		rtnl_lock();
 		net_devmem_unbind_dmabuf(binding);
-		rtnl_unlock();
 	}
 	mutex_unlock(&priv->lock);
 }
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 7419c41fd3cb..a5b234b33cd5 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/netdevice.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
@@ -18,7 +19,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
-	ASSERT_RTNL();
+	netdev_assert_locked(dev);
 
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
@@ -30,8 +31,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	netdev_lock(dev);
-
 	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
@@ -54,8 +53,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	qops->ndo_queue_mem_free(dev, old_mem);
 
-	netdev_unlock(dev);
-
 	kvfree(old_mem);
 	kvfree(new_mem);
 
@@ -80,7 +77,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	qops->ndo_queue_mem_free(dev, new_mem);
 
 err_free_old_mem:
-	netdev_unlock(dev);
 	kvfree(old_mem);
 
 err_free_new_mem:
@@ -118,9 +114,9 @@ int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 {
 	int ret;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	ret = __net_mp_open_rxq(dev, ifq_idx, p);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return ret;
 }
 
@@ -153,7 +149,7 @@ static void __net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
 void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
 		      struct pp_memory_provider_params *old_p)
 {
-	rtnl_lock();
+	netdev_lock(dev);
 	__net_mp_close_rxq(dev, ifq_idx, old_p);
-	rtnl_unlock();
+	netdev_unlock(dev);
 }
-- 
2.48.1


