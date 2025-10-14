Return-Path: <netdev+bounces-229227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85DBD9817
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FC6188434E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F10E314A7C;
	Tue, 14 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNJxVwN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFC1E5B60
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446838; cv=none; b=VEALg38wbNoNuKsnJK1p1KcL/eEzAMVizpyxDa0ApR1+vN4Amo2JjVgk4rZE3bOex2Bj3zWaSbGx5B+RKMBTElUZqzbhWnS0s2kC9GkFv3xhXUHY6u6rRIIUXgGg8AhkVN+nu5txFO3ER/6KUULAZINnbYqMej8wUhclrfdZhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446838; c=relaxed/simple;
	bh=O4ZG85nDGPd7PXtgdg5RSs+JAoveNaHnwwLAEnHUcfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYh86jG+t9Y7z2HYXkfiWjT4B1W6ZwFiMAmArPR8jeO0YOiGE7A/oDO0b4zNICef8rmu65dxShImEyrH3yhiS26rI4HZk9J6g7Np56Tx+IzPo0DU5EbU/iPNJAO5sLtiKOpucxlhMZBBTzNKiF9NnS4DfFFaeSacwPEixeDyvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNJxVwN7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so38445755e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446834; x=1761051634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKwnnsbFaZewVWohwl3HgurKLHOdfvo9hMFu7wHJP0I=;
        b=jNJxVwN7jtfAEHwYh89wIOWMY4ueO/AJFoLAOtsDzTmhYHUByWBM8OxaicH2yw4oSK
         i8ypgxoNEOQX+hckLc67YcaMxTs2tPUDgS0QlehK4bO/DDdiUvNemeTivKzcz9ZCBSOR
         mCrhNV8uV9iKa0zEK1HUoZ6kJcYQorLOSSmvaJQdgNiw6O+HmODRQTTWD1CI0b4stThm
         k/jvPIgBOK9nhJ67HMLREtkMTlkwl7RpL+HVdrQsNgy+yKZt2iQRsRPkNYChD3NdI6c3
         zSSa1ZnEoaiV3yVvHBwgebzWaCQboJ/MMxxJpbw4fMWuHzGnFMqNuh6gzWWIqbaf3Obq
         4weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446834; x=1761051634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKwnnsbFaZewVWohwl3HgurKLHOdfvo9hMFu7wHJP0I=;
        b=dnZFRTAjnERWKbab8/qma0dev/OPqArERUlQaQU35mBCs1DebhlAp9wXzlrMX3P41F
         pnCq2oODJZrSKfxWciRW2CXKjmM+qsIGWfRRh+fsB51OvvzI9C2MnDckNrTp5cCr9tkJ
         O9pe5d6TpmoTiTL2XCxdKqcMjCM3kPlnQPejsr/jf2CaZiBOJQrbj3uG3BbWRUjX9NQh
         7RzLCeedtaSMNSTzQOHYuBfmK3W4YVP+vM3oos3nzpZMZbVaUlgQzPdxcPTFIpuFIIzB
         vPfLYLWks7q+dq/sVk1G8GIkWFPH0zGeK1uRmXa5todS+5+rdnsv6HE8BPeSGcnCYgO6
         VQNQ==
X-Gm-Message-State: AOJu0YzrO4H+5WTo6yYd+MHU11/4lY9k0zDlCp/MtyU1/8eYlV9myfnt
	UtnXW9fdggsI5sLl5g1HXPQ+3/VHKjF8wvzuixtx5z2owAZfa2IUpoYcodhZJbEO
X-Gm-Gg: ASbGncvi2JXSoYBE9G2zk4WKnQjTat84J42sJN+nT9/O/FU3XEYToC1kdlpzUZk7YcF
	uah2zLIl0Pv64BaMOCiWtjRwtuZJdsb1Cx7Ey5qBZzYzYG9rJMaK/ZeM/xnlPF9ciXIlqqUOpuI
	KBlUFMCatviTZPDTW+A8Gf88loi/IfXQIRuLWcG5r+C4FeGBV30ZNU8ch0YkXLzSlF42znv++GE
	kkvR4pYM+zPKAMt7IFeS9rveviEoJwrvEvr5MEr1CSPM86PQmDoAAcdwy9VnAhCObA3yB0BR1um
	A5ttdLps8q32AmqoCBP8dAq+o9maBRpkhX5qzy4A1SLh7Ngt1mPe0Ha2hOgEXgp8wVbqf2LRSe/
	TeAPnYF9LQRmKm8OPbos5lIX+HB0LI4ReyHg=
X-Google-Smtp-Source: AGHT+IEsNg5cq0AbDD8HDQZYEec1USvgiKJ8GhktxA14/2sy5dbkpcXRXDd8Llt0GD6ejRT66hW41A==
X-Received: by 2002:a05:600c:3b2a:b0:461:8bdb:e8 with SMTP id 5b1f17b1804b1-46fa9b06c50mr186231295e9.30.1760446833629;
        Tue, 14 Oct 2025 06:00:33 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/6] net: let pp memory provider to specify rx buf len
Date: Tue, 14 Oct 2025 14:01:23 +0100
Message-ID: <363ecb9e10c64fd6c3a961c93879431d99601114.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow memory providers to configure rx queues with a specific receive
buffer length. Pass it in struct pp_memory_provider_params, which is
copied into the queue, so it's preserved across queue restarts. It's an
opt-in feature for drivers, which they can enable by setting
NDO_QUEUE_RX_BUF_SIZE to their struct netdev_queue_mgmt_ops.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h   | 9 +++++++++
 include/net/page_pool/types.h | 1 +
 net/core/netdev_rx_queue.c    | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..2e6bcec1e1e3 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -111,6 +111,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 			   int tx_start, int tx_end,
 			   struct netdev_queue_stats_tx *tx_sum);
 
+enum {
+	/* queue restart support custom rx buffer sizes */
+	NDO_QUEUE_RX_BUF_SIZE		= 0x1,
+};
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
@@ -130,6 +135,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
+ * @supported_params: bitmask of supported features, see NDO_QUEUE_*
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -149,6 +156,8 @@ struct netdev_queue_mgmt_ops {
 						  int idx);
 	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
 							 int idx);
+
+	unsigned supported_params;
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..be74e4aec7b5 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -161,6 +161,7 @@ struct memory_provider_ops;
 struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	u32 rx_buf_len;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a0083f176a9c..09d6f97e910e 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -29,6 +29,10 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
+	if (!(qops->supported_params & NDO_QUEUE_RX_BUF_SIZE) &&
+	    rxq->mp_params.rx_buf_len)
+		return -EOPNOTSUPP;
+
 	netdev_assert_locked(dev);
 
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
-- 
2.49.0


