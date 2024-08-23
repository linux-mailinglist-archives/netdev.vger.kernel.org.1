Return-Path: <netdev+bounces-121204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4095C2CC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4271C220C0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60B1755C;
	Fri, 23 Aug 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jZfEICnS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0D18E3F;
	Fri, 23 Aug 2024 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376540; cv=none; b=VpPtkPoh7T4vyIZVDqw3b6BDXB4yQoH1QRD5v4qkhURx8XyZUCo3eTdHaLDZHoPosIVjcWiWpf8GKdVI4Za1HgfnVQ14qp39x82Xl+LUntHyhfM1uZNeHAZBGxg7btD8dzFBT03i1r5OT8LivWghQCGohS/OnGP0GPonSaOdmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376540; c=relaxed/simple;
	bh=0Cxc3iKYNDScIHAUvpIRZpSffqwLhiK5znIxktp6S4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob+7c749DjkLg0qZF/pWO1PRToKXhq7fP+SXNYTH8dVGhPOFKAkQ8RaMU16T54jwSQ28/qXwcaunMemOEtRfCuvi3O1RTNomPF2Vx0TgHss4UX72DHt9mACliH2enF+60oNPL0DxY5RQzP/tLlyvHp4riBPWlqn2XRIzsfVi5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jZfEICnS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p7dISyo9lY5Z89dZ4GJEbBQCoecv2wea0bN/8HHoo+Y=; b=jZfEICnS9nZb/DJ/FK1psCTIMg
	C549TQuquvan/e3LR1KwDFFIN0Ml4GTTSjP7QNfwXUIJAY9OY6391PZfpeMliWq+fhYaK8C6RQK0n
	YzJzxnwJk+QfpIvJZmupIfGTWO0A9mFPI33g8gWG7uniMNqWBpGVC2G5+lCXkJHBdxw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shJ6V-005U4s-Lj; Fri, 23 Aug 2024 03:28:39 +0200
Date: Fri, 23 Aug 2024 03:28:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <71391388-4c18-4239-b74d-807dfc48bbc5@lunn.ch>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
 <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
 <a59be297-1a55-4cce-a3e1-7568e3d4e66c@lunn.ch>
 <ZsYTZK4Ku2LoZ4SA@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYTZK4Ku2LoZ4SA@makrotopia.org>

On Wed, Aug 21, 2024 at 05:18:44PM +0100, Daniel Golle wrote:
> On Wed, Aug 21, 2024 at 06:07:06PM +0200, Andrew Lunn wrote:
> > On Wed, Aug 21, 2024 at 01:46:50PM +0100, Daniel Golle wrote:
> > > Normally, the MDI reversal configuration is taken from the MDI_CFG pin.
> > > However, some hardware designs require overriding the value configured
> > > by that bootstrap pin. The PHY allows doing that by setting a bit which
> > > allows ignoring the state of the MDI_CFG pin and configuring whether
> > > the order of MDI pairs should be normal (ABCD) or reverse (DCBA).
> > > 
> > > Introduce two boolean properties which allow forcing either normal or
> > > reverse order of the MDI pairs from DT.
> > 
> > How does this interact with ethtool -s eth42 [mdix auto|on|off]
> > 
> > In general, you want mdix auto, so the two ends figure out how the
> > cable is wired and so it just works.
> 
> It looks like Aquantia only supports swapping pair (1,2) with pair (3,6)
> like it used to be for MDI-X on 100MBit/s networks.
> 
> When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> come up with pair order is not configured correctly, either using MDI_CFG
> pin or using the "PMA Receive Reserved Vendor Provisioning 1" register.
> 
> And yes, I did verify that Auto MDI-X is enabled in the
> "Autonegotiation Reserved Vendor Provisioning 1" register.

Is it possible to read the strap configuration?  All DT needs to
indicate is that the strap is inverted.

	Andrew

