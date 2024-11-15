Return-Path: <netdev+bounces-145309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F249CED19
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67216284DDE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D66C1D4612;
	Fri, 15 Nov 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hoCriG00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE001CDA26
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683780; cv=none; b=GTX1bewP9wE1pv4XcBUu9ri6B/Ve5rm3aKhWuXbMdMG9pvp0Oyv9XBJiDTsYIH9OFIhv/bJbduxOC3ouJGPL2jfrUcVAS1lHlhb9ijSinmcUA+EILdqxNIAqMxsVGLcNusEiiMaCEBkNRFCC6Gy+nCbQTwPZLcyRZCGHBK1eSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683780; c=relaxed/simple;
	bh=PGdAVXzF077PK1LDR1ofJYhbRA268yf5SYdX8qiMAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2Q1XQe5ZtgmPbL3Mkg+WrsbNZBgCcSclyp4xCIKQvz1y69HtZs8uSzC20MrJwV7arB7f3zxSzf7ABL2xS1PQ8YZxj53m9fyRRTPdTIEK6vvZiqNus1kM3S/QBZE/SDkFYw+7h60FtCPBYQR62ZdAa9qwV97LjmCW8l9T6obCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hoCriG00; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so21517345ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683778; x=1732288578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s9Xhvc9cr4h6wYVteT9MWVAiDH+U7w7XJfPSMG1d9k=;
        b=hoCriG006wS1flkPexLDD3qmFT1tyEbxxww4eBmtGH8DWcKiblr2OqSqp96WOanEIi
         aMglc4wBJufDJVMhj3P5RJvS7jL1RBDOBZvWiMcfddWjHxYGCvqFQkK+8u6BSZVbWLT1
         vavOddWfvqf0zDs84Xt4lYWbW6IfUN/uUdP2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683778; x=1732288578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s9Xhvc9cr4h6wYVteT9MWVAiDH+U7w7XJfPSMG1d9k=;
        b=We3pEhfLC7TLKXXSYqK3N/DWhDRK5P9nxUcVkcXdK34CGLfZtAdQ3dTd2karmkNIZv
         9V5pLYwq2mSsFar+Q2+n1dz4vkOtOdUUYUqXSQiX7ir7/4u1UjzkuJsofRvSJBoZxhaG
         Y98ryXxbvOeVaDGuVp7VYyE5u9NxxPk+cpPtLoUJnAbPkublCeXZM0vuD1KbscrRez+f
         GDEXaStMkZ2U9Jnn/dFer/h/vqkxy9JUwFe0g4HApMUdhYfx1pSE45Hy5MW/GvmPQU93
         IS6Jo/TW7C0ZMWXBeTTUs7AVnWiGg1mscDMw1V+RLvMO60c/cPmUwzK0z5t3AZhrDzHB
         2u5g==
X-Gm-Message-State: AOJu0YxRVofiH5/4QNFB081JwbZMEx/E7HrWBfDArIATpUDdRRM3OH69
	YCx6dT1BDIFcvW9YIX0tX/PkIlGEzkTZU48WafnXQ/W46MFQXQ5rkR6kDgWGxg==
X-Google-Smtp-Source: AGHT+IEwWY24Wua/hanQ5g3Eb3SiJW9InhyOHrlQhKN6E8aafOl36Ms+5TYktOa8kR7f7kci26DE+A==
X-Received: by 2002:a17:902:c942:b0:20c:b0c7:92c9 with SMTP id d9443c01a7336-211d0d86584mr45283875ad.34.1731683775513;
        Fri, 15 Nov 2024 07:16:15 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:14 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com
Subject: [PATCH net-next v2 03/11] bnxt_en: Refactor bnxt_free_ctx_mem()
Date: Fri, 15 Nov 2024 07:14:29 -0800
Message-ID: <20241115151438.550106-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
References: <20241115151438.550106-1-michael.chan@broadcom.com>
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
index 0143d976c5fe..8c79b88c92b0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8765,21 +8765,14 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
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
@@ -8789,6 +8782,18 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
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


