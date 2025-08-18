Return-Path: <netdev+bounces-214633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE69B2AAD1
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9E01B27CB6
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED8326D6F;
	Mon, 18 Aug 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gim2O+S0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B42322DCD
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526853; cv=none; b=XzuygFNjA1oa7ZwErQ0FTPrAF3kAVRkzHj37j7TkSOwmHIumZzixyhFkJpcCvX96fYuQ7qKDPydi//89SWKuL6NSb99HsPraZM1moGlZKjLJK+ikWHnVtkjhQfHC8uYEnfE9nvO1WcMRYvX07VL4vYCD6PbP2LBB+PPHpKEf/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526853; c=relaxed/simple;
	bh=mgHwEUqX+8qU0ng3VMU/KHBJ3Vngfmg4k8WehGHncbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVx06Fm9brYXiUINZYG2kJep9PYM/0G0awxPQAJaxFSDDCoOWYGGdeHSzsYo7ZJcEJcvHXxNNoKHvuzup0HrAquFdQKkOw2D3mT1JLi8kVy+rqAvuoOd5zE5OH+y5Mg2dv+RjfS/9ZWALBFOJfqx9eO/OuO16f4tc1UNjVS0C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gim2O+S0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471aaa085aso2385696a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755526851; x=1756131651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Zc78RTQN4qg8zldvIlaWUsVGEnOzW5yVklmq6LpsPM=;
        b=Gim2O+S0HjjxtHggS6jk005qH1HpUYkeMuPFkCgsbMTJNCvaonimFmbXWi/Wep5dIt
         wnOVpIclT0IzBc5hCyF55rveWcAJVwrkFZQnMeF7FgNMCvRrwFefMGrLDGUBY0sNLRjy
         9EuH6zEGXFBh+5k8LEkCB9Ms/LRlW9y1f0fM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526851; x=1756131651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Zc78RTQN4qg8zldvIlaWUsVGEnOzW5yVklmq6LpsPM=;
        b=NirgqbEj4As3of8Nh4PAyTQguCo3tSMthutsujj3t3flqRAQq29jEMgpOMxVvfuDk6
         uJAB0QWMnHBNHLZCcWA/4ASf8emzEZtknhuktKg29fPFtDZadrXYleY3sQ0ophAz2oPE
         9Qa4WUY7CWcl7U0naV7CnwH4o4ldGJVaFSBxNL/LDIcoy7QbBTEpLJc3DaR6t1HGbqYR
         AbeCJpPFsFhv2SVjN7hruFWp6W0Ltbkq62vG2Av/R8ejnh7CUu0SKe3ze++2po40IorY
         k66tOjaf+fw0X6VRaASX6UcjKRAM2PhTN1jrl4qnJoaEIlTft907KaGUzJHnf/uetVNj
         KEqA==
X-Gm-Message-State: AOJu0YzIUjjZjxtJ1gDJoHXOaoH7tE8gSZ8SwSa382XmsYlfNTfZINV7
	o8fhCIZXVQZqhuLVQN/9F8tghcHZezIKwlCC4atUm3vFAiuLvQFb0FY54h/5+VSsZw==
X-Gm-Gg: ASbGncud0i8prHUCw6Ja63aWeN9EYIHHO4ZbVbM4Mc3XIMdwHzQajSIGtmfI/aGeg5M
	WgH0LmGjb5M5Gig77jOQs71I5DwI2EdfO9dJuZ68rHpA0Z/KkwVBk1adxByOzncjHKZN0yXfKKg
	FWLmNsqKIiDLxXhQvLQTb1q2DFI9lQa5dUPKwPDyv3wgtHG2qVLj5SWtyWFWnqap0IP/A0WxOhw
	/W5mrkkK1f64hgAU+ajY/iL7eBcgHYaXyYgTBOolRNXKM1KqSVn5WICGdlLY0m09bIfDesNzES8
	P+uaxV2ddlS0uPc6sqpKqzqTsTaCab/T4x9eUgp3HH/gqqDelW7XKMYFXiasJdJAEQmYZsSM3ih
	OTRQ9P+t2pxfkU7uTpprh5EqD/tTq08pQ7igbbtASHj1tE/mQxPMOn6h1wrkteEIu+bQ3lC/vQK
	MAREq6jSEfV30yUSodaPIKCuYMKw==
X-Google-Smtp-Source: AGHT+IEEH/e+be7s9tOtNyCs6z+lJ3mjQjiuTNPPLvgqI0e207xpZIM75JcO9gOF8sPBGIDnPbwmAQ==
X-Received: by 2002:a17:903:1ac6:b0:244:9912:8353 with SMTP id d9443c01a7336-2449912908cmr11819445ad.6.1755526851052;
        Mon, 18 Aug 2025 07:20:51 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm81947835ad.153.2025.08.18.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:20:50 -0700 (PDT)
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
Subject: [v2, net-next 3/9] bng_en: Introduce VNIC
Date: Mon, 18 Aug 2025 19:47:10 +0000
Message-ID: <20250818194716.15229-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
References: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
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
index d8976faabd3..cc7c2aa59fe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -428,6 +428,123 @@ static int bnge_alloc_tx_rings(struct bnge_net *bn)
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
@@ -436,11 +553,13 @@ static void bnge_free_ring_grps(struct bnge_net *bn)
 
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
@@ -528,6 +647,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		txr->bnapi = bnapi2;
 	}
 
+	rc = bnge_alloc_vnics(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
 		goto err_free_core;
@@ -546,6 +669,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
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


