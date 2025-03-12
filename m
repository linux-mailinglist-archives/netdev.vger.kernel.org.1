Return-Path: <netdev+bounces-174251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE2A5E06A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2150D3B8922
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0312512DC;
	Wed, 12 Mar 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ArIpD8Pk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B2156237;
	Wed, 12 Mar 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793592; cv=none; b=T4/glvNm1eP2p7oikZJM7Sa6S+E/Y37D1vrA+gI5ysklmlGfNm9pNAwRJr5G2Kmr3N4z9FkYcym/imTWiEzM2ZpmUuUYFwkZpuKAjCngHJGcR95R/c7tCKRMucSCQEUpGx8+TkENOWjzf7KVcNZWsCehoFXcSsZnP6PuzCC4jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793592; c=relaxed/simple;
	bh=wvjZs6Ho1imdevToYORMmFUS+fOEcLE9ZMd7vfDXyMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2S8dkIMOo2obG9SDVeWwyWS7f3d66YvoGB4r4rI68PFxx9hkNp5no0H/rpIHRE5WzXpBeErhyMVJ/kk6J8XtORkqDXI/CD0Kz1AOSDlL0s9qp6Uzz2Wol5qzVViw5FkFHCihHaMImbFSrDwaMf7qvyN7LJCdu4V/iVuhrCm6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ArIpD8Pk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iH9GHclLADxHaK7lGmwG60TMy/tMBW1Zzi6F7hap/Yg=; b=ArIpD8PkcXyPglBLUs0D4cNd6j
	5eeOs7YBGX8A63fnnpdRkt8C1TR29b8uSR7GDvR1N4MR11R+lDJMYhOvoz9ZjHJeXgLdl/AW5N982
	qtaO8XKx3nkPfNng4WAUcTWZGPK76teiIDpbBuyEMHSvas6vUIzYwsBBzqTSowVgSqkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsO4q-004hkE-KU; Wed, 12 Mar 2025 16:33:00 +0100
Date: Wed, 12 Mar 2025 16:33:00 +0100
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
Message-ID: <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>

On Wed, Mar 12, 2025 at 03:06:32PM +0000, Gupta, Suraj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, March 12, 2025 8:29 PM
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
> > > > On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > > > > +   /* AXI 1G/2.5G ethernet IP has following synthesis options:
> > > > > > +    * 1) SGMII/1000base-X only.
> > > > > > +    * 2) 2500base-X only.
> > > > > > +    * 3) Dynamically switching between (1) and (2), and is not
> > > > > > +    * implemented in driver.
> > > > > > +    */
> >
> > > - Keeping previous discussion short, identification of (3) depends on
> > > how user implements switching logic in FPGA (external GT or RTL
> > > logic). AXI 1G/2.5G IP provides only static speed selections and there
> > > is no standard register to communicate that to software.
> >
> > So if anybody has synthesised it as 3) this change will break their system?
> >
> >         Andrew
> 
> It will just restrict their system to (2)

Where as before, it was doing SGMII/1000base-X only. So such systems
break?

	Andrew

