Return-Path: <netdev+bounces-131600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF398EFCF
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7CB24778
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA544197A65;
	Thu,  3 Oct 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="chmzQF+u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB60148823;
	Thu,  3 Oct 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960194; cv=none; b=hL4cMtaKkZw/iqEcc9qp6+YfB5QQVai+5jm+IV3PSL2GV8cB/OcO829IXc9+hKxXUiHSslcUMgKG8GPdrZOUipMQ57uupcx7DTWUyfuPjBxKuzPEqqraO+vjtuYPnCi76LXA2T2rp9pTXb0qScNaJR2Uh0FHYhSILxLV3mna4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960194; c=relaxed/simple;
	bh=ELbGgK1SSotfZBZJN05coeserexfapnZur2lQCKI0Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqNUqoOOWlkUfM6E74gylT0p2uk9FIoqf5VUrVOr8Gbd7HkKOYzdXHfW+8L8fJYdKDP8S+GzMAZYJjg7l7r7PiuRIkAWyHp7xuvFtDOd47gDCwBDs6t6sR/7ORYDUGyE2oGA3w0JkHMZRSztaU2texc/2aYUZ2dlgekTpSDHbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=chmzQF+u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QEN15Fs7xG8c1IcYMNSytb5HdDJacf/jlhNpjv/rApk=; b=chmzQF+uywZf3/gMS8CSot6YUp
	jNfvb+AOuQnR9tMvMf3wyFJFtZKnASXTcRRJF4tLBbqbHS53RS7pNYFD87oCRJ5NbaWcK8xSsc1Jx
	GA0bjwb0h+ZGv+KkcO6TPoVjkYpZnNgfMYcpMY8ymcQ+HjlJTlwHK6VaOezNIm6crUUY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swLNV-008wlN-96; Thu, 03 Oct 2024 14:56:21 +0200
Date: Thu, 3 Oct 2024 14:56:21 +0200
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
Message-ID: <f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
 <f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
 <20241003102806.084367ba@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003102806.084367ba@kmaincent-XPS-13-7390>

> > https://docs.kernel.org/power/regulator/consumer.html#regulator-events
> > 
> > Suggests these are internal events, using a notification chain. How
> > does user space get to know about such events?
> 
> When events appears, _notifier_call_chain() is called which can generate netlink
> messages alongside the internal events:
> https://elixir.bootlin.com/linux/v6.11.1/source/drivers/regulator/core.c#L4898

Ah, O.K.

But is this in the correct 'address space' for the want of a better
term. Everything else to do with PSE is in the networking domain of
netlink. ethtool is used to configure PSE. Shouldn't the notification
also close by to ethtool? When an interface changes state, there is a
notification sent. Maybe we want to piggyback on that?

Also, how do regulator events work in combination with network
namespaces? If you move the interface into a different network
namespace, do the regulator events get delivered to the root namespace
or the namespace the interface is in?

	Andrew

