Return-Path: <netdev+bounces-229229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8CBBD9820
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7143918982DF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B97314B77;
	Tue, 14 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jso8Odz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0129314B60
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446841; cv=none; b=pFwVfuAskAoM+OBU0pV3r1N1OOYrN3VfY7dsjKSt/UNh7HJvlGugERf0QTFPoc22MpncvArTnmQ5qUr8/KsaOdxMcHjBH5mlXtF7EUKRAy+LbNf1B6JoxGdf89FlVEj0YHseZSLpSET/PG57VqgFxrbiRsI4PIwQf9nd4+xVF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446841; c=relaxed/simple;
	bh=JM6u3rhenlQZWL+x7CQ4y9MfGHKPZFCJcJabv3mo818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jmm/m5SM5/C3dKUqwxjXz3IbjOOUGcN9Z+IFr0xWMzuU6Vw+Xi0dRBFe39p5Qc7RVvfdGNsREk7YAR+MzbCxK6VLsqesqLD5+wFdBtIJPIZfmYasI0PWdth+GwN5KBoi+iPNPURMc4HCjvpq5kAO/gcr+iAkDfaKs9qItbOrmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jso8Odz1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4218233f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446838; x=1761051638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo/Hffm+GCU38S4s9L6o3lMbhm24x5k4XXoTTrdb28c=;
        b=jso8Odz1yFP3cru5SQvAzTlVeY1SzIsJPQ8CL7JoJKQRHFnLimrxUNtmu6VNhitd8o
         GCuDy+YaHfp9v2I2vlBdhwNRQZcVoqJF2q7BLe90chXwaDPLFkpRIBVEYK+9qhMM5BQL
         RoMpA8nd8FkFrSi9bbIZfTrbSX4Q3Vak0SeS5KMx8aZoNbVikx7eOhHQ9w2WR/biZpnK
         9FkMIzaBwo/Jk8vNg54u0T7Au071mqsgeV2aNMNWMu0XJf8f2Tw7Zrx4mXoqnxYnaYfv
         eiwCkOTURKBRyKn0cbDWDW31dORZLKQnGyigivywUGF/spGxo1Q9ke0c/CX40SHjKwjW
         mFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446838; x=1761051638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo/Hffm+GCU38S4s9L6o3lMbhm24x5k4XXoTTrdb28c=;
        b=jWkaAwQ15NeF9O77aKiRHnD4y6PlYccXTxe1FgQZzg6OZ1ce9JYQNCt4tNXxvvw4My
         SxdGmAszlSDP9u1qZokRiMR2wGyl5c28vJTRhjRyBmZ3sVGJllRjolXDhaw3aFvfuDCq
         OSFUWQJn0Gly+GaHi0DAJbxiSLYNI8ma8wHYsj4qYh9jndBfA/7mwEDs5ExGFWWca0DW
         21UepAEkn86KlBaQNVu3hwqNdDuOO8VFPbFF9qgJdpfdLmeuP3QUe+zUXl4wqZaoRJ+B
         3XAxWdme3zWwXnLtAG64JLZSSUJMitZsH4E32tgKi+w8QBbVjQ20X+fjK0R56b2qGx6U
         hZUg==
X-Gm-Message-State: AOJu0YxmGuJDaUtnnBtpJG1K8y75QE8qAz2/+s0Y+lhTgzrYcqCe3jVy
	8I97Be6kTu7MPzFPWRlaUDEGO9GC7gBMJJPFA6LQBHH++nZjdHlMoA25Rr2VvMpT
X-Gm-Gg: ASbGncs689LNbzEvMZrKOsfrAkZyXA28U/ILRNW+Bm7vkGLnX4CHAPfiFVOFwsb2tSY
	EBqOn8m9Wpjf1H5eB0iJVRRrvB1qQibetLo4Yvjt0/3w0D3YaZLvWr8CM96zsOgTos27vtr4KyY
	YIPSWxERMbJBOG86lVAUUoHg0NIIsNORrDWYYU90kaWHCfO97mWGfrYIthJ7CbWVXAUmRIf1tVz
	GBgOSGztsRT93fekjc2iE2vTd1mMEdZsgez/ZKq7pEdvJF2TSc6iiSb0C202u/zmzgcEWoohvDr
	zFF0SkBh48wkaVMK0nzupg2eEhBXEFx3IeuuxgQXukoZfEvzUeDhBwPUkbxKaOfRv9JiBytutCM
	aQxIrauDT41eSUETG19cUcwGT
X-Google-Smtp-Source: AGHT+IGhSZFm38F8sVCM0Ux5ROYmcmMusBWqctwDSzojJka/K/RPf3AoV/TQmhhmAwvujH6biaI4iA==
X-Received: by 2002:a05:6000:601:b0:3d7:2284:b20 with SMTP id ffacd0b85a97d-42666ab296fmr16323066f8f.3.1760446837436;
        Tue, 14 Oct 2025 06:00:37 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:36 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/6] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Tue, 14 Oct 2025 14:01:25 +0100
Message-ID: <1a9ae7fc9d06111b14f29d0b81ceae9841056bf9.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760440268.git.asml.silence@gmail.com>
References: <cover.1760440268.git.asml.silence@gmail.com>
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
[pavel: rebase on top of agg_size_fac, assert agg_size_fac]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 61943de13774..950e60d204cb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
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
+	if (WARN_ON_ONCE(agg_size_fac == 0))
+		agg_size_fac = 1;
+
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 
@@ -4403,11 +4421,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
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
2.49.0


