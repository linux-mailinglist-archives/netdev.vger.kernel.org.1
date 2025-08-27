Return-Path: <netdev+bounces-217220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1FB37CFD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251957A33EF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A232255B;
	Wed, 27 Aug 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b9FHjbL2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE132145D;
	Wed, 27 Aug 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282120; cv=none; b=Jbp34JbruKXhE3qht1/2bUiEBxa54NnlDC0ig3hLIWBJVs9lfe1YMYYsVHaomt0WG+ATB0FJcTz74NwAWZnRyVVFBuekor04GhdY4wfJjzShScsLCSXZfXAMS0Z7Y7MxkT0Oi7WgYefzkUdU+4DmPjcoGmGfEwbbf2lZErYb/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282120; c=relaxed/simple;
	bh=lsJDDxdY1N4gALbPCmycovRhFfEL8Y0hbTDgIyjV50k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8rMHs3rP9mQyRCUetjIxUVitAzLSMPJgVJwz9w7Qr+iXPl6l6VokDAYZZQqNJeMTMp0C3jyNdDyNaSUn8fIEM1FRSFoR5O1dA6ih08I8CVg0OKQpKdckoK9tb4q1LwrJbGf07FfR/sTKs5K6t0nyDaER08q0qI00bYR5k2abkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b9FHjbL2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CmS9SC4kc4d1Ykb5qagMWrsRP/ZqbzwfCcHKP8Zo8Nc=; b=b9FHjbL2D/NyUZbVGsNSGDOKvx
	byW+FtR+l+Yy5FZ7feS+2oSxWAaha8s355suFXT9WYCxdQHC/DJiMSH6LGnbEjSX4PPrWMjN9EvXT
	VtfXjnrfMh4DwyTfrTTVFjwBqdEAPNZJYPnLKXpTvCu0fgEGQ6CfirsaZSL2Nofjx/S2onXGVNoMP
	lNakSHx1AgMJgzSM4znClbha3NxOWBKu/GOUvs7dv1HcTjNlpRRt56VO/csC6J9Jcyu6ggt5XohKF
	QmzQ9yosw4LFHSLAj6WIph4lfBMLNLZXQushdLgkyIUJFcTuOobNHEw6wjjCLVW7YjzSErnBjl681
	X+C1ezDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urBCm-000000000Bm-2wEJ;
	Wed, 27 Aug 2025 09:08:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urBCi-00000000218-25TM;
	Wed, 27 Aug 2025 09:08:24 +0100
Date: Wed, 27 Aug 2025 09:08:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK68-Bp77-HiOAJk@shell.armlinux.org.uk>
References: <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 07:57:28AM +0200, Alexander Wilhelm wrote:
> Hi Vladimir,
> 
> One of our hardware engineers has looked into the issue with the 100M link and
> found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
> host side. For both 1G and 100M operation, it enables pause rate adaptation.
> However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
> 10x symbol replication instead.

This sounds like a misunderstanding, specifically:

"our MAC only applies rate adaptation for 1G links. For 100M, it uses
10x symbol replication instead."

It is the PHY that does rate adaption, so the MAC doesn't need to
support other speeds. Therefore, if the PHY is using a 2.5Gbps link
to the MAC with rate adaption for 100M, then the MAC needs to operate
at that 2.5Gbps speed.

You don't program the MAC differently depending on the media side
speed, unlike when rate adaption is not being used.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

