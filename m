Return-Path: <netdev+bounces-239491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4286BC68B94
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0C12E2C703
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC132E13D;
	Tue, 18 Nov 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hJSUJUJ7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC429337B8A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460091; cv=none; b=tlw+NqnZT/MAWlv7Ha5IbTJ82+cEKvvu0WzGhpoy/SPjwPRXfjDcoYwlrz172vnEGxcopeXzosDmGnFG57ycvpiQ74d3gbQusbZr8t3ceeGtvvq3PxU/lE8rI82FHjJRWtwX6R11hZAcYuLBBIGFhP2h+3QO0R7E+zWsRMAGPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460091; c=relaxed/simple;
	bh=ty6O0d+RWxRjK9C0QMGtzzKBAKXuHvKq5xxVT/lTzv0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZhBkg6tqsPJ7Q5CQpj1bm7FZPxFT/go+mXZ9H017/XhFTAZhCWnH/kKLpUU5CttPPbZaOV613Rt4v5+uwbOeUXlWqzoEb9QK6KUpCxBTNm6WeXKfOkGkNYJtjvwsz1jMkyX8Fb8n//bjOouOH38bP5MU3kFqLArlubb+nmHaFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hJSUJUJ7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3xmjMUUvq7h5ZfP5IKPwY8giY0PGq3yEuGIgZGyJhEg=; b=hJSUJUJ7Ojqo8dvGWetwdk7que
	tIGSqMPX3advWES945ykHI2DO5v85FlqDLjcJLx6lWUmUbb0p1lipRfyDJKBAB6OdZPNiXwuto32a
	ESAZtmOGTqG3p37+X9GMvj43w9qUlPNE3/OKzOqoJhN1q8dfqLfqeOPJVd8qr5bTUbRLCxdWdplrX
	yNttHyWEKbFw82rQsBuPk/qMiHsJ01GbJBZgjTPdZu+/V3smzH0/wqd9qM8DdRKf/Px0PLzVx4IHh
	zOJl/axL3nuEuMD6XlzomMtrkLHm5OXoPaTlIOcI9+IkVrOfv8YF58rzBvFfq9mKZ66ukdzM93O69
	ueA7a3MQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39174 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLIWX-00000000328-1HEy;
	Tue, 18 Nov 2025 10:01:21 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLIWW-0000000Ewkl-21Ia;
	Tue, 18 Nov 2025 10:01:20 +0000
In-Reply-To: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
References: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: stmmac_is_jumbo_frm() returns
 boolean
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLIWW-0000000Ewkl-21Ia@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Nov 2025 10:01:20 +0000

stmmac_is_jumbo_frm() returns whether the driver considers the frame
size to be a jumbo frame, and thus returns 0/1 values. This is boolean,
so convert it to return a boolean and use false/true instead. Also
convert stmmac_xmit()'s is_jumbo to be bool, which causes several
variables to be repositioned to keep it in reverse Christmas-tree
order.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 9 ++++-----
 drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 9 ++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index d14b56e5ed40..120a009c9992 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -83,14 +83,13 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	return entry;
 }
 
-static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
+static bool is_jumbo_frm(unsigned int len, bool enh_desc)
 {
-	unsigned int ret = 0;
+	bool ret = false;
 
 	if ((enh_desc && (len > BUF_SIZE_8KiB)) ||
-	    (!enh_desc && (len > BUF_SIZE_2KiB))) {
-		ret = 1;
-	}
+	    (!enh_desc && (len > BUF_SIZE_2KiB)))
+		ret = true;
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 4953e0fab547..f257ce4b6c66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -541,7 +541,7 @@ struct stmmac_rx_queue;
 struct stmmac_mode_ops {
 	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
 		      unsigned int extend_desc);
-	unsigned int (*is_jumbo_frm)(unsigned int len, int ehn_desc);
+	bool (*is_jumbo_frm)(unsigned int len, bool enh_desc);
 	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 			 int csum);
 	int (*set_16kib_bfsize)(int mtu);
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 039903c424df..382d94a3b972 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -91,14 +91,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	return entry;
 }
 
-static unsigned int is_jumbo_frm(unsigned int len, int enh_desc)
+static bool is_jumbo_frm(unsigned int len, bool enh_desc)
 {
-	unsigned int ret = 0;
-
-	if (len >= BUF_SIZE_4KiB)
-		ret = 1;
-
-	return ret;
+	return len >= BUF_SIZE_4KiB;
 }
 
 static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index db68c89316ec..12fc31c909c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4579,18 +4579,18 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
  */
 static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	unsigned int first_entry, tx_packets, enh_desc;
+	bool enh_desc, has_vlan, set_ic, is_jumbo = false;
 	struct stmmac_priv *priv = netdev_priv(dev);
 	unsigned int nopaged_len = skb_headlen(skb);
-	int i, csum_insertion = 0, is_jumbo = 0;
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
+	unsigned int first_entry, tx_packets;
 	int gso = skb_shinfo(skb)->gso_type;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_edesc *tbs_desc = NULL;
 	struct dma_desc *desc, *first;
 	struct stmmac_tx_queue *tx_q;
-	bool has_vlan, set_ic;
+	int i, csum_insertion = 0;
 	int entry, first_tx;
 	dma_addr_t des;
 	u32 sdu_len;
-- 
2.47.3


