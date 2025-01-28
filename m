Return-Path: <netdev+bounces-161370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4601A20D7C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E597A28CC
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A971D89E3;
	Tue, 28 Jan 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="th2CPtAL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383781D5AAD
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079272; cv=none; b=sjZ/3ZNZ4N/tsJyVkkMqiVYi2P4QT+ym9fmSozML+38iwsqtRwih/I0RItKtuVWwht/6SHa3D9WGfoZRUMwRqJgiwcxdQdOfrHQ7YRvcc6v93xL+cRwtliH82fn2wZX0cj0yiiN4fQqXsbRar4r5/FN/FpMlqpWcTIucB0hWWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079272; c=relaxed/simple;
	bh=6imLKz0hYki81nIhjrpo6UVOuivfz9z45xecINSvdxc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Vfb+1t4XLyybn3RJ3sO6I6qhOnkpTj6cJ/QpDBWoHjSXfLZMWyR4+2EvCL42rsIqcbd/lExn4I19R4JnfUrMeaVQZUausrjTFKYe2TR8tuObXSjZGtci1Pv8foPm7v9G3gr9h62P2vqhZmbwheJlIfHlN/6And8vuGYMpBDevms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=th2CPtAL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tz+ycJGyz3nSRG9p8hP5+LC1RqbEPoiShhFlu0+Ke9o=; b=th2CPtALOBlUQkboIvRSC7VEXS
	RqpZL/4H1pWtv+K0plXkn8ApIMU1cRhVBXV+L4neCOBobIKpMagIsf+rP8Fw6sWhn9VE5p0UQfSYf
	cI84ux9DzXKScvoGztv34XcfP8NRc2w46LNWABCePnThSDUY3TTjXlxrJyXjcphjVVuLNg1wu2FP/
	ILeVHQuqAqJ1ckJ47hB+IIj2Xl+1uZIvG7wMPxCMFTLaJoqc5a96Q3piw1SDWJJ8LRUSKG5KyHGE2
	lzphbQywc5NPAu+t27Y05DJTvkf9W1El0xhQ9BxmjITtzwWt54sUwKgOXCS1qLiI6bGveo+XUL2np
	tnzseGhQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39312 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoX-0007Ul-0H;
	Tue, 28 Jan 2025 15:47:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnoD-0037Go-Qj; Tue, 28 Jan 2025 15:47:25 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 08/22] net: stmmac: clear
 priv->tx_path_in_lpi_mode when disabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnoD-0037Go-Qj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:25 +0000

As other code paths do, clear priv->tx_path_in_lpi_mode when disabling
LPI. This is done after the software timer has been deleted and
hardware LPI has been disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 485b2bfaf811..40b9e387446e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1052,6 +1052,8 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	priv->eee_sw_timer_en = false;
 	del_timer_sync(&priv->eee_ctrl_timer);
 	stmmac_reset_eee_mode(priv, priv->hw);
+	priv->tx_path_in_lpi_mode = false;
+
 	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
 	if (priv->hw->xpcs)
 		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-- 
2.30.2


