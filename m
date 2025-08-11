Return-Path: <netdev+bounces-212492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF4CB21080
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF26018A2E21
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91B296BCD;
	Mon, 11 Aug 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyjBAinA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550F296BA7;
	Mon, 11 Aug 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926354; cv=none; b=DIR7nPt2nvrbhjv3mMJHlDdaF6NI2Ow8r2t7ljvWHaV8VrQpJJLkDTEyzeXrfzT4A1d4UqhWmBmvo76Uk80pGXr+eAsthJtr1uff8QzovL9wbou6GYUnc4d1OM1xwCHwQF1645Ss9dCn4eXoJcOhhEbD8L/puuiSVpmaQzhpCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926354; c=relaxed/simple;
	bh=lMS8srAArZOopesXUER7WhvBNyx7RPJaSGD1q5g3xkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0H4okSMKFOY3H0uN56He2cCNQQKL4AEcTOy+27veHCP9iOUb2zRPoozeH6kser6JwFqVopD2QKdx/w3q6OZeqfb4zolaLuB7/QTR59+cq/7GXHQVvuFU0Koe55Jy2LbslZdbavfgKYJ44RJF9Fy0DV8nGXOV4fgd5bCwD48XPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyjBAinA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4FEC4CEED;
	Mon, 11 Aug 2025 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926354;
	bh=lMS8srAArZOopesXUER7WhvBNyx7RPJaSGD1q5g3xkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RyjBAinACeyTwBh60zvhfsaDtE6CbhTfQvaOMMyplCABR1wFFsXlnCVxd1hh3H8pV
	 AYcExF6vId0aOuQRMou19doFT712xpXx1htYPaVbotKbH5DcE8wbhj4X3VVYIe/yDV
	 mP5mA26HHfDqeZ30VwCmdQB5KL3+C2XTxGfpNjZEWfvfU2d3hMyUOzWq/2VFts+EPS
	 vOg3ZKKi9NOiHGFDCjeFM66QBYdjHRVsGEFd/RMZIhM8BC0b4GKqKSJCj3Y3c19QtF
	 UUCmiqMgXkxqGWgCxk8t0/hZsPLXO3/zTbgQhjVnepEMQqpdPcdFS+DFncioXuFpgT
	 3bQVzZwx5Z8EQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 Aug 2025 17:31:39 +0200
Subject: [PATCH net-next v7 4/7] net: airoha: npu: Add wlan irq management
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-4-58823603bb4e@kernel.org>
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
index 2a337f00386f3d1a35b964331f3b09d3db4634f6..5d1355126d16d44e5bc1e0e53df7f378b904ff97 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -520,6 +520,29 @@ static u32 airoha_npu_wlan_queue_addr_get(struct airoha_npu *npu, int qid,
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
@@ -627,6 +650,10 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index 7b9ff370c879333397214401b22157832b656e47..84c83753c2bd8c6a30626377b90169ccffa90a07 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -89,6 +89,10 @@ struct airoha_npu {
 				    void *data, int data_len, gfp_t gfp);
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


