Return-Path: <netdev+bounces-124541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D79969EC2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960231F21D4E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013F1A7241;
	Tue,  3 Sep 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R5kT24XS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953B1CA6B5;
	Tue,  3 Sep 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369150; cv=none; b=A3wj7zikJ/n1xgPO6WSOo4FPL6pBUzwsM8LCcPZ0mwp9sLd/WrlJfI7e7eLrCjtj6CfPLVr/IbCnCLh1gVs8T1zT0m3Sr+wG09SXRgjLZCuNYtnt1dPMAQPUoMA2YVwcJS4oQ829Ue2uMo49wGYSLATAqq/0Ky/xs3UUUpI4smk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369150; c=relaxed/simple;
	bh=cEUEgUfK2VJKwSdXTwN56m3l5tttmANwIWAPrH3n0F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3LXeQG0G8QnbfoD1wt6uWLEHjvO5j3dKWDWlD/ptvEXhw0KqcXg4AXZLmDBsJ9hnZOJI43oOyCTeUGPPxPiyGiK20xTJ8DYrghA58lu9IVjYuOhFecVtPxjvOT7G1ViAyn7mnMD5dQh/OSLYmmbZ0cg7vjZHanSQivhjoZcDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R5kT24XS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iuEYWyd+FkBmHpEwRM4wRGxRSybUGjHcHitebzsyO4Y=; b=R5kT24XS1hNQLKAnN8rrJQxjJy
	2uus18smDr03HNh29fOC7YfQp/VduL8+SvxY8BzMcCxuu4sMw8piNjpUGdi5+BsfLHApa1Nwm/On9
	ujW2y4jJui+KsWTmw+PF3rhw/PR/eUM/otRlTFEqRpBLP3F/wOwG5DFrChlLb0IVXSLg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slTKS-006QdE-2o; Tue, 03 Sep 2024 15:12:16 +0200
Date: Tue, 3 Sep 2024 15:12:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Message-ID: <bc68a8c5-b3d7-4b87-a192-ba825bfafb50@lunn.ch>
References: <20240902063352.400251-1-wei.fang@nxp.com>
 <8bd356c9-1cf4-4e79-81ba-582c270982e8@lunn.ch>
 <PAXPR04MB85100D0AEC1F73214B2087CB88932@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85100D0AEC1F73214B2087CB88932@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Tue, Sep 03, 2024 at 02:17:04AM +0000, Wei Fang wrote:
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ethernet-phy-id0180.dc40
> > > +      - ethernet-phy-id0180.dd00
> > > +      - ethernet-phy-id0180.dc80
> > > +      - ethernet-phy-id001b.b010
> > > +      - ethernet-phy-id001b.b031
> > 
> > This shows the issues with using a compatible. The driver has:
> > 
> > #define PHY_ID_TJA_1120                 0x001BB031
> > 
> >                 PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
> > 
> > which means the lowest nibble is ignored. The driver will quite happy also probe
> > for hardware using 001b.b030, 001b.b032, 001b.b033, ... 001b.b03f
> > 
> > Given you are inside NXP, do any of these exist? Was 001b.b030 too broken it
> > never left the QA lab? Are there any hardware issues which might result in a
> > new silicon stepping?
> 
> Yes, some of the revisions do exist, but the driver should be compatible with
> these different revisions.
> 
> For 001b.b030, I don't think it is broken, based on the latest data sheet of
> TJA1120 (Rev 0.6 26 January 2023), the PHY ID is 001b.b030. I don't know
> why it is defined as 001b.b031 in the driver, it may be a typo.

More likely, the board Radu Pirea has does have a device with this ID.

> > 
> > Does ethernet-phy-id0180.dc41 exist? etc.
> I think other TJA PHYs should also have different revisions.
> 
> Because the driver ignores the lowest nibble of the PHY ID, I think it is fine to
> define the lowest nibble of the PHY ID in these compatible strings as 0, and
> there is no need to list all revisions. And I don't know which revisions exist,
> because I haven't found or have no permission to download some PHY data
> sheets. I think what I can do is to modify "ethernet-phy-id001b.b031" to
> "ethernet-phy-id001b.b030".

You have to be careful here. Stating a compatible forces the PHY
ID. So if the compatible is "ethernet-phy-id001b.b031", but the board
actually has a "ethernet-phy-id001b.b030". phydev->phy_id is going to
be set to 0x001bb031. Any behaviour in the driver which look at that
revision nibble is then going to be wrong.

Maybe, now, today, that does not matter, because the driver never
looks at the revision. But it does mean developers might put the wrong
compatible in DT. And then when you do need to add code looking at the
revision, it does not always work, because there are some boards with
the wrong compatible in DT.

Listing all possible compatibles suggests to developers they need to
be careful and use the correct value. Or add a comment in the DT
bindings that not using a compatible is probably safer.

	Andrew


