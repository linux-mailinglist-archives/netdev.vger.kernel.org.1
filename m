Return-Path: <netdev+bounces-206868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59FB04A7A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFBA1A6422D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96D289375;
	Mon, 14 Jul 2025 22:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF43289343
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531549; cv=none; b=nWm4l8UG7ZIMbfjo1u9fHYwGm+0yUUWz8fliXHvE3W/xmkQn1avJH1EdzndLp5asGdA4IyyKtSMgq/mAC4Yz7oDDtL/Pl5HNbprKvnhqbquovoFXYcvLgW+HrN1RLeK1wDTJ8lCaiJwrxMbY8nebNqATSSNK4L5iuzXdOZlbnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531549; c=relaxed/simple;
	bh=sOjyMpOEYUALdickfW71Bcgc7I0nasJZzx5+xqDDPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baYH6s8h7cC2x2JLOBx3b/tWTgIeNmipYyFcFh9oyYC2OKIZGdY9o36ZeNFkkS0G2iworUb9iXECeiaWS+zHzUl8wZ+Nd0k3unz17+Xm8og8Xy8i+PVV1+iJqElCK35Xg+hTOdU5lfWXRaJ7hiiiI9qKe4G7vjBb6xUXwaUfRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749248d06faso4025364b3a.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531546; x=1753136346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rhA+lDZESl5M93I2PKWinDEI37PdDGcvw/NHQDjiy8=;
        b=hoiR5sV9lSmHYeWpNdCyjGoaJTkncHjvSU/kaP2V2kxcLg/wHRP9HLeruLLMfQbSXz
         A9h9oIxKX6dJIdyJKBcnVgbL4jnd+TsWrX3OwGEqZSgKmwsYyOMdq2PP00Fe81JpPjHd
         FiL4fU5+X7zNBfE44y67FaFaXQvbczba/iK/wHW64qD/dTcWaIFNFgByOEGdkbmc7E1E
         U4dKGDK+sYZ+PbkkAsNPDdqxMWhysCxyX3VOBAJzkQxsqlvJy6hR325XwZhW66+b4fp3
         OnlYWXD+1qTHdvglRf3ez+9OmBRMeJ0ep2y4Naq6YiNpvv6yIKioOLOcRmpim0bFDI5T
         LL6w==
X-Gm-Message-State: AOJu0YzYXiJIUGnQGfpgWmBp2RmbW6PqCRd1hjcYIfj1ceBkSrNvwaVJ
	TqDYnFdtae4YOso1yLkfG6NP+nuFHGybxZQno6vU7/PnzHpV1XlwXalTqPrn
X-Gm-Gg: ASbGncs3PnSd48wWY/4sWPcicW/G1CQ7yap7dwRewHHDLOVP2qWuBLWMPVJtqOr1kNq
	aRNmbU/XNrscZipVEYZ5PGxTlZNh9sv0h+bhV/nJvBhLP8R2SWaczV/VpwM8I0mPoNIV57tzzHZ
	KszbcyDNdpjgDfqVo9muz3OduqmyBL5SjBrETIUEhoSEUT00t+HwhAVYVjfQw1BIMonqC+8wjvj
	NMXBc880D7+FCpu/KUKV4YXNOzewpq18wEC2cZOJxyKH9A76X54BzBM94sJkqUh0XfHfkm2Quux
	gWQk10d+9toRNTIj9Rre5E68WofZPkWAmLSPTI+Mle61wTohxa2iZtOyTDFT+bKdj7PuZ7OB8Of
	RggS6VAEJej2U9txx/bSU0ICRXHgbbaRh7fB5ZNBdLyj0igNauGZQew/0nqo=
X-Google-Smtp-Source: AGHT+IFuAZb/k8fZh0u54aQcAYl33O75Yfn79WrxQeoUpZ20zLPTRoL4pNFHxLgfqnWdedxUhNIHDA==
X-Received: by 2002:a05:6a20:2586:b0:234:7ad1:8d64 with SMTP id adf61e73a8af0-2347ad190bdmr9270191637.39.1752531546151;
        Mon, 14 Jul 2025 15:19:06 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9e063besm11030737b3a.45.2025.07.14.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:19:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 6/7] net: s/dev_set_threaded/netif_set_threaded/
Date: Mon, 14 Jul 2025 15:18:54 -0700
Message-ID: <20250714221855.3795752-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714221855.3795752-1-sdf@fomichev.me>
References: <20250714221855.3795752-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

Note that one dev_set_threaded call still remains in mt76 for debugfs file.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../networking/net_cachelines/net_device.rst         |  2 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c      |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c            |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c             |  2 +-
 drivers/net/wireguard/device.c                       |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c               |  2 +-
 include/linux/netdevice.h                            |  1 +
 net/core/dev.c                                       |  6 +++---
 net/core/dev_api.c                                   | 12 ++++++++++++
 net/core/net-sysfs.c                                 |  2 +-
 10 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index c69cc89c958e..2d3dc4692d20 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -165,7 +165,7 @@ struct sfp_bus*                     sfp_bus
 struct lock_class_key*              qdisc_tx_busylock
 bool                                proto_down
 unsigned:1                          wol_enabled
-unsigned:1                          threaded                                                            napi_poll(napi_enable,dev_set_threaded)
+unsigned:1                          threaded                                                            napi_poll(napi_enable,netif_set_threaded)
 unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index ef1a51347351..3a9ad4a9c1cb 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->mii.mdio_write = atl1c_mdio_write;
 	adapter->mii.phy_id_mask = 0x1f;
 	adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
-	dev_set_threaded(netdev, true);
+	netif_set_threaded(netdev, true);
 	for (i = 0; i < adapter->rx_queue_count; ++i)
 		netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
 			       atl1c_clean_rx);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 058dcabfaa2e..a2e97b712a3d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -156,7 +156,7 @@ static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
 	}
 	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
 		sizeof(mlxsw_pci->napi_dev_rx->name));
-	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+	netif_set_threaded(mlxsw_pci->napi_dev_rx, true);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9f4976a3527..4e79bf88688a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3075,7 +3075,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
 		if (num_present_cpus() == 1)
-			dev_set_threaded(ndev, true);
+			netif_set_threaded(ndev, true);
 	}
 
 	/* Network device register */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 4a529f1f9bea..5afec5a865f4 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -366,7 +366,7 @@ static int wg_newlink(struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	dev_set_threaded(dev, true);
+	netif_set_threaded(dev, true);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index d51f2e5a79a4..0ee68d3dad12 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -936,7 +936,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
-	dev_set_threaded(ar->napi_dev, true);
+	netif_set_threaded(ar->napi_dev, true);
 	ath10k_core_napi_enable(ar);
 	/* IRQs are left enabled when we restart due to a firmware crash */
 	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d11804be460c..295457fbcfd1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -588,6 +588,7 @@ static inline bool napi_complete(struct napi_struct *n)
 	return napi_complete_done(n, 0);
 }
 
+int netif_set_threaded(struct net_device *dev, bool threaded);
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
 void napi_disable(struct napi_struct *n);
diff --git a/net/core/dev.c b/net/core/dev.c
index 2d3d9166e7af..dce23b445ad1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4797,7 +4797,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 
 	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
 		/* Paired with smp_mb__before_atomic() in
-		 * napi_enable()/dev_set_threaded().
+		 * napi_enable()/netif_set_threaded().
 		 * Use READ_ONCE() to guarantee a complete
 		 * read on napi->thread. Only call
 		 * wake_up_process() when it's not NULL.
@@ -6960,7 +6960,7 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	napi->thread = NULL;
 }
 
-int dev_set_threaded(struct net_device *dev, bool threaded)
+int netif_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
 	int err = 0;
@@ -7004,7 +7004,7 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 
 	return err;
 }
-EXPORT_SYMBOL(dev_set_threaded);
+EXPORT_SYMBOL(netif_set_threaded);
 
 /**
  * netif_queue_set_napi - Associate queue with the napi
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 1bf0153195f2..dd7f57013ce5 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -367,3 +367,15 @@ void netdev_state_change(struct net_device *dev)
 	netdev_unlock_ops(dev);
 }
 EXPORT_SYMBOL(netdev_state_change);
+
+int dev_set_threaded(struct net_device *dev, bool threaded)
+{
+	int ret;
+
+	netdev_lock(dev);
+	ret = netif_set_threaded(dev, threaded);
+	netdev_unlock(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_threaded);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e41ad1890e49..c28cd6665444 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -757,7 +757,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (val != 0 && val != 1)
 		return -EOPNOTSUPP;
 
-	ret = dev_set_threaded(dev, val);
+	ret = netif_set_threaded(dev, val);
 
 	return ret;
 }
-- 
2.50.0


