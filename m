Return-Path: <netdev+bounces-247096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3ECF479D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25763305CABE
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581633D6FE;
	Mon,  5 Jan 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vC00onSp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB611494A8;
	Mon,  5 Jan 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627661; cv=none; b=UxNTQvXmoCTyMoVe2w65Dii9NnQ9GTLDMymoCpAzk53Q8PjXI8qhDMfOyLVNgbbmeJBYKXtaVr83YkLkuOnLKpYyON0mccsctC4ASc2s5JnpAkI6TwLVeG9houMOgKxKHzx+hHUVD3uXEEKo13r1e5kFFClvKFqgMpT6pes6ZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627661; c=relaxed/simple;
	bh=qxEPNcPyoPE7cO+7Mc1UhrG9sWlmf1lDBHfKXDZcN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuYtwoeLEAZFTT/BJ3D4YKjGvdxWr8JJjrnlhp0K1EnDoi1rv42eS7vssB2WAJcm328zG3WcQMTE5zekfuruU7AEPiEEPrxsYXrkrC516+G/9TYH89xZKv1i3BhUQY8/E+k8F/lGmGVK8g1uzkkaTmXEHPvCNqu4UDDiblP448s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vC00onSp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wgcj7sxBXVa2NjV+9IsdVBE6EHA3Giu1FnJKtsFPXLU=; b=vC00onSp+UsgeuZOLoJshrE+6l
	3VvjhykC8zhsvTtSByXsVCWhh00Xke+DeDb5+wnj7rp+xevMacfXSxLkWVtL9AyiUW+jA7Lh1m+Gf
	QKvSedaYTnLkLKrsLjtTN1W4TV2uKveTuZxetqHPDL/t//4WxujcOn4PfdMYthgykyXU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcmhQ-001VEL-1L; Mon, 05 Jan 2026 16:40:52 +0100
Date: Mon, 5 Jan 2026 16:40:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net] net: sfp: return the number of written bytes for
 smbus single byte access
Message-ID: <040995f9-5df2-4f5f-92c4-bedb8d1cd557@lunn.ch>
References: <20260105151840.144552-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105151840.144552-1-maxime.chevallier@bootlin.com>

On Mon, Jan 05, 2026 at 04:18:39PM +0100, Maxime Chevallier wrote:
> We expect the SFP write accessors to return the number of written bytes.
> We fail to do so for single-byte smbus accesses, which may cause errors
> when setting a module's high-power state and for some cotsworks modules.
> 
> Let's return the amount of written bytes, as expected.
> 
> Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

