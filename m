Return-Path: <netdev+bounces-88180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBFA8A62E5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C341F23A4D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF93A1BF;
	Tue, 16 Apr 2024 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qUESjREs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472539863
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244539; cv=none; b=fjcnDty0naE/eySe1BIMlZpu2HDpJKsWrtm5OFnHYoDIYV0rlAHzbO7vD0G2aXd/3dK21kiTwmRXzsX+wBcG2+ukfLwVwP0Nc2ZHlR1vWZcSqfQSVci7L86BEIFAKzL8YEsbvFfMARenDeMADUB9qlWtUPeJh95kcnXe7Ehn3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244539; c=relaxed/simple;
	bh=VKGpPryBp1qRxW8NvF0iF4kQbCQ+IZf4h907maxV4eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYqxm7V6zi9/R5aMeLPN/7JnnSQ1pomp/gP0vkNQLbMV2f/uvZL2BS3tKXHfkTnqodfF4Myags/oo1WJM+iHtxuSH18MAi+Z8wEZai3FbZmcTZXYlq6eSrzXS/iFH7QPUxY9qc3FQ0VpavA/fDRvHXGCWi84Z4ElU9FQsiSxb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=qUESjREs; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c70a55988dso1370801b6e.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713244537; x=1713849337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GatKq/JJKGctfowNtMQbspH1D9Wc9gEWuRSzVkhw1u8=;
        b=qUESjREsEBk33kdeY+8tc1vA/YwM7bX3OQ9hyTAYRgT1TH09ZVWB3yAtxdpcfz8/sg
         EiAjyrMHLpd6EuMuryEbtnLU54DROjnOwUMIkkApYbJQ8OosUHIc4+u3L4iT1l7KRDIx
         qVKVnoIwbHV9l+/ZD9x/i/2KKHeXJfNxBa4BJO2x2L101223j+EU1BOE51Dn+rXSzfQo
         +8w385mg3QgSBk4726KzigrkZSiQjuHGuiwZfbTqM8cl0DcD1apFs3LBZQMhMj+GKS9y
         JuLQ9+OQXtQr75YJ5GJkKY4oFx2wKNpyGouH8Hr4h/GMgjuGhBU4fFj7Y/dkjybKNHc/
         S4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713244537; x=1713849337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GatKq/JJKGctfowNtMQbspH1D9Wc9gEWuRSzVkhw1u8=;
        b=aQr7IZF+3Ms72a/Us2gUV5PAaduGH2g72iDedr5h/wTE6RHRo8yOV5WOQ7NbGoxrN2
         p10TSolmB8QAvaFWmuNCHlg5Vl/FRH0fT8Vze7GF2331YkKqC8Bti1JEpV/MaBpmKnRD
         tglHlbH4B/bF/OsgpWiKeSKXcaxZSnqmJ5okyilVBgyzjF/qoxgVdG0agksyIs48EM0h
         v6DXMMm3eDF2x8Y9F0kIGXyNlpWJRI8EyTjexLDJ4pXceHHzIqGRmkidq7/YewDcO6HN
         6BGOE7bTThMgx/4Lpu0KS4pDP0pY8N7E+Zb8P3ygzmsX3lcl06t9dUVroe3kjaAGsrbs
         NyYQ==
X-Gm-Message-State: AOJu0Yw1w2RYhmPbzCmoDzoLQ/S7sUsJjYWp/LRpoaRq8pQEw3jJLJ/E
	SG3InAh0hIJlv1ONYXQb2ZZYIPIA+pOJf8NktrPDMdF1PQUM/3v4DO19u0dw/6rd0NSmr0wPdOB
	9
X-Google-Smtp-Source: AGHT+IEwgV5qfdZOobZO/pCnlT9Dhiu6WQbXsaq9GDOkCpKSJo3dNSYezIOeiiyB3HsQcnDH7G6NZQ==
X-Received: by 2002:a05:6808:2a4c:b0:3c6:f482:6526 with SMTP id fa12-20020a0568082a4c00b003c6f4826526mr10821031oib.2.1713244536754;
        Mon, 15 Apr 2024 22:15:36 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id k69-20020a628448000000b006eab9ef5d4esm8477529pfd.50.2024.04.15.22.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 22:15:36 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1 1/2] netdevsim: add NAPI support
Date: Mon, 15 Apr 2024 22:15:26 -0700
Message-ID: <20240416051527.1657233-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416051527.1657233-1-dw@davidwei.uk>
References: <20240416051527.1657233-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NAPI support to netdevim, similar to veth.

* Add a nsim_rq rx queue structure to hold a NAPI instance and a skb
  queue.
* During xmit, store the skb in the peer skb queue and schedule NAPI.
* During napi_poll(), drain the skb queue and pass up the stack.
* Add assoc between rxq and NAPI instance using netif_queue_set_napi().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c    | 227 ++++++++++++++++++++++++++++--
 drivers/net/netdevsim/netdevsim.h |   7 +
 2 files changed, 223 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d127856f8f36..c1a99825be91 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -28,11 +28,33 @@
 
 #include "netdevsim.h"
 
+#define NSIM_RING_SIZE		256
+
+static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
+{
+	if (list_count_nodes(&rq->skb_queue) > NSIM_RING_SIZE) {
+		dev_kfree_skb_any(skb);
+		return NET_RX_DROP;
+	}
+
+	list_add_tail(&skb->list, &rq->skb_queue);
+	return NET_RX_SUCCESS;
+}
+
+static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
+			    struct nsim_rq *rq)
+{
+	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
+}
+
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
+	struct nsim_rq *rq;
+	int rxq;
 
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
@@ -42,10 +64,18 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!peer_ns)
 		goto out_drop_free;
 
+	peer_dev = peer_ns->netdev;
+	rxq = skb_get_queue_mapping(skb);
+	if (rxq >= peer_dev->num_rx_queues)
+		rxq = rxq % peer_dev->num_rx_queues;
+	rq = &peer_ns->rq[rxq];
+
 	skb_tx_timestamp(skb);
-	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
+	napi_schedule(&rq->napi);
+
 	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
@@ -300,25 +330,153 @@ static int nsim_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
+static int nsim_rcv(struct nsim_rq *rq, int budget)
+{
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < budget; i++) {
+		if (list_empty(&rq->skb_queue))
+			break;
+
+		skb = list_first_entry(&rq->skb_queue, struct sk_buff, list);
+		list_del(&skb->list);
+
+		netif_receive_skb(skb);
+	}
+
+	return i;
+}
+
+static int nsim_poll(struct napi_struct *napi, int budget)
+{
+	struct nsim_rq *rq = container_of(napi, struct nsim_rq, napi);
+	int done;
+
+	done = nsim_rcv(rq, budget);
+
+	if (done < budget && napi_complete_done(napi, done)) {
+		if (unlikely(!list_empty(&rq->skb_queue)))
+			napi_schedule(&rq->napi);
+	}
+
+	return done;
+}
+
+static int nsim_create_page_pool(struct nsim_rq *rq)
+{
+	struct page_pool_params p = {
+		.order = 0,
+		.pool_size = NSIM_RING_SIZE,
+		.nid = NUMA_NO_NODE,
+		.dev = &rq->napi.dev->dev,
+		.napi = &rq->napi,
+		.dma_dir = DMA_BIDIRECTIONAL,
+		.netdev = rq->napi.dev,
+	};
+
+	rq->page_pool = page_pool_create(&p);
+	if (IS_ERR(rq->page_pool)) {
+		int err = PTR_ERR(rq->page_pool);
+
+		rq->page_pool = NULL;
+		return err;
+	}
+	return 0;
+}
+
+static int nsim_init_napi(struct netdevsim *ns)
+{
+	struct net_device *dev = ns->netdev;
+	struct nsim_rq *rq;
+	int err, i;
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		rq = &ns->rq[i];
+
+		netif_napi_add(dev, &rq->napi, nsim_poll);
+	}
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		rq = &ns->rq[i];
+
+		err = nsim_create_page_pool(rq);
+		if (err)
+			goto err_pp_destroy;
+	}
+
+	return 0;
+
+err_pp_destroy:
+	while (i--) {
+		page_pool_destroy(ns->rq[i].page_pool);
+		ns->rq[i].page_pool = NULL;
+	}
+
+	for (i = 0; i < dev->num_rx_queues; i++)
+		__netif_napi_del(&ns->rq[i].napi);
+
+	return err;
+}
+
+static void nsim_enable_napi(struct netdevsim *ns)
+{
+	int i;
+
+	for (i = 0; i < ns->netdev->num_rx_queues; i++) {
+		struct nsim_rq *rq = &ns->rq[i];
+
+		netif_queue_set_napi(ns->netdev, i,
+				     NETDEV_QUEUE_TYPE_RX, &rq->napi);
+		napi_enable(&rq->napi);
+	}
+}
+
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
-	struct page_pool_params pp = { 0 };
+	int err;
+
+	err = nsim_init_napi(ns);
+	if (err)
+		return err;
+
+	nsim_enable_napi(ns);
 
-	pp.pool_size = 128;
-	pp.dev = &dev->dev;
-	pp.dma_dir = DMA_BIDIRECTIONAL;
-	pp.netdev = dev;
+	netif_carrier_on(dev);
 
-	ns->pp = page_pool_create(&pp);
-	return PTR_ERR_OR_ZERO(ns->pp);
+	return 0;
+}
+
+static void nsim_del_napi(struct netdevsim *ns)
+{
+	struct net_device *dev = ns->netdev;
+	int i;
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		struct nsim_rq *rq = &ns->rq[i];
+
+		napi_disable(&rq->napi);
+		__netif_napi_del(&rq->napi);
+	}
+	synchronize_net();
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		page_pool_destroy(ns->rq[i].page_pool);
+		ns->rq[i].page_pool = NULL;
+	}
 }
 
 static int nsim_stop(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer = rtnl_dereference(ns->peer);
+
+	netif_carrier_off(dev);
+	if (peer)
+		netif_carrier_off(peer->netdev);
 
-	page_pool_destroy(ns->pp);
+	nsim_del_napi(ns);
 
 	return 0;
 }
@@ -437,7 +595,7 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
 	} else if (val) {
-		ns->page = page_pool_dev_alloc_pages(ns->pp);
+		ns->page = page_pool_dev_alloc_pages(ns->rq[0].page_pool);
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
@@ -477,6 +635,46 @@ static void nsim_setup(struct net_device *dev)
 	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
 
+static int nsim_queue_init(struct netdevsim *ns)
+{
+	struct net_device *dev = ns->netdev;
+	int i;
+
+	ns->rq = kvcalloc(dev->num_rx_queues, sizeof(*ns->rq),
+			  GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
+	if (!ns->rq)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_rx_queues; i++)
+		INIT_LIST_HEAD(&ns->rq[i].skb_queue);
+
+	return 0;
+}
+
+static void __nsim_skb_queue_purge(struct list_head *head)
+{
+	struct sk_buff *skb, *tmp;
+
+	list_for_each_entry_safe(skb, tmp, head, list) {
+		list_del(&skb->list);
+		dev_kfree_skb_any(skb);
+	}
+}
+
+static void nsim_queue_free(struct netdevsim *ns)
+{
+	struct net_device *dev = ns->netdev;
+	int i;
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		if (!list_empty(&ns->rq[i].skb_queue))
+			__nsim_skb_queue_purge(&ns->rq[i].skb_queue);
+	}
+
+	kvfree(ns->rq);
+	ns->rq = NULL;
+}
+
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
 	struct mock_phc *phc;
@@ -495,10 +693,14 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 		goto err_phc_destroy;
 
 	rtnl_lock();
-	err = nsim_bpf_init(ns);
+	err = nsim_queue_init(ns);
 	if (err)
 		goto err_utn_destroy;
 
+	err = nsim_bpf_init(ns);
+	if (err)
+		goto err_rq_destroy;
+
 	nsim_macsec_init(ns);
 	nsim_ipsec_init(ns);
 
@@ -512,6 +714,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
 	nsim_bpf_uninit(ns);
+err_rq_destroy:
+	nsim_queue_free(ns);
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
@@ -594,6 +798,7 @@ void nsim_destroy(struct netdevsim *ns)
 		nsim_ipsec_teardown(ns);
 		nsim_bpf_uninit(ns);
 	}
+	nsim_queue_free(ns);
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_exit_netdevsim(ns);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7664ab823e29..87bf45ec4dd2 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -90,11 +90,18 @@ struct nsim_ethtool {
 	struct ethtool_fecparam fec;
 };
 
+struct nsim_rq {
+	struct napi_struct napi;
+	struct list_head skb_queue;
+	struct page_pool *page_pool;
+};
+
 struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
 	struct nsim_dev_port *nsim_dev_port;
 	struct mock_phc *phc;
+	struct nsim_rq *rq;
 
 	u64 tx_packets;
 	u64 tx_bytes;
-- 
2.43.0


