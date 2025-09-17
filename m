Return-Path: <netdev+bounces-223845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1772BB7D8A8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414802A7E81
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712E30215A;
	Wed, 17 Sep 2025 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FfCT7O+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A822F39B3
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082167; cv=none; b=VN8PSDB6jCWZZD3h4AXZBFhmwtIQnG5PCdfE7aoiWIGmQiR+ZojXsPdgDoneVd6AW60HM6dz69o2cZ4VS3EPsLEqIzXnhRDqvbh1Fnp0GpTagf1bAx5PwPExPXfH1T+ZG5lWX9xVUOcl9fxNZpeCWf9XsdsaURz/07gdzMj2leQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082167; c=relaxed/simple;
	bh=5APQjpdOb3NMkBHAvKa+f7fSYBMf2TTMWDqj53wmYu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiAo2r8HjSJKY4DXpXd/nfodYSOcx/Kf8+z59SKR41KB0zw2DGXGIVti97dnkeeezgiyQ25yM2r6ZIVptgRaTlYowvTVECALB6AkLqlmIA0fXOn8F+eiFIqwtolKcnVifXPUb1YfeI200LGlW879RcQGhRybmy/S4nU4r0r0Ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FfCT7O+i; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-557a2ba1e65so4367094137.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082165; x=1758686965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WLs3dpaVe+j+GDCAi8ROM913OWVivqB2v4g9lpdynY=;
        b=hM8MwMbibGSAO1IngI1LeP2ziXqLIQDi7NDagXml8g3Ugld99OBNzSko+ZkGO1bzbe
         1T7uSyzuTtZ8uvmmsUkr43SZ6iRocyY3MpRjGrd0WxPx/8qEmEnf5WM/JysMw3B+JaLP
         07LvRXxZnb0uk6JHgX0FR2cm/yUyXWFaFk/lyufBFV+foRdIquS5OHviY+S6tR9Q7sX+
         xD5JGCGQhyKXeChGsYXGKZ4a5pU5FVCXAXJ71nJfVQ3EfCjbrAi95g1QYyAonHNR3Mz0
         q0+yR4kxsC43pEi3o6a8bGcYnYLnbs5jk0QsIy9fuLL7t+sZeVA241bWiBwS3fHfa/5z
         2X+g==
X-Gm-Message-State: AOJu0YwJenHpDD5EEfYWVjD3H5HuOCRny0YUMTbVAg1n+KTOk/kfOGF0
	1jymJX2u2fEnnMyBXuXraziyoec/BD+htIYxMOkDKa1MDz4p+3O9oQTcul7zjbrv4ZiqCmLITO/
	kNUP0uIpZi+NKrR6JGMlqb/Drk/DulRkTi8Su++tYey+O9pDEJzRhy4pDeseInJ7QQ90F39Ks9i
	nxiqMRj7FeyEEyCmBAScNWfqRwCRAYhpDu4NaCwFxUntZ/RbXbYNdrb5TmkpxnVixAFzZPAXJe2
	yXuyAIWr/A=
X-Gm-Gg: ASbGncvzNjJwg8vkFYFJAbDd77dvt+h4prtujZfpxBJtfnSoEn99q0nIy0v1I6ITBDq
	835kTvr3YERv1MKwOG91yTEaVTxAbEIdN+dcdt7lSnd/Pp4C9sm0a37+LcsEFcHyXUfoyRTEa9F
	Pr6IpW+EO1XpG+rkTGo9VV0wHr7ahcfTjzM5pFmruKQOXm+btwj9Wcyf5YqYYUC+J73qbqqPjY+
	1qHGcFo1avAWYX/AHi9IAXOOxDWaCz4++OrACAlk9aDLmI1tc9XBS6Z+wONalldfDSeyISMpmme
	6LQ5E8Iz/qaaoe8E4r4UNtjC5zCqBNIR6KbrFQmnyF7dbXhcq4mg1MZ8L8f2Le6fvn4B+dNLnFf
	XMYN4ebxfcU4mdYos+CbOTwLpv9JseLqmgVpslxiMm3YB2H00X0r3x+FhWRtk+LUkOUDlZxvf4Z
	ZnQA==
X-Google-Smtp-Source: AGHT+IGFW+9KkajVs0EoMoCP0jI7Gmcsnv9XGa1TcNABQTLTEP1Abj98Mwv0Ak/Yocz/49/7tKxdqS7porTE
X-Received: by 2002:a05:6102:3c83:b0:4fc:824d:1cba with SMTP id ada2fe7eead31-56d5385fbe0mr205554137.12.1758082165364;
        Tue, 16 Sep 2025 21:09:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-557f9d4b892sm1039503137.5.2025.09.16.21.09.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so5559671a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082163; x=1758686963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WLs3dpaVe+j+GDCAi8ROM913OWVivqB2v4g9lpdynY=;
        b=FfCT7O+i21X4/DKFJB1W1pmaC5b3oOamP2O+2gMYM0d+6qWQD4YQTrG11iz32qHbCi
         PE5quXdsP3+vtQt3oTlloROTmqtHGMnEHrIR7r/KtzWfMaL7OUGQmVZLGX4zpUX217Zx
         HJLK2jnSETkGIKDTHGc0lYL5NUq4S/mkjFWMk=
X-Received: by 2002:a17:90b:4c90:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-32ee3e91b7amr909209a91.13.1758082163588;
        Tue, 16 Sep 2025 21:09:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4c90:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-32ee3e91b7amr909193a91.13.1758082163232;
        Tue, 16 Sep 2025 21:09:23 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:22 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/10] bnxt_en: Improve bnxt_backing_store_cfg_v2()
Date: Tue, 16 Sep 2025 21:08:33 -0700
Message-ID: <20250917040839.1924698-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
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
index a74b50130cc0..b4732276f0ca 100644
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


