Return-Path: <netdev+bounces-223573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FEB59A1D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0E6484587
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1791F03D8;
	Tue, 16 Sep 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLV4QANn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE619E98C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032810; cv=none; b=LYIFf3SPf9bTmwvseEy1FtzqzUelqhiiLTYEyw0ocNflDIYtofItcgcoSkcNTrLhcnA56CQcYWM3gbIsMnhWskizWplirW3QZbimgui1oJ8PnlAvReJliy6wH/7oYLKxCDko0Z6X5CMPM4s3tMlApzodHBlufWauplTZEH1FeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032810; c=relaxed/simple;
	bh=f1eziMhUTcOp7YZGl+YiaDCdsGNEpFd+zO01eVMJblo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gndFSmowPLsjZrn58JwDR/3MxEfyqhZhyOkS1c6dr2xXcaf0cBYY05eOBkg6Z0qFT9xMFbGGW2XXXeNDEEhfJtoNSeOib5TXnnnuG7uexMk9t52cyxCJOpJ/eRF6yp0uiXz0PR9T0zV08z96PBWqvOczmTiMGSbk7Bk5ukvEtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLV4QANn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso1651488f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032807; x=1758637607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVXyT7gZZx7NAfvGZMdB6IRIjeHOqT0WLFhq7EM9v8s=;
        b=WLV4QANnHFkn1ssNtu8ilBzQGVer4f6vyRaNll8n00NiBfodeCAbaSaa7wc166ZkOM
         Fwgachzb6DqTPXxh0fmR7FjGOZJaISiGRW0JYN2PszhLjv615y0K4QrgMPrbNDAvCtM1
         vxtsihKl5p+t/eGixDoPa3rc443phX83EeAPGW4L4J8o3DITrvjAFV9w4vD2vChu7FpJ
         QAw4ssFDBzTOphnyRoR138p2dLvjI/mQQ3xhaOqyleov5tQM7uozNqMkTQfd+Ws5NeTe
         nlkq7dHa0qsYUA2HMxMq4Ls1G+BmUnFIi7LbMqNL2lpUvO0qYfeJFwTHC8rkgvLzvROK
         Qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032807; x=1758637607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVXyT7gZZx7NAfvGZMdB6IRIjeHOqT0WLFhq7EM9v8s=;
        b=EQqmhk7xxMFrfl4GCirdHNhvJGwkt6ErS/8KQ0Fbz2WG0r4wulop4ZkMBDn4K0q55P
         vpZGiHo2eQYdIwjzXmXoY9ttb97X/hn66qs4zLSWTqHKaIbMXa/kmCOE1NeWhccS6CcA
         Ch9x3xknwZ3QaiaY40SK/6JUJh7jjVrV7mZh6e1ELujWBx87h3vgxxR+Ro9JMokLvh6I
         RrNYXHugp/CREN6BRuR3p5/JAUvxSYnvuP+YctJyOhB6guRkrxVvZ8bWhshMH6ygis7R
         O1EXhtmZI97Y9RgXteWd33jrQoXD57nN30DthXdhYUjCETAem7Wp1N9VkH9z+paXzr6c
         h9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXgCrV6+5SgR6AoMLrs95ncG626hOHJOJQQlTpNYzQK1AgsciQvzQKn47ZSTe3BmivVypc2SJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jUiLdkcO8SZIiRWhkEpRxcJqcSLFVC9cL3/ep4Wv6vJonwNj
	8Pe/PomakyXKZ/vLVP+pPjQSxTRdlgm7hbTV+7jL2iE29o1HpYcOoTFZ
X-Gm-Gg: ASbGncvhbdK6ka+uG3xMAGfFzrv/lDjo9miOU2Uz3vu6JPilwWI2H3azDNbzlVrq2F2
	caDKjFXBFa6gztcwgNqn0Bnla1BQISsswpxB5KM50y1E6gc0b9VoiFOzf4EsB0w3+u9pY8p3txO
	1ApkQnmNh7/cSgiHO+AbzMIc2ApZKhIngGvrYulgIj87uSBzPsI2Z5oWCKBoBhDQ1w5jlU6eJkU
	vppO4+znxQXYtbzvUBui9w92ztHa+DIxtFHSdflO40V5kx48elXFd8FqM3IDTPm2DECojtaVFqC
	GgOyrm70PiypM/tQRRYU1ZsZqJbxiR9w4AEcIoXehOftFDxiSJdSst7szdvfpJCYUxBQPqoo+OL
	tQVIkkg==
X-Google-Smtp-Source: AGHT+IETQHyCapz+cmTcS6p25vuwVvZDbYb8nui0O+yFawXA4pHeJRZmH5bGAixQjd84MXteyLQAXA==
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8fb4 with SMTP id ffacd0b85a97d-3ea66809353mr7431465f8f.20.1758032806914;
        Tue, 16 Sep 2025 07:26:46 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 01/20] io_uring/zcrx: improve rqe cache alignment
Date: Tue, 16 Sep 2025 15:27:44 +0100
Message-ID: <9c14eb58088a746ddf3a7fd3ae8d4498dfa36ed4.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refill queue entries are 16B structures, but because of the ring header
placement, they're 8B aligned but not naturally / 16B aligned, which
means some of them span across 2 cache lines. Push rqes to a new cache
line.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 51fd2350dbe9..c02045e4c1b6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -352,7 +352,7 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 	void *ptr;
 	int ret;
 
-	off = sizeof(struct io_uring);
+	off = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
 	size = off + sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
 	if (size > rd->size)
 		return -EINVAL;
@@ -367,6 +367,10 @@ static int io_allocate_rbuf_ring(struct io_zcrx_ifq *ifq,
 	ptr = io_region_get_ptr(&ifq->region);
 	ifq->rq_ring = (struct io_uring *)ptr;
 	ifq->rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
+
+	reg->offsets.head = offsetof(struct io_uring, head);
+	reg->offsets.tail = offsetof(struct io_uring, tail);
+	reg->offsets.rqes = off;
 	return 0;
 }
 
@@ -618,9 +622,6 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	ifq->if_rxq = reg.if_rxq;
 
-	reg.offsets.rqes = sizeof(struct io_uring);
-	reg.offsets.head = offsetof(struct io_uring, head);
-	reg.offsets.tail = offsetof(struct io_uring, tail);
 	reg.zcrx_id = id;
 
 	scoped_guard(mutex, &ctx->mmap_lock) {
-- 
2.49.0


