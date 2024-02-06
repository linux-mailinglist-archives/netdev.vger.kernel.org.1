Return-Path: <netdev+bounces-69568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC54984BB0F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EF81F25E2B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF15F17F5;
	Tue,  6 Feb 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VK4aDJ2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E555AD25
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237279; cv=none; b=vBH80RARuOob+FSytj3SapTw2dG+6T0diph5mQaljg9KUxFHkgAh0Bt76gEeS8Mn0svAvjpdNEcvGuEyOMmWMu6jXVQNWVOOw70mFzWte3JkKt6r9SAzGCq4bZ8Ezaatr4n3VBHAUKEwt1SP7lp9MAn9JukajRvXjBWV6B3kRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237279; c=relaxed/simple;
	bh=Ehe8wkbySYlqi06F4nKKmVja3qQsGAVpDppEmrigw4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcOmrAO9j0jLbcLyp00uFOT1yyeCWHflVVaety0lezAJzQNWalOPMbE5tt18XnNxqwJMLn0W5wWgTJn30OWr9vsQaVG+EEn/CI9tQXiiCVuTLs0J8GoMEeRxvtwNXBedcXMm3K3KpdA/Qf9GiTt5foAjUalHkJlZYRonSIQShqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VK4aDJ2o; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso16745939f.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237277; x=1707842077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIRoOUxRSdp9f2nKlutUNq13IaJ20RhqPUvflOfDWuQ=;
        b=VK4aDJ2oXKzeYrQ+PIke05zBu20u8MFSJsifrQMZVVmGVZb3GhRxpDFTuNuHEb0IEh
         yxFIhcc9WzxgfIHbWp/2tVtb8FQSIxnDXPgS39MQFDKvPRkPPnmS4pAsTSNRLjMysTJg
         3k94XZN79uggmUfcKDbN6lVG3dDOmIumAclGayeQrNUZB8jfJ0++VYSxnOQDyQl08FtJ
         N3szvrfYashKR+YGmoPnqcPyHiaa8AfEZjQQd12pUPzHg2TdVP7/i4cJUph0lpEFLAwr
         F6lddVA19IFto05gkN00ksFmtB3ZK00wTnis5J8+Ymnucey9IrbjsXe3oVxABosAQPAL
         DV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237277; x=1707842077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIRoOUxRSdp9f2nKlutUNq13IaJ20RhqPUvflOfDWuQ=;
        b=olhPrn5Rtl0XElsqSmwkCoqiXgJx06X5MHV6bpWVabGacVoakKYkTiJoyCanpX1tuE
         CqTUdmZhEpuuSjVJNr7GRHBCoJhsNUjspUVhP9uKjlfkc4GNQvIOTAWs5Ikjhqmgjp4O
         7x15itHZMeYbpnXyvAV7MWrhuSFN+V0R5nDsxxZ7O/Mlz4le0M2TnwrNLq2fP6788Cn6
         CmUKJJc1sWErxnynpk15lxfAmVHB40Iikn4EGHBuRXFDDf1ZXo/1RQgT9Un2tzWApsSU
         +PIZsB99g/IYg5yueTBdigJnuvp2h/xkX/qnYns3OiphacOs+oWA1MoOtjgRWn3X1mC7
         d9ow==
X-Forwarded-Encrypted: i=1; AJvYcCVawBvxk5tG72HLCfw1DGQFlLXTLhzQ41Uxx/aJL5mJo04ZpuYR6fyNpkyzQxcSKn6AhsxnYuWLKoe1feqTzmo/tDr+tzpX
X-Gm-Message-State: AOJu0YxHi1QUwdJglETA5/8UUKsItwIvSozBhDIaUW+4ZjPzvJsHNZAR
	TNKa3vmP9Tq/q0Ak6UtGPwkaFd0JUnPk644yY/jhhzFQfNl4joF9k5b4uCKUZso=
X-Google-Smtp-Source: AGHT+IF/6TnH2bylCGTwaThiNlvRFifzCvkGJTzJ0EuV0obgLqxihsVNQSVCwhkqCApF/0IlLFteRA==
X-Received: by 2002:a5d:938a:0:b0:7c3:f631:a18f with SMTP id c10-20020a5d938a000000b007c3f631a18fmr1227061iol.1.1707237277271;
        Tue, 06 Feb 2024 08:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUyOOAYxTdAgI9WE+gCd+hE2ciJ3STwUQgRrT6ixCRxIqIBb9B797dhAYT4nZOa6rGGXa7ko/l7JHrF2ifMh3cSY5ixBA2VMVie6sUEntft3V/NJcDJ5IcqE1RWWdtGSptSNrlv38Nri3kOIY1rJ+xJbnZX7wEryySpSLUx7WCvRKk=
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u8-20020a02aa88000000b00471337ff774sm573316jai.113.2024.02.06.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:34:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	olivier@trillion01.com,
	Stefan Roesch <shr@devkernel.io>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] io_uring: add register/unregister napi function
Date: Tue,  6 Feb 2024 09:30:08 -0700
Message-ID: <20240206163422.646218-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206163422.646218-1-axboe@kernel.dk>
References: <20240206163422.646218-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Roesch <shr@devkernel.io>

This adds an api to register and unregister the napi for io-uring. If
the arg value is specified when unregistering, the current napi setting
for the busy poll timeout is copied into the user structure. If this is
not required, NULL can be passed as the arg value.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230608163839.2891748-7-shr@devkernel.io
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/uapi/linux/io_uring.h | 11 ++++++++
 io_uring/napi.c               | 48 +++++++++++++++++++++++++++++++++++
 io_uring/napi.h               | 11 ++++++++
 io_uring/register.c           | 13 ++++++++++
 4 files changed, 83 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 7a673b52827b..26f78eb85934 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -570,6 +570,10 @@ enum {
 	/* return status information for a buffer group */
 	IORING_REGISTER_PBUF_STATUS		= 26,
 
+	/* set/clear busy poll settings */
+	IORING_REGISTER_NAPI			= 27,
+	IORING_UNREGISTER_NAPI			= 28,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -703,6 +707,13 @@ struct io_uring_buf_status {
 	__u32	resv[8];
 };
 
+/* argument for IORING_(UN)REGISTER_NAPI */
+struct io_uring_napi {
+	__u32	busy_poll_to;
+	__u32	pad;
+	__u64	resv;
+};
+
 /*
  * io_uring_restriction->opcode values
  */
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 3e578df36cc5..b1a3ed9d1c2e 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -207,6 +207,54 @@ void io_napi_free(struct io_ring_ctx *ctx)
 	spin_unlock(&ctx->napi_lock);
 }
 
+/*
+ * io_napi_register() - Register napi with io-uring
+ * @ctx: pointer to io-uring context structure
+ * @arg: pointer to io_uring_napi structure
+ *
+ * Register napi in the io-uring context.
+ */
+int io_register_napi(struct io_ring_ctx *ctx, void __user *arg)
+{
+	const struct io_uring_napi curr = {
+		.busy_poll_to = ctx->napi_busy_poll_to,
+	};
+	struct io_uring_napi napi;
+
+	if (copy_from_user(&napi, arg, sizeof(napi)))
+		return -EFAULT;
+	if (napi.pad || napi.resv)
+		return -EINVAL;
+
+	WRITE_ONCE(ctx->napi_busy_poll_to, napi.busy_poll_to);
+
+	if (copy_to_user(arg, &curr, sizeof(curr)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * io_napi_unregister() - Unregister napi with io-uring
+ * @ctx: pointer to io-uring context structure
+ * @arg: pointer to io_uring_napi structure
+ *
+ * Unregister napi. If arg has been specified copy the busy poll timeout and
+ * prefer busy poll setting to the passed in structure.
+ */
+int io_unregister_napi(struct io_ring_ctx *ctx, void __user *arg)
+{
+	const struct io_uring_napi curr = {
+		.busy_poll_to = ctx->napi_busy_poll_to,
+	};
+
+	if (arg && copy_to_user(arg, &curr, sizeof(curr)))
+		return -EFAULT;
+
+	WRITE_ONCE(ctx->napi_busy_poll_to, 0);
+	return 0;
+}
+
 /*
  * __io_napi_adjust_timeout() - Add napi id to the busy poll list
  * @ctx: pointer to io-uring context structure
diff --git a/io_uring/napi.h b/io_uring/napi.h
index b6d6243fc7fe..6fc0393d0dbe 100644
--- a/io_uring/napi.h
+++ b/io_uring/napi.h
@@ -12,6 +12,9 @@
 void io_napi_init(struct io_ring_ctx *ctx);
 void io_napi_free(struct io_ring_ctx *ctx);
 
+int io_register_napi(struct io_ring_ctx *ctx, void __user *arg);
+int io_unregister_napi(struct io_ring_ctx *ctx, void __user *arg);
+
 void __io_napi_add(struct io_ring_ctx *ctx, struct socket *sock);
 
 void __io_napi_adjust_timeout(struct io_ring_ctx *ctx,
@@ -68,6 +71,14 @@ static inline void io_napi_init(struct io_ring_ctx *ctx)
 static inline void io_napi_free(struct io_ring_ctx *ctx)
 {
 }
+static inline int io_register_napi(struct io_ring_ctx *ctx, void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_unregister_napi(struct io_ring_ctx *ctx, void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
 static inline bool io_napi(struct io_ring_ctx *ctx)
 {
 	return false;
diff --git a/io_uring/register.c b/io_uring/register.c
index 5e62c1208996..99c37775f974 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -26,6 +26,7 @@
 #include "register.h"
 #include "cancel.h"
 #include "kbuf.h"
+#include "napi.h"
 
 #define IORING_MAX_RESTRICTIONS	(IORING_RESTRICTION_LAST + \
 				 IORING_REGISTER_LAST + IORING_OP_LAST)
@@ -550,6 +551,18 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_register_pbuf_status(ctx, arg);
 		break;
+	case IORING_REGISTER_NAPI:
+		ret = -EINVAL;
+		if (!arg || nr_args != 1)
+			break;
+		ret = io_register_napi(ctx, arg);
+		break;
+	case IORING_UNREGISTER_NAPI:
+		ret = -EINVAL;
+		if (nr_args != 1)
+			break;
+		ret = io_unregister_napi(ctx, arg);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.43.0


