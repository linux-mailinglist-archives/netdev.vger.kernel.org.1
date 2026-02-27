Return-Path: <netdev+bounces-261811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NAAOtxvoWm6swQAu9opvQ
	(envelope-from <netdev+bounces-261811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFC1B5F0A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86BE43018BF9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34B37AA90;
	Fri, 27 Feb 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NFnXDZqZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F73364935
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187601; cv=none; b=PbO7gRdRN8aVkefqeD+uIRqaVuMQSk+PbheLX1eQXOwh0BzHOUy9nu9UU8vw6OSUFK/f/EB9R8QH6AXao4TyDxeRDQJOyfQfGcfid9oHShx93tt84sTN/GbOLxlNvtUtsI61jIwJEGxM1HVC4eTO1ia82GVk0J5nQEunZQ0Y4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187601; c=relaxed/simple;
	bh=9cBK++4q9mzyAv/nJlE+HKa8SLcaHWUVeyg7gIUelgE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Fe0XQByZgfTEfgryZlR+SDxoZwMWy8p2SYimxK5l2r4HwGhOkDSX94TIaFy9auI7i8bbmy4RhqU7vJq8jRaDw1yTQ/E45pGnUvfS66BVk35ESSsI+3EFHYLEUzjmJnEEnRbDhEIrF5lhOie+lHv8GhkJeEkvUxdKkJtZKaM+Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NFnXDZqZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKAkTM53E2y1DtK2v4QGCI56px12Jk+xBwE3HDfh0v8=; b=NFnXDZqZz/tiXb1LffWyxzF8Ml
	5Da0EB/MMTENnA9KhokZz/3Nyo7yGG+290lApA2aj3UeK1sTZAaQr7JMy4O8v0YKSvLf06xR/Vwrm
	avWRq1leBv/Vy0m2hgsvIcHo5BleKeUL8+dIOVQI0IBR29F91I3daHmtPszGzy6A2vSbsxE9Qphe0
	zuPNxZc2Fk1Q/ukhliPiOl443y26mpRRR94AX3XYVi2CDn+HOBLaHQeI7GaCYt8W8YP5zLLacZwMW
	79yyFzne/eN2QCeijBtW7f3tX2NAwH+WC2yWhTsSa98D9RHFuFH8UvxxidqJD3GntW2g7UwRmaQfo
	5EeSsGJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43818 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuY2-000000000f7-0ZfH;
	Fri, 27 Feb 2026 09:54:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXy-0000000Avnk-10Q8;
	Fri, 27 Feb 2026 09:54:10 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 13/14] net: stmmac: simplify atds initialisation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXy-0000000Avnk-10Q8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:54:10 +0000
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
	TAGGED_FROM(0.00)[bounces-261811-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 4BAFC1B5F0A
X-Rspamd-Action: no action

atds is boolean, and there is only one place that its value is changed.
Simplify this to a boolean assignment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 38f6b890ec37..a9b26d12a057 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7448,10 +7448,11 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 
 	/* Set alternate descriptor size (which tells the hardware that
 	 * descriptors are 8 32-bit words) when using extended descriptors
-	 * with ring mode. Only applicable for pre-v4.0 cores.
+	 * with ring mode. Only applicable for pre-v4.0 cores. Platform glue
+	 * is not expected to change this.
 	 */
-	if (priv->extend_desc && priv->mode == STMMAC_RING_MODE)
-		priv->plat->dma_cfg->atds = 1;
+	priv->plat->dma_cfg->atds = priv->extend_desc &&
+				    priv->mode == STMMAC_RING_MODE;
 
 	/* Rx Watchdog is available in the COREs newer than the 3.40.
 	 * In some case, for example on bugged HW this feature
-- 
2.47.3


