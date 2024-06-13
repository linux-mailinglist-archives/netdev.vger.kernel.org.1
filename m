Return-Path: <netdev+bounces-103163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE0906A20
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF541F2129E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9913E036;
	Thu, 13 Jun 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yuaDV68L"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907A25632
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274979; cv=none; b=ry4tf0yX1iba9TNacutrqZZdmwieQIcD8HiIJUUfLtLhyy0IH1sVFfJlxNhE0xJNU00kVaCsPN7RUXFhPNCaOKA/ggPDwd1gkeJW3OlYkGYyaBzHpPC12dqsfIwv81b+7juYBkX83p1affWmNN6FGhSSMAbRKAq4r2wPtwI98Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274979; c=relaxed/simple;
	bh=DDYI6Nk03EHvPdqLBJ23ZmMNHCH/qpGj9XFKYO+bAfs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KYUpTo99aJnCSIuTsVaxJx3eBKiWeBbqTYhRfE9/YrhZrvYrQVVLYw4T50IdYN+d7Uj0yDZuyaEVtv84Rluh3L30TOTWQDEo5SOsCJ1/+p/vgom9ADdEW+zyPrVywp2r9bq4rvF+gdv4jU+c3AfYif2BfEf/O7Z128V2FjMZLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yuaDV68L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vVGO4bmqcZokGuXkUDgjKwWn5WEQXT3Zg/qfLuSphYc=; b=yuaDV68LSIN1MhjyRArM+hQwj/
	mdoWD/10MQKPLsj9hXVSpH8gVjYcGxEkzdKaUGiz/LRPITfqreWa6t1+uK2uAuvbW/txgfPA8wqCP
	/HYDDzPfKTDuXI7ZiSiogdLerL5c1iRnoPN0yTKBN+tgfqloZRBdD2JM+UCL5kGLigrQNWavVS7TI
	opIgDrllMYNiuJSbQAMqARC9/ZKYSeavDJRALCiCe82CC6zpvzboD6rXjfJZKypALA09AY3/9PG/b
	fEhQmLk+8ZVyAd7cBiDQuR04Y1+YgsidWuapNYDw+OgEpvGhbXkjkrY9Uq3MYfQzGayzejiV4YDX3
	k1vtrWmQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38506 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sHhoI-00065G-32;
	Thu, 13 Jun 2024 11:36:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sHhoM-00Fesu-8E; Thu, 13 Jun 2024 11:36:06 +0100
In-Reply-To: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 1/5] net: stmmac: add select_pcs() platform method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sHhoM-00Fesu-8E@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jun 2024 11:36:06 +0100

Allow platform drivers to provide their logic to select an appropriate
PCS.

Tested-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
 include/linux/stmmac.h                            | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..302aa4080de3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -949,6 +949,13 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 						 phy_interface_t interface)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	struct phylink_pcs *pcs;
+
+	if (priv->plat->select_pcs) {
+		pcs = priv->plat->select_pcs(priv, interface);
+		if (!IS_ERR(pcs))
+			return pcs;
+	}
 
 	if (priv->hw->xpcs)
 		return &priv->hw->xpcs->pcs;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 8f0f156d50d3..9c54f82901a1 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -13,7 +13,7 @@
 #define __STMMAC_PLATFORM_DATA
 
 #include <linux/platform_device.h>
-#include <linux/phy.h>
+#include <linux/phylink.h>
 
 #define MTL_MAX_RX_QUEUES	8
 #define MTL_MAX_TX_QUEUES	8
@@ -271,6 +271,8 @@ struct plat_stmmacenet_data {
 	void (*dump_debug_regs)(void *priv);
 	int (*pcs_init)(struct stmmac_priv *priv);
 	void (*pcs_exit)(struct stmmac_priv *priv);
+	struct phylink_pcs *(*select_pcs)(struct stmmac_priv *priv,
+					  phy_interface_t interface);
 	void *bsp_priv;
 	struct clk *stmmac_clk;
 	struct clk *pclk;
-- 
2.30.2


