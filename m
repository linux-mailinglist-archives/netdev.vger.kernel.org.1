Return-Path: <netdev+bounces-207713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C498B085BF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D04E169D00
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229221ADB5;
	Thu, 17 Jul 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXkdHpPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5921A931;
	Thu, 17 Jul 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735505; cv=none; b=JVjXTKHKL4RUGjAfP6A4GyelpWgipJQTXnzkwuj8ciUhY3O6ZNTwgxtBkgA4pDJe6Du9MZenq0ykdLfwDkIqaa6qgkJH73k7xOeToH8un4uTXVcy401Dxh9YBlzdkZcGPv9oy2JR+/bU8B2Z9t2EROlx9P9U7DgV9hgq7xSqKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735505; c=relaxed/simple;
	bh=L+SQUyTu0j0pHRhGxGvvCTjZpOMdAJ6X2onquk5e6NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Et3agIu1U5dUv42zfMz2mhLBF+uz6+/EKnS48SxgeZTLLINwX3b72WxNVlhttlW2nZYAotdMjiV+HJoo6CNbCb8mlbzR8558JqqMLpb/V0CQUXsn3VWwOyDSHWzxQlPS0aKkXCnCJQkSjJ1txCWym0HbuX2Y+01MvI425kDWpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXkdHpPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5D5C4CEE3;
	Thu, 17 Jul 2025 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735505;
	bh=L+SQUyTu0j0pHRhGxGvvCTjZpOMdAJ6X2onquk5e6NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LXkdHpPruLApkKNiEMxk+PZY28JmRwP6u0Rds4MrJCW8q4gIpigEsWoa78+jDha99
	 JfInjIiIO6D8ryIjqJdWs/jF1n5unK9SF3pwJkDcROPk5jIAdL7QGIy+lCWFLuGwhu
	 3TXB2B1BCbz/v0RNxuQHbDUjRltU15CbFHc9Q/thC60Yw+BiAQkulQ1Y8UqpOe06Ol
	 8dHPBp4PcQ9y6wWRUqbfP078sTaRsd6bUYxbT1MKnzfU24pkPP84EZRUxYUf7pLnXB
	 VJdKcyyq8LBIi7cY/BA14klohrve0EAj8fmel6+zYgopEORpU/o3ODKWoDcIdC3NrJ
	 nliSYUTajH/6w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 17 Jul 2025 08:57:46 +0200
Subject: [PATCH net-next v4 5/7] net: airoha: npu: Read NPU wlan interrupt
 lines from the DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-airoha-en7581-wlan-offlaod-v4-5-6db178391ed2@kernel.org>
References: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
In-Reply-To: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
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
index d25c9e799c8b0725e82f44f067112caa101ec12e..68ddc940f675b42599bd2c0245dc715bb56edb32 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -694,6 +694,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index 8e830d12bd8a518038f2df7605a5d9f455725e40..981b283806fa8347256f6dce756729daa4736e47 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -5,6 +5,7 @@
  */
 
 #define NPU_NUM_CORES		8
+#define NPU_NUM_IRQ		6
 
 enum airoha_npu_wlan_set_cmd {
 	WLAN_FUNC_SET_WAIT_PCIE_ADDR,
@@ -67,6 +68,8 @@ struct airoha_npu {
 		struct work_struct wdt_work;
 	} cores[NPU_NUM_CORES];
 
+	int irqs[NPU_NUM_IRQ];
+
 	struct airoha_foe_stats __iomem *stats;
 
 	struct {

-- 
2.50.1


