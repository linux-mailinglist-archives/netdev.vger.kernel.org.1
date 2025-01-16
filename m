Return-Path: <netdev+bounces-159021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15AA14232
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDFF188A011
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E5230D0A;
	Thu, 16 Jan 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AxiaqZcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36B22FDF0
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055486; cv=none; b=rLn4TJSqZJa5QNeivPY+XlyK/blFRLv8iPaZhri29Hvky9WoceIhPeyii+qiKEo1RqxOi8yh5aIwBX+CstWZpC9qEFy4I2Or613CZlTtawJWHGCT2imHqpD9BquWWB9ZM1aeST5mp8xY1LzP6f6dqpYYM8/nMyb17hmwh7FbhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055486; c=relaxed/simple;
	bh=y7I+i7P7l4mNWcMSgdLVlm5+nLH+ASHvk9Y8ELeKyKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCl5ap+yZTB6JMVE98vKXap5syRUK7J0qhbQA83asU3NavtVQIjWLHBmkI99k/rz/SC+Noi8PeWBtmoWB3JbXRnXW2kBf854RkmEb+IjqcaEGpiTqbzSfZI4xy10Lf2+m5j8RWcD34TAtaQcx8humGoZvzeA4buPP/9pYgqWWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AxiaqZcx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso1882274a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055484; x=1737660284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsOeDS8H8oGmXwtsNUHQPoSENg34xWZ6ptN1qb2eDtE=;
        b=AxiaqZcxbZeq1xc4mM7pFPSpaioeuEhx6EnCv1JjGzO6IQXJt14xXwnTcngIKPwcA2
         +GJVlxeT4qU8DVOAT10LtVNUQywsxIOIZUGIwP8YOQr2eO5CRR8CGaqoN0i7CQIgwddk
         v5cg5xN+vDxYOesbc9bTdQ8jS7hv5CbkM8+mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055484; x=1737660284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsOeDS8H8oGmXwtsNUHQPoSENg34xWZ6ptN1qb2eDtE=;
        b=bSwV2LAsg4w12Cv+twkusmI9DXSsZXicp2u0cIVg1t9udbY4/Y0xs5ddLJc0Gbkpss
         15A/jh2+nUOxmeUeA2o5EmU5Bb01zyat647KTjrrORQeu7ACl7WRwppGBL/ibECGq2Iv
         Axkuw3ib4hM0FZwMsC+OZjlLg8F3ZNIOLycOoLJVBQZUYN40U10V5OW9aJOpPtePVPOE
         NjdamFIbjS9CVJG5jN0wqd5rk/7nRdLzycVT5hzsq5ul6Pa2UXUj573Fb47Cpfqh6lwv
         FPa+O/QyU5DelcREOCSJyHcoa5bPTZ3CfJ5QCy8Vgg+rukztIl2r+oW6KZHuffM7aUhI
         Rcpw==
X-Gm-Message-State: AOJu0Yx5kWE/+NqZY2argpg48/+7jOT26q6uQcyTaQfHJNvK4p/c8gbw
	qUt8GCyQ/bhWcdKqNB2JG2LP3fKgBJOXbbHnQ8rBKchoeu7TR/0QYiQHdcQQKg==
X-Gm-Gg: ASbGncscImZgnEwBHk89iIqhVUxaAuzspoV+8qPiE1RLYv8dtmaYi8/NivuEbyJnqYp
	hMgofINZpgyvcEkZ77F2oSCMdxBuJwbhJmcG/x3QgsaoH+BnyD0FQ/Xm7S0OBsgsCizSg1J//38
	XWkpS8k/OO2wLNgViMT56olL6WOtV/FC1mJ/HBI6Tb8diz2WixDzl04u1GMatqR48s/b/7pGcat
	iCeNIybkcMioV1koeTfqwoDDgK5PiEvbQEbEUoeq1uG7fSHsdTFfHw9A8hqbL3tlgZW5F5Ml/YE
	9IJgV7mzCDp3b2JapVMC70HDFsBcOHL5
X-Google-Smtp-Source: AGHT+IG477Gja0orUbj7Lbvs7GBX9k+flStyrYwzBrWszyoyYqsrQGt6ICwnrneQUnxGezlCnHuZ0A==
X-Received: by 2002:a17:90b:2dc3:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2f548eae0d7mr51345199a91.10.1737055483955;
        Thu, 16 Jan 2025 11:24:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:43 -0800 (PST)
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
Subject: [PATCH net-next v2 03/10] bnxt_en: Refactor TX ring allocation logic
Date: Thu, 16 Jan 2025 11:23:36 -0800
Message-ID: <20250116192343.34535-4-michael.chan@broadcom.com>
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
index 72fff9c10413..042d394c8235 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7196,6 +7196,20 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
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
@@ -7232,23 +7246,17 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
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


