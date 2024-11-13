Return-Path: <netdev+bounces-144315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75089C68CB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42750283961
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA9178CF6;
	Wed, 13 Nov 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eM6mXR3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22F1779B8
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476391; cv=none; b=oqrG9dYXJdxzG/Q75RODWJaHLMG/qzeoZT7oPLWDB72YCN/a8W0iCD3gd7VrOZWdsbUtyMNh0I7Up0k5bZ5eIzF8UoMgsUAyKUMDflPS4v7gmYjW1o+HiZvDHj+krjB006mWpOQR5oroC89XkVIYmV5BPsrLtXjBXQmzpVt1j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476391; c=relaxed/simple;
	bh=Mfxdu810+ZHtuoXPRwjAxLBtNkLV29y25SiqxwaH3Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKdbx2XxDSN9r061OvmjdwnG6SlMA5HoCpOGhl7tUp3FuDY8C/kJUJUusPpd6isZTQFuaxSMxwD4ize5sEwoZDaiVvrPJKZWEIoUV3nZ19LjDdhLrwbi717cKOUiU7MeYsPHGGDUjn77J+ZAsnIGFc5ovTQEmxl/d6tWjYdR5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eM6mXR3d; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b16d4534so37606411cf.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476389; x=1732081189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/7gB0EjK+9LEfVmnbN+u4TQmR2vQ5qEM/cTVzYOw8M=;
        b=eM6mXR3dSfNnhJUbhY7XWLwglUaH43gJcgH5odI4cqghiKX+gL9tkKf2uNHFvxAvOp
         Ljf78Db1+vaM5a6vlrlSVQQOL+yfq/GgHQMDRqtGwKjht/fB2NUqLKYPuUEmKptUPa4H
         Wy2uSsOCJwl9Syr8GbJQ8gfdhrf5jC4hdcUMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476389; x=1732081189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/7gB0EjK+9LEfVmnbN+u4TQmR2vQ5qEM/cTVzYOw8M=;
        b=ZI8/lFeHapsoe22wHc7gdDsoXXVgyM4mBeza3SxDcJfeCpu+CEYxTE7JnKFWC7bq/z
         oet6mK04IJ0TAYcvPaaARsgogzZNQqwlznH1Q3pKUUh0O655SXdDD3DzAVscAu6GKF+y
         8YP25OUzjnh80nQ5PoXtbHvxPgtdYqySrC87db4b+M/AkBFXMwDQRwQ9wyUOkJ4VAJ1L
         9J5d14mbYnI2aM370IQEab0DShOfvK/xaFDwid41sQd33sDepfohyWI7pwqXoa5sk7s9
         RjWlzaCh5W7Nbc7VRxVK7uUvWwkQLZYAlen/3A5ymqgrZxmDUidUK7QGEifI1E3Gn/0M
         P+Mg==
X-Gm-Message-State: AOJu0YwkBAvuO9ZA2lgaGQMUJ8x3hJa8ZIOaNiSMGqRhuHhSqjKHnhn+
	P8UZynco8cmbwOvUMZ6sxFCtGiOKZxhvdCcNxZXjnVN7V7a7y3zMPrTFXfaUqg==
X-Google-Smtp-Source: AGHT+IHdYwXFCkZl5QwHUV+SWmDQfBXF5ciYpS0idqpTewOB1IqzSD4O9CAk8Kj6uEVSQOT5r/QcCA==
X-Received: by 2002:a05:622a:1350:b0:460:bba4:1efd with SMTP id d75a77b69052e-463093f20a3mr298846651cf.35.1731476388777;
        Tue, 12 Nov 2024 21:39:48 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:47 -0800 (PST)
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
Subject: [PATCH net-next 02/11] bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
Date: Tue, 12 Nov 2024 21:36:40 -0800
Message-ID: <20241113053649.405407-3-michael.chan@broadcom.com>
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

From: Shruti Parab <shruti.parab@broadcom.com>

Add a new bit to struct bnxt_ctx_mem_type to indicate that host
memory has been successfully allocated for this context memory type.
In the next patches, we'll be adding some additional context memory
types for FW debugging/logging.  If memory cannot be allocated for
any of these new types, we will not abort and the cleared mem_valid
bit will indicate to skip configuring the memory type.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-of-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e9aab2e2840e..2f445a4fbf37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8682,6 +8682,8 @@ static int bnxt_setup_ctxm_pg_tbls(struct bnxt *bp,
 		rc = bnxt_alloc_ctx_pg_tbls(bp, &ctx_pg[i], mem_size, pg_lvl,
 					    ctxm->init_value ? ctxm : NULL);
 	}
+	if (!rc)
+		ctxm->mem_valid = 1;
 	return rc;
 }
 
@@ -8752,6 +8754,8 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	for (type = 0 ; type < BNXT_CTX_V2_MAX; type++) {
 		ctxm = &ctx->ctx_arr[type];
 
+		if (!ctxm->mem_valid)
+			continue;
 		rc = bnxt_hwrm_func_backing_store_cfg_v2(bp, ctxm, ctxm->last);
 		if (rc)
 			return rc;
@@ -8781,6 +8785,7 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 
 		kfree(ctx_pg);
 		ctxm->pg_info = NULL;
+		ctxm->mem_valid = 0;
 	}
 
 	ctx->flags &= ~BNXT_CTX_FLAG_INITED;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 69231e85140b..5b921c57a9f8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1888,6 +1888,7 @@ struct bnxt_ctx_mem_type {
 	u32	max_entries;
 	u32	min_entries;
 	u8	last:1;
+	u8	mem_valid:1;
 	u8	split_entry_cnt;
 #define BNXT_MAX_SPLIT_ENTRY	4
 	union {
-- 
2.30.1


