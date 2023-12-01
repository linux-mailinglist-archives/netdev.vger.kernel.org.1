Return-Path: <netdev+bounces-52948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADE800DD7
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CAB281BC0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639647A56;
	Fri,  1 Dec 2023 15:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD4810F9;
	Fri,  1 Dec 2023 07:01:51 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1r951T-0000eX-8V; Fri, 01 Dec 2023 16:01:43 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock
Date: Fri,  1 Dec 2023 16:01:30 +0100
Message-Id: <20231201150131.326766-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201150131.326766-1-heiko@sntech.de>
References: <20231201150131.326766-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

While the external clock input will most likely be enabled, it's not
guaranteed and clk_get_rate in some suppliers will even just return
valid results when the clock is running.

So use devm_clk_get_optional_enabled to retrieve and enable the clock
in one go.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..ec6a39dc9053 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2001,7 +2001,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 	kszphy_parse_led_mode(phydev);
 
-	clk = devm_clk_get(&phydev->mdio.dev, "rmii-ref");
+	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
 	/* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */
 	if (!IS_ERR_OR_NULL(clk)) {
 		unsigned long rate = clk_get_rate(clk);
-- 
2.39.2


