Return-Path: <netdev+bounces-165750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E10A33470
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CE016630F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81F13B284;
	Thu, 13 Feb 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gqYGk9Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BF12D758
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409210; cv=none; b=oDEAqO7UkLCr8yp8oXwBz2ZGTK+EbYqCbN3f7IY9T21fFOT+KEA4JXxzq4OTzzXPpbIugGWOYUZ2sKh4ADBmPLJpU0Z7GgUvP+/u+2Gt1TrvzMEL/Oe/y4h2Pc5htIDY51g0NyQj66c6clR0Y8ZF0PnXy4E4ooCqFe+YTn3OcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409210; c=relaxed/simple;
	bh=798C9bVl/2f9vmMwMenfvnnbRYCzOvXYML/rPtxBmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElXYbNMc7/51LR5Qhc1dLnRrOSugEqDYXLeH5eeSQ9Jxc2YXxoSZY0DgZL55gj4AjmOwOzQpdM5n4gMaS+KjDry24ksvG5Bjg9U4TL9K0f5EbbJ6aL9CTNMYC+gmiOSIhE2rnWEpuj4XHOihZE2SgFefYDDlHKNLHDvKIOS7rAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gqYGk9Ix; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-726f989dc12so214201a34.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409208; x=1740014008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=gqYGk9IxAX1NyUMTWy211MJh2bpXU9y0OEk+Fn7Jab1IeQ2tBb5xgUSdbkXA+Xy3Y3
         XFWLp0SSf3+rqs5rFBb0qiNZRNAUkLdx3JIfpSoNecoNHRHaNDH9FQ0AgS4xR9o34BuE
         SnCPvACk5fGU/XjqYjr1lTFJ071a2xVIOwEaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409208; x=1740014008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=P7M29aD0kq/vJpklNCCBEfrH1IXBIUY11b5H9XQnju+7EJBNDseRP1DyYUPjzkszQY
         QDiVFL9fK7O48DqENoL7Yec0tuGoazChrgDyPRv0AnAui1YOFjPA06uvvxRWkdb9+bj8
         iiNrErf6f09QCtPTGVeoz7jyuPqGPQ2ukzGxo2kT5IpX0NGj5SoTH0tigUpocLt0djx6
         1I5TFGJTaevMBLlp8cokavGwYyx6kUP1aHl6m3zwNRSKF3REIGGwQ3i/YyzDO4AD0WnJ
         oTa1eBgVD5RqBRg/itZTfMgvJUSz/tp27+QgL7Cr7d/q9GaNc4QQ9CgkD96In6GI9/l2
         xK2A==
X-Gm-Message-State: AOJu0YyR75BtFHHItkD/+LfpfZJxiQC9QRzKgbxLJMM/gJCvxoTPn3JK
	idtdv+dpUYwEQ2kUJU6RqMXF96kNebDf/+qxNmZa7h0qgyy+popkEOGcQVEm9g==
X-Gm-Gg: ASbGnctaf80frC8hwSG/BSe4dWSQT4vsRg6bxHjvJl2W6jEWbCPRu4gZCyK0itKH0Lh
	RopRfFs1eDQYFdqLkuRrLFOeyn3NEvJjfmsesyfyfteterULd/JFXbvoaUcdthJI69e5+exSWfM
	CqOhu5AzaezXvF4m/HC8eFt1Jmxj5CBwS/yLGyY9ztqenaW++ZqAso8B95NBo4wMt9qeVdMTtEE
	QwVoYtBws4Ze2HqMZsKbvzFUp0kcnEFBzsOpdMydauyl4UPxQ4FBO9UmV+B+Md0J7rSnaaoqptW
	JPx4sUNqhlfbngrKjY3sVf2+b2S1j9pzJ2S8BF2ovck9fCjBpJd+wec3CSMPALRDykU=
X-Google-Smtp-Source: AGHT+IERHtrdym+a+md7axIghGcxq3RiGaTbvxFTMe5x1uxPrJ/XnrL+3vA0wTIn/nEGPAckIupSWQ==
X-Received: by 2002:a05:6808:3505:b0:3f3:bd0b:e0c7 with SMTP id 5614622812f47-3f3d8da2607mr756128b6e.8.1739409207796;
        Wed, 12 Feb 2025 17:13:27 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:26 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v5 02/11] bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
Date: Wed, 12 Feb 2025 17:12:30 -0800
Message-ID: <20250213011240.1640031-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new bnxt_hwrm_cp_ring_alloc_p5() function to handle allocating
one completion ring on P5_PLUS chips.  This simplifies the existing code
and will be useful later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Use const for a variable
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 44 +++++++++++------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fc870c104c56..0e16ea823fbd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7199,6 +7199,25 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
+				      struct bnxt_cp_ring_info *cpr)
+{
+	const u32 type = HWRM_RING_ALLOC_CMPL;
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	struct bnxt_ring_struct *ring;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	ring = &cpr->cp_ring_struct;
+	ring->handle = BNXT_SET_NQ_HDL(cpr);
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	if (rc)
+		return rc;
+	bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
+	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
+	return 0;
+}
+
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 {
 	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
@@ -7242,19 +7261,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		u32 map_idx;
 
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			struct bnxt_cp_ring_info *cpr2 = txr->tx_cpr;
-			struct bnxt_napi *bnapi = txr->bnapi;
-			u32 type2 = HWRM_RING_ALLOC_CMPL;
-
-			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_SET_NQ_HDL(cpr2);
-			map_idx = bnapi->index;
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
 			if (rc)
 				goto err_out;
-			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
-				    ring->fw_ring_id);
-			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
 		}
 		ring = &txr->tx_ring_struct;
 		map_idx = i;
@@ -7274,20 +7283,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		if (!agg_rings)
 			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
-			struct bnxt_napi *bnapi = rxr->bnapi;
-			u32 type2 = HWRM_RING_ALLOC_CMPL;
-			struct bnxt_ring_struct *ring;
-			u32 map_idx = bnapi->index;
-
-			ring = &cpr2->cp_ring_struct;
-			ring->handle = BNXT_SET_NQ_HDL(cpr2);
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type2, map_idx);
+			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, rxr->rx_cpr);
 			if (rc)
 				goto err_out;
-			bnxt_set_db(bp, &cpr2->cp_db, type2, map_idx,
-				    ring->fw_ring_id);
-			bnxt_db_cq(bp, &cpr2->cp_db, cpr2->cp_raw_cons);
 		}
 	}
 
-- 
2.30.1


