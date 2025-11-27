Return-Path: <netdev+bounces-242397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC585C9021C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CBE3A9F2C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07CE311C10;
	Thu, 27 Nov 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLjFcnh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE1304BCA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276061; cv=none; b=fivZ3Ec4HMqN5O0Sc5q04ObeYxNItHhoWBJhpUfiUS1b7MH1cMIOfQT5nQEEmDAjrQO8qy5PlFfpvMu2buxYzg2xX1WRNUDAhOsdtXb5UGi2UngcKNCoAzYvq41KjzjnbH9M+Ppmqs6r1V1pnXNJ8qxr8SLmWyILapXIBHo18uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276061; c=relaxed/simple;
	bh=Mnn9wb9sRTkIJLXCShYMZgz7pZo/y5Y+Ja2/AUVncu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ID+aabQRX1ZwvmKmOwI1ejo8//BPlRb1MuJXZaq4SCNqNTboWgZ476kU9K/KkAcVtzhvLtRFtRUBr+k6XmWxmEjM3xmEjonYR8Ndsx8L8zJQ5jSQC0UpyH5BbsVWuLO5m/soueE9s7rD2lF7odP8Mfg2SDxN9CHST2gSKW/OE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLjFcnh6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so801810f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276058; x=1764880858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZrDwUzk1jhJojipsQHKrfyEq2t/8kD+pLesRqPqbM4=;
        b=kLjFcnh65TVvNis9UzA5QyzAMXh9A9nOmmEnsGJirYIiQjtpOXnbKZP6PGAgiboaw4
         7YWspoKxfR1ICz6b0akDzUW0Awf/KZwH5r8+HKWt234Rm2YTMGsTMOxSIuROehWE2iqD
         f/fbVY1/d64W679sRX66AqfSE6iyeRnZm5T7Qzio/akBtgYTPhBEKfWyadXF/9E1mrXI
         ATDc2a9O3JQFa/0nFV1G0GVAVTYf2lXqLeicH3P1AqWFgxhkQbhZ7UtR1qM7otsQOftj
         uupoSZP/aOEhaVb7uBg8tLwO4LaMj8Uw+9+5yKxYufUkMJWPzMkOig8WgG4T0Exs7Kfc
         uXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276058; x=1764880858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZrDwUzk1jhJojipsQHKrfyEq2t/8kD+pLesRqPqbM4=;
        b=C/rBtXPYl3rMwAQlHqTQZQYN1mLSXi7RYCdaKP/GZamkCFjLA1VCJPxU4JbMgzLO6C
         xfpsu6pR5jxR7AIusI5pfvezDZXKh+X9xzb0DPSmKmf8j4+PVG3I4NB+gX+rY3jsCP+z
         +etFrMw2Qz9LGR3hRrx7SwfZuQISIdQ4zR1kkG2uOthw6f7sPmFrIXnsAHsACkzdkO7m
         LOJsdMfr4qJv2kDUbMAzSTOEJoW+E3Vs3WzSDcYaBVzyLMjXSYGnKB6B3NDyeMDoiA9d
         7/Wa3T4G3w2tkpyEK6q411ja6RaMpLxEI1OhasldrByjCmrOZZqh9NPdfZPvWeUK/Q2L
         Zd7w==
X-Forwarded-Encrypted: i=1; AJvYcCXX93OO9Rt3IWZK+1uzACRBIXAHP6jQWDQVyJq1poBPHgliIe26ytYbKhUN3Bs+QqPZqTJprYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEapL1VlTOTpxJwNQkDvS2IQNEgrPB8GW2Zc9Z/BWRRXL9Qs+
	YqYBlXis0Ii8u1cw1DkocTBZ6phL3ReFhRVrIpfnziMJTvJ+mOh0iSF65Z8MFQ==
X-Gm-Gg: ASbGncvfHejWaxa8WkNdtdvTyQQLKMkF/vpO2pTbL+PIgqJExxsALV6aeaILOzL4L8J
	12e71pEUiULbZkpiSryef11c0TTo2nfQ8d3QSxPXLZaJlNcGP7jIEEA1SpYHsPn4Pq8GMWINQ9M
	g8/3ZxNXO9bTKUQ7uUbEd4dWNHEneAS301wu5v1Flx8zYfdFpkmr7jwlHsAVnODF09cvX0tWs+/
	VWc3H3ysL/wo4+YZ8pPxmSSqK+MmpM8yZlKdPej4poToz9iKdT0zwc2yOyPoUDerh37JVsCIwlI
	iNSvtjAkfGRDFI/3ZXV1fB2rx8WVEBedAyIJyIrlGBBmuRjDVoUVCSYyt4B3WBbs3PBLw6a19eN
	EhHygJ4oGK8cqmk0HBzKfhY1+PR6i03awJlPfFHBK89gh/he/AxdbIJAGUt6UxP82dBUrDy6OQM
	dvKdixQMuYjmcfOQ==
X-Google-Smtp-Source: AGHT+IGBTqkssyUQXy37QRTA7vMYiUC3UhkdYS3Gn35v/sgqJjvtbjsODVx5dVN3kGxZDzZmup4B9w==
X-Received: by 2002:a05:6000:2084:b0:42b:3cc6:a4d7 with SMTP id ffacd0b85a97d-42cc1cf825bmr27330752f8f.37.1764276058065;
        Thu, 27 Nov 2025 12:40:58 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a2easm5757423f8f.23.2025.11.27.12.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:40:57 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only] io_uring/zcrx: implement large rx buffer support
Date: Thu, 27 Nov 2025 20:40:52 +0000
Message-ID: <7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are network cards that support receive buffers larger than 4K, and
that can be vastly beneficial for performance, and benchmarks for this
patch showed up to 30% CPU util improvement for 32K vs 4K buffers.

Allows zcrx users to specify the size in struct
io_uring_zcrx_ifq_reg::rx_buf_len. If set to zero, zcrx will use a
default value. zcrx will check and fail if the memory backing the area
can't be split into physically contiguous chunks of the required size.
It's more restrictive as it only needs dma addresses to be contig, but
that's beyond this series.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

Depends on networking patches

 include/uapi/linux/io_uring.h |  2 +-
 io_uring/zcrx.c               | 39 ++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b5b23c0d5283..3184f7e7f1f2 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1082,7 +1082,7 @@ struct io_uring_zcrx_ifq_reg {
 
 	struct io_uring_zcrx_offsets offsets;
 	__u32	zcrx_id;
-	__u32	__resv2;
+	__u32	rx_buf_len;
 	__u64	__resv[3];
 };
 
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index b99cf2c6670a..30dbdf1cff13 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -15,6 +15,7 @@
 #include <net/netlink.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/netdev_queues.h>
 #include <net/tcp.h>
 #include <net/rps.h>
 
@@ -55,6 +56,18 @@ static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
 	return area->mem.pages[net_iov_idx(niov) << niov_pages_shift];
 }
 
+static int io_area_max_shift(struct io_zcrx_mem *mem)
+{
+	struct sg_table *sgt = mem->sgt;
+	struct scatterlist *sg;
+	unsigned shift = -1U;
+	unsigned i;
+
+	for_each_sgtable_dma_sg(sgt, sg, i)
+		shift = min(shift, __ffs(sg->length));
+	return shift;
+}
+
 static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
@@ -416,12 +429,21 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 }
 
 static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
-			       struct io_uring_zcrx_area_reg *area_reg)
+			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_uring_zcrx_ifq_reg *reg)
 {
+	int buf_size_shift = PAGE_SHIFT;
 	struct io_zcrx_area *area;
 	unsigned nr_iovs;
 	int i, ret;
 
+	if (reg->rx_buf_len) {
+		if (!is_power_of_2(reg->rx_buf_len) ||
+		     reg->rx_buf_len < PAGE_SIZE)
+			return -EINVAL;
+		buf_size_shift = ilog2(reg->rx_buf_len);
+	}
+
 	ret = -ENOMEM;
 	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (!area)
@@ -432,7 +454,12 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (ret)
 		goto err;
 
-	ifq->niov_shift = PAGE_SHIFT;
+	if (buf_size_shift > io_area_max_shift(&area->mem)) {
+		ret = -ERANGE;
+		goto err;
+	}
+
+	ifq->niov_shift = buf_size_shift;
 	nr_iovs = area->mem.size >> ifq->niov_shift;
 	area->nia.num_niovs = nr_iovs;
 
@@ -742,8 +769,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EINVAL;
 	if (copy_from_user(&reg, arg, sizeof(reg)))
 		return -EFAULT;
-	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
-	    reg.__resv2 || reg.zcrx_id)
+	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) || reg.zcrx_id)
 		return -EINVAL;
 	if (reg.flags & ZCRX_REG_IMPORT)
 		return import_zcrx(ctx, arg, &reg);
@@ -800,10 +826,11 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	get_device(ifq->dev);
 
-	ret = io_zcrx_create_area(ifq, &area);
+	ret = io_zcrx_create_area(ifq, &area, &reg);
 	if (ret)
 		goto netdev_put_unlock;
 
+	mp_param.rx_buf_len = 1U << ifq->niov_shift;
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
 	ret = __net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param, NULL);
@@ -821,6 +848,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			goto err;
 	}
 
+	reg.rx_buf_len = 1U << ifq->niov_shift;
+
 	if (copy_to_user(arg, &reg, sizeof(reg)) ||
 	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
 	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
-- 
2.52.0


