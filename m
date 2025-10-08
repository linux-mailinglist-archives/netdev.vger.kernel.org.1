Return-Path: <netdev+bounces-228225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AEBC5241
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390B03B4472
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E127A900;
	Wed,  8 Oct 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drjZmQC8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D61224B15
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929082; cv=none; b=N5gVZnyVqnpWm68pIAP2STEiaqO3dnTuEh32qp5b2fUPVHCnexm/l2PnSxTvi0Iv0kihh2fF/52vyFXG1vOV/l8UIIkri9uJ/l0sHqY75eTf6nEMJLbhE5weYmvS/DKqlmDYElKU+O+1Y++LoXl6jjntFh+Hjwd5ueTqcBFNj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929082; c=relaxed/simple;
	bh=Tppkg4MldLBgBrI9SzjD/Q3iLLzNpMq+oU6yavdK2rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBlAhDjkXriLQQCeoPPrIjgCEY89pizKq4VZ1+aVEyP7vdpjSc71CUm6+OA243j7Vo6ngpGpLbhuiE/CYlX28PdhFF+AohtMskP76lWf5kM7QEQ/71vSraynqqadKZaJvROSxB+MgPO4ULkj+M1CD0cISRyS4lB7FzSX9GXZjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drjZmQC8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so70022305e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929079; x=1760533879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCUt6DzpwFo9y4KJ0twUr3sa8Mj3ShUrbI048KiFl/Y=;
        b=drjZmQC8Sxzpb1dNxNmqlCidmOUTwJc8QaWo9puvsn/C1RC43MPy1M7uahRQ7W/HwU
         DjRqcc1vx/m7BVFDyqBnl/wgAQq5q54SUy7e7RloOUzWxWjU+/PZXlAuwuAojggUa3s8
         6b89QVUWEFg1tTd5wmVhNohRICpo+h1XxCUU4nCzH0f/pjY/RFQTCtULNQlq7Tdp2Y8D
         ya9V5qT/SJEOq17zu7/khAdfec2aoZzARINS23bm0LGnlebx9s6ndFSUA6vqBarfQUwY
         MtuzbpMzPoUXeBw4Hqh0P8rJym36o7Y3OkhAWVCMZlW9sNH4Ev6/yLVBqX9OZRDsIE3s
         n1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929079; x=1760533879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCUt6DzpwFo9y4KJ0twUr3sa8Mj3ShUrbI048KiFl/Y=;
        b=XJxLj/sdr74ueLC2s3hK45emrIFAYHDCNkdBGZj3z8/8NODuO9vflM/V/55TVjef8N
         mpBMLBY/HC2vvpQth8sHOmSnbhxECFEOO11PpJHbg9TmmQKlfhKs8QuSBaKEcaVcCBga
         kg9Q2EgYu+1fPGIBo7rUmQlO56dExss+soXqSO9dX/IHYf2aqO9oqBNAH1q/HCsnBiDn
         MvL/LhKBpI9Df5Xyd5sNeej+h7ed3zKAT/a80Xf/Txp8D3mpXWHk2X2u5WlftUwfNHGA
         Ykp6vayZZhgI9yWZ12ilsFUvogJ3xIePjBZ5M4Si1EP9pokXHXpRyxtKuqJjvD1W01yJ
         gvaA==
X-Forwarded-Encrypted: i=1; AJvYcCU8r7K/an1OolcvsI0NoRB99fiyb5W7QgIR/Ej1xKt/inoep1P9yOQQgMAngKroZrzQRkLjBwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPq1YjDwmsJu9hskP8fQhF9vIjdx8p0/wslcCNH1IRPijwzRa
	XYcNq5dmpCFEGgluWn2oyJCdOoR42c8jfV/qMp8Sv9mTboKV7D3IUsAO
X-Gm-Gg: ASbGncvnwH98TNdcWGLl/PdfIhcIARt8WgMfTNpd8w3xN28Fb8WHBjlfPtDfHEgEZ0k
	VG8t8joGnusBpL/Pjxr9MK7ugDbkWxGDkTf8toZA0wG9EQIcZN59iftx0zGRR7pTpIDl2dTUvGa
	NO2BUi41essSkAmRlEm7tgDt+0zXRuT5F5U/8TNobiL9shW9AjiIF8zO/k2lPlqBR6wio0jPyjW
	uff4qQgc/aJAqhsrYlnLnW0LWdSbWvfuIACuPFLbbcRRQHkkvOyrVmcWC2ZgkHjECkmIb5PIztq
	bENfmzXY83J1GQ0g3ooSJufhrCTwtawsubNEWXn8dyLi5SB33LkC03xc0QvF90ts+YlKcy+t9zX
	Q/cmH+W4/bfEfxchu/yiZSyAOVktt/Q==
X-Google-Smtp-Source: AGHT+IEMbpkJORbR9U87Ksq/ylpHUVCrODH14lyAZjRiCv7BNmRTB8rOUnB7+aOI9S5r62TUnrJM4g==
X-Received: by 2002:a05:600c:34cc:b0:46e:59dd:1b4d with SMTP id 5b1f17b1804b1-46fa9aa2076mr36974385e9.16.1759929079035;
        Wed, 08 Oct 2025 06:11:19 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:b002])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cd658sm14613725e9.1.2025.10.08.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:11:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org,
	Byungchul Park <byungchul@sk.com>
Subject: [PATCH io_uring for-review] io_uring/zcrx: convert to use netmem_desc
Date: Wed,  8 Oct 2025 14:12:54 +0100
Message-ID: <2ea0f9bd5d0dbc599d766b7b35df4132e904abc6.1759928725.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert zcrx to struct netmem_desc, and use struct net_iov::desc to
access its fields instead of struct net_iov inner union alises.
zcrx only directly reads niov->pp, so with this patch it doesn't depend
on the union anymore.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 723e4266b91f..966ed95e801d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -693,12 +693,12 @@ static void io_zcrx_return_niov(struct net_iov *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
-	if (!niov->pp) {
+	if (!niov->desc.pp) {
 		/* copy fallback allocated niovs */
 		io_zcrx_return_niov_freelist(niov);
 		return;
 	}
-	page_pool_put_unrefed_netmem(niov->pp, netmem, -1, false);
+	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
 }
 
 static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
@@ -800,7 +800,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		if (!page_pool_unref_and_test(netmem))
 			continue;
 
-		if (unlikely(niov->pp != pp)) {
+		if (unlikely(niov->desc.pp != pp)) {
 			io_zcrx_return_niov(niov);
 			continue;
 		}
@@ -1136,13 +1136,15 @@ static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
 	struct net_iov *niov;
+	struct page_pool *pp;
 
 	if (unlikely(!skb_frag_is_net_iov(frag)))
 		return io_zcrx_copy_frag(req, ifq, frag, off, len);
 
 	niov = netmem_to_net_iov(frag->netmem);
-	if (!niov->pp || niov->pp->mp_ops != &io_uring_pp_zc_ops ||
-	    io_pp_to_ifq(niov->pp) != ifq)
+	pp = niov->desc.pp;
+
+	if (!pp || pp->mp_ops != &io_uring_pp_zc_ops || io_pp_to_ifq(pp) != ifq)
 		return -EFAULT;
 
 	if (!io_zcrx_queue_cqe(req, niov, ifq, off + skb_frag_off(frag), len))
-- 
2.49.0


