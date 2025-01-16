Return-Path: <netdev+bounces-159020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE6A14231
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38C5188A076
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4522FDFD;
	Thu, 16 Jan 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S9btzkps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FC22E40F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055484; cv=none; b=icYzCiC4gdeiI5iFgZ41knGBFvK9sUM514KwqNCXD7xpDF07KYq2rvqIYJAKSIfQRgD0g/t/5zV8LfHZiOoVpaSdOAgwb6HqA7C1UpN9M9Y0SkrpHRZexqGwrS47Am11EXyxu8Gv3jIntz8yGz5sbK2B0qqbna7LURBLZ2lWcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055484; c=relaxed/simple;
	bh=Ik9fCcqZcGlSgCHXOs6Mnjoe93TgGD26ZifP6iXlGDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgHWquKm/QlYI4XOMnxX0FPCvd8tbm9T1W1dkDpM3CZy6lgqmuHQm90uvHx9hLfW4+nVql3u1HXOlbgXP0+wq5gU9dtGwAhzAebax43XAU8e8Z7f2UiI90SNGts6YQQqJkJevcafQrcnMpRr4Jd9Y/Az5c1u1BZpDIA11EfuvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S9btzkps; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b662090so24654255ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055482; x=1737660282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG7PXWL3p3eISeDcZaNh+zmaSdzd+33yi7EGDD3/Zoc=;
        b=S9btzkpsrwnf/Vizkp8AHMoq1AZavbE9z3ZRTiBe9iAqYmAJIaQfg426F7Sm67di3n
         K8FCj4ipja0NPwUlwYRmfDpAT8miQ2AQaDrBi0mZC/AHGoRSPlan9a3OVJp812S00RVz
         x49TEYZzxRLVDhlWsDnGLp7hdAKLdj5NU4sRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055482; x=1737660282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG7PXWL3p3eISeDcZaNh+zmaSdzd+33yi7EGDD3/Zoc=;
        b=KPgqpnDOnP4JHknyOlLG10Ytx4mCy+Epnc+hRtlU4cQ6txc42obtvEVouKAcU6YT/Z
         ursvrV5njhV8LjRZg0Xeako+6geeIujdvBqKj0GpKN5q19sdXPQXFh+UNbLU06TxLNf3
         H1Uus8WVML4VfKSEErfgnMxfx8sJVy5ASKzMxwGRwBXkskNdXHl3Hc1kFD1JwMzVlund
         XJkLMBQWQGthxUq/F7S83yHjrf9qPOZpKnU/kz/npXjqbgVOJLdvDYE3jFevuRXC2m6y
         eJTIvtMaiH4fN0kHv6luAl37xmx1I2IRCZflYAQOOdmrZlPDsRhXk5GuDcBQuglJVUF8
         +v3w==
X-Gm-Message-State: AOJu0YwNHegLhn06lO6MgEUtkW5Cbt9g98TfWegh5M7or27q/FWHkVET
	0E49s4fe3xzkHOxYDaTCV44GJBvnYyug/KyaN1zVahjX0P3pib1gJ6TAKYb2Ag==
X-Gm-Gg: ASbGncsfkdFbnNV2qlWtVwKbsLkU/zqLuxzVoyJDefdWb2mGjblPIpFsujw6vQd8wta
	NsZaThf3vJTwgWG+H+t7/SQmdJO1oB90fsphFX/lfa+ecB8d2RbINIAYxsJXL8uVuPIkJWdBWNh
	thpqrf297w3TZmCcE0roUF3h0rluqtppzQkh+PjNanAtMTxPIF7UjNuB8e5hcr9ZINGr6bLy9K8
	TibWreiWe4yJdRQM8vIUMmW12mO44ng5pAVbnmsRD1n6nMtysndkRyNvV6pndfKpQElZ6RrU63x
	w2FKhg03F9TGDV1JbcImXEBdpU7r7+n8
X-Google-Smtp-Source: AGHT+IHcQDSpVsC4fmJGd/UwrUvQF/IK4Bc4b2nzXbEQOfzdTwc3UhgY0sgBwk1kyuoTaUjSyrb5tA==
X-Received: by 2002:a17:90b:518b:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f548eba7d0mr51652430a91.15.1737055482671;
        Thu, 16 Jan 2025 11:24:42 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:42 -0800 (PST)
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
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 02/10] bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
Date: Thu, 16 Jan 2025 11:23:35 -0800
Message-ID: <20250116192343.34535-3-michael.chan@broadcom.com>
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
index 5fda41acbb5a..72fff9c10413 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7177,6 +7177,25 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
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
@@ -7220,19 +7239,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
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
@@ -7252,20 +7261,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
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


