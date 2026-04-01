Return-Path: <netdev+bounces-273939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iANrO53JzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E84375E92
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E74230EB00B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE2A37C0ED;
	Wed,  1 Apr 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1MX05kwM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726B379998
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028148; cv=none; b=pCb2O/8j0QNyaEvPruRkJcLk1guFIie9PWSYfKucGiidXp4R2dTEEOk8QEQ6Sz5qGWWPLznqKnSD0XGyaANAVjL8vaVljTJR9fpW4O0eYhsj35VHZ5n28C5Rvl+dFkprwHB80sUGvG0gwvX/Me8HCDoS/cAAyobeNvbMmWGKNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028148; c=relaxed/simple;
	bh=8x+9FJRmZfxgEcXhzz36OT7S1cp6v1RFSFuji2PXCqU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GaUycRwRU9OL0aO3/8Mgt6VyD3bk0oN35oe9sqJc815eewjkZJZLfcCnWpVVhqrFGC2B25fV5GVRL7xIZOVPP8n2r0HnMq9096qrqTKZc/yXXXNNBZBpBqh9kO6+7Y09X7KrW2C5M/vJ8fUnns0UkeQY3sJu+m60EmM6d5WSup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1MX05kwM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=alPn9o8ewPxsbOPsRLwsXL+u+H9tvwotLTBjFhbxb9s=; b=1MX05kwMDnGsZEqsRJbKB+ZR2o
	cFODAf/0XkUTtVkekuwBDJGtopg5rtuD2yEMu4fuMGYmuvaw0rlPkOBlP0rKRTwzGqY2kDGAK1zAI
	uZTjOYlZuPmRXKYLM72sD23mhic1XNO23CjumH1fhTR51og17igo3PxONsIid74US9Dx+oWQb5FAG
	9C50G/+u2ddRZpWIf/2ZIzGce5VDQxgniIRJXxkqWiBGPEPfRbycFP3H8u89GcvtoLdXdsvGRDPxC
	Uk2+ZweaKcDXIkNNG5gwB83CDSeayWJLpufgYVfDL+gRPfbFth3o4zdGw4PvdGpIj/HHVnAafICCQ
	CcA5EB/A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59464 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7pu4-000000002jA-37sy;
	Wed, 01 Apr 2026 08:22:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pu3-0000000Eatz-39ts;
	Wed, 01 Apr 2026 08:22:15 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
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
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 13/14] net: stmmac: check txpbl for TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pu3-0000000Eatz-39ts@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:22:15 +0100
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
	TAGGED_FROM(0.00)[bounces-273939-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.874];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 57E84375E92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Documentation states that TxPBL must be >= 4 to allow TSO support, but
the driver doesn't check this. TxPBL comes from the platform glue code
or DT. Add a check with a warning if platform glue code attempts to
enable TSO support with TxPBL too low.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5286ad6412a3..406c32142d90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4388,6 +4388,8 @@ static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
 static void stmmac_set_gso_features(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	const struct stmmac_dma_cfg *dma_cfg;
+	int txpbl;
 
 	if (!(priv->plat->flags & STMMAC_FLAG_TSO_EN))
 		return;
@@ -4397,6 +4399,18 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 		return;
 	}
 
+	/* FIXME:
+	 *  STM32MP151 (v4.2 userver v4.0) states that TxPBL must be >= 4. It
+	 *  is not clear whether PBLx8 (which multiplies the PBL value by 8)
+	 *  influences this.
+	 */
+	dma_cfg = priv->plat->dma_cfg;
+	txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
+	if (txpbl < 4) {
+		dev_warn(priv->device, "txpbl(%d) is too low for TSO\n", txpbl);
+		return;
+	}
+
 	ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
-- 
2.47.3


