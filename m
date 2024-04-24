Return-Path: <netdev+bounces-90754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834B8AFE8A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45D1B231B5
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E583CAF;
	Wed, 24 Apr 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="TSuufIwE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E89143C47
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926201; cv=none; b=OlA9BegbJiyrZmofA4lHB+XdphwJNpdXTiIobU8etYC15uPbKTbje+2gUVH5mrjThrvl6RFjgh1XOCf6jEYxWhMcoxT+SxRyt7qUtTjE0oAfbiY1sOO5jZ5LN6qyqjggH+IR6kpLDMUuL3GeVfEUgPLcf5OMRYfBfUdWMKaueZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926201; c=relaxed/simple;
	bh=+FX3lp0bD/05Vq+i1ACF9Oo2Kab8ddgwHl13u4qq3JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmGgepL13tBsdiUdsj0+gJJVO6m5jmyMb2HFExMoyUfXvcMEMwwZqNv56boNJKfOKXp8OqioWb4A2A2ng8FhYhWt8pu5A/DcjUNo40Ct9JCzQuff/nTTLOQZTBoB3fxJdEFP4NL33R8vwhGd+N/ix+3UstDoavzlSpmPys1p4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=TSuufIwE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ee12766586so400329b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713926198; x=1714530998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h4zQ+CJbIiuiPowMrNgCNlz328V8jesHO8fZ4bH37U=;
        b=TSuufIwEt3geB1dD0uJKI++ahcX8xzMWhWf1F/J+arNxHngfmYa1LniyqDBU9xNacV
         xZ3KPWfcl6N/JyPMKOLNP6wFOx/fxUmm47DMxEoeL7vuGHe8+AWXjvJfw1metqd5uyk4
         9ewwPcu09HPP6DcIBLvWM450up8QK2nKB2cDETamV/6PCyQEMslcCdA5sHnTXBcYTWUe
         OmofB9xv9Pi+y8SuwZIstfWD0lwoe3XOKlPZ+StKWGc0sfZOx0xNcC+FYMR4nM1/LARn
         i5PDuCLZMvDBE22s4nTx6iUVTDyMqKWGmeOgTKoIZNMZqQWDwrBhnkdBA8AYv4U3MhOy
         pULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926198; x=1714530998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h4zQ+CJbIiuiPowMrNgCNlz328V8jesHO8fZ4bH37U=;
        b=vbxPKpid5h2KQzWVIZHsdC6sLAnlzmOAajZlJ5NUglWd3Kg54mDK2zO16PFLxwlbRL
         2CGANteBtdnB06iWi/yviAa2MsWfTVAd5ZOi2UU3DRjv3snIn2fiGUbWqGNh+uMDYr9o
         6kPVoWW+OeaSiRJJCKdYeUN9Dc3kwPpg8ZpDeZ0Ziq3knaFYLKYmFzaQ+NUSgtIfl9nh
         owp5NXB45OUoTugr5w4V4h2Xk4/D81AcGKHavw3VctH1HQn5TdmkYJxGF7UlfagLNgiT
         7mxyMOhjiqk8ezHan5vpKudtWKvXZakvjjKYbZpQLnW3Pw6m3CpcwIhJ3ZRrm+MWrEnr
         QD6Q==
X-Gm-Message-State: AOJu0Yx9BJ5sW7Mq6OTbJty908ALuOUGvgQ6p3EmBIAOGlpWqq+6v3gN
	V6mDmMx5b9B3IykQQ4ljfb1Okn03D21Tmd/fmE0L46WcWTQ6I7BvlsbGB5IqP1AOyRMIXsWx9yh
	r
X-Google-Smtp-Source: AGHT+IF/Rl+lkW6qlGkQwFHt3nlHFH4gklDOsyy+jTy0kLf7y7FKOtt6PNgYeC5kIwflLK8UZG2zaw==
X-Received: by 2002:a05:6a00:13aa:b0:6ed:825b:30c0 with SMTP id t42-20020a056a0013aa00b006ed825b30c0mr6248058pfg.15.1713926198458;
        Tue, 23 Apr 2024 19:36:38 -0700 (PDT)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id fi33-20020a056a0039a100b006e65d66bb3csm10324984pfb.21.2024.04.23.19.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:36:38 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 1/2] netdevsim: add NAPI support
Date: Tue, 23 Apr 2024 19:36:23 -0700
Message-ID: <20240424023624.2320033-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424023624.2320033-1-dw@davidwei.uk>
References: <20240424023624.2320033-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c    | 209 ++++++++++++++++++++++++++++--
 drivers/net/netdevsim/netdevsim.h |   8 +-
 2 files changed, 205 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d127856f8f36..193887c072ca 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -28,11 +28,33 @@
 
 #include "netdevsim.h"
 
+#define NSIM_RING_SIZE		256
+
+static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
+{
+	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
+		dev_kfree_skb_any(skb);
+		return NET_RX_DROP;
+	}
+
+	skb_queue_tail(&rq->skb_queue, skb);
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
@@ -300,25 +330,146 @@ static int nsim_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
+static int nsim_rcv(struct nsim_rq *rq, int budget)
+{
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < budget; i++) {
+		if (skb_queue_empty(&rq->skb_queue))
+			break;
+
+		skb = skb_dequeue(&rq->skb_queue);
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
+	napi_complete(napi);
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
+	struct net_device *dev = ns->netdev;
+	int i;
+
+	for (i = 0; i < dev->num_rx_queues; i++) {
+		struct nsim_rq *rq = &ns->rq[i];
+
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
+		napi_enable(&rq->napi);
+	}
+}
+
 static int nsim_open(struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
-	struct page_pool_params pp = { 0 };
+	int err;
 
-	pp.pool_size = 128;
-	pp.dev = &dev->dev;
-	pp.dma_dir = DMA_BIDIRECTIONAL;
-	pp.netdev = dev;
+	err = nsim_init_napi(ns);
+	if (err)
+		return err;
 
-	ns->pp = page_pool_create(&pp);
-	return PTR_ERR_OR_ZERO(ns->pp);
+	nsim_enable_napi(ns);
+
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
+	struct netdevsim *peer;
+
+	netif_carrier_off(dev);
+	peer = rtnl_dereference(ns->peer);
+	if (peer)
+		netif_carrier_off(peer->netdev);
 
-	page_pool_destroy(ns->pp);
+	nsim_del_napi(ns);
 
 	return 0;
 }
@@ -437,7 +588,7 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
 	} else if (val) {
-		ns->page = page_pool_dev_alloc_pages(ns->pp);
+		ns->page = page_pool_dev_alloc_pages(ns->rq[0].page_pool);
 		if (!ns->page)
 			ret = -ENOMEM;
 	} else {
@@ -477,6 +628,35 @@ static void nsim_setup(struct net_device *dev)
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
+		skb_queue_head_init(&ns->rq[i].skb_queue);
+
+	return 0;
+}
+
+static void nsim_queue_free(struct netdevsim *ns)
+{
+	struct net_device *dev = ns->netdev;
+	int i;
+
+	for (i = 0; i < dev->num_rx_queues; i++)
+		skb_queue_purge_reason(&ns->rq[i].skb_queue,
+				       SKB_DROP_REASON_QUEUE_PURGE);
+
+	kvfree(ns->rq);
+	ns->rq = NULL;
+}
+
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
 	struct mock_phc *phc;
@@ -495,10 +675,14 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
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
 
@@ -512,6 +696,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
 	nsim_bpf_uninit(ns);
+err_rq_destroy:
+	nsim_queue_free(ns);
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
@@ -593,6 +779,7 @@ void nsim_destroy(struct netdevsim *ns)
 		nsim_macsec_teardown(ns);
 		nsim_ipsec_teardown(ns);
 		nsim_bpf_uninit(ns);
+		nsim_queue_free(ns);
 	}
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7664ab823e29..bf02efa10956 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -90,11 +90,18 @@ struct nsim_ethtool {
 	struct ethtool_fecparam fec;
 };
 
+struct nsim_rq {
+	struct napi_struct napi;
+	struct sk_buff_head skb_queue;
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
@@ -125,7 +132,6 @@ struct netdevsim {
 		struct debugfs_u32_array dfs_ports[2];
 	} udp_ports;
 
-	struct page_pool *pp;
 	struct page *page;
 	struct dentry *pp_dfs;
 
-- 
2.43.0


