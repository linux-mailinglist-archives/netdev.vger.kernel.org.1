Return-Path: <netdev+bounces-119420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE49558BC
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59CFB212FF
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CA6143722;
	Sat, 17 Aug 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OIPVVrEu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845798F40;
	Sat, 17 Aug 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909442; cv=none; b=jLcAdzVTB6Hl6b7nzf37rkKbbvQawdW3ovbRVX7mek638OzhEjksOfaqBr3WCGh7kSvk7snfKB8r3htIa3gdNIF5BUysV3LW3IJKG2vFgEvVweUckDhkTOGpSv1twI9M7q40gJMgVhECPR5Cf2xNRooIDJVgEjk3WVL2kNjVI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909442; c=relaxed/simple;
	bh=AuEPHjhKbn2q33Buw3XS280g05WEnlJRnwqcblu7zqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptLpDqLBNlSz5LVflO1Mz+vwIcbvYY4At2eL9j1Qk57S8cIxwZgwQ/TFItE+dJHYH/6ob0QCbwqJ+Q2BZYz5dFAxFqft9Z6NPyXd58RK4DUGIzRgeo/lbZycvq3unkUM3DvjcN7Hoz1r8D30vE0BGM6mnoW//ie9zg6V/KV6ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OIPVVrEu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dZ7hDF8ZFhxES3FISLEF805f4jx/zxEu+KESQA8do3Y=; b=OIPVVrEuWsHSOez/n+G5b2Cwwk
	DNC8hkRh7w8wNBzhikvEKtuKEpi7JfOCkn+Bk4pa3AwFXOXUfgpSwCn/I46aMuKCbbUHx/gFdGiw0
	Zprkaj5T01Bjx/rtUVtk4b1iW5NJk1DvcwEPOiadKNyEc/BOPtUUyJtEBMJFV2WGa03w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfLaq-0050Ii-5s; Sat, 17 Aug 2024 17:43:52 +0200
Date: Sat, 17 Aug 2024 17:43:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <6b84cdf2-34c8-4e61-857e-79a1d5e782da@lunn.ch>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240715083106.479093a6@kernel.org>
 <20240716101626.3d54a95d@fedora-2.home>
 <20240717082658.247939de@kernel.org>
 <a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>

> Jakub, as you say it looks solid. I can add to that that I have been using
> this series widely through the double Ethernet attachment on several boards
> and it works well, it is stable and more performant than the dirty home-made
> solution we had on v4.14.

Have you posted a Tested-by:

You can also post Reviewed-by: if you have taken a look at the
code. It won't have the same value as one from Rusell, but it does add
some degree of warm fuzzy feeling this code is O.K, and it starts
building your reputation as a reviewer.

	Andrew

