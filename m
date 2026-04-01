Return-Path: <netdev+bounces-273933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODe+Dn/JzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6D375E7B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0429630DD906
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BBF37BE6F;
	Wed,  1 Apr 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YPWoPziv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9737BE6C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028121; cv=none; b=J1DAol3Mueq8HcUYcuWt+h+4hGCZNukJ+vN7lSvPeDJW9vmdtTZoev76I7QdA1m0a6A1XlaVNuAYXe2svDaVeB/k8jBf6JSeg89HmwuZzEa0FyWVZ6RTd0wZjmqYdF0Bq7tmENSx7OtZixJI5jMPs/DHG4kZogyaEIzQQO2eSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028121; c=relaxed/simple;
	bh=e6SojoCkMeGKm8lzGHx9/g0cPtsrOYqgRPMxNz8IpDQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZX2Nr/YL9/4SzhiiIqbFLHWKXscWVe2D6fQNOXGjJ0WnxwjbTCFlZw36diplvxPn5ntO1fxsvBUHC0VDipvslGpr42ZuMUfrMFfbnANzg/j0p3zTXuMIe93O6AJxQ+at867JD6cIawuDiM6ghafUxdZP/OxGfZpl+eHb3+EhYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YPWoPziv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r3zNFXyOKF+BLz89Sva1o0uRJQ4NNntdmHQyPfgJhJ4=; b=YPWoPzivQBHQrro+coYNy2DvvG
	jQyG8o4qVCZbJgTTipRgxggrJAz2LZCbyyb0/bR8tGDIVB8+iCFnvP4T7984cOt9VH8p5xG8P1yap
	AokkJp34dL0o/0J14ojiqEqfXLg9R2jWZ7QtKc9EF1bvD6DH30BXpAwA/QLt1dTVwshx/rur9IO+A
	0hFfKB2Vd+nUFnnZTjsYRyl44AQYp9tbiXKN8mWZF/jeABZA3nl+XbP41FA2YULN1dEDohu3Dbwku
	3p0m4D0fDLXBdfOxVIGpjlBhz2EhQnzMzhsOQhG7g2XxEpIMPyd6JwTKbjy4+5BcWJ4mUB4e7lCRj
	LSBf5m8Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57410 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptf-000000002hX-1Ygn;
	Wed, 01 Apr 2026 08:21:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pte-0000000EatU-0ILt;
	Wed, 01 Apr 2026 08:21:50 +0100
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
Subject: [PATCH net-next v2 08/14] net: stmmac: move check for hardware
 checksum supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pte-0000000EatU-0ILt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:50 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273933-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.872];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 90F6D375E7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a check in .ndo_features_check() to indicate whether hardware
checksum can be performed on the skbuff. Where hardware checksum is
not supported - either because the channel does not support Tx COE
or the skb isn't suitable (stmmac uses a tighter test than
can_checksum_protocol()) we also need to disable TSO, which will be
done by harmonize_features() in net/core/dev.c

This fixes a bug where a channel which has COE disabled may still
receive TSO skbuffs.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c67f042a90af..d3cbe71b9af1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4757,22 +4757,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Check if VLAN can be inserted by HW */
 	has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
 
-	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
-	/* DWMAC IPs can be synthesized to support tx coe only for a few tx
-	 * queues. In that case, checksum offloading for those queues that don't
-	 * support tx coe needs to fallback to software checksum calculation.
-	 *
-	 * Packets that won't trigger the COE e.g. most DSA-tagged packets will
-	 * also have to be checksummed in software.
-	 */
-	if (csum_insertion &&
-	    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
-	     !stmmac_has_ip_ethertype(skb))) {
-		if (unlikely(skb_checksum_help(skb)))
-			goto dma_map_err;
-		csum_insertion = !csum_insertion;
-	}
-
 	entry = tx_q->cur_tx;
 	first_entry = entry;
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
@@ -4788,6 +4772,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (enh_desc)
 		is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);
 
+	csum_insertion = skb->ip_summed == CHECKSUM_PARTIAL;
+
 	if (unlikely(is_jumbo)) {
 		entry = stmmac_jumbo_frm(priv, tx_q, skb, csum_insertion);
 		if (unlikely(entry < 0) && (entry != -EINVAL))
@@ -4949,11 +4935,25 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 					       struct net_device *dev,
 					       netdev_features_t features)
 {
-	u16 queue;
+	struct stmmac_priv *priv = netdev_priv(dev);
+	u16 queue = skb_get_queue_mapping(skb);
+
+	/* DWMAC IPs can be synthesized to support tx coe only for a few tx
+	 * queues. In that case, checksum offloading for those queues that don't
+	 * support tx coe needs to fallback to software checksum calculation.
+	 *
+	 * Packets that won't trigger the COE e.g. most DSA-tagged packets will
+	 * also have to be checksummed in software.
+	 *
+	 * Note that disabling hardware checksumming also disables TSO. See
+	 * harmonize_features() in net/core/dev.c
+	 */
+	if (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
+	    !stmmac_has_ip_ethertype(skb))
+		features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
 
 	if (skb_is_gso(skb)) {
-		queue = skb_get_queue_mapping(skb);
-		if (!stmmac_tso_channel_permitted(netdev_priv(dev), queue) ||
+		if (!stmmac_tso_channel_permitted(priv, queue) ||
 		    !stmmac_tso_valid_packet(skb))
 			features &= ~NETIF_F_GSO_MASK;
 
-- 
2.47.3


