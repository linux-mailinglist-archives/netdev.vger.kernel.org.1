Return-Path: <netdev+bounces-217818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E25B39E97
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06F81882569
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF423148A0;
	Thu, 28 Aug 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aHagub5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886131195D
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387151; cv=none; b=i8gNNr6d6x0x58ZlFghMkoih1i/6MxvFjUw/yF8BCsbT59xXESXw/mit9DQUWdxEf7lJJa+qajI6lnUUfg8/FQh19/DokVx1dfFbY/505EfA9qVwbgkL1aGE/cReCsh8Il9YGCw6CYNrXmQsC3tt09lLFzcc4BMTXssOPD7QznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387151; c=relaxed/simple;
	bh=H7JoMIILAhGUgjcUXQyHFBWQ8k2DHQByyC1Q5/bQTDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFTcAV6hXEVTrYK1IC8or19uG6odMj/bdUrYQEtuKBOoOUZkBzjFQRzNdBgHQuV9eGNuyR5pbwhPX4vObblZGq/5s6LJ0iS57PmCtcEO2L3kxdO/yCeOF0CWyDrTyCtZsp40Bwent+wTnzM07cxKmJqFzSSTioAj3BJxwj9p4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aHagub5n; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e96df7ff20eso720134276.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387148; x=1756991948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/9NtnykLFlbdwq/BFwbqCg1JY7GaLggRNo0Kw7S3VI=;
        b=n2QgLux/diMR3HtJ1WXcXJd682321vNTVg7gkZgSmY+3WJUTjASwVgola93cRhALfB
         sTWVqziduBIj6VxdJ2QlmCnMBEHcCM0ldQK9O135N+LDOfAtW/3lPtEdD9NCYsMLP+//
         apCEG1Ixo/z0zp1tfxulrscDz0WtojF+jyejFdVtiAzYPjI+Rj+1OqTtF8mUoUYcsIrO
         MCftyzung+tIm9fw8ng1vUnEIk7EaqVW5m7/SIeV7MI9vi8I7C0UGyRx4SAM/4yZa5ja
         QKF21BBI1rqxgU39Gh7WNxuBJ2xboiVh4wfX2ThsGVU7r9q97qc5MyvsWwY127yvcbgT
         P4OQ==
X-Gm-Message-State: AOJu0YwmgkUWQkSMNxUun05QnveCtBaLOaQDpqnaZJ44KL/1C6PvaGXU
	RORTL8ZsTT/XXzbvegqYA2LQwrQXrwmu+x4+TgkRPuT7+dUaJdkwP8Taf5JGgXhWDFcBn1qEGJ2
	KE4a+KbrBx0K5oSAUBjMpDaA9ozgnN4vUKMnnHDX8myIfFBeIrPTDPO2AT5KywBYDyh4u9DaS8j
	T+rkonD7d8BKeYF2fXb8UvM4wko0NTw2zwedq4uP4AE81fYd+kukcDpExWL45opaesTCnyIQd+0
	PjccQcxPdJd+kP40g==
X-Gm-Gg: ASbGncuoriiS3vdvemhZCEKH7yeh2OVGnS8WCtOED7D7olrlXVPLXjdH0FwLUwTiCJR
	PYmvU9DdU0c3kUlJ92qivfNFmb/CchOJGyoW3fuBBXUvXVqka7F0V9SZNX6NIxBAa86DbZG/5Wq
	re6tRyPBluY/3SM5Z50elffRyIlgP8nO7pdoMyWroLLfjjIWS2HqTZ2YS7FzSoO2ZmGZs5NBG1k
	rrHSQIMB/dwNQvmfVtjV07LD8j7b3L5K3LRs/ss1z6q3amxYQkOfjrUMzbTJUuF5jLzwnxiLLpW
	XGDp/ssbw3kuZ+9SG+1uFJzQywyqp483I1CyniWmJl8Zef+PzeLDWa56oYJqYULh/i1kkfXCbT9
	+x1t3Gf/HSBZ/Ctjr84D7/gVXswSzbgKIpJvESkfC2cVi8C5xUU5/7vsYpxZmHuoyWVGQFT5FUC
	gxI8z+Lt8g
X-Google-Smtp-Source: AGHT+IHDZO1PihI83wg3/B6FhXa0FdpITW5RxQGq2gVNnQ8jp6ROV6rSKatt4XE3LT86lnu+jNt8NeE0Hxhy
X-Received: by 2002:a05:690c:74c7:b0:71f:da33:b20d with SMTP id 00721157ae682-71fdc2afd5fmr222820837b3.6.1756387148117;
        Thu, 28 Aug 2025 06:19:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff16a3c26sm8352527b3.5.2025.08.28.06.19.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c1f686b73so804968a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387147; x=1756991947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/9NtnykLFlbdwq/BFwbqCg1JY7GaLggRNo0Kw7S3VI=;
        b=aHagub5newfmYfUftcXrXpTIaVB2prJS3YwIdO5TQYsNTYhkJ4jCxDwR3AeZnvKB6k
         S4ONQyE24LgTRB0FwP5B48Aug7gM204wo5WW3/B7AtxfVM97AxbtiK7ENBe7+Dy92rgP
         NUsREo34vhHAXSa+uvOQQI2hAEmMDk/oNHL7g=
X-Received: by 2002:a17:903:240e:b0:248:df64:ec6a with SMTP id d9443c01a7336-248df64fa0fmr27643635ad.15.1756387146771;
        Thu, 28 Aug 2025 06:19:06 -0700 (PDT)
X-Received: by 2002:a17:903:240e:b0:248:df64:ec6a with SMTP id d9443c01a7336-248df64fa0fmr27643165ad.15.1756387146310;
        Thu, 28 Aug 2025 06:19:06 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:05 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 3/9] bng_en: Introduce VNIC
Date: Thu, 28 Aug 2025 18:45:41 +0000
Message-ID: <20250828184547.242496-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add the VNIC-specific structures and DMA memory necessary to support
UC/MC and RSS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 129 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  30 ++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dd56e8b5eee9..59357b89ac29 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -435,6 +435,122 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_free_vnic_attributes(struct bnge_net *bn)
+{
+	struct pci_dev *pdev = bn->bd->pdev;
+	struct bnge_vnic_info *vnic;
+	int i;
+
+	if (!bn->vnic_info)
+		return;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		kfree(vnic->uc_list);
+		vnic->uc_list = NULL;
+
+		if (vnic->mc_list) {
+			dma_free_coherent(&pdev->dev, vnic->mc_list_size,
+					  vnic->mc_list, vnic->mc_list_mapping);
+			vnic->mc_list = NULL;
+		}
+
+		if (vnic->rss_table) {
+			dma_free_coherent(&pdev->dev, vnic->rss_table_size,
+					  vnic->rss_table,
+					  vnic->rss_table_dma_addr);
+			vnic->rss_table = NULL;
+		}
+
+		vnic->rss_hash_key = NULL;
+		vnic->flags = 0;
+	}
+}
+
+static int bnge_alloc_vnic_attributes(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_vnic_info *vnic;
+	int i, rc = 0, size;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		if (vnic->flags & BNGE_VNIC_UCAST_FLAG) {
+			int mem_size = (BNGE_MAX_UC_ADDRS - 1) * ETH_ALEN;
+
+			if (mem_size > 0) {
+				vnic->uc_list = kmalloc(mem_size, GFP_KERNEL);
+				if (!vnic->uc_list) {
+					rc = -ENOMEM;
+					goto out;
+				}
+			}
+		}
+
+		if (vnic->flags & BNGE_VNIC_MCAST_FLAG) {
+			vnic->mc_list_size = BNGE_MAX_MC_ADDRS * ETH_ALEN;
+			vnic->mc_list =
+				dma_alloc_coherent(bd->dev,
+						   vnic->mc_list_size,
+						   &vnic->mc_list_mapping,
+						   GFP_KERNEL);
+			if (!vnic->mc_list) {
+				rc = -ENOMEM;
+				goto out;
+			}
+		}
+
+		/* Allocate rss table and hash key */
+		size = L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
+
+		vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+		vnic->rss_table = dma_alloc_coherent(bd->dev,
+						     vnic->rss_table_size,
+						     &vnic->rss_table_dma_addr,
+						     GFP_KERNEL);
+		if (!vnic->rss_table) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+		vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	}
+
+	return 0;
+
+out:
+	return rc;
+}
+
+static int bnge_alloc_vnics(struct bnge_net *bn)
+{
+	int num_vnics;
+
+	/* Allocate only 1 VNIC for now
+	 * Additional VNICs will be added based on RFS/NTUPLE in future patches
+	 */
+	num_vnics = 1;
+
+	bn->vnic_info = kcalloc(num_vnics, sizeof(struct bnge_vnic_info),
+				GFP_KERNEL);
+	if (!bn->vnic_info)
+		return -ENOMEM;
+
+	bn->nr_vnics = num_vnics;
+
+	return 0;
+}
+
+static void bnge_free_vnics(struct bnge_net *bn)
+{
+	kfree(bn->vnic_info);
+	bn->vnic_info = NULL;
+	bn->nr_vnics = 0;
+}
+
 static void bnge_free_ring_grps(struct bnge_net *bn)
 {
 	kfree(bn->grp_info);
@@ -443,11 +559,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
 static void bnge_free_core(struct bnge_net *bn)
 {
+	bnge_free_vnic_attributes(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
 	bnge_free_ring_grps(bn);
+	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -535,6 +653,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -553,6 +675,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
+						  BNGE_VNIC_MCAST_FLAG |
+						  BNGE_VNIC_UCAST_FLAG;
+	rc = bnge_alloc_vnic_attributes(bn);
+	if (rc)
+		goto err_free_core;
+
 	return 0;
 
 err_free_core:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 8041951da187..7c56786f5a71 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -178,6 +178,8 @@ struct bnge_net {
 
 	/* grp_info indexed by napi/nq index */
 	struct bnge_ring_grp_info	*grp_info;
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -302,4 +304,32 @@ struct bnge_napi {
 	struct bnge_tx_ring_info	*tx_ring[BNGE_MAX_TXR_PER_NAPI];
 };
 
+#define INVALID_STATS_CTX_ID	-1
+#define BNGE_VNIC_DEFAULT	0
+#define BNGE_MAX_UC_ADDRS	4
+
+struct bnge_vnic_info {
+	u8		*uc_list;
+	dma_addr_t	rss_table_dma_addr;
+	__le16		*rss_table;
+	dma_addr_t	rss_hash_key_dma_addr;
+	u64		*rss_hash_key;
+	int		rss_table_size;
+#define BNGE_RSS_TABLE_ENTRIES		64
+#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
+#define BNGE_RSS_TABLE_MAX_TBL		8
+#define BNGE_MAX_RSS_TABLE_SIZE			\
+	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+
+	u8		*mc_list;
+	int		mc_list_size;
+	int		mc_list_count;
+	dma_addr_t	mc_list_mapping;
+#define BNGE_MAX_MC_ADDRS	16
+
+	u32		flags;
+#define BNGE_VNIC_RSS_FLAG	1
+#define BNGE_VNIC_MCAST_FLAG	4
+#define BNGE_VNIC_UCAST_FLAG	8
+};
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


