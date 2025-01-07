Return-Path: <netdev+bounces-155924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B375A045B1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018EB18852BE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999F1F03DB;
	Tue,  7 Jan 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4KbfYPHM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE401D8A16;
	Tue,  7 Jan 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266434; cv=none; b=TAXmHAypP5fFpHYy3soU8a7c3kcZRSwvWPYt4VUgCOFXtfRqENu1RvVvwvPaqkxHZq1WXJfg4kaUKCMpWaQbWfX6HEYe+hKUOPwvvv7vWknel+dinRteAa/WGcBnXFUlED/L7M1edCc+GIWQLDqBKU3wC73rk28dQujg+1Djz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266434; c=relaxed/simple;
	bh=7BySx3cG5Jb7WmpLpw7kbgTrJ4q3GPNYrmZz7wHOiJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkFY+eamkMyo1aaiNywre54BpNuQgUpdx10tOk1okzG9CglK1zgHdDeOdQkYcgrZj/+sc38APMznJpZW8wO/8CGJdVwiynUZXcuRa5QWdErps428vi8Yh7pGR84Y7weCEjHh5LNYSYZOPu9qFB/h/3jK63lzMZB2PXqRTPdBci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4KbfYPHM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PGtI1Byt9Pcn8gKN9HdLiOqUShOUvAUef3OSlC+uX9g=; b=4KbfYPHM9Lhi0tUQSaLF0UyLN3
	mp/Ts72StG/qKGze4Xgp6K5tkUylI//qhEeLjxCfxASWlXSvseWGQLMWsz+l8SZPqwKVafc+mzJ/W
	qXrnxhp6KLjdsUtoOxkc2a+azJmxaIZXGg+EI93pulOquGoILLNRbCuXnFgzbmlVhOqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVCD8-002Hks-6g; Tue, 07 Jan 2025 17:13:42 +0100
Date: Tue, 7 Jan 2025 17:13:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <1b2cb926-803f-4440-9c6c-54e3d7bdcf04@lunn.ch>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>

> What I think we both fear is having a complex DT description of a
> port that the kernel mostly ignores. While we can come out with the
> "but DT describes the hardware" claptrap, it's no good trying to
> describe the hardware in a firmware description unless there is some
> way to validate that the firmware description is correct - which
> means there must be something that depends on it in order to work.
> 
> If we describe stuff that doesn't get used, there's no way to know
> if it is actually correct. We then end up with a lot of buggy DT
> descriptions with properties that can't be relied upon to be
> correct, and that makes those properties utterly useless.

This is a real issue we have had in the past. A property which was
ignored, until it was not ignored, and then lots of boards broke
because they had the property wrong.

I would strongly recommend than any property you define is always
used, validated, and ideally will not work when wrong.

      Andrew

