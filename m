Return-Path: <netdev+bounces-164367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE56A2D89B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE8518889AA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467721F3BAD;
	Sat,  8 Feb 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1ti5P0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A881F3B91
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046602; cv=none; b=ooh+7xuu6RAVKQdsFsyFAJvwn0PEN5abD4A3LKOfZ1QRJ8hwI8j+m68T7+38H0yku1FurF+Jh5NiwFm69ed8IuJ8ILOh2Lu3LoLY7LiYGsHwgb5zoFwzrLelpVXl6Acvwk15n7BCRLYAVKj1gbBMk+VbjHQMTZ0OJ28Uht1tYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046602; c=relaxed/simple;
	bh=798C9bVl/2f9vmMwMenfvnnbRYCzOvXYML/rPtxBmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6s7uS7b3m0kM4v6XrhKILaa8RQUSaR5zmz1Hpn/ptQhWmVHi/SxdGtBeim8GL5KmEQ5sBQ+HW1C+dCXvKBipuAe+sdSqYufzBbdKXF3LXQEZHiPBgbJfeaLpwv4IVxG9lCrgFoLwYKcYYcYRZ3LH1bcavZ62X3FFrBqVB8JPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S1ti5P0o; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e3005916aso998795a34.2
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046599; x=1739651399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=S1ti5P0oUIBnj0uu+ErJho5Ey+7Pm9QxZ01OoVQLCdhRlSsB4ob35WInPfAxh7Hczx
         sOJRrZsCjSBHs9tlkGkNB74pnl1LXU/x3ShCbO789ZuwGScHWGYjxBQ5sqnO3OuSgPoD
         TnKeWpJl2op2Xd3fcsHLPCZyYrYRY5nEPqumg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046599; x=1739651399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGlMPNT2LmAYPrCmYwn48Iozoi1TKQ77bAj5ygSrkAE=;
        b=u54fEIcg/CBe092jdvUDhesDBemVDxmXEW3BBrA/sMJqCynrqvB0bwdxChVK3vbuqL
         NbbA6I79T+WqTqMplMfARO91rAbx7CtLTiNDz5MBCYxGerVXIOMVfstuEnvdPAoKWcyW
         2LqTC8W3r5umyCkImOchavb9pJgMEgvu2gVJelMobhhxBNpt3Z4aX7jCzdcaGP6d4mNo
         KsfX9HFjqgVaLHOfomYoP80JxpAzTQvW6LtQKoM3Yz9jVqJ4PafUiDZxvcMQNHRhrZcc
         UhVPe9BV0PFuk+PfyBoWiXFCoRcFNt5w+au4r+HIGkVy8j7I3IpIlYzqvdxRqMaPDsBf
         S5+A==
X-Gm-Message-State: AOJu0YwmGJS57XUXFpXoEymacnHM7OvUESGUet63hpRI0XJYXXjYteEl
	sr8kyRzoo1WSL8E2K9QBZEX6NOV2PcTR12ZJwHRSDjI59gPjA3EHq08Ry8Plww==
X-Gm-Gg: ASbGnctIXKkWXYZY2fSc8z6v4k6NohbTsYkOaIyBOE8GVi9DS0259T3MAdUSpoMk6zb
	epgsQ2NCfAveVadtVH12rPy2O9JiJPbLo+fGSPtdW51RHHC2S1oyYoMXjrYrCFOxZtDot2+KbCX
	lnacTvLigK+zAAmq5/kTurOGM3QqmE6VQaLlD2wjN1J1uFRuoTJEkI7rehUIZJGmmSQN9i5n7Xy
	BdsxhdUSuSxpi4URwDke1FZHuUAEETd0BGkCwtNcSCQq20Fl1K9r5W6dtBsUF0CVf9LZfOG5Y4k
	fBkzLlCGxSwTYF7ELU5fhYhzKYoxA9sjxkjH8xuR3wOv+fGQNhmjpUHZsWBKt3D2qXc=
X-Google-Smtp-Source: AGHT+IE4NfZA6NAcqoYne0N/GcL1VPzwYZRaYjvta96lgXxQI6aIMEsHK4zYElH2emNlaXbx/uhDhg==
X-Received: by 2002:a05:6830:374a:b0:71d:5f7d:148e with SMTP id 46e09a7af769-726b881a901mr6102354a34.8.1739046599652;
        Sat, 08 Feb 2025 12:29:59 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:29:58 -0800 (PST)
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
Subject: [PATCH net-next v4 02/10] bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
Date: Sat,  8 Feb 2025 12:29:08 -0800
Message-ID: <20250208202916.1391614-3-michael.chan@broadcom.com>
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


