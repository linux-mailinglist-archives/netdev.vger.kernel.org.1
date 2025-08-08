Return-Path: <netdev+bounces-212217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4CB1EAF8
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296A1161410
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5E288C85;
	Fri,  8 Aug 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SibvD3py"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AB288C11;
	Fri,  8 Aug 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664853; cv=none; b=hSKkq+mwlVV519C9KOKCCtDcXEtxthPWRF0cMzatsCLygs9UPoZwfMLWA0TUAVW7b6tC4G5Dwq+YqQto+JjAQjsyij4f7x+8DBNvrA1GnuBXLwVclYfHp/YNYSV65u90h/TStYyX+4mlYYZq85JeWE1r5cBi+hKNXoowR0V/CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664853; c=relaxed/simple;
	bh=8vq537iXmtQHfUOL8k8D+pDNLn1WmsjY+0Kmacg9zd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndiks7I/f6FiFSghizMpTPt8VGX5Ml6PoySM9TSzkPcDGtr3NlX+vc30AbZghcWkF1WNLplg5MLK/s5r73tdkypmPEErwbux8KKP7gCRViFQ1vXLJ2a0l8OuLuJUjOcWukqq+6/7DmkCNZjLwo9FxwF14Xna9HillESZaP+MBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SibvD3py; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so20828425e9.0;
        Fri, 08 Aug 2025 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664850; x=1755269650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi3R054eLGzZB1SabNcNvV4Hy2T9nutT+v4oQSkGFj0=;
        b=SibvD3pyAf3yqLG91z40P88GJ0adj189J+XRaLoy77ZKxso5t5DxevvjIj35ZTGG89
         1sOi+wXpJWFfF/7IfPdrjGQLHkvzKAvakwbNjlc9JnHPOrydqdKw7ZL5gy66A2tNiQ+2
         J3NOWQ0PAfhg/nd8pXiido2/dPzAySKkbjtCUZe6jYeM70k8Tj06u8Z47QioSWblNoFZ
         FR4MQTgCDQkDV1Rw8YIWZMsFPmgK6mJUjajBNP75wvPf67Yh01W8voe6F0Chut2OyFfM
         fE1MHEcF7JF5+AVzfEn+pfSAKnmK5ZgKN13BvKgCu5MLurS8/1Sv+Q56YF7t5XPfjbwK
         s4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664850; x=1755269650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi3R054eLGzZB1SabNcNvV4Hy2T9nutT+v4oQSkGFj0=;
        b=IEsbaN5ebZk9jstnWryqqBJW9LVUnjOHwCa0ni+j+dYy7hLUx0kW8owHM2UFTDPc0Y
         M36PeTRLiaFlfutZG0fJSqtaLLdF8UVHgLeBNCI9jSJTPd01VBTOdwlCkdsEq3jfmeCd
         jxAp47+TZWKhVpPIlLZInE4ATUSV9+6e+H6CXTQBvAoGYSdEyr+P6mJXvtrHf7FRlXRe
         d0Jqwv2qRuS2GJnzIjAmG6WQMi0ewCX4HP7zO3fhZevXhtVkzGE3V3w7o1+QVFEtApLg
         EcBzMMcR7PadOBFWHHCWF+I19HnnGh3UdYWc3r7YcCnCMOm7uZUuXA/H0uiNXeFX2sNJ
         8xyg==
X-Forwarded-Encrypted: i=1; AJvYcCVuLzLICbtIz511lh4Rt1ouZwPwt5UVuWbo1uN/eL+QU7FVX2OQE0cuayghDdo2WBSobudtLSBJ@vger.kernel.org, AJvYcCXfG5neRVOIsCJRp469xy5rVENbqYPvSPZJp0TVtkEDZa7BlFjDxZjSGPR5LgSQDgp58hZ0L8iiVitPvgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnq4WxJuifB0ulnJVPydtryusE91CmXVEG2IiBH8/XzROH9ob
	BpcsOgbYdpoJrVRBIYw8JSTdVZrXC0GTg5bx8QVHktmu6iZxZJFswHwR
X-Gm-Gg: ASbGncsfpJ5knNFh75krRuFzirRd8j4OWY20W54lw++XoQ7AEqUsp3CyMZw0fR2n+ml
	YX0GL3LfZ7gSCbkdxaXwXv+uskqKCvzN5DtbiTqx5sOQ+5lF61c32WbBXG0rrX2hhyQ9+cbxxrs
	LNUiqz7c/C02rI6sY9qnVzeeFj//xtRqe2DrCM6LqE+4A7Wci98hyUNqQ1cXYDWAX3EmBns42wx
	UVvOEhxV4okiGlTK3wS96VqjVtjnGwVImKbUa8VfSk/qbhcrTq8MSgGX63qe9lsOFm6t5yW8Mci
	tlAcGYE4bWWweIjlC8AqFVFL2IuzQmAko3rqstEel5wTyEdwzufhrYB95jWPG48upYvs2Gpj2gU
	ByA92xA==
X-Google-Smtp-Source: AGHT+IGMPQ91jVvZHMh0HVt2o3lPaz7U3vVo/p2d0l9PzffQJiGd5Fy99o/5a1kBMSlA7X+IjLZAJQ==
X-Received: by 2002:a05:600c:1c8b:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-459fb811f48mr154765e9.2.1754664850246;
        Fri, 08 Aug 2025 07:54:10 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:54:09 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 24/24] io_uring/zcrx: implement large rx buffer support
Date: Fri,  8 Aug 2025 15:54:47 +0100
Message-ID: <2e260f36b0430a76275e49a862b85de382633649.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
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
 include/uapi/linux/io_uring.h |  2 +-
 io_uring/zcrx.c               | 36 ++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 9d306eb5251c..8e3a342a4ad8 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -1041,7 +1041,7 @@ struct io_uring_zcrx_ifq_reg {
 
 	struct io_uring_zcrx_offsets offsets;
 	__u32	zcrx_id;
-	__u32	__resv2;
+	__u32	rx_buf_len;
 	__u64	__resv[3];
 };
 
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 985c7386e24b..90597547d632 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -13,6 +13,7 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/netlink.h>
 #include <net/netdev_rx_queue.h>
+#include <net/netdev_queues.h>
 #include <net/tcp.h>
 #include <net/rps.h>
 
@@ -53,6 +54,18 @@ static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
 	return area->mem.pages[net_iov_idx(niov) << niov_pages_shift];
 }
 
+static int io_area_max_shift(struct io_zcrx_mem *mem)
+{
+	struct sg_table *sgt = mem->sgt;
+	struct scatterlist *sg;
+	unsigned order = -1U;
+	unsigned i;
+
+	for_each_sgtable_dma_sg(sgt, sg, i)
+		order = min(order, __ffs(sg->length));
+	return order;
+}
+
 static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
@@ -384,8 +397,10 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
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
@@ -400,7 +415,16 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (ret)
 		goto err;
 
-	ifq->niov_shift = PAGE_SHIFT;
+	if (reg->rx_buf_len) {
+		if (!is_power_of_2(reg->rx_buf_len) ||
+		     reg->rx_buf_len < PAGE_SIZE)
+			return -EINVAL;
+		buf_size_shift = ilog2(reg->rx_buf_len);
+	}
+	if (buf_size_shift > io_area_max_shift(&area->mem))
+		return -EINVAL;
+
+	ifq->niov_shift = buf_size_shift;
 	nr_iovs = area->mem.size >> ifq->niov_shift;
 	area->nia.num_niovs = nr_iovs;
 
@@ -544,8 +568,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
 		return -EFAULT;
-	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
-	    reg.__resv2 || reg.zcrx_id)
+	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) || reg.zcrx_id)
 		return -EINVAL;
 	if (reg.if_rxq == -1 || !reg.rq_entries || reg.flags)
 		return -EINVAL;
@@ -589,12 +612,13 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	get_device(ifq->dev);
 
-	ret = io_zcrx_create_area(ifq, &area);
+	ret = io_zcrx_create_area(ifq, &area, &reg);
 	if (ret)
 		goto err;
 
 	mp_param.mp_ops = &io_uring_pp_zc_ops;
 	mp_param.mp_priv = ifq;
+	mp_param.rx_buf_len = 1U << ifq->niov_shift;
 	ret = net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param);
 	if (ret)
 		goto err;
@@ -612,6 +636,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			goto err;
 	}
 
+	reg.rx_buf_len = 1U << ifq->niov_shift;
+
 	if (copy_to_user(arg, &reg, sizeof(reg)) ||
 	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
 	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
-- 
2.49.0


