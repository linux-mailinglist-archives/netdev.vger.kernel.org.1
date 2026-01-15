Return-Path: <netdev+bounces-250268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15159D2636D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1D03028318
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46053C199D;
	Thu, 15 Jan 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh9CH+0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BE3BF310
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497159; cv=none; b=VWgnC+q1oX4ufepnNi7cocscFshHMYzFoVwFVovf104YfQz0APCLeCENl/piJXIssK4cwRr6B9hPPsOG2BYC2gef5Hy21IWdPmujtOIoAuqmA1buSssy5N7KI8tmIcYpUELRo6VFa0AQk+/4fsLv0UkwwtfsAozoYPU3a4NNIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497159; c=relaxed/simple;
	bh=m8NMYH4g6lQKcDnWsulwGjwfrhYH+1zKunQ0vgAfNRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTZkFfnntb/aLlXwt11bLEDxcuYGSVQ7pxgGtXglPyK75KHZBicxHrIyihwuLP8vtPV2FWYz2ChcD0Fus5PasghOfZyJIomR6cc/o4PrKjrA8ccwL9HPmQyCxU6cxhIejguPIrFldq8GY5CwXASuSfWFLzSNty/Eja7a9yYpm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh9CH+0P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so7293605e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497155; x=1769101955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz1yS4KnsLbiuKsdPkEkvSuKGyQ7NQwQMS3x7qa8DNs=;
        b=Uh9CH+0PtQFoy2xX4gBfxnddb1lL+DfYCnOwBWThGJGyKEhSKwlEOJD4+E9X0CnwSz
         pkLyHv82T0T+DMKi3nhFSclTexl9/CncwFV87UxsnoBcDzarZCMsreQzhQBEvZ3yJYXj
         LdZyv8Swohkgt1nr+PEYKOAut1ysA/XlKHcBC/nDWWksu+2qptZ+Ujf/6av7aIyJNtIK
         bw/doxp+F8kFjkCsakvon4Dut0+ACoS/Ca3/fBJsHyiWHvjIOmUSLQCHJqy/I/SEPL7b
         PFyb7EVK7oB5ApOBjDwZy/tsyfi2CJYhXUQaEeyIWCLt4vrZGrfZyqiA3G0a21Hj9TgT
         el3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497155; x=1769101955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wz1yS4KnsLbiuKsdPkEkvSuKGyQ7NQwQMS3x7qa8DNs=;
        b=NY5PJ0dsNuYxU9XTYhgtqSbCQr5h7oVlQznqOI2ghvY936vp1AZ/WRPG6i3G7jx66r
         oAg2mz0++FlUdIVqUx2efexMcXelkY2MRqkR7J1DrIXIy3YXxwLYThLdmWiMae0RPoiJ
         xgxb4dFl5jVSiMoVzUv2IB9+CSyUVCiZ4C4PUy1X8KtGk/ulodM6qZDfbflrOumHHdP0
         nb8Def742Fa49lWUF67df16MCN+kTy9zKx/kqngIWYejwVsqNYhJgetg1TUOFL89nW7R
         CJ4SDgnpQQgLGTcKjTI4lbTo9M/Qqtnh6aNx+qK0WlprJT/ij8Mw1H/p0GEgRP82/1y6
         7mKg==
X-Gm-Message-State: AOJu0YyJLeEmv3zqnViHsmUxBmDtikxEOWTm2MhtsvolYYaIe9rm574W
	SghLWzrBnXuV562awrH8uRY0IxSip12vnD5Lla3gc89Bqf5CU46FIlixBD69dw==
X-Gm-Gg: AY/fxX5YXwAJgJzr3lDIi5I1YcNxwahADKdWPMVzv+oo/Z+Skb3kik+e/K9MyRxJSaN
	wYyKAr5VIU7bCYTLTKcQBrcFhaCYemncxZGQ5dKMwIvxd8QzN/jQtWfVdN1zP1+CqoyOWEANNek
	NiuDsQoHF3nBoTFMS427i8kgDr35iLn8I3S+BuaOnMDL/2FQUt9OPr2X/NqYrPXuerDofL/25me
	rGKJUmMjNeLG1uDsvfb3RenyOqHFdCOGDFbPtWWBElMmjY0upEleznQocH1ZOuAZ97MAm4SY8yw
	6PcmQMi5F87xTULyHxhXNHQUN3BAkofnW8l4d23mreHbzLzg4CLqOqKKHW9/6UMletOiPqBv/H1
	PIjafRERy4edZuCS8n0ZVQjIlHKYE8eiHgrpLDVIoox6aw54bHO+Q1RoW36QIEfld716z0K+Uy/
	jj8e2BsHxX/92J9h4KsDMvKqSzhSUOhhJqK7pBVBJX8QrJgSnVWgtZmf3igemhyqmqTgSRrtWZE
	OS6XkDUAn7vmo1goQ==
X-Received: by 2002:a05:600c:1c05:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-4801e2f28edmr6191145e9.2.1768497155155;
        Thu, 15 Jan 2026 09:12:35 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:34 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 6/9] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Thu, 15 Jan 2026 17:11:59 +0000
Message-ID: <c55bf90a2112d7a831d8427034b71ff9fbb78285.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

The driver tries to provision more agg buffers than header buffers
since multiple agg segments can reuse the same header. The calculation
/ heuristic tries to provide enough pages for 65k of data for each header
(or 4 frags per header if the result is too big). This calculation is
currently global to the adapter. If we increase the buffer sizes 8x
we don't want 8x the amount of memory sitting on the rings.
Luckily we don't have to fill the rings completely, adjust
the fill level dynamically in case particular queue has buffers
larger than the global size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: rebase on top of agg_size_fac]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 +++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 196b972263bd..f011cf792abe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3825,16 +3825,31 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
+static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	/* User may have chosen larger than default rx_page_size,
+	 * we keep the ring sizes uniform and also want uniform amount
+	 * of bytes consumed per ring, so cap how much of the rings we fill.
+	 */
+	int fill_level = bp->rx_agg_ring_size;
+
+	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
+		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
+
+	return fill_level;
+}
+
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   int numa_node)
 {
-	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
+	unsigned int agg_size_fac = rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
 	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
 
-	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
@@ -4412,11 +4427,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 					  struct bnxt_rx_ring_info *rxr,
 					  int ring_nr)
 {
+	int fill_level, i;
 	u32 prod;
-	int i;
+
+	fill_level = bnxt_rx_agg_ring_fill_level(bp, rxr);
 
 	prod = rxr->rx_agg_prod;
-	for (i = 0; i < bp->rx_agg_ring_size; i++) {
+	for (i = 0; i < fill_level; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_agg_ring_size);
-- 
2.52.0


