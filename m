Return-Path: <netdev+bounces-122893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA2963014
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7421C20DB7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B219FA77;
	Wed, 28 Aug 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrrbRrFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931A1AB52A
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869992; cv=none; b=c70vBFuYGTrtO8hiWDhzb4P7aoQOPNUEzJ5CpGj4oyz7lQjUrW0LsW7ubheygAQ+iNr35ypkbk3QLgMd+Lm56rV1Pwt7FMhKwgT1snwrg/6C2FZBkJBHISerNlX+T6e9Fit7UpsuijFQGJozFIRtcNKLe399A9MB/u3dBItdeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869992; c=relaxed/simple;
	bh=zfqLIEOmlkAnG7Cb3I49mhzjQ6/j062qMSRb2OM/yp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T334qYJ9XFZ+5T9pkiEbpVeM1cHQ/4boNWmNvGEc/d1JGTHBtKTyEkcQcku7mL6c4OZh3bg+ZjjhPytRO4FWnY79BCxJKCoFLUbUrg19u24TS/x/r/gWX7XPW1IjpsIXuoQzGRLwJMN8WKWxWx692XVp/oZLjmZZmFIKWo149C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrrbRrFJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a8049d4a4cso2724785a.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869990; x=1725474790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEqlfxI0DH+Q1pLerFT9U0gFrolsvWqiRo0L9mCCOq8=;
        b=ZrrbRrFJs+aYsivt0BmVeUZL/r7QiUYdALq7xV5szvP3QEhDG4yCDk9HWcgBchIVh0
         gIRHlAyDnu34SQRIK3vPWUtDMDTBYLS/VJDJ5SxHLChnnt1eLmKmCteEWb3ZAEoRVdLw
         RYthsLyvhNF1gS9dTD9Ob51xBVX0arNME6T3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869990; x=1725474790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEqlfxI0DH+Q1pLerFT9U0gFrolsvWqiRo0L9mCCOq8=;
        b=fFXhCobH9OopJynttBLojJVeBjGvu4RIf4dx1dxx9R+snwWoTg9PyVGtSaxzttUkAE
         4+eGXE6YM5vNHB8b8b0afmUHno2fIl02WhB0dHsAa4UPvlabQxgjx8bMM7fsyAUN5qVw
         w7zCSr0FNHVq1eHNAZj4W9/O/PyxU988pIvwRfbxjDxHZbzZNOvcEpa7OTLKzedi7/dZ
         sTv+n5piiJZCjDI8zCyIbYvY5EbsoLj/LqQqvnU/iknm+VA77PP2c7Kk/bl1qaDgYNBt
         XnIdkCWG2TWfsYxlQJ/jbF38AL3Nuob9aWhP1ShfXzt6fwPykB1mLDfuKVGjBZFogAVG
         gH3A==
X-Gm-Message-State: AOJu0YzfACgjnCxJtqk9/l9vMhMbzSNc8qOL58h88WYg9NPkoYd0ViZx
	r1TBxo8mCvhedmoXvU5/RuCemicZXHOlaj6ugVvFv0DZ2xe0nvVog5d0XK7t7A==
X-Google-Smtp-Source: AGHT+IF07BGSQ6ZwbyrkfHXdYIS3EMia9IGjb+ApY6oRLFSSgwB9lsZcIPhV1g72s6JGvRkJC83LrQ==
X-Received: by 2002:a05:6214:3b88:b0:6bf:8aca:2e8b with SMTP id 6a1803df08f44-6c33e63c2ccmr4592166d6.34.1724869989671;
        Wed, 28 Aug 2024 11:33:09 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:09 -0700 (PDT)
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
Subject: [PATCH net-next v4 7/9] bnxt_en: Replace deprecated PCI MSIX APIs
Date: Wed, 28 Aug 2024 11:32:33 -0700
Message-ID: <20240828183235.128948-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
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


