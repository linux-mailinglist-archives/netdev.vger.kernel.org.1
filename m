Return-Path: <netdev+bounces-132875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EB9939F6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841F3B22987
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0318F2F9;
	Mon,  7 Oct 2024 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="P+uAkpIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561518DF92
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339394; cv=none; b=XFBnhu1NxKIUx1B0KtUwI7yFmwAefTpln8e1snVZDnpBSY9bUtek/fm9KVi4/QMC0Amq9VKn0Bwc+DnPx3PNkikjuxagVBAyPNghxnu48WUZ415+f9lpqSXC+l2Gbt6wVoc8qrv814EHiFJSXyQzzo0EUSRYfi0NrShqi/zWV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339394; c=relaxed/simple;
	bh=9AXdipc3QXUbfcOG5e2XU6AisZjBFHEUE/Y2qDzheoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHqjD+iTE6r6WO/gVRqvfbS6sP2wCbrTUGgven24xwgu1dLrvOLyvuaoQIYxUorv0x8yYbltR4jLhMFPhwcgPVF1P4VOb/HiAvNAEIfG3EPu/hBlUWMAuUHTeY+RJRlIYlzb72ovFzMjAgDkoWJlF8aYrf1q6Kp2DjR59aKieIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=P+uAkpIR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71df4620966so2273700b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728339392; x=1728944192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS0lteTo5Hva+/YqOQiRdxRtksi+N5V23PlOptkcu2c=;
        b=P+uAkpIRMTguuR26TaV1wDpMqyjzUT5+SQSat2BNci+6Z/sfI0ejhWCbVJMCwMPaHb
         bdb5VCWECG1TGu1ybj7bc/CZTswcedppNBPVmVt4mbltDlUvrNA8oL/aPe9NJPqQ1ZwM
         JMRkdkwFFiSa4Xs8e4GMzm4RnlX9MfWcXFd1fdZS0e4OqNGDNH0gAe53puN23IU+lkbB
         iE2qAIxQ8AZWGIo0iVjRWJ5hIom/mt66O3EzSjtPw/tPQT+VwAeGpybnhGKEbV3OA44C
         OGLqe2rSv9SbHgdfn2gs4Tg5bGZ7Fgz0KQmk49v+Pkzl/uvgIPnKtDHcLPFt3BA/fW0J
         woXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339392; x=1728944192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS0lteTo5Hva+/YqOQiRdxRtksi+N5V23PlOptkcu2c=;
        b=tbAQ4qhUgYwT8b3ZJmoPdKuajiMnjKDeX0x8XIeOf2QGnKKC05w8Sbq7Ntoi6oT7ue
         64jtFH5i/54HmPoaPCCFCVLbP5JfRqpwYfJZIgrSRgFSW2MYmY6iU6cdLbNjCVyE1q4F
         Y8/LBd8k3uKE72p4LiDe+0F6lVXfFLRwAnu90jad44Z2dgDTko50O4MJTtvus88ZGQlT
         j/A39G/m9SEouWBzAjzTlLHYPkUXmvzNlL25SkCNXq6aimNGP2g+4OXvfDKqOGyGry7l
         2lQIACkARK6eWUi9nEURliZPU/0fmdsmJkCtrbmapBsd3jDXftTaDaozHW4DQjzxtmVM
         99uA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5lFG4csz1mL/IV/jOqe+wW5lJh1L40QJ4rjmIUCwn0WvMg19sZ6BkhugSB2GRMcK6wj8Z/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPyYLRvUSaaJ5CITVoJss/s65UZn8E4aau/Cyrlp2Mp5sOF9v
	KGG80xh3CcVx4wvtG0KhsH5qlf1OVeF6vRM6XqR70tu5JIBnIea1MHHGL0gFYY8=
X-Google-Smtp-Source: AGHT+IFXbhBWPDSf8ngFYxv2ddrFCuI2V7jMFKQKrZPa0qXRJUBBmznIA7t/ng0DPLetuwWQnarHsw==
X-Received: by 2002:a05:6a00:3c83:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-71de22e8399mr24121525b3a.0.1728339392206;
        Mon, 07 Oct 2024 15:16:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-037.fbsv.net. [2a03:2880:ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d62591sm4921263b3a.150.2024.10.07.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:16:31 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v1 04/15] net: page_pool: create hooks for custom page providers
Date: Mon,  7 Oct 2024 15:15:52 -0700
Message-ID: <20241007221603.1703699-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

The page providers which try to reuse the same pages will
need to hold onto the ref, even if page gets released from
the pool - as in releasing the page from the pp just transfers
the "ownership" reference from pp to the provider, and provider
will wait for other references to be gone before feeding this
page back into the pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Pavel] Rebased, renamed callback, +converted devmem
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h |  9 +++++++++
 net/core/devmem.c             | 13 ++++++++++++-
 net/core/devmem.h             |  2 ++
 net/core/page_pool.c          | 17 +++++++++--------
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..8a35fe474adb 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -152,8 +152,16 @@ struct page_pool_stats {
  */
 #define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
 
+struct memory_provider_ops {
+	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
+	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
+	int (*init)(struct page_pool *pool);
+	void (*destroy)(struct page_pool *pool);
+};
+
 struct pp_memory_provider_params {
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 };
 
 struct page_pool {
@@ -215,6 +223,7 @@ struct page_pool {
 	struct ptr_ring ring;
 
 	void *mp_priv;
+	const struct memory_provider_ops *mp_ops;
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5c10cf0e2a18..83d13eb441b6 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -117,6 +117,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(rxq->mp_params.mp_priv != binding);
 
 		rxq->mp_params.mp_priv = NULL;
+		rxq->mp_params.mp_ops = NULL;
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
@@ -142,7 +143,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
-	if (rxq->mp_params.mp_priv) {
+	if (rxq->mp_params.mp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
 		return -EEXIST;
 	}
@@ -160,6 +161,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 		return err;
 
 	rxq->mp_params.mp_priv = binding;
+	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
 
 	err = netdev_rx_queue_restart(dev, rxq_idx);
 	if (err)
@@ -169,6 +171,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 err_xa_erase:
 	rxq->mp_params.mp_priv = NULL;
+	rxq->mp_params.mp_ops = NULL;
 	xa_erase(&binding->bound_rxqs, xa_idx);
 
 	return err;
@@ -388,3 +391,11 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	/* We don't want the page pool put_page()ing our net_iovs. */
 	return false;
 }
+
+const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
+	.release_netmem		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 12b14377ed3f..fbf7ec9a62cb 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -88,6 +88,8 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 
 #if defined(CONFIG_NET_DEVMEM)
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..c21c5b9edc68 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -284,10 +284,11 @@ static int page_pool_init(struct page_pool *pool,
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
+		pool->mp_ops = rxq->mp_params.mp_ops;
 	}
 
-	if (pool->mp_priv) {
-		err = mp_dmabuf_devmem_init(pool);
+	if (pool->mp_ops) {
+		err = pool->mp_ops->init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
 				err);
@@ -584,8 +585,8 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 		return netmem;
 
 	/* Slow-path: cache empty, do real allocation */
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		netmem = mp_dmabuf_devmem_alloc_netmems(pool, gfp);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
@@ -676,8 +677,8 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
 	bool put;
 
 	put = true;
-	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_priv)
-		put = mp_dmabuf_devmem_release_page(pool, netmem);
+	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
+		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
 		__page_pool_release_page_dma(pool, netmem);
 
@@ -1010,8 +1011,8 @@ static void __page_pool_destroy(struct page_pool *pool)
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 
-	if (pool->mp_priv) {
-		mp_dmabuf_devmem_destroy(pool);
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
 		static_branch_dec(&page_pool_mem_providers);
 	}
 
-- 
2.43.5


