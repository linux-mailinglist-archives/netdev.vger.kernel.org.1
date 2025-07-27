Return-Path: <netdev+bounces-210383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A25B12FE7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7315A18966B7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98521A928;
	Sun, 27 Jul 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4wkF9/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8121A436;
	Sun, 27 Jul 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627282; cv=none; b=NoLrTPlhvkiJO/DwlXJloBOBiFAw7DCQi2rLDBt6gzGF9UbJa+X1nidm92hvqmI7vR0NKLsYLZ1NmYv3Xj/sYbUKBIOZmshMmCW0pcQ2Cb0Q5NQXckYllIP43kh5+Yo3KEzuixde6VNiVNW5TbeYpJqyTC1jxsjOmAK71MfMXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627282; c=relaxed/simple;
	bh=gy92YUEP+jY4RK2ex5JDhIkARzwiNNomaeL8efwukK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkyIscmUl9TGT71/dOATGSt6ney9WThHScZCoGbCmp7P28rilE80npkSltSqSpyTLZ0BSqYd3BMBJ6FZNdLkUahqmbIaA3UJYKRmPt52i5ODBNYuAf+B/THbyze/zjhA20pjfqJll4eRsX9RkPggMVi+aXlXm8yzgnrqWW6iMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4wkF9/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87829C4CEEB;
	Sun, 27 Jul 2025 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627282;
	bh=gy92YUEP+jY4RK2ex5JDhIkARzwiNNomaeL8efwukK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k4wkF9/9abh97zZIpJCdESwyASjTwJWGNp1ZBUQ3uf4RQVSS86xlBZkMsOt4kEBrM
	 Nfkw7onP3GRjLHajbKYxLRSk3V1HCiXOYdpOdmKljniq+UM9oy40nRNdtVvgxqlXId
	 XIsFJh3wRxuK4vKFpJpcDJQx5RUhTBlDhm7PV+TrunbumdOSln0gsdI5YpUaDdRZ5l
	 Bdm0cLBURGwh6J/B0CRdIqRYzJSKjJP9/75YVV2Cs6PkYh6CCNjuCMBEsXLnonBAFl
	 DGe7lAr7OAsp+rpS7XAcVArfZBc63VDpeT5E49IwGhyOPZr6bJXWjqY8CC61YDQTTN
	 NYN4d5ad+38Bg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 27 Jul 2025 16:40:49 +0200
Subject: [PATCH net-next v6 4/7] net: airoha: npu: Add wlan irq management
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-4-6afad96ac176@kernel.org>
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
index 09e6ede8044eac9bfd03997850dde3b83a4078f2..95de323cb0801fb789bbbafacabb48d21d93f63b 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -515,6 +515,29 @@ static u32 airoha_npu_wlan_queue_addr_get(struct airoha_npu *npu, int qid,
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
@@ -622,6 +645,10 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index bcf6cd5e47ddb6adba060e7f8a32d243505cc046..e913e45a0679be9634c289afef71fb88f728427b 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -89,6 +89,10 @@ struct airoha_npu {
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


