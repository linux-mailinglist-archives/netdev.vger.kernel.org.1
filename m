Return-Path: <netdev+bounces-25037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66562772B8D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F0F28135E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4B11CA9;
	Mon,  7 Aug 2023 16:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED32C9C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE16C433C9;
	Mon,  7 Aug 2023 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691427214;
	bh=Wnt22onGXX5fFsf3cU0FGcECVvk6TAii1a47Y662QXw=;
	h=From:To:Cc:Subject:Date:From;
	b=C7g/EqYDBIt4vKUoQuX2S2+EFe4KDtTh+0uf2AIQN3Jjbo8OfWRiyx0yGAGu3ZESc
	 OW0rSRWa+i3zEouGhgyiAOzB0fr1X7jF92eXvC/ath8XynHFCIWK9ZxKauTj6jlYbs
	 qzsjMQCWcpuVAmVdcWFD9BpcvuJVykYzZ7DcDWPxVlQjofrsyXJ7l5y0nRPC1+Bx8r
	 6OmHQN4LNi+gpGHvZ5Tpa/6rdcyQPN/rHR3kVDzY0x0IeUUv2fWpM0tEgYuWaGivQF
	 gvtsHjysyRYfkjMYa+iSNNfuHO3dojL8xhYPeedqfaFCxGMIFq/sPZk0MGuL8ldd1/
	 LDyLCCpmptcOg==
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
Subject: [PATCH net-next v2 00/10] net: stmmac: add new features to xgmac
Date: Tue,  8 Aug 2023 00:41:41 +0800
Message-Id: <20230807164151.1130-1-jszhang@kernel.org>
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

 .../devicetree/bindings/net/snps,dwmac.yaml   | 37 +++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  5 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 37 ++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 54 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 ++++++++++++
 include/linux/stmmac.h                        | 10 ++--
 10 files changed, 140 insertions(+), 51 deletions(-)

-- 
2.40.1


