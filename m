Return-Path: <netdev+bounces-264048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICk2On6mqGkYwQAAu9opvQ
	(envelope-from <netdev+bounces-264048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:39:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC5208094
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12727301CC42
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F23932E2;
	Wed,  4 Mar 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XR2PIT4Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057E3822BD;
	Wed,  4 Mar 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660347; cv=none; b=bKXk/qlbP9JSXnhsgNr7tys6+Et4PKxJzVsU7pOx1jZ4s+jU3UQ21+DRHhFB75q6mqhtlV8dcXVse9Xxrmb8C1ZzQ/K9PSmd71VuKr3bo1XEBR6hgesvKDR9fMPRzb4bvVoBfD88p1m31i7IOQPYWJjVT+LxonIz+8q4q51Wo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660347; c=relaxed/simple;
	bh=kZqKu8Q3HVNIal07DuJIyN1zu3R45CNMJ7csG5g7LEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hqhku4Y+xmY5UVZt3Y3e4/lDkem7L0uJ+6qPhq/bQtHFx3GPkmaKwgWuIfYM6hSPvdy7cwcXfsjDLdUqchKPyriqqlaD9zOWfvzKw2nKxuAqLTiiff9o+60pNFATM+JMKLGhTA2s4VR6QnVquGaq3gX8iSiiWJ+fbcTAwZkaBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XR2PIT4Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PQNIKgK+s1Hm4hxWnJCY1K4WoMHACQn7mWMe/0TAztE=; b=XR2PIT4ZaGssLFN5oQg7obFT92
	86lxVACR8TVzy49s7lVuRzmJZTRQWZKVQJrNVaS2uWBh6qs0+By7os/n3jNyziQtm0rz3GdytcSlJ
	vUNwxN9e0BJCYStWIDJ2EH0D9kgoHc0Y4J8BIFXu4QiUmnsn5MZtoJlA7oGB1Xd8mDJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxtvi-00AB3c-1g; Wed, 04 Mar 2026 22:38:54 +0100
Date: Wed, 4 Mar 2026 22:38:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Brown <broonie@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <6b4bfb6a-d279-44bd-9110-6d2dc67d8020@lunn.ch>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
 <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
 <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
X-Rspamd-Queue-Id: 66FC5208094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264048-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,wikipedia.org:url]
X-Rspamd-Action: no action

> For SFP my understanding is that SFP has a physical specification which
> includes power inputs and that these supplies are being requested by the
> devices that consume them.  If some part of that is not the case then it
> sounds like the bindings aren't describing the hardware (or at least are
> a bit unclear about how they're doing so) and should be revised.  The
> series doesn't seem to do anything at all with the supply side either,
> I'm guessing there are some SFP controllers with integrated power
> provisioning.

There is not really an SFP controller.

SFPs really break up into two parts, because they are
hot-pluggable. There is a cage, which is mounted on the board, and a
module which is inserted into the cage. The cage is passive.

https://en.wikipedia.org/wiki/Small_Form-factor_Pluggable gives a
reasonable overview.

The cage provides the module with power, 3.3v, max 300mA for Rx and
the same for TX. Something must supply the cage, and most designs just
connect the cage to the board power rails. The example give in
Multisource Agreement does exactly that, with some capacitors and
inducters to limit surge on hot plug.

This is the first board since 2017, when support for SFPs was added,
which can actually control the power supplies. We cannot make
regulators mandatory without breaking backwards compatibility.

So for me, the patch is good as it is now, the regulators are
optional.

   Andrew


