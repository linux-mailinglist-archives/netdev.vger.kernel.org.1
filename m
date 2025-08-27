Return-Path: <netdev+bounces-217234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0DB37E86
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76971B64BC7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39695338F3D;
	Wed, 27 Aug 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RcjkirYZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A0274B41;
	Wed, 27 Aug 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286055; cv=none; b=E/Oe571pU4GxkXdK7DMu2FwCKxZpIdEGUrQJjYwgSicS46HlEZ5PzYH5rvWXLw6wLq6jRVTijemud8CXZXE4OK1gQU00HGTU3TpQD9UzW19i8QJsymktZ6Sxfh+2jx5nJQ+eMYWvnd9KH3Zno90erwLqsbhhiV/7iXmimFJIRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286055; c=relaxed/simple;
	bh=/yIf+mskkqkfN8f2LgY5oDpq+Ffb7eNyUGB/AAvVog4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxtIuZfZCwL/7GyZCFS7FWbnuf9V/qb7/to81Y8KAY7VoIJKrDgGAOTFpXoKkK48m5cAGhrFezzZHySo2hOEgqLq5GmgCQCSKmS2q+K9E3s3wrW5LfBSX5PB5QwyjTUwlXFNZ3CKjudy34K1EcMA8dR641qpIblv5Oerz1Ujtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RcjkirYZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8EDTmutXv6cpnKMhKY9aCrRhZQN/VIppbHjVD097H+Y=; b=RcjkirYZ4jlG0KuHggzlLh7fXY
	otW2retBA8Q5OAma3JuQet9AWItJwUwa9wRAod6SP3CZfKf8fGL9qAQZskXdyPD4xKJQ+3EG2eCie
	YXeqnSPyODYhfSbXGZu6zIb/RwLuhtCP3lEK1e2DyP/xYDTt4PjgfUuodBLQuefxwDbf76dJM/jzA
	MC3cm1GfSElU3HRGwp6HWlc0O8lI8PoY5Cd2if7J6Ajhj2vxZRwcf1Gsuxr9d5Fs8pt5cVWY2Xcn3
	M1RoPqfSOCtexQBur+wvKH2GPDYRJAxGd8k0b2cHS7fK/2sRzfBPr9RJDBS36KEbSgrainWf4guio
	fw+A7mtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34142)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urCEE-000000000H8-2VQc;
	Wed, 27 Aug 2025 10:14:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urCEB-0000000024b-1cng;
	Wed, 27 Aug 2025 10:13:59 +0100
Date: Wed, 27 Aug 2025 10:13:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
References: <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 11:03:42AM +0200, Alexander Wilhelm wrote:
> Am Wed, Aug 27, 2025 at 09:47:49AM +0100 schrieb Russell King (Oracle):
> > On Wed, Aug 27, 2025 at 10:41:11AM +0200, Alexander Wilhelm wrote:
> > > Set to 100M:
> > > 
> > >     fsl_dpaa_mac: [DEBUG] <memac_link_down> called
> > >     fsl_dpaa_mac: [DEBUG] <memac_link_up> called
> > >     fsl_dpaa_mac: [DEBUG] * mode: 0
> > >     fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
> > >     fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
> > >     fsl_dpaa_mac: [DEBUG] * speed: 2500
> > >     fsl_dpaa_mac: [DEBUG] * duplex: 1
> > >     fsl_dpaa_mac: [DEBUG] * tx_pause: 1
> > >     fsl_dpaa_mac: [DEBUG] * rx_pause: 1
> > 
> > So the PHY reported that it's using 2500base-X ("OCSGMII") for 100M,
> > which means 0x31b 3 LSBs are 4. Your hardware engineer appears to be
> > incorrect in his statement.
> 
> I asked the hardware engineer again. The point is that the MAC does not set
> SGMII for 100M. It still uses 2500base-x but with 10x paket repetition.

No one uses symbol repetition when in 2500base-x mode. Nothing supports
it. Every device datasheet I've read states clearly that symbol
repetition is unsupported when operating at 2.5Gbps.

Also think about what this means. If the link is operating at 2.5Gbps
with a 10x symbol repetition, that means the link would be passing
250Mbps. That's not compatible with _anything_.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

