Return-Path: <netdev+bounces-119323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D7A95525F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9123F284F92
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513D1C7B74;
	Fri, 16 Aug 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cb07auRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BA1C579D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843759; cv=none; b=RexfYVoQheVuDv9JG0sVCcAf74XIWDgo9sNmZg18+5uS6W65zKJHDCZLx7QNluXIg7UQfDVHQQU8NPWMEoLwhYqYQ10bAC7rw0zvpJ1l6PpUE/8S4XcB0h4TcvK/rAVdMAj3nZN/cseJegSa3RugyvrHTCOcn2o4Qt9EXbYFzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843759; c=relaxed/simple;
	bh=j2HHGXx8bK0TLDRdB0zXS7YCJQG7jxrT8hGHyc9lkPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq72zfiVArWZmv+fbqwdZT/sp5M6bb1VHOxHoR/qC5D1+XyyBdEnISIOXXSzizfdkifrnW4iTMBUFvWj8ROOP/bHAWqZz8EwFRKPEDHxckQbBSEjzWIZbSHGMaAXbHroXkqxCSqeA6ub17ensb3UcDCRQgS8PG3PtHkCaM8doug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cb07auRt; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70936061d0dso1712788a34.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843757; x=1724448557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sj5uy6qcsV6EfwMJkgO154ju0jKDy7oK4R0LZFICE0=;
        b=Cb07auRtPysKd7km4uHutGmpS4AkI0fKRsXpTjdYxECrWHo5mwexRflozQEjQvoFQC
         vhRKFLG8v81fiPlzrSJ9vJTPmyYDygYjvkhk2Fs5asd0DNH4yU/dnowBsSt8tW73V80o
         aASODzaI7nuFsbqTQzIDkeN0cGOc6ozXjXZyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843757; x=1724448557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sj5uy6qcsV6EfwMJkgO154ju0jKDy7oK4R0LZFICE0=;
        b=nSef6wPHydINuDvzsKpLzTwi4h7gFX3hq872zbtdcH4I5hFtyFNhsXEqCwdp/7ENtr
         a3JDcGq35gIbXKrvtub0O8dMpuh8BubypGjEMaff0+gyft8QEhBvC7gw12GnB/JMDCxw
         8c/eCZn4mBznixwMammdfvI0u9QhwTd/RYTwH38gela+f93UkpeI59iFQNPPOZ6ynoAC
         NHIFihS/Lt0EP0aE503PHbhrDU2doN27ZLGeIpYocHjt2Uiz4Su6iZVSnvFrp/dke+N7
         WFen/K/PIXzKs5Z4O4RdpYgaKGquaKDcogMlvRnTspaf80Jxms4UiSsWjxPHX5jBMpHt
         3viQ==
X-Gm-Message-State: AOJu0YwfHwAkagGUNVb4Tru0gy973Ovixv3MKh4WvJ/B7eLllyeJWIgG
	odTIGjYbz9Iv0Beuv5K0MIsT3a6fHv7xmeZ2nJ8QTp//iGuWzMBO+gS9fRTukA==
X-Google-Smtp-Source: AGHT+IEMzfw76iTpeQERoCTMBrjlqNnJp1lHFqp0P1cDTxk7F/oyld9+8SJKxP1nQnYN3+eYg1CLcA==
X-Received: by 2002:a05:6830:3708:b0:703:6341:5171 with SMTP id 46e09a7af769-70cac8567a2mr5018866a34.15.1723843757150;
        Fri, 16 Aug 2024 14:29:17 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:16 -0700 (PDT)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v2 6/9] bnxt_en: Remove register mapping to support INTX
Date: Fri, 16 Aug 2024 14:28:29 -0700
Message-ID: <20240816212832.185379-7-michael.chan@broadcom.com>
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
index 8d3970ccdc21..0666bf0e5dc6 100644
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
@@ -11961,20 +11957,6 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
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
@@ -12079,7 +12061,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
 
-	bnxt_preset_reg_win(bp);
 	netif_carrier_off(bp->dev);
 	if (irq_re_init) {
 		/* Reserve rings now if none were reserved at driver probe. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 043d2a849674..93e00215819a 100644
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


