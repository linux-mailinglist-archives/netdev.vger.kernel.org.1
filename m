Return-Path: <netdev+bounces-125478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B596D43C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958651F21AF2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730C19882C;
	Thu,  5 Sep 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MCOfssGr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F99635;
	Thu,  5 Sep 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529796; cv=none; b=EUNNJugMCVblxVEWtL4i+VHJRevc6tE/5VorsoBKqa4DcOuETUan19dLKLFmUWA5LVdgb7qKjGrSj4zV2HCAWNIcu1nBq3vF8wMWXA6zTUvNnQpwCJIVJNazbJgUxSnbbCxeGeqUSqWW7yf4coyTRm71db4nCVBaOqbLXWlsteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529796; c=relaxed/simple;
	bh=+wtPFeiTu/7sXJxHN4T9+bYQj9IWn/QMza1nhMIejHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhVx3zTGnqLjcUJNNhmG8pYaKbVc3HE34zZuYhIy+8+9iAAGUuOHjjuvLR2FvDUQf97vUqnoXQ+oCuNsahbRmdnWTlow2xlxfmRodRVrG4Phk3hhFDkvZim4s0Ika4yEHdopcwpaxVmm/FahzGXw4Q/4FmszykgLaiJgLwFx6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MCOfssGr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48586aSX015000;
	Thu, 5 Sep 2024 02:49:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cyiR6bnh681vwAa7927VPiiNk
	K9AcNNWHJi29obxZ6k=; b=MCOfssGrMRSV5mM1z8HqGVwfQpaYtperZe1/1Vn7p
	BlGryaQ3HeAzFJw7T/AZwEE0fMrx31qXtnzRt7Lq0fN7YE81JyT9ETg6CQY4tZTY
	bGQsBhQfV7m4VeOIEqeuU6JahM+KhnMn9V8eKspPTY63EHiVh03QiynCPGlWsW/G
	AXgdxhnya5vW0rSYrHmAQxpv1yvSz2QppRJHXejqINSdzX9xYT2mYCIJXSMhrriO
	qRNg8afeGT3X3kKEr/+aX+2nrMO7++en7W+gz7lVVARyfIrh7E7lScyA1YyrE0P7
	SH37RUnm9cqFKLVw7aXz1X8X58krjnI1KeGpOwsddFljQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41f8u48bg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 02:49:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 02:49:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 02:49:44 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B0ECD5B6927;
	Thu,  5 Sep 2024 02:49:40 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 1/4] octeontx2-pf: Define common API for HW resources configuration
Date: Thu, 5 Sep 2024 15:19:32 +0530
Message-ID: <20240905094935.26271-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240905094935.26271-1-gakula@marvell.com>
References: <20240905094935.26271-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VJN7bCgpbh__8uCnqTw1GIwKcx5Jpbot
X-Proofpoint-GUID: VJN7bCgpbh__8uCnqTw1GIwKcx5Jpbot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01

Define new API "otx2_init_rsrc" and move the HW blocks
NIX/NPA resources configuration code under this API. So, that
it can be used by the RVU representor driver that has similar
resources of RVU NIC.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 146 ++++++++++--------
 2 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index f27a3456ae64..a47001a2b93f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -996,6 +996,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		   int stack_pages, int numptrs, int buf_size, int type);
 int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 		   int pool_id, int numptrs);
+int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5492dea547a1..4cfeca5ca626 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2872,6 +2872,88 @@ static void otx2_sriov_vfcfg_cleanup(struct otx2_nic *pf)
 	}
 }
 
+int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
+{
+	struct device *dev = &pdev->dev;
+	struct otx2_hw *hw = &pf->hw;
+	int num_vec, err;
+
+	num_vec = pci_msix_vec_count(pdev);
+	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
+					  GFP_KERNEL);
+	if (!hw->irq_name)
+		return -ENOMEM;
+
+	hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
+					 sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!hw->affinity_mask)
+		return -ENOMEM;
+
+	/* Map CSRs */
+	pf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
+	if (!pf->reg_base) {
+		dev_err(dev, "Unable to map physical function CSRs, aborting\n");
+		return -ENOMEM;
+	}
+
+	err = otx2_check_pf_usable(pf);
+	if (err)
+		return err;
+
+	err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
+				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
+			__func__, num_vec);
+		return err;
+	}
+
+	otx2_setup_dev_hw_settings(pf);
+
+	/* Init PF <=> AF mailbox stuff */
+	err = otx2_pfaf_mbox_init(pf);
+	if (err)
+		goto err_free_irq_vectors;
+
+	/* Register mailbox interrupt */
+	err = otx2_register_mbox_intr(pf, true);
+	if (err)
+		goto err_mbox_destroy;
+
+	/* Request AF to attach NPA and NIX LFs to this PF.
+	 * NIX and NPA LFs are needed for this PF to function as a NIC.
+	 */
+	err = otx2_attach_npa_nix(pf);
+	if (err)
+		goto err_disable_mbox_intr;
+
+	err = otx2_realloc_msix_vectors(pf);
+	if (err)
+		goto err_detach_rsrc;
+
+	err = cn10k_lmtst_init(pf);
+	if (err)
+		goto err_detach_rsrc;
+
+	return 0;
+
+err_detach_rsrc:
+	if (pf->hw.lmt_info)
+		free_percpu(pf->hw.lmt_info);
+	if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
+		qmem_free(pf->dev, pf->dync_lmt);
+	otx2_detach_resources(&pf->mbox);
+err_disable_mbox_intr:
+	otx2_disable_mbox_intr(pf);
+err_mbox_destroy:
+	otx2_pfaf_mbox_destroy(pf);
+err_free_irq_vectors:
+	pci_free_irq_vectors(hw->pdev);
+
+	return err;
+}
+EXPORT_SYMBOL(otx2_init_rsrc);
+
 static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -2879,7 +2961,6 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct net_device *netdev;
 	struct otx2_nic *pf;
 	struct otx2_hw *hw;
-	int num_vec;
 
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -2930,72 +3011,14 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Use CQE of 128 byte descriptor size by default */
 	hw->xqe_size = 128;
 
-	num_vec = pci_msix_vec_count(pdev);
-	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
-					  GFP_KERNEL);
-	if (!hw->irq_name) {
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	hw->affinity_mask = devm_kcalloc(&hw->pdev->dev, num_vec,
-					 sizeof(cpumask_var_t), GFP_KERNEL);
-	if (!hw->affinity_mask) {
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	/* Map CSRs */
-	pf->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
-	if (!pf->reg_base) {
-		dev_err(dev, "Unable to map physical function CSRs, aborting\n");
-		err = -ENOMEM;
-		goto err_free_netdev;
-	}
-
-	err = otx2_check_pf_usable(pf);
+	err = otx2_init_rsrc(pdev, pf);
 	if (err)
 		goto err_free_netdev;
 
-	err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
-				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
-	if (err < 0) {
-		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
-			__func__, num_vec);
-		goto err_free_netdev;
-	}
-
-	otx2_setup_dev_hw_settings(pf);
-
-	/* Init PF <=> AF mailbox stuff */
-	err = otx2_pfaf_mbox_init(pf);
-	if (err)
-		goto err_free_irq_vectors;
-
-	/* Register mailbox interrupt */
-	err = otx2_register_mbox_intr(pf, true);
-	if (err)
-		goto err_mbox_destroy;
-
-	/* Request AF to attach NPA and NIX LFs to this PF.
-	 * NIX and NPA LFs are needed for this PF to function as a NIC.
-	 */
-	err = otx2_attach_npa_nix(pf);
-	if (err)
-		goto err_disable_mbox_intr;
-
-	err = otx2_realloc_msix_vectors(pf);
-	if (err)
-		goto err_detach_rsrc;
-
 	err = otx2_set_real_num_queues(netdev, hw->tx_queues, hw->rx_queues);
 	if (err)
 		goto err_detach_rsrc;
 
-	err = cn10k_lmtst_init(pf);
-	if (err)
-		goto err_detach_rsrc;
-
 	/* Assign default mac address */
 	otx2_get_mac_from_af(netdev);
 
@@ -3118,11 +3141,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (test_bit(CN10K_LMTST, &pf->hw.cap_flag))
 		qmem_free(pf->dev, pf->dync_lmt);
 	otx2_detach_resources(&pf->mbox);
-err_disable_mbox_intr:
 	otx2_disable_mbox_intr(pf);
-err_mbox_destroy:
 	otx2_pfaf_mbox_destroy(pf);
-err_free_irq_vectors:
 	pci_free_irq_vectors(hw->pdev);
 err_free_netdev:
 	pci_set_drvdata(pdev, NULL);
-- 
2.25.1


