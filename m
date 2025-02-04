Return-Path: <netdev+bounces-162320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FEA268D5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FF43A5121
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391F6EB7C;
	Tue,  4 Feb 2025 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YyK0RVvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D756446
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630019; cv=none; b=rA3rui90jV5FKmV85PwFtlIm4kOSfmEzilNsyYJ2QHKurJSnD9NeHGjvDGJcg05U6OfQoQc9JvrH1cCWopHVn7Xml9q4OvgwP5TXjVxHdGcpLftD14PeCgh9aSAkA/iHVqldkNBZQClmEADgwAx2CkAbQ+DkbUrkFRH/Lb44UYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630019; c=relaxed/simple;
	bh=798C9bVl/2f9vmMwMenfvnnbRYCzOvXYML/rPtxBmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG5qlibEKxwaANf1MaRYd/G1yLs3o5E9Pbg6WEYsW4n2yhYT0J336uKtsPXbW1WX5Q8QHfkxa8Lw4/0AmwDd3zie4y9pwLKU0t5qBRIGApU6wCncSh9jbzcuim75b2vC3p7Mj4h4x2reWW/t2XdHHBy73btO1nNxYZamumv7N0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YyK0RVvl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2addd5053c0so2574490fac.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630017; x=1739234817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=YyK0RVvlfz4LR0qLaw9WgcT+3PNcRlaFqHqLfQX0G/LoVsfwcxvM+/MgQywzyP6k+h
         3Q+5N4RDHOGjE7dDv+hg9rE0BAXmJQ5MmEC9Vv5gezbMykWrcWhF0YsfCVOE4ps3ryG2
         Gpl4dRYQXhmrrxVS0PBBvQJfHGExhqlGbH31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630017; x=1739234817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=TBVYoOruw/rdzpL2RnjQN3NJ1I4iv84vi8yQZw6uPzVvay+yE6ieExdeDt/x7vzZmM
         0C7r59PTWrZliv7ZxDaQDkNU7PWZKZF/2K1PGBqVSOi85IWHHretTOhixTWyFdPeSZwf
         gqZqXiJpjUk1yPaEV0qGtv8mtajPcLxSGgl7g8MmPhPFMsgjcnqnephmDuuHRlT7XqnQ
         IKwskpqjSBwVLIyYbKG9Xyk+x/pJO1ieMPtDhJ/beztko0yjmTxDtxP0TmSYMGWdWpVz
         w3CaSinXRLj+9oHud2f38L/A7Wy3070Tj5IumZ4c4RSBBTzXzYy9zjrBmoY3V1bv9oa1
         tETg==
X-Gm-Message-State: AOJu0YwGYpPtL+ioZrEo2JIbok1gd57Xb6Ed9tYnQGxI/19OpEtIZOz8
	NkXIjaW6eCFRiP3kEi2MOsEJUkEaJh5iijNmaxObSSYmjBctEAlCyQ66/xAaRA==
X-Gm-Gg: ASbGncvcOwQAyl8FUZ1Ue3njJ2fUbw1LL6x0Ze3n/KH7wGWDjsSNQyIMhlx37IWxJ/D
	havtr9iGLS5hYPhnK4xu2tyx7UVZjmqS273QJwAoXSXvO0R7TMsk9S/lau8eFRuf46Li+jyJwyd
	n31ZupvcfSJggC4buYxo2R/cNDZvs9JnbEPVVuf+lBWGgbLwgpg9TRBV1luIfXTrw76pqb7Qs1A
	ZCtoNO5mgePTMFXiUTEdDeHnzP5buhCwlJ9lOW7zDoH+/Nt8KyI/AkEm9d71M8IBo7BE2KQmJwG
	ccWwQfH3/S42EUvxfsIerlkTZyDlAjaJyXdicOgjg70sfTV/r0QpO6ywIRs3z1Kc6n8=
X-Google-Smtp-Source: AGHT+IEMfGbTdQxVyqg4K9dONyta2A/sCDFTdOKxH1irvcUKL9dIga6sfDmMM4EzbvuQN7FYFB/jhw==
X-Received: by 2002:a05:6870:2007:b0:296:5928:7a42 with SMTP id 586e51a60fabf-2b32f251707mr14087510fac.22.1738630016851;
        Mon, 03 Feb 2025 16:46:56 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:46:55 -0800 (PST)
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
Subject: [PATCH net-next v3 02/10] bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
Date: Mon,  3 Feb 2025 16:46:01 -0800
Message-ID: <20250204004609.1107078-3-michael.chan@broadcom.com>
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


