Return-Path: <netdev+bounces-201492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C6AE98E6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53CB6A1D95
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6C29B8F0;
	Thu, 26 Jun 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZpSbsDhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF182D97BF
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927595; cv=none; b=loEaNKz7voBpMzdaoe1yKVLxaEeiOhOsNKJv9a7846iYPzg3MGcVf/5J1mzka8kpbEKDVtLsO07Qwy7hF7ywwn4jenMxAedv50hmOGB9TNANubOxbA4WHeARGwOGkV23TNX/i47NIapzvA6ZTt1+KP6Yutpas9Sn74d6w9Ylv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927595; c=relaxed/simple;
	bh=dwswPPn85QE/WevGYEd3ymDW5D2V7xQ1H9WJ3DFHJlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffqXjOtX1gDYLVfozWtZEUitZzBGzzWC6dfZ/TTECHiU4wLly/hjI3FlmJ1R89bMt9t7VNtPPfHbgOVBWSFPIOWZuXvqxSrpcXBhDxUm8DN/D5oNrhxUIVRweEoXIGlBpjV0rocdZHUzDbsLJx+yqKoOhMbq1j3raq0ps+nt+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZpSbsDhQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234c5b57557so7518605ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927593; x=1751532393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVg7xdRH0OHkyVegi5mo3IlVjjrCkzZj5ynXXGjit7A=;
        b=ZpSbsDhQUhI2PkQfevv0erCImES20WUjhVVhtc5Jnp2SgwZw64py3NmLqX0T0eb3PQ
         1PtxpyOqfOAGpCLxPvRhMrz8BkC7W6yQPVForLoP1JUVo+y2//Nnd5nJWAHMfzjnhvoE
         Q2DSDb867rWmNTNKE/1sJS6AODNqWvnRWsxqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927593; x=1751532393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVg7xdRH0OHkyVegi5mo3IlVjjrCkzZj5ynXXGjit7A=;
        b=U3rJbWkIK2U53oveYHOtbqvk/09oLYZrBz8ZZjPtj3H/SnpDM6PzMhjS0Ru83HB5eA
         LcwPVjtn0ri6OLAHtkRPPX+YfBbuu2NlQwYOIBiPLJWyGGDcXdszdie9bFnU4cIycPkU
         3DmlYQ2qfViY+v+lsq3+J3dacGs+fk6Dh+6xNlxWCycjZrGF1STRO0c5x/rutaHHHcF8
         af/BQQIOvtaVpQGFoVZ9uwnBjn2pukwTotixQPo+KnKi6UnvsVQ+llTeoVKxLFkgE6C3
         ZbRgmIdMCIdIhFAu5qiEd0Lwsyib7A6dxbgWChyqmZRKAdvfD9GWo8ODHZjTMSs/HjSv
         OwLQ==
X-Gm-Message-State: AOJu0YwrUvejNAVXB75BlqsrT4/ZRZqC0td6m59ZmZETaPDsp1rb15cc
	Qovpl2HVK/W73Jqlk+7ZMLaInv84g+puV4mTPlrqAYR1PtaSi5lgZHVlL2kYFSLMhLUIytP7k9m
	01/IUJw==
X-Gm-Gg: ASbGncv5H6r5W1k6uMolbspqkjWxyCX4ZTnFU43qdv9TuSY8HX7kXDD7MwqJ/zmvOTB
	2lcQmaZ8o5TBz0MySBZt7RHOX+Hag3BTXEBY3orZm9vfFOWVRuUdIX7DUu0W0QYnKJctfrzyFwN
	Ir4RlMflfR0w+cINqMzkpxhy/p4m1bc6pIroUOYqF6cJKvhnKnhPEUhga2+q49Ei+K7HF6c84ly
	N/On1gwt7n7D36i9vmLUH3aNVRMsw3DWWrL0eGfwPBagxTD9ZXVV7wlN7F4OyAZhwiICLVboCJF
	g20VS8KqW4H75Z97LCCMVwnRW1IcsA3B0ec0BT14clwS+eOjb7ljoy2F0+s0COClxdMd3Sh7tRq
	gOFTKUZrKCeN1Il3ZpkFJmpvTwacXNEx3MdkuQWU=
X-Google-Smtp-Source: AGHT+IGiqQtrfITv5h+HOv0VNYktVelAVN6EvR/SXRvoAvqVov6x56Wmbr0Cbkz1anDUUmXAiEKVAA==
X-Received: by 2002:a17:903:1110:b0:234:bca7:2926 with SMTP id d9443c01a7336-2382402e575mr96048445ad.27.1750927592885;
        Thu, 26 Jun 2025 01:46:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:32 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v2 09/10] bng_en: Initialize default configuration
Date: Thu, 26 Jun 2025 14:08:18 +0000
Message-ID: <20250626140844.266456-10-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626140844.266456-1-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Query resources from the firmware and, based on the
availability of resources, initialize the default
settings. The default settings include:
1. Rings and other resource reservations with the
firmware. This ensures that resources are reserved
before network and auxiliary devices are created.
2. Mapping the BAR, which helps access doorbells since
its size is known after querying the firmware.
3. Retrieving the TCs and hardware CoS queue mappings.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  14 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 122 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  54 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 208 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   3 +
 6 files changed, 402 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 3c161b1a9b62..cef66c1e9006 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -80,6 +80,12 @@ enum {
 	BNGE_RSS_CAP_ESP_V6_RSS_CAP			= BIT(7),
 };
 
+#define BNGE_MAX_QUEUE		8
+struct bnge_queue_info {
+	u8      queue_id;
+	u8      queue_profile;
+};
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -89,6 +95,7 @@ struct bnge_dev {
 	char		board_serialno[BNGE_VPD_FLD_LEN];
 
 	void __iomem	*bar0;
+	void __iomem	*bar1;
 
 	u16		chip_num;
 	u8		chip_rev;
@@ -172,6 +179,13 @@ struct bnge_dev {
 #define BNGE_SUPPORTS_TPA(bd)	((bd)->max_tpa_v2)
 
 	u8                      num_tc;
+	u8			max_tc;
+	u8			max_lltc;	/* lossless TCs */
+	struct bnge_queue_info	q_info[BNGE_MAX_QUEUE];
+	u8			tc_to_qidx[BNGE_MAX_QUEUE];
+	u8			q_ids[BNGE_MAX_QUEUE];
+	u8			max_q;
+	u8			port_count;
 
 	struct bnge_irq		*irq_tbl;
 	u16			irqs_acquired;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 47d56f7c28af..22df6836dab9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -54,9 +54,46 @@ static void bnge_nvm_cfg_ver_get(struct bnge_dev *bd)
 			 nvm_info.nvm_cfg_ver_upd);
 }
 
+static int bnge_func_qcaps(struct bnge_dev *bd)
+{
+	int rc;
+
+	rc = bnge_hwrm_func_qcaps(bd);
+	if (rc)
+		return rc;
+
+	rc = bnge_hwrm_queue_qportcfg(bd);
+	if (rc) {
+		dev_err(bd->dev, "query qportcfg failure rc: %d\n", rc);
+		return rc;
+	}
+
+	rc = bnge_hwrm_func_resc_qcaps(bd);
+	if (rc) {
+		dev_err(bd->dev, "query resc caps failure rc: %d\n", rc);
+		return rc;
+	}
+
+	rc = bnge_hwrm_func_qcfg(bd);
+	if (rc) {
+		dev_err(bd->dev, "query config failure rc: %d\n", rc);
+		return rc;
+	}
+
+	rc = bnge_hwrm_vnic_qcaps(bd);
+	if (rc) {
+		dev_err(bd->dev, "vnic caps failure rc: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
 static void bnge_fw_unregister_dev(struct bnge_dev *bd)
 {
+	/* ctx mem free after unrgtr only */
 	bnge_hwrm_func_drv_unrgtr(bd);
+	bnge_free_ctx_mem(bd);
 }
 
 static int bnge_fw_register_dev(struct bnge_dev *bd)
@@ -86,7 +123,25 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 		return rc;
 	}
 
+	rc = bnge_alloc_ctx_mem(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", rc);
+		goto err_func_unrgtr;
+	}
+
+	/* Get the resources and configuration from firmware */
+	rc = bnge_func_qcaps(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed initial configuration rc: %d\n", rc);
+		rc = -ENODEV;
+		goto err_func_unrgtr;
+	}
+
 	return 0;
+
+err_func_unrgtr:
+	bnge_fw_unregister_dev(bd);
+	return rc;
 }
 
 static void bnge_pci_disable(struct pci_dev *pdev)
@@ -134,14 +189,46 @@ static void bnge_unmap_bars(struct pci_dev *pdev)
 {
 	struct bnge_dev *bd = pci_get_drvdata(pdev);
 
+	if (bd->bar1) {
+		pci_iounmap(pdev, bd->bar1);
+		bd->bar1 = NULL;
+	}
+
 	if (bd->bar0) {
 		pci_iounmap(pdev, bd->bar0);
 		bd->bar0 = NULL;
 	}
 }
 
+static void bnge_set_max_func_irqs(struct bnge_dev *bd,
+				   unsigned int max_irqs)
+{
+	bd->hw_resc.max_irqs = max_irqs;
+}
+
+static int bnge_get_max_irq(struct pci_dev *pdev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(pdev, pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	return (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
+}
+
+static int bnge_map_db_bar(struct bnge_dev *bd)
+{
+	if (!bd->db_size)
+		return -ENODEV;
+
+	bd->bar1 = pci_iomap(bd->pdev, 2, bd->db_size);
+	if (!bd->bar1)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	unsigned int max_irqs;
 	struct bnge_dev *bd;
 	int rc;
 
@@ -190,10 +277,41 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_hwrm_cleanup;
 	}
 
+	max_irqs = bnge_get_max_irq(pdev);
+	bnge_set_max_func_irqs(bd, max_irqs);
+
+	bnge_aux_init_dflt_config(bd);
+
+	rc = bnge_net_init_dflt_config(bd);
+	if (rc) {
+		dev_err(&pdev->dev, "Error setting up default cfg to netdev rc = %d\n",
+			rc);
+		goto err_fw_reg;
+	}
+
+	rc = bnge_map_db_bar(bd);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed mapping doorbell BAR rc = %d, aborting\n",
+			rc);
+		goto err_config_uninit;
+	}
+
+	rc = bnge_alloc_irqs(bd);
+	if (rc) {
+		dev_err(&pdev->dev, "Error IRQ allocation rc = %d\n", rc);
+		goto err_config_uninit;
+	}
+
 	pci_save_state(pdev);
 
 	return 0;
 
+err_config_uninit:
+	bnge_net_uninit_dflt_config(bd);
+
+err_fw_reg:
+	bnge_fw_unregister_dev(bd);
+
 err_hwrm_cleanup:
 	bnge_cleanup_hwrm_resources(bd);
 
@@ -213,6 +331,10 @@ static void bnge_remove_one(struct pci_dev *pdev)
 {
 	struct bnge_dev *bd = pci_get_drvdata(pdev);
 
+	bnge_free_irqs(bd);
+
+	bnge_net_uninit_dflt_config(bd);
+
 	bnge_fw_unregister_dev(bd);
 
 	bnge_cleanup_hwrm_resources(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index ee2675776c14..19091318cfdd 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -647,3 +647,57 @@ int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd)
 
 	return rc;
 }
+
+#define BNGE_CNPQ(q_profile)	\
+		((q_profile) ==	\
+		 QUEUE_QPORTCFG_RESP_QUEUE_ID0_SERVICE_PROFILE_LOSSY_ROCE_CNP)
+
+int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
+{
+	struct hwrm_queue_qportcfg_output *resp;
+	struct hwrm_queue_qportcfg_input *req;
+	u8 i, j, *qptr;
+	bool no_rdma;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_QUEUE_QPORTCFG);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto qportcfg_exit;
+
+	if (!resp->max_configurable_queues) {
+		rc = -EINVAL;
+		goto qportcfg_exit;
+	}
+	bd->max_tc = resp->max_configurable_queues;
+	bd->max_lltc = resp->max_configurable_lossless_queues;
+	if (bd->max_tc > BNGE_MAX_QUEUE)
+		bd->max_tc = BNGE_MAX_QUEUE;
+
+	no_rdma = !bnge_is_roce_en(bd);
+	qptr = &resp->queue_id0;
+	for (i = 0, j = 0; i < bd->max_tc; i++) {
+		bd->q_info[j].queue_id = *qptr;
+		bd->q_ids[i] = *qptr++;
+		bd->q_info[j].queue_profile = *qptr++;
+		bd->tc_to_qidx[j] = j;
+		if (!BNGE_CNPQ(bd->q_info[j].queue_profile) || no_rdma)
+			j++;
+	}
+	bd->max_q = bd->max_tc;
+	bd->max_tc = max_t(u8, j, 1);
+
+	if (resp->queue_cfg_info & QUEUE_QPORTCFG_RESP_QUEUE_CFG_INFO_ASYM_CFG)
+		bd->max_tc = 1;
+
+	if (bd->max_lltc > bd->max_tc)
+		bd->max_lltc = bd->max_tc;
+
+qportcfg_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 59ec1899879a..6c03923eb559 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -22,5 +22,6 @@ int bnge_hwrm_func_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 0e67a0001677..c79a3607a1b7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ethtool.h>
+#include <linux/netdevice.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -28,6 +29,16 @@ static u16 bnge_get_max_func_irqs(struct bnge_dev *bd)
 	return min_t(u16, hw_resc->max_irqs, hw_resc->max_nqs);
 }
 
+static unsigned int bnge_get_max_func_stat_ctxs(struct bnge_dev *bd)
+{
+	return bd->hw_resc.max_stat_ctxs;
+}
+
+static unsigned int bnge_get_max_func_cp_rings(struct bnge_dev *bd)
+{
+	return bd->hw_resc.max_cp_rings;
+}
+
 static int bnge_aux_get_dflt_msix(struct bnge_dev *bd)
 {
 	int roce_msix = BNGE_MAX_ROCE_MSIX;
@@ -68,6 +79,20 @@ static u16 bnge_func_stat_ctxs_demand(struct bnge_dev *bd)
 	return bd->nq_nr_rings + bnge_aux_get_stat_ctxs(bd);
 }
 
+static int bnge_get_dflt_aux_stat_ctxs(struct bnge_dev *bd)
+{
+	int stat_ctx = 0;
+
+	if (bnge_is_roce_en(bd)) {
+		stat_ctx = BNGE_MIN_ROCE_STAT_CTXS;
+
+		if (!bd->pf.port_id && bd->port_count > 1)
+			stat_ctx++;
+	}
+
+	return stat_ctx;
+}
+
 static u16 bnge_nqs_demand(struct bnge_dev *bd)
 {
 	return bd->nq_nr_rings + bnge_aux_get_msix(bd);
@@ -395,3 +420,186 @@ void bnge_free_irqs(struct bnge_dev *bd)
 	kfree(bd->irq_tbl);
 	bd->irq_tbl = NULL;
 }
+
+static void _bnge_get_max_rings(struct bnge_dev *bd, u16 *max_rx,
+				u16 *max_tx, u16 *max_nq)
+{
+	struct bnge_hw_resc *hw_resc = &bd->hw_resc;
+	u16 max_ring_grps = 0, max_cp;
+	int rc;
+
+	*max_tx = hw_resc->max_tx_rings;
+	*max_rx = hw_resc->max_rx_rings;
+	*max_nq = min_t(int, bnge_get_max_func_irqs(bd),
+			hw_resc->max_stat_ctxs);
+	max_ring_grps = hw_resc->max_hw_ring_grps;
+	if (bnge_is_agg_reqd(bd))
+		*max_rx >>= 1;
+
+	max_cp = bnge_get_max_func_cp_rings(bd);
+
+	/* Fix RX and TX rings according to number of CPs available */
+	rc = bnge_fix_rings_count(max_rx, max_tx, max_cp, false);
+	if (rc) {
+		*max_rx = 0;
+		*max_tx = 0;
+	}
+
+	*max_rx = min_t(int, *max_rx, max_ring_grps);
+}
+
+static int bnge_get_max_rings(struct bnge_dev *bd, u16 *max_rx,
+			      u16 *max_tx, bool shared)
+{
+	u16 rx, tx, nq;
+
+	_bnge_get_max_rings(bd, &rx, &tx, &nq);
+	*max_rx = rx;
+	*max_tx = tx;
+	if (!rx || !tx || !nq)
+		return -ENOMEM;
+
+	return bnge_fix_rings_count(max_rx, max_tx, nq, shared);
+}
+
+static int bnge_get_dflt_rings(struct bnge_dev *bd, u16 *max_rx, u16 *max_tx,
+			       bool shared)
+{
+	int rc;
+
+	rc = bnge_get_max_rings(bd, max_rx, max_tx, shared);
+	if (rc) {
+		dev_info(bd->dev, "Not enough rings available\n");
+		return rc;
+	}
+
+	if (bnge_is_roce_en(bd)) {
+		int max_cp, max_stat, max_irq;
+
+		/* Reserve minimum resources for RoCE */
+		max_cp = bnge_get_max_func_cp_rings(bd);
+		max_stat = bnge_get_max_func_stat_ctxs(bd);
+		max_irq = bnge_get_max_func_irqs(bd);
+		if (max_cp <= BNGE_MIN_ROCE_CP_RINGS ||
+		    max_irq <= BNGE_MIN_ROCE_CP_RINGS ||
+		    max_stat <= BNGE_MIN_ROCE_STAT_CTXS)
+			return 0;
+
+		max_cp -= BNGE_MIN_ROCE_CP_RINGS;
+		max_irq -= BNGE_MIN_ROCE_CP_RINGS;
+		max_stat -= BNGE_MIN_ROCE_STAT_CTXS;
+		max_cp = min_t(u16, max_cp, max_irq);
+		max_cp = min_t(u16, max_cp, max_stat);
+		rc = bnge_adjust_rings(bd, max_rx, max_tx, max_cp, shared);
+		if (rc)
+			rc = 0;
+	}
+
+	return rc;
+}
+
+/* In initial default shared ring setting, each shared ring must have a
+ * RX/TX ring pair.
+ */
+static void bnge_trim_dflt_sh_rings(struct bnge_dev *bd)
+{
+	bd->nq_nr_rings = min_t(u16, bd->tx_nr_rings_per_tc, bd->rx_nr_rings);
+	bd->rx_nr_rings = bd->nq_nr_rings;
+	bd->tx_nr_rings_per_tc = bd->nq_nr_rings;
+	bd->tx_nr_rings = bd->tx_nr_rings_per_tc;
+}
+
+static int bnge_net_init_dflt_rings(struct bnge_dev *bd, bool sh)
+{
+	u16 dflt_rings, max_rx_rings, max_tx_rings;
+	int rc;
+
+	if (sh)
+		bd->flags |= BNGE_EN_SHARED_CHNL;
+
+	dflt_rings = netif_get_num_default_rss_queues();
+
+	rc = bnge_get_dflt_rings(bd, &max_rx_rings, &max_tx_rings, sh);
+	if (rc)
+		return rc;
+	bd->rx_nr_rings = min_t(u16, dflt_rings, max_rx_rings);
+	bd->tx_nr_rings_per_tc = min_t(u16, dflt_rings, max_tx_rings);
+	if (sh)
+		bnge_trim_dflt_sh_rings(bd);
+	else
+		bd->nq_nr_rings = bd->tx_nr_rings_per_tc + bd->rx_nr_rings;
+	bd->tx_nr_rings = bd->tx_nr_rings_per_tc;
+
+	rc = bnge_reserve_rings(bd);
+	if (rc && rc != -ENODEV)
+		dev_warn(bd->dev, "Unable to reserve tx rings\n");
+	bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
+	if (sh)
+		bnge_trim_dflt_sh_rings(bd);
+
+	/* Rings may have been reduced, re-reserve them again */
+	if (bnge_need_reserve_rings(bd)) {
+		rc = bnge_reserve_rings(bd);
+		if (rc && rc != -ENODEV)
+			dev_warn(bd->dev, "Fewer rings reservation failed\n");
+		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
+	}
+	if (rc) {
+		bd->tx_nr_rings = 0;
+		bd->rx_nr_rings = 0;
+	}
+
+	return rc;
+}
+
+static int bnge_alloc_rss_indir_tbl(struct bnge_dev *bd)
+{
+	u16 entries;
+
+	entries = BNGE_MAX_RSS_TABLE_ENTRIES;
+
+	bd->rss_indir_tbl_entries = entries;
+	bd->rss_indir_tbl =
+		kmalloc_array(entries, sizeof(*bd->rss_indir_tbl), GFP_KERNEL);
+	if (!bd->rss_indir_tbl)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int bnge_net_init_dflt_config(struct bnge_dev *bd)
+{
+	struct bnge_hw_resc *hw_resc;
+	int rc;
+
+	rc = bnge_alloc_rss_indir_tbl(bd);
+	if (rc)
+		return rc;
+
+	rc = bnge_net_init_dflt_rings(bd, true);
+	if (rc)
+		goto err_free_tbl;
+
+	hw_resc = &bd->hw_resc;
+	bd->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
+		       BNGE_L2_FLTR_MAX_FLTR;
+
+	return 0;
+
+err_free_tbl:
+	kfree(bd->rss_indir_tbl);
+	bd->rss_indir_tbl = NULL;
+	return rc;
+}
+
+void bnge_net_uninit_dflt_config(struct bnge_dev *bd)
+{
+	kfree(bd->rss_indir_tbl);
+	bd->rss_indir_tbl = NULL;
+}
+
+void bnge_aux_init_dflt_config(struct bnge_dev *bd)
+{
+	bd->aux_num_msix = bnge_aux_get_dflt_msix(bd);
+	bd->aux_num_stat_ctxs = bnge_get_dflt_aux_stat_ctxs(bd);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index 23db93e03787..b39fd1a7a81b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -66,6 +66,9 @@ int bnge_reserve_rings(struct bnge_dev *bd);
 int bnge_fix_rings_count(u16 *rx, u16 *tx, u16 max, bool shared);
 int bnge_alloc_irqs(struct bnge_dev *bd);
 void bnge_free_irqs(struct bnge_dev *bd);
+int bnge_net_init_dflt_config(struct bnge_dev *bd);
+void bnge_net_uninit_dflt_config(struct bnge_dev *bd);
+void bnge_aux_init_dflt_config(struct bnge_dev *bd);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.47.1


