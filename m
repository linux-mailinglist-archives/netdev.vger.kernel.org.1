Return-Path: <netdev+bounces-105899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98003913736
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 03:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239E8B22686
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C82C95;
	Sun, 23 Jun 2024 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EbJTqJW5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD8393;
	Sun, 23 Jun 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105691; cv=none; b=keJloX5e3XLWDWfA96132PIOj8hygK6wfO+18mln53KPiYUhmF+1ikFJP9hZHlYXbFiW1u/nGWhJmhhAXiJjk/ChrM0cKOluK9SF4ADcg9RvVR7Vad/UCcHbrvCII33ceI/4mvyIMvrEbrg8bPj5MjoWFCd2yzpwotWrOSY9hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105691; c=relaxed/simple;
	bh=AkiIWMG9fW+6ErSvmJ5PeWILr9+0kVYmudr+D+e2akE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovduBsQ3YkufTAW6UwwKzvylnkHVzaFxNVPUDT9dxy8mzGOpJV15A9iYARzgui2JTs2fqJVSiSZfTTDqms4ItfthOWunLPotQHKXkVsF0Y+R88ZDFn2eRDoxR7dg78/y4ggUxjFq8H2zdfLC8J4nk50H5gp25ofIjTK19V+JF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EbJTqJW5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A688A20002;
	Sun, 23 Jun 2024 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719105679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPaoqEeTpSx86CMKltblLZ3g74Ywhx8FS7aopirkn84=;
	b=EbJTqJW57oSOIYUtca2OpA6QEtF7xPc7grSo0iy5ZUrH+B2/uawpTZJdxXVQGuZviTyiXU
	0tpPf+10EPRZDi+0MfETrTnR6jV1utM8ACTbB5o49HvaRJbAq2JL2/byfr/TXqg3Q2PWdC
	B4PLbio6lwU+NPLCQ56bdJUxE7dXK7HhgKvjdld5TG2ejnd9BZEO9lkeuHEbyA7OMuyaIJ
	zzi39DjBvDUFg2MRG+UyxnWee2/qVp5ywgD9uyljj6NVlrfdBZS56a9KJC605Dzgr/6leZ
	a87O3vIDbq/xHYN++6ip+AHWLG0Eswd4l7x3fofdpxUrokct7sB2rkoQsqqWbg==
Date: Sun, 23 Jun 2024 03:21:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240623032106.3e854124@fedora>
In-Reply-To: <20240613182613.5a11fca5@kernel.org>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-6-maxime.chevallier@bootlin.com>
	<20240613182613.5a11fca5@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub, Andrew, Russell,

On Thu, 13 Jun 2024 18:26:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > +			struct nlattr *phy_id;
> > +
> > +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> > +			phydev = phy_link_topo_get_phy(dev,
> > +						       nla_get_u32(phy_id));  
> 
> Sorry for potentially repeating question (please put the answer in the
> commit message) - are phys guaranteed not to disappear, even if the
> netdev gets closed? this has no rtnl protection

After scratching my head maybe a bit too hard and re-reading the
replies from Andrew and Russell, I think there's indeed a problem. The
SFP case as described by Russell, from my understanding, leads me to
believe that the way PHY's are tracked by phy_link_topology is correct,
but that doesn't mean that what I try do to in this exact patch is
right.

After the phydev has been retrieved from the topology and stored in the
req_info, nothing guarantees that the PHY won't vanish between the
moment we get it here and the moment we use it in the ethnl command
handling (SFP removal being a good example, and probably(?) the only
problematic case).

A solution would be, as Russell says, to make sure we get the PHY and
do whatever we need to do with it with rtnl held. Fortunately that
shouldn't require significant rework of individual netlink commands
that use the phydev, as they already manipulate it while holding rtnl().

So, I'll ditch this idea of storing the phydev pointer in
the req_info, I'll just store the phy_index (if it was passed by user)
and grab the phy whenever we need to.

Let me know if you find some flaw in my analysis, and thanks for
spotting this.

Best regards,

Maxime

