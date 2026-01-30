Return-Path: <netdev+bounces-255113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFusMGiSfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:13:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8AB9EEB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AA43027B77
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECB378D75;
	Fri, 30 Jan 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hA0eoi/d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42D378D7C
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771433; cv=none; b=aOYVwmKrGMN2sntxi5vZ50Fr5BSYI3tO+HvjlL0dLjMwRZHzq4RxNWdcOVcfodp/uO8um8nvuSG/y8xktdb88psfxSFAxg/NmtsX7s7uP8wCd4HHoqkrBYeUFOh8Z3MepUZsMvnKgXIYbl73O5U6PbnH+gkkbGaBh/fUNscVYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771433; c=relaxed/simple;
	bh=tidF4eY1QkVkiuWW/WaG8auSfSnSF4ocXCnd9Nbu5kc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rOdIZ1iz/Xn1pSipaIJEnuk64VZ4FqmMSZBThG5WWWec27JeQWvE6HjBah2YI0vEDC3Hq+cXmeHQpU8dlfsdVP51ZST6TeYU4qboQctrRhCuIEE6MNnJnGEItcVweyFy9bGpYdx08FKjp/XH0qNJLL4SmU+kBBJ6NROfnMoKJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hA0eoi/d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C3OuEF25Keq79i8iVFT8CdTNsLkq8BlZmrX/o6VdmNM=; b=hA0eoi/d+YovpQhF4LoYL2riaU
	7KP9aVTOiZ7WkH0EJI3zQ5kFjx5MTC4Zu2160q2gdn7P1E1xYXf+NXg9ZkyEHw8YrHV+yfCq64JUF
	TTvKWCOiNiuFh8ZgMFFRJhcr9c4VRLP4nsNi1KBGPhRz9tNvEaSHpZ9+f25gRuAKex5yttRyzs20g
	JzaeK0oByMlt4V6h8QceA0shP7tEtJvSZ5SMN+qrhH0XS5bxckJ+9nOiN/Fx6YJZ0s19WVxG1efaN
	IjQdI9QnUVza26YvI4BDjxAT9EqazS5LrtTCbYOBIdvZUnipDqmwAVn+q9qVWFZOyhbVg8/Ve+YEw
	otddi6gQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60546 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vlmOQ-0000000012t-44Tg;
	Fri, 30 Jan 2026 11:10:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vlmOQ-00000006zuz-0ffN;
	Fri, 30 Jan 2026 11:10:26 +0000
In-Reply-To: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: stmmac: clear half-duplex caps where
 unsupported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vlmOQ-00000006zuz-0ffN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 30 Jan 2026 11:10:26 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255113-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25C8AB9EEB
X-Rspamd-Action: no action

Where a core supports hardware features, but does not indicate support
for half-duplex, clear phylink's half-duplex 1G, 100M and 10M
capability bits to disallow half-duplex operation and advertisement of
these link modes.

This will avoid the need for special code in the PCS driver to do this
based on the ESTATUS register bits, as the support in the PCS is
dependent on the same synthesis choice as the MAC core.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index ca81bb1cae39..49893b9fb88c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -46,8 +46,6 @@ static void dwxgmac2_update_caps(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.mbps_10_100)
 		priv->hw->link.caps &= ~(MAC_10 | MAC_100);
-	else if (!priv->dma_cap.half_duplex)
-		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD);
 }
 
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 788b884f9c89..a3c155cccd9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -906,6 +906,9 @@ static unsigned long stmmac_mac_get_caps(struct phylink_config *config,
 	/* Refresh the MAC-specific capabilities */
 	stmmac_mac_update_caps(priv);
 
+	if (priv->hw_cap_support && !priv->dma_cap.half_duplex)
+		priv->hw->link.caps &= ~(MAC_1000HD | MAC_100HD | MAC_10HD);
+
 	config->mac_capabilities = priv->hw->link.caps;
 
 	if (priv->plat->max_speed)
-- 
2.47.3


