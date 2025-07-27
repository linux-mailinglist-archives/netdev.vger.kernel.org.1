Return-Path: <netdev+bounces-210384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC8B12FEA
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C723B70A1
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F221ADB5;
	Sun, 27 Jul 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8LdgEe6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDE2144D2;
	Sun, 27 Jul 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627285; cv=none; b=eJpFEn4bjasi4v+du3YQO7ykfzw9ybzO7T39NgSKGtMY89FbRAc1pb1u2YbHEtgNJx4OKqcJ9hKIjnrb5q03MjyGiypBI8FBz5RlfdGa7qURxqNUYacaiBTi1SV9NDWudaNI6ctgec/+BDtAHifDfI7rHJ05GmfBcAKEGFSczpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627285; c=relaxed/simple;
	bh=cX/HRgKUv5mN0HkYY9Vsqmoc/0+HmSRb2AgJ74dpsRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=um6yuniz6yT1Nb+N3twWThe4pDT9FbcmFWo1Ts6uttBDT/49GMg5LbeBhPXVhJ2JqhhQlfjviq2OBk3OzKwbPkRDDTrrAd37xEZKV668XhoDHldjDrK3q0Q/KqWgLsdo1Ft+vJrMwXUieXgN9ygxHLPFvSLcw/wzD81yR4uxat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8LdgEe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E5AC4CEEB;
	Sun, 27 Jul 2025 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627284;
	bh=cX/HRgKUv5mN0HkYY9Vsqmoc/0+HmSRb2AgJ74dpsRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c8LdgEe6PrGD3zD8oEVzrvqu/6vEHI/Vc4puGSxarJrL7Xtyveo/fr+pgsvv1CqQT
	 WWnYK4u7px+RmRFGkve5QIK4S5S2fJm0H9WU/JHOieC5FlNI+JaG5O76w8fTvvYe7M
	 QndE/wNTRylWD6GLiRIf3zgW0Qv+U06+MT3jrbtmtydnwT9WuPSijGp6IrOJuonoZ4
	 786sNEs7WjHMqbw4u4qoyXkzLyT7qVKgqxgDMkOJ//K5f6dPn3WIZrj0N98Es2W8ow
	 ElJAHhE9nmsyRWdK4Nr3a7IyKiZgsN7o04Z0DAQns01HgSG7kKlzaI6WOjV8ikLQPP
	 ZTLk/I6o9cjGw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 27 Jul 2025 16:40:50 +0200
Subject: [PATCH net-next v6 5/7] net: airoha: npu: Read NPU wlan interrupt
 lines from the DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-5-6afad96ac176@kernel.org>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Read all NPU wlan IRQ lines from the NPU device-tree node.
NPU module fires wlan irq lines when the traffic to/from the WiFi NIC is
not hw accelerated (these interrupts will be consumed by the MT76 driver
in subsequent patches).
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 9 +++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 95de323cb0801fb789bbbafacabb48d21d93f63b..6ad8715f3b71ef217a6097f135fe2d6995be7f8c 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -685,6 +685,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
 		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
 	}
 
+	/* wlan IRQ lines */
+	for (i = 0; i < ARRAY_SIZE(npu->irqs); i++) {
+		irq = platform_get_irq(pdev, i + ARRAY_SIZE(npu->cores) + 1);
+		if (irq < 0)
+			return irq;
+
+		npu->irqs[i] = irq;
+	}
+
 	err = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index e913e45a0679be9634c289afef71fb88f728427b..8dd317bc3549c09dea7bd828587bcf701f74ac27 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -5,6 +5,7 @@
  */
 
 #define NPU_NUM_CORES		8
+#define NPU_NUM_IRQ		6
 
 enum airoha_npu_wlan_set_cmd {
 	WLAN_FUNC_SET_WAIT_PCIE_ADDR,
@@ -68,6 +69,8 @@ struct airoha_npu {
 		struct work_struct wdt_work;
 	} cores[NPU_NUM_CORES];
 
+	int irqs[NPU_NUM_IRQ];
+
 	struct airoha_foe_stats __iomem *stats;
 
 	struct {

-- 
2.50.1


