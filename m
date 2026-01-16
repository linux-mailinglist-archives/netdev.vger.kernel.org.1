Return-Path: <netdev+bounces-250669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB0D38A07
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 00:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EAB1300B897
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A031A81F;
	Fri, 16 Jan 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fpcJ4ARz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316531987D;
	Fri, 16 Jan 2026 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606153; cv=none; b=MFjJvCnmDPw1wcQm/+c4Ieu38xgJ0VlvSR+otikqrG2dIOHfg1agtrBseSIZIB329rPQtXMK3teJfr44nVC1T7Dmrbj5ag0cVyELNSF0NZvHJu2YKOSe1YgO2yYnHCCKxntSWF8Lfu0lp/OzdNLPR9qwXSXBkR9eQRqyxB1QsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606153; c=relaxed/simple;
	bh=kvbojYaek5WbRfXXpN17VKj5S4j74g/KOb37gShoZlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyRwLosdO7cJHH0W9/AReyj10CgsaSEGwU8x+GT8jpzmBYkk6c+jeo1AT0q4QWR8lUEWeughVboqFjjivLxNNTwY1+pdC+DtfS8JYAqaHchYK+NrMLl3Q7h7UcGu1uzbRotiFihTe7L+6vGBje6/9nMzXvoL9eHUbOGHmosrBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fpcJ4ARz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y89AQp25tJxqhLWz3k0d+HDG26wCHWOz1xe3GMgTCFM=; b=fpcJ4ARzEWseLdm7DCmvMX8gmp
	ZlPQdLzJR1U72oXOIv8nTMSjsubA6r+CosGJsdz8BCd4PgOxCpzDqWY6NMuahZTTqyJjBZnov1J8F
	XPH+sLY0fKzgBlSWpA+5eFRxfVd/u5m82eN4r0hYO9SEx8IbSLDN+OmmJQDALiLbV2+4lWfWqjdDW
	I6IzwYZCKWwU3MU2WTS/V51+qUQDnP4O+D8hFvCl4lHhiRUGsAjvYKnKqSagXNc2hcyYRx5VQPCSB
	RqMagM6xJzZ32IYjv+1GSB7PLp5I0J2TZkW1jkGOtTYY7qcRogTyYf9DxOQ9SYxHRCHgRbxRD7nzw
	mbh+9DCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56038)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgtFa-000000002mF-3VJw;
	Fri, 16 Jan 2026 23:29:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgtFW-0000000041E-3aCg;
	Fri, 16 Jan 2026 23:29:02 +0000
Date: Fri, 16 Jan 2026 23:29:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: kuba@kernel.org, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: fix transmit queue timed out after
 resume for tso
Message-ID: <aWrJvrpIAZHQS2uv@shell.armlinux.org.uk>
References: <20260116093931.126457-1-tao03.wang@horizon.auto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116093931.126457-1-tao03.wang@horizon.auto>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 05:39:31PM +0800, Tao Wang wrote:
> after resume dev_watchdog() message:
> "NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"
> 
> The trigging scenario is as follows:
> When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true,
>  and the last_segment value is not cleared in stmmac_free_tx_buffer after
>  resume, restarting TSO transmission may incorrectly use
> tx_q->tx_skbuff_dma[first_entry].last_segment = true for a new TSO packet.
> 
> When the tx queue has timed out, and the emac TX descriptor is as follows:
> eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
> eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000
> 
> Descriptor 221 is the TSO header, and descriptor 222 is the TSO payload.
> In the tdes3 (0xb04416a0), bit 29 (first descriptor) and bit 28
> (last descriptor) of the TSO packet 221 DMA descriptor cannot both be
> set to 1 simultaneously. Since descriptor 222 is the actual last
> descriptor, failing to set it properly will cause the EMAC DMA to stop
> and hang.
> 
> To solve the issue, Do not use the last_segment  default value and set
>  last_segment to false in stmmac_tso_xmit.
> 
> Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")
> Signed-off-by: Tao Wang <tao03.wang@horizon.auto>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b3730312aeed..1735f1b50a71 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4448,6 +4448,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (dma_mapping_error(priv->device, des))
>  		goto dma_map_err;
>  
> +	tx_q->tx_skbuff_dma[first_entry].last_segment = false;
>  	stmmac_set_desc_addr(priv, first, des);
>  	stmmac_tso_allocator(priv, des + proto_hdr_len, pay_len,
>  			     (nfrags == 0), queue);

Buried in the patches I worked on as a result of the previous version
of this patch, I came up with a completely different way to deal with
this which doesn't even need .last_segment set correctly.

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: stmmac: calculate tso last_segment

Rather than using tx_q->tx_skbuff_dma[].last_segment to determine
whether the first descriptor entry is the only segment, calculate the
number of descriptor entries used. If there is only one descriptor,
then the first is also the last, so mark it as such.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2589f02ff7e..e0da51222966 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4359,11 +4359,11 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4551,10 +4551,16 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_enable_tx_timestamp(priv, first);
 	}
 
+	/* If we only have one DMA descriptor used, then the first entry
+	 * is the last segment.
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


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

