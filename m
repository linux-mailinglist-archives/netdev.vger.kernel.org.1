Return-Path: <netdev+bounces-209165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164FB0E823
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AEB4E6C72
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61361B6CE0;
	Wed, 23 Jul 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYNk1cfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271C19CC3D
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234237; cv=none; b=W3BnnvRhuqYgebg5RH5b3RCFYX+ldNoNWsOw8JyVu53jPfp9dS0hZrQo7a7cB7IvD+RRzis9fKueIi/RQaaj+vgE707lpPvp6E0CJIKI6yYK+NMw3NmSpIIB/tYsosFzP7X4RwZNPF4p3KtGqlYhypB9cpppGzHP9FUtkj9afww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234237; c=relaxed/simple;
	bh=CS64BQQ0/PSjDccpgivt4SmOilMH32yH/IjZ2WLEE6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lc7BEzLHjqq3+E2DD7As+osuG3zA1XEQwENlPTk1B78LpiSKM2jVdJqT2QiBp4ouICeimHgoJxYV8wG1Ud6qCt9A3lxkcz1DdKUHgN8BWrx2Dvw7iXv8K+zlk16P0qFU1hMMAnVDsLZXJHyEkBqCDPG9iOEdGa+LKIk2M949xYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYNk1cfc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-754f57d3259so9004223b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753234235; x=1753839035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=39NULgCWqifJIMliU0x4R/Eztw2lR7V80nwUdyu5ioA=;
        b=BYNk1cfcA8S4maJLo19DjCTFyqQB74RUxsWt8IBqC7I1Ao3OngdMuS61sU3EBlwXB8
         kqL4a29V7ySXB3Y4OisxwE+E26ehWCTTSbXp6Cbj0U5lgB6Gm3V0aH/HNnUp6Gh2IGn1
         9VX7aGxOz635zxc2E7eF5+D2td6yPhv4G42jg/KtFIdCFG5Xggd9d6gHP2JZWrzzvT/I
         uBHMMrQJravcDv4N3HCf8KGmw06VBPSaWQg7SzrIhG9OFFFWsdZj1xQMyOx8CHFLM1fM
         5bhqUyDv1o/WKdHOegHRm5xug2kjcW9r4XR9NJwfDlSf80VfOLSsC0dELC4BuVzsjSb1
         x5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753234235; x=1753839035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39NULgCWqifJIMliU0x4R/Eztw2lR7V80nwUdyu5ioA=;
        b=RTVpnCgALv6GMw7DvoffsMVgPynEeWkk6uckQGgIfxv7cq/DiyDMZP5Mshddz4z7If
         BpvpcShdxbH8EEpJylcTpQutIqdu4rnBB+1Xje6LFnZgbndhBocNYOzTf+LsrEWVjgvY
         Bc8vjxtcPYovQ4FEvbpg0bS1PbpGgZsqdSzHiZPs3X70+FHAZSOshzZwq4sRZEXO3STd
         PzOU4ytJM2Txd4rQh7nKEtjokVhZ1LORq/BmeWKOvmeRMVOibHrbi/btCMb6EdZNsmgh
         DLubCWrYVjhR/E3KWftrZ2dA2kGYt0NIdc73VSJxRu7qu9MEm4b8eUJ8IeeWmNFXVbbx
         YCDA==
X-Gm-Message-State: AOJu0YzQPS7FrDb60gJGJiHXDkXgNhk3iATY+Z3ACAiFYk6dcYAAK/nd
	G2/XtCGNidsyJkZzRe9bB6uG6EiBlFCpkzZWF+edbtTiTY+cjP3zr6G3FgktHA+pn7c2r2WXMil
	NBgS0dnuhrK7wpg==
X-Google-Smtp-Source: AGHT+IEnqJ3rwywTMyfeL5WbWodVgqGeDnSLHz2VXDRBo3+OAIqYqNXbEGiHwE99KcTaXBKMdOkPDUyPAkjR9w==
X-Received: from pfuj12.prod.google.com ([2002:a05:6a00:130c:b0:746:3244:f1e6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b91:b0:74e:ac5b:17ff with SMTP id d2e1a72fcca58-76035af8da9mr1481393b3a.13.1753234235318;
 Tue, 22 Jul 2025 18:30:35 -0700 (PDT)
Date: Wed, 23 Jul 2025 01:30:30 +0000
In-Reply-To: <20250723013031.2911384-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723013031.2911384-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723013031.2911384-3-skhawaja@google.com>
Subject: [PATCH net-next v8 2/3] net: Use netif_threaded_enable instead of
 netif_set_threaded in drivers
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Prepare for adding an enum type for NAPI threaded states by adding
netif_threaded_enable API. De-export the existing netif_set_threaded API
and only use it internally. Update existing drivers to use
netif_threaded_enable instead of the de-exported netif_set_threaded.

Note that dev_set_threaded used by mt76 debugfs file is unchanged.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---

v8:
 - Renamed netif_set_threaded_hint to netif_threaded_enable
 - Added kdoc for netif_threaded_enable
 - netif_threaded_enable return type is void

v7:
 - Rebased and resolved conflicts.

---
 .../net/ethernet/atheros/atl1c/atl1c_main.c    |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c       |  2 +-
 drivers/net/wireguard/device.c                 |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c         |  2 +-
 include/linux/netdevice.h                      |  2 +-
 net/core/dev.c                                 | 18 +++++++++++++++++-
 net/core/dev.h                                 |  2 ++
 8 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 3a9ad4a9c1cb..7efa3fc257b3 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	netif_set_threaded(netdev, true);
+	netif_threaded_enable(netdev);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index a2e97b712a3d..8769cba2c746 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	netif_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	netif_threaded_enable(mlxsw_pci->napi_dev_rx);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4e79bf88688a..94b6fb94f8f1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			netif_set_threaded(ndev, true);
+			netif_threaded_enable(ndev);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 5afec5a865f4..813bd10d3dc7 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,7 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	netif_set_threaded(dev, true);
+	netif_threaded_enable(dev);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 0ee68d3dad12..f0713bd36173 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,7 +936,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	netif_set_threaded(ar->napi_dev, true);
+	netif_threaded_enable(ar->napi_dev);
 	ath10k_core_napi_enable(ar);
 	/* IRQs are left enabled when we restart due to a firmware crash */
 	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5aee8d3895f4..a97c9a337d6b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -589,7 +589,7 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
-int netif_set_threaded(struct net_device *dev, bool threaded);
+void netif_threaded_enable(struct net_device *dev);
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
 void napi_disable(struct napi_struct *n);
diff --git a/net/core/dev.c b/net/core/dev.c
index 76384b8a7871..f28661d6f5ea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7029,7 +7029,23 @@ int netif_set_threaded(struct net_device *dev, bool threaded)
 
 	return err;
 }
-EXPORT_SYMBOL(netif_set_threaded);
+
+/**
+ * netif_threaded_enable() - enable threaded NAPIs
+ * @dev: net_device instance
+ *
+ * Enable threaded mode for the NAPI instances of the device. This may be useful
+ * for devices where multiple NAPI instances get scheduled by a single
+ * interrupt. Threaded NAPI allows moving the NAPI processing to cores other
+ * than the core where IRQ is mapped.
+ *
+ * This function should be called before @dev is registered.
+ */
+void netif_threaded_enable(struct net_device *dev)
+{
+	WARN_ON_ONCE(netif_set_threaded(dev, true));
+}
+EXPORT_SYMBOL(netif_threaded_enable);
 
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


