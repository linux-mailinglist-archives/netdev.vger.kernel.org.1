Return-Path: <netdev+bounces-213441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E057BB24FEE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFBB18812E3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A529992A;
	Wed, 13 Aug 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ed/Yut4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA9292B5D
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102581; cv=none; b=QAahOHadA9cpipldhRLUdSEC/ScCwdGZSPuix4tdxMG7vPYlW1S13mZ0lAQbYoYOY/GwFT8MtA6TjTLiPlPELsDyoAts1hzSdKj/Noj44Q6lcp0h6ptaiRK5st9vtuvbzFA924j14hxkqraYcvKHrYWNAbeI0yvvPKhMkkBEjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102581; c=relaxed/simple;
	bh=iw8SGquvm45ZFKLgJCjIx8yYp7F5uG5XpiJ73moYtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmB8k5XPtM13H+ZIR5aBARwWAW8r0+D+DdY1l2sr0dccWvt/lVRBPx9+EI6T7/wQ1yEei8LtLlHywIiVYQ2csPNHdo1Es88xaEA/TwSRkyfVm1Ycmq+Y2E9NJpEID6R20kfac2GTu9UCIhE8u9Pe9k4VfQIfMQwAuKUKMiGoLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ed/Yut4t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so5271548a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755102578; x=1755707378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEoDHzkcg5tJ2N8bNpHdrnQzYqgUq2Qmt5OBLm8otMs=;
        b=ed/Yut4tFn3nSgdY8suTN1CLJmLLMIsL6sFAMYmHY9BWKNuNp0oKf7KL9zTGuab0wj
         YATLGK/SWlmI4qmFDipNZ8MPKycCebJAoYaD2zLnwEochI3XXoPubPisbg879Wyf2SZe
         tioJBM79+3wcYcDABaNpeSNdKWOKm+/H82r6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102578; x=1755707378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEoDHzkcg5tJ2N8bNpHdrnQzYqgUq2Qmt5OBLm8otMs=;
        b=h0W42pQJUZ/XBB7WowP/As/Ip3ElE+LSvDiqij6ITwesoY9Rm0ede1IGHtcHgcLTlW
         UQLzGMjcEju2VOt18jNyYSYVLYq3TN1j2cuFLuddHrNdDG+j84QHiYcV0mG9LaKC49RV
         1BfQT7tDyXA3WK41u5ugnynteVI1NPRj+mRaC9OTmoyWrwa3hm86w/svdgSGyCJdHpK3
         MvXjjxfsICrft+/u4tnohyfJTj5ZCOunnaoFhUEkE+H1s6n3cS5APrrLP+3d2XdxAUAG
         nLxt3NovEsyfNRDc6GO8asulwpL0cyfkdr7YjxcxEFumvhv7dZKaEGSC7xXUuP1uAh4F
         BzHg==
X-Gm-Message-State: AOJu0Yw0lCNtarjuta1hvBjayCrlMYArXGx9VPzeI5GAZMN0J6ALdHB0
	c1y1IIutXklV0SqmZJq/FMosbA2irlOThinMnPOx/O0mn6gkqQB2yL1dZzN1c03DcQ==
X-Gm-Gg: ASbGncvgFV8EZqNScRwv7H28ceXkqe9WSMKVTABxZjIXul0TvVsLcp73syNL0wdcZq3
	hkmFJ9cosPjnVW15fLyURpjbvR07PHgry4ZApabEnWshNvDRjmZAa0SpQ9EoXRUNpz7TG+QwvUW
	a9fn6nZWEFaILdtkKoQ1m+hCsNTTraz6ek1p8N7hMccKFsN8cc0aItU0HcrIFgVy8kC4ar1bQcH
	YPe6wHhQYxejdlqz1+G/MZmr4FZX3V9Up0mvl87z049KN9XcntiarFnD719uOItWZ+b/ls9LvzC
	gSp0K+tYzLxiPWXPwa+v2/qiVlp2PlNQ9mOuOIwzU6I32NwY6XwjeMxdSQrsdKc8rfjmkDTuiSC
	+MQNcnY3DhW0idj2vkXMG6jHboj22jyn9MIG2k3n5iJ9kGVbYHClF6RJAUfFYL4osDWEFX5G39L
	ht5wblYEvKalPEsY3N6UwZD887zw==
X-Google-Smtp-Source: AGHT+IF5RJpW/b15g+Ujeh2JdwFSPQTgxJYcfq4yB2To8AQZ9p12zehv9r++1ejCNtfh8A9fggrtOg==
X-Received: by 2002:a17:902:da83:b0:240:50c9:7f26 with SMTP id d9443c01a7336-2430d0b8231mr53716025ad.13.1755102577600;
        Wed, 13 Aug 2025 09:29:37 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm329311915ad.41.2025.08.13.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:29:37 -0700 (PDT)
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
Subject: [net-next 3/9] bng_en: Introduce VNIC
Date: Wed, 13 Aug 2025 21:55:57 +0000
Message-ID: <20250813215603.76526-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
References: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the VNIC-specific structures and DMA memory necessary to support
UC/MC and RSS functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 130 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  30 ++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 5df12bb86f8..e76a7d1f6ec 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -427,6 +427,123 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
+		size = L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16));
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
@@ -435,11 +552,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
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
@@ -526,6 +645,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -544,6 +667,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
index 665a20380de..8bc0d09e041 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -177,6 +177,8 @@ struct bnge_net {
 
 	/* grp_info indexed by napi/nq index */
 	struct bnge_ring_grp_info	*grp_info;
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -301,4 +303,32 @@ struct bnge_napi {
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


