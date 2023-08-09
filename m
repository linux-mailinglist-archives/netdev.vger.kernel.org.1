Return-Path: <netdev+bounces-25996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAC776612
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2041A1C213CD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D51CA1C;
	Wed,  9 Aug 2023 17:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CB1DDC0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C6C433CC;
	Wed,  9 Aug 2023 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691600533;
	bh=2GxVXefyNbdQErExbmg0/pws/HcbyG4JyeKhzXvRnBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4FQ928xApvJhFE7Tj8KKEoOwWeAcsCs7IVHfjo54UzZhuYT+1/itilrbXbRAkTot
	 aygKFrqatHRVmboBFOzHoObEJlmsElo6lDTz74RBj6An9R/fnCu2HlOwl2+RB6C1Tf
	 +FLLxeQp+C5lGV8MtsdKsRV5EoxRSLGnzH8SGey+kA1k2KlB2z5OZRmvJg1260d3hR
	 KJAWgfmAq2wIgT0c47FDz0u20m2QnpPLoqsa9KeRBLAyemWGdPr+b+RSi3plJ6z+Ke
	 j1BtCa/bbeGCxRgRp0pyJZunGA1HUrosCZQPLTZJzOg/Hid0gOD1reZKA8wQ3ZDcNS
	 0Y4oJ9Gsm6AXQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 08/10] net: stmmac: platform: support parsing safety irqs from DT
Date: Thu, 10 Aug 2023 00:50:05 +0800
Message-Id: <20230809165007.1439-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snps dwmac IP may support safety features, and those Safety
Feature Correctible Error and Uncorrectible Error irqs may be
separate irqs. Add support to parse the safety irqs from DT.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24..29145682b57b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -738,6 +738,18 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
+	if (stmmac_res->sfty_ce_irq < 0) {
+		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
+	stmmac_res->sfty_ue_irq = platform_get_irq_byname_optional(pdev, "sfty_ue");
+	if (stmmac_res->sfty_ue_irq < 0) {
+		if (stmmac_res->sfty_ue_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
-- 
2.40.1


