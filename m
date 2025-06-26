Return-Path: <netdev+bounces-201491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E943EAE98E1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF35189F58C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F982D979A;
	Thu, 26 Jun 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cO7DXjqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970029A9C9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927590; cv=none; b=jZRTiNykNFhgP+9qmC2FCJ7pwwg9iyRRlPmszizZUcRbicRUuz6FQ4hppMliaV878NafoS73zIa5qRwlzacpDRX3+VMrWiPsfZr1b6EwOO8QFzbJdML99viVSHHbOU1zw/a1flzUnMaEKyTjcgoNxPrCwAIYUG25FdTmas4PyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927590; c=relaxed/simple;
	bh=mpzqWhT1I+6uw/XL0NOgYZhIQ3NUjVGpw47BxenLilM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRxSPkeHsUQPq7RfHAGbKHQeft7adIMF1I/6Chh85mZe9TuHXx4g+Da0SX2z6N5d5nL4j392fw9XP1An3NZUL08EimZLXr9ACwIn43GLiwvjIC1jBJzqMuDeCQUlsbeFTLrc61eMzttkckKRafOWJcO7O7fj+e2VOkOyRVjNxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cO7DXjqP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235d6de331fso10760635ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927588; x=1751532388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz5DxFLcNcY/JgVYAsCkaQXBb/kJxxrffxVb/EKMKLE=;
        b=cO7DXjqP5EEgbc/FczgWGMzEEGIWorxpHBKnIC5IWS6ZyJ+wtft7pGiEd5lnbUXG41
         YP+Fd3DedR8P+jOxuSn6goRWWyJARbBu0/OGc2VZ4oKMoPF+77H6Ecrx47ebwrG6mWcu
         ACG8IfNb/BUWTq3Ub7SGvqNnMiuQNvPQdCAX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927588; x=1751532388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz5DxFLcNcY/JgVYAsCkaQXBb/kJxxrffxVb/EKMKLE=;
        b=uXl6ZNTAxF3PC/63/tWGdslhQtAaxitCNekCv8hd3KGMbOf0wWrH0MIJSl4nwolXRQ
         gfrzVtznboQcmxNzEl/9OBLYLREi+MPnrzHSmQVbV9cNNHGg44rsOf6nCAfQ51frwtl/
         Z6xXrNdldUYxXTdU/GDRU/PPQu8nqxWzEgL8au2tHyz6b38wffY71j+UpgC5ClBnEJdW
         ZVvxTfe+SR0/KsunTT2HvOCtgexXzWoq3JoaLb2xZwYqqArZjJjlUoWRFDad4JbdssQ+
         +MorZqI7lFN3ye80cNqMA4vbTpz6/8duZ22R4FVNCpEW1MCzOAUNJs0X2U+/tUaNm0Ld
         EChA==
X-Gm-Message-State: AOJu0YxNtI4SQ4ZqFLDLa5J4CjcP/vcSXQHIzoWW6wtjmh4IvkxRsxZ7
	47WSbZ2SbAOK3vBr7ozCUVJF09bIXti/gO1b259v/TGnwV5M7QWY0/DyqEe6Qplt6w==
X-Gm-Gg: ASbGncusXoiWNwFVPKwaJ2rpyXxD2AwDsUDqzY1BpFaBTH+vjznWir6d3SZPma/gvOH
	/cpkm547pVDdetiX+wQh/6eQRJmgnwbMDfN2I1J7tRrXz8spedR40JI9bhCn7J4Fxp6XxmdT+U2
	q+DLcBEmBJUcD/rRyBvJUNGiXNhPHIV6wVPl5xz+ZjNWMmtuGEGX+JODXoqEhrL551eR4l1XA75
	xHNtgC5v39zcBgpHDZ1F2X3QOkreu8proT7BiSWGr8iFrjkvjFeD0ky9SFPtqQgjA00MrEVNmPT
	QzgajhcaXxU3a1ukrODWgwar721EADd6CTMXVVfcmmzEoh+x0L+TturvBkqxitc22SfHukN05gh
	L5F9rusUTWHo3zhpWbO6TsltHceAL7XIMs2X+HXQ=
X-Google-Smtp-Source: AGHT+IG2witw1GhiVd/zUENVh7YQ9ERywffK/p1yW6If3anO+V8/ZaXM0mhAqX6OblAnLnkhReOt8w==
X-Received: by 2002:a17:903:3bc4:b0:235:27b6:a891 with SMTP id d9443c01a7336-2382403cc2amr102083285ad.28.1750927588466;
        Thu, 26 Jun 2025 01:46:28 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:28 -0700 (PDT)
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
Subject: [net-next, v2 08/10] bng_en: Add irq allocation support
Date: Thu, 26 Jun 2025 14:08:17 +0000
Message-ID: <20250626140844.266456-9-vikas.gupta@broadcom.com>
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

Add irq allocation functions. This will help
to allocate IRQs to both netdev and RoCE aux devices.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  3 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 69 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_resc.h    | 13 ++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index b58d8fc6f258..3c161b1a9b62 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -172,6 +172,9 @@ struct bnge_dev {
 #define BNGE_SUPPORTS_TPA(bd)	((bd)->max_tpa_v2)
 
 	u8                      num_tc;
+
+	struct bnge_irq		*irq_tbl;
+	u16			irqs_acquired;
 };
 
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 68e094474822..0e67a0001677 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -326,3 +326,72 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 
 	return rc;
 }
+
+int bnge_alloc_irqs(struct bnge_dev *bd)
+{
+	u16 aux_msix, tx_cp, num_entries;
+	int i, irqs_demand, rc;
+	u16 max, min = 1;
+
+	irqs_demand = bnge_nqs_demand(bd);
+	max = bnge_get_max_func_irqs(bd);
+	if (irqs_demand > max)
+		irqs_demand = max;
+
+	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
+		min = 2;
+
+	irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
+					    PCI_IRQ_MSIX);
+	aux_msix = bnge_aux_get_msix(bd);
+	if (irqs_demand < 0 || irqs_demand < aux_msix) {
+		rc = -ENODEV;
+		goto err_free_irqs;
+	}
+
+	num_entries = irqs_demand;
+	if (pci_msix_can_alloc_dyn(bd->pdev))
+		num_entries = max;
+	bd->irq_tbl = kcalloc(num_entries, sizeof(*bd->irq_tbl), GFP_KERNEL);
+	if (!bd->irq_tbl) {
+		rc = -ENOMEM;
+		goto err_free_irqs;
+	}
+
+	for (i = 0; i < irqs_demand; i++)
+		bd->irq_tbl[i].vector = pci_irq_vector(bd->pdev, i);
+
+	bd->irqs_acquired = irqs_demand;
+	/* Reduce rings based upon num of vectors allocated.
+	 * We dont need to consider NQs as they have been calculated
+	 * and must be more than irqs_demand.
+	 */
+	rc = bnge_adjust_rings(bd, &bd->rx_nr_rings,
+			       &bd->tx_nr_rings,
+			       irqs_demand - aux_msix, min == 1);
+	if (rc)
+		goto err_free_irqs;
+
+	tx_cp = bnge_num_tx_to_cp(bd, bd->tx_nr_rings);
+	bd->nq_nr_rings = (min == 1) ?
+		max_t(u16, tx_cp, bd->rx_nr_rings) :
+		tx_cp + bd->rx_nr_rings;
+
+	/* Readjust tx_nr_rings_per_tc */
+	if (!bd->num_tc)
+		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
+
+	return 0;
+
+err_free_irqs:
+	dev_err(bd->dev, "Failed to allocate IRQs err = %d\n", rc);
+	bnge_free_irqs(bd);
+	return rc;
+}
+
+void bnge_free_irqs(struct bnge_dev *bd)
+{
+	pci_free_irq_vectors(bd->pdev);
+	kfree(bd->irq_tbl);
+	bd->irq_tbl = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index c6cef514588f..23db93e03787 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -51,8 +51,21 @@ struct bnge_hw_rings {
 	u16 rss_ctx;
 };
 
+/* "TXRX", 2 hypens, plus maximum integer */
+#define BNGE_IRQ_NAME_EXTRA	17
+struct bnge_irq {
+	irq_handler_t	handler;
+	unsigned int	vector;
+	u8		requested:1;
+	u8		have_cpumask:1;
+	char		name[IFNAMSIZ + BNGE_IRQ_NAME_EXTRA];
+	cpumask_var_t	cpu_mask;
+};
+
 int bnge_reserve_rings(struct bnge_dev *bd);
 int bnge_fix_rings_count(u16 *rx, u16 *tx, u16 max, bool shared);
+int bnge_alloc_irqs(struct bnge_dev *bd);
+void bnge_free_irqs(struct bnge_dev *bd);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.47.1


