Return-Path: <netdev+bounces-212493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17373B2107D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717366867C1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74498296BD3;
	Mon, 11 Aug 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQT/H8eC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05E1A9F81;
	Mon, 11 Aug 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926361; cv=none; b=YVPFAW4OeE1m6+ga5UbFpNcx0KDOBvqCDcowK8ZiH/WwTRPWisML5kZOu8LOCkp+iRhiUVQdRDFZYX+C5QcHdz5Yw/6MhLKM3LE7F72w5my99YZ3tiwLMwtRWkkjH/PlzOaUalsJc0by7zKw3AHdn10FTSQ4i3tulDr9+C6A1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926361; c=relaxed/simple;
	bh=M9uyc+6VuGvuh/2RacI2HAQuvO3Vo36AEbp9B8zJ3AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKpEVvV5d6usNSL9lEGyooen+zf8bnIs2y2efmJRoW+xL6vewa1Knb3HgA0vJHd3wwTn9dEdI7lfzWR/ocI6cOWTYLOpuO0mdtCvyEQ1yu1oOVHvDqsKYlsrJ4cCMkgAigWeam7WmMdcSqMXFz6LKabz31FKXptORn6wRuDBlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQT/H8eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635B4C4CEED;
	Mon, 11 Aug 2025 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926361;
	bh=M9uyc+6VuGvuh/2RacI2HAQuvO3Vo36AEbp9B8zJ3AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aQT/H8eC6qQ+43MEZWiWyEa+05fUPOUNWE451F7Qny9B4yLULdTgelb+g9a8gxD3P
	 HTDIL1xyJyHANWAumrJ8yuyXWFsW+W32NQaf2x14/xb2PjftQJOPdgshrDrjsai/a7
	 3MK1rM1IBm6LkQOADVdK6cCdlZkwpHbErBocM7RDAqP58mwrafVNVHBNMSJ6rnUJOR
	 0Lxe/+EKUUOYTegpkXcnPxMoOToOuWkY0/xxIi8ni67OXfmZntZRyNabUrmNPySKvP
	 ZjFw5dPGcXAbj9yuUOiqWi9xZhwrfEWg3x9Q6aq4BuFf3kxY1NEUH5SNfMMg+pnLfw
	 lSVKaLdreEOAQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 Aug 2025 17:31:40 +0200
Subject: [PATCH net-next v7 5/7] net: airoha: npu: Read NPU wlan interrupt
 lines from the DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-5-58823603bb4e@kernel.org>
References: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
In-Reply-To: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
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
index 5d1355126d16d44e5bc1e0e53df7f378b904ff97..e0448e1225b8eb6b66a3a279b676592876f277ae 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -690,6 +690,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index 84c83753c2bd8c6a30626377b90169ccffa90a07..a448c74208a9e99116009606e039134aa0aae251 100644
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


