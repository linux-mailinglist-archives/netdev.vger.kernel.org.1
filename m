Return-Path: <netdev+bounces-195254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110AACF13F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816473A420B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385A23A9B3;
	Thu,  5 Jun 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QOqj9mB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2034187332;
	Thu,  5 Jun 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131333; cv=none; b=kucnxS5YifupmhnLVVCqrCaZlWwBXYM79gMrO1Crftfa520e7Qjtx//0MrluGijsSxlebeAm+HnNEv+wYKJFCxdsLNIn9tKiWu5o8E/AvV9KIXvMMoOry5gWBkdFpooSJWnrQFXTSBEtJtrBtd9QhsAitcde6E9/oMkuEfCV5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131333; c=relaxed/simple;
	bh=PQwCtTHpfjblBY1wgPoU6gycETBaSsI0rdsuy5i175U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huQ6MHT2suWNWwar1kOhVokAxDGqJbLyCiWCQqFUIMFxuW6Pb6uWCEL0QhjHsm8sTx043T/11+uuyFCp7OWMAALEYXogxZ4ca+waQ54IeaFsnMU/O+ymuzswqzLL3TFW567xyPubRFKKJH7dW7s4X37LRVBrz2CoW8B+xrZh+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4QOqj9mB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Avs8RreK+zR7HP1QXRMqbMIL8H/eJs96poV9Y6KSBt8=; b=4Q
	Oqj9mBciCJWKhvwI8WQ7R3rG9kkXjYiEwi3NywHjU5tUpdrTY+H1J79+vA3gnVJR5s+Z8W0YnnoE/
	qcXxx+UCq5dLyNQzwGyfFot7sSGg4QCcx6Zdi40E6j7KH7FObEBudB6+6bJcI63NRMQqIeydWMU/n
	sIwBz7Bis/Z1ZrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNAxR-00Em9A-8k; Thu, 05 Jun 2025 15:48:37 +0200
Date: Thu, 5 Jun 2025 15:48:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>

On Thu, Jun 05, 2025 at 06:51:43PM +0800, Icenowy Zheng wrote:
> 在 2025-06-05星期四的 10:41 +0100，Russell King (Oracle)写道：
> > On Thu, Jun 05, 2025 at 05:06:43PM +0800, Icenowy Zheng wrote:
> > > In addition, analyzing existing Ethernet drivers, I found two
> > > drivers
> > > with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
> > > ti/icssg/icssg_prueth.c .
> > > 
> > > The QCOM ETHQOS driver enables the MAC's TX delay if the phy_mode
> > > is
> > > rgmii or rgmii-rxid, and the PRU ETH driver, which works on some
> > > MAC
> > > with hardcoded TX delay, rejects rgmii and rgmii-rxid, and patches
> > > rgmii-id or rgmii-txid to remove the txid part.
> > 
> > No, this is wrong.
> > 
> > First, it does not reject any RGMII mode. See qcom_ethqos_probe() and
> > the switch() in there. All four RGMII modes are accepted.
> 
> Well my sentence have its subject switched here. I mean the TI PRU ETH
> driver is rejecting modes.

Which is theoretically fine. I've not looked at this driver in
particular, but there are some MACs were you cannot disable the delay.
The MAC always imposes 2ns delay. That would mean a PCB which also has
extra long clock lines is simply FUBAR, cannot work, and 'rgmii' is
invalid, so reject it.

> Well I am not sure, considering two examples I raised here (please note
> I am comparing QCOM ETHQOS and TI PRUETH two drivers, they have
> contrary handling of RGMII modes, and one matches the old binding
> document, one matches the new one).

Nope, i fully agree with Russell, the binding has not changed, just the
words to explain the binding.

Just for a minute, consider your interpretation of the old text is
wrong. Read the old text again and again, and see if you can find an
interpretation which is the same as the new text. If you do:

* It proves our point that describing what this means is hard, and
  developers will get it wrong.

* There is an interpretation of both the old and new where nothing
  changed.

* You have to be careful looking at drivers, because some percent of
  developers also interpreted it wrongly, and have broken
  implementations as a result.  You cannot say the binding means X,
  not Y, because there is a driver using meaning X.

My hope with the new text is that it focuses on hardware, which is
what DT is about. You can look at the schematic, see if there is extra
long clock lines or not, and then decided on 'rgmii-id' if there are
not, and 'rgmii' is there are. The rest then follows from that.

And if you look at the questions i've been asking for the last year or
more, i always start with, "Does the PCB have extra long clock
lines?".

> > The RGMII modes have been documented in
> > Documentation/networking/phy.rst
> > (Documentation/networking/phy.txt predating) since:
> 
> I checked the document here, and it seems that it's against the changed
> binding document (it matches the original one):
> 
> The phy.rst document says:
> ```
> * PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting
> any
>   internal delay by itself, it assumes that either the Ethernet MAC (if
> capable)
>   or the PCB traces insert the correct 1.5-2ns delay
> ```
> 
> The changed binding document says:

You are not reading it carefully enough. The binding describes
hardware, the board. phy.rst describes the phylib interface. They are
different.

	Andrew

