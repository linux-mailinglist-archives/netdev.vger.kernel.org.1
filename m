Return-Path: <netdev+bounces-163976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47DA2C366
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EC5188C5EB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC301E105E;
	Fri,  7 Feb 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dkXz39eB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869779454;
	Fri,  7 Feb 2025 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934387; cv=none; b=WYSCJqacY3RsrS/GIWKmDYP85GMnNlbdzJ551SKcmFc7H2lUOeibdkEsSdFi195o4sOEjrNZHmFeLeVGHw4McWQV/peRr3W94sjwSV9gwgCOJe0HKYGkHKm6jdml63gsk7z3edmEFZ5qvhYnVtEFpKTRu6BF3p0TmJx0PEte1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934387; c=relaxed/simple;
	bh=jRrB2qmo7JrU98XWap5HuVTNK8sJMFUVIUhbRBVGh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1wSvA/oHF6zJnObv2h2qrdosNddahrzGxKDrlGgWlx/e48ifl29/JPMW2Ricur6U2P7KpCxaJhCludLbIQl9QPjue14+NiRXZ6A+6x7vac41mV6BDrGxz2dIyYP6djRK6UOUb+4wDgK4CdsqYYiBLzvbnLUUL1V1pxa75aeXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dkXz39eB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6IvWTedbFSZ2DZf9hRcDWc+nGLgLBJV4pd4iba6oTfA=; b=dkXz39eBc1Jhhf2RLEJnoSB5IC
	dyQlxKs8BCdsVI/ibsWTME3NpJoftbO7Y82uL4umSlJq8yaO3Scd+XcjCxvmMGu2sVgcu21gNc/ZN
	F4TIPUKFCP6aFNW/IaHnKHhDS0XUNU0FCKcdsgipYs15Dyo11z8KVrRr173WmH54XuGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tgOGZ-00Bqmp-R0; Fri, 07 Feb 2025 14:19:31 +0100
Date: Fri, 7 Feb 2025 14:19:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Byungho An <bh74.an@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: sxgbe: rework EEE handling based on
 PHY negotiation
Message-ID: <0d3ba7a5-0e24-4cb5-be52-74a7096a11eb@lunn.ch>
References: <20250207105610.1875327-1-o.rempel@pengutronix.de>
 <Z6X0WsUaRw-P-QVt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6X0WsUaRw-P-QVt@shell.armlinux.org.uk>

> ... and given this, I ask again: should there be a generic
> software-timer EEE implementation so we're not having to patch multiple
> drivers for the same bug(s).

Probably there should be. But given how little resources we have, i'm
not sure it will ever get done.

Is there anything special in the stmmac code? Workarounds for stmmac
peculiarities? Could it be pulled out? Given you have looked at it,
and fixed it up, it seems like the obvious candidate for code
donation.

Maybe we need to ask the next developer who submits a MAC driver with
a software-timer EEE implementation to build the library?

	Andrew

