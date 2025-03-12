Return-Path: <netdev+bounces-174314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC3A5E40F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F57A29CC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1D1E5B9B;
	Wed, 12 Mar 2025 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nOolVWXO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D61E5B76;
	Wed, 12 Mar 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806154; cv=none; b=fB60eWGA0Jj3ZI7QZfwOClpRBbf4HyjrtdGOxdcXNnpey/ljt3vou/OXRcc32FaH1JefGMWnucVgOydmN/yWM55XrQ7EyHDEvMsxgqxKnsNBHmIKJdg770h/mXodzBOTdxd1O9/lESN1bThWijIRwzygnHNkDDiaJgSON9OsS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806154; c=relaxed/simple;
	bh=idOmWFvNR/hkrHv8K6P5ExxPfuEgX7xMqzYEmJvI81Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKgOtOrkrEtlxbfG4z/AJQSQ0h4ZwtJ5FkW4s4U1u/iDXa5gfe8HL6AAJwe1rsnRVVk7+FqvjmmKiQYn72/EGWeee1qzIpaIrZohgmtkYNSn0lfrFwnYxmWK1IVprelbpWEn2k8FAQ2O8NoKPjV9Fn3x+adtuk6w435rJLF+NsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nOolVWXO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6yolepTUWycUYSP0NNLMuaVmz6Sw1ofQLTuAXR+lN7k=; b=nOolVWXOwrwm+h38j0+1o0NTme
	Vm2e2oT75glTXLaSsbcjFtGNrDxqQd/zSwatCVx1BTRKCZEehp2GexcuwjMiFozWB2Phvev30ThWa
	qeIXkDD0+XN90q+HCVz3qKY2rarAsVjPHaMz1eNHCu1EJlCqatHjd+S3nJFn4BYrUbz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsRLL-004kgf-JU; Wed, 12 Mar 2025 20:02:15 +0100
Date: Wed, 12 Mar 2025 20:02:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Message-ID: <ce0796f4-cf2e-4a3d-ae79-1f9b9966773e@lunn.ch>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>

On Wed, Mar 12, 2025 at 04:08:02PM +0000, Gupta, Suraj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, March 12, 2025 9:03 PM
> > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > Cc: Russell King <linux@armlinux.org.uk>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > Simek, Michal <michal.simek@amd.com>; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > <harini.katakam@amd.com>
> > Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X only
> > configuration.
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Mar 12, 2025 at 03:06:32PM +0000, Gupta, Suraj wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: Andrew Lunn <andrew@lunn.ch>
> > > > Sent: Wednesday, March 12, 2025 8:29 PM
> > > > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > > > Cc: Russell King <linux@armlinux.org.uk>; Pandey, Radhey Shyam
> > > > <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> > > > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > > > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > > > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > > > <harini.katakam@amd.com>
> > > > Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for
> > > > 2500base-X only configuration.
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > > > On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > > > > > > +   /* AXI 1G/2.5G ethernet IP has following synthesis options:
> > > > > > > > +    * 1) SGMII/1000base-X only.
> > > > > > > > +    * 2) 2500base-X only.
> > > > > > > > +    * 3) Dynamically switching between (1) and (2), and is not
> > > > > > > > +    * implemented in driver.
> > > > > > > > +    */
> > > >
> > > > > - Keeping previous discussion short, identification of (3) depends
> > > > > on how user implements switching logic in FPGA (external GT or RTL
> > > > > logic). AXI 1G/2.5G IP provides only static speed selections and
> > > > > there is no standard register to communicate that to software.
> > > >
> > > > So if anybody has synthesised it as 3) this change will break their system?
> > > >
> > > >         Andrew
> > >
> > > It will just restrict their system to (2)
> >
> > Where as before, it was doing SGMII/1000base-X only. So such systems break?
> >
> >         Andrew
> 

> If the user wants (3), they need to add their custom FPGA logic
> which anyway will require additional driver changes. (3) was not
> completely supported by existing driver.

You say 3) is a synthesis option. Say somebody synthesised it that
way, and found it works for what they need with SGMII/1000base-X.
Because the driver took no notice of the capability bit, that is what
it would do. Since it worked for them, they might not of gone back and
optimised the options. "If it is not broken, don't fix it". So we
could have systems out in the wild, synthesised as 3) happily doing 
SGMII/1000base-X ?

With this change, won't you break those systems?

I'm just trying to get to a definitive answer, is this change actually
safe to all todays possible systems?

	Andrew


