Return-Path: <netdev+bounces-198954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F330ADE6D4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9590417D1F0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1A283141;
	Wed, 18 Jun 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HPEFUCZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588762874E2
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238681; cv=none; b=HICFg3zCrbQKWY4CC6RLlqkqmG7hc9nfBICVZQ9OOk8Cmi2qsoVV3w6Po1yi1gJhi5G5cUy1F97iUg9k0Uph0BzXQQZjCuAG8wVEDgJao5gw6BcmyzOi+Zaz6qCVbEXu5fJ28OjEu1jTkp331dBvQycK4XA7KxquCrIjMLQhb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238681; c=relaxed/simple;
	bh=DzK9pKdBJNjDFJ1+nKcLzHNlipjY/5TIRi6NTkowD6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0uJ9XNc+hlxl7ZKHsS7J7Z58A+IQUaPZXvGx1bQ2QK/+CHc6YXdgmOYtOp6qIkSoI6WpOfwhdsTXrmDbEqAXX0AUBWg21N9aEy82v0e3KHf+1nL9VI6pREZU8Ctp0hl4XlUKr2iLg5yBrW7abRhk15Dzvya5dq5E1I/o6egLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HPEFUCZt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7950545a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238676; x=1750843476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELn5mg6f9FDwFcvop6rIHDsPXpqVBwxdEt1doKIqqWQ=;
        b=HPEFUCZtTCWxw1KLG9WXcWqXGL15UtqQOg+qIY0P+yX2rFsOA+6aGhcA7u87P0XfY/
         xW3q5lZgtNaTAT2GVXVpDFYdQ8RkugpYaVkNnQViXc9MPEfBWpEgFuMIZVY0vrb1FtOE
         UZWtXnaAt7OiZ8swiH8PSZW4Y9922azPR5rrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238676; x=1750843476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELn5mg6f9FDwFcvop6rIHDsPXpqVBwxdEt1doKIqqWQ=;
        b=xUCDOqFqzTgMyH5nfbdoyAcpzmqDjYcXv2dvkST9r5K+f+qdGtdZekI2E4ZTPAS8jz
         pkW5hUYl8YaV4KS0XRGXetO5owiVAeCu5gZISmVWGZVlEMCQmbRW02hNN5jvqBUVck3Y
         sBqJTqpkSfyDrcGqi9MA4AnbfpU2PthQ4sjnGQeRfv1qOMer6v1WMlN59iiWgqx+8Xvp
         9/crySU5P+5002FZSUiT+IfMCWKkB31zv34zPFGoQv9J+G+6CqxBTkdVPremmCcvLrAh
         Ud37Jf2+CA5/VoWpj8ihNUwX96RpBTRZq3i8BY+zEX+pj1O70AX4bY9PNP2LUtNubWlR
         7BdA==
X-Gm-Message-State: AOJu0YzsCQ53NO8B+E0HfHDE1BUKPNDqwpU4OFJvBHuStInagdehHYXf
	skECePzvGB29t7oChMa6Jnh5MxUnztnyg5+Mp5fxsZaoEy8pEcT1v+YZwqlJoBpxhDIInfE4p0b
	mRUQvOA==
X-Gm-Gg: ASbGncsmkmVxMGvPnvYdqpHGujSyVy7F7FPZF8iQTTdjeMu1Yt31yQkYcCcDtraRxeG
	fOkUngH87l9K3v4bfGAqqGI5mvI4jMeEKnRzZ64nCAWvwbA2sRSJr49IRXB/i0lV0UuP4iF2zrV
	xAqKtvVHAJ5L5YGRZ4zWkfAcc0lW9AjlqsAtlMgBbeUIvtV8DO/aG/7T2ePq3Nhjcz8rtMbo2Ij
	Viv4A+kzoZjzI9ntGiGEyu8nLK9XAqtoQEpuFkZn0mS7AKVE84wbhCyHFYnHiionKy9ABadKvrl
	Ga7Rgjc7As75fT1aFsUCrI/6E4tHnNkDLnUeJBV0iBAiN7wySmD2iUD/+k6OEj5NBBM2UyZj9ji
	oUyC4E/G2BLS0Q+X1xRDSKCcimFXh
X-Google-Smtp-Source: AGHT+IG39AVgw40fw00qxkJNzFi35tG12TrV1nYQL0gZ3YedV0JmL5qBgJynV5U7SgDGsqm2K23Hhg==
X-Received: by 2002:a05:6a21:158e:b0:21d:3918:3bdf with SMTP id adf61e73a8af0-21fbd4656a4mr25657043637.8.1750238676332;
        Wed, 18 Jun 2025 02:24:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:35 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, 03/10] bng_en: Add firmware communication mechanism
Date: Wed, 18 Jun 2025 14:47:33 +0000
Message-ID: <20250618144743.843815-4-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618144743.843815-1-vikas.gupta@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to communicate with the firmware.
Future patches will use these functions to send the
messages to the firmware.
Functions support allocating request/response buffers
to send a particular command. Each command has certain
timeout value to which the driver waits for response from
the firmware. In error case, commands may be either timed
out waiting on response from the firmware or may return
a specific error code.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  13 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    | 503 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    | 107 ++++
 4 files changed, 625 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index e021a14d2fa0..b296d7de56ce 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_BNGE) += bng_en.o
 
 bng_en-y := bnge_core.o \
-	    bnge_devlink.o
+	    bnge_devlink.o \
+	    bnge_hwrm.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 19d85aabab4e..8f2a562d9ae2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -13,6 +13,8 @@ enum board_idx {
 	BCM57708,
 };
 
+#define INVALID_HW_RING_ID      ((u16)-1)
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -22,6 +24,17 @@ struct bnge_dev {
 	char		board_serialno[BNGE_VPD_FLD_LEN];
 
 	void __iomem	*bar0;
+
+	/* HWRM members */
+	u16			hwrm_cmd_seq;
+	u16			hwrm_cmd_kong_seq;
+	struct dma_pool		*hwrm_dma_pool;
+	struct hlist_head	hwrm_pending_list;
+	u16			hwrm_max_req_len;
+	u16			hwrm_max_ext_req_len;
+	unsigned int		hwrm_cmd_timeout;
+	unsigned int		hwrm_cmd_max_timeout;
+	struct mutex		hwrm_cmd_lock;	/* serialize hwrm messages */
 };
 
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
new file mode 100644
index 000000000000..803a1951b736
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <asm/byteorder.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+
+#include "bnge.h"
+#include "bnge_hwrm.h"
+
+static u64 hwrm_calc_sentinel(struct bnge_hwrm_ctx *ctx, u16 req_type)
+{
+	return (((uintptr_t)ctx) + req_type) ^ BNGE_HWRM_SENTINEL;
+}
+
+int __hwrm_req_init(struct bnge_dev *bd, void **req, u16 req_type, u32 req_len)
+{
+	struct bnge_hwrm_ctx *ctx;
+	dma_addr_t dma_handle;
+	u8 *req_addr;
+
+	if (req_len > BNGE_HWRM_CTX_OFFSET)
+		return -E2BIG;
+
+	req_addr = dma_pool_alloc(bd->hwrm_dma_pool, GFP_KERNEL | __GFP_ZERO,
+				  &dma_handle);
+	if (!req_addr)
+		return -ENOMEM;
+
+	ctx = (struct bnge_hwrm_ctx *)(req_addr + BNGE_HWRM_CTX_OFFSET);
+	/* safety first, sentinel used to check for invalid requests */
+	ctx->sentinel = hwrm_calc_sentinel(ctx, req_type);
+	ctx->req_len = req_len;
+	ctx->req = (struct input *)req_addr;
+	ctx->resp = (struct output *)(req_addr + BNGE_HWRM_RESP_OFFSET);
+	ctx->dma_handle = dma_handle;
+	ctx->flags = 0; /* __GFP_ZERO, but be explicit regarding ownership */
+	ctx->timeout = bd->hwrm_cmd_timeout ?: DFLT_HWRM_CMD_TIMEOUT;
+	ctx->allocated = BNGE_HWRM_DMA_SIZE - BNGE_HWRM_CTX_OFFSET;
+	ctx->gfp = GFP_KERNEL;
+	ctx->slice_addr = NULL;
+
+	/* initialize common request fields */
+	ctx->req->req_type = cpu_to_le16(req_type);
+	ctx->req->resp_addr = cpu_to_le64(dma_handle + BNGE_HWRM_RESP_OFFSET);
+	ctx->req->cmpl_ring = cpu_to_le16(BNGE_HWRM_NO_CMPL_RING);
+	ctx->req->target_id = cpu_to_le16(BNGE_HWRM_TARGET);
+	*req = ctx->req;
+
+	return 0;
+}
+
+static struct bnge_hwrm_ctx *__hwrm_ctx(struct bnge_dev *bd, u8 *req_addr)
+{
+	void *ctx_addr = req_addr + BNGE_HWRM_CTX_OFFSET;
+	struct input *req = (struct input *)req_addr;
+	struct bnge_hwrm_ctx *ctx = ctx_addr;
+	u64 sentinel;
+
+	if (!req) {
+		dev_err(bd->dev, "null HWRM request");
+		dump_stack();
+		return NULL;
+	}
+
+	/* HWRM API has no type safety, verify sentinel to validate address */
+	sentinel = hwrm_calc_sentinel(ctx, le16_to_cpu(req->req_type));
+	if (ctx->sentinel != sentinel) {
+		dev_err(bd->dev, "HWRM sentinel mismatch, req_type = %u\n",
+			(u32)le16_to_cpu(req->req_type));
+		dump_stack();
+		return NULL;
+	}
+
+	return ctx;
+}
+
+void hwrm_req_timeout(struct bnge_dev *bd, void *req, unsigned int timeout)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+
+	if (ctx)
+		ctx->timeout = timeout;
+}
+
+void hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t gfp)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+
+	if (ctx)
+		ctx->gfp = gfp;
+}
+
+void hwrm_req_flags(struct bnge_dev *bd, void *req,
+		    enum bnge_hwrm_ctx_flags flags)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+
+	if (ctx)
+		ctx->flags |= (flags & HWRM_API_FLAGS);
+}
+
+void *hwrm_req_hold(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+	struct input *input = (struct input *)req;
+
+	if (!ctx)
+		return NULL;
+
+	if (ctx->flags & BNGE_HWRM_INTERNAL_CTX_OWNED) {
+		dev_err(bd->dev, "HWRM context already owned, req_type = %u\n",
+			(u32)le16_to_cpu(input->req_type));
+		dump_stack();
+		return NULL;
+	}
+
+	ctx->flags |= BNGE_HWRM_INTERNAL_CTX_OWNED;
+	return ((u8 *)req) + BNGE_HWRM_RESP_OFFSET;
+}
+
+static void __hwrm_ctx_drop(struct bnge_dev *bd, struct bnge_hwrm_ctx *ctx)
+{
+	void *addr = ((u8 *)ctx) - BNGE_HWRM_CTX_OFFSET;
+	dma_addr_t dma_handle = ctx->dma_handle; /* save before invalidate */
+
+	/* unmap any auxiliary DMA slice */
+	if (ctx->slice_addr)
+		dma_free_coherent(bd->dev, ctx->slice_size,
+				  ctx->slice_addr, ctx->slice_handle);
+
+	/* invalidate, ensure ownership, sentinel and dma_handle are cleared */
+	memset(ctx, 0, sizeof(struct bnge_hwrm_ctx));
+
+	/* return the buffer to the DMA pool */
+	if (dma_handle)
+		dma_pool_free(bd->hwrm_dma_pool, addr, dma_handle);
+}
+
+void hwrm_req_drop(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+
+	if (ctx)
+		__hwrm_ctx_drop(bd, ctx);
+}
+
+static int __hwrm_to_stderr(u32 hwrm_err)
+{
+	switch (hwrm_err) {
+	case HWRM_ERR_CODE_SUCCESS:
+		return 0;
+	case HWRM_ERR_CODE_RESOURCE_LOCKED:
+		return -EROFS;
+	case HWRM_ERR_CODE_RESOURCE_ACCESS_DENIED:
+		return -EACCES;
+	case HWRM_ERR_CODE_RESOURCE_ALLOC_ERROR:
+		return -ENOSPC;
+	case HWRM_ERR_CODE_INVALID_PARAMS:
+	case HWRM_ERR_CODE_INVALID_FLAGS:
+	case HWRM_ERR_CODE_INVALID_ENABLES:
+	case HWRM_ERR_CODE_UNSUPPORTED_TLV:
+	case HWRM_ERR_CODE_UNSUPPORTED_OPTION_ERR:
+		return -EINVAL;
+	case HWRM_ERR_CODE_NO_BUFFER:
+		return -ENOMEM;
+	case HWRM_ERR_CODE_HOT_RESET_PROGRESS:
+	case HWRM_ERR_CODE_BUSY:
+		return -EAGAIN;
+	case HWRM_ERR_CODE_CMD_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case HWRM_ERR_CODE_PF_UNAVAILABLE:
+		return -ENODEV;
+	default:
+		return -EIO;
+	}
+}
+
+static struct bnge_hwrm_wait_token *
+__hwrm_acquire_token(struct bnge_dev *bd, enum bnge_hwrm_chnl dst)
+{
+	struct bnge_hwrm_wait_token *token;
+
+	token = kzalloc(sizeof(*token), GFP_KERNEL);
+	if (!token)
+		return NULL;
+
+	mutex_lock(&bd->hwrm_cmd_lock);
+
+	token->dst = dst;
+	token->state = BNGE_HWRM_PENDING;
+	if (dst == BNGE_HWRM_CHNL_CHIMP) {
+		token->seq_id = bd->hwrm_cmd_seq++;
+		hlist_add_head_rcu(&token->node, &bd->hwrm_pending_list);
+	} else {
+		token->seq_id = bd->hwrm_cmd_kong_seq++;
+	}
+
+	return token;
+}
+
+static void
+__hwrm_release_token(struct bnge_dev *bd, struct bnge_hwrm_wait_token *token)
+{
+	if (token->dst == BNGE_HWRM_CHNL_CHIMP) {
+		hlist_del_rcu(&token->node);
+		kfree_rcu(token, rcu);
+	} else {
+		kfree(token);
+	}
+	mutex_unlock(&bd->hwrm_cmd_lock);
+}
+
+static void hwrm_req_dbg(struct bnge_dev *bd, struct input *req)
+{
+	u32 ring = le16_to_cpu(req->cmpl_ring);
+	u32 type = le16_to_cpu(req->req_type);
+	u32 tgt = le16_to_cpu(req->target_id);
+	u32 seq = le16_to_cpu(req->seq_id);
+	char opt[32] = "\n";
+
+	if (unlikely(ring != (u16)BNGE_HWRM_NO_CMPL_RING))
+		snprintf(opt, 16, " ring %d\n", ring);
+
+	if (unlikely(tgt != BNGE_HWRM_TARGET))
+		snprintf(opt + strlen(opt) - 1, 16, " tgt 0x%x\n", tgt);
+
+	dev_dbg(bd->dev, "sent hwrm req_type 0x%x seq id 0x%x%s",
+		type, seq, opt);
+}
+
+#define hwrm_err(bd, ctx, fmt, ...)				       \
+	do {							       \
+		if ((ctx)->flags & BNGE_HWRM_CTX_SILENT)	       \
+			dev_dbg((bd)->dev, fmt, __VA_ARGS__);       \
+		else						       \
+			dev_err((bd)->dev, fmt, __VA_ARGS__);       \
+	} while (0)
+
+static int __hwrm_send(struct bnge_dev *bd, struct bnge_hwrm_ctx *ctx)
+{
+	u32 doorbell_offset = BNGE_GRCPF_REG_CHIMP_COMM_TRIGGER;
+	enum bnge_hwrm_chnl dst = BNGE_HWRM_CHNL_CHIMP;
+	u32 bar_offset = BNGE_GRCPF_REG_CHIMP_COMM;
+	struct bnge_hwrm_wait_token *token = NULL;
+	u16 max_req_len = BNGE_HWRM_MAX_REQ_LEN;
+	unsigned int i, timeout, tmo_count;
+	u32 *data = (u32 *)ctx->req;
+	u32 msg_len = ctx->req_len;
+	int rc = -EBUSY;
+	u32 req_type;
+	u16 len = 0;
+	u8 *valid;
+
+	if (ctx->flags & BNGE_HWRM_INTERNAL_RESP_DIRTY)
+		memset(ctx->resp, 0, PAGE_SIZE);
+
+	req_type = le16_to_cpu(ctx->req->req_type);
+
+	if (msg_len > BNGE_HWRM_MAX_REQ_LEN &&
+	    msg_len > bd->hwrm_max_ext_req_len) {
+		dev_warn(bd->dev, "oversized hwrm request, req_type 0x%x",
+			 req_type);
+		rc = -E2BIG;
+		goto exit;
+	}
+
+	token = __hwrm_acquire_token(bd, dst);
+	if (!token) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+	ctx->req->seq_id = cpu_to_le16(token->seq_id);
+
+	/* Ensure any associated DMA buffers are written before doorbell */
+	wmb();
+
+	/* Write request msg to hwrm channel */
+	__iowrite32_copy(bd->bar0 + bar_offset, data, msg_len / 4);
+
+	for (i = msg_len; i < max_req_len; i += 4)
+		writel(0, bd->bar0 + bar_offset + i);
+
+	/* Ring channel doorbell */
+	writel(1, bd->bar0 + doorbell_offset);
+
+	hwrm_req_dbg(bd, ctx->req);
+
+	/* Limit timeout to an upper limit */
+	timeout = min(ctx->timeout,
+		      bd->hwrm_cmd_max_timeout ?: HWRM_CMD_MAX_TIMEOUT);
+	/* convert timeout to usec */
+	timeout *= 1000;
+
+	i = 0;
+	/* Short timeout for the first few iterations:
+	 * number of loops = number of loops for short timeout +
+	 * number of loops for standard timeout.
+	 */
+	tmo_count = HWRM_SHORT_TIMEOUT_COUNTER;
+	timeout = timeout - HWRM_SHORT_MIN_TIMEOUT * HWRM_SHORT_TIMEOUT_COUNTER;
+	tmo_count += DIV_ROUND_UP(timeout, HWRM_MIN_TIMEOUT);
+
+	if (le16_to_cpu(ctx->req->cmpl_ring) != INVALID_HW_RING_ID) {
+		/* Wait until hwrm response cmpl interrupt is processed */
+		while (READ_ONCE(token->state) < BNGE_HWRM_COMPLETE &&
+		       i++ < tmo_count) {
+			/* on first few passes, just barely sleep */
+			if (i < HWRM_SHORT_TIMEOUT_COUNTER) {
+				usleep_range(HWRM_SHORT_MIN_TIMEOUT,
+					     HWRM_SHORT_MAX_TIMEOUT);
+			} else {
+				usleep_range(HWRM_MIN_TIMEOUT,
+					     HWRM_MAX_TIMEOUT);
+			}
+		}
+
+		if (READ_ONCE(token->state) != BNGE_HWRM_COMPLETE) {
+			hwrm_err(bd, ctx, "Resp cmpl intr err msg: 0x%x\n",
+				 req_type);
+			goto exit;
+		}
+		len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
+		valid = ((u8 *)ctx->resp) + len - 1;
+	} else {
+		__le16 seen_out_of_seq = ctx->req->seq_id; /* will never see */
+		int j;
+
+		/* Check if response len is updated */
+		for (i = 0; i < tmo_count; i++) {
+			if (token &&
+			    READ_ONCE(token->state) == BNGE_HWRM_DEFERRED) {
+				__hwrm_release_token(bd, token);
+				token = NULL;
+			}
+
+			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
+			if (len) {
+				__le16 resp_seq = READ_ONCE(ctx->resp->seq_id);
+
+				if (resp_seq == ctx->req->seq_id)
+					break;
+				if (resp_seq != seen_out_of_seq) {
+					dev_warn(bd->dev, "Discarding out of seq response: 0x%x for msg {0x%x 0x%x}\n",
+						 le16_to_cpu(resp_seq), req_type, le16_to_cpu(ctx->req->seq_id));
+					seen_out_of_seq = resp_seq;
+				}
+			}
+
+			/* on first few passes, just barely sleep */
+			if (i < HWRM_SHORT_TIMEOUT_COUNTER) {
+				usleep_range(HWRM_SHORT_MIN_TIMEOUT,
+					     HWRM_SHORT_MAX_TIMEOUT);
+			} else {
+				usleep_range(HWRM_MIN_TIMEOUT,
+					     HWRM_MAX_TIMEOUT);
+			}
+		}
+
+		if (i >= tmo_count) {
+			hwrm_err(bd, ctx, "Error (timeout: %u) msg {0x%x 0x%x} len:%d\n",
+				 hwrm_total_timeout(i), req_type,
+				 le16_to_cpu(ctx->req->seq_id), len);
+			goto exit;
+		}
+
+		/* Last byte of resp contains valid bit */
+		valid = ((u8 *)ctx->resp) + len - 1;
+		for (j = 0; j < HWRM_VALID_BIT_DELAY_USEC; ) {
+			/* make sure we read from updated DMA memory */
+			dma_rmb();
+			if (*valid)
+				break;
+			if (j < 10) {
+				udelay(1);
+				j++;
+			} else {
+				usleep_range(20, 30);
+				j += 20;
+			}
+		}
+
+		if (j >= HWRM_VALID_BIT_DELAY_USEC) {
+			hwrm_err(bd, ctx, "Error (timeout: %u) msg {0x%x 0x%x} len:%d v:%d\n",
+				 hwrm_total_timeout(i) + j, req_type,
+				 le16_to_cpu(ctx->req->seq_id), len, *valid);
+			goto exit;
+		}
+	}
+
+	/* Zero valid bit for compatibility.  Valid bit in an older spec
+	 * may become a new field in a newer spec.  We must make sure that
+	 * a new field not implemented by old spec will read zero.
+	 */
+	*valid = 0;
+	rc = le16_to_cpu(ctx->resp->error_code);
+	if (rc == HWRM_ERR_CODE_BUSY && !(ctx->flags & BNGE_HWRM_CTX_SILENT))
+		dev_warn(bd->dev, "FW returned busy, hwrm req_type 0x%x\n",
+			 req_type);
+	else if (rc && rc != HWRM_ERR_CODE_PF_UNAVAILABLE)
+		hwrm_err(bd, ctx, "hwrm req_type 0x%x seq id 0x%x error %d\n",
+			 req_type, le16_to_cpu(ctx->req->seq_id), rc);
+	rc = __hwrm_to_stderr(rc);
+
+exit:
+	if (token)
+		__hwrm_release_token(bd, token);
+	if (ctx->flags & BNGE_HWRM_INTERNAL_CTX_OWNED)
+		ctx->flags |= BNGE_HWRM_INTERNAL_RESP_DIRTY;
+	else
+		__hwrm_ctx_drop(bd, ctx);
+	return rc;
+}
+
+int hwrm_req_send(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+
+	if (!ctx)
+		return -EINVAL;
+
+	return __hwrm_send(bd, ctx);
+}
+
+int hwrm_req_send_silent(struct bnge_dev *bd, void *req)
+{
+	hwrm_req_flags(bd, req, BNGE_HWRM_CTX_SILENT);
+	return hwrm_req_send(bd, req);
+}
+
+void *
+hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
+		   dma_addr_t *dma_handle)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx(bd, req);
+	u8 *end = ((u8 *)req) + BNGE_HWRM_DMA_SIZE;
+	struct input *input = req;
+	u8 *addr, *req_addr = req;
+	u32 max_offset, offset;
+
+	if (!ctx)
+		return NULL;
+
+	max_offset = BNGE_HWRM_DMA_SIZE - ctx->allocated;
+	offset = max_offset - size;
+	offset = ALIGN_DOWN(offset, BNGE_HWRM_DMA_ALIGN);
+	addr = req_addr + offset;
+
+	if (addr < req_addr + max_offset && req_addr + ctx->req_len <= addr) {
+		ctx->allocated = end - addr;
+		*dma_handle = ctx->dma_handle + offset;
+		return addr;
+	}
+
+	if (ctx->slice_addr) {
+		dev_err(bd->dev, "HWRM refusing to reallocate DMA slice, req_type = %u\n",
+			(u32)le16_to_cpu(input->req_type));
+		dump_stack();
+		return NULL;
+	}
+
+	addr = dma_alloc_coherent(bd->dev, size, dma_handle, ctx->gfp);
+	if (!addr)
+		return NULL;
+
+	ctx->slice_addr = addr;
+	ctx->slice_size = size;
+	ctx->slice_handle = *dma_handle;
+
+	return addr;
+}
+
+void bnge_cleanup_hwrm_resources(struct bnge_dev *bd)
+{
+	struct bnge_hwrm_wait_token *token;
+
+	dma_pool_destroy(bd->hwrm_dma_pool);
+	bd->hwrm_dma_pool = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(token, &bd->hwrm_pending_list, node)
+		WRITE_ONCE(token->state, BNGE_HWRM_CANCELLED);
+	rcu_read_unlock();
+}
+
+int bnge_init_hwrm_resources(struct bnge_dev *bd)
+{
+	bd->hwrm_dma_pool = dma_pool_create("bnge_hwrm", bd->dev,
+					    BNGE_HWRM_DMA_SIZE,
+					    BNGE_HWRM_DMA_ALIGN, 0);
+	if (!bd->hwrm_dma_pool)
+		return -ENOMEM;
+
+	INIT_HLIST_HEAD(&bd->hwrm_pending_list);
+	mutex_init(&bd->hwrm_cmd_lock);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
new file mode 100644
index 000000000000..c14f03daab4b
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_HWRM_H_
+#define _BNGE_HWRM_H_
+
+#include "../bnxt/bnxt_hsi.h"
+
+enum bnge_hwrm_ctx_flags {
+	BNGE_HWRM_INTERNAL_CTX_OWNED	= BIT(0),
+	BNGE_HWRM_INTERNAL_RESP_DIRTY	= BIT(1),
+	BNGE_HWRM_CTX_SILENT		= BIT(2),
+	BNGE_HWRM_FULL_WAIT		= BIT(3),
+};
+
+#define HWRM_API_FLAGS (BNGE_HWRM_CTX_SILENT | BNGE_HWRM_FULL_WAIT)
+
+struct bnge_hwrm_ctx {
+	u64 sentinel;
+	dma_addr_t dma_handle;
+	struct output *resp;
+	struct input *req;
+	dma_addr_t slice_handle;
+	void *slice_addr;
+	u32 slice_size;
+	u32 req_len;
+	enum bnge_hwrm_ctx_flags flags;
+	unsigned int timeout;
+	u32 allocated;
+	gfp_t gfp;
+};
+
+enum bnge_hwrm_wait_state {
+	BNGE_HWRM_PENDING,
+	BNGE_HWRM_DEFERRED,
+	BNGE_HWRM_COMPLETE,
+	BNGE_HWRM_CANCELLED,
+};
+
+enum bnge_hwrm_chnl { BNGE_HWRM_CHNL_CHIMP, BNGE_HWRM_CHNL_KONG };
+
+struct bnge_hwrm_wait_token {
+	struct rcu_head rcu;
+	struct hlist_node node;
+	enum bnge_hwrm_wait_state state;
+	enum bnge_hwrm_chnl dst;
+	u16 seq_id;
+};
+
+#define DFLT_HWRM_CMD_TIMEOUT		500
+
+#define BNGE_GRCPF_REG_CHIMP_COMM		0x0
+#define BNGE_GRCPF_REG_CHIMP_COMM_TRIGGER	0x100
+
+#define BNGE_HWRM_MAX_REQ_LEN		(bd->hwrm_max_req_len)
+#define BNGE_HWRM_SHORT_REQ_LEN		sizeof(struct hwrm_short_input)
+#define HWRM_CMD_MAX_TIMEOUT		40000U
+#define SHORT_HWRM_CMD_TIMEOUT		20
+#define HWRM_CMD_TIMEOUT		(bd->hwrm_cmd_timeout)
+#define HWRM_RESET_TIMEOUT		((HWRM_CMD_TIMEOUT) * 4)
+#define BNGE_HWRM_TARGET		0xffff
+#define BNGE_HWRM_NO_CMPL_RING		-1
+#define BNGE_HWRM_REQ_MAX_SIZE		128
+#define BNGE_HWRM_DMA_SIZE		(2 * PAGE_SIZE) /* space for req+resp */
+#define BNGE_HWRM_RESP_RESERVED		PAGE_SIZE
+#define BNGE_HWRM_RESP_OFFSET		(BNGE_HWRM_DMA_SIZE -		\
+					 BNGE_HWRM_RESP_RESERVED)
+#define BNGE_HWRM_CTX_OFFSET		(BNGE_HWRM_RESP_OFFSET -	\
+					 sizeof(struct bnge_hwrm_ctx))
+#define BNGE_HWRM_DMA_ALIGN		16
+#define BNGE_HWRM_SENTINEL		0xb6e1f68a12e9a7eb /* arbitrary value */
+#define BNGE_HWRM_REQS_PER_PAGE	(BNGE_PAGE_SIZE /	\
+					 BNGE_HWRM_REQ_MAX_SIZE)
+#define HWRM_SHORT_MIN_TIMEOUT		3
+#define HWRM_SHORT_MAX_TIMEOUT		10
+#define HWRM_SHORT_TIMEOUT_COUNTER	5
+
+#define HWRM_MIN_TIMEOUT		25
+#define HWRM_MAX_TIMEOUT		40
+
+static inline unsigned int hwrm_total_timeout(unsigned int n)
+{
+	return n <= HWRM_SHORT_TIMEOUT_COUNTER ? n * HWRM_SHORT_MIN_TIMEOUT :
+		HWRM_SHORT_TIMEOUT_COUNTER * HWRM_SHORT_MIN_TIMEOUT +
+		(n - HWRM_SHORT_TIMEOUT_COUNTER) * HWRM_MIN_TIMEOUT;
+}
+
+#define HWRM_VALID_BIT_DELAY_USEC	50000
+
+void bnge_cleanup_hwrm_resources(struct bnge_dev *bd);
+int bnge_init_hwrm_resources(struct bnge_dev *bd);
+
+int __hwrm_req_init(struct bnge_dev *bd, void **req, u16 req_type, u32 req_len);
+#define hwrm_req_init(bd, req, req_type) \
+	__hwrm_req_init((bd), (void **)&(req), (req_type), sizeof(*(req)))
+void *hwrm_req_hold(struct bnge_dev *bd, void *req);
+void hwrm_req_drop(struct bnge_dev *bd, void *req);
+void hwrm_req_flags(struct bnge_dev *bd, void *req,
+		    enum bnge_hwrm_ctx_flags flags);
+void hwrm_req_timeout(struct bnge_dev *bd, void *req, unsigned int timeout);
+int hwrm_req_send(struct bnge_dev *bd, void *req);
+int hwrm_req_send_silent(struct bnge_dev *bd, void *req);
+void hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t flags);
+void *hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
+			 dma_addr_t *dma);
+
+#endif /* _BNGE_HWRM_H_ */
-- 
2.47.1


