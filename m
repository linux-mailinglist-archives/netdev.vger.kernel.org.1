Return-Path: <netdev+bounces-208766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E07B0D003
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DF73B66F1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4128BA9C;
	Tue, 22 Jul 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2nPSoP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27228BA91
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153654; cv=none; b=IX7jLyqVdO1s/rxRw6y2k5R7Y8OtjXv0u/s+L1ks/lk/bX4z+wfgWZvvyrjqbVg4uWW+QiZsOlFSbmNlEULSoCJgUvpwzJrS7bTwTKCKdsRntEkN7krzHKQSrCI5w2cSqpUSkZunpSPWB9SJi+tr83R7pJ6qEHhbcrJ3TrDu3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153654; c=relaxed/simple;
	bh=RrK2Bpf6+nUkqp6abapn8jiVhbqkuN8RowXTgI7ak88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Flh8Bk8dmPArNID004GfG6yIjJTdolyBJmA+2dJhP11XnPapdvx6gAlQg6W6ws6RzIcUqzjd7YENyuYEbGnqVNsoiwfMf2Uwbv717Ln/n9XEMqHLQgQ4Dj6J24R5zZV1eK1iNEuZ5OxV1ceDkeT49sur//xbOinTQF1bjvGG0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2nPSoP4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso4444289b3a.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753153651; x=1753758451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ2qyIBFEtXCfeFLDbRynZdG5edj3U9+c4g0kE3CNVE=;
        b=x2nPSoP4gcFl24/NafOH49Oz1NXR36MiPOt3MQn81kSoZWFxDOTbS/WlVrUiB7jPU6
         H/nXjzKZiGF1fH1R9Pj4zrMo/YladtiAA5/P+A6Ys5Wi4N7bC5ujyKRqDlorB2l61m1p
         hlLLPfK39bu9iGwWMDzw603rzMyfg7tVOWoq9dsZz5Eq21XcztPkpS+5fEum8W989a+O
         4BGDlnHD7O0xefEQMVyqxwU969RnCUPKb6tQPun+FCXtxaP38hSrV8NgaRydT3NlUOCh
         zYIbREpnqAUw8l8kQPfyMUvvnAP6ZM8IzpvwkxKqk7EQJYc27mH98ANIXc08258tBv7j
         H6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153651; x=1753758451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ2qyIBFEtXCfeFLDbRynZdG5edj3U9+c4g0kE3CNVE=;
        b=qE9rQJYXZd92WjzpgYu6MKpYDSM+zIHP29ZSQoPddkZq2g2UvUOI9pC5y9jJ8SuCYJ
         ayNXFxElH313/uAyPPMMhOYuzHFM27+1SmyEJUXe//pLVXNRcxptJVO6B/xF6ujetWlF
         J/NbGloZbVG/u1LgfNwuhPwoCzU81dRJzUPRbrxcH/9AqPV6TjcKUo7WR+O5jPXSsYiE
         7rkuHbAaSxlvBSsOx1LR6FFPqFnEjXbVF0wErEARq8OYr2QdT7Qc6GMm5cqFixziHYRF
         aJDnIqdWJVEapOkuCiA02sH8ZhXbXZJEB0+r5CDiJapDA573+Jn2FSh2n5MWtsOJwNj7
         BV/g==
X-Gm-Message-State: AOJu0YxMfkTupnUBZhrzSknhHYYlTMFO7tn/uvLyzzojUZ1P5vMfNnAE
	feFyijcwLR2ennFOeToEJSUw5NuhnQhKGi8X7hlEZMGClCXjhPFpdLIn43YkMqlSEEqOalL/qmN
	eTBmYBSXT8OQ5FQ==
X-Google-Smtp-Source: AGHT+IEPGj2LVimqsUuiIVJ+RbHGYhp2AcLiz84iR1kWZsTULa8PtHtUv1J0jWrtHt8Iymr9NzSDgYvKrJUPlw==
X-Received: from pgcv10.prod.google.com ([2002:a05:6a02:530a:b0:b34:aa48:e31a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3299:b0:234:cd25:735 with SMTP id adf61e73a8af0-2381474ea15mr36033526637.38.1753153650823;
 Mon, 21 Jul 2025 20:07:30 -0700 (PDT)
Date: Tue, 22 Jul 2025 03:07:26 +0000
In-Reply-To: <20250722030727.1033487-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722030727.1033487-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722030727.1033487-2-skhawaja@google.com>
Subject: [PATCH net-next v7 2/3] net: Use netif_set_threaded_hint instead of
 netif_set_threaded in drivers
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Prepare for adding an enum type for NAPI threaded states by adding
netif_set_threaded_hint API. De-export the existing netif_set_threaded API
and only use it internally. Update existing drivers to use
netif_set_threaded_hint instead of the de-exported netif_set_threaded.

Note that dev_set_threaded used by mt76 debugfs file is unchanged.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
v7:
 - Rebased and resolved conflicts.

---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c       | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c        | 2 +-
 drivers/net/wireguard/device.c                  | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c          | 2 +-
 include/linux/netdevice.h                       | 2 +-
 net/core/dev.c                                  | 7 ++++++-
 net/core/dev.h                                  | 2 ++
 8 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 3a9ad4a9c1cb..ee7d07c86dcf 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	netif_set_threaded(netdev, true);
+	netif_set_threaded_hint(netdev);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index a2e97b712a3d..e5af8ffd771c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	netif_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	netif_set_threaded_hint(mlxsw_pci->napi_dev_rx);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4e79bf88688a..068fff76d883 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			netif_set_threaded(ndev, true);
+			netif_set_threaded_hint(ndev);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 5afec5a865f4..b36c585d520a 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,7 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	netif_set_threaded(dev, true);
+	netif_set_threaded_hint(dev);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 0ee68d3dad12..3a84780529e2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,7 +936,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	netif_set_threaded(ar->napi_dev, true);
+	netif_set_threaded_hint(ar->napi_dev);
 	ath10k_core_napi_enable(ar);
 	/* IRQs are left enabled when we restart due to a firmware crash */
 	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5aee8d3895f4..32ea881d79fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -589,7 +589,7 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int netif_set_threaded(struct net_device *dev, bool threaded);
+int netif_set_threaded_hint(struct net_device *dev);
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
 void napi_disable(struct napi_struct *n);
diff --git a/net/core/dev.c b/net/core/dev.c
index 76384b8a7871..4eeae65fda09 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7029,7 +7029,12 @@ int netif_set_threaded(struct net_device *dev, bool threaded)
 
 	return err;
 }
-EXPORT_SYMBOL(netif_set_threaded);
+
+int netif_set_threaded_hint(struct net_device *dev)
+{
+	return netif_set_threaded(dev, true);
+}
+EXPORT_SYMBOL(netif_set_threaded_hint);
 
 /**
  * netif_queue_set_napi - Associate queue with the napi
diff --git a/net/core/dev.h b/net/core/dev.h
index a603387fb566..f5b567310908 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -322,6 +322,8 @@ static inline bool napi_get_threaded(struct napi_struct *n)
 
 int napi_set_threaded(struct napi_struct *n, bool threaded);
 
+int netif_set_threaded(struct net_device *dev, bool threaded);
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
-- 
2.50.0.727.gbf7dc18ff4-goog


