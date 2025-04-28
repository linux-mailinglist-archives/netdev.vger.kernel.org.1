Return-Path: <netdev+bounces-186591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3CA9FD5B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB74A480014
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47731214818;
	Mon, 28 Apr 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UqVXZ7S7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF242135C5
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881189; cv=none; b=u7mjmTMObh4BZALgFWDRbv8SrvccpBOCrDO0nCpHlSwWjc7riVZ4jGBruGkIIWhKIz3FgcVJsxoLQmXRq5oa4tF78PXrvbZEMRc6I2VPk4c9LY6o2C3XKpGF6Dc16kFx9IhqDap+XY8C0v2cESv4VRVn7H178Wq/NlyTLQkznSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881189; c=relaxed/simple;
	bh=MT4U4ynG9XcYSDFNulFhxiOMFjQhGWr7V2eA78VUk50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD6/TCBxgibdISBTty4x1OwXMnAjJibR1IGL5vwYD5GK/be5UpceHvPDSQtiRTH1KopZ9jk9PcYbBoxaOq7x19+YUDf2uNMxnlZGacKuvZyZhG+QKOz3ah6MvaqV3JBbNktDF7UdWes33fLMONUyZTj6i++YKBcs9DWYWqlOswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UqVXZ7S7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so5370232b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881185; x=1746485985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0zdmeTvYYzFj6Hemd+RggKckMkx+0hYnhirdSmllag=;
        b=UqVXZ7S7CWgHOz0PE+5Dv2zw8T6g6pDRuKU+vzfF37f2YU6ufY8TSO2EjIJhnnZsO/
         Gv8Bk8ppwd/YajDX0ZnxXzS2q3IUwKB4NcL/v+llJS+gULFxWq3JDZHyHXSSzxd6iGZU
         n6PzNUup78flS3/uPxBEH53A7eLsDOEeIOlg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881185; x=1746485985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0zdmeTvYYzFj6Hemd+RggKckMkx+0hYnhirdSmllag=;
        b=QOHuu4iBdbdFreAALCnuZKSqru/V7L8/n11U1eSVxQBAT0SuFqXX6LkdNnnoNE/F5k
         0f4EsiXTEDi85ZTJbyQWBS250VkY31Qivbs1h/A4lEsoN52GZ4BjLmAR5Ug2ezJ6JfKf
         fUpyA/IZNL1wqsVhHAAf/iTFtdJUgu6ECMsYfvGJKWgrLlUYxQTTiPCDGEk6gjQt70Fc
         ekycNeMP41pS6xtnN3ERp6ujHpNKowihGVWKs4BfRd+bY1qPNJEoXFLZ+fq1cJbqSp8d
         lX+3OKCt/htKu9VSQASc+ltoQTBqFIsl1mpmLcUBYay3PKoG8iLepIfRObVsk6AXgOAo
         dkJQ==
X-Gm-Message-State: AOJu0YyG39oLhdOw5B+PAG1iCR5ziqIy3xvhAYoH+1fYAXWhOLrQEZNx
	q/59/5byXCYksI319vJcvYQnqqwTIK4Wla+oh32Ty7QPJotcaSQ4v4vsZJyuzg==
X-Gm-Gg: ASbGncvqlsiMYN0FRfDd1Zc8rxQhuixe2nWXprJVgkUZbPDqUy7BUb/A0o++lBV1Tof
	bfqrN3eIEgkQfPZnzFtCd9iD8UU/IaH8DeHGIFgeaDc2HKYhGhLGwSuqj5MqrX2XoZzgZd2f6hz
	1/3+xKOVZjPxFCbiT6lIfSFj7497YI2A3rLBo6eixCzPiD7WW1zafDuYLruDX4cGO8jRyaff+8j
	yRf12H4jcbIXIZ8M/xPXHxDwWNmsd9KJE4CQu+WNV15MjdZfCs/IpT4SKjMc1LQu2qoeYUSMVW8
	AJBe3hAne3hzAIuzNVzH2lWpjIkf6Ewll/o7HlWNwLxzKUCR9Pu2DrdHJp5fEa75m8E8mkIiNax
	EoCxxRygriXzkwuzE
X-Google-Smtp-Source: AGHT+IHOoPFrp+FsWcHOenmKUz7BZjj/eACP48hqkwUK8tGP0bxmvx2LcItWJjIdIjQdj6fT/VtoYA==
X-Received: by 2002:a05:6a00:3995:b0:736:a973:748 with SMTP id d2e1a72fcca58-73ff73eeeb1mr13855873b3a.22.1745881184882;
        Mon, 28 Apr 2025 15:59:44 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH net 5/8] bnxt_en: delay pci_alloc_irq_vectors() in the AER path
Date: Mon, 28 Apr 2025 15:59:00 -0700
Message-ID: <20250428225903.1867675-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

This patch is similar to the last patch to delay the
pci_alloc_irq_vectors() call in the AER path until after calling
bnxt_reserve_rings().  bnxt_reserve_rings() needs to properly map
the MSIX table first before we call pci_alloc_irq_vectors() which
may immediately write to the MSIX table in some architectures.

Move the bnxt_init_int_mode() call from bnxt_io_slot_reset() to
bnxt_io_resume() after calling bnxt_reserve_rings().

With this change, the AER path may call bnxt_open() ->
bnxt_hwrm_if_change() with bp->irq_tbl set to NULL.  bp->irq_tbl is
cleared when we call bnxt_clear_int_mode() in bnxt_io_slot_reset().
So we cannot use !bp->irq_tbl to detect aborted FW reset.  Add a
new BNXT_FW_RESET_STATE_ABORT to detect aborted FW reset in
bnxt_hwrm_if_change().

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3b2ea36f25a2..78e496b0ec26 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12325,12 +12325,15 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 {
 	struct hwrm_func_drv_if_change_output *resp;
 	struct hwrm_func_drv_if_change_input *req;
-	bool fw_reset = !bp->irq_tbl;
 	bool resc_reinit = false;
 	bool caps_change = false;
 	int rc, retry = 0;
+	bool fw_reset;
 	u32 flags = 0;
 
+	fw_reset = (bp->fw_reset_state == BNXT_FW_RESET_STATE_ABORT);
+	bp->fw_reset_state = 0;
+
 	if (!(bp->fw_cap & BNXT_FW_CAP_IF_CHANGE))
 		return 0;
 
@@ -14833,7 +14836,7 @@ static void bnxt_fw_reset_abort(struct bnxt *bp, int rc)
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF)
 		bnxt_dl_health_fw_status_update(bp, false);
-	bp->fw_reset_state = 0;
+	bp->fw_reset_state = BNXT_FW_RESET_STATE_ABORT;
 	netif_close(bp->dev);
 }
 
@@ -16931,10 +16934,9 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 		if (!err)
 			result = PCI_ERS_RESULT_RECOVERED;
 
+		/* IRQ will be initialized later in bnxt_io_resume */
 		bnxt_ulp_irq_stop(bp);
 		bnxt_clear_int_mode(bp);
-		err = bnxt_init_int_mode(bp);
-		bnxt_ulp_irq_restart(bp, err);
 	}
 
 reset_exit:
@@ -16963,10 +16965,13 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 
 	err = bnxt_hwrm_func_qcaps(bp);
 	if (!err) {
-		if (netif_running(netdev))
+		if (netif_running(netdev)) {
 			err = bnxt_open(netdev);
-		else
+		} else {
 			err = bnxt_reserve_rings(bp, true);
+			if (!err)
+				err = bnxt_init_int_mode(bp);
+		}
 	}
 
 	if (!err)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21726cf56586..bc8b3b7e915d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2614,6 +2614,7 @@ struct bnxt {
 #define BNXT_FW_RESET_STATE_POLL_FW	4
 #define BNXT_FW_RESET_STATE_OPENING	5
 #define BNXT_FW_RESET_STATE_POLL_FW_DOWN	6
+#define BNXT_FW_RESET_STATE_ABORT	7
 
 	u16			fw_reset_min_dsecs;
 #define BNXT_DFLT_FW_RST_MIN_DSECS	20
-- 
2.30.1


