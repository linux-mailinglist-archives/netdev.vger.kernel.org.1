Return-Path: <netdev+bounces-229541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F46BDDDAD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACA63BDAA2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF831BC90;
	Wed, 15 Oct 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sWas1ByB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8F1A23B9;
	Wed, 15 Oct 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521718; cv=none; b=EwkhiHbtdkVP2OTCGi+C53YlG2YxLnb+aeyPo2dBNwjMrekGmvALB+GoqDSBSB6CNocVKZjSL8XgLTBF/ln/CA9eZmDrbmHKFbMDP1t/MTKPXJxqycmrvfT6JomBVJa+7vp+nWeIj3pVBYlc1ZAtskyJpfyCmspL09V+bqf9D0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521718; c=relaxed/simple;
	bh=NFGnU8x9lnrS2wxj8pS1t+Oz6cPjut0jLD7+R+/8HxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJZc502uLzUKEsQD4Sd7tUcpoVAUM8M8Kgqiiv2IShVJedHDHW31vV+o2z/aHboKmPkTtGRLpAH6oI/ZSxPvlayoTHw3OFllvF7E1fYz0FBm5gUVk8HKQff3UIJJCTKt+j5gWVZJQOVNG0wQUsDeiKUiqyK8FDKdgNUryRYkBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sWas1ByB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nms/uf1fDtw2HCTch0VpFbmftAd//60CvgRED5bBFXg=; b=sWas1ByBD3WT0lWsd7v10GP4+M
	wXa7if2yM4Nyg40a0ELo2/k/RnN3N9/aP5PKmIZjs6yjLFRkz382IqB5nHGi9Vk0Ypd+GM5/y1w8w
	n6y0O6wqnLI1abtit5W3odZzuc1dyPZF+9oj+o1fHUVmgPp39Afajrj6L7/xIrlbHiclykI2Jw9Af
	xspa9jmxzTAHFtj7LYc98xqGvPPUQGdCfxoC28NjgM6q40VV+3WYKNAHufo5jR4k134PnY47DrY9D
	VYwmbFY2PXoO7B4Emv+sW2cagxu/DAHaFgf72U3cvizEkITvN2eDMPsdQ3v+YiYERZd8dzraiPyY2
	qb/KpAMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57256)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v8y7M-000000004KT-3ori;
	Wed, 15 Oct 2025 10:48:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v8y7J-000000002Aa-3qzR;
	Wed, 15 Oct 2025 10:48:21 +0100
Date: Wed, 15 Oct 2025 10:48:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <aO9t5TWNDpIe3q9g@shell.armlinux.org.uk>
References: <20251013135557.62949-1-buday.csaba@prolan.hu>
 <20251013135557.62949-2-buday.csaba@prolan.hu>
 <e4dbb9e0-4447-485a-8b64-911c6a3d0a29@bootlin.com>
 <aO9kN_UgU6RpOYn2@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO9kN_UgU6RpOYn2@debianbuilder>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 11:07:03AM +0200, Buday Csaba wrote:
> On Mon, Oct 13, 2025 at 04:31:10PM +0200, Maxime Chevallier wrote:
> > Hi,
> > 
> > On 13/10/2025 15:55, Buday Csaba wrote:
> > > When the ID of an ethernet PHY is not provided by the 'compatible'
> > > string in the device tree, its actual ID is read via the MDIO bus.
> > > For some PHYs this could be unsafe, since a hard reset may be
> > > necessary to safely access the MDIO registers.
> > > This patch makes it possible to hard-reset an ethernet PHY before
> > > attempting to read the ID, via a new device tree property, called:
> > > `reset-phy-before-probe`.
> > > 
> > > There were previous attempts to implement such functionality, I
> > > tried to collect a few of these (see links).
> > > 
> > > Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
> > > Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
> > > Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
> > > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > 
> > This should probably be accompanied by a DT binding update,
> > with some justification that this is indeed HW description
> > and not OS confguration.
> > 
> 
> I have the corresponding patch ready, I just wanted this to be accepted
> first. My description was to be:

Please see Documentation/devicetree/bindings/submitting-patches.rst
point 5.

Basically, don't submit code that introduces a new undocumented DT
property without also including the binding update in the patch set.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

