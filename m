Return-Path: <netdev+bounces-101415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59418FE7A6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C13B259C4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF08195F10;
	Thu,  6 Jun 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rKN9pVNQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62408193080;
	Thu,  6 Jun 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680193; cv=none; b=GUoSJGKi1RzNcsms0Doj5rALqpl7n1iquR+uhigyyudrWAHNbwrCzy6ZypNZJUqp98TPoDfLhGJWlGvqKG498VukXQonO9w5ilETh4f5hNt9okwOUSzSl/i2j9e+q//5+xx+G+60Vw1o2fobRI5zBbLWcZEqbtzZLMLfPccSh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680193; c=relaxed/simple;
	bh=00drqhebaHWCjS05Lbg4tmTQZPkOKshoCUutLfgZstY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl/JQA+QLJ7szGxKiI/A5/Jf/3MnNJTdfmW8mUrQNYVDSi74iRf4KQa6+TrIj7ng5bcgifdZNjyX59A/AW6XnfQaU2+spm1fpLTRe8YqA6xOjiJ8bw9jEwj3JTumlfG8baF72WTlUnzRLhYa2He+FnsrLbrVXe1no8Xi5NgpL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rKN9pVNQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mhwoRV2RXqsiDHFrRm5Df2FNUcBIA3rXGBCyxZFRSdk=; b=rKN9pVNQpy9JdaYYfUdasjoWj3
	B4SlMa28Ql1LIrX6cdnDqFHeEz7t9uskCc5VMipW6S/Ew/0fXrQgwQyEqXCyjMIXi3RVHn+84EBKC
	IEZqxuQQolOWc5oxUnPCZnwB0DSZx6j8r9dKOX4PCCk6ie+N9QTgrE9k5RqKSsC3xGdE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFD4x-00H1ED-R9; Thu, 06 Jun 2024 15:22:55 +0200
Date: Thu, 6 Jun 2024 15:22:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Jayati Sahu' <jayati.sahu@samsung.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Message-ID: <14887409-4c5e-4589-b188-564df42924c8@lunn.ch>
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
 <20230814112539.70453-4-sriranjani.p@samsung.com>
 <323e6d03-f205-4078-a722-dd67c66e7805@lunn.ch>
 <000001dab7f2$18a499a0$49edcce0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001dab7f2$18a499a0$49edcce0$@samsung.com>

> > > +&ethernet_0 {
> > > +	status = "okay";
> > > +
> > > +	fixed-link {
> > > +		speed = <1000>;
> > > +		full-duplex;
> > > +	};
> > > +};
> > 
> > A fixed link on its own is pretty unusual. Normally it is combined with an
> > Ethernet switch. What is the link peer here?
> 
> It is a direct connection to the Ethernet switch managed by an external
> management unit.

Ah, interesting. This is the third example of this in about a
month. Take a look at the Realtek and TI work in this area.

So, i will ask the same questions i put to Realtek and TI. Does Linux
know about the switch in any way? Can it manage the switch, other than
SNMP, HTTP from user space? Does it know about the state of the ports,
etc?

If you say this is just a colocated management switch, which Linux is
not managing in any way, that is O.K. If you have Linux involved in
some way, please join the discussion with TI about adding a new model
for semi-autonomous switches.

   Andrew

