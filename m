Return-Path: <netdev+bounces-103167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DAC906A2A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2871F217C2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142514264C;
	Thu, 13 Jun 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fMu5Ks35"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64013D8B5
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275006; cv=none; b=nlsRNoXHH6T2CE1DVkbOSLIbwCy4UKdflWwTAabL3i23qDpC3BnoDL+ptc54cJ/PS2brSvY5rJJ/4xV0MIvft2bmOS8ctivv/mL03bRBZh+tnFq/VZBZxVBkBiHFIFxHP9ur7ZUolQBP4I9Jh+Ix8YGvWV99ci3ZwEPf88/+RLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275006; c=relaxed/simple;
	bh=/dSoNX92S0jJzpjdUHtw8Z8hRQmoQFwMxMjYyYGkx34=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SLIOmcr+dg1z/hnGXFOUK8weDDr8qAfLMHXMduN7qVG/PJv7z6UA8lack/+uiHgUuL8qoqFlTxcIsRGPD6ogyhbW5zGcsnM1u9tYWL5745v6RHAq2qcBP1dP6UNQPDk0RTkRqz5Fftgx+rlYNx9P2m5sYlb9Hu9n8OEEk9hJoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fMu5Ks35; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s2lHzukmb8hrOXev5/PBGl9GhDsxZO3hlbsDi9vMyB8=; b=fMu5Ks35qQ3Pd/+tM00D+kUzDw
	s6mo13JtMV3j8Zm39QY/hKj8WjIpZzMrGZtjCVzTrXWrKwhX4IYbn4Y/h/PwhTsS6439aR8ofpS9Q
	uitIPDP/7XyanSW7Zrug2jPrqWbZICghLro50NM3oG3BJ4pTrjZaSYhioi60cVQIFhKtG+kz3LdSY
	5munwv1TQulFvU45tmlbWjxyCCtI8YM8TW4M5nkrFxYUS0QQZoGuPY68Jk4OGOxGmOZK5ZhKwiONM
	smEL/SlUv6B7PgVC81niHj+imhHjfIC4EC+V6lNW3F2tyi0sRzS0UmJckQIqiuwhJmfDhuN+dnnEa
	kxJIWOtw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45528 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sHhof-00066I-1r;
	Thu, 13 Jun 2024 11:36:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sHhoh-00FetT-3S; Thu, 13 Jun 2024 11:36:27 +0100
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
Subject: [PATCH net-next v2 5/5] net: stmmac: clean up stmmac_mac_select_pcs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sHhoh-00FetT-3S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jun 2024 11:36:27 +0100

Since all platform providers of PCS now populate the select_pcs()
method, there is no need for the common code to look at
priv->hw->phylink_pcs, so remove it.

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
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


