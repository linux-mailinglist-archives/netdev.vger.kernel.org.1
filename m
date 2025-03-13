Return-Path: <netdev+bounces-174753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A1A602D2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD12D3BED94
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272FB1F426C;
	Thu, 13 Mar 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FELOkDWy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583776F2F2;
	Thu, 13 Mar 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898447; cv=none; b=JvPR0hAVK4VHnxUW87yV4s+YaGguAa6hdHZQIaZuEpFamTbqWE3kr19LBqQ2Gy/d4gCUJssoOfMH3GV02sAkIX0vZTRJtufvyHx0w2+J0wa61T1VuZM+j81y/FjAGDmovRS0ZQcGBZT91/iH/15YxbV4TH8IaN1InU2wEqHSVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898447; c=relaxed/simple;
	bh=UKF09hZbujuv4/nwID9bGnTQz9unLs7XP7f9Qo0EhYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGprSsIRUSpTFJJgpxBtNyb505SkqN+3SsNr9vD00UtFJhdtv5TiVQqy6LnoP48aZsO8QExfla1G2VfNWOn3JOp01TpKQvOAThJf3wH4vLATNlhUZUS9aLxuiNClr/EEWLA05pTrJEqWwMO49dgJf4p74FKM1Wxt3+fNd3qeXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FELOkDWy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3RF2WHNo1aasNoNcp5hUTGc/NdE/rBvS9KHkHJd4Tbw=; b=FELOkDWySR3lZkOkOW7/wfRt2Y
	djHCIoy8Akoy5Z1S0cLfWM4EdOh+XR9eveE/ZAN1+0iaqXNx+xKLhlld3OrOGvmEzY58PqsbYMIp8
	MJtm75Au81Cr+7u3z1jGGOO26w5qfukoqa5GzNusHL9BfmfBiwGeXAtPrNmur2GD1XyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tspLv-0056JO-H6; Thu, 13 Mar 2025 21:40:27 +0100
Date: Thu, 13 Mar 2025 21:40:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Message-ID: <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
 <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>

On Thu, Mar 13, 2025 at 08:37:18PM +0000, Chris Packham wrote:
> On 14/03/2025 09:35, Andrew Lunn wrote:
> > On Thu, Mar 13, 2025 at 07:54:39PM +0000, Chris Packham wrote:
> >> +cc netdev, lkml
> >>
> >> On 14/03/2025 01:34, Andrew Lunn wrote:
> >>>> +	/* Put the interfaces into C45 mode if required */
> >>>> +	glb_ctrl_mask = GENMASK(19, 16);
> >>>> +	for (i = 0; i < MAX_SMI_BUSSES; i++)
> >>>> +		if (priv->smi_bus_is_c45[i])
> >>>> +			glb_ctrl_val |= GLB_CTRL_INTF_SEL(i);
> >>>> +
> >>>> +	fwnode_for_each_child_node(node, child)
> >>>> +		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
> >>>> +			priv->smi_bus_is_c45[mdio_bus] = true;
> >>>> +
> >>> This needs more explanation. Some PHYs mix C22 and C45, e.g. the > 1G
> >>> speed support registers are in the C45 address space, but <= 1G is in
> >>> the C22 space. And 1G PHYs which support EEE need access to C45 space
> >>> for the EEE registers.
> >> Ah good point. The MDIO interfaces are either in GPHY (i.e. clause 22)
> >> or 10GPHY mode (i.e. clause 45). This does mean we can't support support
> >> both c45 and c22 on the same MDIO bus (whether that's one PHY that
> >> supports both or two different PHYs). I'll add a comment to that effect
> >> and I should probably only provide bus->read/write or
> >> bus->read_c45/write_c45 depending on the mode.
> > Is there more to it than this? Because why not just set the mode per
> > bus transaction?
> 
> It's a bus level setting at init time. You can't dynamically switch modes.

Why not? The bus is only every doing one transaction at a time, so why
not switch it per transaction?

	Andrew

