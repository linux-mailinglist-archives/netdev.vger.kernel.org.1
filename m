Return-Path: <netdev+bounces-246414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48501CEB8D1
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 597D13004793
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44731197A;
	Wed, 31 Dec 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hl3QmaXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480E313E0A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767170238; cv=none; b=BTMbnSLmYefjT5Ba8Ho83St8GYyT4/3M9mlt9bs7ZXlSIjWW46+Tn7sjNO0VhlfDo/SXDdjvdWQz3Pk4cSrGPcd/Xn9kye1/xnyVx1r3j72VohKqkeh41mRYKFl1jRwknTgEtnn8MQ7soAZu4BUI4lq2b4Ze/h79iHHAMB8ZbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767170238; c=relaxed/simple;
	bh=VTT447L+ssvf2BCNaTy5dfqbbq7CazrhLECYMcQIQ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVPAcBdlDf6cVdNWSzMXpxWHHPY2Qrb5Er9SEBqylkLyotWJb1BAHE0OuQNa2lZ6kY6fUjw6tBPF6Jv2QwI74cQPnkhTNvz5IONBiWJfQwdc6t+eV6JTSDSw7w+MftTlX1rxs75ZTV5UCVEfxEtQVt6TBoIyH6N1ylRhpTRjsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hl3QmaXp; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3f11ad6e76fso8942615fac.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 00:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767170235; x=1767775035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76mIH5VsoNyP30FgFpGKTCg/KJTSgdU+xXj6oBGvPZg=;
        b=iMkfepx0rUs9yENmk4/jhW+frEKHffZVdLJO7eThomeSuQMTHP0yZiYW2NaVxirrbU
         OB8Sq7OKi3rfTbr/Wt6ox24yq4EQbffps/liSEV97OiP3CQuM5ZYdyBtFd/MPcr3cmcC
         m2TBPNP/8c3pNTeGimBqAr4Vv+Q5lM+9ftgUK/lKSxVG94RV3F8/3yxut/mAIBwFYaB+
         C5m7dWo6oLACFd4p1YSrCN8SimRkU5jYdbW3EqfRXM4yPwWD3l4RM4reTobzZVsTNJ3x
         GamgnOfAt69e4vGQiX/qoVdqi5to8dLxNnpJlxzOip4r3xMFnEr497pmBbFFhCWfS8bp
         wwbw==
X-Gm-Message-State: AOJu0YyjgMWjZ9JDM8INU5wcsuGJfQgF1EapuGccp6n/qtT0NiOzk4X1
	nJ4UgHk8PKk1Sq9dWrEpBgii4XX/M12XeoHJDNHydo+inb8yskNk8hCJaQigw4c/zGsko4b3L2r
	Cm5WyI+0raCcuBC08q1mz2KRVXuH0JNPuP2KE025ZcZCsLM50s+eQPp8PEDoQb9h4YNqvPzRmSw
	F7TSkIKK+zsIvTLVeBQYm1Ozkki5DNL1nCtvLRvI6UgfmEGRDguVNbL4A6KMmEh9KNqEwWICJzB
	ySnvqlm0ao=
X-Gm-Gg: AY/fxX4uqIE+ijfmzevz8i4vyRuakXRug5dt+YN7M6oFsIS2bIMl9mr1ixt7ZBh/8Ze
	u8Hg8SAYyOSchE6mPV6u1bjDS/gphFTwIe6YkAGpWSlKjf+ppXA98qDNgURccKxHE+PqLBwCWZr
	zN/XrbOC+cf8TVCEBk1t2fKIlieTxXWIcYBx3ri1OaWPz+6vbNZai/FxNR6WpT3jvHWUfmjVkvL
	PXeIxTXYC+5bvy61uv8KtXFLH1R+Z6qnt0N2rcqYd2NV/J6F4fapO2Gr+jV7aODLh7l/MXuWhgA
	rpGPcqMcvPFxTQi9m0FvZg3OqaoX3Ygp7Yf8+Z4QeELGwzU5HHhOmMK0Z+AcuP+W8sX0pGtCO9G
	nNJfvlHwO/nE21v3733Zkq2VJ3pkWXwAy9PfZ+v2HUpz8LKJTXSZ44pup22i9Ek5kSLs64D0wAn
	t+NTOjbeodle4aVtCQNH8QRNb6Lczrv/2owWAu06zBuWuszIM=
X-Google-Smtp-Source: AGHT+IGDPhByM40+b4GaOIRoNYmgPbb4eTtRLWcQJM09jCNF6zS0VICMHVQqEsoBqgpJSrpCYeSZ29YSJHt8
X-Received: by 2002:a05:6870:f201:b0:3ec:39fc:daac with SMTP id 586e51a60fabf-3fda541922amr16615782fac.48.1767170234751;
        Wed, 31 Dec 2025 00:37:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3fdaa93944esm3650735fac.6.2025.12.31.00.37.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2025 00:37:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88888397482so318958446d6.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 00:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767170233; x=1767775033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76mIH5VsoNyP30FgFpGKTCg/KJTSgdU+xXj6oBGvPZg=;
        b=hl3QmaXpWWlCNs209grdS4LR8va/5Q7jjzTfwqbMroQLC9ee4dQyEtUiB4wxVGZBOn
         OKcdm3fqtoqsq33vg8JFcIQysuYF353F0bZyVwjzAshJcV1L8R1A5BvJ60QgeHc5Kwxn
         WQx1DxvGVCLJYnR9wz5ykxlRXnvl48QTwsilM=
X-Received: by 2002:a05:620a:44c5:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c08fbc6b6dmr5679574185a.5.1767170232883;
        Wed, 31 Dec 2025 00:37:12 -0800 (PST)
X-Received: by 2002:a05:620a:44c5:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c08fbc6b6dmr5679573185a.5.1767170232529;
        Wed, 31 Dec 2025 00:37:12 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ed974sm2760651385a.30.2025.12.31.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 00:37:12 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	vadim.fedorenko@linux.dev,
	leon@kernel.org,
	Srijit Bose <srijit.bose@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH net v2] bnxt_en: Fix potential data corruption with HW GRO/LRO
Date: Wed, 31 Dec 2025 00:36:25 -0800
Message-ID: <20251231083625.3911652-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Srijit Bose <srijit.bose@broadcom.com>

Fix the max number of bits passed to find_first_zero_bit() in
bnxt_alloc_agg_idx().  We were incorrectly passing the number of
long words.  find_first_zero_bit() may fail to find a zero bit and
cause a wrong ID to be used.  If the wrong ID is already in use, this
can cause data corruption.  Sometimes an error like this can also be
seen:

bnxt_en 0000:83:00.0 enp131s0np0: TPA end agg_buf 2 != expected agg_bufs 1

Fix it by passing the correct number of bits MAX_TPA_P5.  Use
DECLARE_BITMAP() to more cleanly define the bitmap.  Add a sanity
check to warn if a bit cannot be found and reset the ring [MChan].

Fixes: ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for 57500 chips.")
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srijit Bose <srijit.bose@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 +---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..d160e54ac121 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1482,9 +1482,11 @@ static u16 bnxt_alloc_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
 	struct bnxt_tpa_idx_map *map = rxr->rx_tpa_idx_map;
 	u16 idx = agg_id & MAX_TPA_P5_MASK;
 
-	if (test_bit(idx, map->agg_idx_bmap))
-		idx = find_first_zero_bit(map->agg_idx_bmap,
-					  BNXT_AGG_IDX_BMAP_SIZE);
+	if (test_bit(idx, map->agg_idx_bmap)) {
+		idx = find_first_zero_bit(map->agg_idx_bmap, MAX_TPA_P5);
+		if (idx >= MAX_TPA_P5)
+			return INVALID_HW_RING_ID;
+	}
 	__set_bit(idx, map->agg_idx_bmap);
 	map->agg_id_tbl[agg_id] = idx;
 	return idx;
@@ -1548,6 +1550,13 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		agg_id = TPA_START_AGG_ID_P5(tpa_start);
 		agg_id = bnxt_alloc_agg_idx(rxr, agg_id);
+		if (unlikely(agg_id == INVALID_HW_RING_ID)) {
+			netdev_warn(bp->dev, "Unable to allocate agg ID for ring %d, agg 0x%x\n",
+				    rxr->bnapi->index,
+				    TPA_START_AGG_ID_P5(tpa_start));
+			bnxt_sched_reset_rxr(bp, rxr);
+			return;
+		}
 	} else {
 		agg_id = TPA_START_AGG_ID(tpa_start);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f5f07a7e6b29..f88e7769a838 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1080,11 +1080,9 @@ struct bnxt_tpa_info {
 	struct rx_agg_cmp	*agg_arr;
 };
 
-#define BNXT_AGG_IDX_BMAP_SIZE	(MAX_TPA_P5 / BITS_PER_LONG)
-
 struct bnxt_tpa_idx_map {
 	u16		agg_id_tbl[1024];
-	unsigned long	agg_idx_bmap[BNXT_AGG_IDX_BMAP_SIZE];
+	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA_P5);
 };
 
 struct bnxt_rx_ring_info {
-- 
2.51.0


