Return-Path: <netdev+bounces-154989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A5A00923
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD83163715
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BAE1F9F60;
	Fri,  3 Jan 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE3XQ48J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFE219E0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906653; cv=none; b=Llgo7qh+YvtD8u5T416OuOs3BCrWjMalwS+JyPSSplAkqVYb81QTUjv05ILqEy0mkkXN2ORPP2bE4UznTIh4I1ZxhLmTmLNay0AUYpvIWT1JdVLzixnwDChb5oAP5ilJ9AL72mqzuo11D1pPgOkZF+2NS9SgFdV6P/csvC8xI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906653; c=relaxed/simple;
	bh=fd/aH/z2sf7GgvQ1/qfuBaz9++yS81y9FpLiIGCQDWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5qOhW3Mr5r+S7DLv6vKqeSpMTOW2t7tiTtz8VjbVlWKhnsROhb3l1X9/yvTTK8iBSHU5lox9vIBRkqvaqZIQz2VN34uZwaHA9GPLpD99HpnkuDVMrpPsyxNdFltxQxKAFsO10am1xZIGeUnHSapRS9mYC8exw7JgYwEv+vJO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE3XQ48J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE08C4CECE;
	Fri,  3 Jan 2025 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735906652;
	bh=fd/aH/z2sf7GgvQ1/qfuBaz9++yS81y9FpLiIGCQDWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TE3XQ48JGqBoZfRW+mkkorMlScB3pNn75AyI3xCEh71hz79l66JuI/A5fQSye4MU4
	 0mjpxB+TiOmgBJov3e75C/ELmgXvRX8bCZ+wiFuizikj1CtAFjo0erTaBjPrcmXdb3
	 suk7yAng6zULTfXnzi2L/W5sqfCFD6u4GvCu0HUGMYhxw74D4ZcPFQ+4YDXIPODca0
	 wwUn2vAFVDP72t4bUtAOf54s2ARauetYaYs61mTg4iFH4tMkBdbsoI9gASNovwXCwF
	 qVw07lyqPUBaBA84SJYSb6bdNwrJ1ur2pledmflp6bvqUdNXtZEiubCobqH0vKGUOb
	 vtD/FG0z1i0ng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jan 2025 13:17:02 +0100
Subject: [PATCH net-next 1/4] net: airoha: Enable Tx drop capability for
 each Tx DMA ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-airoha-en7581-qdisc-offload-v1-1-608a23fa65d5@kernel.org>
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
In-Reply-To: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

This is a preliminary patch in order to enable hw Qdisc offloading.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index d8bfc21a5b194478e18201ee3beca7494c223e24..59e889cf08e49b89d20fa630f83a1c1322bae6b4 100644
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


