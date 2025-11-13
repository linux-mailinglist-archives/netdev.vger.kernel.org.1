Return-Path: <netdev+bounces-238304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C6C5734F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCCF3B3A7C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD133CEB4;
	Thu, 13 Nov 2025 11:27:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46133C52E;
	Thu, 13 Nov 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033260; cv=none; b=i9jwtINpN0fuoGovJsUi9kWVVm3/omRfh2nULbrpJp2QU6vGe3rV8iNLX9iAk7Uq47OY6SvqOj1UPG1/6S7Y+U2HGgnSrKeTswrHF+qTjRnb7R2KmbuWYL0UDESNtbdp8p0Es9SdrHQMp6NPwYbeH38ocwvDazFKS8x8iXjuUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033260; c=relaxed/simple;
	bh=+ev+Lm7ALu6QWPuInxQp8hFbgIcRZFszd1M8OMejVIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQcJtkrgMLhk7AX3C+Tw4KHpEuuBNkkrG44UjnY1yFVopHJlBlfQdL9zProLQsOBvPxAgOQGZ2EwyilQofSw/Ve5mE43RBS4BlxpgEGXJIscggs60vD2T0db2uvWbPqmjO6MfwvyyoAO7ZIAPq7hn3GCsfPF3ebOPlN0wnCD2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: MRHuWa0kTI6Lt2ZP5B982A==
X-CSE-MsgGUID: KyhrcSpkSba0cQfQ1HQTYg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Nov 2025 20:27:37 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.175])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3FC48428B0EC;
	Thu, 13 Nov 2025 20:27:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: stmmac: Disable EEE RX clock stop when VLAN is enabled
Date: Thu, 13 Nov 2025 11:27:21 +0000
Message-ID: <20251113112721.70500-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
References: <20251113112721.70500-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Renesas RZ/V2H EVK platform, where the stmmac MAC is connected to a
Microchip KSZ9131RNXI PHY, creating or deleting VLAN interfaces may fail
with timeouts:

    # ip link add link end1 name end1.5 type vlan id 5
    15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

Disabling EEE at runtime avoids the problem:

    # ethtool --set-eee end1 eee off
    # ip link add link end1 name end1.5 type vlan id 5
    # ip link del end1.5

The stmmac hardware requires the receive clock to be running when writing
certain registers, such as those used for MAC address configuration or
VLAN filtering. However, by default the driver enables Energy Efficient
Ethernet (EEE) and allows the PHY to stop the receive clock when the link
is idle. As a result, the RX clock might be stopped when attempting to
access these registers, leading to timeouts and other issues.

Commit dd557266cf5fb ("net: stmmac: block PHY RXC clock-stop")
addressed this issue for most register accesses by wrapping them in
phylink_rx_clk_stop_block()/phylink_rx_clk_stop_unblock() calls.
However, VLAN add/delete operations may be invoked with bottom halves
disabled, where sleeping is not allowed, so using these helpers is not
possible.

Therefore, to fix this, disable the RX clock stop feature in the phylink
configuration if VLAN features are set. This ensures the RX clock remains
active and register accesses succeed during VLAN operations.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2 changes:
- Added comment mentioning that EEE RX clock stop is disabled to allow
  access to VLAN registers.
- Added "Reviewed-by" tag from Russell.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ccf383b355e7..101babc8513e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1245,7 +1245,11 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 	/* Stmmac always requires an RX clock for hardware initialization */
 	config->mac_requires_rxc = true;
 
-	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
+	/* Disable EEE RX clock stop to ensure VLAN register access works
+	 * correctly.
+	 */
+	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
+	    !(priv->dev->features & NETIF_F_VLAN_FEATURES))
 		config->eee_rx_clk_stop_enable = true;
 
 	/* Set the default transmit clock stop bit based on the platform glue */
-- 
2.51.0


