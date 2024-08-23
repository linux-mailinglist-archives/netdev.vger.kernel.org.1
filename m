Return-Path: <netdev+bounces-121494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D88795D64D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C37AB21EB8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7B19309A;
	Fri, 23 Aug 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZgXu1FEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C19193089
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443077; cv=none; b=JhcV98TNN1FWM/w3aXmqaHhcyaaFjHtybs96nrX6//FtonhijuDlw8laBm7mFimMSJgtiOSILzNYGKxahyqBT58epNwxNQ+pnkeCv+pOoxHqm5GuXgXJUypowjkQP+d/5WVPnseP9gJYQJDAAlScF439++OHtogO49Bjo3ywJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443077; c=relaxed/simple;
	bh=uVfYXnO7KEr4MbCNM2tPLz1fBzFWKDDMSgAG33nKbo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZlI0KV5T6KnefrnIx6tVRDIjjDhejKKykx63MU1ZC90OFV+ALvoiQwN957KSACTltX3G26JaNO9r3tpRNmYU9MsdawH3tRIHyjmQ5uPg0Bjl/yLq2RdJa5la7fj78fo/cCvcTEdHYn6Z5DIR2gXPStnQKhoGZ1jXyVF8STf0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZgXu1FEO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-714262f1bb4so1951620b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443075; x=1725047875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSRkRd1bUOamWqoWx9cZCQwg3atj77uWWzgwowWKD7U=;
        b=ZgXu1FEO4yvB74x5jgsiD91eB2HPkk5XYUXpQcQk3V0D2KJW1LAlU70N5BmAi+X9H3
         w9PhUCdrT3IR0j3MfjVp+QzAK9jTi2IPD09sRBXZ3nKGXn4N7nzF7IgHfDoJu4OdBsTW
         VYHP19yvJXR8QtRpPZwTXm6nakrmT9D++q+KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443075; x=1725047875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSRkRd1bUOamWqoWx9cZCQwg3atj77uWWzgwowWKD7U=;
        b=dWvox2XCToun4SplOI/w7cJQOgewTszL5MZwghyeCfST2NVTfFYG1/1D9Cj2/sUYB6
         RqoQhzL5gMJO3j6mP6gwHrP0PSJjWagN+JduyJ34/pEQnthU2X56DL7F96ZHU5VYN/+R
         QptvJEExzInblr/g+3Tt7V/XH9Jy06N6Tl5T6u1YFwlxxgXFR3k/bJzMe/HcJq7GZehU
         TFUkX/20fAC6QBD+o26ArliHtC1dnIgHcX6eHojYj6gbG0aeT6ZFuJgYzxyQZj+HcB44
         DjaNNTG3ez0o12CYXH0VoZ8LKnuSieBcB4vImKPE40jJbzUacHzhKO+jWRzz+JNqTcla
         pGuA==
X-Gm-Message-State: AOJu0YxVaPFr4usxiKRAtVkvDN6Zu1kQh4w9/1cJgRwRP1oOyhBAnV0G
	SPfahar5J6qdaETJly3z2c+wIK7ADnT1FCFvat/B91Itk3tB8+oLUhSTcKJA6A==
X-Google-Smtp-Source: AGHT+IGR1SpTAHGJNjeOJtj0a81kfpODiLz02ywZ/ZlkLVs/EdKZZeKsu692xK4yhaIEI6MJqQBC6A==
X-Received: by 2002:a05:6a00:cc9:b0:714:1f68:7efa with SMTP id d2e1a72fcca58-71445d51e12mr4152215b3a.12.1724443074737;
        Fri, 23 Aug 2024 12:57:54 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:53 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v3 6/9] bnxt_en: Remove register mapping to support INTX
Date: Fri, 23 Aug 2024 12:56:54 -0700
Message-ID: <20240823195657.31588-7-michael.chan@broadcom.com>
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

In legacy INTX mode, a register is mapped so that the INTX handler can
read it to determine if the NIC is the source of the interrupt.  This
and all the related macros are no longer needed now that INTX is no
longer supported.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Update changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 -------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 67f09e22a25c..2ecf9e324f2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -302,10 +302,6 @@ static bool bnxt_vf_pciid(enum board_idx idx)
 
 #define DB_CP_REARM_FLAGS	(DB_KEY_CP | DB_IDX_VALID)
 #define DB_CP_FLAGS		(DB_KEY_CP | DB_IDX_VALID | DB_IRQ_DIS)
-#define DB_CP_IRQ_DIS_FLAGS	(DB_KEY_CP | DB_IRQ_DIS)
-
-#define BNXT_CP_DB_IRQ_DIS(db)						\
-		writel(DB_CP_IRQ_DIS_FLAGS, db)
 
 #define BNXT_DB_CQ(db, idx)						\
 	writel(DB_CP_FLAGS | DB_RING_IDX(db, idx), (db)->doorbell)
@@ -11959,20 +11955,6 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
 	return rc;
 }
 
-/* Common routine to pre-map certain register block to different GRC window.
- * A PF has 16 4K windows and a VF has 4 4K windows. However, only 15 windows
- * in PF and 3 windows in VF that can be customized to map in different
- * register blocks.
- */
-static void bnxt_preset_reg_win(struct bnxt *bp)
-{
-	if (BNXT_PF(bp)) {
-		/* CAG registers map to GRC window #4 */
-		writel(BNXT_CAG_REG_BASE,
-		       bp->bar0 + BNXT_GRCPF_REG_WINDOW_BASE_OUT + 12);
-	}
-}
-
 static int bnxt_init_dflt_ring_mode(struct bnxt *bp);
 
 static int bnxt_reinit_after_abort(struct bnxt *bp)
@@ -12077,7 +12059,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
 
-	bnxt_preset_reg_win(bp);
 	netif_carrier_off(bp->dev);
 	if (irq_re_init) {
 		/* Reserve rings now if none were reserved at driver probe. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b1903a1617f1..3b805ed433ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1755,8 +1755,6 @@ struct bnxt_test_info {
 #define BNXT_GRCPF_REG_CHIMP_COMM		0x0
 #define BNXT_GRCPF_REG_CHIMP_COMM_TRIGGER	0x100
 #define BNXT_GRCPF_REG_WINDOW_BASE_OUT		0x400
-#define BNXT_CAG_REG_LEGACY_INT_STATUS		0x4014
-#define BNXT_CAG_REG_BASE			0x300000
 
 #define BNXT_GRC_REG_STATUS_P5			0x520
 
-- 
2.30.1


