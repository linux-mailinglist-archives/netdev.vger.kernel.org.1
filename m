Return-Path: <netdev+bounces-20189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4A75E39A
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321BF1C209D0
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5AA20E4;
	Sun, 23 Jul 2023 16:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AC20E3
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1153C433C8;
	Sun, 23 Jul 2023 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129325;
	bh=7hHXq5KIGZC56c1hv7UXeUsgzL3fx7D0F+Gla1+ZuLg=;
	h=From:To:Cc:Subject:Date:From;
	b=lahRw5W+Sld4yPDA3+L9Vc2Rkfld49P9uq31pPL2GHeT5QMH/scER6UMa6DQwbzaz
	 YK+LIJG1GZnrSv5aRDvWJFmaNxRwJfhLTopV7YBP1Chs6Ws/1J2T/KOEsms5YPZ+kR
	 cTHoKeEMTtXx5jA8p39buiLddz0WvTIbOI/uwTfGed1m+lAqE1a1W+SA3DN6eHuJvl
	 o/4QUPVJpdDl32ffWVmiiYkFgVXsX4h0wcEEE6N6xiOtkqBuK9qrm17lPZVtMpNcZ1
	 VHS+5NJ+mAWig5S8WlQ1V2zTTMfLZky5A5DvsdIHOa1LT9P8Zq9Djac0J/GnuR/Eoh
	 6wgU05nH/XwoA==
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
Subject: [PATCH net-next 00/10] net: stmmac: add new features to xgmac
Date: Mon, 24 Jul 2023 00:10:19 +0800
Message-Id: <20230723161029.1345-1-jszhang@kernel.org>
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

Jisheng Zhang (10):
  net: stmmac: correct RX COE parsing for xgmac
  net: stmmac: xgmac: add more feature parsing from hw cap
  net: stmmac: mdio: enlarge the max XGMAC C22 ADDR to 31
  net: stmmac: enlarge max rx/tx queues and channels to 16
  net: stmmac: rename multi_msi_en to perch_irq_en
  net: stmmac: xgmac: support per-channel irq
  dt-bindings: net: snps,dwmac: add safety irq support
  net: stmmac: platform: support parsing safety irqs from DT
  dt-bindings: net: snps,dwmac: add per channel irq support
  net: stmmac: platform: support parsing per channel irq from DT

 .../devicetree/bindings/net/snps,dwmac.yaml   | 27 +++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  5 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +--
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 37 +++++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 39 +++++++++++++++++++
 include/linux/stmmac.h                        | 10 ++---
 10 files changed, 112 insertions(+), 31 deletions(-)

-- 
2.40.1


