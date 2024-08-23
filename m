Return-Path: <netdev+bounces-121495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EB95D64E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0179D283D08
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF51193089;
	Fri, 23 Aug 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gCyW1YEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B436192B6D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443078; cv=none; b=bCIqDfX1ak2MZiKTCV06PB+czy6k2E1tN/c3ojk4IMxVA2qq/RFy8rwxODJKYr9iwrzULepeq6GR3YJLOlp3NQEyjwQq1EPidCvEOPqpKZX/RMhwIJ51/5Og1KMVmqAE4VitdNmJJd/1xSaDRomRCUo75p9nXNsH5+yBusqmxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443078; c=relaxed/simple;
	bh=zfqLIEOmlkAnG7Cb3I49mhzjQ6/j062qMSRb2OM/yp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMH7aNGAwjCi2cqkkouoUn3N6VP1W7pvp84yx+ozF65cdycI6/T7WOxI0WFA60Wh1jKfO4jFRBKadpQGJDFvPYHQbwpoL5TDAjgM0IuDV9TxBRfasioiCDO/D0EeJbIrVwOX1cXyGqX2Q0ZiiSylHw1TgXpUVnS255gIaf00nCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gCyW1YEP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c6aee8e8daso1656575a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443076; x=1725047876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEqlfxI0DH+Q1pLerFT9U0gFrolsvWqiRo0L9mCCOq8=;
        b=gCyW1YEPu00ChL4fh7qAgCS0MFJZqcAzA2ACHjKYHT7igpxji9r7sK7naHPOlzNEtH
         QYgCqEs/B8r0+/zkigwq4rOjIQR00Mj3oeJWendkOMyaHulSDNdL6by9AHGemKat5665
         Bs8tgtDLoB8ej1nYr8v7YSS6tzve85YelQjaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443076; x=1725047876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEqlfxI0DH+Q1pLerFT9U0gFrolsvWqiRo0L9mCCOq8=;
        b=wBHS0I62ABNsZfKKCeAF2Qo/IS1FnSTTeoexGpaJNcZRQRFIZhcn5dQ1M8VZcSL8vY
         uW64cyvxc3n4x2D0e3+P1QjXtdeRFDzmRcuEBq831uUygB9pNB6AjXtOAxkGsuXLTntz
         ybOB+NJv6OUsny8Wr1MBhJzih1AKVFyIkwmms9hacJ+3mtbhAUYvysKhZTUpyepYoneI
         iYzSwMV2yZrT3J+SZ5o0U8/RRRufh4rcHd66FfbNzr28SUYPeNGpkhTSIFU7xfFan+Vj
         W8I0wPNmyTmQ4xkBlioX5ODLTmZ90IQJLFiMEOTI668/4fmFm/Csh5XZM580hjd4534U
         I1Cg==
X-Gm-Message-State: AOJu0YzMGWu7yJo51/yMJQ1iA3doHlmHi/OdzabFKNGtrpjxUhto2AFh
	9YpCWw98X9Ff/sJSxl9y3oAhJji7mtW8BK3oXrlIrAh9hodevwpHDaKO5XXohvTlPAp2pbnmDPk
	=
X-Google-Smtp-Source: AGHT+IGD0iskTQ7O2h1rDRJvcuVNfFKN3HFvzoHLmBAJh971vL8TJnXfEif7rZhwYUPPNS9fqQGbrA==
X-Received: by 2002:a05:6a21:4603:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1cc8b50ebebmr3941700637.29.1724443076183;
        Fri, 23 Aug 2024 12:57:56 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:55 -0700 (PDT)
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
	przemyslaw.kitszel@intel.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v3 7/9] bnxt_en: Replace deprecated PCI MSIX APIs
Date: Fri, 23 Aug 2024 12:56:55 -0700
Message-ID: <20240823195657.31588-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240823195657.31588-1-michael.chan@broadcom.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2ecf9e324f2e..03598f8e0e07 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10723,7 +10723,6 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
 	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
-	struct msix_entry *msix_ent;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -10733,19 +10732,11 @@ static int bnxt_init_int_mode(struct bnxt *bp)
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
@@ -10755,7 +10746,7 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
 	if (bp->irq_tbl) {
 		for (i = 0; i < total_vecs; i++)
-			bp->irq_tbl[i].vector = msix_ent[i].vector;
+			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
 
 		bp->total_irqs = total_vecs;
 		/* Trim rings based upon num of vectors allocated */
@@ -10773,21 +10764,19 @@ static int bnxt_init_int_mode(struct bnxt *bp)
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


