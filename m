Return-Path: <netdev+bounces-155926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FCA045EA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D21882BCA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801101E0E00;
	Tue,  7 Jan 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w0tGPoVP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF741D8A16;
	Tue,  7 Jan 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266978; cv=none; b=SkGUhSuOuKHQmqeKwR0qr5Ik3DWbgyiJWyPBizOhUKIQ4J8Sox0uDVloey39cN9kOQIhwpW15KBJhHhmU79s9rOnZVdYGTIy7g2Sn/bn0XGl/FjY5f0BDUv8zET7jgsJ3Vyqd5o/1PA0OKkoWztgsTRjShGguXMU+SERL+jv1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266978; c=relaxed/simple;
	bh=upFMXhvCgcIcthR6rb9m6dyv+il0TE1oSMQE57Q2gVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA9+9uTRb5+Ekx51DnTkXKuiaLBdCpQ8HKNmpnUd2l3VoLMftwRB5gt+dXadVgZWmN8zSHg5Oij8Uky6QNll9YEUB11055Wi5S1QmLcAzquJaH++3qMiw+/xLskZg4IK49K5byGIFd0qHlmZgMwgOsEohzYnEH4PSPFY92e8aFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w0tGPoVP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=agNC8oF9rUXSC9YbiyboPCaucWw3KQBsHEsPHpHMHUk=; b=w0tGPoVPuCFhfdKT9EhePXNdrJ
	6jg0NeIr0AUvVSvAQgz6RgYSMfSxiav2wf1dQcn7Pvg6mulrK5TeyeZb6QwWc7qgTohB0O1VlXn0D
	2p/O2XFLE7LMSp6+glS+sgUWj2LcyBQLUvEQPYKiwsR2+g0rQ16MT89SVZwSZFbFAwaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVCLz-002HvG-1C; Tue, 07 Jan 2025 17:22:51 +0100
Date: Tue, 7 Jan 2025 17:22:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <601067b3-2f8a-4080-9141-84a069db276e@lunn.ch>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
 <20250107171507.06908d71@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107171507.06908d71@fedora.home>

>   I have however seen devices that have a 1G PHY connected to a RJ45
> port with 2 lanes only, thus limiting the max achievable speed to 100M.
> Here, we would explicietly describe the port has having 2 lanes. 

Some PHYs would handle this via downshift, detecting that some pairs
are broken, and then dropping down to 100M on their own. So it is not
always necessary to have a board property, at least not for data.

I've no idea how this affects power transfer. Can the link partners
detect which pairs are actually wired?

       Andrew

