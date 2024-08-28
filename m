Return-Path: <netdev+bounces-122894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96E963015
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52701F22E0E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED11AAE25;
	Wed, 28 Aug 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CaRc5BJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF821AB536
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869994; cv=none; b=mrepZj8s7K1i5t15ZOZNjRPNRL6yjG5F/LzRdEF73Djyx4rXN4Rz3xZaWi5nlNELP9UBVNNjZcBcJlG1Doj88IQchO61sRN+GRfSuSOTHvcZSOEviHhs2C6CmoidiYf5AMxrOiP3J+JUWD73Hj+38gHw25Ryam5LaxpHM6tnmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869994; c=relaxed/simple;
	bh=2QKsv57NUo4zAWVK7Bix5ZO6GStNOAXAteSt6+xb6MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljf/sFhReq1gtyVVt/Oj90SxE6UKGnLdWMIZolCmHK472O1/K0rdo/v9HF8wPjFx8xHl/mq8GHuG8bzgbnJrhq1mKUY/3X0pphiMksFI9z3vheGdloGkiENt9jGaRvaUSnglsQrLgxwB7c9sYT8lIgOM5Bh/MbY1VLaXkfKDJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CaRc5BJt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e13c2ef0f6fso7215793276.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869992; x=1725474792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgfNrEJq6HRA04vzTkra13bJoUTfLD1DdGwFWycZ0Zk=;
        b=CaRc5BJtYINi07hn0+7QO9jxhJoEjkV7eNuZf/J1qf22pEo50AlcXgacJCUsSFNLlH
         /UkcisVC97hwCBlDIVvGlALZp2uZYj/cRJVC4Rba9RVx/bWsvrl+bvajo3aNNm5ZKwqL
         wqSlGrBv75j6TjCjwhgBDwqkH5hZexCD8zf80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869992; x=1725474792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgfNrEJq6HRA04vzTkra13bJoUTfLD1DdGwFWycZ0Zk=;
        b=KgBE40HI6M0X781RiLVfNyh3Jtda0JNYMHbpjE8yUBU7j68WrZ8Gqa2h/KMINPeV7X
         EVFZ5froF5jrJMbYTuyGLJB+Jbq3hRVzM9YBP3zMRbCWq11VpK7qTqoVDBLoYujC3MEF
         Uh4BwtfyirbtxjLIakp3Qg51fs5cnyv7yTcJeFwzFukZDLJ6BMxLM05cPhzERzvEOl7B
         VDkRcb3XzE7an1Owu5OA13RAGbErQpLpeRnZ8YUj/VOt5uHdGOk00E1m3hM25HR+7ya7
         qeUSLm7FicMa1s7j7zoqNjkr6Rvyn5+9FH4wbWYTtRxXIz9vxw87ct2tx9BO5ZyMy1my
         pY3A==
X-Gm-Message-State: AOJu0YzR50zPK13Bdi/1k6iyk4dwafSlOa82VyLSeQ3TmJT7QC8FVpkd
	cuAae5jJZbPSZ6WwY6B7egGKKo7H952weIjHk6L85Fl+wMQ5dVGwW4jzJL7X1A==
X-Google-Smtp-Source: AGHT+IFNMTlSxyN6+GPGRiIXTqVEfD3btUaFmkcAbE//9Ek8Qn+QFnQCo8yRhOHY333UmT5FvCJhwQ==
X-Received: by 2002:a05:6902:2204:b0:e11:7b16:9482 with SMTP id 3f1490d57ef6-e1a5ab5681dmr311113276.2.1724869991782;
        Wed, 28 Aug 2024 11:33:11 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:11 -0700 (PDT)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v4 8/9] bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
Date: Wed, 28 Aug 2024 11:32:34 -0700
Message-ID: <20240828183235.128948-9-michael.chan@broadcom.com>
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

If dynamic MSIX allocation is supported, additional MSIX can be
allocated at run-time without reinitializing the existing MSIX entries.
The first step to support this dynamic scheme is to allocate a large
enough bp->irq_tbl if dynamic allocation is supported.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3: Use sizeof(*bp->irq_tbl)
v2: Fix typo in changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 03598f8e0e07..fa4115f6dafe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10722,7 +10722,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
+	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp, tbl_size;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -10743,7 +10743,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		goto msix_setup_exit;
 	}
 
-	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
+	tbl_size = total_vecs;
+	if (pci_msix_can_alloc_dyn(bp->pdev))
+		tbl_size = max;
+	bp->irq_tbl = kcalloc(tbl_size, sizeof(*bp->irq_tbl), GFP_KERNEL);
 	if (bp->irq_tbl) {
 		for (i = 0; i < total_vecs; i++)
 			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
-- 
2.30.1


