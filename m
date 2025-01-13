Return-Path: <netdev+bounces-157602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E3A0AF65
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99413A20C2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E7231A46;
	Mon, 13 Jan 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P2O+tN5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E11232369
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750415; cv=none; b=nVRdVIY29b7l/KrtdezO7yIcWeNY7rV/kTgSUm1SiaREEH2CLjgLEzXHFy7XkRe7iD+LZBLwRDNckoezHWqBKzB2zTUbMYf+v2TGRWq2Kyez4cvFhctM2cFr5rJGi5MttM4Uekd+DizsfmpIhkmJaAW5t3BkB6Z4mHACoZTgbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750415; c=relaxed/simple;
	bh=7xGbNKfDlDXcmJ3zEHTqOX5f6MHoW+qO6bLiXgRv4t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXPnOoqEnAId2I2+f9WRI138M+pszf04tjnEYTClhTp5HGiYQMtOTEbHTrSln5D7JLD4Cxt5jbwCRjg4bEZpx+ePtt2EY98EuqDZ3jdGgR8OEY8L53E3WSHDnvqQZeKikaAVPdFIKEZcJU/iRJmoQAV6BBaA7BzxwtY3jEbZJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P2O+tN5t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21654fdd5daso63893765ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750412; x=1737355212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbm+qmkEZ6i8uKzVe9Rp2TsXkqbq1pLB5M2HUO7zAlQ=;
        b=P2O+tN5tUWjNdYYcv+bWQl0W6NaV5Mcum0zYPFb91lmsh2a3026tmWt9Vg0Hk3EgFs
         GEapKOsh7hzkpTvHui6IWrzGp6QeIcTMZvg6NNszGD2pfD9+g+KpeOaPUu92cTla2Iwg
         jKF3W2aMQWjUxIA46g0Y3cf3SZXJgPDB6miYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750412; x=1737355212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbm+qmkEZ6i8uKzVe9Rp2TsXkqbq1pLB5M2HUO7zAlQ=;
        b=aOZRJd03ETrjRB3l6qSzVLrYn56c6/QqVFPgS/uyIuSHUPjAIeFpjv/y6/8n484cKX
         uZSy1JdL6gEF7zt71k4Wh1rOIL91/YpK8uncErzwfvsroBoRSyXo1iyYgzmMAKFSDs6z
         nVGYoFP/xpu2su/19TkMi0UMfuChEz7oXCZvDHJGPv8On1ygZs3iE1Da7+9Hvt4NTaWb
         o8HAxG8gT4nWKSwAcZWYNJJAS6GiUlpktvs9i9XfettsrLXjvvTMDgxSLsysJjBMTrFc
         rO8hFpA8LTRw9oyWkIFbI7392NBbwN1ILsUmHlja8UhOwt/pVm/1T9Lk/R7RFrl3kWlq
         imWQ==
X-Gm-Message-State: AOJu0YxUht/eF8FsA7zWfwNMw8k2jA7vMtvO2kubcMRoOOXjS0LqMof2
	3ggEC8sB35/AZ/LMfNYoYToacTxI0HbROMeipIdMy92C+qJbTL05cVGAGP1SuQ==
X-Gm-Gg: ASbGncsW30nH/ZIykWmTktwQPG8HnISNC2rqpAPxb4CnUxi8+u/wnEk0a3YdIMi2H14
	ei2atO/NkhPL+pfrK1C69UqMVxIDyRGEH1sqJ+onYwGJemDhl+lDhpNk5/O88QAqbGP4R2TDcTw
	/TKzXKBONbP3kKcfvaS2erKbLb0fUom2KYqNqsMZWnKKnjT5qHNZief4ndhhdP0luKrWhpn2lIG
	S/2zAdpR+UGg6FfZ2Ozi2V2sWZ6rk+CVb/4S+OdzWdKF+v7gwVu+3AEqZvHTHCoK+VTmgiRQl4K
	tFrszJFoY3ZxcxZHv4T/XPmo1aoqY0No
X-Google-Smtp-Source: AGHT+IH9U2F4rqzrw1L3+8gxJ12nQn0NL/IcdTdsvtxItHBlDBSmW6AkaMo29skKcZOjmCoBGriqKg==
X-Received: by 2002:a17:903:186:b0:216:282d:c69b with SMTP id d9443c01a7336-21a84002ac6mr288513375ad.50.1736750412019;
        Sun, 12 Jan 2025 22:40:12 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:11 -0800 (PST)
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 04/10] bnxt_en: Refactor completion ring free routine
Date: Sun, 12 Jan 2025 22:39:21 -0800
Message-ID: <20250113063927.4017173-5-michael.chan@broadcom.com>
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

From: Somnath Kotur <somnath.kotur@broadcom.com>

Add a wrapper routine to free L2 completion rings.  This will be
useful later in the series.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e9a2e30c1537..4c5cb4dd7420 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7378,6 +7378,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
+static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_ring_struct *ring;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -7423,17 +7437,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		struct bnxt_ring_struct *ring;
 		int j;
 
-		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
-			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++)
+			bnxt_hwrm_cp_ring_free(bp, &cpr->cp_ring_arr[j]);
 
-			ring = &cpr2->cp_ring_struct;
-			if (ring->fw_ring_id == INVALID_HW_RING_ID)
-				continue;
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_L2_CMPL,
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-		}
 		ring = &cpr->cp_ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
 			hwrm_ring_free_send_msg(bp, ring, type,
-- 
2.30.1


