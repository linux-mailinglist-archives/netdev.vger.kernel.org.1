Return-Path: <netdev+bounces-121496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81A95D64F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9A32846E3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B965193418;
	Fri, 23 Aug 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ItaKFh1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE354193407
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443080; cv=none; b=pQNLQCWRNywuoLLoK2qhjYoqe2x5YofbJZeHJxysnbF0Ro0zXnJ4+865bGT1d0s89sQpWMi+9pJ6ab/hUgeJ7JKL2paXG13vaulS6Hl2RQuQGmJIcC9qdSDeUncpvA9i/HsrGwFH62mzfGlZpLbybjzQOOgt/HfTA9Uw70BbDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443080; c=relaxed/simple;
	bh=2QKsv57NUo4zAWVK7Bix5ZO6GStNOAXAteSt6+xb6MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLqY79fgM7mu4VpBkZV9wV59ESo92pc2+1djrIxIHnvBwWpks/OAlAUimSyZdcMsvEDz639sR6rlgEaZ8ButnoXiGrasICSPiknGp4C6vIXgMlm46Q/S2ppkP2MMvDLIG+/2toIJl6SniPDgKF/WZ+u/lVfSSuGA+yGCJV8v6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ItaKFh1K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71423273c62so1850573b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443078; x=1725047878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgfNrEJq6HRA04vzTkra13bJoUTfLD1DdGwFWycZ0Zk=;
        b=ItaKFh1KtKoGyEG+8hQO938pZrk8RtSsReD+7nC+05JJMwOfgUbPsxUEeS+yWSoz7O
         icJqcSBBPsOKlVhySbmKgSB2AUUXQbXqdMDUN9Ivhy0bLEdlnvSkdNBvL6ZtCfQzBkZG
         +SGupyUxS5jtDxf4ZJKSJA0pIytlWfxQoHpDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443078; x=1725047878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgfNrEJq6HRA04vzTkra13bJoUTfLD1DdGwFWycZ0Zk=;
        b=HqeEUrPZYfNvvL0q7OPNvyyWhCFjgyr8cCENJCB5ho2bUus/TnMZUMqcnY/Ttx6OL5
         uDzGJ7lj5xYXvB/zRcttWqV1lEwvDLGzfy12rHRRr8RQ+p2rYxw1TP2CR7Jt7gZFHUGb
         +/AyFbIooXmeqJtQ1hSgXZOMoc7fXV8+ZXvaJK/NRQ1Lx4NnFW+paMCwtXTWfowhYQ/p
         21oBOKGKwTOlCuW81MTU6FJXPjCRdBc4PyLDYjVUIODDDEYfyRbd8t0OUvyodUKNaZID
         +CvUiQIrOJRzGKKQWhByX2UEU8rPhnMHMFcGorBufmp1s7YYGZXp7rFTCnT02J7rg2Yw
         a4bg==
X-Gm-Message-State: AOJu0YwkoAefmH5mMK5FGzbGDiRRi2id0J9RC8sy2Pyw8tlPXXpjsUz1
	iZGB4e/HJxhbQ0EI9WBxif4hwz1btVYNPmoMl+BVMh0BBkmelcp+PH/d4XXCIA==
X-Google-Smtp-Source: AGHT+IGvke3JHhJbdlfY6rQEDFuphVtj5WHBRXAQ55YqgOB8RF9QbKn3jplceayMKNmjMnwaQNXP4Q==
X-Received: by 2002:a05:6a20:c896:b0:1c9:1605:2a3a with SMTP id adf61e73a8af0-1cc8b0e74a1mr4677254637.0.1724443078079;
        Fri, 23 Aug 2024 12:57:58 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:57 -0700 (PDT)
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
Subject: [PATCH net-next v3 8/9] bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
Date: Fri, 23 Aug 2024 12:56:56 -0700
Message-ID: <20240823195657.31588-9-michael.chan@broadcom.com>
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


