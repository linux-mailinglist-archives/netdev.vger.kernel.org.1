Return-Path: <netdev+bounces-173616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC9A5A1FA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5211746A1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC95234972;
	Mon, 10 Mar 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pm1kQcd+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F72F28;
	Mon, 10 Mar 2025 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630529; cv=none; b=QNVDAu5pUbSwtPu9cu3mRWETUF89mz6FcSt6goRQn10eekKNuNk4UvpnLYa6ISYqPWSRYQ/r4CRFrUq8KJHWmDf6XVHY548FgxsoPF4u26OTHO5iBrWC6dnKSmMQqXdsHWIeCqkoaCgz+r8JtSCOjAKMU7a6nXvBoKKd8X0xNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630529; c=relaxed/simple;
	bh=NtQZmrdTZmr/X/usyvSixMuh+iNn2L06lDG7Eva3Dww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlxBjmcZUN5sNLdi0NT3jmcfmgZ8welyexHw5RutQ2OpH9r1O5owlcm/mJWWvMhBqMEiWuHQHXpqMIEZKlJEqfz9dktwlXjf89HTKrR4c+yFlllh6urqqmZWClXzo39NYnUS92cAV3d0lYJeJO6zfDMfaNElDjfpE8QTOqI3dsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pm1kQcd+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bMPNw2bGfnLnRunzTLGDt86VtF+X4dciD+kd2divlIU=; b=pm1kQcd+9mVXsgD23hVbtXY0Q5
	9WKbI+iQ8UuLDtslobXxf0T80c2f6mZlkyo2QxXR+qs98afpF0rrC9xPa08XUX0mqp+Moa5RliyU0
	olKDzOOheCeKsgswLp/zF3X9rX65KVw660cffciqyEI/dP9ceY6ir61X0E64efGdZz6dUFsajKnFs
	7YvuKKf/S96O361nAYNcW9dRwEq/WpDDpOwWUQ+4DiDL9lIvqQhDYPQlEt9Boa+BlMfQMtpshgQ4N
	v4Ky8P0q0XMNycrTixnzBQdlG3eO1+IHOIgDWtZIrQ+bNlggBkdf98Zj1UYhTFl+nR2ohKF1LXb5J
	Ao+6GqQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trhec-00033X-2E;
	Mon, 10 Mar 2025 18:15:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trheX-0002gs-0k;
	Mon, 10 Mar 2025 18:15:01 +0000
Date: Mon, 10 Mar 2025 18:15:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sander@svanheule.net,
	markus.stockhausen@gmx.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <Z88sJSzFTmYMvsZL@shell.armlinux.org.uk>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <3514933e-0fdd-4f1e-b1e4-b72a638edfc8@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3514933e-0fdd-4f1e-b1e4-b72a638edfc8@wanadoo.fr>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 07:06:13PM +0100, Christophe JAILLET wrote:
> > +		err = of_property_read_u32(phy_dn, "reg", &addr);
> > +		if (err)
> > +			return err;
> > +
> > +		bitmap_set(priv->valid_ports, pn, 1);
> 
> set_bit(pn, priv->valid_ports) ?

If you don't need it to be atomic, then please use __set_bit().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

