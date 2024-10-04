Return-Path: <netdev+bounces-132076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36D990530
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC4028516D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122C2141D0;
	Fri,  4 Oct 2024 14:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254D2139DD
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050549; cv=none; b=aKtlaOUkNgLHipfab8wNpL3J3lxVGMrRtbH8wQzcMS1nFsJvjxTa8ujfAF8KVkXJai/2/4Itu7XrLBn4yHFOaxTerpXvlB7Oxp4Rnp2otjpAczgYxp8FrsqhaaYetm+etM937aFBbqmJck91PJTLkX4ScYd6SDprvFvGlQPYsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050549; c=relaxed/simple;
	bh=m+EuFRP4yJCBryc6cpYw/Y6cYfUZ04WOCx4r0St2QmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLu0SV9y8DE7hQA7+TKtt/8reF4sKZeK7ItHyJItUgO5RRcxiye57+DMko1IZ1bwlSQREtUOk0r962k5OijOGUat9znSaYWsTAMh9IG/SHknBTP3AwHttQxZR4fn/6AZ+RxovGgaU+JHm6murCFIB4PiLDlUIrRM6tVtcX+Tc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swisr-0006f4-HM; Fri, 04 Oct 2024 16:02:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swisp-003abZ-Kf; Fri, 04 Oct 2024 16:02:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swisp-00AhcU-1j;
	Fri, 04 Oct 2024 16:02:15 +0200
Date: Fri, 4 Oct 2024 16:02:15 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Message-ID: <Zv_1ZzwQJ-P36mt6@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
 <f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
 <20241003102806.084367ba@kmaincent-XPS-13-7390>
 <f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
 <20241003153303.7cc6dba8@kmaincent-XPS-13-7390>
 <4b9d1adf-e9bd-47c0-ac69-5da77fcf8d0b@lunn.ch>
 <Zv_0ESPJgHKhFIwk@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv_0ESPJgHKhFIwk@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Oct 04, 2024 at 03:56:33PM +0200, Oleksij Rempel wrote:
> On Thu, Oct 03, 2024 at 05:22:58PM +0200, Andrew Lunn wrote:
> > > Indeed, but regulator API already provide such events, which will even be sent
> > > when we enable or disable the PSE. Should we write a second event management.
> > > Using regulator event API allows to report over current internal events to the
> > > parents regulator the power supply of the PSE which could also do something to
> > > avoid smoke.
> > > 
> > > Or maybe we should add another wrapper which will send PSE ethtool netlink
> > > notification alongside the regulator notifications supported by this patch.
> > > 
> > > > Also, how do regulator events work in combination with network
> > > > namespaces? If you move the interface into a different network
> > > > namespace, do the regulator events get delivered to the root namespace
> > > > or the namespace the interface is in?
> > > 
> > > regulator events are sent in root namespace.
> > 
> > I think we will need two event, the base regulator event, and a
> > networking event. Since it is a regulator, sending a normal regulator
> > event makes a lot of sense. But mapping that regulator event to a
> > netns:ifnam is going to be hard. Anything wanting to take an action is
> > probably going to want to use ethtool, and so needs to be in the
> > correct netns, etc. But it does get messy if there is some sort of
> > software driven prioritisation going on, some daemon needs to pick a
> > victim to reduce power to, and the interfaces are spread over multiple
> > network namespaces.
> > 
> > What i don't know is if we can use an existing event, or we should add
> > a new one. Often rtnetlink_event() is used:
> > 
> > https://elixir.bootlin.com/linux/v6.12-rc1/source/net/core/rtnetlink.c#L6679
> > 
> > but without some PSE information in it, it would be hard to know why
> > it was sent. So we probably either want a generic ethtool event, or a
> > PSE event.
> 
> Hm... assuming we have following scenario:
> 
>                                   .---------   PI 1
>                                  / .---------  PI 2
>                    .========= PSE /----------( PI 3 ) NNS red
>                   //              \----------( PI 4 ) NNS blue
> Main supply      //                `---------( PI 5 ) NNS blue
> o================´--- System, CPU
> 
> In this case we seems to have a new challenge:
> 
> On one side, a system wide power manager should see and mange all ports.
> On other side, withing a name space, we should be able to play in a
> isolated sand box. There is a reason why it is isolated. So, we should
> be able to sandbox power delivery and port prios too. Means, by creating
> network names space, we will need a power names space. 
> 
> I can even imagine a use case: an admin limited access to a switch for
> developer. A developer name space is created with PSE budget and max
> prios available for this name space. This will prevent users from DoSing
> system critical ports.
> 
> At this point, creating a power name space will an overkill for this
> patch set, so it should be enough to allow controlling prios over
> ethtool per port and isolation support if needed.

Oh, sorry, i'm too tired. Too many words are missing in my answer ...

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

