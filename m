Return-Path: <netdev+bounces-237630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6898AC4E15B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AB844ECBA0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540632FA0F2;
	Tue, 11 Nov 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wh3OWvCQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B449276028;
	Tue, 11 Nov 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866949; cv=none; b=kw10r96ignV5yGyDHDtBZ2NogS5Ev+vuvZZ3j2m/bCThxAsDuJ9adxgyEae0AI1IHsLUKE/bsXuRK31DCC4uHtPh7f1iqp12qifla80dv8PmsfQ22lzCnIP1sgbR1X66y/+H7sdTRyc889wsDUb1IACXbQYAApVqIky/bGQz7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866949; c=relaxed/simple;
	bh=ZQ6dxipJ51QHX5QrsUWP9b3Vwtyiu0o23y1NOa3Jsn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEol4lGEyXwIAjIUC1hvxzkiWW+DenAW7tvWx3T+oqNHbou6YOnXlfi1pxB2TckTRsVIo0b6SAW9bkhQSvHVh4ij3QkzykiukGI8q3hbDbZRyXsaBUn8CGrnLe+6Dp1Wrw50XcH8aD/AxhQ6sa3joW4ocjw9mpkbX1C4Rvb765Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wh3OWvCQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I3zJTFOQs/8vSW+pEVegCZ+SZsAcTAe2+aJAkEUSPZo=; b=wh3OWvCQp9mBGT7yDM/H5Ov8AO
	M0k81Jxf1yX0xkuOxZFWM40RhfP5XBnmvVMD2DI1aycP77i2o4aBLdI5JCxBuHlysIG4ArYFkmCnS
	L2swtVFu6GwZjMFsp5WoPQUBVmNmWdpStrmxT7ljL1NqG8GbM+RZMSMv9UIAfziSqLhc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIoDh-00DdEc-0w; Tue, 11 Nov 2025 14:15:37 +0100
Date: Tue, 11 Nov 2025 14:15:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Message-ID: <d43743aa-715d-43b3-b00d-96433a85f5fa@lunn.ch>
References: <20251105043344.677592-1-wei.fang@nxp.com>
 <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
 <PAXPR04MB85106ADEC082E1E8C36DA65188CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85106ADEC082E1E8C36DA65188CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>

> There is an Integrated Endpoint Register Block (IERB) module inside the
> NETC, it is used to set some pre-initialization for ENETC, switch and other
> functions. And this module is controlled by the host OS. In IERB, each
> ENETC has a corresponding LaBCR register, where
> LaBCR[MDIO_PHYAD_PRTAD] represents the address of the external PHY
> of that ENETC. If the PHY address accessed by the ENETC using port MDIO
> does not match LaBCR[MDIO_PHYAD_PRTAD], the MDIO access is invalid.
> Therefore, the Guest OS cannot access the PHY of other ENETCs using
> port MDIO.
> 
> What patch 1 and patch 2 do is configure LaBCR[MDIO_PHYAD_PRTAD] for
> each ENETC.

And this is done by the host OS. The guest OS has no access to this
register?

The host OS is using DT, following the phandle from the MAC to the PHY
to find the address of the PHY. So is the MAC and PHY also probed in
the host OS, because it is listed in DT? When the guest OS is
provisioned, is the host driver of the MAC and PHY unbound? A DT blob
for the guest is constructed from the host DT blob, taking out all the
parts the guest is not allowed to access?

> > I assume there is a hypervisor doing this enforcement? But if there is
> > a hypervisor doing this enforcement, why does the ENETC port MDIO need
> > programming? The hypervisor will block it from accessing anything it
> > should not be able to access. A normal MDIO bus scan will find just
> > the devices it is allowed to access.
> > 
> > I also think the architecture is wrong. Why is the MAC driver messing
> > around with the ENETC Port MDIO hardware? I assume the ENETC port MDIO
> 
> The MAC driver (enetc) only simply changes the base address of its port
> MDIO registers, see patch 3:
> 
> mdio_priv->mdio_base = ENETC4_EMDIO_BASE;

And i assume the hypervisor like block is limiting the guest to only
access this MDIO bus? But why do this here? The DT blob passed to the
guest should have the correct base address, so when it probes the MDIO
bus it should already have the correct address?

	Andrew

