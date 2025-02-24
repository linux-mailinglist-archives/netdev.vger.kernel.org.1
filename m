Return-Path: <netdev+bounces-169017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B8CA420A4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9E17A2B23
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBB23BCE8;
	Mon, 24 Feb 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xlxUzMBl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBE1DACA1;
	Mon, 24 Feb 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403913; cv=none; b=AmD8BiGFEdcQ2/kpukRvV3iIDORbgf660l8YD1UzqFmvVxxSZqHwcyvEOzOUoXRd5PxgSQRyKzoujesBjO64sLzaDVTnFlfKFRNL8QoanqNqFXWVt5teFyOE8u8rR8rMehnnbTlSe9fZSbNvHGcwDZ5R0YcIALVfUKnUcTPKrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403913; c=relaxed/simple;
	bh=N7H3lcseBwrt2LpQoJb1h1KpVqI7UGXZ/rgcJ04vhZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfbIIo3TvttM6gNEVim8USAFIkz9Nk9alyY6efuiSSMOOjiOqlnEfT+SVdfSgL+eqE4ILY6Sw8XjkleWAmJLUbHSKKTrDJTr8v4IIlmiI9UFvietz1ZdfQQb3y/XdrGoY8lhkP5XNDAzzHz+eDc5PuBfJlf28qgnu9pGjBD/+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xlxUzMBl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3UjwgQbSq/Gm2Q1/ZS3x1PVVVlPqGioobTaKF3okpsk=; b=xlxUzMBll/3CDSt/Xozd/5RN+M
	qqDxZcCgljY8cM6UJ3qcigv2eXTqXtY/D6LIsYBP7IfUB6RDrbMOrR9zWZpOU25IQ6PyKOXUuUW7X
	eHahzsVG5z0g1aUNsHsdhbsZUASOp8264r/wayMtoXx0OPYSRwk4co1ENUGdY9CwNecM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmYYh-00HAYs-0X; Mon, 24 Feb 2025 14:31:43 +0100
Date: Mon, 24 Feb 2025 14:31:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikozu86l.fsf@miraculix.mork.no>

> What do you think will be the effect of such a warning?  Who is the
> target audience?

It will act as a disclaimer. The kernel is doing its best with broken
hardware, but don't blame the kernel when it does not work
correctly....

> You can obviously add it, and I don't really care.  But I believe the
> result will be an endless stream of end users worrying about this scary
> warning and wanting to know what they can do about it.  What will be
> your answer?

I agree that the wording needs to be though about. Maybe something
like:

This hardware is broken by design, and there is nothing the kernel, or
the community can do about it. The kernel will try its best, but some
standard SFP features are disabled, and the features which are
implemented may not work correctly because of the design errors. Use
with caution, and don't blame the kernel when it all goes horribly
wrong.

	Andrew

