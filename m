Return-Path: <netdev+bounces-175751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87528A67605
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE16819C0F77
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C420D519;
	Tue, 18 Mar 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="357SSSF2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C420CCF5;
	Tue, 18 Mar 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306599; cv=none; b=D82+3Bg86lUUQZHd7+QgQ7/+wkWpnJQEXH8EOveYUW3f42iuDyMAcYP3tnzI0lvK5x+6tqz6RpKL8kiLQvcCbMUctWaJWV0xHpTcNyC46Mi2Eb2uXHuCBSyBfZyMDVHiP9/qPcp9NvrxEFveFbfzZRrqlzKjo2aHDlalPc94gOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306599; c=relaxed/simple;
	bh=ONEQCJHxtWXCTHYNxmFxRZ9fNTNwrSUvdGTV4QoojI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLttlobn/a1x5NasoHrg4EMs9ypHSDFmujJKEqhZ74+k/H7blHy9shjkDe2Xn4ph6bD0MEWJg87jYFkg1GYFTLSgRstCnF6erHYyEhJl8nejcAfPUk4ExzoKo55ER8ngQhmmNDTHvsqse9gFwZuKdVOWDnJxaUiKnGXyBiy9TKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=357SSSF2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0yf+Edtj7qyHSUTzNfZ+JKXVNOrD8jm+TXRXVg69QbA=; b=357SSSF22yh5nMcYWPclY7KXns
	bBTRpnsCM0yabQo6ggsqvDtS521lMh5u73mchyQSJ01CwKeyG0v+3YePiHNisxh+qWVKy4GBaVYcn
	r0Q3lIM+FIwRUz5pkuG+bJ7OENHhjUHK7BtAmWbnOGI3HE7L6QrQAaz1gFMU1LblELAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXX5-006Gct-Rs; Tue, 18 Mar 2025 15:03:03 +0100
Date: Tue, 18 Mar 2025 15:03:03 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbbmV0LW5leA==?= =?utf-8?Q?t?= 2/4] ARM:
 dts: ast2600-evb: add default RGMII delay
Message-ID: <8c0195dd-50b3-4f30-a021-c5b77d39d895@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
 <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
 <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 11:00:27AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > >  	phy-mode = "rgmii";
> > >  	phy-handle = <&ethphy2>;
> > >
> > > +	tx-internal-delay-ps = <8>;
> > > +	rx-internal-delay-ps = <4>;
> > > +
> > 
> > Ideally you want:
> > 
> > 	phy-mode = "rgmii-id";
> > 	tx-internal-delay-ps = <0>;
> > 	rx-internal-delay-ps = <0>;
> > 
> > Since 'rgmii-id' correctly describes the hardware.
> 
> I still confuse about ethernet-controller.yaml.
> It lists 'rgmi', 'rgmii-rxid', 'rgmii-txid' and 'rgmii-id'.

DT describes the board. Does the board add the 2ns delay via extra
long clock lines? If yes, use rgmii. If the MAC/PHY pair need to add
the 2ns delay, use rgmii-id.

If the MAC/PHY pair is adding the delay, the DT says nothing about how
they add the delay.

The general rule is the PHY adds the delay. If you look at
drivers/net/phy/*.c, every PHY that implements RGMII support both
PHY_INTERFACE_MODE_RGMII_ID and PHY_INTERFACE_MODE_RGMII. There is no
reason not to follow ever other MAC/PHY pair and have the PHY add the
delay. The MAC can then do fine tuning if needed, adding small delays.

	Andrew

