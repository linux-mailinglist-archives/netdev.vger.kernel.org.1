Return-Path: <netdev+bounces-157601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADEA0AF64
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7397A0387
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04D232366;
	Mon, 13 Jan 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K9kjYbLF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB7231C9D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750413; cv=none; b=uPhuNFxljG3jsLJon4eV5g91QvJNk+vq5AbUrCsLdBQ4pNDvHTfXAin+E4RlKgPNuGQ8odUAMgLT/CgEzzKU5y6tKeYgcD8kXQWAqkxsM76nmCXs+ApRfK8yFqYob+QdLM9Ukou67NCeyr7d+p/J6+rEFimxw/KX8LGHzGALhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750413; c=relaxed/simple;
	bh=eUdmp/KPsiALefk+9mhYNve58+cZAnyd1eIrO/48gYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGcDwmdwj8QVJnuu2UGoEj5w84cGq2lVGHp6Nwq7wkZUn4Y+F6vSrQLi1aAvdA13ItWV/4+jvKZKF4hM5riZhBWGmruumU7WFwNNlT1KtPKxBl9KeHeszDR+Z/xLYWZe5h2nO7WXGXaSaewvadv0/mCSedTWRx/sFVS7fHhlUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K9kjYbLF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so67692275ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750411; x=1737355211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ms5zo6ZPdW4ymWmsGL4fzbsL1eE26sA6YU5s5fC1Lo=;
        b=K9kjYbLF0U/Fc2qxQnJRCW/zEb/zDByH36FiCVLXxYEUxKmRdZHoLdNArU7W1zCiJv
         QFxnVboirx8WoLT3QdYN/ikueMiimiJJd4oU+/j691XcoBjskcD0j70aXXwF91+LMpP1
         LVcWF9NWWwantt2aI8PStPntK6IxzzOb1fdSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750411; x=1737355211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ms5zo6ZPdW4ymWmsGL4fzbsL1eE26sA6YU5s5fC1Lo=;
        b=YxwkmS5HvNB9rMNObvXyCuUqhAQW9Ysvw3Cp44jAQmYKpyZD5DeatR2iW8CVo/cq/t
         QHbJPc/UlQlHkW3Ds+sFSlzn7W7U7T3mHu/iZ4S3EMPP6GzkK50daNZ29MtaXMb3gwNR
         +mNVt4HwR4lSCz+tKlyuO5ylZJMNs1eSkUXWsxqqVCLNcOe6sUGisPu6Oukm95M46STt
         Sojs4uxjaAnmhkMoxtiic07Rg36beZMPsi+RmwwpcAouBKRQaszlU5ixWO8S3UExfYgJ
         t9EjNgeyqBuI1oOlX8dWIhQgQe9MJMXmQ43t5UJyl7n7FTXGIu+I0ClDzsuQaLPBZ4qX
         dRvw==
X-Gm-Message-State: AOJu0Yy1AzXokcykTb3T8QCBqezqUVgpdaXffzDEmQLpnIjILb7okS6t
	ZmUK68qWoGnxUNOa3mjfEq/ngBNPVURqfcuaacpPzx0fjWpvLe7jwHt5bFG/qA==
X-Gm-Gg: ASbGnctRj82u1LBu29eL0ygXAG2z5rK7gqGA162q9V4b0aifVAO5TBCNbR3sA5fnD31
	we0tDNogXR4pMUxm9bcKsahRfKSMKAomzlBxYWIIWE3+55OSt27h1Z0cIQhyAdlF+Y5g28DyQA6
	kHnIg/T21EMqAoE6+nztC/dLuypr91qu+xB5ZpCTbqRsenle6hV3bHo995IPOEew08KzCgqHoyS
	3NvbR32xju3w9aOkf4E3qVl3iP9kDIP+6UI/339A1xVORThhGBkpZvV5XIEf9pd6ZJExhrMtEiy
	jsiovzwmYqwPb5KyvyS+2x58COLbSgpp
X-Google-Smtp-Source: AGHT+IHh694P97QPocB8y0Rcu+Ea1eTKhHRm9Px3euNWf8A93IS1uukmOlDjQ7BVclKkwlBbWTrg/A==
X-Received: by 2002:a17:902:c407:b0:215:44fe:163d with SMTP id d9443c01a7336-21ad9f7ebe1mr94178415ad.17.1736750410831;
        Sun, 12 Jan 2025 22:40:10 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:10 -0800 (PST)
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
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 03/10] bnxt_en: Refactor TX ring allocation logic
Date: Sun, 12 Jan 2025 22:39:20 -0800
Message-ID: <20250113063927.4017173-4-michael.chan@broadcom.com>
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

Add a new bnxt_hwrm_tx_ring_alloc() function to handle allocating
a transmit ring.  This will be useful later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d364a707664b..e9a2e30c1537 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7191,6 +7191,20 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	u32 type = HWRM_RING_ALLOC_TX;
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
@@ -7227,23 +7241,17 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
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


