Return-Path: <netdev+bounces-28543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED677FCB2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0C11C21516
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29D171C1;
	Thu, 17 Aug 2023 17:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C0171A4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D7C433CC;
	Thu, 17 Aug 2023 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292180;
	bh=nrZBBHIvwoY7+NGVTUVo+wQxGv/rQfcOhG+8CHuUfbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqfCowDBfSqLcVFjlD11GFJSUH0EMWxlBxuC4kwhPdNDkLiKR0O6jOv0xZTf62WnD
	 ZVIrCBskydJV8vy56PW6FFBvq0cgiCXysSwL2NsKI6T3LCl3EqiARFrhRlFDel3q/H
	 cX8DEnsTqwPxIg2MvmM+0FMqZIa4gb34YemcxM1qXptwCQP4g0ZKeOH1qGfLwL7qxc
	 IAOMRahGFT1GeOIUHyE5RaHiXUzIEeQnlX5kGc+fqE+e+NNj1HlX1qV2SF1ILg11Iv
	 D5SmzcZnnRMJ4K7l0sHH8qy2k1i6BK/JRJZvk1uO3QzCZHe9brEn9vs9EffWhy0yV4
	 5O2iuhBRfHMqw==
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
Subject: [PATCH net-next v5 2/9] net: stmmac: xgmac: add more feature parsing from hw cap
Date: Fri, 18 Aug 2023 00:57:42 +0800
Message-Id: <20230817165749.672-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230817165749.672-1-jszhang@kernel.org>
References: <20230817165749.672-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 3aacf791efeb..1ef8fc132c2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -410,6 +410,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
-- 
2.40.1


