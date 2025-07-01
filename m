Return-Path: <netdev+bounces-203048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554FAF0682
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50F64460FD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09600302CB2;
	Tue,  1 Jul 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKQRLMrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5B302068
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408649; cv=none; b=CPObJ4+UhtPIfLOdVI9soCJbHWlOQH3eXRL43Px8h/2brzZ/r6xoFxA3l+S1BPQTDosq4DNNIBW8AUdqt7iNBQ6UuMQ+GIbUABRvVN66s/9H6IyZPTlXePE2lDf+k7YnXI88ZvB4Ep9vJorAyqh4OTeTQinLuQ3tcxAtcgMEV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408649; c=relaxed/simple;
	bh=xKLHQDg56Z1k+PJMz2yNnsr2Wa6oxMXBF2BQJ2yofR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qwf0jwSCeMycse1Sg/NhfgF93fVCznfOb1jngCXiFRhHenrEpc50cpX9TRvN7he994OdtMNlddFSwxFIyIop+c/jvjJxCa2Xgfbj/1Bo8414nmEm7mBM7UDOEMidCLnmfndUifE+kjT2agcaU/Gi7Jky5pNgKoeEzgD9r6tIhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKQRLMrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C58DC4CEEB;
	Tue,  1 Jul 2025 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408649;
	bh=xKLHQDg56Z1k+PJMz2yNnsr2Wa6oxMXBF2BQJ2yofR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PKQRLMrYU+laDZ7oJqWcZvLSzE7IppRRf8k15Rhi+goIrjgzEKQVB1lOMzenTTPtR
	 Xz8BrTvFxqUHYYUoxhAbME9lWzYa8APTY5S2DhGYJky83yJ2mhxiChdl7AqXTUtGpn
	 5jFH/TyycllaDANjCKcI8xczPV0qg2ukRF+B5/Q19L0RxXhYSfEPdh+jzV6uii7nd0
	 sItnty3JWOUqErewFLwUACs5O+DMSxHP/+2jO0AB2bIVr5e8TJ25OjtLUCbBWTJh33
	 VHmJA2XhJS0bbwnXKLxhWlwi4v+PRo/j9Il8+8wq2JtH884k+26iZrbnWvxsbK4UQX
	 HJjXRCWKiVc7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 02 Jul 2025 00:23:33 +0200
Subject: [PATCH net-next 4/6] net: airoha: npu: Read NPU interrupt lines
 from the DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-airoha-en7581-wlan-offlaod-v1-4-803009700b38@kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Read all NPU supported IRQ lines from NPU device-tree node.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 8 ++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 7d552ab7f692ba0f720e4fef89082e6ab233d809..1cf431469ca034bbaeb922fed3ebdab41aafef05 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -848,6 +848,14 @@ static int airoha_npu_probe(struct platform_device *pdev)
 		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
 	}
 
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
index 23318b708f81eacc11753f54350ae33ea83a11ee..19cfc6b7fb52f4a176d91c7b39383b4c3e13d777 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -5,6 +5,7 @@
  */
 
 #define NPU_NUM_CORES		8
+#define NPU_NUM_IRQ		6
 
 struct airoha_npu {
 	struct device *dev;
@@ -17,6 +18,8 @@ struct airoha_npu {
 		struct work_struct wdt_work;
 	} cores[NPU_NUM_CORES];
 
+	int irqs[NPU_NUM_IRQ];
+
 	struct airoha_foe_stats __iomem *stats;
 
 	struct {

-- 
2.50.0


