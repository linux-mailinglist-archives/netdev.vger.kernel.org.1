Return-Path: <netdev+bounces-131655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEB98F275
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B453280CFD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343931A0708;
	Thu,  3 Oct 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ApJFzrcO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642219B3EC;
	Thu,  3 Oct 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968994; cv=none; b=KICCN9pTzx/sEPdDJ/LaReynAHjjhscInNugH1wDjGaXmKfuFyloBNVSW6LVYDVzbjm4/m9nvbxHCMtA55TGZs2biIwkUkUkBbpLRVUZL+TdiBFIBqKZYbGQi1/TVw0NvT/zEolPicMId72bFYq16r9LpUuvkHq5Pq80sES5MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968994; c=relaxed/simple;
	bh=asz9dVozoErgq27bpc5UY/I+4Coq+Ol2cdNSR2sBGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLL5l73h2vHmtM4pEqrQc7ZMPOD+M5RqALz6DfgZehwOsFMXB2QiX1A7kx4ZAazmgb0jI5Ntj2HOWREkqL8qE7Z1WRQxaDmSIfdbDkh5jm0zAtSPArcWd2puGFuMQU4MvpzamsoG2WSLgiOSmG9j3SxOsxWKcToPNE6w4qsGA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ApJFzrcO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bu+7udGachSDOwzt9lN48RPmgsVsfzke/QAVauZ/lfQ=; b=ApJFzrcOE37Y0DIvoNtFYVV/p7
	ULeH4F/1DhOierXGFTQLkKbSaHZMSe+yUPX6PPGlYC9pejOhQvcllNOwEmD9eT3fwqn5clg7Jy5+R
	rJLL4CTLTkulm9KYfohCXx9R91sG/OFo6+tI6BCDi77C7b2cjFbag/agl5dJNYb+C/GE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swNfO-008xUC-5r; Thu, 03 Oct 2024 17:22:58 +0200
Date: Thu, 3 Oct 2024 17:22:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <4b9d1adf-e9bd-47c0-ac69-5da77fcf8d0b@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
 <f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
 <20241003102806.084367ba@kmaincent-XPS-13-7390>
 <f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
 <20241003153303.7cc6dba8@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003153303.7cc6dba8@kmaincent-XPS-13-7390>

> Indeed, but regulator API already provide such events, which will even be sent
> when we enable or disable the PSE. Should we write a second event management.
> Using regulator event API allows to report over current internal events to the
> parents regulator the power supply of the PSE which could also do something to
> avoid smoke.
> 
> Or maybe we should add another wrapper which will send PSE ethtool netlink
> notification alongside the regulator notifications supported by this patch.
> 
> > Also, how do regulator events work in combination with network
> > namespaces? If you move the interface into a different network
> > namespace, do the regulator events get delivered to the root namespace
> > or the namespace the interface is in?
> 
> regulator events are sent in root namespace.

I think we will need two event, the base regulator event, and a
networking event. Since it is a regulator, sending a normal regulator
event makes a lot of sense. But mapping that regulator event to a
netns:ifnam is going to be hard. Anything wanting to take an action is
probably going to want to use ethtool, and so needs to be in the
correct netns, etc. But it does get messy if there is some sort of
software driven prioritisation going on, some daemon needs to pick a
victim to reduce power to, and the interfaces are spread over multiple
network namespaces.

What i don't know is if we can use an existing event, or we should add
a new one. Often rtnetlink_event() is used:

https://elixir.bootlin.com/linux/v6.12-rc1/source/net/core/rtnetlink.c#L6679

but without some PSE information in it, it would be hard to know why
it was sent. So we probably either want a generic ethtool event, or a
PSE event.

    Andrew


