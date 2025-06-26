Return-Path: <netdev+bounces-201486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A6AE98D5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B6918980EE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93D29E0EE;
	Thu, 26 Jun 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dp1gutZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7ED2BEFEF
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927569; cv=none; b=adZX6OERJfe3HhKjd7ka9u9xgrRQqAvK6OOackOV4EMYfi4RrYbut+KwMQW2bd4wlWdeUiCZCPqyPQmgYcGX47xY6/bYoranLVxCEzkPPIykzNZWygme/3pGZhRPEpaLwfDLqaZGZeiFDcqn5R7QU94ji1QNvnM9G07dLX2GlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927569; c=relaxed/simple;
	bh=QFieygx96I2+3oXVatGSxwYs2G46ibTmZHeHF9zluIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFR9Bzzvfg0pVS9kZ+cm0I4PCbMcG7H3b6+fCMIyIWPrwzHurIJXLBX4FLZfzIqjEEznUCE9yz7WisRV5cMAhs/+jF6P+o1JGPRIJEt99kjGURRPJw3Ys9F2gZmR6q7UFtgp6nCwUFoZfWkZbA+c0ClsPkQkw6gW0o412uahTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dp1gutZj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167b30so7990575ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927567; x=1751532367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdHV6Xz263FtstCg/q2dAjtY0VZUfQQdKsi8inEoZVI=;
        b=Dp1gutZjQlQmLTc9eBio4qB5fSqgflcSzxqpUOavQxW7FeNrSv5wwrpUbnQKY4baUu
         qeSEmYJ+m3bCO90BeRz4JSki17eCNPWKh1IxPRWj4XrBtcYFNb8TYEOFFznv4BmA6YPn
         uN0Lkua3hkq2j54+kv5pu3NeJGv9hq3+T+Zeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927567; x=1751532367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdHV6Xz263FtstCg/q2dAjtY0VZUfQQdKsi8inEoZVI=;
        b=KbWYkJWfTUlrPAb2+y9qQmQHd8GJAGRy1nKkT704EB1UCl/TEPwJG+9SoT6XBxeozv
         yTUCr1Z22rYBbuX3d5br8iLT2M1YF17xwaevQNoqgakIUvEQ7Viao2C7k0EcnXVElGQx
         IeL9/r9u71BfADAsxWNOwfp6mUo+8jQuz25kqkcA6MEd/mIwJr2ZkOXFMJjP5zqSCjhr
         pQ/3MytrrFxRj+vPnTe5XDAIbezCyHv4/o/TKb3+Khk0ovVU4rQZ+6ykV5YpY/lC4XPc
         udpFOWNs4LbHkhx4CA7cePgUTLXsBj9gSngIfChCDc+6CfqWNe518nLHASu798qA6cw2
         4xmA==
X-Gm-Message-State: AOJu0YyFEHeowvu0qj3NMMvtrz0goIocXBVYPsKnByNlCH+fbhDqSrIw
	MriYBOrMdwgUDqciG7AtU/bsIJsNLkrhAPuqXZQLFnM3CUFSAVqmV+oYvGXkjbRlBw==
X-Gm-Gg: ASbGncuLMzSPcFLyG7beLF/ioy8pGCtqzY2FMKthAoQmf3PF2qJCuz3KBgAip2bL73O
	D/r0Rx9Y1I2a536dkAFFpqzaoZghmzP7W7Wpn5rbt+m8bK7QUw3+6E+X+R19VWE0r9rRlscl9gJ
	ygaPDCi+jbFbbSKY0eUdr4Oedr14gyzMr7UV+qu2kWYEk2TLn4OLZQ9eHyNMHEDzMiZ+T7yejAp
	xSpXt278BlXlq8GQtTTx8ucwtxfP/fiWHTKeeUGAhaLJFux4n/Ecz8PXW0PQ/uAp1BefSRST/uJ
	n7FZESe2gdrI/RRNdjnxhnz94Ihpps6dXQhhdVZtLzKBs7NvakjeE6Nmxr/t32tLDXUXRADYaOV
	DAsZJxMIPu+P5CU0J0R6MOVjFg2XWPX7BIpKIbqg=
X-Google-Smtp-Source: AGHT+IEwQ6SdWqSO2gjoehVyeUj2NhCYP78jxfh10Qhh4iwi4kl/O2gyK+ZXsK2csSCVROghJd1QQQ==
X-Received: by 2002:a17:903:2283:b0:234:c549:da0e with SMTP id d9443c01a7336-23824072d85mr90816265ad.47.1750927566637;
        Thu, 26 Jun 2025 01:46:06 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:06 -0700 (PDT)
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
Subject: [net-next, v2 03/10] bng_en: Add firmware communication mechanism
Date: Thu, 26 Jun 2025 14:08:12 +0000
Message-ID: <20250626140844.266456-4-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626140844.266456-1-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    | 507 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    | 111 ++++
 4 files changed, 633 insertions(+), 1 deletion(-)
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
index 000000000000..7f25c4bf2147
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
@@ -0,0 +1,507 @@
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
+static u64 bnge_cal_sentinel(struct bnge_hwrm_ctx *ctx, u16 req_type)
+{
+	return (((uintptr_t)ctx) + req_type) ^ BNGE_HWRM_SENTINEL;
+}
+
+int bnge_hwrm_req_create(struct bnge_dev *bd, void **req, u16 req_type,
+			 u32 req_len)
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
+	ctx->sentinel = bnge_cal_sentinel(ctx, req_type);
+	ctx->req_len = req_len;
+	ctx->req = (struct input *)req_addr;
+	ctx->resp = (struct output *)(req_addr + BNGE_HWRM_RESP_OFFSET);
+	ctx->dma_handle = dma_handle;
+	ctx->flags = 0; /* __GFP_ZERO, but be explicit regarding ownership */
+	ctx->timeout = bd->hwrm_cmd_timeout ?: BNGE_DFLT_HWRM_CMD_TIMEOUT;
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
+static struct bnge_hwrm_ctx *__hwrm_ctx_alloc(struct bnge_dev *bd, u8 *req_addr)
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
+	sentinel = bnge_cal_sentinel(ctx, le16_to_cpu(req->req_type));
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
+void bnge_hwrm_req_timeout(struct bnge_dev *bd,
+			   void *req, unsigned int timeout)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
+
+	if (ctx)
+		ctx->timeout = timeout;
+}
+
+void bnge_hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t gfp)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
+
+	if (ctx)
+		ctx->gfp = gfp;
+}
+
+void bnge_hwrm_req_flags(struct bnge_dev *bd, void *req,
+			 enum bnge_hwrm_ctx_flags flags)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
+
+	if (ctx)
+		ctx->flags |= (flags & BNGE_HWRM_API_FLAGS);
+}
+
+void *bnge_hwrm_req_hold(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
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
+static void __hwrm_ctx_free(struct bnge_dev *bd, struct bnge_hwrm_ctx *ctx)
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
+void bnge_hwrm_req_drop(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
+
+	if (ctx)
+		__hwrm_ctx_free(bd, ctx);
+}
+
+static int bnge_map_hwrm_error(u32 hwrm_err)
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
+bnge_hwrm_create_token(struct bnge_dev *bd, enum bnge_hwrm_chnl dst)
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
+bnge_hwrm_destroy_token(struct bnge_dev *bd, struct bnge_hwrm_wait_token *token)
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
+static void bnge_hwrm_req_dbg(struct bnge_dev *bd, struct input *req)
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
+#define bnge_hwrm_err(bd, ctx, fmt, ...)		\
+	do {							       \
+		if ((ctx)->flags & BNGE_HWRM_CTX_SILENT)	       \
+			dev_dbg((bd)->dev, fmt, __VA_ARGS__);       \
+		else						       \
+			dev_err((bd)->dev, fmt, __VA_ARGS__);       \
+	} while (0)
+
+static int __hwrm_send_ctx(struct bnge_dev *bd, struct bnge_hwrm_ctx *ctx)
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
+	token = bnge_hwrm_create_token(bd, dst);
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
+	bnge_hwrm_req_dbg(bd, ctx->req);
+
+	/* Limit timeout to an upper limit */
+	timeout = min(ctx->timeout,
+		      bd->hwrm_cmd_max_timeout ?: BNGE_HWRM_CMD_MAX_TIMEOUT);
+	/* convert timeout to usec */
+	timeout *= 1000;
+
+	i = 0;
+	/* Short timeout for the first few iterations:
+	 * number of loops = number of loops for short timeout +
+	 * number of loops for standard timeout.
+	 */
+	tmo_count = BNGE_HWRM_SHORT_TIMEOUT_COUNTER;
+	timeout = timeout - BNGE_HWRM_SHORT_MIN_TIMEOUT *
+			BNGE_HWRM_SHORT_TIMEOUT_COUNTER;
+	tmo_count += DIV_ROUND_UP(timeout, BNGE_HWRM_MIN_TIMEOUT);
+
+	if (le16_to_cpu(ctx->req->cmpl_ring) != INVALID_HW_RING_ID) {
+		/* Wait until hwrm response cmpl interrupt is processed */
+		while (READ_ONCE(token->state) < BNGE_HWRM_COMPLETE &&
+		       i++ < tmo_count) {
+			/* on first few passes, just barely sleep */
+			if (i < BNGE_HWRM_SHORT_TIMEOUT_COUNTER) {
+				usleep_range(BNGE_HWRM_SHORT_MIN_TIMEOUT,
+					     BNGE_HWRM_SHORT_MAX_TIMEOUT);
+			} else {
+				usleep_range(BNGE_HWRM_MIN_TIMEOUT,
+					     BNGE_HWRM_MAX_TIMEOUT);
+			}
+		}
+
+		if (READ_ONCE(token->state) != BNGE_HWRM_COMPLETE) {
+			bnge_hwrm_err(bd, ctx, "No hwrm cmpl received: 0x%x\n",
+				      req_type);
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
+				bnge_hwrm_destroy_token(bd, token);
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
+			if (i < BNGE_HWRM_SHORT_TIMEOUT_COUNTER) {
+				usleep_range(BNGE_HWRM_SHORT_MIN_TIMEOUT,
+					     BNGE_HWRM_SHORT_MAX_TIMEOUT);
+			} else {
+				usleep_range(BNGE_HWRM_MIN_TIMEOUT,
+					     BNGE_HWRM_MAX_TIMEOUT);
+			}
+		}
+
+		if (i >= tmo_count) {
+			bnge_hwrm_err(bd, ctx,
+				      "Error (timeout: %u) msg {0x%x 0x%x} len:%d\n",
+				      bnge_hwrm_timeout(i), req_type,
+				      le16_to_cpu(ctx->req->seq_id), len);
+			goto exit;
+		}
+
+		/* Last byte of resp contains valid bit */
+		valid = ((u8 *)ctx->resp) + len - 1;
+		for (j = 0; j < BNGE_HWRM_FIN_WAIT_USEC; ) {
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
+		if (j >= BNGE_HWRM_FIN_WAIT_USEC) {
+			bnge_hwrm_err(bd, ctx, "Error (timeout: %u) msg {0x%x 0x%x} len:%d v:%d\n",
+				      bnge_hwrm_timeout(i) + j, req_type,
+				      le16_to_cpu(ctx->req->seq_id), len, *valid);
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
+		bnge_hwrm_err(bd, ctx, "hwrm req_type 0x%x seq id 0x%x error %d\n",
+			      req_type, le16_to_cpu(ctx->req->seq_id), rc);
+	rc = bnge_map_hwrm_error(rc);
+
+exit:
+	if (token)
+		bnge_hwrm_destroy_token(bd, token);
+	if (ctx->flags & BNGE_HWRM_INTERNAL_CTX_OWNED)
+		ctx->flags |= BNGE_HWRM_INTERNAL_RESP_DIRTY;
+	else
+		__hwrm_ctx_free(bd, ctx);
+	return rc;
+}
+
+int bnge_hwrm_req_send(struct bnge_dev *bd, void *req)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
+
+	if (!ctx)
+		return -EINVAL;
+
+	return __hwrm_send_ctx(bd, ctx);
+}
+
+int bnge_hwrm_req_send_silent(struct bnge_dev *bd, void *req)
+{
+	bnge_hwrm_req_flags(bd, req, BNGE_HWRM_CTX_SILENT);
+	return bnge_hwrm_req_send(bd, req);
+}
+
+void *
+bnge_hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
+			dma_addr_t *dma_handle)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_alloc(bd, req);
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
index 000000000000..c99aa8406b14
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -0,0 +1,111 @@
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
+#define BNGE_HWRM_API_FLAGS (BNGE_HWRM_CTX_SILENT | BNGE_HWRM_FULL_WAIT)
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
+#define BNGE_DFLT_HWRM_CMD_TIMEOUT		500
+
+#define BNGE_GRCPF_REG_CHIMP_COMM		0x0
+#define BNGE_GRCPF_REG_CHIMP_COMM_TRIGGER	0x100
+
+#define BNGE_HWRM_MAX_REQ_LEN		(bd->hwrm_max_req_len)
+#define BNGE_HWRM_SHORT_REQ_LEN		sizeof(struct hwrm_short_input)
+#define BNGE_HWRM_CMD_MAX_TIMEOUT	40000U
+#define BNGE_SHORT_HWRM_CMD_TIMEOUT	20
+#define BNGE_HWRM_CMD_TIMEOUT		(bd->hwrm_cmd_timeout)
+#define BNGE_HWRM_RESET_TIMEOUT		((BNGE_HWRM_CMD_TIMEOUT) * 4)
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
+#define BNGE_HWRM_SHORT_MIN_TIMEOUT		3
+#define BNGE_HWRM_SHORT_MAX_TIMEOUT		10
+#define BNGE_HWRM_SHORT_TIMEOUT_COUNTER		5
+
+#define BNGE_HWRM_MIN_TIMEOUT		25
+#define BNGE_HWRM_MAX_TIMEOUT		40
+
+static inline unsigned int bnge_hwrm_timeout(unsigned int n)
+{
+	return n <= BNGE_HWRM_SHORT_TIMEOUT_COUNTER ?
+		n * BNGE_HWRM_SHORT_MIN_TIMEOUT :
+		BNGE_HWRM_SHORT_TIMEOUT_COUNTER *
+			BNGE_HWRM_SHORT_MIN_TIMEOUT +
+			(n - BNGE_HWRM_SHORT_TIMEOUT_COUNTER) *
+				BNGE_HWRM_MIN_TIMEOUT;
+}
+
+#define BNGE_HWRM_FIN_WAIT_USEC	50000
+
+void bnge_cleanup_hwrm_resources(struct bnge_dev *bd);
+int bnge_init_hwrm_resources(struct bnge_dev *bd);
+
+int bnge_hwrm_req_create(struct bnge_dev *bd, void **req, u16 req_type,
+			 u32 req_len);
+#define bnge_hwrm_req_init(bd, req, req_type) \
+	bnge_hwrm_req_create((bd), (void **)&(req), (req_type),	\
+			     sizeof(*(req)))
+void *bnge_hwrm_req_hold(struct bnge_dev *bd, void *req);
+void bnge_hwrm_req_drop(struct bnge_dev *bd, void *req);
+void bnge_hwrm_req_flags(struct bnge_dev *bd, void *req,
+			 enum bnge_hwrm_ctx_flags flags);
+void bnge_hwrm_req_timeout(struct bnge_dev *bd, void *req,
+			   unsigned int timeout);
+int bnge_hwrm_req_send(struct bnge_dev *bd, void *req);
+int bnge_hwrm_req_send_silent(struct bnge_dev *bd, void *req);
+void bnge_hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t flags);
+void *bnge_hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
+			      dma_addr_t *dma);
+
+#endif /* _BNGE_HWRM_H_ */
-- 
2.47.1


