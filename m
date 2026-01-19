Return-Path: <netdev+bounces-251110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4433D3ABA2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 017F1300D32E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3936C0C5;
	Mon, 19 Jan 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sOUgVvXT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C643361645
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832510; cv=none; b=FWYFbWMmcTNpnB32PWOenNxEEZL5G6i1Yyx+CLOmW7861QRgtS74g06HOANcWORvZnTs1qSOyILqKmP0t0qNrb0MzNFHUVIwWsLMPMkCUal5+dQ2XgKuwNS3pc8lCqQ5yd4EsLuwwPqeNTcnSNlznWbdwuTwd7qnJ8nImZX8t8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832510; c=relaxed/simple;
	bh=oU7YAszKI3kX7CJo4ykE87U9XQNUMUDn7ndQH4zm/F8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=TCBtsLGpK9pjz7aWwqqFjeUiSScAC+hFHc0PSIJPojhFaMkk9BRVlogQf9CDBK3D2TiO7DG/hlDJrpQr6kQypS5DXFoieybhCNJr3u2NHERA0qGu/IvljmqF7vugycc/BgpsMfpCV6Zug0N3zmfn2YM5wEibeaMSXAzDwvcj7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sOUgVvXT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+DI6q3ezeAcW/RwFwkGoz60ZMnTmsonDvKRYBklNGiQ=; b=sOUgVvXT4Q1xtFJSB7gY92yeP6
	OH+GeF/DoJaESvHWaNKLLWGqxQ85uzRbbayLSmcv7OmLFxe1bYnR7FY9GcnH4ZZq0FsdiQNgNAO0m
	u5J1dzPNQWT+hZ9/kOofsazeIP+WuQfLFirZGeauJM22Fv4kp67jHO78CysKdc8KbU/yJwrh8rGEB
	zutz0SYQU8pvbijtAaIcK5Kp5tGXsMfoBK02lbW1nk57t/88VwrKiIrItkuElgqVgTrGwwm5ipzX7
	Z/7lo9PFUYnInTbfItlh9lz1CbEfqQrcENBvjLhhDyv+I/5IVfc/gjptMlOcsRSunZ6iX5euc7A30
	R7BuOtFQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38882 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vhq8O-000000005HT-3eys;
	Mon, 19 Jan 2026 14:21:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vhq8O-00000005N5s-0Ke5;
	Mon, 19 Jan 2026 14:21:36 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Tao Wang <tao03.wang@horizon.auto>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: stmmac: fix resume: calculate tso last_segment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vhq8O-00000005N5s-0Ke5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 19 Jan 2026 14:21:36 +0000

Tao Wang reports that sometimes, after resume, stmmac can watchdog:
NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms

When this occurs, the DMA transmit descriptors contain:
eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000

where descriptor 221 is the TSO header and 222 is the TSO payload.
tdes3 for descriptor 221 (0xb04416a0) has both bit 29 (first
descriptor) and bit 28 (last descriptor) set, which is incorrect.
The following packet also has bit 28 set, but isn't marked as a
first descriptor, and this causes the transmit DMA to stall.

This occurs because stmmac_tso_allocator() populates the first
descriptor, but does not set .last_segment correctly. There are two
places where this matters: one is later in stmmac_tso_xmit() where
we use it to update the TSO header descriptor. The other is in the
ring/chain mode clean_desc3() which is a performance optimisation.

Rather than using tx_q->tx_skbuff_dma[].last_segment to determine
whether the first descriptor entry is the only segment, calculate the
number of descriptor entries used. If there is only one descriptor,
then the first is also the last, so mark it as such.

Further work will be necessary to either eliminate .last_segment
entirely or set it correctly. Code analysis also indicates that a
similar issue exists with .is_jumbo. These will be the subject of
a future patch.

Reported-by: Tao Wang <tao03.wang@horizon.auto>
Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b16d1207b80..af9395d054a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4320,11 +4320,11 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct stmmac_tx_queue *tx_q;
+	bool set_ic, is_last_segment;
 	u32 pay_len, mss, queue;
 	int i, first_tx, nfrags;
 	u8 proto_hdr_len, hdr;
 	dma_addr_t des;
-	bool set_ic;
 
 	/* Always insert VLAN tag to SKB payload for TSO frames.
 	 *
@@ -4512,10 +4512,16 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_enable_tx_timestamp(priv, first);
 	}
 
+	/* If we only have one entry used, then the first entry is the last
+	 * segment.
+	 */
+	is_last_segment = ((tx_q->cur_tx - first_entry) &
+			   (priv->dma_conf.dma_tx_size - 1)) == 1;
+
 	/* Complete the first descriptor before granting the DMA */
 	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
-				   tx_q->tx_skbuff_dma[first_entry].last_segment,
-				   hdr / 4, (skb->len - proto_hdr_len));
+				   is_last_segment, hdr / 4,
+				   skb->len - proto_hdr_len);
 
 	/* If context desc is used to change MSS */
 	if (mss_desc) {
-- 
2.47.3


