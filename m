Return-Path: <netdev+bounces-163033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B8A2942C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53EE3B1385
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF91FC11F;
	Wed,  5 Feb 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dfbQkCFt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43018A6A9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768285; cv=none; b=X+i7MGZoz3Ji0ZgsXqsXRJ/G7KjM4r7jNYd/+H3mMYi9ZLK8NX8sz0BRM8ryJnBKtlyPRxjS1ymniT5Sg6Rl/rwI6sPaOjBr4HpCOjMLx82PQNOhWetoZezdhY3Gwuy9CqpNRcLkFQ0SrRB2i4aokIpdtOIA23dsp53YV6ug+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768285; c=relaxed/simple;
	bh=QrrJZJAMX9KtEMw78bOC5inI5qhfnPipR9iewb2NaaQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WiXXItsHATTJ7IqFusGVQN+ctnbfxAkHzOHVh+Xl3x2pseUjf5IT6LCo6f9vXwLdUpgB8sjON2pR33pGJXGUFVeH7LeJfB3XL+Lj/pWPdf0vEIt9XaSCLBRT0GzZ583g1oX4NXVXUa6nmSPahzZyqQO0hV2dwpAWoKEY1CSXdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dfbQkCFt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+5GmaJXZT5l+1wfRT+lAuNHUWIAAutwCYXRr+Clwac=; b=dfbQkCFt/AbX3Ly6CPenOsJUPe
	JdqX1DA4wpqobctID/Ck0UuvZ1CMXIQHdzsE0XVgGlGArAHwQJbnIGom31uIg+2HuKF1dtxljd1hf
	s+g4YyytgRUA0lMoYClFGlaDCAZLJXVPGhjBWSgO7+HQ9Iw7bg/FLrEEev1K3wPMkHEBOkDuTOMHL
	cucH65Ff6VuOkN+Mhzow3iUephAPRHh+7KyZjof/KUS9Jivej6ERPRbIFVWrpfHFoXNfRTunOvVjN
	Szqg54bElEnZsbP0cJQ6ozMGW+/P7QZ+2YjgS9nw9BRO5aRmQraHqqWeKymMt6NyCv5P1mghu2Zrt
	8XK4KCcw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38600 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tfh3a-0007Sh-16;
	Wed, 05 Feb 2025 15:11:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tfh3G-003aRG-RI; Wed, 05 Feb 2025 15:10:54 +0000
In-Reply-To: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
References: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 1/3] net: phylink: provide
 phylink_mac_implements_lpi()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tfh3G-003aRG-RI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 15:10:54 +0000

Provide a helper to determine whether the MAC operations structure
implements the LPI operations, which will be used by both phylink and
DSA.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c |  3 +--
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 214b62fba991..6fbb5fd5b400 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1957,8 +1957,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	pl->mac_supports_eee_ops = mac_ops->mac_disable_tx_lpi &&
-				   mac_ops->mac_enable_tx_lpi;
+	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
 	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
 			       pl->config->lpi_capabilities &&
 			       !phy_interface_empty(pl->config->lpi_interfaces);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 898b00451bbf..0de78673172d 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -737,6 +737,18 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 	}
 }
 
+/**
+ * phylink_mac_implements_lpi() - determine if MAC implements LPI ops
+ * @ops: phylink_mac_ops structure
+ *
+ * Returns true if the phylink MAC operations structure indicates that the
+ * LPI operations have been implemented, false otherwise.
+ */
+static inline bool phylink_mac_implements_lpi(const struct phylink_mac_ops *ops)
+{
+	return ops && ops->mac_disable_tx_lpi && ops->mac_enable_tx_lpi;
+}
+
 void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 				      unsigned int neg_mode, u16 bmsr, u16 lpa);
 void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
-- 
2.30.2


