Return-Path: <netdev+bounces-157718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D199A0B5F7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919C8166BB0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518D22CF35;
	Mon, 13 Jan 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J57ZEuuJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14515667D
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768783; cv=none; b=FJ2mgtWPmcvoeUhw424e7j5vYh0+EU/1jWiwWc93gj6m/26q1sQJK/+JBNAdQHxwc/eBSiePLjwyC31DAHc1JbuJiRwN/05WulO65FX40CKh7/dM/v8DueqWRTS9IMlwwO2eDHkUreBcXdjzHTWnJPa4e1wAiXZRaEsE4Dgi8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768783; c=relaxed/simple;
	bh=FZ3NvYwmNrNmDVOcpVE2PYbFc4WkshtYJqraaItJIfs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=m3Gi3cXER5yZKW+G6RjGT003HosoF7f39LaHZ1vpAqzJSvM9KJP6/ajNUNpXYASmDbmibmFgACSQNjl72cBxSnsbZ6KAz37uWY9hk0Y6Suw7geRofPTp78LNaYpT3jFXrvxTOBfug1mWbMSEth/NDowEynwCkK0mM/C9toYm6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J57ZEuuJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=chXwxPSm499N84MeQ/hbX0oDsMrVYQ0eEiWb6Bzy+XA=; b=J57ZEuuJoJ9EkO5nhs+61xeyAh
	lrtQfofdDXMP1xze95c3uPiqKDHNQ2kPdIkx57CQABhEG72XQ9tsxJcF3150ZXG1T3ajtQC+LQCVK
	N7NYo76PjIr+UeC8uunP/67W4fAkYQWujWMxUrHXWRZv4IebagEQRThuTdxhCAY1uCeutbbgOIt8U
	eBZkVHlccjVxQi46R8m5lRE9kIUsDtETwsD964F5Sm+CrVSBX6QetO6QcRFJJRZa8798iakjvPijv
	IQskVvpgpGhaFxkPhn6jMzZh8DfiVuExRrsUiiO1pOKjuYwpTDCVHUZuCKvnJVQj1QuynNIutP1Bv
	pBOzySsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35688 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXIta-0006Vg-18;
	Mon, 13 Jan 2025 11:46:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItH-000MBC-8i; Mon, 13 Jan 2025 11:45:55 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 4/9] net: stmmac: check priv->eee_sw_timer_en in
 suspend path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItH-000MBC-8i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:45:55 +0000

The suspend path uses priv->eee_enabled when cleaning up the software
timed LPI mode. Use priv->eee_sw_timer_en instead so we're consistently
using a single control for software-based timer handling.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e8667848e0ee..26ff1ded4e3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7719,7 +7719,7 @@ int stmmac_suspend(struct device *dev)
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	if (priv->eee_enabled) {
+	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
 		del_timer_sync(&priv->eee_ctrl_timer);
 	}
-- 
2.30.2


