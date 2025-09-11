Return-Path: <netdev+bounces-222265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF855B53C5E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F300C1705F1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0E3680B8;
	Thu, 11 Sep 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iE0YQHpf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F43680A3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619342; cv=none; b=QCN/HPPCdBNGBprmucm0pudJdhYko/3VGDymAbcPfnal+qYHVtqEYZ9tGng6+GmGUo5Tz6j7tkyrjQnteEJz0kO1crTiZMgsszNVUzAkf0bWPYZqXhvAoqQWddfvjkeXFurpuAPqG9364yxVD5bfOnufd1XsVBI+lyqh/Ss8FgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619342; c=relaxed/simple;
	bh=L6tIgEx/MCVx319fx57U40bBW1wG3FCU6bChrvaYdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGLAZvVadK8IOGj2qpxT8W15LDzPIHB3dcF1/tnV7gHwfkeHpuI6WZzN3/h6bNlRUy3TzH5qwXnd8mxN0iEP6VbqXuT7kfHiC5TuB+/zmwxz74dK5/uBBkMm1QDqXG+rF3UDnhJKIWNGwAv5ylI0OSm3BCDNKCe0QA+Y2wPczfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iE0YQHpf; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-77287fb79d3so991393b3a.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619340; x=1758224140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7bXnrdBFhD9jlD7jd+pgJ0HwtePtGZ00MytlnQt1xY=;
        b=f7M/QFNxaiBJCNC3HW5faTBnxfRygPuSLTxHZ8/FcoJ6+L0fqTj2o5NCrMbAp067vH
         ii7juAn3dm0S70OuSlva6vgwW22/kDGxVs0vs7UqRIscdB5Aqm6RkyozO8nkslT/G5VV
         fjGFJHs4joWUGLU6Jqn1q/u4B40leI8k8Q+JGwwJXmN6n7TtHjq112G5RYjRLxFzpkjM
         QviSk3q9iArsGeIqXmUh93yWJCaW9d+h+n8Vfcuk16m2MJw8b7wZF8nHwcm9ZruSAOt8
         go12i1Qv6PLFFYKCELqGOiECqUWiweVHljSYU8ApBNHcTU6nia368sAxTDAZ0lKHQO2l
         nOYw==
X-Gm-Message-State: AOJu0Yywa26mV3epD3MFNHZB/KmXjQ0iEUkFnOl2HWQe8pF/PLMJOqPt
	lz8sVdk16ulAhy0TS1IWQhTMZD1z0ftYqvA8k4+8mBtlKQCsXsnbkRoiyLToRJOiwd5+Vhx/1b4
	Jb8AQ3HuPr+yMlWMPLnpNkpeF3exeGzkh2TDusMedfswjEX8lJee6IeC8foq3Yl48jppBSlTWc7
	dt45qpLwv6JB0veI/UaXPbyZ0cioj1pcJ5C2CvYt9HNSqjL82DH5zboU73YSpKWxyx4FaXuR/6Q
	VO8SWevIhjsQQhhUN0a
X-Gm-Gg: ASbGncuAYHerjA2rtHyqDhthA+IqtB/CBlsmtps+FQSLc6QKUwL286pe4v+uITgOu5I
	Ape7wq4d2Fd62DH2HORK0HeTrGsfgH8FJ3x2SkYMOSFjH8TIShc7VRIQmxK2MBU4YggIdJeN8+L
	ki6auJJIiDiqi3mK8/OFhWW7OUbzMQ9NTA5zgxUPqRvL5dztcjpSlGEtNHPld1ncaZdfSlBsfQ7
	qKeyKBeRwUQGaqDER6Rw/FGdNH8z5TParAcTKZWjayaw5+u78q89jNIU1pNSGtkP5OaiwaUzU78
	hpB0GUQb8Qh40aSdoRfDJLlN/xSCoJfrbOcQjL+6iLMXZ6L0CZZuzUaZYUaD4B3D9+s/5Mhg9rQ
	arZBBCHNSHLu/m3lDuzxqCCFUnx+soaxcdnmE5MNqIgEGDgEj0UzD0YTYvyWtQ2hAmwrzcmvaiB
	5dUuxteEHB
X-Google-Smtp-Source: AGHT+IELv90Fhu9ohHa4pZQfCQj/pAjlLO0/AF7rNPmQYV1eqzb6BTH0kv99BrEiLSGK+mSmwFYh/Tx9PgB7
X-Received: by 2002:a17:903:9cd:b0:24b:299a:a8c8 with SMTP id d9443c01a7336-25d24da379amr3925495ad.20.1757619339810;
        Thu, 11 Sep 2025 12:35:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25c371997e5sm1985065ad.18.2025.09.11.12.35.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ae30bd2d0so10679665ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619338; x=1758224138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7bXnrdBFhD9jlD7jd+pgJ0HwtePtGZ00MytlnQt1xY=;
        b=iE0YQHpfMCLslSLWmlMi6jQxhpPIBsDBVaaTDDbalS9t9t4Arv3evJxyINjQjqJxRD
         nsdaxIwiCu1ZGQDiedNF30UgM53Wi0jC2lltzRHGlYOF89vA/HUU6vCrkvsPtPkxvKlO
         33EnhYyWyS3JEU6UQYhal3pXbPWxh7fdmkJ0Q=
X-Received: by 2002:a17:902:d490:b0:24c:c57d:36a2 with SMTP id d9443c01a7336-25d249c3596mr5928945ad.13.1757619337938;
        Thu, 11 Sep 2025 12:35:37 -0700 (PDT)
X-Received: by 2002:a17:902:d490:b0:24c:c57d:36a2 with SMTP id d9443c01a7336-25d249c3596mr5928695ad.13.1757619337455;
        Thu, 11 Sep 2025 12:35:37 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:36 -0700 (PDT)
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v7, net-next 04/10] bng_en: Introduce VNIC
Date: Fri, 12 Sep 2025 01:04:59 +0530
Message-ID: <20250911193505.24068-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 121 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  30 +++++
 2 files changed, 151 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 615f9452725..34b0c9d6cce 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -437,12 +437,122 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
 	return rc;
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
+	int i, size;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		vnic = &bn->vnic_info[i];
+
+		if (vnic->flags & BNGE_VNIC_UCAST_FLAG) {
+			int mem_size = (BNGE_MAX_UC_ADDRS - 1) * ETH_ALEN;
+
+			vnic->uc_list = kmalloc(mem_size, GFP_KERNEL);
+			if (!vnic->uc_list)
+				goto err_free_vnic_attributes;
+		}
+
+		if (vnic->flags & BNGE_VNIC_MCAST_FLAG) {
+			vnic->mc_list_size = BNGE_MAX_MC_ADDRS * ETH_ALEN;
+			vnic->mc_list =
+				dma_alloc_coherent(bd->dev,
+						   vnic->mc_list_size,
+						   &vnic->mc_list_mapping,
+						   GFP_KERNEL);
+			if (!vnic->mc_list)
+				goto err_free_vnic_attributes;
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
+		if (!vnic->rss_table)
+			goto err_free_vnic_attributes;
+
+		vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+		vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	}
+	return 0;
+
+err_free_vnic_attributes:
+	bnge_free_vnic_attributes(bn);
+	return -ENOMEM;
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
 static void bnge_free_core(struct bnge_net *bn)
 {
+	bnge_free_vnic_attributes(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
 	bnge_free_nq_tree(bn);
 	bnge_free_nq_arrays(bn);
+	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -529,6 +639,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -544,6 +658,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		goto err_free_core;
 
 	rc = bnge_alloc_nq_tree(bn);
+	if (rc)
+		goto err_free_core;
+
+	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
+						  BNGE_VNIC_MCAST_FLAG |
+						  BNGE_VNIC_UCAST_FLAG;
+	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
 		goto err_free_core;
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index bccddae09fa..115297dd82c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -176,6 +176,8 @@ struct bnge_net {
 	u16				*tx_ring_map;
 	enum dma_data_direction		rx_dir;
 
+	struct bnge_vnic_info		*vnic_info;
+	int				nr_vnics;
 	int				total_irqs;
 };
 
@@ -300,4 +302,32 @@ struct bnge_napi {
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


