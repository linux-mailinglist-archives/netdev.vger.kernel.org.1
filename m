Return-Path: <netdev+bounces-157197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B321BA095E9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D153A95FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0121147F;
	Fri, 10 Jan 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DGBA6mWp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70920E035;
	Fri, 10 Jan 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523528; cv=none; b=CnJQONVWwN8x/T/JcUcJ16ooDCvNcedSIy8+YPDITPrMLj8fie5yMKn2PFysFQLZ4+NaufxAx5AL8zmw4x+BFxl22dBlTrPw0EYLg+Iw5mdfy4C+p0OBC5V3Plhf1UWiOFX/iWsGqurOhjyQTFT371WXGYbc59OBA3kJsGTk6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523528; c=relaxed/simple;
	bh=0O3EkU0RPlxCHGr0yIks5lMvozMStcD+7GteeL08l8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT6gza1QXo+gRA3pvyrjdSyE1EYRXsct6dhZOP1UPOKHLmpl89VyyxJwr+497pShZLDYXZo/FBktR87BKJZs3bgwmpOLyunrF8XBXqY+ReN0wfM+O+iKZT8E1tXPsl8S9DPLiqOOpix871lGm2xZTLEIj8pZeI3bcvZnpLgQgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DGBA6mWp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kef15OjRvGqUB+zEmVxSQr9gAePzm85eOXIQPtstMZs=; b=DG
	BA6mWpmmAcZhO/CuBfQGcX7JmP6/Py9BPkLAtM4dcpF7xielUeAvTdam9teBM6d8R+TU4t3ti/rmG
	5kvDb2vcZnoJKvHEIfvTu+13nvFyh/86ESthfE7J3KBr0sdMpeAeientgN+zgEa9KW+ZcpgyxUjgf
	RM+DgRd225AUVZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWH5W-003H4u-HL; Fri, 10 Jan 2025 16:38:18 +0100
Date: Fri, 10 Jan 2025 16:38:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H?= v2 05/10]
 ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <0ee94fd3-d099-4d82-9ba8-eb1939450cc3@lunn.ch>
References: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
 <81567190-a683-4542-a530-0fb419f5f9be@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81567190-a683-4542-a530-0fb419f5f9be@linux.ibm.com>

> Do we need updates on this description. It doesn't talk about external PCB
> level delays?
> 
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L77-L90
> 
> This is what you explained:
> 
> MAC driver reads following phy-mode from device tree. 95% of mac driver
> directly
>  pass it to PHY through phy_connect.
> 
> rgmii - PCB has long clock lines so delay is added by PCB
>         On this mode PHY does nothing.
> rgmii-id - PCB doesn't add delay. Either MAC or PHY needs to add the delay
>            Add delays in both directions. Some PHY may not add delay in that
>            case MAC needs to add the delay mask rgmii-id to rgmii.
> rgmii-rxid - If there is an extra long TX clock line, but not RX clock,
>              you would use rgmii-rxid
> rgmii-txid - When there is an extra long RX clock line on the PCB, but not
>              the TX clock line, you would use rgmii-txid

The documentation is not great, that has been said a few times.  What
is described here is the view from the PHY, which is not ideal.

      # RX and TX delays are added by the MAC when required
      - rgmii

From the perspective of the PHY, this means it does not need to add
delays, because the MAC has added the delays, if required, e.g. the
PCB has not added the delays.

We have the problem that DT is supposed to describe the
hardware. Saying the PHY should add the delays, but if the MAC adds
the delays it needs to mask the value passed to the PHY does not
describe the hardware, it is Linix implementation details. The DT
Maintainers don't want that in the DT binding because other OSes might
decide to implement the details differently.

So your description becomes:

rgmii      - PCB has long clock lines so delays are added by the PCB
rgmii-id   - PCB doesn't add delay. Either MAC or PHY needs to add the delays
             in both directions.
rgmii-rxid - There is an extra long TX clock line on the PCB, but not the RX clock.
rgmii-txid - There is an extra long RX clock line on the PCB, but not the TX clock.

It is correct, but leaves so much unsaid developers will still get it
wrong. What we really want is that developers:

1) Read the mailing list. Patches for RGMII delays are posted at least
   once an month and i point out how they are wrong. If developers
   actually read the mails, they would not make the same mistake again
   and again.

2) Developers for some reason like to invent their own code, rather
   than taking the easy route of copy from a driver already in Linux.
   The majority of drivers in Linux get this right, so if you copy
   another driver, you should get it right for free as well.

	Andrew

