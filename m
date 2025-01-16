Return-Path: <netdev+bounces-159025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D41A14236
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC516B4C2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20D236A8B;
	Thu, 16 Jan 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/rsT7RD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF52361DB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055491; cv=none; b=Lu0d7YPkY17IM3H4FaKgP3fcnZAYbHHz/LjmBRQ3kgBQYLbsF8pQ9tPXWWs+lmVC4gXcdfjwCDfN9WsODyP9kNhKB/Rsblz2AIWOgPZ8XzEeE6KDkymY7ASl24TiYYLlCiN4t8/asgY27FfjGEw1R5Y5UKQzdez21maKaKkXrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055491; c=relaxed/simple;
	bh=PNVHL7YTNem/WA0Or55Gb20pZdAF3L1ptRe39kjvheI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGIsCbJqYoUoR1DcsMhXTGxOndjq6YUnFTPWER2YXG4JZx+ufBZNXF3fFUGj7WAO8Pb3f0fvIQOHHVbCq3ZOeLtXzAmX1ydDlZgA4ggYIdIslMmc14V9hl/p0c146NSlP6R0XAYquOd+pCFySvjUn4JkBe1AhqDvhu/qYduIyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/rsT7RD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so1892033a91.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055489; x=1737660289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTx8V1qXANaZ7DHzyUxUqznIoQ/WlPYQy5w4MRNLGGA=;
        b=P/rsT7RDRcpLYho9kwdpZIf2wMCytemInCbCZf9vQnfLDkELem/4/OeWX+1bIZ7cTw
         6duwergLfZnSzgLWGLHqoosKB5pl0vdmFnOdK5My82NOwv7EAqa+g5JUTv8bO4ZjD0dj
         qg4uX0zpoSv8TNB+JX2j80ccUZrsALCaxUknk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055489; x=1737660289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTx8V1qXANaZ7DHzyUxUqznIoQ/WlPYQy5w4MRNLGGA=;
        b=Dtdfa0bDsx7oXX05CNlXfDG+ZVVWiPSPqqx0hu35DBnM5w4FuXPa5doD8QrqiP90b5
         jA9f8shuK/B1mmkohqex2xM69rLFJto1x3fN0DtDGsS+leMihNM3h47HdEiG5ySRlvYm
         NB/bpGwdndNuZQf73hr8vCshAGc0S5Xmn2N8VUcd0LInBD403lFKqtGdXoUyM/o/G2wZ
         +IB5HQ2jFfC//cDLuW+Y97WTb5zbdDlO+WrBQKKmWjKNWfn4Nl4w+xrTfmQNpFIp6GxJ
         jQklX6UBSEDu+zlJamMOc2yM7bKxRRZpXTDz2cVFdb0OZK8ov7qpMQYEHz87zDAJQ37+
         s2zQ==
X-Gm-Message-State: AOJu0YxxouUW+5di+eAQYvDe+fw6Ngp0AZROOyMDOKeVnwWk+x8TxbKh
	EPSaMiQbn0YkC4ZY1Lx5dV5nzYpTL+TSCZyO0mpqSIXz77392N4Z0uWMAOlTdA==
X-Gm-Gg: ASbGncsOlfV7wAt1nnV12bXZXqRhVcrAFcEIEhGI2w5RqMWnQKlvLGc8MUurjYl8Eyo
	6vEj+ag+34uz5pTh1VJK4HkWXv6Si24/0HzuNei5YNWGK65kTx3bS8/bat6SRcFwxd9OJSgrl/n
	FP2a3oakFpq6dnAsHQao8+hWlJ2ep8OMmGinIdBbnLs2b/ZcnnfMW7O21VKibvGe8g1I+zDTz95
	Vnlk5V+YuwGyHfZjNMBkWsQTTZaymVlG4UXKJyrjm7BM9u/SBVEO5jhBBx4z/ZHW39VTdvbQtVA
	y6O4YC55e8bZvqn9YVidYWggCDOljVJw
X-Google-Smtp-Source: AGHT+IFrTvNjFYgUqQBBr2VhaRNyD4+lzsvrD19jyUhxG6O7P+ni5k0GQGK1IuhCy5ufkKccjvYBUg==
X-Received: by 2002:a17:90b:51d1:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2f548edf181mr53400231a91.18.1737055489316;
        Thu, 16 Jan 2025 11:24:49 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:48 -0800 (PST)
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
Subject: [PATCH net-next v2 07/10] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Thu, 16 Jan 2025 11:23:40 -0800
Message-ID: <20250116192343.34535-8-michael.chan@broadcom.com>
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

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe Steering Tags on P5_PLUS chips.  When allocating
RX/RX AGG rings, pass along NQ ring ID for the firmware to use.  This
information helps optimize DMA writes by directing them to the cache
closer to the CPU consuming the data, potentially improving the
processing speed.  This change is backward-compatible with older
firmware, which will simply disregard the information.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 919f6efd0571..da5acb8b0495 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6927,7 +6927,8 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
-	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
+	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+		      RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID;
 
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
@@ -6941,6 +6942,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
 	}
 	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+	req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 	req->enables |= cpu_to_le32(enables);
 }
 
-- 
2.30.1


