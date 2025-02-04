Return-Path: <netdev+bounces-162764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A7A27DE6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8407A1772
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934B21C18F;
	Tue,  4 Feb 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aS6a/OId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610A21C172
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706193; cv=none; b=V6B3ERPjeZO2JgX+5JSZXlnneGZ92YtR4li+2Sd4v5aNZ+Ein3pB1K1PejUsU4cqx6DD63l3izJWBIMQS75LTdMvcarj4LgaSPvvczium0BtdF/vGEyW0U9osraUb9GQVIJbBjJak/DpjcFJNGxmr1Dp1GswJK19bwYv9uDP2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706193; c=relaxed/simple;
	bh=XhYDQi1clFZRqF7t94s2n85+aldNY7/iQ78okp5gHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGJNxJduiedOmRTBo0ibiE+T/22gDKrdu+K5PiMY+zGYZqo4ssUTwPW4nPI+9Yco+ScIKy6LCQNFtENU+ZreawrlrsmMGh9Kxt40medWUWo0CU8XPmmkp6iF8zNnNLlsiGFjxT6VjcZPmkR9C/3K37TeZ1W7MZ7gTaYvuy6e1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aS6a/OId; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21654fdd5daso106881265ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706191; x=1739310991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g2nOnsSPtyA6MdoGolfoJakySG02rGgvojfspNAyCg=;
        b=aS6a/OIdnQek5p3B5JN825NvTsj1t0JLBCH4/joz5ZZe5uyCU0e05HMlZDkY+1jHm7
         0fC54C0b7vWkJE5G8mkiQdWXRIqq8Tr2FCvs84QXLSC5rIa+rO65RUPs53oHi6AQY0bM
         V4/kMwPkUvwTc4SVYlcmsH4I19lI+d85j+OgRvAFmEzED32JIEY/KA6nSk1TwuYs1iKj
         dR3nQLvBqjgd8rC6KFVcHsRylex1ZKvbHy/pFF+WmU85xvHJnIgjq/NgtwMNE/AE40F+
         CmPp60dNPssLBZAIqz8luEboeluOoSCShB+hsJ9MZf5IsvKMAmTPr27BaWu2Dew++F8P
         genw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706191; x=1739310991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g2nOnsSPtyA6MdoGolfoJakySG02rGgvojfspNAyCg=;
        b=F/1NtP7VItUgB8eNDna1XByHYB5VGl9wMWLjGCw+o3uGXKIZls9JVRhZIYAgR/nFth
         Sr1fxaW3TdEohjA43XwqDSF9gwkopsK6d56h5PKQ2MFi+pIrP3gBEUg4DODn+PwvWvDy
         gYAFM3fmO6adO9ekwlhr8OUWVQpzrREq5D/LHikgrxwQNlJvqII6mWsFq0Q1LX2jp09m
         gAogCyA/OEkI6JTmA2LPjIJqtAL6t1DUFUJP902AWXdd9njAOefu1AwQg1RLJvtiesF9
         29A1puErs3Mf0TIuoIVWlaOi9f2RhesBUBzCwUe6vcz73fWM2jkfZVpgodYabHxcZ1cF
         C21Q==
X-Gm-Message-State: AOJu0YxRBjjNNbTd+X37bVk/cs7dRTRPMa1MJ1dGEqtkfQ4elDl6CF1S
	g2Pi7k+BgCMmneOJ/18Hpgb34idf1s0n+k5EMMZE4yHmP0KpG7wgdmbkJ4YoDfEmu41BTjcYJCX
	k
X-Gm-Gg: ASbGncsKEQvJmOpamwD4p+0sD7sBF9ueai7ZXoPTeJrFKIGz6Xqq2pCg7H8GQZ+15qB
	/cozMuCvQwCdp1axpgMn/PGc8fVZO71//Inut3jYI+hUfYfAvuBvHHMbiZywNM2HQZJjYEFeudr
	cTvhpGrxuFxRD7rhX70YMI9Rzu5Rtkp7odpFplTKmWGTIl1PDjLYYE576bcWG+4XDEP1X6ak+mi
	WAVmIGMWqgpsM2vjQDwgeIjVREn0O0YMlPhAbdtO8ksH/vlneMv9KjGzHHRsaEmxzPFlT4YMXcG
X-Google-Smtp-Source: AGHT+IEHNxA9nZZ4ojd4hmMyLsyMrw0GtwS7haEpSJLlJqXH1TN+CUmPiSZ7pF+S1MTCzT4HAGkOmw==
X-Received: by 2002:a17:902:f64f:b0:215:b75f:a1cb with SMTP id d9443c01a7336-21f17e26cf8mr7741275ad.9.1738706191206;
        Tue, 04 Feb 2025 13:56:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee5a2sm102015585ad.26.2025.02.04.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:30 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 07/10] net: page_pool: add a mp hook to unregister_netdevice*
Date: Tue,  4 Feb 2025 13:56:18 -0800
Message-ID: <20250204215622.695511-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  1 +
 net/core/dev.c                          | 16 ++++++++++-
 net/core/devmem.c                       | 36 +++++++++++--------------
 net/core/devmem.h                       |  5 ----
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 6d10a0959d00..36469a7e649f 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -15,6 +15,7 @@ struct memory_provider_ops {
 	void (*destroy)(struct page_pool *pool);
 	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
 		       struct netdev_rx_queue *rxq);
+	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
 };
 
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..384b9109932a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -159,6 +159,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
 
@@ -11724,6 +11725,19 @@ void unregister_netdevice_queue(struct net_device *dev, struct list_head *head)
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
@@ -11778,7 +11792,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		dev_xdp_uninstall(dev);
 		bpf_dev_bound_netdev_unregister(dev);
-		dev_dmabuf_uninstall(dev);
+		dev_memory_provider_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 63b790326c7d..cbac6419fcc4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -320,26 +320,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
@@ -415,10 +395,26 @@ static int mp_dmabuf_devmem_nl_fill(void *mp_priv, struct sk_buff *rsp,
 	return nla_put_u32(rsp, type, binding->id);
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
 	.nl_fill		= mp_dmabuf_devmem_nl_fill,
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


