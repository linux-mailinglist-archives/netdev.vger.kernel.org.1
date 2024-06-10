Return-Path: <netdev+bounces-102303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91521902456
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09EDB26D97
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA613212C;
	Mon, 10 Jun 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aFN9Dtt7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9B12FB0A
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030469; cv=none; b=uBqGakXc1iQIgrjrcoRtfG4i9ge2uxUlNuGA+o2yn/JVNeAyePrFZyJQoRS48MHVI0UOlBnR1mMYMhrvVFVFLfx93qLFkNzHKX8xs7zrONJN77+vtAkSnpBYVtIanbZkwO+yR+GtAFoUMB9Js5uUIHmnzWDEoxbu/zRTH/Jv8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030469; c=relaxed/simple;
	bh=R6tPxkh1qQgqNv5XuhFEoq8drrzo3CEPQ765Glu+u+I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=iW2PMh6okcIbuIILJuUaPJmAIEM+ZIbXMSsZ4vCu0HV0zLNImccKMayuD1aFU2lr2loR0FAk/Gdf6vh6d8h8uS+ssK56LyD2+WF59sT6g0fzdyTGzqX3wn+nSaImg0Q9qqz5OXW7GPpHHK17j8MDewqTMa2xGmvnxKBdj8ccOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aFN9Dtt7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BWNZHsS70/QjgSQEoGOeY4EqJuojEQ3o1GbogG6YuSM=; b=aFN9Dtt71SZcljf3N6tl77BQXr
	5sRXskmGKkIPtETe02zygZfaCwL5RNVzhxIL/vnFm6JeKk9NaCe2f6NFLzJlH4qcuSJ0ha/xXccJz
	MyIEWYxSal5mus0jCNVUCd7dlCeb/Fspo3rgmm9yduKawktSUvILnN3f2Z4k/2IH0rWStU5XNf8dF
	OErEWPBE7IPY3eRaRARJT5MMC4Luxgvijyf1+6UCGMhiLa3L1teatgKng9f8jUhpHqZt0i6MxvIok
	yP81vLZ2DIDH2HqDIczo89TPQK+ALLHUqEv+jZIop+jOJkSDnVSEiV75jIS2iVGX51dP/KuEQRvUe
	7I10C7BQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38386 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sGgCZ-0001ft-2B;
	Mon, 10 Jun 2024 15:40:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sGgCc-00FadB-Ch; Mon, 10 Jun 2024 15:40:54 +0100
In-Reply-To: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/5] net: stmmac: clean up stmmac_mac_select_pcs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sGgCc-00FadB-Ch@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Jun 2024 15:40:54 +0100

Since all platform providers of PCS now populate the select_pcs()
method, there is no need for the common code to look at
priv->hw->phylink_pcs, so remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e9e2a95c91a3..5ddbb0d44373 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -957,7 +957,7 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 			return pcs;
 	}
 
-	return priv->hw->phylink_pcs;
+	return NULL;
 }
 
 static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
-- 
2.30.2


