Return-Path: <netdev+bounces-242404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD402C90279
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02A3A9FB2
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9831ED92;
	Thu, 27 Nov 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DotU0Rr0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DE31A065
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276281; cv=none; b=opMVPZvNRiHJpn7sf3Tyb+BeuE15iyUrF15VIAL7SnhsLdhYnizBbrb8GyqtGKiMrqZ2qIzCuoQkFvtJVCNNps6spS4nf74AE04Md03PJ7yCLpnwMv6mn5cdH9dIBcXcL8V8Nj/8FyeI0cTOKsfzwkQwGe8a/Gv5fWuC2LlQnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276281; c=relaxed/simple;
	bh=D2EsVI2xh2ZhL05Tk+r0h3Pg9Cl/77LcPo6nKDQSuGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx43A7rRW/k5CAh7nHiX0h573q5SkxD+bQM8OJn7SJi/NP/EV+PcxF54XNCYxqDUAqyz4uF9oQf4UWcuLFU9HJheyir0RaSK7UFpy+ETxiYRAoSc41UJ5oQfqACFWuvDaFRu33zRbd/i7xgLUMfqkmcv7P3kPjy11o5n1uXX+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DotU0Rr0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32900c8bso826148f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276277; x=1764881077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy0XbKcemKbh0CcuwZvqfWEa3IvL5tyGOdRED1Ad+uQ=;
        b=DotU0Rr0wYeSWTrWjGX/hBXLnQeUJKMJjdb5kKAplXeQlnY0TpvGr0vyMBlJOvTUwk
         Xjgkiix19rVRe8+vvy8g9kTRuKDtzTXAWUsm9TzfgAbeVmVMaULHrPHsPnxqi2Ev2ioC
         c/xFZQQZzexZLpT+l7tmuwnRQK0/daDbEN9GbGVwrYiyAuzPS3cev62PXtoBd0H8P3A0
         NV1jpL/DnDOGmDI63j3gSIfs7Jv+Os52cf3gKKvNTK1G9l8Cxca7ZyJIMV7VSk2vOKGh
         s0wH9bBwWYbS4dj/u2VBgZtJ6xcsiFIVNAsuFkxcdueUhB2srfjlNlcNG/ekJVufYK5J
         5Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276277; x=1764881077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vy0XbKcemKbh0CcuwZvqfWEa3IvL5tyGOdRED1Ad+uQ=;
        b=pSyKfC13934RmPrVpTcuoN8JFLwBV+NefAyKLRWSPvTzxVqXzUXLbjm98Th81Gdwri
         yrDqkEGpuWMqNg4eJg6hWHwafxthds+YBp1nUS4qqsuoMICVxOjInh89K/gGmPwAZ+nV
         HJJbDL9tapwZ5g0rlfHH3QtdpFCA1h1C51Igui0KazHPoaOtzT7EpdJIbNxN9y/40Et2
         uXyL4Kk1v8637S76nsXU/sWpP70Vrwa8GvduW0uJIbNcgQwPO0W9o+LzQfVD1PcLskUV
         D/o7uOKeC/cPYU6T0j7natEfB80ocFCAdqYKEQICrWBjBOk7LAXwpGuDNJYoQLAS5R/2
         W2rg==
X-Gm-Message-State: AOJu0YxyWIn5TnpoJXxh+gq7hTa6nQqwFqVNRklb1Mo2VyzdIidTfCRn
	LJOtUgQsCgEO7N3xZG6eCNVYNa1rldnQMOGNRlMt4Yuj8yJHJxEWrDxR0vblLw==
X-Gm-Gg: ASbGnctZ23O3HAkDE+QZi8s6AHN9MkfqqM8rWI5a7H2tSgAa/USyYmDujW4jtvPtajG
	LxeooETT6HyAke+CpK1LuNsryDUjuj9LcnyeBvb3ACGYYbHIRihx8i0SNn8+y5dAzunzL9wzuD9
	6BYnCDVl0G43rMqLOQ4JwrXiuro0G8yhJ3MKCEgfnzv76XqoE0MrIPkoWY36WLHwv/r1KFS0yp+
	/3L1sw4YK4+jmbTo6yibtwcrc0AaSvPLz5ojQ7KfcyhJ71nkTwWZxZrXage/kn4EdhIv3YUcJqS
	xFz/7fRdTKW9+8w9K3jIxn6QiH4zfhE5zjMaim1XoKhAB8GxOq3d5Ntzd1PJNm0JxSk6R+RBaZh
	SsyWY7MQwww/7oIfSSdyCzQiDwvbjR/4F24fDwtYC2ZUAmFy+aSvCcWkfbEWiZQwflNwgEz4+Zr
	V/+Pp+To4ko2CevQ==
X-Google-Smtp-Source: AGHT+IE4EdepoSGguIef0SYCibCymaDm7WjMY8rUmVSyXGFaZ7vrRrlEhrAxCK+PPLWhSAF3UH6tKg==
X-Received: by 2002:a05:6000:2f81:b0:429:bc68:6c95 with SMTP id ffacd0b85a97d-42cc1d520camr29604197f8f.47.1764276277267;
        Thu, 27 Nov 2025 12:44:37 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:36 -0800 (PST)
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
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v6 6/8] eth: bnxt: allow providers to set rx buf size
Date: Thu, 27 Nov 2025 20:44:19 +0000
Message-ID: <9342d7dd5e663d3d44419229d6c9971b67e3f059.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement NDO_QUEUE_RX_BUF_SIZE and take the rx buf size from the memory
providers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 34 +++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fc88566779a4..698ed30b1dcc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15906,16 +15906,46 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static ssize_t bnxt_get_rx_buf_size(struct bnxt *bp, int rxq_idx)
+{
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(bp->dev, rxq_idx);
+	size_t rx_buf_size;
+
+	rx_buf_size = rxq->mp_params.rx_buf_len;
+	if (!rx_buf_size)
+		return BNXT_RX_PAGE_SIZE;
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		return -EINVAL;
+
+	if (!is_power_of_2(rx_buf_size))
+		return -ERANGE;
+
+	if (rx_buf_size < BNXT_RX_PAGE_SIZE ||
+	    rx_buf_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return rx_buf_size;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ring_struct *ring;
+	ssize_t rx_buf_size;
 	int rc;
 
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rx_buf_size = bnxt_get_rx_buf_size(bp, idx);
+	if (rx_buf_size < 0)
+		return rx_buf_size;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15927,6 +15957,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = rx_buf_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16053,6 +16084,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16205,6 +16238,7 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.supported_params	= NDO_QUEUE_RX_BUF_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bfe36ea1e7c5..b59b8e4984f4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -759,6 +759,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE (1 << 15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


