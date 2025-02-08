Return-Path: <netdev+bounces-164368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2889A2D89C
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E61166A47
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DEF1F3BBE;
	Sat,  8 Feb 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SmbL2bA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260C1F3BAF
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046604; cv=none; b=TyenBwVz87V23cAEWPe7DvQr5uNLALd6REd8olJnaMy3NoRQgGB9nUzEnoJR5q18M3w6AUyV/6G6N8Bt/Fn66BLQCoT4aMizs3/MGh2D8/aVEcnd1CkogeY00aJTUckjCvjNf+9CiHMT8A41CFI9iULa8Tqx5Nv3X/OSrk5QCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046604; c=relaxed/simple;
	bh=N4tPBq96MNEhuP9E/BsZZBcc9KAk6IUhpymzyYeQMxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQNinoBlGhvsdzEZkMkspZkzyo8Rvk6kaEzI7OT+HupMLXAzwXpq53mVpbxEi+rNyERP1c1bVKDHTzZLzWS8IFU8vu7UzzjFqGTbEVbxbYKKDF5IG5WfDzRbq7p2npZVJNC2Lo3k9rxbWN5f7vs/Bv6+PSCGh12Kxux7Pt7QprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SmbL2bA8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71deb3745easo906350a34.3
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046601; x=1739651401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=SmbL2bA87dBD6OUAYW5NXqc0koxaYH6PJA7ARJdbyGIz6uY6g8qv4+gd2DvkT1sffh
         rxhjRndgnshCVmPD5qPIrwCMUCuB92YSoHm00eBy2m4VM92p1WAoEWjgsMcfHE4ab1A7
         GH6YgJC2cw3jRp5fAkXTRPGhBDysdlwg9Zdo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046601; x=1739651401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=JTQFPREq3va3tWhdGDJUm6QgeWb1oWOyTvNM3qsB9jA8nXM+j4pQyOz8gFXA4RXh6e
         Be/pKb3OUiC7AwSeVw29XkzUTDFz4wDwq3qO7iqNRiJjRMja8oziZgw/5g8pa0r9kyM9
         RZ4DALTSVYN+hD8y8dBoC3jSgQM0bAZeQQ4HvE+TPuzuQeAsJnC9KA5bApvaIgatYkUO
         aZVo2Ys0Y4zS2A39Zn1y0IRBB1AYXC2/JZcFD40aRc3SERwogZrPQWwBf1Quh5QLpWzG
         qz8jLPRRCJFk+lCNDU5psTVWEuI/c05oJtYDCh/WoWXsps5tws60pKB0ro3KUXB1ri+z
         H0fA==
X-Gm-Message-State: AOJu0YyKyJGHHsAXa3NxgGIuziuKb84SwbAfpf5cxE6g6y67JxxPGOXm
	jMPhT5cjsaEcvXn4zbINtIHqzppPQJp4gZKsXdPLfth85B0Hk+Ru4Jao+TEImA==
X-Gm-Gg: ASbGnctCbd7r/tbvUTX+5dLoHQ5xdZifHbPGUKTNgnosiKih6TEBU9koQxr20cCW7Wl
	A4pO5loaIqDUnLsIXJVy4RCG5W+cW8BLimCSaDY2465D3dMOdxKANZ9Bv6qXS60xatQUl/zQc+Z
	TbUqumJ2OpQ3jM8lLSLiC9EA/QMgZCxjUpJK+77UR7ul4IROfA+xAPbP5ahDglLzV1OBslLiWrb
	/kMzTzvcbIOzMpQlB9X0SCTkUDXLdxyAvqm/klxVirhJMWZC/+Py92igED6XtPXh8esU6bJWf9I
	JEAJQLIj4C9LhjB+12YTA45tuQDIhiCip1pe11b6zBkIpk1KdUn7S1lczgHy7cNPotA=
X-Google-Smtp-Source: AGHT+IFAr6BjcU2flKbUBUPzgkN39YLI6I4nRXX7BOOANpaZJhZbC5lWcOD6RaKh1UN6tgSKTmufGg==
X-Received: by 2002:a05:6830:2aa2:b0:71e:155:9bf with SMTP id 46e09a7af769-726b88ad3ffmr5281965a34.25.1739046601641;
        Sat, 08 Feb 2025 12:30:01 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:00 -0800 (PST)
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
Subject: [PATCH net-next v4 03/10] bnxt_en: Refactor TX ring allocation logic
Date: Sat,  8 Feb 2025 12:29:09 -0800
Message-ID: <20250208202916.1391614-4-michael.chan@broadcom.com>
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

Add a new bnxt_hwrm_tx_ring_alloc() function to handle allocating
a transmit ring.  This will be useful later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Use const for a variable
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0e16ea823fbd..8ab7345acb0a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7218,6 +7218,20 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	const u32 type = HWRM_RING_ALLOC_TX;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, tx_idx);
+	if (rc)
+		return rc;
+	bnxt_set_db(bp, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
+	return 0;
+}
+
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 {
 	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
@@ -7254,23 +7268,17 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		}
 	}
 
-	type = HWRM_RING_ALLOC_TX;
 	for (i = 0; i < bp->tx_nr_rings; i++) {
 		struct bnxt_tx_ring_info *txr = &bp->tx_ring[i];
-		struct bnxt_ring_struct *ring;
-		u32 map_idx;
 
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
 			if (rc)
 				goto err_out;
 		}
-		ring = &txr->tx_ring_struct;
-		map_idx = i;
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, i);
 		if (rc)
 			goto err_out;
-		bnxt_set_db(bp, &txr->tx_db, type, map_idx, ring->fw_ring_id);
 	}
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-- 
2.30.1


