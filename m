Return-Path: <netdev+bounces-220438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5396B45FE9
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE967BF0CE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150131B806;
	Fri,  5 Sep 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AWLdp5Ui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34836CDF5
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092834; cv=none; b=jM48IU2+rjrhVOK0V5HCc+usjBQ+w+SUyRToomkUxA6LJQoqefQdFthgNrXLBZxAvGPpzEaE/n/BGmhJjFePYLdUIKSBi9tvpfj6Bu+0wjW9PSm5dLBIacabHj5A3SZd3HkC5B4i+3r1lXBLu4ghjhF3rjeYFw8ugunvCntICQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092834; c=relaxed/simple;
	bh=lBIehoTE9qHsfEbtzGnpbAnYuCwj+LDwF9UlRj/6mL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCHnTUSCgtC8bbe3kedgKh9OrhDS9jQLxVrMkL7heBTrCttt8SuUz28bsEo4z4QFokcRxYzL8RjUttOvnsBGHN81dbk/RWM55Ev6JfSyLxnqo5g7sXK6jF0dGoVcTNOoBVcH/cM1LOb1JckGbEpUIgjhqqVzpuJoO7POnHF2FII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AWLdp5Ui; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e96e45e47daso1969281276.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092831; x=1757697631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilwPX9LIjs3l0fybAvTKSDVfu7+GjybA609gdC08RM4=;
        b=PAmt52Y7xYQ5N4aitHg8Lrqn1URkMR/dwSCkV8H+PV3yFJclxGmeId6cSi7zwwajSK
         eFANRE+iW/WTUU8HoloBt+WYyNey/srIGcuQ/Uy++CGOyzCqQuRbC4OEkcg3g7yD3xzI
         5WviWwAA7pohi4ufR4YiFch/uW5yALzwtG3wOoF9SYERuHqs1v9PiSUWxRZrSiNVEJHA
         g9gTc6KhOb0474L+iSb7/8FsrgIP+ZHZYlg4afmJm6+jIIvBwuMVKf0dlOCAwd1nJOOu
         4LbbWBzrw9UnRAvP52C/nNtQBh+pZLxesK0g6HvVXvjq4rdJSul7mz1vmtSTdYhyBa4t
         +Gdw==
X-Gm-Message-State: AOJu0YwW9z9Vzm3Ey5TISK+5FDGpVFCoUUS4V/MWS8/ssHeSAXrCMP/F
	AQa52+Bs7oUqLTCG27X1AyYCWdsus43LeAQI9v4ioj1y9J3rw2ggA/6FEZNU+50V/nDVIkvreI8
	sP8KM6V4bw+xFh34Dg9HLbfvCDc3qzLX4OsRZzfC4lLQnbYedc+qiUKTZKWrJk59kgl715IHTGC
	TCWAfgp3v81Vc32K8ewkOVlJP0TkYVglVpYiT8Fz5IUkjxWaC8APpnsxCcyCmkxVqb0LNoNtmf/
	UfWRSD9AiG7eJcu84TA
X-Gm-Gg: ASbGncvTICpsAbgPX4C7bsxsmcJHeYombL++iW9B40em2YcNurodG/os1IYn+kfXmv0
	Z+UiiIY44CSXjsb5H7K0ZfiqYVXwzDl7q/Avy/gjhTovER9VzrKdzFscNAnhpWo9LE2Rx4RFlx8
	6VPhD9shp9FwdzkXjqKHwuXjcntHy0+QJAnWMsDSTukmeFWkClskGNRAawZ2/uE4/W9jIqPDRAf
	QxqPGI3BtVoFU1N97gPYd+NkjQLgk9uVs0oqDRMsdDEmKDs+kYyNHWOy+defq350p0Z+0dXeO1G
	tXu9nKxeWlkEXie/CVKpOSN6tydG6ggpn4J/swYwUZyUaY2lV0LNRWLOW5/OqDcxa0MkKgR+FgP
	Nm6j44J/F66YaCqX5HC/z7VEb9w+RQOq6Z8R9qIRUl9dkclSi8jEeKKZ5BqHjDezPcDqeTiJvGK
	+ZlFP1LzLX
X-Google-Smtp-Source: AGHT+IHU4D8b2TXSCWfqGTHvb2biUHzoZypgm5IVTrZ1L6dvbuqrkvZp6lwrMD1Qpkhk7axyO039uQedVVHb
X-Received: by 2002:a05:6902:4a82:b0:e98:a36a:7633 with SMTP id 3f1490d57ef6-e98a575c57emr18071583276.1.1757092831396;
        Fri, 05 Sep 2025 10:20:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e9bbdf3cbc4sm789389276.3.2025.09.05.10.20.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329dbf4476cso2138432a91.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092830; x=1757697630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilwPX9LIjs3l0fybAvTKSDVfu7+GjybA609gdC08RM4=;
        b=AWLdp5UipYSdjkUPo90IFa3uxOmiWeSAIFsPQXVhyy6kvyx/cRyocSbUykAJlbNU9d
         15YbO61BFebMu8m5YzjUh6s+HPonlCeiftGiK1yU8Tb3/IIDl5lm6+9xaBKrpmCJY3en
         zcZZlz2bjD1GZmvob6PFTCgXXEW3nJEbgVrqA=
X-Received: by 2002:a17:90b:1848:b0:327:6de3:24b6 with SMTP id 98e67ed59e1d1-3281541223dmr29395847a91.8.1757092830026;
        Fri, 05 Sep 2025 10:20:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1848:b0:327:6de3:24b6 with SMTP id 98e67ed59e1d1-3281541223dmr29395805a91.8.1757092829452;
        Fri, 05 Sep 2025 10:20:29 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:28 -0700 (PDT)
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
Subject: [v6, net-next 04/10] bng_en: Introduce VNIC
Date: Fri,  5 Sep 2025 22:46:46 +0000
Message-ID: <20250905224652.48692-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
index 207cbaba08a..c2c78df0e9c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -452,6 +452,114 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
 static void bnge_free_ring_grps(struct bnge_net *bn)
 {
 	kfree(bn->grp_info);
@@ -460,11 +568,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
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
@@ -551,6 +661,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -566,6 +680,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
index 8041951da18..7c56786f5a7 100644
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


