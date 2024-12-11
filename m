Return-Path: <netdev+bounces-151142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FFA9ECFC4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C908167A93
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C71ABEA1;
	Wed, 11 Dec 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuhlBhi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE0134AC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931131; cv=none; b=WzfRUWUKZuOVz+h6JrW0LGjHAUV7LsYwgb1AMUBkywa1VxihRo9WT3XsL63z0eifU1Ni0Rh3+wQxN9r4PV4Zl3JVR28Hs3vjkMKtKrtLdeHDBUx+RyJj1eFdBD+BBDpR5v7Rol7JHYNLnzcpZGjLHWvUO/0K907iLgqprUqR63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931131; c=relaxed/simple;
	bh=ROV6gAJ72HepSe7VqiKDMySMiiQ8/V+aYPKFzp3BNs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvZsP4FSTFi5iWAE4aI0WdRvK2SLK7rGrPowNbf/hJ4tC2nLK2sboXSaTLfCFM+o7QHNLyiQ+gigRryzm1/R/XmZM6cdVew2HQF4yaxXHrpMWh9HpwO6+4LURc/F7i5jfc+DIo4if55kgA2A2msoBm0WEMxb3kGoz0uY5c03ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuhlBhi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A64C4CED2;
	Wed, 11 Dec 2024 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931130;
	bh=ROV6gAJ72HepSe7VqiKDMySMiiQ8/V+aYPKFzp3BNs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuhlBhi21LY7LlvP50LO4JRKHRzggagoRnf2Pppfij12bi5yjPbQeBybXTyuq7Ksb
	 051D+Zm9I+sc82lD7KhQP6HgnIpNB4eTNvSBg3Du/IZVm7ORiOiARtPuHtj4rWECaS
	 fipGJYnkA4sw4t7pXTTjMGBK1n7mrKxlZkfHeWR57C5XbaJDBVB1RobmmUwXMpgMiN
	 39oQmXROaH+6ofVvc4vVie8FITrgo6EBk2p3lmbGNsDQJuJ3SJZaqYxURUs03XEP47
	 DdfTPLii4GY3tw46HtO3xVKil1O5tNDMzTEBsWSjdm2asPttXzfynaMO/jKaNrUQmD
	 ZcbU7EifXIoTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: [RFC net-next 1/5] net: airoha: Enable Tx drop capability for each Tx DMA ring
Date: Wed, 11 Dec 2024 16:31:49 +0100
Message-ID: <7447d3ae100352962c6a0c967bfeed73df9068b0.1733930558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733930558.git.lorenzo@kernel.org>
References: <cover.1733930558.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preliminary patch in order to enable hw Qdisc offloading.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6c683a12d5aa..dd8d65a7e255 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1789,6 +1789,10 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
 
+	/* xmit ring drop default setting */
+	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),
+			TX_RING_IRQ_BLOCKING_TX_DROP_EN_MASK);
+
 	airoha_qdma_wr(qdma, REG_TX_RING_BASE(qid), dma_addr);
 	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
 			FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
-- 
2.47.1


