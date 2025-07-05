Return-Path: <netdev+bounces-204348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38648AFA1F8
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EED4A3873
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F023E32B;
	Sat,  5 Jul 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNLLA8C7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B223D28F;
	Sat,  5 Jul 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749819; cv=none; b=NiZFBieQU4HUVsDTX0Aw0vOoWI1T4GBrnZ5m5YQbuHVG98B9yESj+tluZnk8j/6ToxLAEgU0sFaY8OBifU1wFs/vGw8ikXSnAHYWqYJqKzo3NaFL/NKrCPispH5Re7NFX7MAitiXydpnkwqnHG+ibHAr4Y3IOXSYe2foTYUMt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749819; c=relaxed/simple;
	bh=nJ18tbaHJlhnqSKWjhX0WmYwbJQL+A5jO3NbanY07hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzEbVBEgBGrDCzzBaeYkrJGX54D0WgjUDRaM1107djBSe7ngshtprcRhRrg3bD/755waWKu9OYfizygTMgyGEaIOWGTO5kFMtfqOT0StWbF2ixQUK7PtKOg41vbcgC9zSAtRYttQR6zbhizB3E+nMitaSYMwbBVh4PhBBiNCafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNLLA8C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00422C4CEE7;
	Sat,  5 Jul 2025 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749818;
	bh=nJ18tbaHJlhnqSKWjhX0WmYwbJQL+A5jO3NbanY07hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KNLLA8C7Pq3UaF11V/WADMte1jasiqjR3PurD64SmWLQqWwfNd9G0Qb5bATB0nBIn
	 JCe38KGEOr5CZAK9lCWL+zvEWaL3Yb7ewGbEhzCmB6vIiyKbGP/MQ27XMhge8pja5A
	 KCmAcCG2xWhIeHX7rGCSQx9MN+1+E7MxVq7cnooTErD8irbQYlKP9n8Fd9i3XgjZlT
	 8lk6yE6g+mTWF+anKB5UyHSuqpkcP/ROdsy82k2NdreaJxpTRPw7auDr1pOxqbUXgz
	 E9Ajo+cagWRi8dItx/bto35UwbIxS2uSMuq5WjfCQfJ7eMpk9/gOPHSVNQ36SGDK/k
	 SDefOTht8RSxA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:49 +0200
Subject: [PATCH net-next v2 5/7] net: airoha: npu: Read NPU wlan interrupt
 lines from the DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-5-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
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
index aa7edb60e5d1d19fbfc0675bae623cab346bf211..8c31df5b760730814ccfaa9fffff6c6aa8742f01 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -701,6 +701,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
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
index 9e225df8b6c94b40386cc015cc086e9de7489a53..72b1d41d99e798ed32e8abdaa443e4775c6defd1 100644
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
2.50.0


