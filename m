Return-Path: <netdev+bounces-208270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648FB0AC86
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCCD7AD1B8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17E22D7B9;
	Fri, 18 Jul 2025 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0YE5Oyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FF22A4F6
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880858; cv=none; b=RTT3Um6nzlZRbDfNJT1HdEaU94+IMUVsY01DrCZ3c5bIpRbXOOTQP1MCGEr0kJA7dojBci7edyVTRR7M5O6LdSKF+t3u//RiAkFbjQzAeE9mYhbjqeI3k7allvwxl1RGg8sSOzM6lvKcAcvLeP1uvtOGnhgS2lrjPstnm9KJhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880858; c=relaxed/simple;
	bh=JlQkiAQrawqOaIacfpGGxADETLyTk1yqdYObyxwbt6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrTv9OeBr3tD7+bnmxTJv1ppWRj0zYFFC7xTsUrr+iBHq1NppLBQ9W7AjbFS6MOQZirUvmlLIj5fMELEVPQ4GrTqPBJXXLhsGHmDnCwNy4GyS0t+3eLyVa4juYOp8ZkrwMPg6GIqzvtCikDQSHzO65HLlPudhNHK6TQVS3f/jPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0YE5Oyj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea7007866so2465577b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752880856; x=1753485656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxPmpnaA8JUrrmkVf/IZ87W8HbC2SlfKdXDPlTBP4xY=;
        b=w0YE5OyjHyBNpsCmo48EkkOHFaEJqn6pjZDkGzo2mHXw6xJiakuZNiHwvKt9I1J5KO
         CK/DJUQrgrpmsX5HkdCK7ofnuMbZiUinHbUWpd9wjgp4vDdzdQe5LZoVV2DURHUEFUkL
         BqhClmuWCIZj5bOEKLxxplCWfAiNFokAYNZHgwdZII+LmU5lMCl7X+wqorZMCMLrgkbM
         g9HNdnO0+K0Dd3HRauCOBwHfD9bOBsw8l7vFqbmFzt+lnkLJxqHUoZMzCWuvCjZPd9tw
         noCoBc8BLzpADX8bqrA/0RTEmZAymNC35ABdPTi9rXJyIKGP3l2ikwhlXIGQbzGTb1tv
         irFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880856; x=1753485656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxPmpnaA8JUrrmkVf/IZ87W8HbC2SlfKdXDPlTBP4xY=;
        b=LX7pZe6OuZkvTcXQLriYZreZv/FrG0nmZYQKE+rWTLemoawijkhh+gYRfYXIuJBrb2
         o+Z6EjTcFdN+SrIXglST7tMKMwaFd9Lzc5nvuWwTDLtO1MYYgUKunwjnlKQeba2HzJgA
         I6AeAO508rbnEUxLw0ipW2bW06xFeJq9PgOgu0jGLYOv3eu8riji9T/Cfpd9FQKv4Sic
         qV3G4UL2L0fKnAB2LIqKH0D5tbV6uw0s/k8h4kVT+qsKgDFK6ijq4muvJEbtkzXL+0r7
         ilbfpKAJGTCmBanKWntNtJdk8M7fm5OYAyMjeJq5oWyjqCTb2Es1/Np34X9ujaq8g7sZ
         H6qQ==
X-Gm-Message-State: AOJu0Yzo5IVHNwAY4r4qLD8aDF8v6I1xQSM+spqp4qtM4ng2LlPzwt/B
	NgTjCRHBdcXCjzFQ20tidSOKh4r1vf3vkJ4Co7Xzef8Q2R1ABBRi7il+R4kMNN1eRzBJ2iVsrn0
	BIoHLYXLYN4uHVA==
X-Google-Smtp-Source: AGHT+IFvel7Oxp3S5QS/flRBmQJsskfW+tyVatMhHEjqFIdFUqS8sdu7FeQ8e6iVN9HVokmIZrTNEcZkOkgh2Q==
X-Received: from pfbml7.prod.google.com ([2002:a05:6a00:3d87:b0:749:30b5:c67e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2da4:b0:748:ff4d:b585 with SMTP id d2e1a72fcca58-75724c8c841mr17593927b3a.19.1752880856151;
 Fri, 18 Jul 2025 16:20:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 23:20:48 +0000
In-Reply-To: <20250718232052.1266188-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718232052.1266188-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718232052.1266188-3-skhawaja@google.com>
Subject: [PATCH net-next v6 2/5] net: Use dev_set_threaded_hint instead of
 dev_set_threaded in drivers
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Prepare for adding an enum type for NAPI threaded states by adding
dev_set_threaded_hint API. De-export the existing dev_set_threaded API
and only use it internally. Update existing drivers to use
dev_set_threaded_hint instead of the de-exported dev_set_threaded.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c       | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c        | 2 +-
 drivers/net/wireguard/device.c                  | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c    | 2 +-
 include/linux/netdevice.h                       | 2 +-
 net/core/dev.c                                  | 7 ++++++-
 net/core/dev.h                                  | 2 ++
 9 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index ef1a51347351..4519379d284c 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	dev_set_threaded_hint(netdev);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 058dcabfaa2e..268b830ce17e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	dev_set_threaded_hint(mlxsw_pci->napi_dev_rx);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9f4976a3527..31b2cb11764d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			dev_set_threaded(ndev, true);
+			dev_set_threaded_hint(ndev);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 4a529f1f9bea..1f3e4e7cc90a 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,7 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	dev_set_threaded(dev, true);
+	dev_set_threaded_hint(dev);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index d51f2e5a79a4..d6412330d8ef 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,7 +936,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(ar->napi_dev, true);
+	dev_set_threaded_hint(ar->napi_dev);
 	ath10k_core_napi_enable(ar);
 	/* IRQs are left enabled when we restart due to a firmware crash */
 	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index b6a2746c187d..bd62a87aabfe 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -34,7 +34,7 @@ mt76_napi_threaded_set(void *data, u64 val)
 		return -EOPNOTSUPP;
 
 	if (dev->napi_dev->threaded != val)
-		return dev_set_threaded(dev->napi_dev, val);
+		return dev_set_threaded_hint(dev->napi_dev);
 
 	return 0;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e49d8c98d284..87591448a008 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -589,7 +589,7 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded);
+int dev_set_threaded_hint(struct net_device *dev);
 
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
diff --git a/net/core/dev.c b/net/core/dev.c
index cc216a461743..d3f72e5f4904 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7025,7 +7025,12 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 
 	return err;
 }
-EXPORT_SYMBOL(dev_set_threaded);
+
+int dev_set_threaded_hint(struct net_device *dev)
+{
+	return dev_set_threaded(dev, true);
+}
+EXPORT_SYMBOL(dev_set_threaded_hint);
 
 /**
  * netif_queue_set_napi - Associate queue with the napi
diff --git a/net/core/dev.h b/net/core/dev.h
index a603387fb566..23cbeaad8ca2 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -322,6 +322,8 @@ static inline bool napi_get_threaded(struct napi_struct *n)
 
 int napi_set_threaded(struct napi_struct *n, bool threaded);
 
+int dev_set_threaded(struct net_device *dev, bool threaded);
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
-- 
2.50.0.727.gbf7dc18ff4-goog


