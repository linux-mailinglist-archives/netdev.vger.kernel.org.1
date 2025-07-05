Return-Path: <netdev+bounces-204347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263AAFA1F6
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECB94A3A05
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDB23C4E6;
	Sat,  5 Jul 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9JnOIqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EB136349;
	Sat,  5 Jul 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749815; cv=none; b=uaOHlwTIVvV3OEhSMkkqDg/Rlp6ikVi5YUwaV7YlWfX40ZkEi3GdNJhspV8txAB0F9dDgsiptEuI5OzoesiH8Z6rnYKy6TwMDttJNlfLxn2geq1bJUT74ELLNmzACgxsm6YpDKmyHp4uNgZpsWTVvwelcjUXCo2pigPiebCttAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749815; c=relaxed/simple;
	bh=PE8CYF+KPPeWMtClRPVBKcyxMNaNMuI0KMUEfk9n6U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjBdGfzFj0kja6pD571k73zyD9USu3W1gbZmBC3Rl3s0iWRipxT2M9GpUyw9T7mcY11WBLW5F7IPDcF8rhFn3xkv5shiL5a4HOajcn/eJ8KZhtH7SAivvA3UyuRH+QNPyEU4CGU5lgtFXIgEkG5Uc0OoJMZi6sH456by3eBJbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9JnOIqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC27C4CEE7;
	Sat,  5 Jul 2025 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749815;
	bh=PE8CYF+KPPeWMtClRPVBKcyxMNaNMuI0KMUEfk9n6U4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R9JnOIqSx+ZMIQQEF7n3Z5EScObwnlwqpeJyqn+z3eqJ15yfngVOtzYf0qbWpJdPZ
	 g7JsEGWbwBmyLAFSL8o20ou3qRTG1zDFZKVpXBfqhGc1GLnhjCKrQom3s8CSjPm95m
	 6S/BgCF+cy6dA8z6e8Xuyv2A4BwoQoduylnqRsMtancH+pYQkwDG8Zm6MmwDgVAL8p
	 ZdZ7ApsVCXbYMmGTdhDRWcNcYWtyS2ltQEaviG3wv0l+KtPajFBxJkrfmXkV+k5T8b
	 hNOU57DEDsDOm/NuKKjXAbmCEVN2yVsvXTUO94pZ/5UIQUoihec8avRb0MZV61P4ZB
	 vU+AP5HhgZ2pw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:48 +0200
Subject: [PATCH net-next v2 4/7] net: airoha: npu: Add wlan irq management
 callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-4-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
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
index a1568233edcb180c7d19245051f0c409664b5242..aa7edb60e5d1d19fbfc0675bae623cab346bf211 100644
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
@@ -632,6 +655,10 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index 6a9cb1425f48ad8b01daf191ace4e443d22949dc..9e225df8b6c94b40386cc015cc086e9de7489a53 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -88,6 +88,10 @@ struct airoha_npu {
 				    u32 *data);
 		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
 					   bool xmit);
+		void (*wlan_set_irq_status)(struct airoha_npu *npu, u32 val);
+		u32 (*wlan_get_irq_status)(struct airoha_npu *npu, int q);
+		void (*wlan_enable_irq)(struct airoha_npu *npu, int q);
+		void (*wlan_disable_irq)(struct airoha_npu *npu, int q);
 	} ops;
 };
 

-- 
2.50.0


