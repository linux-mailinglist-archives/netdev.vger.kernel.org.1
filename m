Return-Path: <netdev+bounces-273930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lb8E5PHzGn5WgYAu9opvQ
	(envelope-from <netdev+bounces-273930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30675375C3B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C9E8302D939
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8137BE6C;
	Wed,  1 Apr 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R41ryk/5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D1376BCD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028108; cv=none; b=aVgmnHl9udMByur+6UbNxB7DP5f4fY3JTq8DVtlzb+s2iSnne8q9wX1Gyusp4hgccSoYjTVflbcCiTYPkregQAtu2CZWvVLOfU1PmDJIpHV7vuAE9KmC4cr11o2bAMQGd4F79BBHnLuU9mmE9sCdrGActNCvHB+oxL/8D7f/mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028108; c=relaxed/simple;
	bh=gxLvRjxkG6rrI0xx5WKcTzsXmfNu+NFI4OdCaaMr5XU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=d9RUYVBE6lATM78GS5MsT91+a8lr3QB074PM3CywYSEYwR2C+vCXn8/En4nFcBu2Wmv97xpAZl6YZuCzoNv+Y6pJxtYPdXXdfGwBY7Gfp7M/+MkT6QAgEeOcHmGFBtXpZecFCBcutvrq9EJDBOFls0pL17NuYkUurOUSGB9oZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R41ryk/5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yRM4MS7lMXrkCnlS5Wb2LjAcWP2fmJloN6RcG6v0ddU=; b=R41ryk/50ww9uiCE+0QbzGMg3w
	pf0RroFFHdyxgyDsoIHxiKoRxaK03owUMqaMcxoAmqmip9RUvA6FvgMy7rIWTL+bL9DKttO/qQvW0
	jpkpBw7pqiGLk5qQqnTHiq0kh4YxA9hKSxzl/UO6VV9dD+rMidgvhTDmvQ6pOTbHhKlWZP+FCVgkm
	W2C6Y6/HdiRoAikzD1VWw5tO/izSj9yLk+xLiCQfHxrZhZXX4rrQaRjZ2GaTbgfNToj55Q2of8c7k
	TS1O9MkuwGwEASKs1Ywlrzx8+7KMXOe9BXpLtT8V2QwC9uHdDdAUMobVDrpTldk8zoiGDLNq1b11s
	3IBCHWGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35434 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptR-000000002ge-09rs;
	Wed, 01 Apr 2026 08:21:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7ptO-0000000EatC-39il;
	Wed, 01 Apr 2026 08:21:34 +0100
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
Subject: [PATCH net-next v2 05/14] net: stmmac: add TSO check for header
 length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7ptO-0000000EatC-39il@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:34 +0100
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273930-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.876];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 30675375C3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the STM32MP151 documentation which covers dwmac v4.2, the
hardware TSO feature can handle header lengths up to a maximum of 1023
bytes.

Add a .ndo_features_check() method implementation to check the header
length meets these requirements, otherwise fall back to software GSO.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2b5bccc727a5..031ffb78f40d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4385,6 +4385,20 @@ static size_t stmmac_tso_header_size(struct sk_buff *skb)
 	return size;
 }
 
+/* STM32MP151 (dwmac v4.2) and STM32MP25xx (dwmac v5.3) states for TDES2 normal
+ * (read format) descriptor that the maximum header length supported for the
+ * TSO feature is 1023 bytes.
+ *
+ * While IPv4 is limited to MAC+VLAN+IPv4+ext+TCP+ext = 138 bytes, the IPv6
+ * extension headers aren't similarly limited.
+ */
+static bool stmmac_tso_valid_packet(struct sk_buff *skb)
+{
+	size_t header_len = stmmac_tso_header_size(skb);
+
+	return header_len <= 1023;
+}
+
 /**
  *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
  *  @skb : the socket buffer
@@ -4945,7 +4959,8 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		queue = skb_get_queue_mapping(skb);
-		if (!stmmac_tso_channel_permitted(netdev_priv(dev), queue))
+		if (!stmmac_tso_channel_permitted(netdev_priv(dev), queue) ||
+		    !stmmac_tso_valid_packet(skb))
 			features &= ~NETIF_F_GSO_MASK;
 	}
 
-- 
2.47.3


