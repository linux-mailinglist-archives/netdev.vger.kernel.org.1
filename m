Return-Path: <netdev+bounces-238287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FEC56FD3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48DBE344AC6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960D338F20;
	Thu, 13 Nov 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9/mTpgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E433C510
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030794; cv=none; b=WWAYf7G64+qRCMU1qGtyfJ2RONxMq3PMgtB2qJiyVXbQOmk+xkP2t7ty+eexKdCa6tHZAYEG7pIJhGIKW9bWajhzaP64Ga/+zUpZXEO94AWMAtkwIUQe9gsFf+wODWFVXLXAz+SW68vY0yq6Lpwk+rLMWrRmf0DHXeCNCOmu40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030794; c=relaxed/simple;
	bh=fxImp9PCBrRzLacyzw0s4/YWShfUB5rnWGk2JRRT9hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFlSRh9uWxdPt9JFb7XZNe4WrTS16Hf+J3AwaLieBT/Nhemuk8CMVfeeIoMZs+gTkD0AQKLh/yWbidpwP+iHZBCj40uTkRByKQp6p7nrw19IqvOSkghgb23OEUr2b+BEs6lWDRP8rOFaizzglCqzQa4rg+9txylVFfqdwIyTyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9/mTpgS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c4c65485so573223f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763030791; x=1763635591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s05tFvB4WFd+B9gxrucMuUCTKso703qwSrt2nkbSvSc=;
        b=Y9/mTpgSTx7siF99SxSZ7icekfwwNM4PrMFYhhggKmtfqDTDNDC9asyapzQPaCg2YT
         O/T63mpjZ68RHbYic33oSekEhkCLmZACRYqLTFv+P9Uv2dwNgdVPDCVxd2g/WF9gfSEy
         NJGsy133fYHiE0Dn+tJiyk3N6zTbBs25P3HOVvznrNUHZgVY+2/YoTr9MmOl8Snz5pNR
         iB8TMxmsliJJutOqxaEPaoZkGqE0UJbBYqnkQ01L14KIuixheEcGjYcvdKBp3GZj8bZ3
         JsHbupPo+D87oMlnkyvYPBbYkkiGBQvAl/UO2CYUAemhlHBw9YnbU+wL/FXqwufGEDmi
         pFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030791; x=1763635591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s05tFvB4WFd+B9gxrucMuUCTKso703qwSrt2nkbSvSc=;
        b=ZBv/QekN9PULnDOd+dVGuoPc83goCIWNg3+L2Yii+ueijinl1mcH4MmE7VZh/gClHD
         yhwAjQwwy1D+1izYDSL6uE4uA/jV34s7e+HSX8Q8A0g71ehiLN2rr0m3MX+uaX4PYNMN
         ZpWMrD9RNQ9d6vmjxRaiGiSEO7a+S3fFD/yWOaWi+Y4lK+GZKN2ktFzzLWoq+o4Tm2iu
         +w71vXD8RMStnQpNwpIRaWTv/40iV2W3QVLLLPrM+cTOOUtRBbnuUOKwvC2iA6nYSRVh
         0rbTZ0AHfN5DPOflXU0jJxwZtSfq9d2p2mmhkMWE8Rmv7CPxAXoOWesx/olTg2gJNF0b
         ui0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXSJhHP6eLEaQ3X5CjidgeH2wrirGCoWgseYaoKFQIe+G0mLZ9/njU5fDXAwWdRPpQUklk+VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUA5dinU7ctuibelrWLgq0PK6YY9t6e8zQQyT3qRg7eISrKV8
	zQ57liy1jCQW17yXUjEAGmX6sM8ScLHn5cz8Z65Sfjj0q6lYu8Cxpn8w
X-Gm-Gg: ASbGncvcNMmmvp4i6i3BI2qTOc/pltXq1sE2ipFgwZt5XbWy+u340BtdqTXU6Zb2cm2
	cfdAfYfteAJ2fExTJ7Kwk/itsfDCQ56dBhJg6tb1nq55QufPNWeQMNSAFftuwx8WBcD/2DolZ+B
	Ds/g7dK6VH65v9Jy2uGgbZsDANGCk2Av1jzZ+kLIc+O6qL6PcPd0gONBVkxxG3L7x3OfMpjsctS
	ckih7f8MWB7/CTEu9QlwFszl2koMM/FygbItmzAFyHz7jmarDYbD+wcRuJOMn5SwrXNg7kAJvPt
	V5rGfy6jz0cqdK3nwU0y+n3e2P5rZSf7Z2YzjhJN+La1XKYrXXwJXHG6XCDGxHuQcdX/iUhbQN1
	O5Gi99Xyh25NdtAcp92xYvXYDthmae7r5/4tbMSPzjZzDrJ2VtqM2ns8ndsA=
X-Google-Smtp-Source: AGHT+IFTizU/twJ2tH/xFdwQQ3KWcjN7Nqmib5bArJ/lMR51LKVnPXeqH4/Ou4Tn/oy9DSZegVM6jA==
X-Received: by 2002:a05:6000:2003:b0:42b:40df:2339 with SMTP id ffacd0b85a97d-42b4bdb9f74mr6123087f8f.57.1763030790638;
        Thu, 13 Nov 2025 02:46:30 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm3135210f8f.10.2025.11.13.02.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:46:29 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 04/10] io_uring/zcrx: introduce IORING_REGISTER_ZCRX_CTRL
Date: Thu, 13 Nov 2025 10:46:12 +0000
Message-ID: <781c0f06a0e7f2d0520d7fe59a13725efd647a85.1763029704.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It'll be annoying and take enough of boilerplate code to implement
new zcrx features as separate io_uring register opcode. Introduce
IORING_REGISTER_ZCRX_CTRL that will multiplex such calls to zcrx.
Note, there are no real users of the opcode in this patch.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h | 13 +++++++++++++
 io_uring/register.c           |  3 +++
 io_uring/zcrx.c               | 21 +++++++++++++++++++++
 io_uring/zcrx.h               |  6 ++++++
 4 files changed, 43 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3d921cbb84f8..5b7851704efe 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -701,6 +701,9 @@ enum io_uring_register_op {
 	/* query various aspects of io_uring, see linux/io_uring/query.h */
 	IORING_REGISTER_QUERY			= 35,
 
+	/* auxiliary zcrx configuration, see enum zcrx_ctrl_op */
+	IORING_REGISTER_ZCRX_CTRL		= 36,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -1082,6 +1085,16 @@ struct io_uring_zcrx_ifq_reg {
 	__u64	__resv[3];
 };
 
+enum zcrx_ctrl_op {
+	__ZCRX_CTRL_LAST,
+};
+
+struct zcrx_ctrl {
+	__u32	zcrx_id;
+	__u32	op; /* see enum zcrx_ctrl_op */
+	__u64	__resv[8];
+};
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/io_uring/register.c b/io_uring/register.c
index ec13ff876a38..2761a751ab66 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -826,6 +826,9 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	case IORING_REGISTER_QUERY:
 		ret = io_query(ctx, arg, nr_args);
 		break;
+	case IORING_REGISTER_ZCRX_CTRL:
+		ret = io_zcrx_ctrl(ctx, arg, nr_args);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 149bf9d5b983..0b5f4320c7a9 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -941,6 +941,27 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.uninstall		= io_pp_uninstall,
 };
 
+int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_args)
+{
+	struct zcrx_ctrl ctrl;
+	struct io_zcrx_ifq *zcrx;
+
+	if (nr_args)
+		return -EINVAL;
+	if (copy_from_user(&ctrl, arg, sizeof(ctrl)))
+		return -EFAULT;
+	if (!mem_is_zero(&ctrl.__resv, sizeof(ctrl.__resv)))
+		return -EFAULT;
+
+	zcrx = xa_load(&ctx->zcrx_ctxs, ctrl.zcrx_id);
+	if (!zcrx)
+		return -ENXIO;
+	if (ctrl.op >= __ZCRX_CTRL_LAST)
+		return -EOPNOTSUPP;
+
+	return -EINVAL;
+}
+
 static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 			      struct io_zcrx_ifq *ifq, int off, int len)
 {
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index c9b9bfae0547..f29edc22c91f 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -65,6 +65,7 @@ struct io_zcrx_ifq {
 };
 
 #if defined(CONFIG_IO_URING_ZCRX)
+int io_zcrx_ctrl(struct io_ring_ctx *ctx, void __user *arg, unsigned nr_arg);
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			 struct io_uring_zcrx_ifq_reg __user *arg);
 void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx);
@@ -93,6 +94,11 @@ static inline struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ct
 {
 	return NULL;
 }
+static inline int io_zcrx_ctrl(struct io_ring_ctx *ctx,
+				void __user *arg, unsigned nr_arg)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 int io_recvzc(struct io_kiocb *req, unsigned int issue_flags);
-- 
2.49.0


