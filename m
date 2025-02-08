Return-Path: <netdev+bounces-164371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36DA2D89F
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546B3166B05
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46B243974;
	Sat,  8 Feb 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EiNkFhQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CD241C86
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046612; cv=none; b=o3801F5uML6rvwRWlhwzC1w+LZKH/zdI+fl28HFdswEiOVsJruMVmuKKvPEl6YjmVBokoxcuIIxbKLT7o8RiYez9Xcf0Gn6WGpmZSB14oZulo3Aj44D24xfDyE8gsSyOIJERrucB42coWI5NxXXrFJ71vR2Wz6cHd/px2Ul9oIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046612; c=relaxed/simple;
	bh=I9Fd3w7iBdsQw7RR7W5KoX06nwuqLqZBEZ0GhvatebA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uhm6L4hjPXJmXrUTJ7HnUuS6DOJ1fOSOOPHZ+wOJDnSR9FdTzdX3z7Pf+S9lzsChqV8Hs9sog26CQc/07Ash67QdTlPsuY8qBF4VCzdcGCbwokpE6AzQzSryVOVo8PUI1xC90nAvwhaJQXtrTX1RQb5b8jm4HT8Nm/lJ3jXXlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EiNkFhQW; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f2dee7d218so1561487eaf.2
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046609; x=1739651409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=EiNkFhQWP3Ue7SJU3uYL9rf694NhtRoHqx1OJjAiZ9pIInR/nkYGwT1oLa0IM6HyZD
         ZnymGKa5eLcOotJ/bnKvFWccKijhYQV1tMglMY2woVWZmXs1zCIeJsVLZRSvdA0CqDHp
         TemPNynYQG324Ia9O1buRWZozytaTQagSNmoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046609; x=1739651409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=sE7AcLYl+LMGrlf94O8n+LucFXrN3oTZKH0C6lGpIUpBOSvAjNklqtg8/JFX0DdLc8
         4vZH3xgJRVPGeUIrKSmqCujWpXeK3XKxEU7ViSH89VI/+9UaV9231arYERKYG0VuPH7m
         WWY9fZhKRM0z+kKyjyrsRcSFUBCUYMEZvUt5F66xXRGZfqImAmcj/9hiXXdtuy/8OwnX
         zMOgTtudsTbLbDZiLgCz1cYXQlIT2FiuM022PvxkdwSdpvAGut9SIlbab6nf019df3XV
         ncT83dWVBLxqDrUDZ85sWzSP04XWHFH0SoGM62hRo/xcnc3xYBsJTzRPH22sE5N4gnG3
         jIqw==
X-Gm-Message-State: AOJu0YzIN1p9Mxyk0a+uGlCw2z8gv/S8obOdwjr/u1TJn/L1z++P/l+Y
	o0HlpAJnuzhQ7QqiyFnIZkS6SnDBGoXaZKA/YZ1I+VkzEgsZui9JggXbhBROlg==
X-Gm-Gg: ASbGncszCQMsuikiUoyNC552XvIvSi8Oya9FmvLMes1Rzw8bQeyXkm9b/+gIeQTiLKd
	lrkeYa4ObtyCbMrAyvvsSo8PfaVrt/3AP7jqJcfL3u6TvvYnwrDYZFoqaxmyth/pjNkZBsdFAyY
	SrlIV8UwgwKuJ3GMuG4/U1+CfF/xAkgl0Hthhkns8zxyGbIY9WI623de2WG3aPLV99bnxZkdE38
	ZFKaD3sAathQMwNqN7eZtXchQCiQztjmUDc83pb51H82zmnj7hpcgf1eOXZEDc38kMzi9rU3KqI
	qrZiTimRpwIBep515CWM/Yk+5sFUpRXcwaht/qZepOfB0pgSpqBbOKPclvhpOCDT8/Y=
X-Google-Smtp-Source: AGHT+IGfz9jUQ9Av4bb+41B5wBywHpi9jb1QRYtmbs1JI25YlxslzjoWTAnfkL7uoKMB0LeE6kbC2g==
X-Received: by 2002:a05:6820:207:b0:5fa:2139:3f2 with SMTP id 006d021491bc7-5fc5e5ff7c5mr5498076eaf.1.1739046609499;
        Sat, 08 Feb 2025 12:30:09 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:08 -0800 (PST)
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
Subject: [PATCH net-next v4 06/10] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
Date: Sat,  8 Feb 2025 12:29:12 -0800
Message-ID: <20250208202916.1391614-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
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


