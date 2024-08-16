Return-Path: <netdev+bounces-119324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D020D955260
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B66284F7A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47621C57A9;
	Fri, 16 Aug 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FQYnxA0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114141C7B7C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843761; cv=none; b=bOYS0JsmSTnVTXzndXJQv5uGhGjDeXbepTVuKK8mirmyHbvIUmu8rEVFpumHhUbyuPTwDEi63JMphmpRokgNcB8+EEnVtxIHC5n5Di7zpY9xAJnMtTrwHYZLsh1D2DB/u3D4UYQ4ZFvxdFJVXkfQafViFHbgI4lcgvfQuG49Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843761; c=relaxed/simple;
	bh=CTrxxlKCLKeylesgUbLA47h8BxyyPcpt1EaDEvS9EfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6D07Rn4kKaBO6cJ3AGq/RQhMryBGA3f971T8RF3/t12++R93L7WKl3gUuho8jrjNqXzSs1l6d09vZF8hZyq387gSmkl8xTX5buwkLa/Z97Yn8/S2XfK2Mqi21pseVfsKS+P8RLUCXlf2Hp9gz+7JIOGjftT5zk0y5i0rJmr5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FQYnxA0K; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db145c8010so1521523b6e.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843759; x=1724448559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XmNeikEmcv/JzzuTRyvb8CpnWK2tXjyoAycIU0hhoI=;
        b=FQYnxA0KeKbSzSmgesStYpg5B3ciISA0KuaVMKBWxNSIfRyn5ERqFImtJMKeoev5Rb
         SKY9tHf2m+jOERU3kMSeElDOnmtHdxVjvvYOhWNNWQzfMmiiW5Ueg3dejMrrcwcjiWAA
         BJ/zveVIPyRyu/zAm0nQ8e/owLu+lBw0oHSDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843759; x=1724448559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XmNeikEmcv/JzzuTRyvb8CpnWK2tXjyoAycIU0hhoI=;
        b=tBNrOgZeRdX3arTvIls4vNvTLeWlMiOZ0vLcnidWJBOc3YdB2SjfSlMIRM8epA1Rfm
         8qySJaTbQYcnYZjGWbsS4ONkgJXQpUEABy3CBCpl1NAotYkmwiLtWCoJj7Iz3M1siiJC
         itCNf3T8H9lLvkhNwrSYjW94QtcNBQ4eTX99BH96w5KDAR8jkUJiENMxhdLKP8e+wS2X
         Uqgi7V3AzxjJM0UrgRrb6dUbe6immxzcU7CgZnlpTgTxCG3T0yr5+HjFzHpPfKsOVyxw
         T9Y/ZiX5qi0hehlUMPqekjnWdgtAWmiXDCS6jfgOF/CmY9QI61Rg7/e1EjjAOi1MBHw6
         Lgyg==
X-Gm-Message-State: AOJu0YxAwVaJZW/gFZp2x/NkwIyKvNOCGB4Li7CqkyBa9oJ9a+qcpwwn
	AiOfNDqgrs90zqkKwx6IVXU9itiyy+qUOnCNiVmqyGcArdWokHB6oMC1L/d6Fw==
X-Google-Smtp-Source: AGHT+IG38lT/LXiFdsVwHJpG5/FakB8yxScuipvBsshalF6t2ceYUtKRlaHcgJirlHyU/V9Bg8Vo2w==
X-Received: by 2002:a05:6808:ecf:b0:3d9:ad9d:622f with SMTP id 5614622812f47-3dd3ad4f38dmr3895587b6e.27.1723843758957;
        Fri, 16 Aug 2024 14:29:18 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 7/9] bnxt_en: Replace deprecated PCI MSIX APIs
Date: Fri, 16 Aug 2024 14:28:30 -0700
Message-ID: <20240816212832.185379-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240816212832.185379-1-michael.chan@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new pci_alloc_irq_vectors() and pci_free_irq_vectors() to
replace the deprecated pci_enable_msix_range() and pci_disable_msix().

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0666bf0e5dc6..5d0d40d78c37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10725,7 +10725,6 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
 	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
-	struct msix_entry *msix_ent;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -10735,19 +10734,11 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	if (!total_vecs)
 		return 0;
 
-	msix_ent = kcalloc(total_vecs, sizeof(struct msix_entry), GFP_KERNEL);
-	if (!msix_ent)
-		return -ENOMEM;
-
-	for (i = 0; i < total_vecs; i++) {
-		msix_ent[i].entry = i;
-		msix_ent[i].vector = 0;
-	}
-
 	if (!(bp->flags & BNXT_FLAG_SHARED_RINGS))
 		min = 2;
 
-	total_vecs = pci_enable_msix_range(bp->pdev, msix_ent, min, total_vecs);
+	total_vecs = pci_alloc_irq_vectors(bp->pdev, min, total_vecs,
+					   PCI_IRQ_MSIX);
 	ulp_msix = bnxt_get_ulp_msix_num(bp);
 	if (total_vecs < 0 || total_vecs < ulp_msix) {
 		rc = -ENODEV;
@@ -10757,7 +10748,7 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
 	if (bp->irq_tbl) {
 		for (i = 0; i < total_vecs; i++)
-			bp->irq_tbl[i].vector = msix_ent[i].vector;
+			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
 
 		bp->total_irqs = total_vecs;
 		/* Trim rings based upon num of vectors allocated */
@@ -10775,21 +10766,19 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
-	kfree(msix_ent);
 	return 0;
 
 msix_setup_exit:
 	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
-	pci_disable_msix(bp->pdev);
-	kfree(msix_ent);
+	pci_free_irq_vectors(bp->pdev);
 	return rc;
 }
 
 static void bnxt_clear_int_mode(struct bnxt *bp)
 {
-	pci_disable_msix(bp->pdev);
+	pci_free_irq_vectors(bp->pdev);
 
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
-- 
2.30.1


