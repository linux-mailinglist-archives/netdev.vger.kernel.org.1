Return-Path: <netdev+bounces-157804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B1A0BCBD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385F21886DDA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3B1FBBD4;
	Mon, 13 Jan 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6To6T4eq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B511420DD;
	Mon, 13 Jan 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783994; cv=none; b=EwQzQ9rX7AyL8McNqu9ed+0bY0GhYgxwajO9T4fw1vIZUJOu5GwdIF13izBArr91ZTNQMWXhin68oe5udnJZD7vf6eTlp8KoLO6jKIu68Qz6dcmQkLeAx/1h9DvZ9n/z1tMIleHHhbRSAR6PkUlSsbDtbTMN602g0ZbDmxDQbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783994; c=relaxed/simple;
	bh=0mRezYsIRETVR9LowYE1d/AT0UNKa27L8I9LtzK8HNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5ijgg/AzaJ6/IMXFoQrnoa5q+/j8UOWbUTaTnrF2CM9IRQAuJrXGCEhK3OciiGDIsb2hcIOvbnGfEQ91fquP0Crlh8MVTatSCwKbPCdQVXMH2ADCzOdjklLMQN9FB9QG4Yixltp+axwUUHJkrMJJPLfNXraow7o9z8sQeFyxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6To6T4eq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SJf7sTIHMVoyN452+drIiRGVhPY1OdqWNinj135Rt5M=; b=6To6T4eqIb9D/f6GnK2y9E3X+K
	/LXB2M6aaMJ8/VMHIKxyTGfTPBNR0A/0qyBQlLr2off5hhlDsY7BzS/M1+PqdrCTa70Cv7I0mxo2s
	skHAcPXbWDzs9YmIc78f0PqiU+waPYbKiL8CIkB1W4tkTa0iwZMRJ6m/OCUNJ9SgQDzE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXMqo-0048x9-KA; Mon, 13 Jan 2025 16:59:38 +0100
Date: Mon, 13 Jan 2025 16:59:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <5118eb9a-ff6e-4e78-8529-d174e09cf52e@lunn.ch>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
 <fcffef06-c8d1-4398-bc20-30d252cd2fd2@lunn.ch>
 <20250113141828.GA4250@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113141828.GA4250@debian>

On Mon, Jan 13, 2025 at 03:18:28PM +0100, Dimitri Fedrau wrote:
> Hi Andrew,
> 
> Am Mon, Jan 13, 2025 at 02:54:28PM +0100 schrieb Andrew Lunn:
> > On Mon, Jan 13, 2025 at 06:40:11AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > > Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> > > Add support for configuration via DT.
> > 
> > The commit message is supposed to answer the question "Why?". Isn't
> > reducing the voltage going to make the device non conforming? Why
> > would i want to break it? I could understand setting it a bit higher
> > than required to handle losses on the PCB and connector, so the
> > voltages measured on the RJ45 pins are conforming.
> >
> - Will add the "Why?" to the commit description. You already answered it.
> - Yes you are right.
> - I don't want to break it, the PHY just provides these settings. And I
>   just wanted to reflect this in the code, although it probably doesn't
>   make sense.
> - In my case I want to set it a bit higher to be conforming.

I have seen use cases for deeply embedded systems where they want to
reduce it, to avoid some EMC issues and save some power/heat. They
know the cable lengths, so know a lower voltage won't cause an
issue. The issue in that case is that the configuration was policy,
not a description of the hardware. So i pushed for it to be a PHY
tunable, which can be set at runtime. Your use case is however about
the hardware, you need a slightly higher voltage because of the
hardware design. So for this case, i think DT is O.K. But you will
need to make this clear in the commit message, you want to make the
device conform by increasing the voltage. And put something in the
binding description to indicate this setting should be used to tune
the PHY for conformance. It is not our problem if somebody misuses it
for EMC/power saving and makes there device non-conform.

> > Also, what makes the dp8382 special? I know other PHYs can actually do
> > this. So why are we adding some vendor specific property just for
> > 100base-tx?
> >
> I don't think that the dp83822 is special in this case. I just didn't
> know better. Would be removing the vendor specific property enough ?
> Or is there already a defined property describing this. Didn't found
> anything.

If i remember correctly, there might be a property for
automotive/safety critical, where there is a choice of two
voltages. But it might be just deciding which of the two voltages are
used?

There is also:

  ti,cfg-dac-minus-one-bp:
    description: |
       DP83826 PHY only.
       Sets the voltage ratio (with respect to the nominal value)
       of the logical level -1 for the MLT-3 encoded TX data.
    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
    default: 10000

  ti,cfg-dac-plus-one-bp:
    description: |
       DP83826 PHY only.
       Sets the voltage ratio (with respect to the nominal value)
       of the logical level +1 for the MLT-3 encoded TX data.
    enum: [5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
           10625, 11250, 11875, 12500, 13125, 13750, 14375, 15000]
    default: 10000

I'm not so much an analogue person, but these don't make too much
sense to me. A ratio of 10,000 relative to nominal sounds rather
large. I would of expected a ration of 1 as the default? Since this
makes little sense to me, i don't think it is a good idea to copy it!

I've not looked at 802.3.... Do we need different settings for
different link modes?  Are the losses dependent on the link mode?  Are
the voltages different for different link modes? Is voltage actually
the best unit, if different link modes have different differential
voltages? Would a gain make more sense for a generic binding, and then
let the PHY driver convert that into whatever the hardware uses?

So, please take a step back, think about the general case, not your
specific PHY, and try to come up with a generic binding applicable to
all PHYs.

	    Andrew

