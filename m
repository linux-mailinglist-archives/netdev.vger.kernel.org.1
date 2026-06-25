Return-Path: <netdev+bounces-302028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gZQPOARUPWqw1QgAu9opvQ
	(envelope-from <netdev+bounces-302028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 510416C762B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:15:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=wPPmattY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302028-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302028-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE2F30078B0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961733E717F;
	Thu, 25 Jun 2026 16:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B13E7BA6;
	Thu, 25 Jun 2026 16:12:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403955; cv=none; b=mJ/zBE81WC7hOmIfN3mWymhbY0MkbmOKNrqSKytvC592EW68Ey2DniUYAWkulayd5hdtjylx4Hjv9NLfjKeGmmOzb3P91fzkWPFx09AfeUHq0KJPHJGaERVQ3OYXBGlYohjkifl8g/WV4w9vWw1euG2TkfD0EnOxa9oCWBx5y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403955; c=relaxed/simple;
	bh=nuEQl8tmi4PUjefQwgETQMtKZH+Awnmm7DZAsMlhLuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4JW/OmYDpAoAT8XWsM2ZeWizZj1+7G+GJ3IfPC5mGJ962OFYv3LDB1V3z5uVM0R0fAyjSR30DQZ1kLc+MhQWH8CP9Rt2mqJ/fWKR7vo5fO0ho4rDj2Spg8yOVWHKQHxvBG3KSMmHkohp+nKzYsdFQp17MxwSeLcE9T5AfE8eHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wPPmattY; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SjSnpDcd/nnOyv3A51l5TDSAZxIAPfoeJIYXW95Ak+g=; b=wPPmattY9V9C7LKAFqV+sEQJTv
	1hN2Un6obtE1QG8nfATQkbhpbNtZ5BWRfdLF1Yr+nGGQSC+xkVqNt5/HaJBGqEVycgxD71a8VrWv7
	tD+/0xcNutB0wwxZOaLmm09N9BlJNH/Ah19tSghjjSkWkfcugVlJJr6WPThNTKlUNL18=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcmgf-009GEq-Sr; Thu, 25 Jun 2026 18:12:21 +0200
Date: Thu, 25 Jun 2026 18:12:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
Message-ID: <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 510416C762B

> This isn't sphynx, but I've come-up with something like this for a
> test definition :
> 
> 
> @ksft_ethtool_needs_supported_anyof([Pause, Asym_Pause])
> def test_ethtool_pause_advertising(cfg, peer) -> None:
>     """Pause advertisement
> 
>     Validate that changing pause params through the ETHTOOL_MSG_PAUSE command
>     translates to a change in the advertised pause params, and that these
>     parameters are correct w.r.t the supported pause params and requested pause
>     params.
>     
>     This exercises the .set_pauseparams() ethtool ops for MAC configuration,
>     as well as the reconfiguration of the PHY's advertising and negociation.
>     
>     On non-phylink MACs, the MAC should call phy_set_sym_pause() to update the
>     PHY's advertising, and restart a negotiation with phy_start_aneg() if
>     need be. Failure to do so will result on the wrong advertising parameters.
>     
>     Pn phylink-enabled MACs, phylink deals with the PHY reconfiguration provided

On 

>     the MAC driver calls phylink_ethtool_set_pauseparam().
>     
>     Failing this test likely means that the PHY driver is not correctly advertising
>     pause settings, either due to the MAC not triggering a PHY reconfiguration,
>     a misconficonfiguration of the advertising registers by the PHY, or by
>     mis-handling the phydev->advertising bitfield in the PHY driver directly.
>     
>     The validation is made by looking at the advertised modes locally, as well as
>     what the peer's 'lp_advertising' values report.
> 
>     cfg -- local device's interface configuration
>     peer -- peer device handle

Plain Sphinx can be made to pick up this method documentation and
include it the generated documentation. You would use something like

.. automethod:: test_ethtool_pause_advertising

in the .rst file.

I've no idea if the kernel configuration of sphinx allows this. At the
moment, i would not spend too much time on getting sphinx to generate
documentation. I would say that is nice to have. The description
itself is more important.

>     """
> 
>     # Initial conditions :
>     # - Local interface is admin UP, and reports lowlayer link UP
>     # - Remote interface is adming UP, and reports lowlayer link UP
>     #
>     # Test 1
>     # - SKIP if supported doesn't contain "Pause"
>     # - run 'ethtool -A ethX rx on tx on autoneg on'
>     # - FAIL if the return isn't 0
>     # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
>     #   "Pause" or contains "Asym_Pause"
>     # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
>     #   "Asym_Pause"
>     # - Succeed otherwise
>     #
>     # Test 2
>     # - SKIP uif supported doesn't contain both "Pause" and "Asym_Pause"
>     # - run 'ethtool -A ethX rx on tx on autoneg on'
>     # - FAIL if the return isn't 0
>     # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
>     #   "Pause" or contains "Asym_Pause"
>     # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
>     #   "Asym_Pause"
>     #
>     # ...
>    
> The annotation defines the pre-requisites in terms of locally supported
> linkmodes, we have a docstring containing information for developpers
> to debug their drivers, what I'm unsure about is the commented-out part
> below, so either one big function testing multiple adjacent scenarios
> or indivitual functions.

Sphinx follows pythons object orientate structure. So you could have a
class test_ethtool_pause_advertising, with class documentation. And
then methods within the class which are individual tests.  The
commented out section would then be method documentation.

However, i've no idea if the selftest code allows for classes of test
methods? It looks like ksft_run() takes a list of methods. So you can
probably instantiate the class, and then pass it methods from the
class?

I would say you are right about picking one of the simple test case,
and playing with it, define and implement it, and see what comes out
at the end. 

	Andrew

