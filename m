Return-Path: <netdev+bounces-119326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA63A955262
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFB11C22134
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C321C57B2;
	Fri, 16 Aug 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y+tNqgoG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B11C7B89
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843765; cv=none; b=EKSrDsbZRgRKJHbiYFcl2QvUr3L3NHhzBhC4bwRmo4SLxCyUAdBno8QmZgN0jHHbocZQxtW9E9x7cKIaJwuNclqJnV3PkNoaZvfiZkrKdFLpOEYJjpr0TSSlj4xRL9GPo4Cj4bvu9gX181sGf3Nd+KDDI+mSUBpvFCzT5bWLMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843765; c=relaxed/simple;
	bh=ugfagNAGfpNF1G/OPRly4OeWcOsgg0mnSoDCqpLhQZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plK5df71mi7OuKiOXwArv1Ip/yY5W2kYZORc/O9EydHTaAFjB28rv+PN4TAj0+6Bdsa4yppd1w7FlEoCpZrtoZ6RWCKajcxZZgHCStYuxExw4UQTBEdXAeH5jnLnDnvSXwB+kKjMpjGS3s5ND3LUdLKbys9zHLrBshwbCIgOIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y+tNqgoG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db19caec60so1565202b6e.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843763; x=1724448563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4wzEYtouvzxVOFaYuVyAO9v0SPQDvtZHLZuX95GPPY=;
        b=Y+tNqgoGlsvevztoo1BHJ8/MEOOmTwQB4NKMuf5qQXgFjsoLqv742U1BG9KCIUxAvh
         fB+MNwtFvVa+gNobVAKzADsBW1uGnX86SmsYQdmuHiI++UuV7A9nNBVpCQmfbTfH1Ycr
         JMCia60ONjmk3b4P8lw/axWw9ayyxVrqJL9N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843763; x=1724448563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4wzEYtouvzxVOFaYuVyAO9v0SPQDvtZHLZuX95GPPY=;
        b=GqsEaUfuvoUhRq2eY2JeGTForbVn9Y1YRvLnyAPzF9bKNB3lAvkAPNCaWDg0muPyAY
         Mh3vQdSShyS1R5TWABCy2VZiIMS+CtJ7FJgeeS7+XUOk4W55ycfq6Fn2f9Glix2bgEtM
         2AQ62Br7qrHolZdhbMnPDQgV9FE8qNgMrL0HMQMoB1dO4AHLJHEx2/14ZSW+psWUgHDx
         HogfMga0pdSt7FJQfm59SN/pE+ky/ELZtEZYTBtZj8lT0a8SPwT3ouWEnjLgK0Dxb4/7
         6ZY8zQWgYpctsGieZucDcXr6kTD3USePsvRDgH2EnHTxWTTYuLGQqjROsH1Ed7WIR7Ht
         JDVA==
X-Gm-Message-State: AOJu0YxPM1imrgLsizs5A0lH8nyylxWg9G6M35pUB53KWvFa48C3RDaK
	ywa/g4uohBcFUhz5Xr0iqKbBwkiBxv6cbNp94orX6zXZDUXeMuVKWtof4tS79g==
X-Google-Smtp-Source: AGHT+IGaYuz1JDUOUaAAKoamxNcM5LuSyyNGRajAugWNOiAvLeygMqEbN3lJ9t2Kb3MjjK33KL/wKQ==
X-Received: by 2002:a05:6808:170c:b0:3d9:28d0:fcdb with SMTP id 5614622812f47-3dd3ad330a2mr5378104b6e.12.1723843762899;
        Fri, 16 Aug 2024 14:29:22 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:22 -0700 (PDT)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 9/9] bnxt_en: Support dynamic MSIX
Date: Fri, 16 Aug 2024 14:28:32 -0700
Message-ID: <20240816212832.185379-10-michael.chan@broadcom.com>
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
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix typo in changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 57 +++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b969ace6b4d1..d702fc1d9ed5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10624,6 +10624,43 @@ static void bnxt_setup_msix(struct bnxt *bp)
 
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
@@ -10790,6 +10827,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
+	bool irq_change = false;
 	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
@@ -10808,15 +10846,28 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
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


