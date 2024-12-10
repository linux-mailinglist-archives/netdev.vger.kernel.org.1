Return-Path: <netdev+bounces-150677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE0F9EB297
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD9188D65B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D201AB523;
	Tue, 10 Dec 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O+Uuf9XX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AB1AA1D4;
	Tue, 10 Dec 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839352; cv=none; b=YJItdpsD2Tomvzi8a/J85gnUf2JGDJeLHDOcBFXkZ4BdYJChPoUDLZOADg0EXLK1GEfWD/SKd9hh9lgr868GfCCZIAIdGWYaZA7U5wrOPr/VOwyXYYg4PCO2/kqrpdd7a8Tib3iDtyCnMSppI1lA/TnXH5tSGgYX+u62H1QhZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839352; c=relaxed/simple;
	bh=okogMpjxbultBuWEIKWmSjFy9gsNll/FG9p0uJzgv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEpiBhiGP/PBkgn07149CBDKl9i6UNxyY1itquE0Ekuojcg0CSaNOojPDywFyFIQT2Dx8gH61siEzpuSN9RlksSUYxYBBj+D1arUp1nhibZ+NPn77wBWHH+WkUopu3mJxLQN5LeYmFePQ302Yh3/iOYSY6aqHXjR3JdYEPSzGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O+Uuf9XX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L0il2+dIsaUdgxtsmaC+6DEd7B+BchXAnUOcw3KtR4E=; b=O+Uuf9XX+7G6fFnNUPYwsOLeGr
	AcbVO76OT/0Pgd4qd9P/0zICKGrknKGsVTwHlyn2HbT6hNZz07JA89qwymBarUjpyFP+hA+fIrGu6
	dfJv94RcEX/9yFhVsbhuMW6CudBUvTxkoXVK6bPEbaqgrhesXt4CePOdWcQUwC1+NDF3z0hJRH+ul
	6curpHKhwp+ZiqBqF6syA6AdjKR3NfEbFsVk2Og5z4VHCP4YTEZ4IqTnse/snQP9EOT+hVGvPUnDW
	/E/1VbbQ/Q7Y8ZvAUGlfN94OUttIJeQaoZ1xEHNlb52Fiswk5YyzFOgt78RkVO/RNFyBqP3ozndTh
	JWEmH7NQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tL0oY-0002Qb-0v;
	Tue, 10 Dec 2024 14:02:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tL0oU-00030f-03;
	Tue, 10 Dec 2024 14:02:10 +0000
Date: Tue, 10 Dec 2024 14:02:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
 <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 12:56:07PM +0100, Paolo Abeni wrote:
> On 12/6/24 12:39, Oleksij Rempel wrote:
> > +#if 0 /* For kernel-doc purposes only. */
> > +
> > +/**
> > + * soft_reset - Issue a PHY software reset.
> > + * @phydev: The PHY device to reset.
> > + *
> > + * Returns 0 on success or a negative error code on failure.
> 
> KDoc is not happy about the lack of ':' after 'Returns':
> 
> include/linux/phy.h:1099: warning: No description found for return value
> of 'soft_reset'

We have a huge amount of kernel-doc comments that use "Returns" without
a colon. I've raised this with Jakub previously, and I think kernel-doc
folk were quite relaxed about the idea of allowing it if there's enough
demand.

I certainly can't help but write the "returns" statement in natural
English, rather than kernel-doc "Returns:" style as can be seen from
my recent patches that have been merged. "Returns" without a colon is
just way more natural when writing documentation.

IMHO, kernel-doc has made a wrong decision by requiring the colon.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

