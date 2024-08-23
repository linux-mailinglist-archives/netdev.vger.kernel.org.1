Return-Path: <netdev+bounces-121497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDC695D650
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD691C21239
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37AF193427;
	Fri, 23 Aug 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gVQEhtbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8B193417
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443081; cv=none; b=VELOgdQsLPMNTiIMHv5rrcrtiYR3owFxYNb+d16xFHvpRZHUHwb6/68fTGA/irT1MlSNItTAuQQ1mfSueY8i4Zd6LUqVG5jMbQ5xYroBLMrOln49zk0UcWBhZUgca6Z4CE08FzQ6uNSQYyeQORI+8eSJw37YpbxrxjteVojy3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443081; c=relaxed/simple;
	bh=XDVWMEChUAV07AyjrtSlsUYEIscL77rGn9pTSzxYfEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdhAeTvQE45+5v6G35PtPzayVL9u4UB//9lCVOqPl3MK8gQnmMQVdRJjiKkL+xnsZ5o+/OPUcWNdbxqjsUYyeuqM9Iz+c2CRNwzTDzorrE3xKxD2BoZ/baXFoV2KVSR1DNUr8Zjm+8fFANIm+l3b8shYHijppEnJiGi3TEkP7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gVQEhtbb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd895682fcso985160a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443079; x=1725047879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duOFN3rsXulcVtkmQeA9EW5HMUC8/DLo1WtDwbYu5/A=;
        b=gVQEhtbbp9nZ4znInRm88Ao5UGdq9WniJM8DS3kKbkHbM0N4qrd4VmSAJ2fqvqOPfi
         GDiMZp/i99n10HwTT/FdYmsXL12jy6bNPph4zCO1oHAa6G3OYlugmEefIJ/zEJn3NC9d
         fzkJNaUrGgAwwFUyef83VIOYdwBTZrVLXVcCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443079; x=1725047879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duOFN3rsXulcVtkmQeA9EW5HMUC8/DLo1WtDwbYu5/A=;
        b=XPypUjsJZug4A9fkojAvKYI8nONjS0zfxV+f0Qe+q1J424m66IuK1fikysWZcVpHEl
         rZUEwSKW8OMP4rkU/POFM1rC6eVMh38MLlXRFQFQY7aVI3Eo9hGJ6naiM9nYM1SgNXAa
         X2Bj0+V9KiVyjnh9owJtCmWjthQ4MQO2QwkMZAcdByAtT4jJgWAnpC9uFXjsRmmUaSSt
         XKkn+MufmKH9jCqr96p6m6wMiVCw/8uVH+HitfBnoiQ3OXr9P1Id2nFNZKlnJdHPX24B
         RUYj/nWtqweeRDnE3S7iUOHcZ6xt1O1MMV6KIiftHADlqgBkVEz5LJ6GJm9hs8H1qons
         5qFQ==
X-Gm-Message-State: AOJu0YyZC2SK31HGZ9RXtTk666ox+fviQT8TH2oHy5rnyr8LVbspFjzN
	XZWVXDCutmf2BDzmfyPEiVig9eMAsFZZkg6dwuM0Sn8FztduaqFgk3Tc9YgzGQ==
X-Google-Smtp-Source: AGHT+IFEkTA71uEpSBaSwI14V89O0wbgYhog96C115TAPMhfBxmlgPaCwc9d50YmrBraXNO6Y1KfAA==
X-Received: by 2002:a05:6a21:1584:b0:1ca:cbf5:5b0 with SMTP id adf61e73a8af0-1cc8b459221mr3650736637.21.1724443079359;
        Fri, 23 Aug 2024 12:57:59 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:59 -0700 (PDT)
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
Subject: [PATCH net-next v3 9/9] bnxt_en: Support dynamic MSIX
Date: Fri, 23 Aug 2024 12:56:57 -0700
Message-ID: <20240823195657.31588-10-michael.chan@broadcom.com>
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
v2: Fix typo in changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 +++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fa4115f6dafe..39dc67dbe9b2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10622,6 +10622,43 @@ static void bnxt_setup_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp);
 
+static int bnxt_add_msix(struct bnxt *bp, int total)
+{
+	int i;
+
+	if (bp->total_irqs >= total)
+		return total;
+
+	for (i = bp->total_irqs; i < total; i++) {
+		struct msi_map map;
+
+		map = pci_msix_alloc_irq_at(bp->pdev, i, NULL);
+		if (map.index < 0)
+			break;
+		bp->irq_tbl[i].vector = map.virq;
+		bp->total_irqs++;
+	}
+	return bp->total_irqs;
+}
+
+static int bnxt_trim_msix(struct bnxt *bp, int total)
+{
+	int i;
+
+	if (bp->total_irqs <= total)
+		return total;
+
+	for (i = bp->total_irqs; i > total; i--) {
+		struct msi_map map;
+
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
@@ -10788,6 +10825,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
+	bool irq_change = false;
 	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
@@ -10806,15 +10844,28 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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
+		int total;
+
+		if (irqs_required > bp->total_irqs)
+			total = bnxt_add_msix(bp, irqs_required);
+		else
+			total = bnxt_trim_msix(bp, irqs_required);
+
+		if (total != irqs_required)
+			rc = -ENOSPC;
 	}
 	if (rc) {
 		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
-- 
2.30.1


