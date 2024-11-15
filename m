Return-Path: <netdev+bounces-145308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588E69CED27
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3EB2CD60
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA11D5141;
	Fri, 15 Nov 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FkzSPcxo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4A1D4612
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683776; cv=none; b=jYiwp9N3ik/PhBm9Qxma88r6Qfu1kAn0nfGVeztWNJQeLLkrGczshyMm+VA06kPaBIu2ehgZrUdn7Ww3UzfcIGOhqrafUjpFOGD6RqtZdMAKaCM+JnanOMnT4xMk79CHtu34WPg6fOETla0Mpf61El9SrfOV+Dx8MGk9sdRo5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683776; c=relaxed/simple;
	bh=K6azv/gUEk+LNaBzbEGDmcuM31V8G7nzvqMG559DQrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuPXQkqabHN5P2a0auteE0eil6pos9M+ZEPTX7bE7ujAwW9B60VUjZ4zp3lGxPjn2UvjD7azCQZryUxY16V7ZheqhY+/4rJXuSfuDttqDyTsazTQZ0AjFARg5xkKN0bC0kbEWjhcKu3uViNs+wDkk50zOYckyXo9VVcXiviW6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FkzSPcxo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cbcd71012so22594175ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683774; x=1732288574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfu+2Door3E60cOTpTDMi/S+ZGJkhWXzO6XCxkJTpVk=;
        b=FkzSPcxoKMeFf5qtGkR+cJ+spy1BSTk9wr5QWia4F+tCzEjfFvWFiqzR/JPHX+c/Qs
         RZwtSgPxAPmdsMCkD1iuBv6FqWGSIjowAxZqmpy8DgtgvIR9y+J8C+g6xTkTqUDZgDC3
         o8oCvF8Mh7wnV5mvLmsVnJ4tOwbmGppYp7lno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683774; x=1732288574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xfu+2Door3E60cOTpTDMi/S+ZGJkhWXzO6XCxkJTpVk=;
        b=LvxsUJ+TO4mxwTiG/StrLmRGfhFhoRSmfcAIBTFvAKEsxrQbnm1F/DpiFT/Rk2tt4R
         mfyYHa3t2pkfnEHRwPTAxcEnwpIxU/CGw9z3HQ9d1TXbzErUCURHpteKHqJ4R7+9oqZI
         IjalCNvHQJgo5Xo527d85w2EmfxrdAIGY08wpRPz7SFcOwWWoME3GptMDWNQiVUhZ42h
         Puk9rMic5+xV5zixt7wcqECiXJcEyv3Vkh0ZariGcTBUoXcMJZp1gWERe9H2FUiHAo6T
         XbNxRLSLNX5cD0Mw7ZOlRWfOtHnp9+wVET1zVETbv4Mv0ZW/qzFE6a1ZbLlHJVgRP+Ml
         m+7g==
X-Gm-Message-State: AOJu0Yysn5W16tQzpE8pjrO6KuD7lDpOkNk8Q82fcRx/h6CZcpUVW6es
	EcIs7Zqv8B/1rlN5aD6+AmHdHy/YKWKseJ09iP8R599kvdEUOhT1oorgN6M+NA==
X-Google-Smtp-Source: AGHT+IFMVOnBefiA+aj4L/7drAWzWkF5MikUlyy8M66ZnXcpkYHJoYWbhQlRYSUf65F2/8RFr5xTvA==
X-Received: by 2002:a17:903:2b0f:b0:20c:7a0b:74a3 with SMTP id d9443c01a7336-211d0d91360mr44731525ad.24.1731683773901;
        Fri, 15 Nov 2024 07:16:13 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:13 -0800 (PST)
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
Subject: [PATCH net-next v2 02/11] bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
Date: Fri, 15 Nov 2024 07:14:28 -0800
Message-ID: <20241115151438.550106-3-michael.chan@broadcom.com>
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
index 4c1302a8f72d..0143d976c5fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8684,6 +8684,8 @@ static int bnxt_setup_ctxm_pg_tbls(struct bnxt *bp,
 		rc = bnxt_alloc_ctx_pg_tbls(bp, &ctx_pg[i], mem_size, pg_lvl,
 					    ctxm->init_value ? ctxm : NULL);
 	}
+	if (!rc)
+		ctxm->mem_valid = 1;
 	return rc;
 }
 
@@ -8754,6 +8756,8 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	for (type = 0 ; type < BNXT_CTX_V2_MAX; type++) {
 		ctxm = &ctx->ctx_arr[type];
 
+		if (!ctxm->mem_valid)
+			continue;
 		rc = bnxt_hwrm_func_backing_store_cfg_v2(bp, ctxm, ctxm->last);
 		if (rc)
 			return rc;
@@ -8783,6 +8787,7 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 
 		kfree(ctx_pg);
 		ctxm->pg_info = NULL;
+		ctxm->mem_valid = 0;
 	}
 
 	ctx->flags &= ~BNXT_CTX_FLAG_INITED;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 649955fa3e37..d1fa58d83897 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1889,6 +1889,7 @@ struct bnxt_ctx_mem_type {
 	u32	max_entries;
 	u32	min_entries;
 	u8	last:1;
+	u8	mem_valid:1;
 	u8	split_entry_cnt;
 #define BNXT_MAX_SPLIT_ENTRY	4
 	union {
-- 
2.30.1


