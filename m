Return-Path: <netdev+bounces-249139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1616DD14BA8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8F130953BA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCD3815C1;
	Mon, 12 Jan 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf37x+/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100930F931
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241863; cv=none; b=pO3ySPB8h8xuWfYXJwC2eO1UhFIspnX84QFnj90PZ/7ThZGdPclIVMvEzWV+EkTSzIlkuACIUdHQxVhaK7+YLF4JXlq0VvrRMVIYGTDqZQOX5aSL8NN4t3dh2mnoaLj/j7RRpk088vw5p+Q+3m9bJi9x5jiNPCaElooxWk/lZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241863; c=relaxed/simple;
	bh=2Sqpis1K0LSL/WFSvtY09l86+t1Bt2h1wW9J0JxvOs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkHGrRtbv2fwd2LCZHhr8aLfXnyq0G4z/d5HOIJr2DVo+2D74IAo3/BWcVv+XaDLYTliCWzTAPNSTHvtsMkE7nOqYG/1bhiYGiowr7+PNWZ8/y18Gdiaxm8iZJmNHvQqDQiUIms3kBwjUQnw1qx8A4Sqh7b2AOSfMNm9S/TWCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf37x+/B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so4811500a91.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241862; x=1768846662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el5UxGKyuVvQQYU13vsmsSfuItrkm2KM2pfP5FWsHjg=;
        b=hf37x+/By0SXrsXwEiQ/Q2Lu3GotwIJu0BtSLx8dTlFZCKGSx7d4+UwGmC7Rr+E73w
         VkEz7YfMkgm59DiRLoL3u4rQV4JQTnxNbrF3F/jXXL/X4XyiU/knYw3MO5+Oc2DMBf63
         axKdfcekRyXOl9u7Ix2qj89X6BRDOe2BdGVcPHTuSugkvTVZHi9P6wWig638cZRoa5WI
         HQ2OwbG/0KUA/oxX07YYaSQNGZRxvTuhLUZOR+a5jowFuNoQOYYRILt7QG2ZAOtkcrOw
         sKyMQDgKdD83bi7zSoTbDpuIxxk6DHRfuL/acx8WhZbbp30LcHHaTD0594DjayxbER0y
         SW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241862; x=1768846662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=el5UxGKyuVvQQYU13vsmsSfuItrkm2KM2pfP5FWsHjg=;
        b=HiuxQluKtUvCMzgD5yGash366CZg8Y1A+0+LMLnRTPnZ5Td/3woxJmrM2yBOVKT3sf
         gKJGw9Z0UtcFiY8qJWrEO/QmeJhSDNylvNYfYx66BJ1fWIKpxPIrijjKxINvf94dOCs2
         emSaVN8OlmpP11yr2VJ8e3YABdMnEQtzChiO5CXboA70ZSIy2/uGvrLR+XgY6eqcKgM9
         vXrrYS8Gw8nr2aqDmUna+vua5yV5cCdiaGeEzKNEIER8eH8bMA/YVJIx/gB5h/cZnXc0
         9NN2AqeduN/KPXrrjBl/lt/CRs5P2676SBqFZ8UvkrAfjx/sXgMmCKVDbAJiqb7U2EcI
         oFeA==
X-Forwarded-Encrypted: i=1; AJvYcCWG2R76DOQ26XqZJdDotB0xQkpTcUbu/4ESQxWkRMWjJ28t/TEUbdV9/h2lr8gAWBRwhxQKs74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGQynGXRRjqi304NZDOqNYWj0rFOQxZI+bLs6tKJ6vgzwU0Mc
	Gegqow9sry98cp2dKhH7lWuO5Zz4dSgl/HTiytAo/bWlBPV0mZ6O1e9z
X-Gm-Gg: AY/fxX5g0AFJluhl5/lObPpcbpd0epLJmF4R0e8C+YlJZYYSKcpfMxkDMXBIdzT7fa8
	BFgojSpebJlfI4Y+Mk7LwewmDL+1MwAKQ7zE9ZX740IxrkvVb8pfuQKX7qIs6F5NMG8BF8KTWvU
	YOwQOlp7ZHtRUcXDI2lQlWeJ+jI6b2BpYC6n4Gs6BJKdfsp23xlbprT0JHwvSsNcLbmPRSdic9O
	mp/SER7V/Z1Y46IUWZqt+IPB13SWsF9Tw1TCX5VjSEKOBKX34iQj3Z5fFvrpbBK9iy8YsYnApUs
	E+Yq2t8rKMFaVf+8gdDkeJEAWZ2DpIUZp8zYDXItxUbOYoKqZNHucLnF6HL7t4+IWV79QOBPX1f
	quprPk5Z40E3sAslbeJtLU053j2FNxPrCrTlEkmL981Z3ljZGKc9zCV0jZYdOj3USLWvbdTfeMl
	8emm7K4SU5hg5zxcmtPCBHyL0yWWNrYcrajQqkvnC/Q7GV8b2AoYv0DpbugMgyPNEMPUdTmLk29
	jEy
X-Google-Smtp-Source: AGHT+IGw8c/ge0kogLSvooJ8T05HpwWG8XaZIOQXBwEzKsqUzkn4DfT0BloqE2l57lQqyy6/HPMuNg==
X-Received: by 2002:a17:90b:2692:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-34f68c30794mr16139992a91.2.1768241861645;
        Mon, 12 Jan 2026 10:17:41 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:41 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 5/6] vmxnet3: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:25 +0530
Message-ID: <20260112181626.20117-6-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callback and update the code to use the rx_mode snapshot and
deferred write model

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 38 ++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0572f6a9bdb6..fe76f6a2afea 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2775,18 +2775,18 @@ static u8 *
 vmxnet3_copy_mc(struct net_device *netdev)
 {
 	u8 *buf = NULL;
-	u32 sz = netdev_mc_count(netdev) * ETH_ALEN;
+	u32 sz = netif_rx_mode_mc_count(netdev) * ETH_ALEN;
+	char *ha_addr;
+	int ni;
 
 	/* struct Vmxnet3_RxFilterConf.mfTableLen is u16. */
 	if (sz <= 0xffff) {
 		/* We may be called with BH disabled */
 		buf = kmalloc(sz, GFP_ATOMIC);
 		if (buf) {
-			struct netdev_hw_addr *ha;
 			int i = 0;
-
-			netdev_for_each_mc_addr(ha, netdev)
-				memcpy(buf + i++ * ETH_ALEN, ha->addr,
+			netif_rx_mode_for_each_mc_addr(ha_addr, netdev, ni)
+				memcpy(buf + i++ * ETH_ALEN, ha_addr,
 				       ETH_ALEN);
 		}
 	}
@@ -2796,8 +2796,23 @@ vmxnet3_copy_mc(struct net_device *netdev)
 
 static void
 vmxnet3_set_mc(struct net_device *netdev)
+{
+	bool allmulti = !!(netdev->flags & IFF_ALLMULTI);
+	bool promisc = !!(netdev->flags & IFF_PROMISC);
+	bool broadcast = !!(netdev->flags & IFF_BROADCAST);
+
+	netif_rx_mode_set_flag(netdev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(netdev, NETIF_RX_MODE_MC_SKIP, allmulti);
+
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+	netif_rx_mode_set_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST, broadcast);
+}
+
+static void vmxnet3_write_mc(struct net_device *netdev)
 {
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
+	int mc_count = netif_rx_mode_mc_count(netdev);
 	unsigned long flags;
 	struct Vmxnet3_RxFilterConf *rxConf =
 					&adapter->shared->devRead.rxFilterConf;
@@ -2806,7 +2821,7 @@ vmxnet3_set_mc(struct net_device *netdev)
 	bool new_table_pa_valid = false;
 	u32 new_mode = VMXNET3_RXM_UCAST;
 
-	if (netdev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_PROMISC)) {
 		u32 *vfTable = adapter->shared->devRead.rxFilterConf.vfTable;
 		memset(vfTable, 0, VMXNET3_VFT_SIZE * sizeof(*vfTable));
 
@@ -2815,16 +2830,16 @@ vmxnet3_set_mc(struct net_device *netdev)
 		vmxnet3_restore_vlan(adapter);
 	}
 
-	if (netdev->flags & IFF_BROADCAST)
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_BROADCAST))
 		new_mode |= VMXNET3_RXM_BCAST;
 
-	if (netdev->flags & IFF_ALLMULTI)
+	if (netif_rx_mode_get_cfg(netdev, NETIF_RX_MODE_CFG_ALLMULTI))
 		new_mode |= VMXNET3_RXM_ALL_MULTI;
 	else
-		if (!netdev_mc_empty(netdev)) {
+		if (mc_count) {
 			new_table = vmxnet3_copy_mc(netdev);
 			if (new_table) {
-				size_t sz = netdev_mc_count(netdev) * ETH_ALEN;
+				size_t sz = mc_count * ETH_ALEN;
 
 				rxConf->mfTableLen = cpu_to_le16(sz);
 				new_table_pa = dma_map_single(
@@ -3213,7 +3228,7 @@ vmxnet3_activate_dev(struct vmxnet3_adapter *adapter)
 	}
 
 	/* Apply the rx filter settins last. */
-	vmxnet3_set_mc(adapter->netdev);
+	netif_schedule_rx_mode_work(adapter->netdev);
 
 	/*
 	 * Check link state when first activating device. It will start the
@@ -3977,6 +3992,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 		.ndo_get_stats64 = vmxnet3_get_stats64,
 		.ndo_tx_timeout = vmxnet3_tx_timeout,
 		.ndo_set_rx_mode = vmxnet3_set_mc,
+		.ndo_write_rx_mode = vmxnet3_write_mc,
 		.ndo_vlan_rx_add_vid = vmxnet3_vlan_rx_add_vid,
 		.ndo_vlan_rx_kill_vid = vmxnet3_vlan_rx_kill_vid,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.47.3


