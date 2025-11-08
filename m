Return-Path: <netdev+bounces-237015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E965C4332B
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840BD188D309
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583AD27703E;
	Sat,  8 Nov 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lFuXdxqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929802798F3
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762625676; cv=none; b=pWVlGg1oZF8s1Tx5aYAeonF2ifn61Ee4dwOjEr8fWXGSGZKNV+L672vcty9BBrqzTCffpjNOTyK89cVXtp5JUFLQruYLMVmJBz3HB3RlRTAZDw2o/cy1dPzYmgL/cchB5uzTbxWxZLsAUIpcwwpKzH1NptF8D/aS3wWXFjJJaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762625676; c=relaxed/simple;
	bh=swDa2PQ3bTyqse4dDEsB5XLEJB58Uvr9Sg1pgYPVJH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAWvKJRWNGnIagulQcCiSgNhw4CuWmPk9EAZXbwMmcYoLYssmMzE8SdJbWWWl01Xrln9MpVMENlq+UYqvbQ0qYZiti7BYX/zhcZG7mZKqIzJ+n70JSm4p09rz7qiAn+O4vehYqjUYuDdzQjP5fhUUkxxs+CWvBfdWfdduSZJBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lFuXdxqG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e41b6469f5so909836fac.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762625673; x=1763230473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnnUSLvFMGOvFxx4OXBj7KUZH0qTnU4jvHFzpkOE1No=;
        b=lFuXdxqGZEFXllwBeQpYE6ufBepM8cKTh54NxsXx9R8NGA6VXznl7eNZCoCQPmGsbR
         m45/1JTzj/bMY6qKbnXQ1jck7vRu0Dkwqf3HBKOHJDEfw78AuuLVlaxt7d2HnW4EhDQg
         ryBP2jKuJzN60iTVUf1vdnFX6yKvPfbIX5XtN/lebIl040/nvytmssJvHZrcNhlTWrlK
         u0cdd1Cj2YQn/XuZuDLX0WecmdYbFjvcPdF9/pUbJG1rtqmJ92DsR7pF96eTeay5fFna
         4YtKMti/vDkkC8KDWejsRwfRUncSMRzyMso1jM+3P8KmrfZOBWgIfSV8J5Zf1PHGtimT
         upUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762625673; x=1763230473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnnUSLvFMGOvFxx4OXBj7KUZH0qTnU4jvHFzpkOE1No=;
        b=r3EqWhi6Ke/Uf+i566q/F5yUOhN3G1Dc5bF4ODQNSe+C8V+0xZx7A/pqU9Y88/seUu
         avm1fcSUYtw4RXoPyt1PON9qDrwHjJZrekBxBKlfokn36fT4o8P4sB4ECC/JnMdXUZ8Z
         mpIsnSyumaFTzdWiCiW0UK8mK6WLNZdNtmTYhTqAPtHigcx2Nk9Ls5mZb+MSgtC11pQy
         rDnjLXT4Be3ZtPyYXnXl+T7FBpLFq7jrygJkFHnRdkncwcU1X4alG/092Z7gxw0p116s
         IqDUuUBWn8V097ZSTyTv4NnjfRDrwXa05WTkUOIF0/qgTE0S2QN+OyQ+6dnzN1q7RKk6
         PILA==
X-Forwarded-Encrypted: i=1; AJvYcCXeu9h5vp4gnV83qegqqRqPCzxeFx8VC63TYmvBLQAR/+CDAcDjZyWvfju4b+KcB1/ZDySnu8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdijQMOtgXUxje5KYS1AGlR6fMH03ajQiUEVVkMbDTllvF6sU
	gQhFUPZE8ADNjrqFboKtTgF4oNGjHzpCFRCXqq67bCjuCyGyHr1UqfMACy40mJom6ZK1iLiCqQA
	f/mS+
X-Gm-Gg: ASbGncswTguFalVwTlnh2Pk0/w2Vi940Qw9S09XaBNr3n/qubBTQk9r29AWwhZdccJH
	NTqNXJrVJtpW6EsTlkIlX4a+51int1bUzZl+BnLa0KjphVRiuFrUM9HkxDMuyaAwlg5Q6mA01dO
	WaeK6TqQz01QndgGNyvMBNfvTjnYM6ujWu4gR/vx92BLLZ6x+BMyeV5kvLsZYuNtsrmnrxQfg1i
	tn6hiFCa8Gaqvz90X3ERGjtGRQbaiWOP0OKeikwhxBDtzavXbXZl+3g4mSfKwjmSQtUz7lyCx92
	CDYuiBOg6iRSX3EukU3UBvnEtuLthO1LcJCQKdb4Hd7qTPsI9i+g4chG7Pz/THJxR4tSO96QoIu
	GVF86ImyWtDto+SR9ylg/OliIqYpCjrzlqwH2WRgwEHPbMVlprymA92wq/D/lbpPBsg3JyTCVO4
	CGUrn8y5izPobKBQ4leyYOx5HdZH7ahA==
X-Google-Smtp-Source: AGHT+IGrBUhsgwfE9g87Lzu8eUXccxeW06jeYL+x3OkNB5Kh/GkA4Z86GFd2cImWj5hklQQV94fRJg==
X-Received: by 2002:a05:6871:2b84:b0:3e7:dd0a:31cd with SMTP id 586e51a60fabf-3e7dd0a3747mr366357fac.30.1762625672793;
        Sat, 08 Nov 2025 10:14:32 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f0b21fsm3297035a34.1.2025.11.08.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:14:32 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v6 4/5] io_uring/zcrx: add io_fill_zcrx_offsets()
Date: Sat,  8 Nov 2025 10:14:22 -0800
Message-ID: <20251108181423.3518005-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251108181423.3518005-1-dw@davidwei.uk>
References: <20251108181423.3518005-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper io_fill_zcrx_offsets() that sets the constant offsets in
struct io_uring_zcrx_offsets returned to userspace.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3fba3bbff570..49990c89ce95 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -345,6 +345,13 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 	atomic_inc(io_get_user_counter(niov));
 }
 
+static void io_fill_zcrx_offsets(struct io_uring_zcrx_offsets *offsets)
+{
+	offsets->head = offsetof(struct io_uring, head);
+	offsets->tail = offsetof(struct io_uring, tail);
+	offsets->rqes = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+}
+
 static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 				 struct io_zcrx_ifq *ifq,
 				 struct io_uring_zcrx_ifq_reg *reg,
@@ -356,7 +363,8 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	void *ptr;
 	int ret;
 
-	off = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+	io_fill_zcrx_offsets(&reg->offsets);
+	off = reg->offsets.rqes;
 	size = off + sizeof(struct io_uring_zcrx_rqe) * reg->rq_entries;
 	if (size > rd->size)
 		return -EINVAL;
@@ -372,9 +380,6 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	ifq->rq_ring = (struct io_uring *)ptr;
 	ifq->rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
-	reg->offsets.head = offsetof(struct io_uring, head);
-	reg->offsets.tail = offsetof(struct io_uring, tail);
-	reg->offsets.rqes = off;
 	return 0;
 }
 
-- 
2.47.3


