Return-Path: <netdev+bounces-225258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA253B9140B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5251763AF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B43090D4;
	Mon, 22 Sep 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wLUvKyMK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B056309EF9;
	Mon, 22 Sep 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545637; cv=none; b=I929xn/kgAi0f9xzlR+VRcGNCpVaVuAIlQIWLNevq11c79V+TrJ31pP3p5Xu5gyULyKNOw8FhacjUAxlSG3PxoL3Jssd9A2waEfdJgaQM2ttTmnMqYP7Rp6agZuVzNua7IzMuI0T9v9TGMq68LSmMGoEj2p8X8BfyedKoZhMcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545637; c=relaxed/simple;
	bh=PFDI01a6mct7hksGc4zTTa0XRLZ06Ofqa0ApwFcBc7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exPzYFS/ErkVoNuwEfbJZD1bo3NXVRPQXIJztH/XeQZ28uk6rUsiQ5Q/9IvzZ6viTbqM+fo4GUDU7nxvHmUwRdMZD2abiBvpSzjuRg9/WGabuEgg4bFOh2fsSZnHI9bjjVZ6YB5VwzHffFTWTeDD44I55EbL46tG/4OolVFQmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wLUvKyMK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S+6duT8Gy/2mwF0SaEiU9OG0xSITWAhmGxgdnKJqntE=; b=wLUvKyMKiYnKsOVJEloKadZaeD
	wCKf7RZ0rxFUjkDoKRqDHcOPznhh4DzFzJFZU/zZ49109c41Ae2vKW268IhZkQY0g1mSGsCGWPQWR
	bUjPGfGVkRbcp3XMoe7rSsdJEyUW8PgzpN8/krKFIcgwEg2zBi6htuYB73qv8OXs/T+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v0g34-009ABU-2e; Mon, 22 Sep 2025 14:53:42 +0200
Date: Mon, 22 Sep 2025 14:53:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Andy Fleming <afleming@freescale.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] net: mv643xx_eth: Fix an error handling path in
 mv643xx_eth_probe()
Message-ID: <efff779e-96e1-473a-8b9c-114b090ff02c@lunn.ch>
References: <f1175ee9c7ff738474585e2e08bd78f93623216f.1758528456.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1175ee9c7ff738474585e2e08bd78f93623216f.1758528456.git.christophe.jaillet@wanadoo.fr>

On Mon, Sep 22, 2025 at 10:08:28AM +0200, Christophe JAILLET wrote:
> If an error occurs after calling phy_connect_direct(), phy_disconnect()
> should be called, as already done in the remove function.
> 
> Fixes: ed94493fb38a ("mv643xx_eth: convert to phylib")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative and compile tested only.
> Review with care.
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 0ab52c57c648..de6a683d7afc 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -3263,6 +3263,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out:
> +	if (dev->phydev)
> +		phy_disconnect(dev->phydev);

This is correct, but it is a little bit less obviously correct than it
could be. Nothing in mv643xx_eth_probe sets dev->phydev. It happens
deep down in the call chain of of_phy_connect(). Just using:

	if (phydev)
		phy_disconnect(phydev);

would be more obvious for this probe function.

But since it is correct, Reviewed-by: Andrew Lunn <andrew@lunn.ch>
and i will leave you to decide if you want to change it.

    Andrew

