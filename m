Return-Path: <netdev+bounces-159024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC7A14235
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AD73A9C12
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A02361FB;
	Thu, 16 Jan 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Futg4PI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA031234D00
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055490; cv=none; b=PxcVRxcaTnTvnQ9u6bup9fN3XX1L0fjv5mV7MXZYydlHD3EUY/NfcLUpBnz/qtzp3rOlCkeJWMGuO1U8JrrljlzxxmdNwLEjU98LoCefb9Fq1g84k5wRURxjs8BtxpPlp7Gv+y3HRTxuKz9Ht0KO8qikD9zeB4tP9A2isnBzzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055490; c=relaxed/simple;
	bh=KRdOMj7yjbhfoV8tbU1tvEQ2TruDUAf6GRedXqVPcdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6JA4iNxgvIM4TGRVdfuiLKODnYxYEXQL0/oCBfI0s5FyGW8gIBZG0FH4CHtyelZdblL6BzDYFzqVZix8qPnPE/mmcgoMQjKBFi9iGV+Ale/SF3t7JQA8DTRy1x/If2GV2oe3c9QEfB0zTkZz7OpncglVvb3XvKjRWByhmf4bAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Futg4PI1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so2499132a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055488; x=1737660288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLG8hHSuvtAnk+h4A6UUjpypA62yo2i1k/65WXAeyOU=;
        b=Futg4PI1pjkb1ABGdwDW+kvxpBueHLvA2lY6BasTZrQWFZCnumW7qC3n1fdGBSNNti
         5FMvyDR16+vCbMkwyKUcU1mYiIQD8NwZFa++CQQSzb0WFzfLKhEUEU+yXM1dx9q3iPd3
         Tg3/YO5LEiNqkzimkkuszNEocEkpzjhQU5J9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055488; x=1737660288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLG8hHSuvtAnk+h4A6UUjpypA62yo2i1k/65WXAeyOU=;
        b=wBISGSkNDn09BDlNISqT6YH7Y5oD2tNwOBsF74oYEpTLFGNJvAkdBNWPyJMVHC4Awi
         ceKjl7OjmZ2qiBDYlR/95hXLdPRW0HHfc4b5zRaYEu6RvYWkkWkqXG5A9QKwuWf0nZ4Q
         YW6pTmeQN8MIz50xIBsNPbqnpbF3rrAZSbHUQcpAm3Pm+xB89Boqf52zT2lM6sXNRUqi
         uhNylcetPPwEMlM2QQs/zbL09p+ImhBN4Gft3pSR92yXra5wvAEAW3pUFG9b6GfhOVo0
         Iqc3RFZoK6SOQoeaoY+UnEJT/Usm/yihZNCHNMvgUFLHgTJ/eHx4Xf+SG9Es81QNw4PU
         6ZVg==
X-Gm-Message-State: AOJu0YxXVbdmS4yItS/3ejQ9i93dHr1X894ejVbiT/orEYaJhEkAu9UQ
	PXAwTtkgoYlWyHQnBP0Fz1a60qF0cgVpImFgnllQYTHFdVof+UUUqh8+Xe/hdA==
X-Gm-Gg: ASbGncsoSQT9UUH64YddmR8W73AN6078bycNCBB6lmz+mYW7E++U1iLsQFeTjuZRbr5
	senVZLPWntix/0i7tEfPPm7Wa1s+qXmntFPO9Ze0GFDWwUVbQu5McPd/0PukuodfYl9tup6mU7n
	TqU6UyrnpnE+ensyo/8xiTSfza484zoTjoBRKqLr+Q3yLsGVzB9KZYnvtxsC/YCl7LeepHQpfIx
	6mk6uPCllEJYhT5wmi4ohB8kQg9rsAn1AZqKCtVjyq5ZVAdZALwx2khyEhqxXKRBgCZs7/rTlt5
	LxeUa5GMSP8LPduWig/bsoRDTAasfqT3
X-Google-Smtp-Source: AGHT+IHLb/onFDMsheI52NMHw1l5nTd2j3pJZfsnInfrT02HoNK3RojMTFHhnQqrSx4hYVAKRW2aiw==
X-Received: by 2002:a17:90b:4d05:b0:2ea:83a0:47a5 with SMTP id 98e67ed59e1d1-2f548f17337mr48032259a91.4.1737055488077;
        Thu, 16 Jan 2025 11:24:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:47 -0800 (PST)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 06/10] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
Date: Thu, 16 Jan 2025 11:23:39 -0800
Message-ID: <20250116192343.34535-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 58 +++++++++++------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 50459ffc48c8..919f6efd0571 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6922,6 +6922,28 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
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
@@ -6973,37 +6995,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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


