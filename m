Return-Path: <netdev+bounces-198959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A833ADE6E5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33C51740F0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0E28A1DE;
	Wed, 18 Jun 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A5SZsXH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFF284663
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238700; cv=none; b=N3U4b9tJABR868Q5PLY8fjlgJmeHvxxil1aIKKqS3wRgHljaumXLk1IWF+WWyxb0IFWumhpcV9ntvWCBbV1KvNyxpOujJq9ydU4obt/U7LGwB7s6vVLoC7qa0hL7EwBp9Y0brGHxueK++eqSIOZYC1JU7vy5IzHHkPxWvBj3A5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238700; c=relaxed/simple;
	bh=+jYbBLULxAnZLs4ECjDPNXUyJh89OcFcoxdMunkJ9hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVCfdAzuon7TILSUH/GTFk7pbTDp8EpSgU8unw/nScq2BsLRsnd0auXPj79U4AXdKtJQtXwY2fjD1TmVxc5+I0nTioa44lEF6uKtodlxyuLPMavFAiVZDrrNdh8iUb+kCqMSF40dA+gCOmmr0Ynf+ileiCJlxasWmIe/m3nlqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A5SZsXH0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e97cso1257450b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238698; x=1750843498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjZBGiGgqOOLwfoyW1GtVx9ASyWTSLK+uTZekEDcjuo=;
        b=A5SZsXH0ziLOCzWA4h+hHUSnH9RgHHJyPn4Xvou/XiIezzlNW8V0Z9UPL7YjpgdcY3
         E45R+6pdnSj23D1vOONS2P+gDDLt06FGZ3SrFnzFcL31O1l+6ZniPSWixWVrKst+YUwo
         t+DbsLT8sjfH9LAPm9NlVWqakkgEm+Egjcy20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238698; x=1750843498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjZBGiGgqOOLwfoyW1GtVx9ASyWTSLK+uTZekEDcjuo=;
        b=EeisTi6mmEwcBbCDG1oaB6yQS2w8iEZdByfeK/UIEgOTJYQbWpWXrazYElxdmi9vu5
         NLsEDSWHZpoFInTwwsJrZQkAzdOMuosQ/lECTZidW2Ucx8QqLBZWmez9xKmpieGuf5k6
         x/F70XnfJh4dwDl3lfM27I5l+UAmZPFMxmcNrsa78qltZfgtIBn+KQLm+xx+o9xdVgRA
         hIAjWWqlw1hi0j15FbkFYaJVwDMAyGWHrZ/GN2Tt6mAWx4G5FGhLM1mAdV/M9RlpB1jU
         UPHcRTJrnNpYKwMpdoVdjwRAd9mPh/UnX8b1umIIwukM+t0yT6nLMY1g1ROgcFiH5P/6
         oRxw==
X-Gm-Message-State: AOJu0Yyk1IbBiiYfwZ54N+doZZDc9giBsoDk1UqLVT06VTD5fNlMoz74
	euhSau25YmEAWT2LQHFT++WQFh+LYu9ri7pv33ySWRUNJu9RtgGrJqXM0AWj40gCbw==
X-Gm-Gg: ASbGnctMBriuZkEx5uURQ7UKXN5LyGyWrQb6eNYfE3Zi7yy6QM/McTWGuECpGS51jZP
	ezbSHUdDnZ2loaaeI8nZbefckwwRL8vqXwgqbxa3+Xz1zbNc9DHuq2LU23VkMdRY8P0U70kJI9P
	KD2mVCXz7efhuNTcvvJ0WLxyeZM83sMBeNwigZw6oYzEm9mnEVH0dw5zc4hieFnALT8W57tDSDN
	LeAeg+QrMaLVDkShcTgs1Efj1BO0E6x9SXfIxrNUsgADwFvybDe634VClPVFloJydIhmxKUsqN6
	lqLr1ICuVZgMmdBeCSy3jx76JmKQ2LpPc9MVOeS41n8iFVoa/w7U9u2GCVuCd97wc4gitZhYuGU
	gWUEddJ+h8GXTa5RR/yg6HdRO5B4u
X-Google-Smtp-Source: AGHT+IH4MG64SCB97l2547kyD7vV1k62qfuOQWN4U926rjrfJcngE2qahuMITfeWAa1wKvRdjfbKWw==
X-Received: by 2002:a05:6a00:2186:b0:748:33f3:8da8 with SMTP id d2e1a72fcca58-7489cfc2976mr18661159b3a.5.1750238697791;
        Wed, 18 Jun 2025 02:24:57 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:57 -0700 (PDT)
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
Subject: [net-next, 08/10] bng_en: Add irq allocation support
Date: Wed, 18 Jun 2025 14:47:38 +0000
Message-ID: <20250618144743.843815-9-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618144743.843815-1-vikas.gupta@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
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
index 68e094474822..84f91e05a2b0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -326,3 +326,72 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 
 	return rc;
 }
+
+int bnge_alloc_irqs(struct bnge_dev *bd)
+{
+	u16 aux_msix, tx_cp, num_entries;
+	u16 irqs_demand, max, min = 1;
+	int i, rc = 0;
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


