Return-Path: <netdev+bounces-152758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3259F5BBE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2F91887F5C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF706524B4;
	Wed, 18 Dec 2024 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NmkDPxlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EC446A1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482284; cv=none; b=esRzoi+p5ye+Gr0wi8+4TvbgMjledtgL+DpLOOwhpXgdqk0V9LZvY+ZBwN5uSWpKVO2rLblzCdFolnaMD6vev/UBfunJAKuDDwnlrkCIyWK9ZA0c+ov19KtaRPMzlhJGi1r26FjFuQGnxd+OWB5n9PSD3sYNFAP+mbSzF7VXO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482284; c=relaxed/simple;
	bh=rCxxW/itp5x+499AxEs1p7a9ucFkJqEo/t2FhOUVYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJdDgGOO3V6Tonzgol8MhErE6SrSnNOaolVtSseAjgAQLITL1GILPVsjrPB/ZH/bAI/babin5vgdoCkR9ScG11zRr71xC/hlu9ePRHkjFq79X520f4EWAH29uoJn7iliqVDRx7S3mzK6xY/1x1d4n+oYG6M8R2E/KAdCWgQ/liQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NmkDPxlJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4260524a91.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482283; x=1735087083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AfGsKFHOkdqeOf3FsE461f86oQPOHTvgRIj0UuaaTA=;
        b=NmkDPxlJHo1O4tohIzgNaVCdevCCk9ukopaT928MXLW7wdnVU5mO+BsbcwH8IikIQS
         8XHlqI3r1QVNSlbO2j8SdOkueNgmiF9uszuEpAHx3g3DjrGYW7o92sY40E9LMyS69v4I
         xuMQCUPCvW2i1Wj3HIXAD7741mUf5GtRw5vvt1mrM+r12KoaQzsDLy5G11kkl1SOS+BQ
         nYwIui0TFU44pESu8vsW2tLXIDNlEYsNQf8ZoS9/MXrZRZxGd+H9gDluSjpbrMzS24tK
         0BB5sPvhZ3PjpqfE1dGzlZTPhSucyjFQlUSH+2jmjCmgNaU9d+SbVCRD8su1HZGR76Q5
         3eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482283; x=1735087083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AfGsKFHOkdqeOf3FsE461f86oQPOHTvgRIj0UuaaTA=;
        b=nWRV7GJ0G8rwFRuY80uncISp4HK+8nEWp8sYJGZaJXICTTMF0MU0HvOwWN+8RlGNDw
         +htQysDCFXXWqL7aTEpHSmLWsBOap5fb5seQ5vFm+1zp6r8lLqEeh9tW+/u6e89XhLdh
         MMS69gaxwzSATVKb46HO1ByIMpPRyTegAUokDZKY8AoNs0FAO/aDAoibmhXxoyounHLO
         F9ONxKfqKpl9uU7ujOd3AxHIoIfeW5nEjJTvL8ICX7Yl9/RqVyFYZy55Bjrnk5afU6nG
         LM6d+saLt9GFGAjPyCK0wvGXa6SIrhKSLVOpnUHihIIKdIt8MHeZtBuUS3b+JNJeIX4y
         gHQg==
X-Forwarded-Encrypted: i=1; AJvYcCX74NpnavJtHNrC9iC8wcxLGSdpTy643i37d2BFE+vHFQ7hMhDx0DBHHkIbbxbwHkV0n+qJ6NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLaE6wcyW+CBZ04MfL+0XbHTK9ZQpwy2IYGphd26p6htxjb8D
	sZ7wqd+Lm6CenUnmpE2A5P+UBGHR2dQuv/xWXHkTkjEKA7tAXciNecF37IRRIbA=
X-Gm-Gg: ASbGnctNC1AXNW5iNzoJIVeRGfMLwkjKJVvofhcs1zI0P/HFicgAI7bP3iVToSXb87P
	JHB8z0jq2IRrd+FS/4n3Wbqa6QJ+sFk3e1tg1goyaBVLJSGeOK3ZX8KvWNk+vm+3V0EDYgXePgq
	7h9qBas+u2bCjFGYhXHSsprYfk7nTVfvpUQJDVJOYX5dq01gBe/OxjhG3OoaDgqQ2nVkDuEKipG
	aCMv62ttPxynnoyAan82bYmreNZXgHw4xyD7Tvs
X-Google-Smtp-Source: AGHT+IGR5LtCiHdpBMT9BbBFtuBIuICGu+bP7i6GvYwDVpp1zApjpbwEqvUEmYFj/DD4IWaUS2GokQ==
X-Received: by 2002:a17:90b:2b87:b0:2ee:45fe:63b5 with SMTP id 98e67ed59e1d1-2f2e91c4fcbmr1321471a91.3.1734482282595;
        Tue, 17 Dec 2024 16:38:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cdc3sm111852a91.3.2024.12.17.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:02 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v9 06/20] net: page_pool: add a mp hook to unregister_netdevice*
Date: Tue, 17 Dec 2024 16:37:32 -0800
Message-ID: <20241218003748.796939-7-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Devmem TCP needs a hook in unregister_netdevice_many_notify() to upkeep
the set tracking queues it's bound to, i.e. ->bound_rxqs. Instead of
devmem sticking directly out of the genetic path, add a mp function.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h |  3 +++
 net/core/dev.c                | 15 ++++++++++++++-
 net/core/devmem.c             | 36 ++++++++++++++++-------------------
 net/core/devmem.h             |  5 -----
 4 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index a473ea0c48c4..140fec6857c6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -152,12 +152,15 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct netdev_rx_queue;
+
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
 	int (*nl_report)(const struct page_pool *pool, struct sk_buff *rsp);
+	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
 };
 
 struct pp_memory_provider_params {
diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb..aa082770ab1c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11464,6 +11464,19 @@ void unregister_netdevice_queue(struct net_device *dev, struct list_head *head)
 }
 EXPORT_SYMBOL(unregister_netdevice_queue);
 
+static void dev_memory_provider_uninstall(struct net_device *dev)
+{
+	unsigned int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct netdev_rx_queue *rxq = &dev->_rx[i];
+		struct pp_memory_provider_params *p = &rxq->mp_params;
+
+		if (p->mp_ops && p->mp_ops->uninstall)
+			p->mp_ops->uninstall(rxq->mp_params.mp_priv, rxq);
+	}
+}
+
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh)
 {
@@ -11516,7 +11529,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		bpf_dev_bound_netdev_unregister(dev);
-		dev_dmabuf_uninstall(dev);
+		dev_memory_provider_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index df51a6c312db..4ef67b63ea74 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -308,26 +308,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return ERR_PTR(err);
 }
 
-void dev_dmabuf_uninstall(struct net_device *dev)
-{
-	struct net_devmem_dmabuf_binding *binding;
-	struct netdev_rx_queue *rxq;
-	unsigned long xa_idx;
-	unsigned int i;
-
-	for (i = 0; i < dev->real_num_rx_queues; i++) {
-		binding = dev->_rx[i].mp_params.mp_priv;
-		if (!binding)
-			continue;
-
-		xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
-			if (rxq == &dev->_rx[i]) {
-				xa_erase(&binding->bound_rxqs, xa_idx);
-				break;
-			}
-	}
-}
-
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
@@ -402,10 +382,26 @@ static int mp_dmabuf_devmem_nl_report(const struct page_pool *pool,
 	return nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id);
 }
 
+static void mp_dmabuf_devmem_uninstall(void *mp_priv,
+				       struct netdev_rx_queue *rxq)
+{
+	struct net_devmem_dmabuf_binding *binding = mp_priv;
+	struct netdev_rx_queue *bound_rxq;
+	unsigned long xa_idx;
+
+	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
+		if (bound_rxq == rxq) {
+			xa_erase(&binding->bound_rxqs, xa_idx);
+			break;
+		}
+	}
+}
+
 static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.init			= mp_dmabuf_devmem_init,
 	.destroy		= mp_dmabuf_devmem_destroy,
 	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
 	.release_netmem		= mp_dmabuf_devmem_release_page,
 	.nl_report		= mp_dmabuf_devmem_nl_report,
+	.uninstall		= mp_dmabuf_devmem_uninstall,
 };
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a2b9913e9a17..8e999fe2ae67 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -68,7 +68,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
-void dev_dmabuf_uninstall(struct net_device *dev);
 
 static inline struct dmabuf_genpool_chunk_owner *
 net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
@@ -145,10 +144,6 @@ net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return -EOPNOTSUPP;
 }
 
-static inline void dev_dmabuf_uninstall(struct net_device *dev)
-{
-}
-
 static inline struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
-- 
2.43.5


