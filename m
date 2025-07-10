Return-Path: <netdev+bounces-205942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB6B00DFA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F29587007
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3A290092;
	Thu, 10 Jul 2025 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Re7EmrHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88D28F95F
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183620; cv=none; b=jS8W82v8CAQrGB8P1PVHJVAV5S71GkaQksPfmONdwsMd8lVjg0aNP89qO23o9ldKZkyVTGOm3maE4XNEZ6hWistXnQC4PSSwJbr7ag2dooWHIZwNixthWqDjIdk66EVaqlGUWsiLf2flhpKwTnjjpE2Xl0ftl+PKy4+6GwsSQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183620; c=relaxed/simple;
	bh=wxAYHaGP0GYdIinjqN1JLMIvuwj3+4Ip8OakFVdWBUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDiCrgCYYNZgqPh/NxLusPlAfJKWdkt5mBMcZNgi+v6lwyn68neQ6gbZuOMQd1NpYLGoK3nknptcukajxRH7Wwn/J96dcOZysVuOBHvyhkM99pgiJ2vJKH5ek/M0Eq/2qL0yJ8nOhpHFnEQgaNlrmCBxZbO7gER8yoWG5INsSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Re7EmrHZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1183338a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752183618; x=1752788418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVGYqkoPvCfnH8pqsSFcE91f8N++sa66Dv3ITu0FMmI=;
        b=Re7EmrHZrK+fvke0wicyP55/RcXP8qZuuJC5jZFIYG+6z7w0cYe6qqOAdasA8vGLxJ
         lfD/NzwoMOW9PxIiDJDbXJLuCIa93SSsJtAYv1CebB3s4mRw/AYOPoLBUhLw7ZIjYk2Y
         wxgpPx1F8RIanFGFsJ+9Kkh86v5JohpKulhfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183618; x=1752788418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVGYqkoPvCfnH8pqsSFcE91f8N++sa66Dv3ITu0FMmI=;
        b=q9DNb1+am9HnC40gUxDHdgvC2TFtDCuzC1ncuRUhpVz/IO2kfpg9eyDOLW82KvrEY3
         bZrTxhzrkFFnVr1SVd9yjq4B7YJSqwVNBh+nDAjUqvTE0/gOQPqJusLQehpwsIAlKUu5
         45ZAw9mJ+Q+2bCzU7MAkGOob636rsCSXR2IE9aSHtKV7srPnA5zisdlZn2l0zWt/E+rL
         DLuV5z2QiAruzgzGctS3XRmRfcACT5FHJl6KOABc7gdXkpYm/OGPb3KGNlloGkNXpmh9
         84oG9GiKizTkNdrfRwCdEaiGajWbkYd3GTq2Ryvtk7A8/7zBeMvc3Tt4/pAOF12gwxBA
         QNcA==
X-Gm-Message-State: AOJu0YzSnBZd4zzvBpQTTcJ5gufYjCSsmJYe6dRIHFHSjuomV234zorj
	TVBd9brbYyAO41uqDCsLIYMx4Fm7s6qMyAsFKsvu96CpGHrrK91Woi1P9PQHCm/AdQ==
X-Gm-Gg: ASbGnctEn76dkk35y+v6nUzyjb3M5idvAiFFd/25+Vz+ECocA8pJBrit9Di6pNySWVf
	wBH95QHqe/3Or9oBGX32TJ2HXdvzI2rkg1iWWF0MkTvHMerwtfj2ili21sRJQrTFCyXfi0eV7qs
	P1cWwMf0FD/KfAo3PZJqA+1dY99HV54grQ8RtKd3+u187mIN3Wwjb6Hierwcxm/lbpE9m+mY5gp
	jiCKAQFdzWpIqOISlJr6PUE0hvbWiscZwFQigbTm6g+L6Ik6z6jFZg3EzIJPvMtrskaH8njQzMd
	htC//lrQv/RsQyAk8M+d9Yp/OLc0yv0uf86IlFKjOySCqHKfi0aX61LVpw3gysFe5rWnC27eI/d
	k5sOAmo4CU2PkwMSdVLmLm13PMHT9+EWowgoovg==
X-Google-Smtp-Source: AGHT+IG//cJPB6JVF0tlqmDaGPFm1shltPqPBvPF2MsWFrMiLJpNSNXPJyEt4N4p/5rT80OhudmrpA==
X-Received: by 2002:a17:90b:4cc5:b0:312:39c1:c9cf with SMTP id 98e67ed59e1d1-31c4cca45a1mr1312656a91.7.1752183618133;
        Thu, 10 Jul 2025 14:40:18 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e9581d8sm3358208a91.6.2025.07.10.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:40:17 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 3/3] bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT
Date: Thu, 10 Jul 2025 14:39:38 -0700
Message-ID: <20250710213938.1959625-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710213938.1959625-1-michael.chan@broadcom.com>
References: <20250710213938.1959625-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

When transmitting an XDP_REDIRECT packet, call dma_unmap_len_set()
with the proper length instead of 0.  This bug triggers this warning
on a system with IOMMU enabled:

WARNING: CPU: 36 PID: 0 at drivers/iommu/dma-iommu.c:842 __iommu_dma_unmap+0x159/0x170
RIP: 0010:__iommu_dma_unmap+0x159/0x170
Code: a8 00 00 00 00 48 c7 45 b0 00 00 00 00 48 c7 45 c8 00 00 00 00 48 c7 45 a0 ff ff ff ff 4c 89 45
b8 4c 89 45 c0 e9 77 ff ff ff <0f> 0b e9 60 ff ff ff e8 8b bf 6a 00 66 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ff22d31181150c88 EFLAGS: 00010206
RAX: 0000000000002000 RBX: 00000000e13a0000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ff22d31181150cf0 R08: ff22d31181150ca8 R09: 0000000000000000
R10: 0000000000000000 R11: ff22d311d36c9d80 R12: 0000000000001000
R13: ff13544d10645010 R14: ff22d31181150c90 R15: ff13544d0b2bac00
FS: 0000000000000000(0000) GS:ff13550908a00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005be909dacff8 CR3: 0008000173408003 CR4: 0000000000f71ef0
PKRU: 55555554
Call Trace:
<IRQ>
? show_regs+0x6d/0x80
? __warn+0x89/0x160
? __iommu_dma_unmap+0x159/0x170
? report_bug+0x17e/0x1b0
? handle_bug+0x46/0x90
? exc_invalid_op+0x18/0x80
? asm_exc_invalid_op+0x1b/0x20
? __iommu_dma_unmap+0x159/0x170
? __iommu_dma_unmap+0xb3/0x170
iommu_dma_unmap_page+0x4f/0x100
dma_unmap_page_attrs+0x52/0x220
? srso_alias_return_thunk+0x5/0xfbef5
? xdp_return_frame+0x2e/0xd0
bnxt_tx_int_xdp+0xdf/0x440 [bnxt_en]
__bnxt_poll_work_done+0x81/0x1e0 [bnxt_en]
bnxt_poll+0xd3/0x1e0 [bnxt_en]

Fixes: f18c2b77b2e4 ("bnxt_en: optimized XDP_REDIRECT support")
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4a6d8cb9f970..09e7e8efa6fa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -115,7 +115,7 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
 	tx_buf->action = XDP_REDIRECT;
 	tx_buf->xdpf = xdpf;
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
-	dma_unmap_len_set(tx_buf, len, 0);
+	dma_unmap_len_set(tx_buf, len, len);
 }
 
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
-- 
2.30.1


