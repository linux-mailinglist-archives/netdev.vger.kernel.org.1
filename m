Return-Path: <netdev+bounces-28131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A66777E54E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7424D1C20F7F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760415AE4;
	Wed, 16 Aug 2023 15:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF110957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F1EC433C8;
	Wed, 16 Aug 2023 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692200471;
	bh=E/IKYTzpQNaTIjxwmCo0tbwLoswgeWU73USgeaiUoRc=;
	h=From:To:Cc:Subject:Date:From;
	b=TljYul4JFTwRzGTmjIOHRlZZQr9Fi9g0zZjcfNrIgEaDromvz+slL8+dX/zmWBAbI
	 liD/G1qoAvyIkn53it76Hw0PmJkqFRrtMOtrQc/ycA1ASxULJ8sh4bZsR1hD7FvFt5
	 4AA6M5BtKrOiW9LYqwxtBoRmxy2zDt4GqgHJvVnGZkc+RlvNpqcrs4iEGQe1z3sgHA
	 FCVW1bRlTvptubJLDdptiyTeqWfUE4mNhM7gOrInUMgOQVvj/quI70mQFRWMUkR9La
	 2gd/NF65Ytfv2d0O94APf5/LTJpMT/4EUHePJ9UbGDsVM7K753pvLh/KaA0s2LZTwl
	 KEcd+ZEsSIPMw==
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
Subject: [PATCH net-next v4 0/9] net: stmmac: add new features to xgmac
Date: Wed, 16 Aug 2023 23:29:17 +0800
Message-Id: <20230816152926.4093-1-jszhang@kernel.org>
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

Since v3:
 - collect Acked-by tag
 - remove patch which enlarges the max XGMAC C22 ADDR to 31 since it's
   merged
 - s/stmmac_request_irq_multi/stmmac_request_irq_multi_channel
 - update the dt-binding to refelct the optional per-channel irq:
     - use enum
     - add additionalItems and maxItems to fix the "interupt-names ..
       is too long"

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


Jisheng Zhang (9):
  net: stmmac: correct RX COE parsing for xgmac
  net: stmmac: xgmac: add more feature parsing from hw cap
  net: stmmac: enlarge max rx/tx queues and channels to 16
  net: stmmac: reflect multi irqs for tx/rx channels and mac and safety
  net: stmmac: xgmac: support per-channel irq
  dt-bindings: net: snps,dwmac: add safety irq support
  net: stmmac: platform: support parsing safety irqs from DT
  dt-bindings: net: snps,dwmac: add per channel irq support
  net: stmmac: platform: support parsing per channel irq from DT

 .../devicetree/bindings/net/snps,dwmac.yaml   | 77 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  5 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 34 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 56 +++++++-------
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 35 +++++++++
 include/linux/stmmac.h                        | 10 +--
 9 files changed, 172 insertions(+), 53 deletions(-)

-- 
2.40.1


