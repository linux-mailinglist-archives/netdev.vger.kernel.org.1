Return-Path: <netdev+bounces-221322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CAB5024F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C1E541111
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0E33A01A;
	Tue,  9 Sep 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o7QZaVho"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A6322DBD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434674; cv=none; b=FPtXrUy/3WomVUqHQd5CvP/Y8jthOE9sJoP6jYg8M8VKIwj54/S+3Q8q6aUTcg17TMwSJ/92VVKJme7Mx2SLzZGuftBEXLdY+EFn8EQHAEN6MzjRDhu3oa+I7QBepqWHGktKrsm5X8XBAKqv5BQW9VkcgLUzyzyNEynxIvN7WiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434674; c=relaxed/simple;
	bh=sFJ+9OwZynlz9n0NCXZbt/ZAXBQkX64Fr7+Xh9UPPkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epI2dJOggpNUHh9pSCoU4ihyWgchz9s0SKlmbEbg0cnsneaQDkwcTatkHNcx8nxl154m78WNBgslrdB10LHF/ypxFNwQQXexHR6oq8jQ5U5oSdChNuQU8RsJNIBUXQlHpNiirxTTcvQDQ1IeH8fdwAQenNHkce4eVUrNmVZbfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o7QZaVho; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gFTkWuV/UhKgQoIM3F2WXI9bu9D3fe4GTkwREGwadmo=; b=o7QZaVhopmwSq9Pcz+3FwQvEIO
	Uv3BJFq8cUjyA1ZqRosqT5PRyOEsIpw+W0ifzPlIYNt6rQld/rXJQslG5Mp65O8VPsphITWGo5k2A
	i8+JAUukz6Oq0r2hVsnDaI0XL97JaEl9qsrUyn+HaamMYYUbxYyQD+d7FQaaQ/JJUwgMBtqNjyA8P
	J/E/CZY2d3nAUIBvX9NaQEe6OAUN0fYh/1btR49u19rUqPshs+5JjlJh2UmhQegNrLiqR20jXrn3r
	0V74qhCbVzrsCpbRUpXhKpl41tSSPXH6HwmpDN/kafjwMtaFj+eZ4DNlrrc2O/Dj/6p38yAt8Ypo2
	TAzI5D8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55190)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uw12R-000000008SM-28Od;
	Tue, 09 Sep 2025 17:17:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uw12P-000000000Z1-3NF1;
	Tue, 09 Sep 2025 17:17:45 +0100
Date: Tue, 9 Sep 2025 17:17:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: mvneta: add support for hardware timestamps
Message-ID: <aMBTKTz6Oi0bzI6B@shell.armlinux.org.uk>
References: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 09, 2025 at 04:30:01PM +0100, Russell King wrote:
> Add support for hardware timestamps in (e.g.) the PHY by calling
> skb_tx_timestamp() as close as reasonably possible to the point that
> the hardware is instructed to send the queued packets.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 476e73e502fe..5f4e28085640 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2985,6 +2985,13 @@ static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
>  		if (txq->count >= txq->tx_stop_threshold)
>  			netif_tx_stop_queue(nq);
>  
> +		/* FIXME: This is not really the true transmit point, since
> +		 * we batch up several before hitting the hardware, but is
> +		 * the best we can do without more complexity to walk the
> +		 * packets in the pending section of the transmit queue.
> +		 */
> +		skb_tx_timestamp(skb);
> +

A question to netdev timestamping people...

As I understand it, skb_tx_timestamp() not only adds support for
PHY-based hardware timestamping, but also adds software timestamping
at the point this call is made (hence why it needs to be placed
carefully.)

If a driver has skb_tx_timestmap() added, should the driver also
fill in the ethtool .get_ts_info() method, presumably with
ethtool_op_get_ts_info() ?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

