Return-Path: <netdev+bounces-223249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD7B587EB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096B8488A5C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668E2DAFCA;
	Mon, 15 Sep 2025 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSDytJSd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE12B2D7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977143; cv=none; b=Gy+ZVs60bX8ZaH1h41K0XGjOEO2i7WkHBsb636l17EEdXHrIg7buf5K7D4xGQ4BTdTyco65Ar5NDE1GWBFAsL4JO2tfY4aL7Nby5jRtUEa/qQfA5zJmz7T2lWbVmLd2AJAPsLm9MmKUon5LyK0N7YB+Cf2c9Ym81eIzL8qNTbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977143; c=relaxed/simple;
	bh=Hkl7Hrg9IFCZBYKnKnj3rKJzTmnbfDzbuHherwt+gR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkZbW2BZBf2VbUb+UyU8sNKRCUG6YQXDTPlGZ3NzX9lnbip7LEUc9rPr6sLI3xERFtuH3PiX0sovZ92a0EFrJ7cjyOGvOLsqgU0octK7EFhzQh4opbKa116DwfRerQ3U2twRvr6EpSy2Zx8d1BWXoUDNarmw8qsRmrgUj1hIE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSDytJSd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7761b392d50so3908286b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977141; x=1758581941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS72FUrrcjhUlTELkw2tpyEfgDIXEpCHERwaP4sAcqA=;
        b=VSDytJSdwp481YwAMcM1udnOKwW69fwD+8FrfCpwxbYBhO5G7G1SVLbHS84flYXjGa
         pnVbt+LkoHA67uC6v8HugJ6Eh9bRP/LpXknn4JkFF9T5wxJ1s61Yyd0lCipUJ7TQOObK
         4kff70JKPPoRfBtYnQU68+IFT+bsbiTWfxWBeF++S3jvogqf07qTEPHH9Me5gg527v9Q
         J+esn2K9kjqwKfJcQ67o/Jp22egN7kZ4yA+wDXJWUKOIqCvlfJONK3VvKPxtbh1iI5o+
         ZL0X7J8/pCQDt0izTfUlnlvqzcAc/B9g+2kcA2OwxK7h/nk7LoyhEm/2yKiEapcLki0D
         XXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977141; x=1758581941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS72FUrrcjhUlTELkw2tpyEfgDIXEpCHERwaP4sAcqA=;
        b=fJRmuD5nq786vWWP2I4Hqo+HooMfTWmQOOPlkN2qosmDOT6jzcl36T1NJNOrLRSMav
         T2RVtQmNXs12eig+vT11taDODkfW3p9CRO6kMvEvsou9eYjN8savKh0uMSSAW000ljMC
         TcBt/QZV9pPgGubUBKcyHJT4rHNqJe1HA8cNtp9SBpVOLLhLNxN+hJywpIDqkKhoEPgL
         7xbC+MZxw3HpOyaXkgFLd3P8HSpYXtnX7/EW+PNKGyeZObe0RvA+SvR/meeykv0l6YK4
         sx7jVQ7IW41kn4YW6CLkXb6e1jueG+eVkB7I3rTHjNa0cQybJxTyp7pstIXDvncKBdYd
         RjSw==
X-Gm-Message-State: AOJu0YyaFJWJj8dupnRiL0oGl0FAmBfYztiK22Qm9lJ+Yi85nTb33w4Z
	lC4zxyiSmFXZ7yAQuVqAy53EvqbKZczLWN/aMo8vBZdL2i55SOEQNRERO5804A==
X-Gm-Gg: ASbGncvl9ZwSvgdNdMk+HiHv0+S7bLQPFpsQVrFvIod5vxxWddKx7mJ1oeEh+wxcbo/
	uHFwyTrXVTCQKuSH8gYdbygjoC4koZeJZ+rlzrA2qBmFiI7uKgu5e+A8oEDSXTfwR4rTiR3ry0F
	J7CWgzSbXkIhdYa/v9AuyCkpLvfrvly78Q7RfZJXKaYmoQ0Roy+djvt2eLSXrMB6CVIILVEYEsT
	Fi8RbVBpCnRoNakkGef5cvVPsnCmgkSNR5LwAH+i0vJYvkLAumsrmbNwbtxkZhiR4EqSlRnqXol
	SwJy9iQZEFL73zYdXQOsmHjE9JW/mw2H37UeCGULM3IGlb82rFK5uoG8xnM5IrAqEyimYhBm3Qg
	P6JO4VTn/dh3Cx5NwjoPY3YI=
X-Google-Smtp-Source: AGHT+IHKP8ioierObvVqSiz84UtnesEULzdgz8cFdan1n6u2IG9xL8UfAUyAkVOjV0biNTBODJNixQ==
X-Received: by 2002:a05:6a20:3949:b0:262:af30:e4c with SMTP id adf61e73a8af0-262af303e80mr10211981637.53.1757977140912;
        Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47310sm13959355b3a.27.2025.09.15.15.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:59:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	cpaasch@openai.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net v2 2/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ
Date: Mon, 15 Sep 2025 15:58:57 -0700
Message-ID: <20250915225857.3024997-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915225857.3024997-1-ameryhung@gmail.com>
References: <20250915225857.3024997-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP programs can change the layout of an xdp_buff through
bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
cannot assume the size of the linear data area nor fragments. Fix the
bug in mlx5 by generating skb according to xdp_buff after XDP programs
run.

Currently, when handling multi-buf XDP, the mlx5 driver assumes the
layout of an xdp_buff to be unchanged. That is, the linear data area
continues to be empty and fragments remain the same. This may cause
the driver to generate erroneous skb or triggering a kernel
warning. When an XDP program added linear data through
bpf_xdp_adjust_head(), the linear data will be ignored as
mlx5e_build_linear_skb() builds an skb without linear data and then
pull data from fragments to fill the linear data area. When an XDP
program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
data size and trigger the BUG_ON in it.

To fix the issue, first record the original number of fragments. If the
number of fragments changes after the XDP program runs, rewind the end
fragment pointer by the difference and recalculate the truesize. Then,
build the skb with the linear data area matching the xdp_buff. Finally,
only pull data in if there is non-linear data and fill the linear part
up to 256 bytes.

Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index fadf04564981..aa1368698a40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2016,6 +2016,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2069,7 +2070,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2085,10 +2086,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2099,9 +2105,18 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) +
+				    (nr_frags_free - 1) * PAGE_SIZE;
+		}
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2126,8 +2141,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-- 
2.47.3


