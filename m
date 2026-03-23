Return-Path: <netdev+bounces-270532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE9rObQ2wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:48:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC02F2332
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6405301280F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349423AB282;
	Mon, 23 Mar 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYZr3iMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5A3A9DAB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269862; cv=none; b=J+Z3PuMHJREqt9WX9k/HzpJbkfWn/ZvQLuXPAJa1qZ8X6somDmEqMTgzsYmG4Vx4vv2UzeGun/SLHq51ai2NCer9x88r0Psi0WthbtRlpWXa+ION9TM/7YcAXI4m6LNfcPBwpcvaalhnEmvfdnyJ76CKLU6Pxno+iWvu1rbvv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269862; c=relaxed/simple;
	bh=Y7t7tUt6dttDoeVhQwZj5yxNm7WRkBuvOfI5U93wNxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouDBG6pZhnWQAb1KMiiPoLJGzFdjnFWV55hv+1+8VAsSuKX67ZoJo5mzJPg6BHU+4qhugaUpA4xmK4nOWoQ6sb9qUaEc0NwQZagKUFUsE+SWZu5/xDCvmYVFcpz5D50JJPyd5AwyuhYaT5S0lR2euaKyOrVBGs9Kw+ZwOUfCBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYZr3iMx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439c56e822eso120637f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269859; x=1774874659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV373+pSIBMLTnC1QlsnIRzT9QyOtEAQp+0Xg1q5i/s=;
        b=FYZr3iMxEyM7BT8SVSW1bL5OYXRiS76KkU0zFbzrj2uF77Uaon7BSPVF2BNSNch7Bh
         mh1CxK4I2/7yOlk+3wkR7ec3Sp8g/oKH+XU+vEJOwnl4/Qru4RLTT/TUbaQqdRb/VYGW
         /tmkdIavKnr8nP+qfYq1gQyalH91/c7aPw5FIN9yANLcs/s9KfKw/J/ItzHJ7MHfJ/0L
         SWE2R6a2IJGpMKfnXsiZLp8oBiAWSjlP6IOgw7gX8V8B5eBWhh0Y5Sfv2FPxO+g0aIfd
         D2aEQu1cF5W0vG1P+fDgVTTiWjTPuEpo1yO5Y/hBf4ivA7HwWaTItADUpeOFU8n8qg1W
         lopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269859; x=1774874659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DV373+pSIBMLTnC1QlsnIRzT9QyOtEAQp+0Xg1q5i/s=;
        b=KmCaqiMY4dhCBbaNUhg8x471FLFk/n2vcilZustysF3TUu7GRTDpYH52MOKWZWyd4Q
         SNKmNg+RsFc9Pz/xQ+2jbPZNG+SQONMS8w69JRERNiIb5ZweSAJ4G6jwDESxpgRHBOO4
         8iDCk3AA6uJ6ikP58UKdieOY/F6BOdhfHjkE4V0rgDXPDp6jEjVdnfIlfhponwx0+ggi
         sNQdz25ayU9l+kUZ04xciYxQbqAOByih8PtA9q+QObe/z3K+ZcNkXpzxZYixwEnYcInD
         21i7bF/okr2311shHq6KHr+ZbmviVmQECUO6A1pPB9ryWaztElh250c7DK7hXXEl1ZBH
         k6NA==
X-Forwarded-Encrypted: i=1; AJvYcCWQc1E7l9FEAWXSHKzkGAPfudqAcQy3UkDRKG1yLFHE7s1mWDwlbeFkEqiJvqaR+EbpKpuE8Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dZGCXBOEaJ/wDv2d4C4INtZazEHobhyf0IDm1bnLtWV7f9O+
	7teDjCpbtqJiBdkaVbWSBQE9+Uj62BVpcZkv2TYG4Ody+rNLO8XUBRam
X-Gm-Gg: ATEYQzwTc44N8s32fI6yd7D/KlHgjGSYGRBN+Am3GnZSK5RmbpL8zYux3jBAh09+YT2
	G62apGjNZi7hS7PQILMT5//ddVovBap0kjXnd869Oi2vdWQMySe2fhrTZ1akUr9UyaKVHvi/Y+0
	SHg/6daQDMP2eSTpLFkZ//u8D8nlzGrze7pFi1RmVmB/BIA3gFIPgsuSg5yTv+wfaK12HcDueYu
	O4yYlmF/hDfSVzqYOE1m+SnE9Rr8+Vpvigy9/nE1zRcGX5VPFXtgmWxZHbVySvLinGKJlybNYOm
	E1L9+HzpGlahCENAW20gEldFLgxMopWIGQK9/IrgAex3+JQ21Z9TSGHSKO77SQcecu+u95x8Wc/
	LyuUpSoVb1DeYxtL8HKB5tfBAiFxhikFONwns80h4MR5t+yBC9wbnzT8DI+2P0bntr91ElojbsN
	3ZSoIFCl67k7IV1GQLz/lzCfV7E2SAAzRL2RF3orfV7+S1xLGkb1BP7EGq90L5voSEyU22WsaW4
	YKZSm2HCw==
X-Received: by 2002:a05:6000:26c3:b0:43b:50bd:bca3 with SMTP id ffacd0b85a97d-43b64238685mr17478676f8f.1.1774269858818;
        Mon, 23 Mar 2026 05:44:18 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:6969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm25520861f8f.0.2026.03.23.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:44:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 14/16] io_uring/zcrx: cache fallback availability in zcrx ctx
Date: Mon, 23 Mar 2026 12:44:03 +0000
Message-ID: <65e75408a7758fe7e60fae89b7a8d5ae4857f515.1774261953.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-270532-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4FC02F2332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store a flag in struct io_zcrx_ifq telling if the backing memory is
normal page or dmabuf based. It was looking it up from the area, however
it logically allocates from the zcrx ctx and not a particular area, and
once we add more than one area it'll become a mess.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 9 ++++++++-
 io_uring/zcrx.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 265b3a744ac2..d6475f95b815 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -423,8 +423,13 @@ static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
+	bool kern_readable = !area->mem.is_dmabuf;
+
 	if (WARN_ON_ONCE(ifq->area))
 		return -EINVAL;
+	if (WARN_ON_ONCE(ifq->kern_readable != kern_readable))
+		return -EINVAL;
+
 	ifq->area = area;
 	return 0;
 }
@@ -882,6 +887,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
+	ifq->kern_readable = !(area.flags & IORING_ZCRX_AREA_DMABUF);
+
 	if (!(reg.flags & ZCRX_REG_NODEV)) {
 		ret = zcrx_register_netdev(ifq, &reg, &area);
 		if (ret)
@@ -1296,7 +1303,7 @@ static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 	struct io_zcrx_area *area = ifq->area;
 	struct net_iov *niov = NULL;
 
-	if (area->mem.is_dmabuf)
+	if (!ifq->kern_readable)
 		return NULL;
 
 	scoped_guard(spinlock_bh, &area->freelist_lock)
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 893cd3708a06..3e07238a4eb0 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -54,6 +54,7 @@ struct io_zcrx_ifq {
 	unsigned			niov_shift;
 	struct user_struct		*user;
 	struct mm_struct		*mm_account;
+	bool				kern_readable;
 
 	struct zcrx_rq			rq ____cacheline_aligned_in_smp;
 
-- 
2.53.0


