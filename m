Return-Path: <netdev+bounces-123869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB557966B29
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45140B218D2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6CA1BF7E9;
	Fri, 30 Aug 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wpzhloxb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AFF16D325;
	Fri, 30 Aug 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052189; cv=none; b=IrJ3k+P/ZduzMtk6/lWHHrwLmLbW99t+vAdo7+XijrJ9K7LIHOlQPNIm/dmwgRgJmmaAT/6WJVJ94NCQ4bViD9RWXbo4mfppLlyuiq2dJKPYaAK6XFYP4oVARH9ymvyFBp8GF6Xj8szeUU0S+dHIOYirPrp/iaB0QIj2McauzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052189; c=relaxed/simple;
	bh=VZvC7n++bZcLNhi+Oq6E1t0MGTpxMdR2sSj2mwRlrO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXRJjHkBoqDglLW/63BZKnf9M6hQ/0/0yyjU2YQgMaJ9+b/kMryQmfFisYUl7G6vk0O0MSiJ39FXv7GgzLCXKHKmpQ28NbWH3jZksuP4CScJEgoCb9tBqXorx2reK2CacWHNXsRPnsGELvMnK20qw4pKh5vgJa8X8oZ3fHtWi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wpzhloxb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EhSusv/Ri0/6QWxoLI/hMvVgiEuQpxYNq9k+BHb3qoA=; b=WpzhloxbfOXT+z/GYNIFyMNFIM
	ZxNEenSNW7FDURBlZxnL9RWJRfyKBKJ6Ou2Z3qmKX9lsMZ5cBn/QbxcvJJ7jJjDJmjxnfWC7U+bS8
	o9p3JhA9SXUVk8FixQln/CNlA/xdfVXTVFsHEL5IhpwKoSrpAJf20OHHby7C4h2S7H2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8sC-006AKQ-Kc; Fri, 30 Aug 2024 23:09:36 +0200
Date: Fri, 30 Aug 2024 23:09:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 6/7] net: ethernet: fs_enet: simplify clock
 handling with devm accessors
Message-ID: <ab8fb701-c91b-4e66-8dac-fe74e3ee0ca1@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-7-maxime.chevallier@bootlin.com>

On Thu, Aug 29, 2024 at 06:15:29PM +0200, Maxime Chevallier wrote:
> devm_clock_get_enabled() can be used to simplify clock handling for the
> PER register clock.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

