Return-Path: <netdev+bounces-157605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE1A0AF68
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1943A6F72
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B423233124;
	Mon, 13 Jan 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RNJI4KQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39D232780
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750418; cv=none; b=l8A+PATxCkOmV0V/lwB7deFwFwIiXdkQCapOonuyd6xerl/3GhlN403TBjcYXQFsWhcwdMre6vU5Nzx4zZD2EjkCNPEqoipisftRZ3VV5P0IYi9IssA0HRbR12KCFStaiIhD3IAbrurDy246Yse/ZDOO0iPanD0hPqSq24z4Fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750418; c=relaxed/simple;
	bh=LtGLFlZCuLB26h0C57Xbpxchpfd0yGdBnyNXqg4zol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbIYIJWJhfTbUL+u6+6kZqs94QeM2VWABljlgO/tsdDGKurmMksJ0VpgtIPPwzpTG5I3PmHuKW8z/GDe2PZC6WpA32vPfTdD5q+MkuAWvhZCfWSywvusJhAf13mfs02jC1VJ5ZsrsWPlEneUOWblhVU8wowC+1KpjscdJYQePN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RNJI4KQ0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216728b1836so66289335ad.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750416; x=1737355216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do9Y7F8ta8tI4xzuwVHlG3rrw+vbCLlsnA7GtVLEL10=;
        b=RNJI4KQ0ty8HFZ206OvkgOjik8Vwt0ueAXJQ365SF5TSfMjOYtuSCDT9cSh+laRkyX
         CPSSgsMfU8jlaPSWiz+8usophPSGHlLzgqzpi7P8i1VnqgkXblzjFliZD20ayWOCMyVI
         3AAwcq8DtANONilEn6qlWf0SzyQHi2h87tUYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750416; x=1737355216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do9Y7F8ta8tI4xzuwVHlG3rrw+vbCLlsnA7GtVLEL10=;
        b=UeeFiF2/mE4Nko09avu8HTZh5QiO/uwy/KSO6duOdo21bb/IQaT8fmxD0kpfjW1jcs
         Y2u6WnynBDnX0tbOU1elw7rLIGKvyb+GRqROu+4vrPXCHeztjY4n3DY1r8plD6rJ/tMo
         9M41mqjl/88zYQCXflMAfokC6e+3/wlC7+jCwhxVWImKSl1Lb9wIzU2k6N/RPhI7OMTh
         D8M43sYF9q5Bl3NVMo+hR85gr8r2qpOeNI3zUR2fkOlF9Qaum+wK7Z36twT8byiG0w5+
         mPc91nviX4ZNh0amnE3xHtQGHTr5uJXRWAwysPumZDN/MJfOrQ4IJVhgLAPdCprXWsCP
         ykyg==
X-Gm-Message-State: AOJu0YzdnXD0Fa41x4Y1w7KcWZcjAdp0af9AM2NVTn1b+G6DRa+oRNMP
	0oiAtGEl+UeU5jGdVteH4VEUxQpmBk6ICLg7m7Rn8ueWTlY5ltEflK+NQsKvcQ==
X-Gm-Gg: ASbGncuPUrO/wBCloBqUqqTOH2sWuz0zT7xnBkC6wIPO+7dl97g6A+zAddqOjeGcQMT
	sXTwtwMXdDsDVC5enI6aPTIzueNBseXqgIhohLxbhkEB/CdZV8Ex7zBvo24irwDUcwwxWHyzVVS
	XCEMZSEY7oyzm+1arTLlX4UIQ3YGgguaC8w1IOwC0OKY4ua+P7tCdvVKUI+iS+kgQhaUMxK+FeV
	9Fu3L8OJgjRxsN/RBzw6HOIE5lr34+r0PCkWxbEVzWaztxJ+dc+bCaeF/bzkznteudpVHkrSaEY
	HDnWOzbuiZK1DKRJPgDq/YiY7RDzX7nu
X-Google-Smtp-Source: AGHT+IE3To7RMKSvdFJ2fKWLq+sjEZMMshsBW6o8iiJJtXxBeh58DLdd5gTevfoz8VgtWMOgeIY3kA==
X-Received: by 2002:a17:902:db0e:b0:216:725c:a11a with SMTP id d9443c01a7336-21a83f43b7amr330127465ad.10.1736750415882;
        Sun, 12 Jan 2025 22:40:15 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:15 -0800 (PST)
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
Subject: [PATCH net-next 07/10] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Sun, 12 Jan 2025 22:39:24 -0800
Message-ID: <20250113063927.4017173-8-michael.chan@broadcom.com>
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

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe Steering Tags on P5_PLUS chips.  When allocating
RX/RX AGG rings, pass along NQ ring ID for the firmware to use.  This
information helps optimize DMA writes by directing them to the cache
closer to the CPU consuming the data, potentially improving the
processing speed.  This change is backward-compatible with older
firmware, which will simply disregard the information.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c862250d3b77..30a57bbc407c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6922,7 +6922,8 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
-	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
+	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+		      RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID;
 
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
@@ -6936,6 +6937,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
 	}
 	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+	req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 	req->enables |= cpu_to_le32(enables);
 }
 
-- 
2.30.1


