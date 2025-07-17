Return-Path: <netdev+bounces-207712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621AB085B9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56068A40E5B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44286221554;
	Thu, 17 Jul 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQFuvvQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10021D5A9;
	Thu, 17 Jul 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735503; cv=none; b=anjPj6iIkeo+gISKoAu9J2SOG5RV6Gi1IFURlJOSb89qRwcPUp1B52uGsubCMZuahuWrqJwWab4xmWZVw/1l0jGLEVhnu/6HVPSze+TgpQEz+3gf41+mRJm1xviO15QKB5SJ1SxGFwvsbJxrTbIzpHhlm/LR+mkGrTblMaGiJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735503; c=relaxed/simple;
	bh=dobj3y1w8fjsYR9k5BjFXpDstQzOpvz6Xw7A5zyEszY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNRHz397KPOCGZXe3SuS4HtGGhD7gUfjPQQe/X+n6hvNeS6W/TC2okey5RFbblG7qdAbfLTy9UIaUEqdvicBLjWY7IG9VMWE0Ll+6bZh2QfdN5S472ktuXFaXp3gk5v4N6TcodIel5gD2EL3TG+itrWV8BF9xGgamPIlSW7X+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQFuvvQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDD4C4CEEB;
	Thu, 17 Jul 2025 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735502;
	bh=dobj3y1w8fjsYR9k5BjFXpDstQzOpvz6Xw7A5zyEszY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GQFuvvQtj9/FZMW85NPo45kGcdErXM0h0mO/o7Qv51hfTfnTaqXuaLouK3Gh9dau5
	 wv3uozmmfPK9o+yDqdSkxGwOeNuVpgL+KCqe+JwFKqUC5rtywwE46AWyQcHgAtvQO8
	 nP2oV+IzMG4KwddJY//Zc+WzBSkjBUBxoGGQsFVc7H3mVWrGNzZ7GYecRU90Lfdjia
	 qgasSKaz0IzBQpqhVG2KdU76ZWlX8CrLLP9RxYu7EYcbnQN5y5LzzNkIu+f72702eP
	 Au0ZIDnIWz2JjweKl0Pa7bbngLAkg6mr8eQ4V4VsXdC4KjZ82ZTXZPjKgqsoHqaDuz
	 CJsWj912Di/NQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 17 Jul 2025 08:57:45 +0200
Subject: [PATCH net-next v4 4/7] net: airoha: npu: Add wlan irq management
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-airoha-en7581-wlan-offlaod-v4-4-6db178391ed2@kernel.org>
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


