Return-Path: <netdev+bounces-157723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC0A0B603
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53621886F94
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECA1CAA9B;
	Mon, 13 Jan 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CLIuNbxF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8A1B4154
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768808; cv=none; b=a6SQSpuWOMF23iCFQdMmlwYPlZ1dLilcQvLlDh+dOF9q4pGO06oQdirb7IznTpn9wO35J/E8JRcstXWyCZfdtn+UcE0MGvxppsLWkOEOgbGQTDdtk7URbwziEUqcqWg5SPBkz95bdpwJxubS3zLPSsKMaBzabI9RItUKpAg28mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768808; c=relaxed/simple;
	bh=4N3tfFhL1H96iZlgtmbf22MdLnRH7Ji+WsGUzhoGoFA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WK5iJ2OgN0cNIy09UIS4ig9RtU1vq8bU9UIlL20p6w2XXeUDX+bPqFNJ60lpyF+3B07X1e6Sf+wbe09x11LebhWpfV6LfhNrsE9d8o0MxdhKrpAB+np40PhQIS9v9rjw27f87oTAbEiYXP70fwUdXgBtblvCJU+i7d9bYTqrQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CLIuNbxF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Icf5ryCIJcF20+mRtB38lPc5k3RjJWwfbRKAYFqi0WI=; b=CLIuNbxFGCKkV5AyGiPGpfX0qt
	CZ0/7NdHsZ09sRDrsLpbtoTyxVUD2jfzkZb+laaei7Iip6Rf+22dD1VE8/WKEaMicd3R0AsJkm9sG
	BMriQ5zO02Zd/6bWt+BK8b1LwCd1cGWFmZnpqnINQoKDmI+UlB1yurUmbJ6SpMohG1vSx7cIZRhMd
	FOdfSnFKSdILVaTtCTIQDeBdssaBaXxoI0tFL9XU+G4geaXQ3Lhy/N7I4IuvpovyTtXuL5pmb46FL
	P/sgHslnKCeWeoxzIB/HzZEaN38dX9f6jFo8eWrou8sHw6XxzTCziaoke/KPNYeFVP6T5xlkXd4tl
	XB33yW3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38268 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXIu0-0006X5-02;
	Mon, 13 Jan 2025 11:46:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXItg-000MBg-TW; Mon, 13 Jan 2025 11:46:20 +0000
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
Subject: [PATCH net-next 9/9] net: stmmac: restart LPI timer after cleaning
 transmit descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXItg-000MBg-TW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:46:20 +0000

Fix a bug in the LPI handling, where it is possible to immediately
enter LPI mode after cleaning the transmit descriptors when all queues
are empty rather than waiting for the LPI timeout to expire.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 72f270013086..acd6994c1764 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2795,7 +2795,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 	}
 
 	if (priv->eee_sw_timer_en && !priv->tx_path_in_lpi_mode)
-		stmmac_try_to_start_sw_lpi(priv);
+		stmmac_restart_sw_lpi_timer(priv);
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-- 
2.30.2


