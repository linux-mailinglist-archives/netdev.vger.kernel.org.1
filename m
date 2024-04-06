Return-Path: <netdev+bounces-85437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D768289ABF2
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847E81F217BF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A143BBF4;
	Sat,  6 Apr 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KuLAShsa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0E38396;
	Sat,  6 Apr 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420055; cv=none; b=W1jfc+/0YLiWkHTsv1t5Y/cFWYmO5SAueWPqLnIVub5X+O5Qkonk4g2ldtZlrgbILoBsXyukoQWzFCpmv1FoB986DiuwYJZ/FECP/PX1QHmPtMSNnUYUK99q1eaOmjSfsQxHoSKrkGsse3Zx1OVDZXDKRIzF3tTj84/EZ28xvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420055; c=relaxed/simple;
	bh=ZlEmRPoAfWYYr0CJ+9eeyIeoPG7qNC9qINFRuFN4SpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRmqQs+QZ4YXEmamoVhQoRXf1kH2waXH1Rh71MC1sL3dg/GV4MeZ42J44HW23WRFweo9MrxGLo7tfL/XxM+j1sEOKG8ZLi5oumkY5UPGz/NiHYHVTvV32ZqtuZMG5tq5QRAe96pGt3kR53WvISusfxLLE1TJPsLR6Wi2AjvdE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KuLAShsa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2OVtX+5WKn0At0QBYPFlNgJmZou+DvFnhRzz5T7jCKQ=; b=KuLAShsaKELYuK+CaYP52iOB9W
	QtsI2qfO9y6RWpFMyx3qownZbB1xcb+kk0tNHkwPuauACxtuQMzu4G4cPXD96SzQYBr6c9rg+vRVb
	bi7uGe6NrdvqIddV84CVcGNFloeqHOWUwmQpu2HINzDVFCGIE6UFV/KRjeUxie2Uw1bc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8gF-00CNfP-2X; Sat, 06 Apr 2024 18:14:11 +0200
Date: Sat, 6 Apr 2024 18:14:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 08/13] netlink: specs: add ethnl PHY_GET
 command set
Message-ID: <d3df9d5e-4d97-44b1-b03c-98369294ccec@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-9-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:29:58AM +0200, Maxime Chevallier wrote:
> The PHY_GET command, supporting both DUMP and GET operations, is used to
> retrieve the list of PHYs connected to a netdevice, and get topology
> information to know where exactly it sits on the physical link.
> 
> Add the netlink specs corresponding to that command.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

This i don't feel qualified to review this, other than i don't see any
obvious spelling mistakes etc.

Is there a tool to sanity check/validate these spec files? If so,
could it be added to NIPA? Added to Simon's list of checks?

	Andrew

