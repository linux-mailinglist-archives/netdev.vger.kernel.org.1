Return-Path: <netdev+bounces-122729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24A96253A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE80C1C2168B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372271684B9;
	Wed, 28 Aug 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="koD4xEJo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861315C15B;
	Wed, 28 Aug 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842091; cv=none; b=O8ayzMlK4LG8FBvwmCK16M3LaIi+/0lXVzThmG2JZPzLGbBrtUzVpgnqOGp4iEAI/7i9Y0Ei05qjaqaU9ytP6GrEraLZNHWo49edEHrbhLlWIKJb/iu6st3LNDniIQzqzC5xbMpXBtg53aCLhL5MbreLiJqa0T4Vg8drLxLmCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842091; c=relaxed/simple;
	bh=AvpK99Ogtlm6T/flrdzVUTirkdfok6X8bw/cYu6MaPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPHr9V74Dmqk8TRjh32U5E+3HqcTfcHO1gUudn+FLGiklJEPQX61OGR5nXTGFuLuRgmUsgdpofFfDWuHS6LZx2eXJo074PxjJQgrWAxpYuEc799d+loq2Eu7ck+trj8ZIqbSRS6T6K0+Oa9tSOhj37+UB874PACVPv26nh+MX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=koD4xEJo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HiHXsrU1uxoz44DKaTX7gem1HpGF3cKfHBXLo1xRc0I=; b=koD4xEJolxR4rrnjzgYuXUwenr
	G7d/pX6vMbb+NMG/3KQa5ayqwKAWfdlTSOn0VvdzB+og4f+7CbUUHD+ZXYy5xLsC8N7Bz4RS/8Tnk
	HKF1ajkZTxo8euK2Tq7mtjC/AQ3UsMaR7Jp3VbFTCRNNpyUvswfyYHK9hyaIHqzkwhPgisRd41HXx
	ReF4DzwxixULXa4yCDZt9/iTYUNgGhg3GCRuGyGfbhxpTVpc72KnGPT7o/Jv5lMwWMmzo0SvalvnR
	cJOLTq9pLwKbEfyxnmrx9ZwSvtU/djScjAiF3rL1SmYBqsMLrFtbciDpIiRZD4p2BtaexpsnXZCmt
	oMKW86kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sjG4S-0008Ug-0G;
	Wed, 28 Aug 2024 11:38:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sjG4N-0004PU-1l;
	Wed, 28 Aug 2024 11:38:31 +0100
Date: Wed, 28 Aug 2024 11:38:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 6/6] net: ethernet: fs_enet: phylink conversion
Message-ID: <Zs7+J5JWpfvSQ8/T@shell.armlinux.org.uk>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
 <20240828095103.132625-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828095103.132625-7-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 28, 2024 at 11:51:02AM +0200, Maxime Chevallier wrote:
> +static int fs_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +	struct fs_enet_private *fep = netdev_priv(dev);
> +
> +	if (!netif_running(dev))
> +		return -EINVAL;

Why do you need this check?

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

