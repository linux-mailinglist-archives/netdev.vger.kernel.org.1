Return-Path: <netdev+bounces-25987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6356F7765DD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943E21C20B2D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202521CA0B;
	Wed,  9 Aug 2023 17:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D618AE4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2394C433C7;
	Wed,  9 Aug 2023 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691600508;
	bh=LFjNs8fNnfJcH2w+sep24uTLzAFqDRt8//EcSlD2l18=;
	h=From:To:Cc:Subject:Date:From;
	b=qVNvJwMfwetQ1u816Yp27of8fuCmX/XzC5rEIND4icIW4LlQ2OjjgsyIbGAOzNBWy
	 XYfp7FnqqfoF7FvpkZp5SszFqSkJQ7if/17JFGFPqh+72eR/hmc6iWD7zo3VUP1MlE
	 ikQwyNFZPLPU8wo0cO0S6zyMvaujCRd8Agkr3MVa5XAhBLRNHAb4HcDrMh45P9GWQ3
	 gE7ubSFVAfg48V59oLiEpdHAB4HAar922L+d0HzMXzuWnJhDkMgEitURp+CIExF+17
	 fAUtUI7ChDb5UWkGbOeJpO4K1bM8McAFbXccJQWlCUw/7SuFYUG4tfnHpAr2OM7mJ4
	 IYNasGRQe7KSw==
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
Subject: [PATCH net-next v3 00/10] net: stmmac: add new features to xgmac
Date: Thu, 10 Aug 2023 00:49:57 +0800
Message-Id: <20230809165007.1439-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add below new features to xgmac:

correct RX COE parsing
add more feature parsing from hw cap
enlarge C22 ADDR and rx/tx channels
support parse safety ce/ue irq from DT
support per channel irq

Since v2:
 - check per channel irq by (res->rx_irq[0] > 0 && res->tx_irq[0] > 0)
   rather than (res->rx_irq[0] && res->tx_irq[0])
 - bypass if (irq <= 0) when request rx/tx irq

Since v1:
 - remove "_irq" suffix from safety irqs dt binding
 - remove "snps,per-channel-interrupt" dt binding, check the channel irq
   instead.
 - more renaming about "msi" to reflect per channel irq isn't MSI
   specific


Jisheng Zhang (10):
  net: stmmac: correct RX COE parsing for xgmac
  net: stmmac: xgmac: add more feature parsing from hw cap
  net: stmmac: mdio: enlarge the max XGMAC C22 ADDR to 31
  net: stmmac: enlarge max rx/tx queues and channels to 16
  net: stmmac: reflect multi irqs for tx/rx channels and mac and safety
  net: stmmac: xgmac: support per-channel irq
  dt-bindings: net: snps,dwmac: add safety irq support
  net: stmmac: platform: support parsing safety irqs from DT
  dt-bindings: net: snps,dwmac: add per channel irq support
  net: stmmac: platform: support parsing per channel irq from DT

 .../devicetree/bindings/net/snps,dwmac.yaml   | 37 ++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  5 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 37 +++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 58 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 +++++++++++
 include/linux/stmmac.h                        | 10 ++--
 10 files changed, 142 insertions(+), 53 deletions(-)

-- 
2.40.1


