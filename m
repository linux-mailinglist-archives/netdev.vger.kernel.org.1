Return-Path: <netdev+bounces-174568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC8A5F4D3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0273ADC18
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F572673B3;
	Thu, 13 Mar 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6HSjX6LE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F7266F06;
	Thu, 13 Mar 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870050; cv=none; b=aWohqnVA9ynUp8uQNjUlSvEnXJ++XFj6UH7dK2SGSLFPc7LRE2D6AG6PJXKoM7vuFYEYq6EEDaLHuJLsCLlmbYBLXMFweAfQShR6QoUT+stO8Fz+gtdS4DPibaL3dMYX6eSkbpUPdUvZzWkAIb+uEeX5DPNXFlS4HdsdhQ0Ypmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870050; c=relaxed/simple;
	bh=jh7AlQV+J80m3ya1YliWMdlZd3CLbamm8Ao4jbwHTj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8Nzi2T3Wa1dMloTz3EndTIoCY0/799qBWjI0IG/7a9VQsblAban6E4kL5vFNpSAPwm49sBw2lJZvIWAukKmrbC/Np4w0D4AzHfcTcjU8gFXI40DKjee4PRNMw4pug9JxMZ1krKcOTimr8um2nCb5ymTiVujnk/E995V4L3Q6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6HSjX6LE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2JNQ9mA9G78qT8pu4ERbL8PORL7dS1v735kFrxqkM54=; b=6HSjX6LE9s3DMBguSsNtVrjvd3
	lF2RDAYnpBr5rqqxgwCzpWKi1ISsjoEPvPZLxBhey78k2Zz92YoqiVXQSWtgWn89P5vJnvpyXIiyi
	v1wJfXpqe3GgMv5vPbxA9QqxxQMHyOYKRTpTbPn7YvO5TOAXsJNyF3gVfDs5C6FhPeQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tshy3-004zQY-Aq; Thu, 13 Mar 2025 13:47:19 +0100
Date: Thu, 13 Mar 2025 13:47:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Message-ID: <b2a65ad1-d4ca-4c0d-b59e-911b07f96554@lunn.ch>
References: <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>
 <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
 <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
 <BL3PR12MB6571DF7CBA49AF626ABDA382C9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571DF7CBA49AF626ABDA382C9D32@BL3PR12MB6571.namprd12.prod.outlook.com>

On Thu, Mar 13, 2025 at 07:34:55AM +0000, Gupta, Suraj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Gupta, Suraj
> > Sent: Thursday, March 13, 2025 9:01 AM
> > To: Andrew Lunn <andrew@lunn.ch>; Russell King (Oracle)
> > <linux@armlinux.org.uk>
> > Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam,
> > Harini <harini.katakam@amd.com>
> > Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X only
> > configuration.
> >
> >
> >
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Thursday, March 13, 2025 3:41 AM
> > > To: Russell King (Oracle) <linux@armlinux.org.uk>
> > > Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; Pandey, Radhey Shyam
> > > <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> > > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > > <harini.katakam@amd.com>
> > > Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for
> > > 2500base-X only configuration.
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > > This is not an approach that works with the Linux kernel, sorry.
> > > >
> > > > What we have today is a driver that works for people's hardware -
> > > > and we don't know what the capabilities of that hardware is.
> > > >
> > > > If there's hardware out there today which has XAE_ABILITY_2_5G set,
> > > > but defaults to <=1G mode, this will work with the current driver.
> > > > However, with your patch applied, it stops working because instead
> > > > of the driver indicating MAC_10FD | MAC_100FD | MAC_1000FD, it only
> > > > indicates MAC_2500FD. If this happens, it will regress users setups,
> > > > and that is something we try not to do.
> > > >
> > > > Saying "someone else needs to add the code for their FPGA logic"
> > > > misses the point - there may not be "someone else" to do that, which
> > > > means the only option is to revert your change if it were merged.
> > > > That in itself can cause its own user regressions because obviously
> > > > stuff that works with this patch stops working.
> > > >
> > > > This is why we're being cautious, and given your responses, it's not
> > > > making Andrew or myself feel that there's a reasonable approach
> > > > being taken here.
> > > >
> > > > >From everything you have said, I am getting the feeling that using
> > > > XAE_ABILITY_2_5G to decide which of (1) or (2) is supported is just
> > > > wrong. Given that we're talking about an implementation that has
> > > > been synthesized at 2.5G and can't operate slower, maybe there's
> > > > some way that could be created to specify that in DT?
> > > >
> > > > e.g. (and I'm sure the DT folk aren't going to like it)...
> > > >
> > > >       xlnx,axi-ethernet-X.YY.Z-2.5G
> > > >
> > > > (where X.YY.Z is the version) for implementations that can _only_ do
> > > > 2.5G, and leave all other implementations only doing 1G and below.
> > > >
> > > > Or maybe some DT property. Or something else.
> > >
> > > Given that AMD has been talking about an FPGA, not silicon, i actually
> > > think it would be best to change the IP to explicitly enumerate how it
> > > has been synthesised. Make use of some register bits which currently
> > > read as 0. Current IP would then remain as 1000BaseX/SGMII,
> > > independent of how they have been synthesised. Newer versions of the
> > > IP will then set the bits if they have been synthesised as 2) or 3),
> > > and the driver can then enable that capability, without breaking
> > > current generation systems. Plus there needs to be big fat warning for
> > > anybody upgrading to the latest version of the IP for bug fixes to ensure they
> > correctly set the synthesis options because it now actually matters.
> > >
> > >          Andrew
> >
> > Synthesis options I mentioned in comment might sound confusing, let me clear it up.
> > Actual synthesis options (as seen from configuration UI) IP provides are (1) and (2).
> > When a user selects (2), IP comes with default 2.5G but also contains 1G
> > capabilities which can be enabled and work with by adding switching FPGA logic
> > (that makes it (3)).
> >
> > So, in short  if a user selects (1): It's <=1G only.
> > If it selects (2): It's 2.5G only but can be made (3) by FPGA logic changes. So
> > whatever existing systems for (3) would be working at default (2).
> >
> > This is the reason we didn't described (3) in V1 series as that is not provided by IP
> > but can be synthesized after FPGA changes.
> > Hope I'm able to answer your questions.
> >
> 
> I understand your concerns that current solution might break if any existing system uses (3).
> 
> Russel's suggestion to use DT compatible we can try to send as RFC and check if that is accepted by DT maintainers.
> Andrew's suggestion is complete IP solution and will involve IP changes to correct ability register behaviour based on synthesis time selection in a new IP version. But this will need internal discussions and IP rework and might take few months.
> 
> Please let me know your thoughts on it.

Given your comment:

> It's 2.5G only but can be made (3) by FPGA logic changes

It sounds like the design is not ideal at the moment, and you will be
making changes anyway to clean this up. Being fixed in 2.5G mode is
not nice, you need a PHY doing rate adaptation in order to support the
slower speeds.

You should also be thinking forwards. If you add support for fixed
2.5G now, can you cleanly integrate switching between 1000BaseX/SGMII
and 2500BaseX in the future without breaking existing systems? You
probably at least need a paper design of how this will work, so you
can say you have thought through all the user cases: New IP old
driver, Old IP new driver, etc...

	Andrew

