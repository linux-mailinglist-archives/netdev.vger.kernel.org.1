Return-Path: <netdev+bounces-169036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C23A42301
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016023A83E5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD578F2D;
	Mon, 24 Feb 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x2U1bWuj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB50F9F8;
	Mon, 24 Feb 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406717; cv=none; b=D0dtBk91R7kclFBBJ0ZBMP19FTaQ5rpFV24zoh2ZMFyX+GGOaNKh/7ewK1NUXY9p+TiD0GW6euiVD6wdYpJRxedQaDQHuua1iqmPpYVegptDmHDkR8leL8VvEbm2N+kVT57n1PprprCWFhuucSC4afYSAuhVAJtDjlbxBGOhiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406717; c=relaxed/simple;
	bh=TZMvKoS23Bgd5fkbnhBSdwZISP6VFkX5FvuY4M0tonw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blYwaHLN0bxdGq7U3Pisom4W1j7078cIfFJR1dImVkRm5jEzPTZ+5aNESg+kGxAR4oh20+Rd4H0csYiRgqWrVaqPV0E4KzNKAYGbGrR99koANv5j1eVIC23c5t/4vRxQdCAhuXva9E+u242+5fXtYLhtQF6aUY+HjtcIs2Y3em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x2U1bWuj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sTRzsTWPEY8VAwBUDsx7WMrpBUI6EPw7F0vhHruQ4JM=; b=x2U1bWujqzxGD/usFeNweAq4t/
	BfB4tOjCbb8xgL8w1ImFFTF0nsiyexTiqudFpNLk29U18MS6jCqMMXgJgURc88iGhxfyTlKeeYN6z
	ogh48TZZojVPUlr4d77SfkYna3rzjMEWb/P15RIu9f+xDRa7JWHhwnPWoRh0wqYfWKxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmZHw-00HBSe-AF; Mon, 24 Feb 2025 15:18:28 +0100
Date: Mon, 24 Feb 2025 15:18:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
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
Message-ID: <50494dd0-6d0c-4eac-adac-cac9b6e224f6@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
 <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
 <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>

> "Please note:
> This hardware is broken by design. There is nothing that the kernel or
> community can do to fix it. The kernel will try best efforts, but some
> features are disabled, other features may be unreliable or sporadically
> fail. Use with caution. Please verify any problems on hardware that
> supports multi-byte I2C transactions."

I'm good with that.

	Andrew

