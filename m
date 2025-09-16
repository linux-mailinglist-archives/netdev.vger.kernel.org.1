Return-Path: <netdev+bounces-223577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A9B59A2E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A257A188DB97
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E628334720;
	Tue, 16 Sep 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVRiD5Kf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2532ED2F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032816; cv=none; b=DHDX4Jhu7f79b537AkkzA8VkuPnlQnPawIFyI5Vrwc5NHMPa3E2TpscYXMs8hJg+DG8sQbHYpdsYSDAJShF693go/ZBg7y+yTuLCxso4n6wwV3KZFRtzJRTqwOh5C8eJDtER3XiQKom3RyiB+9Td4Oj13AFmX1NOlqgLI5HXf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032816; c=relaxed/simple;
	bh=v5MfKTL5OaBB/TYhkrY+YTJ9ipou4p8N1M+WBJL1v/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCMvh3E6UMLRjJ7f4L9grKt3vku+I6+laDM4xPEaopWS2dwAkhufnrp/HlT8bLWPPc/GcL30jmpgBweZzYh7os20ONfHGBDvxn+N8nt1TkcxryKkHk4Zm9gcqhBO7YLxVBsnX327GkJTzUwXGzGxrRGxuxc6H2FmzbfwQsV2kmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVRiD5Kf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ea3d3ae48fso1628034f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032813; x=1758637613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVgwK3F7FwSjd75w6fCwZeFfF5ahI5kLep0RPJ8gENY=;
        b=LVRiD5Kfh9LVkuyhVXWkI+7HqmskYAnfX9pFq/cM86waF+ZX4KdXVfzbImDXJWVzwo
         it1OsTLUm0n6yclbHrgtBDsNZWLbWbiIZ2/ZX4QgAPf/AeAISAfCRmjv8XpDuv7AtuqF
         dF/EoXm7W6GzZWR+3t5Oj+4VXz4nVrWTgAi+IiJ0y+ktaseU9CASyUEWXBoh3f7jpMaO
         UYp6A/tYsE0X4R4YT3DiBbod2PKP3bpxnLoSuq6yR3YUGBzjB7Zw9JGmIHumV4v+Wral
         kGwLEfr7syoKcseWVWi3Iqc8qlwxtod+nH65RwVAbfol5ZkvqsKVz/to05G8lJYo5Ipn
         gGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032813; x=1758637613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVgwK3F7FwSjd75w6fCwZeFfF5ahI5kLep0RPJ8gENY=;
        b=kIw2wm3BAtEgp6rg92sR0pjC6ogvbyF+D6rM9wPUQVJA/xnmU6sdDvC58EuMBqM90U
         gFXBWS9kfHTtI0sbsvsDSiGYq6VTdXZJ4EzL93nLVq7P6I5AG5oCeewcwGfWtcxX7OTu
         OF/qDOTSeBzm2KwweQ4ZmT9glz4ZIRcFQZNHw+xCY9ZzydEzvBZyXjjr1mzsAc7XLFa4
         9kASuBZZ3nCzuUVS0szkTwI53V442Da7r/lz3hteuRd/gsGzKeJT0oXbpeOFgJNa54M9
         B6jmqf8kMspweHXH7lzhTmDF0v2/jJ0LQnP5jQzDtSVpIH0S63iR+11mNmsAS3Boyvgo
         v2/g==
X-Forwarded-Encrypted: i=1; AJvYcCXf34hCAe232lEu39QP0lELTYiHb7ypeGAgj9uIuGXeO6MJOhl+oY3Fsql46jMebdDCfeAc6uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Mz6CRWML5svIoMQr6p6Js03zCktSEAP/XvujBQgtog1J0Ph3
	opj7MERxaGlSofNlE0RHeXreBYgQBK2I0wPQGvFOyDIACQw/RcmE4VKt
X-Gm-Gg: ASbGncs9ImnzkM6jNJmst0ag0AOqBpKGtPrSF4+BeMrlEK/AGbG/14Mmexy0+rF48EA
	L0Sgy3VTkURu231NA3SmRkGDc7yAvT9PIpQFxqC/zbfWrlaJ9xa1mJ4J3YmD5Y4Ypi0hhZeR6X+
	OCN7r3IoksqcOq63aYONW9hjU2mnPY76sokRAAFbpkcx1dz6Jt09h/ld27BFkn/RwYK1NgIY2pw
	1PQe6QtWipitQQGWZ5tXU0qnszjqgdJZ/TwkrEBMuuapnvAg0k7uFAzoMtFelwkzk042AQvj1Go
	v1qVoN807XC/iUp4NTj/kcdTxQNyfVwmkD8okWd0KoO1VVl70s1ijosFrJm49OMngJIYjrGMUSR
	JkE3Cug==
X-Google-Smtp-Source: AGHT+IE1u83evQctNZDIG0xt/GdZk/rK5A1KJd2AoC65XklH57KuUcIfXPERofKD0uQTZLJDvK+37w==
X-Received: by 2002:a05:6000:1448:b0:3dc:2f0e:5e2e with SMTP id ffacd0b85a97d-3ec9e686554mr2742771f8f.13.1758032812530;
        Tue, 16 Sep 2025 07:26:52 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:51 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 05/20] io_uring/zcrx: don't pass slot to io_zcrx_create_area
Date: Tue, 16 Sep 2025 15:27:48 +0100
Message-ID: <6ce9cb89296cb3ca4828f1d82a5d6e31ebfd0dd5.1758030357.git.asml.silence@gmail.com>
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

Don't pass a pointer to a pointer where an area should be stored to
io_zcrx_create_area(), and let it handle finding the right place for a
new area. It's more straightforward and will be needed to support
multiple areas.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 7a46e6fc2ee7..c64b8c7ddedf 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -397,8 +397,16 @@ static void io_zcrx_free_area(struct io_zcrx_area *area)
 
 #define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
 
+static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
+				struct io_zcrx_area *area)
+{
+	if (ifq->area)
+		return -EINVAL;
+	ifq->area = area;
+	return 0;
+}
+
 static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
-			       struct io_zcrx_area **res,
 			       struct io_uring_zcrx_area_reg *area_reg)
 {
 	struct io_zcrx_area *area;
@@ -455,8 +463,10 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	area->area_id = 0;
 	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
 	spin_lock_init(&area->freelist_lock);
-	*res = area;
-	return 0;
+
+	ret = io_zcrx_append_area(ifq, area);
+	if (!ret)
+		return 0;
 err:
 	if (area)
 		io_zcrx_free_area(area);
@@ -610,7 +620,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	get_device(ifq->dev);
 
-	ret = io_zcrx_create_area(ifq, &ifq->area, &area);
+	ret = io_zcrx_create_area(ifq, &area);
 	if (ret)
 		goto err;
 
-- 
2.49.0


