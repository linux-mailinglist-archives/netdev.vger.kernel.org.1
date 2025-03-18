Return-Path: <netdev+bounces-175739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F9A6757E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9928117BEB8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E5B20C008;
	Tue, 18 Mar 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TIykPaMS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5220DD51;
	Tue, 18 Mar 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305517; cv=none; b=QJXLyUGGa9rpfz67vUwpUdLc6w9lNIgCFGpwGbI6UwvV+nVtaTV6dDjm+S7FRR+FZPB7jm423cT4afx5VLEtPqOpgrxRziG4boMsTlAJQb426+zKeyemUJDmj1l011qcgxWBQFNJ2gImFhAI2JbcuyBA5c5LN/KjRplT2tBSIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305517; c=relaxed/simple;
	bh=Kz6FQ/HReAI51U2V9CzlGPsu8I8OwqeEBhYdpAoKzCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm4gRkzwSC+llfAxCYfVL68+IhZABsNluiH8hn72ZWN6witEBJ1/DqS0uftDJsJC7AG5JX+veuH3Rvsn6UZIou6OmOWWIcnvijTBPRzJuixLjlk073zRuGPtQ3n9PXih3GhcF8FoRgVKhpHhOPiQRLBTNsryg+7sk7HljUdCCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TIykPaMS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8/RzstvQ9BWwLvvMkrQEWveUn5iG+OyCk6DBs4Rad9Y=; b=TIykPaMSpNNvt2P5/a+iJhCdkH
	ZDU27yEMxC6rC9OBHfa9CLX+uTPrfzKx89lqkaTMu80DUdw+cgNe/cB87UYF5GoGvpaKYXa51093A
	Pv6f1eCCR9DEwQr3pZC1oPxCHdW0uc5m3ke99tB6mi7Q9b2N0Zt2MkC/rl1UySGgT60Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXFE-006GSZ-5r; Tue, 18 Mar 2025 14:44:36 +0100
Date: Tue, 18 Mar 2025 14:44:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 4/4] net:
 ftgmac100: add RGMII delay for AST2600
Message-ID: <1a2dab82-ddb1-4c38-a576-abd1edd8d5e1@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
 <SEYPR06MB513471FBFDEAFAA3308000699DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513471FBFDEAFAA3308000699DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 10:46:58AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > +	u32 rgmii_tx_delay, rgmii_rx_delay;
> > > +	u32 dly_reg, tx_dly_mask, rx_dly_mask;
> > > +	int tx, rx;
> > > +
> > > +	netdev = platform_get_drvdata(pdev);
> > > +	priv = netdev_priv(netdev);
> > > +
> > > +	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
> > > +	rx = of_property_read_u32(np, "rx-internal-delay-ps",
> > > +&rgmii_rx_delay);
> > 
> > > +	if (!tx) {
> > 
> > The documentation for of_property_read_u32() says:
> > 
> >  * Return: 0 on success, -EINVAL if the property does not exist,
> >  * -ENODATA if property does not have a value, and -EOVERFLOW if the
> >  * property data isn't large enough.
> > 
> > You need to handle EINVAL different to the other errors, which are real errors
> > and should fail the probe.
> > 
> > The commit message, and probably the binding needs to document what
> > happens when the properties are not in the DT blob. This needs to be part of
> > the bigger picture of how you are going to sort out the mess with existing .dts
> > files listing 'rgmii' when in fact they should be 'rgmii-id'.
> 
> Why can't the MAC add internal delay to RGMII? Is it necessary to add on PHY side?

The MAC could, but that is not the point. You need to explain how you
are going to solve the mess you have in DT, why all aspeed boards have
the wrong phy-mode. You need to fix that, and i will continue to NACK
new boards until the correct rgmii-id value can be used to indicate
there do not have extra long clock lines on the PCB.

> > > +		/* Use tx-internal-delay-ps as index to configure tx delay
> > > +		 * into scu register.
> > > +		 */
> > > +		if (rgmii_tx_delay > 64)
> > > +			dev_warn(&pdev->dev, "Get invalid tx delay value");
> > 
> > Return EINVAL and fail the probe.
> 
> Agreed.
> I just show warning here, because sometimes the RGMII delay value will configure at bootloader.

That is a different issue. If there is a value in DT, it must be
valid, fail the probe otherwise.

	Andrew

