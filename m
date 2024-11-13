Return-Path: <netdev+bounces-144316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2799C68CC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64764283372
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45431714CB;
	Wed, 13 Nov 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XGl5+cV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C91779B8
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476394; cv=none; b=HfavAJ8d9vk7vuZqG/GUZ89ZY91riVDBqLNoqiLSOwtNCJka58H2I+tekM1N6YjMXyWLW5R8AlBNGhuRww9x5DEK+CXtht60BDH/UpnkiFRpMsYYiR+SuhPt4SI41MnW0lOcRhFdbZ4w7p3yLSJqR3mq7QE1XRZHveM1xl1AucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476394; c=relaxed/simple;
	bh=QrVrqqiFIi+HITeUh6COc5uuG4XcV06aL8iXJ11kjJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUsLkf+ZjYm2jRHRHanG/f5tgghrrQwuqgZduBbUGbx1+OgZ/c95bjQuAF6A9E16HmClIlO6hJSZNjXBmrT01eg3FyAM9AtEX4KSl0BAbBl+18Fg3OqWFpgERkHvspdlXLdA0irpx8PfI41yu5Nm6XccUDFcgZCqjRlkJRhgSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XGl5+cV3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b15467f383so479754185a.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476392; x=1732081192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpK6tawyNfFPxJ7UEBnT9IfDOPtxuUeVMvq6VlFzOTQ=;
        b=XGl5+cV3n4l+AmsZzjM06wkntkogFj4Mi8nYB0PzCwFxtmtM6dbIdWylJ9lV5sR9mS
         HXBl89VQ8MjE+t2hk3qtHQQ0mLPMvbhUIljxkhh0/kPcvkROVOTjwRjWrF0KjQQRKBZ4
         Jqlbh9ASzziOrlyFF2ejeVXcP1VK5PvLZg8GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476392; x=1732081192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpK6tawyNfFPxJ7UEBnT9IfDOPtxuUeVMvq6VlFzOTQ=;
        b=VOoaQmcvwVR0lJUjACfz8F9wQ3gWuhzegxHbkFKPUJuh/FJRl+70XsV9z4ZXiH30Bf
         BlZy13FHbHNy2xZ59x0pd9kuTrFU4y/axOtcADtkNnr/ks3RaVPMyXLEOx5gi2BBDZVE
         nRmq3ZOqbPkLr/C0PepOqpYyFqYo8jVyjUOnFneCA4Bv8YuhuRlZDuCeazaTyLd164da
         +Coiq7zNwtajlb0DL1xfeAxyYvGZ2/noeKM54oJg7HcZF8v4gALNg7PvAyniWHIODn34
         2TGr8c+oN/kQvLhK7biD1UNFiuhdz+2Swj1EatMbnX9y4lQVX+AuGZUtfjpF37E5Q03M
         uKRA==
X-Gm-Message-State: AOJu0YxIjEn8Vb8dPLQwVdmSpNUfyuGkelPDK/VLZAvT/7J8KeTqQT6H
	Xai8omMdmruLcXk+mjQd1sGVmw/auRxho1L8SElQgg/RevlfmO4igMsP8GWsgg==
X-Google-Smtp-Source: AGHT+IGrx87nRk72Kvv3/t31jb6W5GPDLyDx1r9w17D6shuVlhg+NmkYV8VTuYJJxE6qFn1Oh0gYwQ==
X-Received: by 2002:a05:620a:46a1:b0:7b1:48ff:6b48 with SMTP id af79cd13be357-7b352857e84mr191558785a.14.1731476391683;
        Tue, 12 Nov 2024 21:39:51 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com
Subject: [PATCH net-next 03/11] bnxt_en: Refactor bnxt_free_ctx_mem()
Date: Tue, 12 Nov 2024 21:36:41 -0800
Message-ID: <20241113053649.405407-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241113053649.405407-1-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongguang Gao <hongguang.gao@broadcom.com>

Add a new function bnxt_free_one_ctx_mem() to free one context
memory type.  bnxt_free_ctx_mem() now calls the new function in
the loop to free each context memory type.  There is no change in
behavior.  Later patches will further make use of the new function.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 31 +++++++++++++----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2f445a4fbf37..2e4fcab98cc9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8763,21 +8763,14 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	return 0;
 }
 
-void bnxt_free_ctx_mem(struct bnxt *bp)
+static void bnxt_free_one_ctx_mem(struct bnxt *bp,
+				  struct bnxt_ctx_mem_type *ctxm)
 {
-	struct bnxt_ctx_mem_info *ctx = bp->ctx;
-	u16 type;
-
-	if (!ctx)
-		return;
-
-	for (type = 0; type < BNXT_CTX_V2_MAX; type++) {
-		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
-		struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
-		int i, n = 1;
+	struct bnxt_ctx_pg_info *ctx_pg;
+	int i, n = 1;
 
-		if (!ctx_pg)
-			continue;
+	ctx_pg = ctxm->pg_info;
+	if (ctx_pg) {
 		if (ctxm->instance_bmap)
 			n = hweight32(ctxm->instance_bmap);
 		for (i = 0; i < n; i++)
@@ -8787,6 +8780,18 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 		ctxm->pg_info = NULL;
 		ctxm->mem_valid = 0;
 	}
+}
+
+void bnxt_free_ctx_mem(struct bnxt *bp)
+{
+	struct bnxt_ctx_mem_info *ctx = bp->ctx;
+	u16 type;
+
+	if (!ctx)
+		return;
+
+	for (type = 0; type < BNXT_CTX_V2_MAX; type++)
+		bnxt_free_one_ctx_mem(bp, &ctx->ctx_arr[type]);
 
 	ctx->flags &= ~BNXT_CTX_FLAG_INITED;
 	kfree(ctx);
-- 
2.30.1


