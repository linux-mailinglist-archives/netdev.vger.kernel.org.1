Return-Path: <netdev+bounces-159085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD9A14542
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5E4188B988
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C9244FA8;
	Thu, 16 Jan 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Rs06UutY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61D2442FF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069442; cv=none; b=hQn4+48oS1jkbRlFL5ylLvRKRB9R4gRzTFe5E+z9O4ILnAgm8k8b4RhgDxyO0LmZykt5q81gDl9oY6rooKCqJZ4GS5iLZ2udP8w2cyoHEPXaN+IcFt/gED1WuYaomZI73oImr1vJjuKZffDA60pYnrP9uJel3vqZ7aT8J/8FYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069442; c=relaxed/simple;
	bh=ni+GBCJpV+6e9Z3Jx+ASe5psY3mF/X+C2+8/GRsJcxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNORI+FqyhNWdbb+wYCt1DQX0G/v61E0vA7M3ztYTuOnJb1LCxBLCUPEmcmtFMWBmmicOGdkuFrCZI5ETCU374nA7O++9nvyrg0TBU3sWmi6tBapusqLtQjj60zMd0Z1gX4r3TUkFsCTf86vDjUVNIO4kTDj6E8j3/8UVAhaZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Rs06UutY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21636268e43so34638025ad.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737069440; x=1737674240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNe5O6sLZLRlzUpONmh0BhOdwH0c/mpvhiy7fWtyNiI=;
        b=Rs06UutYlsnhpgzvSNFfgyJIVRU4l0AcgCtBvZi09Wxd+e8cXken7IlHlEjKd60Auu
         5onojg0PGDSW3qSjuvrECOqkllCnwjAvEIkgLBmBwrP9U4x9+4neS/lyROHMZjj1uluI
         FxaHx49+DF5RcPd1LPF/qgMMv+Wa8tonaDUsZFAYdDXFFsCy4yayoJ++4eI0CruRVZ8n
         cQK3PgdawqfijStdqc2r9spxyzVrBd3eQrmhR6s58EBEvIvh2GeXcYQB/x4OWENB2/wg
         S8FWR4D54vPaJq2kWlByJDkZxGQfHtlXpaDrIOGZL+4BX4Rx2N3k4GeLWV5DgrG1BdBh
         VzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069440; x=1737674240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNe5O6sLZLRlzUpONmh0BhOdwH0c/mpvhiy7fWtyNiI=;
        b=OsZDsNP4YaN3Dsr9BW91zFOct8vkAHEKqaQ4yAQR2yVXWWzmCG2ylgTemfF9GgnTiq
         XmPpdgi8Mczr8xBHd1lATqoLFqAmMGN/RMlk/nX/zh6jGA9umva+sxF9bGs5Y6VhvGG8
         1khI8i5sfcSbMvzt+OXh+RqQRvkLupVGNYGGlP5+2g14u89wzQK5AX/Mxo61j0nKlj/p
         gT7RHPdGT9+z+ZMivODxyJ/1YbR53/mpNyF1DFhu/Hcn8LNFs2xHwQYkFAw0p+e2kufa
         CYOHhivE8poEyPS22XPAsMS4Qu4D9rmpa5kixGC4WzWxAeMyholR9j3EyOpQp1qOlspo
         0KaA==
X-Forwarded-Encrypted: i=1; AJvYcCVvOcRJm4NTQ9XLqh0pJb34Wd8wZkxwJyE6w4wADDhdrp+/l3484PVNJXo6RA07lTtI1OgNlwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkvvwdq4cRzjOpdhEuXS1n9Mz8zWi4cz1lS7T2zDS1VVCFEhg
	wxDU0YHHzlnTP7WyCudVv2RUpRCP4NxXQMoAS2Wk/GmZ7zaIu0yalDqluvHj6QE=
X-Gm-Gg: ASbGncvPJWYllznP11Ia55ZUoPTMBPxbhPcN+HGTGQM0k/DzFfk51ffWoGkJQV20Cr1
	EdmJvlZTSaQ9fLAJL0FtZZ6v4eiSf9phzsreL0Xol+4XNgZ5MHhW5nfYvPdOwTf7/SSKCBetuO2
	Y7r1JYFTcLUtovebZj9J4sAYJRw6+GOWfswzUL1R+S5MJniJnRYE5M3/GEsFaDSQRLram6ThuMs
	kv5jagmCFKJr6vdLG1MI3sMKwFSEgBAvUwmIXw3f+NlN0M23AU=
X-Google-Smtp-Source: AGHT+IFPCVAzi3Y7iLEYB+1MNFlWMBosh0pxQi8qGeMSUjYARBehDaU52qL2+q2dZYAo0YhvuCRF+A==
X-Received: by 2002:a05:6a00:330b:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-72dafba2625mr993459b3a.20.1737069439794;
        Thu, 16 Jan 2025 15:17:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c9462sm547474b3a.100.2025.01.16.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:17:19 -0800 (PST)
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
Subject: [PATCH net-next v11 10/21] net: add helpers for setting a memory provider on an rx queue
Date: Thu, 16 Jan 2025 15:16:52 -0800
Message-ID: <20250116231704.2402455-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116231704.2402455-1-dw@davidwei.uk>
References: <20250116231704.2402455-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers that properly prep or remove a memory provider for an rx
queue then restart the queue.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  5 ++
 net/core/netdev_rx_queue.c              | 66 +++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 4f0ffb8f6a0a..b3e665897767 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -22,6 +22,11 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
+int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+		    struct pp_memory_provider_params *p);
+void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+		      struct pp_memory_provider_params *old_p);
+
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
   * @pool:      the page pool to place the netmem into
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index e217a5838c87..e934568d4cd9 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -3,6 +3,7 @@
 #include <linux/netdevice.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "page_pool_priv.h"
 
@@ -79,3 +80,68 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	return err;
 }
+
+static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+			     struct pp_memory_provider_params *p)
+{
+	struct netdev_rx_queue *rxq;
+	int ret;
+
+	if (ifq_idx >= dev->real_num_rx_queues)
+		return -EINVAL;
+	ifq_idx = array_index_nospec(ifq_idx, dev->real_num_rx_queues);
+
+	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	if (rxq->mp_params.mp_ops)
+		return -EEXIST;
+
+	rxq->mp_params = *p;
+	ret = netdev_rx_queue_restart(dev, ifq_idx);
+	if (ret) {
+		rxq->mp_params.mp_ops = NULL;
+		rxq->mp_params.mp_priv = NULL;
+	}
+	return ret;
+}
+
+int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+		    struct pp_memory_provider_params *p)
+{
+	int ret;
+
+	rtnl_lock();
+	ret = __net_mp_open_rxq(dev, ifq_idx, p);
+	rtnl_unlock();
+	return ret;
+}
+
+static void __net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+			      struct pp_memory_provider_params *old_p)
+{
+	struct netdev_rx_queue *rxq;
+	int ret;
+
+	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+		return;
+
+	rxq = __netif_get_rx_queue(dev, ifq_idx);
+
+	if (WARN_ON_ONCE(rxq->mp_params.mp_ops != old_p->mp_ops ||
+			 rxq->mp_params.mp_priv != old_p->mp_priv))
+		return;
+
+	rxq->mp_params.mp_ops = NULL;
+	rxq->mp_params.mp_priv = NULL;
+	ret = netdev_rx_queue_restart(dev, ifq_idx);
+	if (ret)
+		pr_devel("Could not restart queue %u after removing memory provider.\n",
+			 ifq_idx);
+}
+
+void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
+		      struct pp_memory_provider_params *old_p)
+{
+	rtnl_lock();
+	__net_mp_close_rxq(dev, ifq_idx, old_p);
+	rtnl_unlock();
+}
-- 
2.43.5


