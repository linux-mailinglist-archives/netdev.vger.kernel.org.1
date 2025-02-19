Return-Path: <netdev+bounces-167659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1135A3B652
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E23D177C06
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE01DE3C5;
	Wed, 19 Feb 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9s+9nrn"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAC1DE3BE;
	Wed, 19 Feb 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954937; cv=none; b=cwCRJLBLrj6gXlCm51862FsDNl5LvcazUzZLbKCtUJ0lBZYbuBT8aFOJjl0dzS4UCxGw2xOYtydQAg/8rCL8+UoZ4jkhzQF5PINwvA9y6wWi5GFcVkrBkhWW0Hi4pAepEIcgQiSdm2NTR+nxw8HsBLj3vE3KnUykhThxgp8STA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954937; c=relaxed/simple;
	bh=fQbJ1QkpxFm4SGCWfxJzdDPB5fI9jirKoaXycqEgolc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT6NMfG85tj9q2PT/6HKdLkW8O5FXRffpAkLx0wyTkZXc86oZyFfrntU+dnLmRXT/P/ki6CZt7oNdVHve2z3jMlHDO7eNSsj1efFtScPKd9tjiNM7SnQ+Q3lDGX5B0F94eFkfhl7nFX4nH2QV7gwkcT+biknlxofH6Aci4cYiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9s+9nrn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC92F44443;
	Wed, 19 Feb 2025 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739954933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uQR7Ryzn6i4UNyU9zcKaYBUdL/qVB7QaGkD/Wt9o6k=;
	b=R9s+9nrniofjhO95BXMJmUUr1CFUhslXjgpUMJM3tORBZZdAUyzU+/rBYKvpVY8zZjdOU0
	uaZp1o2BSikw69d3XAqTIfWKsQT2EeFq+fk8C+cxbp0wv1bip5cQYY5GQABxk0DLgBuw9l
	Tq9D5WolkMPizxMWtpO4HuyPH2nuUbCr+62N9QUG8qZtuxm9BHLVViF0hOaHIQnMXWIrHB
	emQggSTYM08I4edTDTUoGs56F8N6dJp3N5qdG+FagwyYglnAE6b30Fn+hV35vNtGpnujYN
	j7nttnbBAHcJVmielnnOyhqE6rHl8kMgzogvip3onh6hiqQiQraj2ak6wsN6mA==
Date: Wed, 19 Feb 2025 09:48:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: cadence: macb: Synchronize stats calculations
Message-ID: <20250219094851.0419759f@2a02-8440-d103-5c0b-874f-3af8-c06f-cd89.rev.sfr.net>
In-Reply-To: <20250218195036.37137-1-sean.anderson@linux.dev>
References: <20250218195036.37137-1-sean.anderson@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepvdgrtddvqdekgeegtddqugdutdefqdehtgdtsgdqkeejgehfqdefrghfkedqtgdtiehfqdgtugekledrrhgvvhdrshhfrhdrnhgvthdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtohepnhhitghol
 hgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Sean,

On Tue, 18 Feb 2025 14:50:36 -0500
Sean Anderson <sean.anderson@linux.dev> wrote:

> Stats calculations involve a RMW to add the stat update to the existing
> value. This is currently not protected by any synchronization mechanism,
> so data races are possible. Add a spinlock to protect the update. The
> reader side could be protected using u64_stats, but we would still need
> a spinlock for the update side anyway. And we always do an update
> immediately before reading the stats anyway.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/net/ethernet/cadence/macb.h      |  2 ++
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 5740c98d8c9f..2847278d9cd4 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1279,6 +1279,8 @@ struct macb {
>  	struct clk		*rx_clk;
>  	struct clk		*tsu_clk;
>  	struct net_device	*dev;
> +	/* Protects hw_stats and ethtool_stats */
> +	spinlock_t		stats_lock;
>  	union {
>  		struct macb_stats	macb;
>  		struct gem_stats	gem;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 48496209fb16..990a3863c6e1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1978,10 +1978,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
>  
>  		if (status & MACB_BIT(ISR_ROVR)) {
>  			/* We missed at least one packet */
> +			spin_lock(&bp->stats_lock);
>  			if (macb_is_gem(bp))
>  				bp->hw_stats.gem.rx_overruns++;
>  			else
>  				bp->hw_stats.macb.rx_overruns++;
> +			spin_unlock(&bp->stats_lock);
>  
>  			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>  				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
> @@ -3102,6 +3104,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>  	if (!netif_running(bp->dev))
>  		return nstat;
>  
> +	spin_lock(&bp->stats_lock);
>  	gem_update_stats(bp);
>  
>  	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
> @@ -3131,6 +3134,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>  	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
>  	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
>  	nstat->tx_fifo_errors = hwstat->tx_underrun;
> +	spin_unlock(&bp->stats_lock);
>  
>  	return nstat;
>  }
> @@ -3138,12 +3142,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>  static void gem_get_ethtool_stats(struct net_device *dev,
>  				  struct ethtool_stats *stats, u64 *data)
>  {
> -	struct macb *bp;
> +	struct macb *bp = netdev_priv(dev);
>  
> -	bp = netdev_priv(dev);
> +	spin_lock(&bp->stats_lock);

Sorry if I missed something, but as you're using that lock within the
macb_interrupt(), shouldn't it be a spin_lock_irqsave() for all the
callsites that aren't in irq context ?

You would risk a deadlock otherwise.

Thanks,

Maxime

