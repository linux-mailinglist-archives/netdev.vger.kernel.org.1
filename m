Return-Path: <netdev+bounces-165754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3CA33475
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20733A8784
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365A145348;
	Thu, 13 Feb 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QQv5VjhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8F1411EB
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409218; cv=none; b=TP6OT5mLj9iLHgIpUGv3ollo4UixVBHeqlLE2xuFmMlV5pulJ0XVYrQ5OTiwr259HdSslB3+hKwOfgYqOOhAwvMBtzD452p2s6hvUU6F6SX5ZPu8JKDLO2Eoa8TMSjvfqkGunmOIq9+4wpXSiP3yq8MUh8QkTLQGfL7Jv8bDGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409218; c=relaxed/simple;
	bh=I9Fd3w7iBdsQw7RR7W5KoX06nwuqLqZBEZ0GhvatebA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir38JkVqj/xgeOBLqh/ZBnrSBdiC9BotifjQ4a5HuTupEMfJuPcn7OVJspQVufs2ouojWHVgs6vkrLvw7TpWzKrhMzJyb0QNkU/wfNyXYILWXOIx/OIRqh7SIzsUoIcksvIFJcDTEA3SPy8miAyjKX8e3Dpvu/es49bUnOdopfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QQv5VjhG; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-726cdf7541eso158252a34.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409214; x=1740014014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=QQv5VjhGpDU8uHLuitWLe089Ksz6hwabpqnOZks2XHnEbMloiMAyEeeR/+W8C++zq7
         8aKgPXRSBKA8ryd7l/vKImFbtN1fj2buWtPTkqskNKc1eUfF0vjeOSXhS3Gn9YO8VLZY
         VoSyF+f0cf0Wr7zeLiX+P/BPno8TH1KgJ7l+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409214; x=1740014014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPidmFB0PDNsFwHUYhUbpXpckFku0salq0TmYXgX8xo=;
        b=LRgbxfrmY2wzdAfUZq9j1iFDdpcznN1IXerskGqJrV7dB7W7rOajtkwQn7Ii0120TH
         3Sxor6zv668Xnc69QAZa2FYNh4x8cPNYEioq1eo1yrW4qdmAoK4Cjh0DPHNzLfI9Wdu0
         vDdVHb/iSitcp4TdMRoXWOpRatTKDxSiF8B3Cnyp3Iw2SHtfw0+t+E9283ynWc2mkbpW
         4VKcwgawozMfvVT/fkxREArKjv7bTX9XH8s20Wr2nhq43W51QEUe63zwVeQDKUfXf7dO
         VLsUCQ7k8ChuJT2QljGh7RsFGhohFpMbdY1BJaqEahE4S+waIR5Y3vFPItbY2+6j0NEZ
         o5ug==
X-Gm-Message-State: AOJu0YyFJrdxLCzvVtcr/yoE8oBaNOwE+dKl94XGkaL+IsWPMvpq4JFf
	+v9AfTfWj92mUEdodtu1d55Xl+84Ei+FbMkvhJiHxItDg8fxxnoWi6BrL3G8uQ==
X-Gm-Gg: ASbGncsN/PFMiyh22Jfij4ci+oYE9nbRjbL9SUDcCRK0KrGj3mArOM4GSOHfQDoEmi9
	Ya063fnq8j54q/Ms3DJnQEmRFa1vXmXW7ErfYx4yToBGH4wMAVfg93RxsgVJwVUpEeXfE6Es9Ju
	JLBmmigFDfhk2oIAOzcVD2/E/ik+5zoDy4RVSdmhwOeDpKtbzqRYtAiIb+pzIati8HHdi0djWKu
	rvBaIYVLZLTPzPun3Re/pncWZ7L+DF3clF7rmUKlFrkaBsE3gu0OsTTyvrDW/8ystgShlB4Rr4K
	KSjuH9RMtjgk+xHjQ0VhIr5aE+2YSJelGOLy40QLgtxqJ6d4ZBorhnaFJMj83DbXb2g=
X-Google-Smtp-Source: AGHT+IH6rJK+CwS3G3Lw2JD7SlcxemFyzRe20++6kikxNZgxFXW1MH+C0DMK4Q/v+SvWx4e4rNC+ag==
X-Received: by 2002:a05:6830:f8a:b0:710:a425:d6b8 with SMTP id 46e09a7af769-726ff1629d0mr606734a34.14.1739409214200;
        Wed, 12 Feb 2025 17:13:34 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:33 -0800 (PST)
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
Subject: [PATCH net-next v5 06/11] bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
Date: Wed, 12 Feb 2025 17:12:34 -0800
Message-ID: <20250213011240.1640031-7-michael.chan@broadcom.com>
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


