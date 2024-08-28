Return-Path: <netdev+bounces-122895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47F963016
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BCC1F24C41
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002A149C54;
	Wed, 28 Aug 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fvir5UG5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC01ABEA1
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869996; cv=none; b=AwJxLRG1zKNoubJNJ1A2UD+DAOlgV6Rx4zYfNNdEjdH2EXKG02jNcSHyKuPPnd4BQM1sffIM4xmvdgILbYITrtdFH6cr5O35ALdeuvhmLhUwLti8sLwiGkbKeqWKg0OueS/eJKyNZPQKMuGCA2fDeEHHIOjh9gXb3t8zbCRsksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869996; c=relaxed/simple;
	bh=QWNhIto9JgVL369Y1Wt0dDajfaICwm86M5cWUU0kDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1Cwri6Mlje6DRWGX+DMc3dJkJYCC894XNlxCCz9n7+yN0egW/ONQgw2eqQBYY6/BfximDOLMdC+3GhZ3iBI9d6+TjHXcx8hmz0rmlDGYHKhmF2N6xhHQzuK3kn1mNMg9HY8lxkT7CjBwXwqIb5SdC/TwrhJManEpOFOy/xyCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fvir5UG5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so7835156d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869994; x=1725474794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/LNyb18fnHH/VvP2ImCzZnRX+7EwZmHcxiAzCjxOKI=;
        b=fvir5UG5OgH+Sfb4EZyPsRRMbabhv/59kqz+fWC9yOJm99luorYHDZ5anmAxlubdyn
         gy/EUPoyl14RMlw2bi/3vHgDEY5bsBBW2Svml/ZA3hBbaTjmt4Nembl/H2U2KZpMr3DS
         nJc8jXYZLR0KcmIe9Yp7czAea3xxYA4xFMFmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869994; x=1725474794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/LNyb18fnHH/VvP2ImCzZnRX+7EwZmHcxiAzCjxOKI=;
        b=YhXmFDNZrLqNHdix5mQ0b+fCZmDPXjiiQlH10uF+VosEN7NR0LsfkvT12GnAWqW0dP
         c7F5lzgJdHDd8J2CchOt5n7eD2AjhL8anO4BGlgeAvzSpoJiPzvsAlIs6eGGIyOhbtYJ
         dsAAFv+jJvcrTiM+KKM39hSt2LQn41c1WhTF/mnkc9rtVl+bPMGBVlUaM0bBMlDFaDrs
         vJ1HIPvHPxgI1VM+o/KRaqtbXbXFOraX+mH8L8eIRZtvrHSEPN+8PUrTL6iRTp1BJ+WB
         bJHq3+ZSevhccB+tNg133RNiXoOHyl4e5NK1sjFXSR90UjEsOIXfF6nxPWHtY6m0EH3n
         qTBA==
X-Gm-Message-State: AOJu0Yxl2JvZIYnPqvQ1DeIWIJ5D1QjGTbeasK6N02dvtTQ4j124vUv/
	7D1dE/4rCuIvnp5tEm+E8e1hNnvrOxR/wMk8EeyBpKvYOBO2rwM7lqJt297rc5/03C7ixF591I0
	=
X-Google-Smtp-Source: AGHT+IHjl6oBDHqNbC+yV0z2vArViHpd3mtU4ql08msW/F7e9vNaAs1vavCSJNIkEeC1OgGXQ67rVw==
X-Received: by 2002:a05:6214:4019:b0:6b5:1cea:649d with SMTP id 6a1803df08f44-6c33f33df4cmr1105996d6.11.1724869993704;
        Wed, 28 Aug 2024 11:33:13 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:13 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v4 9/9] bnxt_en: Support dynamic MSIX
Date: Wed, 28 Aug 2024 11:32:35 -0700
Message-ID: <20240828183235.128948-10-michael.chan@broadcom.com>
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

A range of MSIX vectors are allocated at initialization for the number
needed for RocE and L2.  During run-time, if the user increases or
decreases the number of L2 rings, all the MSIX vectors have to be
freed and a new range has to be allocated.  This is not optimal and
causes disruptions to RoCE traffic every time there is a change in L2
MSIX.

If the system supports dynamic MSIX allocations, use dynamic
allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
vectors.  RoCE traffic is not affected using this scheme.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
v4: Simplify adding and deleting MSIX
v2: Fix typo in changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 37 +++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fa4115f6dafe..c9248ed9330c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10622,6 +10622,30 @@ static void bnxt_setup_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp);
 
+static int bnxt_change_msix(struct bnxt *bp, int total)
+{
+	struct msi_map map;
+	int i;
+
+	/* add MSIX to the end if needed */
+	for (i = bp->total_irqs; i < total; i++) {
+		map = pci_msix_alloc_irq_at(bp->pdev, i, NULL);
+		if (map.index < 0)
+			return bp->total_irqs;
+		bp->irq_tbl[i].vector = map.virq;
+		bp->total_irqs++;
+	}
+
+	/* trim MSIX from the end if needed */
+	for (i = bp->total_irqs; i > total; i--) {
+		map.index = i - 1;
+		map.virq = bp->irq_tbl[i - 1].vector;
+		pci_msix_free_irq(bp->pdev, map);
+		bp->total_irqs--;
+	}
+	return bp->total_irqs;
+}
+
 static int bnxt_setup_int_mode(struct bnxt *bp)
 {
 	int rc;
@@ -10788,6 +10812,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
+	bool irq_change = false;
 	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
@@ -10806,15 +10831,21 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	}
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
-		bnxt_ulp_irq_stop(bp);
-		bnxt_clear_int_mode(bp);
-		irq_cleared = true;
+		irq_change = true;
+		if (!pci_msix_can_alloc_dyn(bp->pdev)) {
+			bnxt_ulp_irq_stop(bp);
+			bnxt_clear_int_mode(bp);
+			irq_cleared = true;
+		}
 	}
 	rc = __bnxt_reserve_rings(bp);
 	if (irq_cleared) {
 		if (!rc)
 			rc = bnxt_init_int_mode(bp);
 		bnxt_ulp_irq_restart(bp, rc);
+	} else if (irq_change && !rc) {
+		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
+			rc = -ENOSPC;
 	}
 	if (rc) {
 		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
-- 
2.30.1


