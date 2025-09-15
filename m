Return-Path: <netdev+bounces-222905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F347AB56EAC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC10189BC23
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1222A1E1;
	Mon, 15 Sep 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d0vffSiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD42264CE
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905558; cv=none; b=UEp/QJ1Q2G2IOybOcwuPvtMrdQ40IX0tbioKWZ1ChJudkzJ6t+AjjI1s82KEFGa615XksKMtlgv7r+PRM28+N/e8cbjrNFrkzfR36viLYxEW0hjmYkEk9u2h9ppflLH8sfzIOFpfsIWarjk6tiv0thx/mZdxNJP6e7n/untTnpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905558; c=relaxed/simple;
	bh=6pe7KPKVibGPKi/1WEGrWmRtrl0vZj9a9PUs+ZRoWjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmI0qz9NiUUdWzu2GieMoJFQuNgRNZylqBtCmdOlZShMYlJ7O5Ff++lYZD5NicupHhZkY9gXrj3AMVrb+/RzSszgmNIrVX05F920wH6cDYKvRPBix/dzgE0Unk8/Z7AiEMkdjcXuLfzDOYXAy2rU6Uo4Ih78Ymukw1ZwRTP+sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d0vffSiD; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-88758c2a133so351196039f.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905556; x=1758510356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIsE9rFxRBUecsymabyKGtPnjA3lvbGtBhowECHc0hM=;
        b=AiyuqUXYOLKRM90lTENnQjDzSnyjo+cWLvoDXEWcLi87nvAlD4X060ZOHYBRK4rUCU
         HT3D1xLnXEnIeJly0ZqwGCoKAYEKzIS18ujSIjyPpDLXMn1//J8rMe57OOQvRy5E/hjP
         IP+oIvLcK3vY8jkXqsoayA3ptg47hB/JnxUP6SkwPObxqj5olCeZra4BnxZ1ut74FLTe
         Im0zsuYOKuRuS3Dzmreb7z9W4hlAxTIsM773P1w6+JOZTj6ye6jVXnv/62nMfl8DborK
         QXYyqr+emKC722SzVYwyCXznylMDRIrqDKeDSMv450oBiw7UKjC4EjjeBICdkEfSiQ/c
         MdUw==
X-Gm-Message-State: AOJu0Yyrjm6Zm7gNtFCNQb0qzor3XfQph4bIlPMXu9tcHGR/4eHOBClX
	7w2+o6ejroL+/8XgMUosIBTHluNg7N3666CruNk91o9V1utCdWk9NRwcRcXg6hV2ZVoUrlkMsQN
	k5hvSAnoI42yJyGdZQCJJMnao8hUpvrug3suJnSaziXieKNw8s0lWdG1MyGGfTTSU+kvI6h8GUp
	/LBNeuqbYCy+5buXDd5W79suer0wxlftgM9VkWzACMHm7olBybarBkl7AKjCExOVCVXvFMhzw10
	KUBmh5kMU4=
X-Gm-Gg: ASbGnctwiGMD6SYxSRsgEzwBOYEKm2+g0hw2OZU2U4yJNQO4qKcVUZJAkJSBEyTW+uq
	QOmNAFIDqHOt9Qd6vb9cbSXGUXQ0G8wHwNJytGdKPAurTxyfKpp0OmAd37ZXetPPJ8tNVog4MT6
	znPs5qIiumaldT61v5S5RN/dIyl+MU4vv1MYEU13IMJ3RU234CeK4XHMcmLrKMw8GuVBHuhcdbZ
	nlYdJhOLwNS7N4IDyjnUFlW63oK10r4oCcV9Yv1R1i/fAbqWnrL4fiFQ4C5CbLUA00sjgrfduCE
	Eyajw6QZ4C8nHrXUkSZBTLgByg0oz6bgel4qtGv+SJZ9phvllaE5gYTUleBNlg5DNdpwpkJ5DLJ
	a72AVERCbRzl61BWHb8siz2zCZ0sLxRkbt+3rPHXPUzuTIVGqMxt8VrWJURvTkf5Gv4hlobpe3s
	s=
X-Google-Smtp-Source: AGHT+IH1dgRIpYLG7gy58fAYZuKCZogNFre0l4iW1xxRwLJHipR/F9EsUS0AOW+eHAH66z7p7JBuBH8RnpCB
X-Received: by 2002:a05:6e02:5e84:b0:423:f9d1:e913 with SMTP id e9e14a558f8ab-423f9d1ea88mr45030395ab.31.1757905556205;
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5120f99ddbbsm497870173.33.2025.09.14.20.05.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2675d9ad876so3599135ad.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905554; x=1758510354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIsE9rFxRBUecsymabyKGtPnjA3lvbGtBhowECHc0hM=;
        b=d0vffSiDySDHBP7oAiWN+AfOPKw9+40MHJFyoDIjhczmgf4HUkXB6jVZoR5f5dhjyM
         PcWvGNyLzod9wzYYtCjXvMcIddIaNkkWLeWUWEXkeBHfT+G4Vk1YAKOzsBi7KcwyESTZ
         TVL5izpEDMdh2nHCRUapbRVUMDffCV4MfZ42E=
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr113436865ad.14.1757905554690;
        Sun, 14 Sep 2025 20:05:54 -0700 (PDT)
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr113436595ad.14.1757905554315;
        Sun, 14 Sep 2025 20:05:54 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next 05/11] bnxt_en: Improve bnxt_backing_store_cfg_v2()
Date: Sun, 14 Sep 2025 20:04:59 -0700
Message-ID: <20250915030505.1803478-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Improve the logic that determines the last_type in this function.
The different context memory types are configured in a loop.  The
last_type signals the last context memory type to be configured
which requires the ALL_DONE flag to be set for the FW.

The existing logic makes some assumptions that TIM is the last_type
when RDMA is enabled or FTQM is the last_type when only L2 is
enabled.  Improve it to just search for the last_type so that we
don't need to make these assumptions that won't necessary be true
for future devices.

Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 38a2884f7c78..09cc58288e67 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9150,7 +9150,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 	return rc;
 }
 
-static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
+static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9176,12 +9176,13 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	}
 
 	if (last_type == BNXT_CTX_INV) {
-		if (!ena)
+		for (type = 0; type < BNXT_CTX_MAX; type++) {
+			ctxm = &ctx->ctx_arr[type];
+			if (ctxm->mem_valid)
+				last_type = type;
+		}
+		if (last_type == BNXT_CTX_INV)
 			return 0;
-		else if (ena & FUNC_BACKING_STORE_CFG_REQ_ENABLES_TIM)
-			last_type = BNXT_CTX_MAX - 1;
-		else
-			last_type = BNXT_CTX_L2_MAX - 1;
 	}
 	ctx->ctx_arr[last_type].last = 1;
 
@@ -9411,7 +9412,7 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	ena |= FUNC_BACKING_STORE_CFG_REQ_DFLT_ENABLES;
 
 	if (bp->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
-		rc = bnxt_backing_store_cfg_v2(bp, ena);
+		rc = bnxt_backing_store_cfg_v2(bp);
 	else
 		rc = bnxt_hwrm_func_backing_store_cfg(bp, ena);
 	if (rc) {
-- 
2.51.0


