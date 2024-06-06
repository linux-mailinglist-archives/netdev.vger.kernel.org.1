Return-Path: <netdev+bounces-101411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BAB8FE74F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831B2284B4A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39A7196421;
	Thu,  6 Jun 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FI0Wio6W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95419195F34;
	Thu,  6 Jun 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679554; cv=none; b=u61y0U0kcjrJJ8aQbe2Ip9+RX3YVQ965PxAZmQnOnrECBDpOFPx8SHkwOCLHThq4Lh7BmbtIJOWvtBBLs+2glfD7W+K8pdkJNdWZWDZS9dPA15Z42esCn57zBx2eE38jyoukKJ7MINtG1kWfbqBDa+BTJ4egzU4EoREnKM9ZmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679554; c=relaxed/simple;
	bh=t4Yrc4YSgi5aw6OYsIIwbSUEnB+XhTy6yQ2BhFHTQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYcMfdU4jK7cb1NrwdKgfinXCPkuRC2iX4u41ZUAgOerIB3rSOHOJkGWI26+8hi1noVpC/33HCbsJ1blnNj48JGioK8r6mLdJjFNrEPQuKjX2LT16kJQ3SXUiDoUM/68ciBltxjDmEQbLAqQrLUbpeDOONLJJL2VjRa0AY9yJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FI0Wio6W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qxLXUJYoql242lphy3eB+73ttg/HGC3RBqjvzOTKpt8=; b=FI0Wio6Wp9bZlIiHYC86O6Md3M
	bgzBQ9NSbW0xJ6UuYewHJcqVK1VWZsS+zXMbeO7hasU7Ue4gFSczKss/PrrccYG6GFrMZi/X8NpbA
	p1R9rPmcXFPGq8RV58jNrlDgI11e0hugrGwZP1bPIKQIA6IqG9SedElqPvGTcwVPzE0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFCuZ-00H19p-O0; Thu, 06 Jun 2024 15:12:11 +0200
Date: Thu, 6 Jun 2024 15:12:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>,
	Viliam Vozar <Viliam.Vozar@onsemi.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <79f61e42-c32f-4314-8b77-99880c2d7eeb@lunn.ch>
References: <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
 <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>
 <732ce616-9ddc-4564-ab1f-ac7bbc591292@lunn.ch>
 <BYAPR02MB5958DE3C4FE820216153894B83FA2@BYAPR02MB5958.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB5958DE3C4FE820216153894B83FA2@BYAPR02MB5958.namprd02.prod.outlook.com>

> I believe my client is configured to wrap at 70th characters. 
> Not sure why it is not doing it.


It could be you also send a MIME obfuscated copy which is not wrapped
correctly?

> > > 1) Can we move memory map selector definitions
> > (OA_TC6_PHY_C45_PCS_MMS2 and other 4 definitions) to the header
> > file
> > >      include/linux/oa_tc6.h?
> > >      Also, if possible, could we add the MMS0, MMS1?. Our driver is
> > using them. Of course, we could add it when we submit our driver.
> > 
> > Interesting. So you have vendor registers outside of MMS 10-15?
> 
> This is not about vendor registers. The current oa_tc6 defines 
> MMS selector values for 2, 3, 4, 5, 6. I am asking, if 0, 1 can be added, 
> which are meant for "Standard Control and Status" and MAC respectively, 
> according to MMS assignment table 6 on OA standard.

But why would a MAC driver need access to those? Everything using
those registers should be defined in the standard. So the framework
should handle them.

> One example I can think of is, to handle PHYINT status bit
> that may be set in STATUS0 register. Another example could be,
> to give a vendor flexibility to not to use interrupt mode.

But that is part of the standard. Why would a driver need to do
anything, the framework should handle PHYINT, calling
phy_mac_interrupt(phydev).

I really think you need to post patches. We can then discuss each use
case, and i can give you concrete feedback.

But in general, if it is part of the standard it should be in the
framework. Support for features which are not part of the standard,
and workarounds for where a device violates the standard, should be in
the MAC driver, or the PHY driver.

	Andrew

