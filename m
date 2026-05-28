Return-Path: <netdev+bounces-292507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COgsM0aXF2opKggAu9opvQ
	(envelope-from <netdev+bounces-292507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:15:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4695EB84C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6A5305D6CD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B722745E;
	Thu, 28 May 2026 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tNZnzS+Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097B233922;
	Thu, 28 May 2026 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930946; cv=none; b=JvC14gTzajU7Z+T/9C2Mus7ASon+mz0zJ5LQiwuYE63YCcrWaq0GISG1fwQdMbGrxfsdU1CcWHXVcu5yWE4Zqzk6x8Yqpmf4U2mJULAJFp6ay78olZBhQJVvFmIk3VHPrSqCdXO7aSEiLW4wYJYqQ2lv6XUmLERhHqhh3lNBHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930946; c=relaxed/simple;
	bh=CE96iTM7gITR4S3f5JVNJDF/jRwOEjFQInUIDansplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQerzT6M6PcforJZ1xtZYShfbISoB89ZSGy4O8qAi0HFmhqS+LCftq7Zxjr0qcCYrT2/4IuNz8sY3sadcx8LpXgQ7A3TvSc2+gk0jmcnjWX/K2DRYIo+aXDd6rhGQf7ZcEen2gl398lzWN3sjlBkxLigHB/sbdfZ1aeryHRCG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tNZnzS+Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6kBS55w8EuZAby4USjIyUN/gnQ2xiZZy0k+CIx/45ME=; b=tNZnzS+QVpXbJWpuxuNevgjKlp
	6fGyi/i8ieycrgP2nHQZO1VUxE23LY+xJYWaBun8E78UdCxFMGiafIP+foz547t6hHKzff2hQ3heD
	Ii+5tYvqhbRqAydgiLmtyZ1Ijo0+EUdkyD6prh+Ko7oMhF4FWuTg+Tffk8uqrEOT9rDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSPLH-004puy-PH; Thu, 28 May 2026 03:15:23 +0200
Date: Thu, 28 May 2026 03:15:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292507-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F4695EB84C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +A.1 : Sanity Checks
> +~~~~~~~~~~~~~~~~~~~
> +
> +Pause autoneg is set to off::
> +
> +  ethtool -A <iface> autoneg off
> +
> +The 'supported' fields retrieved using the ETHTOOL_MSG_LINKMODES_GET includes
> +a "Pause" bit and an "Asym" bit.
> +
> +The ETHTOOL_MSG_PAUSE_GET command returns the currently configured pause modes
> +in the "tx" and "rx" attributes.

What you have left unspecified here is the state a link autoneg,

ethtool -s <iface> autoneg on|off

At minimum, it should be specified. I've not read the other tests yet,
but we may also want to run this basic test with both possible
setting.

One possible bug which we are trying to detect is that pause autoneg
is off, the values are forced, but -s autoneg is on, it completes, and
overwrites the forces values with negotiated values.


> +A.2 : Half-duplex operation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Pause settings as exposed with the ethtool API only concern full-duplex modes.
> +
> +Test scenario:
> +--------------
> +
> +Set the interface under test in half-duplex mode with::
> +
> +  ethtool -s <iface> duplex half
> +
> +Expected behaviour::
> +
> + - ethtool <iface>
> +
> +shows no Pause settings advertised.

Since we are talking about advertisement of pause, i think you actually want

ethtool -A <iface> autoneg on
ethtool -s <iface> duplex half autoneg on

If -s autoneg is off, nothing should be advertised. So we need that
turned on. And if -A autoneg is off, no pause values should be
advertised, so you need that turned on as well.

Also, since we expect this to trigger an autoneg, we probably want a
sleep(2) in there before looking at the results, to ensure autoneg has
completed.

There is also the possibility that the link does not come up, because
the link peer does not support half duplex. This is quite common for
1G interfaces. It could also be the local interface does not support
1G half. So maybe 

ethtool -s <iface> duplex half speed 100 autoneg on

Or let it first autoneg unrestricted, look at both the local and LP
values, and pick a half duplex link mode both support and set it to do
that?

The tests defined so far also don't cover all the possible settings of
-A autoneg and -s autoneg. There are combinations:

Link autoneg with pause autoneg
Link autoneg with forced pause
Force link, with forced pause

It would be good to consider what can be tested for these three. Maybe
nothing can be tested with forced link, because that it likely to
result in no link, when only the local side can be configured.

> +B : Combined devices testing
> +============================
> +
> +Requirements : The interface under test must be connected to a link-partner that
> +can be actively configured during the tests. It must at least support full-duplex
> +modes, and optionally (but ideally) symmetric and asymmetric flow-control, as
> +well as autonegotiation of the Pause parameters.

and forced link parameters.

> +
> +B.1 : Autoneg advertising
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Goal: Validate that the *advertised* Pause and AsymDir bits match the configured
> +pausemarams.

typo.

> +
> +The link-level autonegotiation must be enabled::
> +
> +  ethtool <iface> autoneg on
> +
> +Pause parameters are set with::
> +
> +  ethtool -A <iface> rx <val> tx <val> autoneg on
> +
> +Pause advertising is retrieved with::
> +
> +  ethtool <iface>
> +
> +Case 1
> +------
> +
> +Pause parameters : rx **off** tx **off**
> +
> +Expected advertisement : **None** (Pause = 0, AsymDir = 0)
> +
> +Case 2
> +------
> +
> +Pause parameters : rx **off** tx **on**
> +
> +Expected advertisement : **Transmit-only** (Pause = 0, AsymDir = 1)
> +
> +Case 3
> +------
> +
> +Pause parameters : rx **on** tx **off**
> +
> +Expected advertisement : **Symmetric receive-only** (Pause = 1, Asymdir = 1)
> +
> +Case 4
> +------
> +
> +Pause parameters : rx **on** tx **on**
> +
> +Expected advertisement : **Symmetric** (Pause = 1, Asymdir = 0)

We should consider here what happens when the local side only supports
symmetric pause. We would expect EOPNOTSUPP, or maybe EINVAL. If
ethtool report:

	Supported pause frame use: Symmetric Receive-only

not getting an error for the asymmetric settings would be a bug.

> +
> +B.2 : Autoneg resolution
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Goal: Validate that the Pause and AsymDir negotiation translates to the right
> +TX and RX pause parameters.
> +
> +The following table, from the 802.3 standard, exposes the autoneg resolution
> +result for the advertised pause parameters by each link partner.
> +
> ++-------------+--------------+--------------------------+
> +|Local device | Link partner | Pause settings resolution|
> ++------+------+-------+------+-----------+--------------+
> +|Pause | Asym | Pause | Asym | RX        | TX	        |

There is a tab vs space issue here.


> ++======+======+=======+======+===========+==============+
> +| 0    | 0    | Any   | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 0     | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 1     | 0    | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 0    | 1    | 1     | 1    | No        | Yes          |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 0    | 0     | Any  | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | Any  | 1     | Any  | Yes       | Yes          |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 1    | 0     | 0    | No        | No           |
> ++------+------+-------+------+-----------+--------------+
> +| 1    | 1    | 0     | 1    | Yes       | No           |
> ++------+------+-------+------+-----------+--------------+
> +
> +The mapping between the configured pause parameters and advertised modes follow
> +the following truth table :
> +
> ++----+----+-------+---------+
> +| tx | rx | Pause | AsymDir |
> ++====+====+=======+=========+
> +| 0  | 0  | 0     | 0       |
> ++----+----+-------+---------+
> +| 0  | 1  | 1     | 1       |
> ++----+----+-------+---------+
> +| 1  | 0  | 0     | 1       |
> ++----+----+-------+---------+
> +| 1  | 1  | 1     | 0       |
> ++----+----+-------+---------+
> +
> +We can boil that down to the following cases to test, keeping the number small
> +to avoid dealing with the whole combinatory::

Why not do the whole set of combination? There are 16 combinations,
autoneg takes a little over 1 second, so we are probably talking 32
seconds in total. That is a reasonable runtime for a test.

> +Case 1
> +------
> +
> +Local device : rx **off**, tx **off**
> +Remote device : rx **on** tx **on**
> +
> +Expected result on local device after autonegotiation completes :
> +        rx negotiated **off**
> +        tx negotiated **off**
> +

...

> +Case 7
> +------
> +
> +Local device : rx **on** tx **on**
> +Remote device : rx **off** tx **off**
> +
> +Expected result on local device after autonegotiation completes :
> +        rx negotiated **off**
> +        tx negotiated **off**
> +
> +Case 8
> +------
> +
> +Local device : rx **on** tx **on**
> +Remote device : rx **off** tx **on**
> +
> +Expected result on local device after autonegotiation completes :
> +        rx negotiated **on**
> +        tx negotiated **off**

what also needs to be considered here is:

What if the local side only supports symmetric pause?
What if the LP only supports symmetric pause?

The expect results should take this into account, that the
configuration fails, but that is not a test failure, just a hardware
limitation.

> +
> +B.3 : Pause Autoneg
> +~~~~~~~~~~~~~~~~~~~
> +
> +Goal: Validate that the Pause autonegotiation flag correctly toggles the
> +advertised Pause and AsymDir link parameters.
> +
> +Test scenario:
> +--------------
> +
> + - Enable pause autoneg and at least rx or tx pause::
> +
> +        ethtool -A <iface> rx on tx on autoneg on
> +
> + - Check the Advertised pause frame use::
> +
> +        ethtool <iface>
> +
> +        ...
> +        Advertised pause frame use: Symmetric Receive-only
> +
> + - Disable pause autoneg::
> +
> +        ethtool -A <iface> autoneg off
> +
> + - Check the Advertised pause frame use, which must be 'No'::
> +
> +        ethtool <iface>
> +
> +        ...
> +        Advertised pause frame use: No

Please describe configuration for both sides. This is needed for all
the tests when there are two devices involved.

Also, when local pause advertisement is turned off, check what the
link partner is reporting it received from its link partner.

	Andrew

