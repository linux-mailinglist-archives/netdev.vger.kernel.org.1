Return-Path: <netdev+bounces-212797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577B3B22008
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF8686F20
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79F2DECB7;
	Tue, 12 Aug 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXL0/bnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933F2DEA7E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985325; cv=none; b=QapCofCoPSZCxAf/aeF8+i2NeX7xafgdDTWe6Ep5V8r5oz+L1/TunU9oXE0v8Kmv1KqeGG9hLjk6lJFaOgQywlCppUABLMXA5KeGinYHCKFlHdod91h4F48vKdUnQjK/f3NU5Qo+hhLuTLeje2xll3vqsy1tY/iC3byFYFS7qsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985325; c=relaxed/simple;
	bh=mrhy9PQiLCJM+jUKKR0YXlw0H0B+XyoLb0acCxub5JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqpapDKfXRuPx3G0E6boarsMchpoGhbmFrg/YNHRlyY/HYcHneCQwKzLSmebFz1aS6VcjTCEl87dHYL0THXune6qo8nHcvcPD0iwX3Xsf208PnB+D7N+JyRhN3S62MOgv1/gO+ipbwUTPlVqS81UAAEFnYwCLBIbkJfy1qPStCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXL0/bnd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4233978326so2891316a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985322; x=1755590122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nua+Saoq3cgdpcV2SyDKodrQAeZWBLQm1joHhSepEdg=;
        b=GXL0/bndnOcyVV6ZZrpl60u8C/ZKu/657t/HlIcfm78bzdiQo1uL9rzYye2rb08BMW
         8nrrdX5HDxXckkp2Yeqw08reUwK5t86EmVGj8T+FejKrSFSxSQ+RL3IBzFSDIuPgzbG9
         Un2AZFgo0xdtUnelGF38tiFhYg9GabxMecRx0atjoB3ZpqFHGht0IdVFnqppHdKeujvo
         DvZs6dZ/njlenW0FYdKO7thtR5/pB2n7kOAr6LcEnw8O+u8VARe/H/8e12ouLi+ABhI8
         ylvA1AMaLXIq+5toMatqoD4XOihd2lq/10/FgksFyOWXYOLODoJBT9iqUBVTYsVW0/Hg
         lqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985322; x=1755590122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nua+Saoq3cgdpcV2SyDKodrQAeZWBLQm1joHhSepEdg=;
        b=QYBEOW8Remtj9A8yHZ0TXPzTP+d3JDAJLkU/ro/gdTRoym+h40APcURoyswDoMH6kn
         D6yh7qN+xOWrz49QXYiRAQDfj3lrfwHe8/odHClx34LRYI7wtjHB/dtj4tu7Pjl3FQFv
         DUjwXSGQHkY95i7wpOsfvMxJ4BYAp7SwX9JUFkgTCT48LntuTNJyeCcyKVC51jjjZqCC
         BpbInlSwB2KguiJGBl4A5D9MsSFWfz/mcinTMdIqnFe8WoxSzgwauWxhK0Juz5OK0qmW
         so2A1BD9TitvWymPjRiHMCH4QTJ3CDlrl2I89zDlG+6gO0PaKmYDOl8+DkqQ3G4/36c7
         hllQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyV1gE95PH8XM72yzUPF607pfNF/VanZA6c+y99QBjj/BlEfuhr4shZOYFtoguMcipZOUiBGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpRosH8Hsy5Hm9Q0aw49uurDJSYZheEpzlsBJdlq3ZLrrSRwF
	HkSxBne0j6CCCF+ZugEuiPSAusvfP2us5InUZzhW8kd1e9Zp2n3MGtqJ
X-Gm-Gg: ASbGncuWf4SYSSbzPlLUkFj7wNT7gv9PfmGTx33B8bbABicL7nMZvCx416DcN8wujkC
	ln+RDkXLXvs/hAF5Hb0f/YpA6YYO9ck2DMeztRa1eoR6IQM0M+wCrZftnl79kgZbAEopLZm+HBj
	IBZaCGnYk/syvZ/8eqKC8j3mNIkp+NKm3sqseXKmiZ4h6K4k8on5kRtWs1zmcw0OLlvh0bI+ISs
	ELxE0ZCPFesZRzNcad82HCLH7BDV5PJMOhnnlNjbYX4Bl0p7uNaX8DOU8hBwYqqGlIJnHRyKJRZ
	fEDOtHCmTNN6c7psKnyn+yLcKsKc1wdY/1LlkupFm/seY1kuLpcqaOC4tGruKe0yyebHPC4ylbq
	VExO9jJEEY/KG2V51z4J7jwstvvV/QlZmayCOiH9j2KJseyXgrImZIWpDhbOnJOWXTM6yQAWN4O
	8ESOzS
X-Google-Smtp-Source: AGHT+IF56R6elMTGuSLc1ld1mjtxGYvTuPLn+GhWA2a1eQT6shTy4jObTSd5VfzNjYgDUxkBjIuwYg==
X-Received: by 2002:a17:903:2307:b0:240:a559:be6a with SMTP id d9443c01a7336-242fc33d8b2mr36827355ad.34.1754985322047;
        Tue, 12 Aug 2025 00:55:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac12d4sm24651320a12.32.2025.08.12.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 00:55:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	sdf@fomichev.me,
	larysa.zaremba@intel.com,
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH iwl-net v2 3/3] ixgbe: xsk: support batched xsk Tx interfaces to increase performance
Date: Tue, 12 Aug 2025 15:55:04 +0800
Message-Id: <20250812075504.60498-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250812075504.60498-1-kerneljasonxing@gmail.com>
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like what i40e driver initially did in commit 3106c580fb7cf
("i40e: Use batched xsk Tx interfaces to increase performance"), use
the batched xsk feature to transmit packets.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
In this version, I still choose use the current implementation. Last
time at the first glance, I agreed 'i' is useless but it is not.
https://lore.kernel.org/intel-wired-lan/CAL+tcoADu-ZZewsZzGDaL7NugxFTWO_Q+7WsLHs3Mx-XHjJnyg@mail.gmail.com/
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
 1 file changed, 72 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -2,12 +2,15 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
+#include <linux/unroll.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 
 #include "ixgbe.h"
 #include "ixgbe_txrx_common.h"
 
+#define PKTS_PER_BATCH 4
+
 struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
 				     struct ixgbe_ring *ring)
 {
@@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
 	}
 }
 
-static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
+static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
+{
+	u16 ntu = xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : xdp_ring->count - 1;
+	union ixgbe_adv_tx_desc *tx_desc;
+
+	tx_desc = IXGBE_TX_DESC(xdp_ring, ntu);
+	tx_desc->read.cmd_type_len |= cpu_to_le32(IXGBE_TXD_CMD_RS);
+}
+
+static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
+			   int i)
+
 {
 	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
 	union ixgbe_adv_tx_desc *tx_desc = NULL;
 	struct ixgbe_tx_buffer *tx_bi;
-	struct xdp_desc desc;
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	if (!budget)
-		return true;
+	dma = xsk_buff_raw_get_dma(pool, desc[i].addr);
+	xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
 
-	while (likely(budget)) {
-		if (!netif_carrier_ok(xdp_ring->netdev))
-			break;
+	tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
+	tx_bi->bytecount = desc[i].len;
+	tx_bi->xdpf = NULL;
+	tx_bi->gso_segs = 1;
 
-		if (!xsk_tx_peek_desc(pool, &desc))
-			break;
+	tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
+	tx_desc->read.buffer_addr = cpu_to_le64(dma);
 
-		dma = xsk_buff_raw_get_dma(pool, desc.addr);
-		xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
+	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
+		   IXGBE_ADVTXD_DCMD_DEXT |
+		   IXGBE_ADVTXD_DCMD_IFCS;
+	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
+	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+	tx_desc->read.olinfo_status =
+		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
 
-		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
-		tx_bi->bytecount = desc.len;
-		tx_bi->xdpf = NULL;
-		tx_bi->gso_segs = 1;
+	xdp_ring->next_to_use++;
+}
 
-		tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
-		tx_desc->read.buffer_addr = cpu_to_le64(dma);
+static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc)
+{
+	u32 i;
 
-		/* put descriptor type bits */
-		cmd_type = IXGBE_ADVTXD_DTYP_DATA |
-			   IXGBE_ADVTXD_DCMD_DEXT |
-			   IXGBE_ADVTXD_DCMD_IFCS;
-		cmd_type |= desc.len | IXGBE_TXD_CMD;
-		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
-		tx_desc->read.olinfo_status =
-			cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT);
+	unrolled_count(PKTS_PER_BATCH)
+	for (i = 0; i < PKTS_PER_BATCH; i++)
+		ixgbe_xmit_pkt(xdp_ring, desc, i);
+}
 
-		xdp_ring->next_to_use++;
-		if (xdp_ring->next_to_use == xdp_ring->count)
-			xdp_ring->next_to_use = 0;
+static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
+				  struct xdp_desc *descs, u32 nb_pkts)
+{
+	u32 batched, leftover, i;
+
+	batched = nb_pkts & ~(PKTS_PER_BATCH - 1);
+	leftover = nb_pkts & (PKTS_PER_BATCH - 1);
+	for (i = 0; i < batched; i += PKTS_PER_BATCH)
+		ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
+	for (i = batched; i < batched + leftover; i++)
+		ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
+}
 
-		budget--;
-	}
+static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
+{
+	struct xdp_desc *descs = xdp_ring->xsk_pool->tx_descs;
+	u32 nb_pkts, nb_processed = 0;
 
-	if (tx_desc) {
-		ixgbe_xdp_ring_update_tail(xdp_ring);
-		xsk_tx_release(pool);
+	if (!netif_carrier_ok(xdp_ring->netdev))
+		return true;
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, budget);
+	if (!nb_pkts)
+		return true;
+
+	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
+		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
+		ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
+		xdp_ring->next_to_use = 0;
 	}
 
-	return !!budget;
+	ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - nb_processed);
+
+	ixgbe_set_rs_bit(xdp_ring);
+	ixgbe_xdp_ring_update_tail(xdp_ring);
+
+	return nb_pkts < budget;
 }
 
 static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
-- 
2.41.3


