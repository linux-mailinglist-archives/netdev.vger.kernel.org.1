Return-Path: <netdev+bounces-206736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90780B04404
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80330188AEE3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AB26A1C7;
	Mon, 14 Jul 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXagEWL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139D26A1AE;
	Mon, 14 Jul 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506748; cv=none; b=cSOpRSLHqWNXQWizqrSmZs2+UPB+UpLmAA0Um3zQOrXLZycN2VK+Sf6g/Bu4U+0gLlQtU2rz6q5x+KVKOc8K/hrh7kjGnUmVVpoC8qxtd5GgoNO/+9c/zozTVQXMfbJm/B9L79Gh4nblWwlG0fB1UDcwhYDcKieHv8qiaOHdo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506748; c=relaxed/simple;
	bh=dobj3y1w8fjsYR9k5BjFXpDstQzOpvz6Xw7A5zyEszY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ap/xNzaU/COE63bgyxstryrJWFcBd0GGi/0edLHag7N1tPUp90FsOtytLnyL8TSwGiqZBr2d9Khj2upofYPxPYrzSe9lZALmq+W9+cPZEfH3TIbw3yYjWoi5PEpGZO8b7RQiMfd7IzfdHr6s13nEKB2H+OwbmCjkIXxdiQLO0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXagEWL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F40DC4CEF6;
	Mon, 14 Jul 2025 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506747;
	bh=dobj3y1w8fjsYR9k5BjFXpDstQzOpvz6Xw7A5zyEszY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXagEWL14gFG5FdIXRjSAaEnlvPtjsshvJTU4E1/j0gv/wCdbuyjY81Komwh6d839
	 iHVeKjUn72HDAwPHhgfuDeMH/MyNvOzcn5FG52trdtPV7KX1CXP4XlNr1O4jBmd9ZE
	 7fNVgaWTiSWjDDwwKeGMT4kAI7r0X28q31fvYWGkpWStwUGTqAb47Or1pYkv7q98fa
	 kZAvBwHQ//XuILpEfLHps2epobV4SEI1tg2RPsqC4962ykB65U87aiLWvU4ie8ggRo
	 FSaAcpwfnru+ZuRCPSOWbviLM7kVIOyluooV0U69trRjGtqlYW+zs4m8bXTAK8IFnx
	 lL6WH+l1VJ7cA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 14 Jul 2025 17:25:17 +0200
Subject: [PATCH net-next v3 4/7] net: airoha: npu: Add wlan irq management
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-airoha-en7581-wlan-offlaod-v3-4-80abf6aae9e4@kernel.org>
References: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
In-Reply-To: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce callbacks used by the MT76 driver to configure NPU SoC
interrupts. This is a preliminary patch to enable wlan flowtable
offload for EN7581 SoC with MT76 driver.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 27 +++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index cf087daa5d0b7b5e60edda632423a8d07240ed4f..d25c9e799c8b0725e82f44f067112caa101ec12e 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -525,6 +525,29 @@ static u32 airoha_npu_wlan_queue_addr_get(struct airoha_npu *npu, int qid,
 	return REG_RX_BASE(qid);
 }
 
+static void airoha_npu_wlan_irq_status_set(struct airoha_npu *npu, u32 val)
+{
+	regmap_write(npu->regmap, REG_IRQ_STATUS, val);
+}
+
+static u32 airoha_npu_wlan_irq_status_get(struct airoha_npu *npu, int q)
+{
+	u32 val;
+
+	regmap_read(npu->regmap, REG_IRQ_STATUS, &val);
+	return val;
+}
+
+static void airoha_npu_wlan_irq_enable(struct airoha_npu *npu, int q)
+{
+	regmap_set_bits(npu->regmap, REG_IRQ_RXDONE(q), NPU_IRQ_RX_MASK(q));
+}
+
+static void airoha_npu_wlan_irq_disable(struct airoha_npu *npu, int q)
+{
+	regmap_clear_bits(npu->regmap, REG_IRQ_RXDONE(q), NPU_IRQ_RX_MASK(q));
+}
+
 struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 {
 	struct platform_device *pdev;
@@ -631,6 +654,10 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.wlan_send_msg = airoha_npu_wlan_msg_send;
 	npu->ops.wlan_get_msg = airoha_npu_wlan_msg_get;
 	npu->ops.wlan_get_queue_addr = airoha_npu_wlan_queue_addr_get;
+	npu->ops.wlan_set_irq_status = airoha_npu_wlan_irq_status_set;
+	npu->ops.wlan_get_irq_status = airoha_npu_wlan_irq_status_get;
+	npu->ops.wlan_enable_irq = airoha_npu_wlan_irq_enable;
+	npu->ops.wlan_disable_irq = airoha_npu_wlan_irq_disable;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index b81bb9398fed9366a18f9bf79e323372969ee138..8e830d12bd8a518038f2df7605a5d9f455725e40 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -88,6 +88,10 @@ struct airoha_npu {
 				    u32 *data, gfp_t gfp);
 		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
 					   bool xmit);
+		void (*wlan_set_irq_status)(struct airoha_npu *npu, u32 val);
+		u32 (*wlan_get_irq_status)(struct airoha_npu *npu, int q);
+		void (*wlan_enable_irq)(struct airoha_npu *npu, int q);
+		void (*wlan_disable_irq)(struct airoha_npu *npu, int q);
 	} ops;
 };
 

-- 
2.50.1


