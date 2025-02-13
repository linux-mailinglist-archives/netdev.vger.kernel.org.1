Return-Path: <netdev+bounces-165751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37289A33472
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A2418890A0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00186323;
	Thu, 13 Feb 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X0YRHgGT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4213BAF1
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409215; cv=none; b=P8oRLCBF9cwUwhItnkoMzLl4UXm3kz1V1KcvOobrxzDcH6DqKOE7k7p9gbho8Bu6RPzwH4xkwLhelnccFlhSiLIkOChBp/0ala9ujFrynI9F+6kHcI7dIbZxuJhSCe983FoEuHJkAfQR7z+SNZfEq4r1n7rIC5P4MFQOniBtL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409215; c=relaxed/simple;
	bh=N4tPBq96MNEhuP9E/BsZZBcc9KAk6IUhpymzyYeQMxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC3Hosua+dXtkez8fbTjdbSN1b5ot0Kf7C7UA4uLwr2stTpV87DxNwsMrwbFgh4RVmMksJXYqOF+tp+pESgmuvqrRPPWVF9F5IDGiVVWV+rQnBrUAeeEQdla056uY0DewPt6cFLpljg6RC5MSe2SMgq5QnItj4ZuZ0yvLF3Ufjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X0YRHgGT; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-726f943b6f4so130045a34.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409210; x=1740014010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=X0YRHgGTLJN31hETlnG1AE1XjdCTITPaQEvP9JSxHjj4Jvl6hj0QAIzIxNqec0ELFR
         34GDQ99CjPjQur2gR4mVHLwbd1m1VIqODtgyRVmt6c56ByNhJfbd/GCfLVswXqiwR3PX
         RGuD+sAxDGvV6hvWnQWEoQBaYfTWoWzkqLmCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409210; x=1740014010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAnNmS1PpxNhoASBZ/NEPmOmzVWH3c4fcg+geDwoOGo=;
        b=h6+5rywojO8H9U/+o/LajdM1tGDNXfcsStLqrpyyLj0NMvUitQJN5R30109/Pr2nFp
         FC5SAqOJR5w3R/nlETl9nXZTQkdfxWUMpPSNx4lKFqiZHbE6VFFClgbtrSCRb0izLuwm
         op80gDM2nN6S91xCLOCgG262BKvb57T5ooE00NglhbhPtohiHALQQf6RvZquaRX6caBo
         00onMEQ8GvxDGzrXJXgkxWyNpw6sz12B7C9qpc8r4FzJnwa37YZHM/T4lJWO8zmk7ykV
         /nTJHJF4LMFdT5Z2aOSyjQSM5dVNiv7g3j4PWU7itb16YmSCdklZou7yYDa/lS9IWK5Y
         HKow==
X-Gm-Message-State: AOJu0YzPK59NLV0ajSC3/so8cnW4fgOhqIXkAYJarY2AlWQunLFzyJTD
	vIAB6RyEOiDf53VTgzsOoG2mBx2UKPgcV5EcWsdP+u3E6SQxyjA+Gp/VcXYH8w==
X-Gm-Gg: ASbGncsoKdYKRQvwLtmHVIHKe4gugWB1zvYmsOGpWprMpVDvBWVnuNlKMnvH0xA5eYH
	kjscC1DEkN6Zy6x+k3GYHJGoFbnfhEwuHbg7BGraJ+Pmv4GJUAA9cQ7mFXne7KHi6vyNDSYI7co
	QstDfdqBAB14SEv2hAr9Y3Q3pbw9dzyIEraICw+hXHeCB1lnkYNkkmpQz/l6VV9y4ge86gZWH+U
	p/TdsdjuQlLIJdkj4Y2Jxa4uSdoqVZthVV3BUhEkVTQ1CiStXY+lCnDTHtqY66gH3K5exrajLaa
	cBLDwitX3iJgOAu+KA3ArD4X9yxzaQFTFmet4GhAg7uGBp2qHp5Sx4Jm+PqdQwgckgQ=
X-Google-Smtp-Source: AGHT+IHOmzYRB3mHEOl2Yb2lOg3rtjKR5mQBbkRYGnYTmXjixbczwuwVoP2jtQ8Ib08grBd/0/1sag==
X-Received: by 2002:a05:6830:f8a:b0:718:7c3:f86a with SMTP id 46e09a7af769-726fe758cebmr857175a34.6.1739409209809;
        Wed, 12 Feb 2025 17:13:29 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:28 -0800 (PST)
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
Subject: [PATCH net-next v5 03/11] bnxt_en: Refactor TX ring allocation logic
Date: Wed, 12 Feb 2025 17:12:31 -0800
Message-ID: <20250213011240.1640031-4-michael.chan@broadcom.com>
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


