Return-Path: <netdev+bounces-105883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3A9135CC
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32911B2265E
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694138FB9;
	Sat, 22 Jun 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="25zCCAoi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D926AF0;
	Sat, 22 Jun 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719083558; cv=none; b=M4Eo0uw9VM/ZU8bYfSISrU5mRMMcFJKGPD7OL1bpfbpwDJ2AJa5asXD+tDe6TGmpoeHKgUVRsZlN/2HeEGqARS8ZvbeRS71M4eeuN7eAxyEEWTXcLItQWM2k1Ck+/AKbfCaNbPyP4G5aammtV5AR1TkLghyiU1LdXS8nid5JZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719083558; c=relaxed/simple;
	bh=vh2JKpWH7dyPXeXv/cvX+1DJemvZtcmkvOgLcFIOik8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smrdj8UeQRS41TNxAdVz8UxD6RiveLMctbTkusZr5cx76VYoHMZWzgTp4h9lBO9YJSzzPz4Z8KmXI33AMrj8Dhgws9J/JMHhcp99LVqaPpX8ufzPke4ox+Y2rFn0hV3cSUAvzWJG1YP/bYN/7IA04tR4ZcdIdwInsw8iyeeNKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=25zCCAoi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9M2T5n/TTpRlSib4sQ6QSIHATO0zpnGPeFOWZW/omFM=; b=25
	zCCAoitrNvc6EPlxrZOj2ZOMRBY49RdgsSyN/lvJfblfW4DKbNmTqeS3Pf8SuXSft02p2F5EtU2vJ
	XyfzxaF21C9jxl/CQnkX8dcwwzVc2dWNDaEdKZKnZTkEMo7/cirlJv5f/srrnbJBT6l1fY9H+KxQm
	9TiLgCMjHlixoqw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL69v-000kN9-9E; Sat, 22 Jun 2024 21:12:23 +0200
Date: Sat, 22 Jun 2024 21:12:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <5a77ba27-1a0e-4f29-bf94-04effb37eefb@lunn.ch>
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621112633.2802655-5-kamilh@axis.com>

On Fri, Jun 21, 2024 at 01:26:33PM +0200, Kamil Horák (2N) wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle
> configuration of these modes on compatible Broadcom PHYs.

What i've not seen anywhere is a link between BroadR-Reach and LRE.
Maybe you could explain the relationship here in the commit message?
And maybe also how LDS fits in.

> +int bcm_setup_master_slave(struct phy_device *phydev)

This is missing the lre in the name.

> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	int i, val, err;
> +	u8 brr_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
> +		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);

I think that needs a comment since it is not clear what is going on
here. What set these bits in supported?

> +
> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
> +	if (err)
> +		return err;
> +
> +	if (brr_mode) {

I would expect the DT property to be here somewhere. If the DT
property is present, set phydev->supported to only the BRR modes,
otherwise set it to the standard baseT modes. That should then allow
the core to do most of the validation. This is based on my
understanding the coupling hardware makes the two modes mutually
exclusive?

> +	/* With BCM54811, BroadR-Reach implies no autoneg */
> +	if (brr)
> +		phydev->autoneg = 0;

So long as phydev->supported does not indicate autoneg, this should
not happen.

	Andrew

