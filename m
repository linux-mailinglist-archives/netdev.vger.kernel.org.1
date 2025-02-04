Return-Path: <netdev+bounces-162324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1639A268E0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09857A3954
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4113B280;
	Tue,  4 Feb 2025 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sq/1pK5g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F51386B4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630029; cv=none; b=X8/x+dsO68axnLuPfv2tx3NY25Qlo1hGk7FaYsNOP49JWRFwbq/tNoHQy/Sq4P6ioZ2BuexU95UyZdUPzICGWDiUMFuDEUBtvgbvnM2xyAghqdk7mHKnKk6B3srYQ1gcGUHIb+VbUChMv1Mu/aFs3lnjOLgcMakKuQ+xy8ukkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630029; c=relaxed/simple;
	bh=I9Fd3w7iBdsQw7RR7W5KoX06nwuqLqZBEZ0GhvatebA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPdxq1X3pNs5nSsPFIUU+uy95kUAcRwgxs3eNsmdH3KcD9aOygx4Ejqdb3EptFrgfRIxiaaHTh0qXbTASUN2bG31+JW7wlDEKixKRiANLNV2/XEOVjoLad2MDkSihxKN6K3UJfQHVEE8/QSXfm0wLZGYOL701tpRdnne8R+VnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sq/1pK5g; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b38896c534so1579695fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630026; x=1739234826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=Sq/1pK5gWF1DE23YgPG4OcLyLSrRgZ5pfFn6l7I0TwVPOpOG42fb8z/kfvnE9auc0+
         1xTE+qqgfBFI5Mf4J4pTN4u5Qlr9KO88fl8vlEgAEg7JUqZXhOaAzI4GhyJbdMggbL62
         goRGaNXpdTdp2klS2WDLOnHCr/Tz/JQsJ4vgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630026; x=1739234826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=qcF/nQtbFJIi+O9xwWRRZTY6zIqUDrlNZdJyeB/0d9Syk+M6hhy8CH3QgRG65jChYZ
         qkUJZQKpCjU+cDlM4SrilfXAezZDsDwcPI6RFqcuz4gatfFnX7l8TzeF29eqWPd7Z/ty
         jLMdiLTS4EkqwYxgtTaLoltYNc85G2f+WmxC6IIil8aqQPpVhZ3xGnbxAx/y9c+Y+NCS
         1If5NYEpNHyi2DhwfoHtKiq76FJpWx4bq7jwrM2zGsAoLNI3AOSQAw5zxEpgjYtp1aX5
         0ZIEzfg7A/xLYQKtpqnrKn2KdcO5BoCdYrSVbrltPg3KJJbLB13O52ACnbOoM1MrpC9R
         /I5g==
X-Gm-Message-State: AOJu0Yw+W5pnvS8BApWMtev2Fuxp40OxPnSRzNXT/W+YcEUCff26/98L
	ZP4cBwiI1hw8/HCJ1bNKqRi+dSIp6yeHdO4hk6GPBBQOO/wg50X9EWoWigNCLA==
X-Gm-Gg: ASbGnctz6PGGr7fLXFJWVlW71NzP9B57ZNJKBz1dTWvFDS2fTMrJ//bjYlKs2H83Jid
	5rMWyqOmoLykwBCvjf6IK+JGxOB2F2tYB/0TIOxbZoLagQBOSBaYkjhfEytw7zsTvS2zSKE0jid
	wVraG9/jmMCnt6dFPJltQ5kLOKONh286pgbk1e04muqT18VpvGdpYQteTapiFaqNmG0CQdnlHFY
	ZAx129/Pht5cVxBxmjZMnqPES/38DeQzkwS6dUg2eayaD9ailIpZLk8WB5/QR7z7Beu5MSdTR5n
	ZhMCKwMSDGAHL/feC7AZJDysbZBcDKBXICxznvk+q7f+tvvm3lVoRVai8EmPWzJW0TU=
X-Google-Smtp-Source: AGHT+IFs5JqbFOSpAwgDPUPcsnmYrY96bZ03qh6xDN1Drwhc6VdFOiqkHJUGWxQ30mdAqcLr1Csdpg==
X-Received: by 2002:a05:6871:814:b0:29e:3345:74ff with SMTP id 586e51a60fabf-2b32f203e15mr14237998fac.23.1738630026371;
        Mon, 03 Feb 2025 16:47:06 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:05 -0800 (PST)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 06/10] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
Date: Mon,  3 Feb 2025 16:46:05 -0800
Message-ID: <20250204004609.1107078-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
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
index 453f52648145..ac63d3feaa1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6944,6 +6944,28 @@ static void bnxt_hwrm_ring_grp_free(struct bnxt *bp)
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
@@ -6995,37 +7017,13 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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


