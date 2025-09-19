Return-Path: <netdev+bounces-224814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C31FB8ACF3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30763A02371
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C32323408;
	Fri, 19 Sep 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dAquKlJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFE3233EA
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304112; cv=none; b=VPMYGQePajQuxnWrwGK5HXmX2QN2euFkIJfFpLod6WwOcaEL3abQyTKnVfD5/vMlnpJ75qDaIO8hWwYQM8UCpO++7dtY5AnnjuyHjXvpQVFRKC2pVXdaQYNLhlpHKOnuS8Ewrqvw8wso4sOy26x3ohF5ZeUnvio4VgbaTXk+iIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304112; c=relaxed/simple;
	bh=+U9VwpQDZKnRhyDKJWqrh6t+vRxcUQAWmT+i2EwSPZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO+jAZglcMfO9rhGKYK1wsw/6FewAne31+zdKvsPlGcUIIF3azhOtOBYxfe2YJykYZWqPcyeCC0tGtxi8AidnwrP2Ylqe1DKE620tIvWkyoQbE/3pUtO2tqvI5SYtVIoQriNbWh5vuwIHY6n+xTjxhSU/OmM4U393cT2ffsfYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dAquKlJr; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-77766aae080so26389946d6.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304110; x=1758908910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WEPji3RS1+RhxYXPlyiCS/AdggPdPHkCGhc0sRkgSk=;
        b=IQkeLspgI2rYemeCpEXwFTn9xYVyS3Mfbt+OOJuaXnMZZvVYtD25ocelL8wp6ALCid
         3J2G7pmqIZSiZA+lTUkw9ajGEyP6f5nESiEGC7EcXXGX5PXD4OTa+MlqzOyJ4JKD0ahP
         l0jdJ4LpNElE/ABg8aBCLvzJYavVC39Y4TjgUe9dQL4V7a25/VzaMcrKdrvd8LTI9dDn
         Lx/9rdpXFJUKr7gL7Aka7wkT5I86gXiFYYNzobIskWYi96PNmJTFFmIs+tlrX342VHFZ
         QUUwlfw+Xx9zpl1q/IhdQrnb4TYuUmxZTHUZ+7Mq8cmQzG7HrXsh8sr6/hYD/8WBlBdh
         B7HA==
X-Gm-Message-State: AOJu0YydGcO6rDUbJVhvKtTm52VYoIFux81amkMjP3aB3sZ9rr7XI9v8
	vzJuXBANvY5BUebfjNMwKXExk7BYzi41NJSKLcXxjTClaN1HxBdmtWjGKq30qEzg4fLfjGRzPxM
	Bgo9QnxMZXnTGXRQDnnopwN0sViVB489hIfCHpQqp8oCFI/+qVrt2uSqYJnwCoY1Scrklz3UG9E
	+W18ZbjyPo6/RZmwga2duGUYDTJBgGc/5ohI9PRINPggFD7DZnvN1RjVndY9oEEUHbnhGBYXMJj
	Zq93adMbgcRuafjKO/t
X-Gm-Gg: ASbGncsf3BCJSopCSYPQqxVX2lolZLfTv8fco18zX/MYfRSBMS3yiAERIj1kIPpHF33
	7vsqNmA7r2s7A6QNGT1V15nFsbmzOLVMp9d26OBUNgIp3j8SQtZQaJF4ureSWeWEafalkaJB0PP
	pRI1DTHW5UaKlt39ULDRW2gicACAGQSxIBbk9CA7MvrJZBlsI4ERRIvT3jTXXgYY40VmGpQzDAq
	sqv8AQiK2YsjYAyXYrjwHvBgIHUAE77sH7LzUAgdZcQPDsMzp5ZnSs0DgESxtOorsdQyAZqHxCw
	sOQcaePGRYo5pLusA40WXifKXWQJLaTlMs33t/djHAJj/23gguuo93wYIbgbqESVdOdEkX9GPfq
	0ykaa79PDOaX3L/3XjD+1MOW2AxoDJPTrUsLddeELZ60DlwwO6iLqXkLEc2OOxvdRkLSQqa/zKe
	/q5HdtZ3s0
X-Google-Smtp-Source: AGHT+IFWlw8drvbK5qiKktx7LHoqLjvOwy0OQWI1p8JwsnvtTbsgKRfPB8ykdKDpM1SqLGhO+H14xSpmSb/q
X-Received: by 2002:a05:6214:f62:b0:78e:5985:92f1 with SMTP id 6a1803df08f44-792652fd35amr107369036d6.11.1758304109816;
        Fri, 19 Sep 2025 10:48:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79351f75297sm3700136d6.41.2025.09.19.10.48.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77e76a04e42so923931b3a.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304108; x=1758908908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WEPji3RS1+RhxYXPlyiCS/AdggPdPHkCGhc0sRkgSk=;
        b=dAquKlJrq+3NkkIqZs+L7w0jc+Od82FjEsYOxVxVlyacVmtAS9K7caJrco5dRApWGV
         x1DB0iH6pQeVNiDkTcnhF/nO0+6ATje/ZXQFrvy0SgTtWuLNChW1c7yHY2SjRvaWN++1
         fpuXuoTR9Ll+Q5D5JAAAphHPOUstsZJidMBGU=
X-Received: by 2002:a05:6a20:e212:b0:263:a022:983e with SMTP id adf61e73a8af0-28467929cfamr12118992637.29.1758304108543;
        Fri, 19 Sep 2025 10:48:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:e212:b0:263:a022:983e with SMTP id adf61e73a8af0-28467929cfamr12118957637.29.1758304108074;
        Fri, 19 Sep 2025 10:48:28 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:27 -0700 (PDT)
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
Subject: [v8, net-next 04/10] bng_en: Introduce VNIC
Date: Fri, 19 Sep 2025 23:17:35 +0530
Message-ID: <20250919174742.24969-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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
index 67da7001427..df05e6ea271 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -439,12 +439,122 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
@@ -531,6 +641,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -546,6 +660,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
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


