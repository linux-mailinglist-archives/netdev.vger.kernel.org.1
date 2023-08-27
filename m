Return-Path: <netdev+bounces-30930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C44789FA9
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F817280F6F
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE971094A;
	Sun, 27 Aug 2023 13:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107610945
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 13:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EFAC433CB;
	Sun, 27 Aug 2023 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693144435;
	bh=Kr78mWGRf6MBDQoDlE1Lr7eQQGJaKlhNBXFLknzw88E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7vmYP/FTlRo1iYOX8JaWg3RpiLfbWcc9THwvP5MyglGp/uzIsXymKqNF+fpKxm04
	 zo6hBgBwaq718v9Z4/9Zm0nqRgWr9S+lbD+C+yGAQCjH7uFda/RUm1sDTJLLDepUeY
	 w03vlgFGfE6epFLES3kwrH0haVsSwlF5zcBtC7ROqx1yeEOXzUxhc48b01H0/hzZfB
	 9ktrd0wdZseXfGo2Z39S1+8Z4NRKxRimxKmWW2nJxgAmxcQy25S+MidFIQRa8DrbwT
	 2kmo57GpHGbLueVXJMUal/jtTGcyrdVvGYZfHrCdhbro5oBNIiNVwSdvfzDCCGvgkA
	 SwhQjXvaMXnig==
From: Jisheng Zhang <jszhang@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-starfive: remove unnecessary clk_get_rate()
Date: Sun, 27 Aug 2023 21:41:50 +0800
Message-Id: <20230827134150.2918-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827134150.2918-1-jszhang@kernel.org>
References: <20230827134150.2918-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In starfive_dwmac_fix_mac_speed(), the rate gotten by clk_get_rate()
is not necessary, remove the clk_get_rate() calling.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index b68f42795eaa..422138ef565e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -30,8 +30,6 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigne
 	unsigned long rate;
 	int err;
 
-	rate = clk_get_rate(dwmac->clk_tx);
-
 	switch (speed) {
 	case SPEED_1000:
 		rate = 125000000;
@@ -44,7 +42,7 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigne
 		break;
 	default:
 		dev_err(dwmac->dev, "invalid speed %u\n", speed);
-		break;
+		return;
 	}
 
 	err = clk_set_rate(dwmac->clk_tx, rate);
-- 
2.40.1


