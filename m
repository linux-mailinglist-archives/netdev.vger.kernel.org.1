Return-Path: <netdev+bounces-127801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB575976914
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B2BB20F7C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C501A42A8;
	Thu, 12 Sep 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcc23E+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C741A3A96;
	Thu, 12 Sep 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143897; cv=none; b=gcNk5q7bSDr0dopr/GuCYvYobgaw/9BgLEVhSFKAs6hlb/fJnQuCaBcI30TBcSNSIMyHrcMWbKuKfYULq25Va7XGUE3LYiEATrsktxpEQlJgKB8SCGGoNPK0bg5WKmPQ1WfGKNy644/WFzgIGmV7jTOEnQ+rN3nVakyqY7Ovsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143897; c=relaxed/simple;
	bh=FRng+cMcwQMKVnWZW9h7CJJYKyq4oEf6Bbu86/1oL1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYq+5QB4OQjdqU8e2Zm7h/JwuzCnEM+jSf4pM8lOSknJuT/opvNrXhnq/ODlNT1JEIW6n1q6cogIaYcelpLUE5rbeJnBuPIk5DAytvhNfgORgdfveAaoduVTQKgDmAfx4J9mMJbbS68U2ZAZ0ero+mshSaebZLr0NiEb72+nsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcc23E+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FB9C4CEC3;
	Thu, 12 Sep 2024 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726143897;
	bh=FRng+cMcwQMKVnWZW9h7CJJYKyq4oEf6Bbu86/1oL1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qcc23E+AfF8wTibBCKmNZ4QMpEN2nWYM4IehjV7PjXYbetENXL2jpMMfWatGznTrU
	 ohnt5H5hZqf0ONtcZ8iaK+LOkmyi4P3pgfKmuusPXCNEM2a3ZvVMKgq7ZGhuz2KHaU
	 Gt2yjnQgy3tpA+PTslxmxNGwKGtylyhu0jxJIw1zguH2EQdGcBqMe6gn5zJy7JN3ck
	 wkhzTB5FN9WpC6yPeqPE1WyvOK2AATdI2kW+9L6EV+wcHRP4hC4lhLBNOG9EXfdyHG
	 oBQaJ0rXxWOifkoBXNqBJLWaCRE/xJyKrgvdE3+h8DtEPgNbmExtvmzSoPnb/M3a6M
	 lHrFJb1lhZSNw==
Date: Thu, 12 Sep 2024 13:24:51 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 3/7] net: phy: lxt: Mark LXT973 PHYs as having a
 broken isolate mode
Message-ID: <20240912122451.GM572255@kernel.org>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
 <20240911212713.2178943-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911212713.2178943-4-maxime.chevallier@bootlin.com>

On Wed, Sep 11, 2024 at 11:27:07PM +0200, Maxime Chevallier wrote:
> Testing showed that PHYs from the LXT973 family have a non-working
> isolate mode, where the MII lines aren't set in high-impedance as would
> be expected. Prevent isolating these PHYs.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/lxt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
> index e3bf827b7959..55cf67391533 100644
> --- a/drivers/net/phy/lxt.c
> +++ b/drivers/net/phy/lxt.c
> @@ -334,6 +334,7 @@ static struct phy_driver lxt97x_driver[] = {
>  	.read_status	= lxt973a2_read_status,
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
> +	.flags		= PHY_NO_ISOLATE,
>  }, {
>  	.phy_id		= 0x00137a10,
>  	.name		= "LXT973",
> @@ -344,6 +345,7 @@ static struct phy_driver lxt97x_driver[] = {
>  	.config_aneg	= lxt973_config_aneg,
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
> +	.flags		= PHY_NO_ISOLATE,
>  } };

Hi Maxime,

This duplicates setting .flags for each array member
updated by this patch.

>  
>  module_phy_driver(lxt97x_driver);

-- 
pw-bot: cr

