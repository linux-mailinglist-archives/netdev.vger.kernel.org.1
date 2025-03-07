Return-Path: <netdev+bounces-172999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9DA56CD2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406861787D3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B972221F10;
	Fri,  7 Mar 2025 15:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8D21E0A2;
	Fri,  7 Mar 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363054; cv=none; b=q8aL8SpFVTBHSGz9czvDQn+EAOE3x8RS70hgKC4Cn9M+ELgDwOAkGHG/sqRT8gwyLDoiMMICugOmFrOM6Rul3CvwFTqUi0j5rkXEM33CCg8itYlJxG/82bau4H73TMlwknVZ4AqXel+p1THHzDauXfvLJHeoIGNBCP9zLcmEquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363054; c=relaxed/simple;
	bh=lYILpbAOKO+vkQH0pJfDI/aajZ4gWsD0lr2JKJJ5iWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MydBupfA8JXScUYE33gE2+IGE9hJvuz+cyDpmkoAZJ7MxURPCtu3Ff8CewZfDwg1GkF6CpmZMmm9Bc0HmWSvuq8A2/ir5FAYmxcPvrBzN9iJEYY5H5m9/wJnuwXh9Ztb/yZ1Upyll/UCEBn2aRLp7g8OUPRpaEy9WirFIRa2ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223f4c06e9fso37608555ad.1;
        Fri, 07 Mar 2025 07:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363051; x=1741967851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNY7QpJz52D8G6N2MeHEgoi0caSdn8a+aQQjEhBoLzA=;
        b=YGbYRIW+wHoB+2lFWH16HibBbTn27LTAGa4V/ZBKe/NBOUmFlWNIp1sCwZrgTCOtJW
         igzcWdw9dFObMhJWejDIpyyHVx2/gDAI+1Mlu4FWZvjotlYSqlDj1YsNlEUQC5zrYWZw
         oaefR/Fk3MtrR+/MPrnHldtdftHg3R945pqgJmlECCzO2ah5eABp480mT1iGVk9inNX6
         xhl4ftfa37ajDCOpvG4qaTLwzmTiT5ub4y+PJ0/TpUehF1cun4d9NHDS2IMDChJQovkX
         qivOChwIyVduXvFbNpCYV8IqugPHlLjbmNbSjQff3Kj3/GmUWvbLcNlxrEH6hnjxatOB
         fr4g==
X-Forwarded-Encrypted: i=1; AJvYcCUrBPVhObm4x5bU2T4gfPrFZdQr7HC6zu6jUUtf/TyHm0Ylo/dw592SAlOgAd2+Kwp/t+Rx+/VIwRHKKqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGP+YQ4yWlwrGRWwZm926TFdApL1JDFBHOGkf3yOdexEnh4Vmw
	+enGMimI+v9hOPincYzB4vcJNyHOBnpMyt2AmCCPmdW9xAADUHMmglkm
X-Gm-Gg: ASbGncv0HFR5TU9uZQlvsVgpMOk//a6lIuazI2Kozj5pu4sfWf/+/LjDkMt0XHA/5H6
	ozGQZ3YG6esGcwMK/3mdVecYyfMnrARqFpYTvqGJaI+ccPARUR5Ho4CmGKp1SaxWAlSnWVj0FZI
	P+5SnZr1V1PE0Zs4pi3PhN/MbJ6aMTI/htmizlHIRigLYWLU5XBuLWdcnVONw9dJIspZvUns7tM
	nyRgRh+vAqAaRZbo5WI7aurM6xZD8JctzfuViJPVcDTte8C6ZuhzXMnO07x2FEW7oRWuFnKSMce
	rSRcp1FW8ThWp3+hCsy5tAaIJ640VXe5LS9zo7XEYzQY
X-Google-Smtp-Source: AGHT+IGrKs8tyHlQ6sonWiilKHhayquw18UpO5yvlUWmMpGKRlmKHRoMCf/2ZVxttNss+RdVxYqDIQ==
X-Received: by 2002:a17:902:e548:b0:216:271d:e06c with SMTP id d9443c01a7336-2244f057ca6mr594285ad.4.1741363051299;
        Fri, 07 Mar 2025 07:57:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ea87esm31641855ad.85.2025.03.07.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:30 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	sdf@fomichev.me,
	xuanzhuo@linux.alibaba.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v1 4/4] net: drop rtnl_lock for queue_mgmt operations
Date: Fri,  7 Mar 2025 07:57:25 -0800
Message-ID: <20250307155725.219009-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307155725.219009-1-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
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
 net/core/devmem.c                         |  3 ++-
 net/core/netdev-genl.c                    | 18 +++++-------------
 net/core/netdev_rx_queue.c                | 15 +++++----------
 5 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1a1e6da77777..9b936cfc1d29 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11380,14 +11380,14 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
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
index 54d03b0628d2..1ba2ff5e4453 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -786,7 +786,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	if (ret != 2)
 		return -EINVAL;
 
-	rtnl_lock();
+	netdev_lock(ns->netdev);
 	if (queue >= ns->netdev->real_num_rx_queues) {
 		ret = -EINVAL;
 		goto exit_unlock;
@@ -800,7 +800,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 
 	ret = count;
 exit_unlock:
-	rtnl_unlock();
+	netdev_unlock(ns->netdev);
 	return ret;
 }
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index c16cdac46bed..e48eb42d7377 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -132,9 +132,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		rxq->mp_params.mp_priv = NULL;
 		rxq->mp_params.mp_ops = NULL;
 
+		netdev_lock(binding->dev);
 		rxq_idx = get_netdev_rx_queue_index(rxq);
-
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		netdev_unlock(binding->dev);
 	}
 
 	net_devmem_dmabuf_binding_put(binding);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 8acdeeae24e7..1de28f9e0219 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -481,8 +481,6 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
 	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
@@ -491,8 +489,6 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENODEV;
 	}
 
-	rtnl_unlock();
-
 	if (err)
 		goto err_free_msg;
 
@@ -541,7 +537,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
 		netdev = netdev_get_by_index_lock(net, ifindex);
 		if (netdev) {
@@ -559,7 +554,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->txq_idx = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
@@ -860,12 +854,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -918,14 +911,15 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
-	rtnl_unlock();
+	netdev_unlock(netdev);
 
 	return 0;
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
 err_unlock:
-	rtnl_unlock();
+	netdev_unlock(netdev);
+err_unlock_sock:
 	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
@@ -945,9 +939,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		rtnl_lock();
 		net_devmem_unbind_dmabuf(binding);
-		rtnl_unlock();
 	}
 	mutex_unlock(&priv->lock);
 }
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 7419c41fd3cb..8fd5d784ac09 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -18,7 +18,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
-	ASSERT_RTNL();
+	netdev_assert_locked(dev);
 
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
@@ -30,8 +30,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	netdev_lock(dev);
-
 	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
@@ -54,8 +52,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	qops->ndo_queue_mem_free(dev, old_mem);
 
-	netdev_unlock(dev);
-
 	kvfree(old_mem);
 	kvfree(new_mem);
 
@@ -80,7 +76,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	qops->ndo_queue_mem_free(dev, new_mem);
 
 err_free_old_mem:
-	netdev_unlock(dev);
 	kvfree(old_mem);
 
 err_free_new_mem:
@@ -118,9 +113,9 @@ int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 {
 	int ret;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	ret = __net_mp_open_rxq(dev, ifq_idx, p);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return ret;
 }
 
@@ -153,7 +148,7 @@ static void __net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
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


