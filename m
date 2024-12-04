Return-Path: <netdev+bounces-149102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66339E431A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BBB64D2C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B921638A;
	Wed,  4 Dec 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pGD6cees"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC3215F73
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332980; cv=none; b=l6KzVl/O1B88MkkfpzqN7CPu7Eryvo3sNh9OApRHEFrcUGRZO9j6P+uK+YJvPAds6vgLDqs6UesmLHvDGr+DOqu4nan8tzRvjLRbm3t73vQpIRy95vkLjzHefr39m73LMf+pNSrSNX7heW1YlitAdPSUHpCgkgexyhdJNRoD7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332980; c=relaxed/simple;
	bh=yHkBS0Ae7tWKphGIsp/BscufJpA2CS64Q5wOxYY5YaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EywE0IncEkEAkJjmUi4gl4MjkQiRe5tEaBNywAV0il5C/pVko+rFHvXvAoABwemYx62HVJEa9TwbZMBnGkS6DHc1a2FUtAR5oIqgJqoO6tVfCO3/GOgNFd0e0FvcUHlIfAwt+H4xWkfjM1GSy9IpJvkwXBDRsvS99qNsY03DV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=pGD6cees; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7258ed68cedso57607b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332979; x=1733937779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VznSQpWwqyyoWSCkKyMSe9FismvnJKrDHHL+sPjQaA=;
        b=pGD6ceesua5fqcoDyv6tYtlyfBSCa74Ez8d8BPc+DWDUbdTkR7oqw7Z06A4lDTpRqW
         cMB/SAy8Nx97kwed1h2TYDAtCewFDjz+A1pPUuAH/lfo3dMVhvhw4TJuS/nBbKyioINg
         j6uFVqFDg8cd/iRfoNmC5TKG6lJpXPTZZapOh7GNxQDeIcvYCURtyMoD8NkjY0LCaBHK
         1+woBjiyw5H/r+SR/4j56/clo2iyPjidb3D2IR02hNRyvTkg6pS6EW9ZmuKKJAoBuGji
         xYXrH1mvI5fn9kELhX7Rmbixan/slt0NYgxPte5MhaVPDFxkOa9rVzFgbI37jaw7hqVP
         uYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332979; x=1733937779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VznSQpWwqyyoWSCkKyMSe9FismvnJKrDHHL+sPjQaA=;
        b=vJsnRHmXz7JT2mrbJQFlfYKtCMVQhSp86qsTxScFSI7G5O5egGTx7d8fRQTY/6mwgq
         sDI9oYwQQd0FN5IdEt4DZ98huEK5rCvAaGEl+AAKhqTy1nx03fN8lbIMoKHgNxXZfvse
         rm24cLT9fe3w1OOQ0uwlymL26cEc/zfIf33U/onQwtLGDBLcK66gtLfWWR5Ikn9Midbh
         KmdrWGc/bBbjDBkKz00t04nQOxTPC6cVMlkWHILPpzU3cTb0KwUQ4seDKfBRBfFlZ0ge
         b5Iby84DH3XC+EJC+sdGKecp1goljctiB7HpiipSsJ8xiWkxpa+5qi6vsSQwygws6w1x
         5aYA==
X-Forwarded-Encrypted: i=1; AJvYcCUn2kc0gUAqUMXhq/11WsbWsQwPXnYSonfMtUV6n69R7kh/7vbY+VVuuhgBoqaope1NQrDANu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7tNFxNPvEJfeyual4G9IFh68sPM51xSbX6oHpgBs37mwlkSb
	ZmNJ86DwF/c1vcpH17xe8co+Dl5a7kUCVxgsPBQSvdtbsgxaLhpEZY2tW3D0baU=
X-Gm-Gg: ASbGncuXubKnx2h5BqUYQMbEpbUmUpn0f7MQeDpCJvDSHmAWUySkgRhEnaTKWgxOwqc
	dOnvAp4h0l4LuqkFcvR+w9q5Kx1ON8vyA6mBrpDspDKm+7DQpsvByOPO/ku1Cw1F4I5jB7PLZSo
	o4kfdAaN0JeihDO/42b1lOk1g0wqTSjs4DHPX3/PFOetp/xX9zuqWiv5qNZMndBchJfGIdu3hrZ
	Kcyn4MBwDFnycTZmf9xN4y/TsZkW41F+w==
X-Google-Smtp-Source: AGHT+IEYZB2vCFuL7ZbQFmggnrjBxbbYL45SNh5yqfMSBWNINZX4pOWFcZW8ol1Bys8QeuJPGdAFuA==
X-Received: by 2002:a05:6a00:3c96:b0:725:9ac3:f35 with SMTP id d2e1a72fcca58-7259ac31291mr1468948b3a.4.1733332978687;
        Wed, 04 Dec 2024 09:22:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762c0csm12633993b3a.33.2024.12.04.09.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:58 -0800 (PST)
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
Subject: [PATCH net-next v8 13/17] io_uring/zcrx: set pp memory provider for an rx queue
Date: Wed,  4 Dec 2024 09:21:52 -0800
Message-ID: <20241204172204.4180482-14-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204172204.4180482-1-dw@davidwei.uk>
References: <20241204172204.4180482-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

Set the page pool memory provider for the rx queue configured for zero
copy to io_uring. Then the rx queue is reset using
netdev_rx_queue_restart() and netdev core + page pool will take care of
filling the rx queue from the io_uring zero copy memory provider.

For now, there is only one ifq so its destruction happens implicitly
during io_uring cleanup.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 92 +++++++++++++++++++++++++++++++++++++++++++++----
 io_uring/zcrx.h |  2 ++
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 004730d16e8f..0cba433c764a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -8,6 +8,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <trace/events/page_pool.h>
+#include <net/netdev_rx_queue.h>
 #include <net/tcp.h>
 #include <net/rps.h>
 
@@ -36,6 +37,65 @@ static inline struct io_zcrx_area *io_zcrx_iov_to_area(const struct net_iov *nio
 	return container_of(owner, struct io_zcrx_area, nia);
 }
 
+static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
+{
+	struct netdev_rx_queue *rxq;
+	struct net_device *dev = ifq->dev;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (ifq_idx >= dev->num_rx_queues)
+		return -EINVAL;
+	ifq_idx = array_index_nospec(ifq_idx, dev->num_rx_queues);
+
+	rxq = __netif_get_rx_queue(ifq->dev, ifq_idx);
+	if (rxq->mp_params.mp_priv)
+		return -EEXIST;
+
+	ifq->if_rxq = ifq_idx;
+	rxq->mp_params.mp_ops = &io_uring_pp_zc_ops;
+	rxq->mp_params.mp_priv = ifq;
+	ret = netdev_rx_queue_restart(ifq->dev, ifq->if_rxq);
+	if (ret)
+		goto fail;
+	return 0;
+fail:
+	rxq->mp_params.mp_ops = NULL;
+	rxq->mp_params.mp_priv = NULL;
+	ifq->if_rxq = -1;
+	return ret;
+}
+
+static void io_close_zc_rxq(struct io_zcrx_ifq *ifq)
+{
+	struct netdev_rx_queue *rxq;
+	int err;
+
+	if (ifq->if_rxq == -1)
+		return;
+
+	rtnl_lock();
+	if (WARN_ON_ONCE(ifq->if_rxq >= ifq->dev->num_rx_queues)) {
+		rtnl_unlock();
+		return;
+	}
+
+	rxq = __netif_get_rx_queue(ifq->dev, ifq->if_rxq);
+
+	WARN_ON_ONCE(rxq->mp_params.mp_priv != ifq);
+
+	rxq->mp_params.mp_ops = NULL;
+	rxq->mp_params.mp_priv = NULL;
+
+	err = netdev_rx_queue_restart(ifq->dev, ifq->if_rxq);
+	if (err)
+		pr_devel("io_uring: can't restart a queue on zcrx close\n");
+
+	rtnl_unlock();
+	ifq->if_rxq = -1;
+}
+
 static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 				 struct io_uring_zcrx_ifq_reg *reg,
 				 struct io_uring_region_desc *rd)
@@ -161,9 +221,12 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	io_close_zc_rxq(ifq);
+
 	if (ifq->area)
 		io_zcrx_free_area(ifq->area);
-
+	if (ifq->dev)
+		netdev_put(ifq->dev, &ifq->netdev_tracker);
 	io_free_rbuf_ring(ifq);
 	kfree(ifq);
 }
@@ -222,7 +285,18 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 
 	ifq->rq_entries = reg.rq_entries;
-	ifq->if_rxq = reg.if_rxq;
+
+	ret = -ENODEV;
+	rtnl_lock();
+	ifq->dev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
+				       &ifq->netdev_tracker, GFP_KERNEL);
+	if (!ifq->dev)
+		goto err_rtnl_unlock;
+
+	ret = io_open_zc_rxq(ifq, reg.if_rxq);
+	if (ret)
+		goto err_rtnl_unlock;
+	rtnl_unlock();
 
 	ring_sz = sizeof(struct io_uring);
 	rqes_sz = sizeof(struct io_uring_zcrx_rqe) * ifq->rq_entries;
@@ -231,16 +305,17 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	reg.offsets.tail = offsetof(struct io_uring, tail);
 
 	if (copy_to_user(arg, &reg, sizeof(reg)) ||
-	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd))) {
-		ret = -EFAULT;
-		goto err;
-	}
-	if (copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
+	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+		io_close_zc_rxq(ifq);
 		ret = -EFAULT;
 		goto err;
 	}
 	ctx->ifq = ifq;
 	return 0;
+
+err_rtnl_unlock:
+	rtnl_unlock();
 err:
 	io_zcrx_ifq_free(ifq);
 	return ret;
@@ -262,6 +337,9 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
 void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 {
 	lockdep_assert_held(&ctx->uring_lock);
+
+	if (ctx->ifq)
+		io_close_zc_rxq(ctx->ifq);
 }
 
 static void io_zcrx_get_buf_uref(struct net_iov *niov)
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index ffc3e333b4af..01a167e08c4b 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -5,6 +5,7 @@
 #include <linux/io_uring_types.h>
 #include <linux/socket.h>
 #include <net/page_pool/types.h>
+#include <net/net_trackers.h>
 
 #define IO_ZC_RX_UREF			0x10000
 #define IO_ZC_RX_KREF_MASK		(IO_ZC_RX_UREF - 1)
@@ -36,6 +37,7 @@ struct io_zcrx_ifq {
 	u32				if_rxq;
 
 	struct io_mapped_region		region;
+	netdevice_tracker		netdev_tracker;
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
-- 
2.43.5


