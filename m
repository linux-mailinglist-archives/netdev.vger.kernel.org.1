Return-Path: <netdev+bounces-210564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7579B13F20
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5DF164A38
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7E207DF7;
	Mon, 28 Jul 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IxkRkgjE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A582135D7
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717585; cv=none; b=BXJQXzaO9jQVV2xI/QfQXrWC6Yseco8Z0wUxUMaaw+lkMV05GYjswTldbJ6Ax7DAdilmgKS93lCBhWcBfCQSpB+Xi2ox2BXojdjYVO2bjqbOjDTEZ5Nw/XxzikJlJvfitEQTJvwPmT/T7cKFO1T+UwwQqCeWNttWC8MYhdFOhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717585; c=relaxed/simple;
	bh=A5OoA6BGBcH+nF2i/lSIN0N9ncYvAHBPwwzJkDR+O+w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YX5GMQe1WiatgLdtbrcjCgFza2cqEtsXpP78uku7038iaghX6jZzJ11tHoO7ghylaNUgZ3DiSeAA6dIrCssbkImf4mmlcCPa1RDj9NEP/B82PN6M+p3xbI4XJB1bdQDv3lGwe1t+s5tpqYSpzgOJl9aPLLFKB85Hj+gQaCTSKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IxkRkgjE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UHxdT55JRA7x7Guv/dUxLd0lwCXlgL3mLFhEqQaE6hM=; b=IxkRkgjE4yCWF2WhvrKlsr7Y4K
	T/1fAB26cA63Nn6qw1owOTIc/x+B5EtkroDZIfT9N7xi5eU6vW80B3Nxayzab8OXxHdqBe59Woaf1
	MbLAEjWggFQxgoeRq+iGvWTEeMpheGRyJC8HCuUVnOcptWQpuGlJoZS06izNRax88aTEoepk16b8o
	WDeM5HUJ2vfAvC7ZmNYvlpXWh8JFVNKwtL5sEJhNZB6fKlkoFM91L3e1IpCIHnMqOasgcofMk8FLd
	/ArS1FnuIwJ+nvR22S8++HGcNyTBHJdbNP2n2Gt5c55UZ9hnTjf3/ArdCPXaoF1FfScggY/Hmmu58
	FMQGXEiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55542 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ugQ3L-0000Tl-2a;
	Mon, 28 Jul 2025 16:46:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ugQ2e-006KCw-7V; Mon, 28 Jul 2025 16:45:32 +0100
In-Reply-To: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 1/7] net: stmmac: remove unnecessary checks in
 ethtool eee ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ugQ2e-006KCw-7V@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 28 Jul 2025 16:45:32 +0100

Phylink will check whether the MAC supports the LPI methods in
struct phylink_mac_ops, and return -EOPNOTSUPP if the LPI capabilities
are not provided. stmmac doesn't provide LPI capabilities if
priv->dma_cap.eee is not set.

Therefore, checking the state of priv->dma_cap.eee in the ethtool ops
and returning -EOPNOTSUPP is redundant - let phylink handle this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 77758a7299b4..dda7ba1f524d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -852,9 +852,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!priv->dma_cap.eee)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -863,9 +860,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!priv->dma_cap.eee)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
-- 
2.30.2


