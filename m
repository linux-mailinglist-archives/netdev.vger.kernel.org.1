Return-Path: <netdev+bounces-157604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2AA0AF67
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA04B3A24D7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE0232786;
	Mon, 13 Jan 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TUvxHEl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907C232373
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750416; cv=none; b=okHGW171auPFsLc6LQL62BRrEvp2D5O/4pfk5KnuSw3T1x6Dv4TOEx3/EUaALvVKLLHpbYPNizSX55A3wBoIej3RMII/M+8u44MRHRJ++vFIirXsO4cvJrU3Yj11YoxMR/6ISPfpvTSLcJhy7rBJZw0CHyb3MtVKHPe/RK/AvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750416; c=relaxed/simple;
	bh=Iw7QAxScAn+dBGHgREsYNYQ3Xgxp6sYPYPJBWqLTM9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so87z+/RuHpn1Jh3o+SZR6erYt8qi5yNnwpj8j1Yj+11zmcBlZ3LfqcN41rnfVurfQUCXDsvxpcyMGcRjn2nF2mriiTtsuvboNMB/AEyUZqpsnfSlCwazFyTTWqYwnPSiyUgVVYoJa4FCWCv9k2Lza1tkfHu78RUafywIOcY1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TUvxHEl+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2167141dfa1so67693005ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750414; x=1737355214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz9kdjBWSmt76W8AEDgoAsCUHcapox2gX7zyXYohUmA=;
        b=TUvxHEl+Y0TByXcybpzWE8oVo/hzkkBO8h1CuyFj20+kETv7twJics92TTVRD/U7f6
         ECT5EthBM7P/X3S1ulmBw/Q6Xdk1MmkK8hs4WMZ88FY+jrxM0AqlqksO87NHQMMdHriq
         mAdcQOH9KpsU3zxIIl+6La00ie4TI6aJrXm+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750414; x=1737355214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz9kdjBWSmt76W8AEDgoAsCUHcapox2gX7zyXYohUmA=;
        b=AZneWDi35DA8Rs61GgKdDUllKOthTarQmanq+Zu9uc9FwNGbve7/Iy7nVI9fzaaYM9
         eVmKPuJrkiSt0kJvJykBTIqXrqhOVHG1VfzvIpgwJkc2jF+ZWGmwBn8Cm5yymomUTI4c
         GvMrPJCW8NIxe9nuEbWX+M/F+Abq+KJlDtDfvkfkkZXjAzvJzU9QTD7sUarRPAJqNk3W
         6gNhXPUNsIULl/+espX7LWfwz6Xuuv0GjPwBXqAzLlH9f1eMbg9lJ9uD9VIGyBd4v/Q2
         2zV9oei6tMqux1qH+FzqMmr0VYTYo7O8x0GJJUQFm/Si3VhFlhWyxU9vPVsWUk9+rM94
         NauQ==
X-Gm-Message-State: AOJu0Yz2aIlf5n7NkGurjXT8FTIzf+vsljkLeW9mZ8HaxDJS4d8hsAkm
	Ya7z3t/H4TXTFpz8NOHlrCMvYbKlJcwtcvw8SFZbdnYvH1ipNuAKDn+mMjh77Q==
X-Gm-Gg: ASbGnctXDvr7Nfg07r30DTi24OWiMJua4xFlpBmHnXIoAHPHkDexTAn/I9I+Coh/xc4
	EpeYP+h2mzuchnkEyei7Uh4q8dYkZNKoVO1A68fPY7Kzj233V1uEij517XjMLAhxdorW3vck7oj
	J4QxhuvfvfW4GX2AXb9EYcNXKyb3URw7s9CUP9lhpdykAYB/pjUOawXVPx1gMVgwUscBAcYtmOy
	KX8RWmfQG7URoGji2mUF/IQJhPpN7tsJKF+WTqADIhCw0rCiuW8Mb32UDWyKF9wGopguePV661C
	7v4O520WzE6JG9pJsdLGOjAZOwhyutoC
X-Google-Smtp-Source: AGHT+IHeSu+LpP+hgaRqPG+y7ed7EF5xxMkskA4/oEts9gg6KsIP4ajwa06rbrvERGeFWMaVHw73rg==
X-Received: by 2002:a17:903:1249:b0:215:b1e3:c051 with SMTP id d9443c01a7336-21ad9f23c63mr115441095ad.11.1736750414426;
        Sun, 12 Jan 2025 22:40:14 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:14 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 06/10] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
Date: Sun, 12 Jan 2025 22:39:23 -0800
Message-ID: <20250113063927.4017173-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250113063927.4017173-1-michael.chan@broadcom.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is some common code for setting up RX and RX AGG ring allocation
parameters for P5_PLUS chips.  Refactor the logic into a new function.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 58 +++++++++++------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4336a5b54289..c862250d3b77 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6917,6 +6917,28 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
 	hwrm_req_drop(bp, req);
 }
 
+static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
+				       struct hwrm_ring_alloc_input *req,
+				       struct bnxt_ring_struct *ring)
+{
+	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
+	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
+
+	if (ring_type == HWRM_RING_ALLOC_AGG) {
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
+		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
+		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
+	} else {
+		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
+		if (NET_IP_ALIGN == 2)
+			req->flags =
+				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
+	}
+	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+	req->enables |= cpu_to_le32(enables);
+}
+
 static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 				    struct bnxt_ring_struct *ring,
 				    u32 ring_type, u32 map_index)
@@ -6968,37 +6990,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 		break;
 	}
 	case HWRM_RING_ALLOC_RX:
-		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
-		req->length = cpu_to_le32(bp->rx_ring_mask + 1);
-		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			u16 flags = 0;
-
-			/* Association of rx ring with stats context */
-			grp_info = &bp->grp_info[ring->grp_idx];
-			req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
-			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
-			req->enables |= cpu_to_le32(
-				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
-			if (NET_IP_ALIGN == 2)
-				flags = RING_ALLOC_REQ_FLAGS_RX_SOP_PAD;
-			req->flags = cpu_to_le16(flags);
-		}
-		break;
 	case HWRM_RING_ALLOC_AGG:
-		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
-			/* Association of agg ring with rx ring */
-			grp_info = &bp->grp_info[ring->grp_idx];
-			req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-			req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
-			req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
-			req->enables |= cpu_to_le32(
-				RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
-				RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
-		} else {
-			req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
-		}
-		req->length = cpu_to_le32(bp->rx_agg_ring_mask + 1);
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
+		req->length = (ring_type == HWRM_RING_ALLOC_RX) ?
+			      cpu_to_le32(bp->rx_ring_mask + 1) :
+			      cpu_to_le32(bp->rx_agg_ring_mask + 1);
+		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+			bnxt_set_rx_ring_params_p5(bp, ring_type, req, ring);
 		break;
 	case HWRM_RING_ALLOC_CMPL:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
-- 
2.30.1


