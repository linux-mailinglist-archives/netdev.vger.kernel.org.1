Return-Path: <netdev+bounces-133634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C052D996945
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D72819DB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F91922EB;
	Wed,  9 Oct 2024 11:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD51922DA;
	Wed,  9 Oct 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474755; cv=none; b=e0yix4rDd+B7zbsJnB4HR0N2bs4qjg/gCDiKT9UqQEHz6PI/wa7a5T6T0DZN+DKtB3xQF6tX/ttQCfLAVfETRni0T5xpmo0/qbMVF3LX+zBX19s/x8EKQL0Juxu6UmknRPzYp6WbC0tp93PiuTU9tH3K5AFFfbQXiYALRlUs0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474755; c=relaxed/simple;
	bh=tOY/lPf/BdIO3Ajl6LWHJxWjxkAveQ94QJQbWdlBEe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0Wa4xOJJtNOqrtAKVHwvvHgb58hCk2Mcx0dgvH8ruLAHyBkrywMGv2BPwiEKBt/SD/QiwpjmOI08t8z4KGg6EOu8jPNRJD+njL03DWQnAyOgseGHxTl20j285sPVth+rxUwlqaZbpu2mG03w3jlm3ib8j3Z6ZCcag7uKGpOrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syVEt-0000000067Z-05Lf;
	Wed, 09 Oct 2024 11:52:23 +0000
Date: Wed, 9 Oct 2024 12:52:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwZubYpZ4JAhyavl@makrotopia.org>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>

Hi Russell,

On Wed, Oct 09, 2024 at 10:01:09AM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 02:57:03AM +0100, Daniel Golle wrote:
> > Use bitmask of interfaces supported by the MAC for the PHY to choose
> > from if the declared interface mode is among those using a single pair
> > of SerDes lanes.
> > This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
> > results in half-duplex being supported in case the MAC supports that.
> > Without this change, 2500Base-T PHYs will always operate in 2500Base-X
> > mode with rate-matching, which is not only wasteful in terms of energy
> > consumption, but also limits the supported interface modes to
> > full-duplex only.
> 
> We've had a similar patch before, and it's been NAK'd. The problem is
> that supplying the host_interfaces for built-in PHYs means that the
> hardware strapping for the PHY interface mode becomes useless, as does
> the DT property specifying it - and thus we may end up selecting a
> mode that both the MAC and PHY support, but the hardware design
> doesn't (e.g. signals aren't connected, signal speed to fast.)
> 
> For example, take a board designed to use RXAUI and the host supports
> 10GBASE-R. The first problem is, RXAUI is not listed in the SFP
> interface list because it's not usable over a SFP cage.

I thought about that, also boards configured for RGMII but both MAC
and PHY supporting SGMII or even 2500Base-X would be such a case.
In order to make sure we don't switch to link modes not supported
by the design I check if the interface mode configured in DT is
among those suitable for use with an SFP (ie. using a single pair
of SerDes lanes):
if (test_bit(pl->link_interface, phylink_sfp_interfaces))
	phy_interface_and(phy_dev->host_interfaces, phylink_sfp_interfaces,
			  pl->config->supported_interfaces);

Neither RXAUI nor RGMII modes are among phylink_sfp_interfaces, so
cases in which those modes are configured in DT are already excluded.

> So, the
> host_interfaces excludes that, and thus the PHY thinks that's not
> supported. It looks at the mask and sees only 10GBASE-R, and
> decides to use that instead with rate matching. The MAC doesn't have
> support for flow control, and thus can't use rate matching.
> 
> Not only have the electrical charateristics been violated by selecting
> a faster interface than the hardware was designed for, but we now have
> rate matching being used when it shouldn't be.

As we are also using using rate matching right now in cases when it
should not (and thereby inhibiting support for half-duplex modes), I
suppose the only good solution would be to allow a set of interface
modes in DT instead of only a single one.

Or, as that is the only really relevant case, we can be more strict
on the condition and additional modes to be added, ie. check if both
PHY and MAC support both 2500Base-X and SGMII, and only add SGMII
in case 2500Base-X is selected in DT.

I have never seen designs on which SGMII and 2500Base-X would both
be supported by the SoC but use a different set of pins. Also, as
2500Base-X is 2.5x as fast as SGMII, it's safe to assume that a
board which has been designed for 2500Base-X would also be fine
using SGMII.

Let me know of either of the above would be acceptable.

