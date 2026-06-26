Return-Path: <netdev+bounces-302161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W9MCFkJzPmpUGQkAu9opvQ
	(envelope-from <netdev+bounces-302161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:40:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD96CD147
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=DadMQrqy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302161-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92127301A917
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94C3EB119;
	Fri, 26 Jun 2026 12:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA06369D64;
	Fri, 26 Jun 2026 12:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477615; cv=none; b=pSHrUjE3uZO8oYpGwupR+hu8fIDmcA+N1/0Yht1ODtiqrawtLsmT1KMcvK3OKEheijJjSlo0l5bhd1nxIAe6xYbrPj63P3BA0lMuHaDhkgqNHKPuMNOczHNfO07UfKhu8vk6nljCRpgsHbwZz15+capQZ7sbIaEGbKz1V1+Q/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477615; c=relaxed/simple;
	bh=OVxZMbiaQlrp+L2yCRrOoOuGO6RSDY2XFX6v4SFoZGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyURfstK1L/CqtvonORKA/Qy20I9R4d5QarDLYI5Wx5Xf7sVm7d57x4kep45EMBiJNtbrKMwfSBpCEIQLTLuCv7V5WHJMqLlggox32OBnyGCl8Vq3I82zFMbqhmnNofzSyOF+zcdTQ4YAZkgdWLZgOMghwgckkIeKz5ubbGxP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DadMQrqy; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=20j2IfcmT+en6mrD70QCKDlefTLZF8HYkqHZlLQLew0=; b=DadMQrqy5iHANxOAA5Spl1ZGFC
	ku2c0vrkmAZkVyLQCuWXg4tIWt4WdW67i8bWp5ZtF9oQag5luroOiWm4m2aSJU58f+yz5ZacuxiNq
	BTFhUmE+OL439ChDNM8zIyGmJzz2LFZBDgfCqfLzmgco+8SGoNNno8XRus7HC9bTV5uQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd5qf-009MzV-VT; Fri, 26 Jun 2026 14:39:57 +0200
Date: Fri, 26 Jun 2026 14:39:57 +0200
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
Message-ID: <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
 <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
 <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302161-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2DD96CD147

On Fri, Jun 26, 2026 at 10:33:50AM +0200, Maxime Chevallier wrote:
> 
> > Sphinx follows pythons object orientate structure. So you could have a
> > class test_ethtool_pause_advertising, with class documentation. And
> > then methods within the class which are individual tests.  The
> > commented out section would then be method documentation.
> 
> Good point, so maybe something along these lines :
> 
>  - A class for the test
>  - methods for indivitual tests
>  - For readability, I've written what the internal test helper would look
>    like (_adv_test), and how a test would look like without the helper in
>    adv_rx_on_tx_on().
> 
> I'm already diving into coding, but it helps me a bit in the definition of the
> "description" format :)
> 
> this is what the class would look like :

I like this :-)

> 
> 
>     @ksft_ethtool_needs_supported_allof([Pause])
>     def adv_rx_on_tx_on(cfg, peer) -> None:

Using decorators is a nice idea. Since it is not a C concept, please
give the decorator a good comment explaining what it does. We should
not assume driver developers know python.

>         """Advertising test with rx on tx on
> 
>         - run 'ethtool -A ethX rx on tx on autoneg on'
>         - FAIL if the return isn't 0
>         - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
>           "Pause" or contains "Asym_Pause"
>         - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
>           "Asym_Pause"
>         - Succeed otherwise
>         """
>         ret = cfg.run('ethtool -A ethX rx on tx on autoneg on')
>         ksft_eq(ret, 0)
> 
>         linkmodes = cfg.get_advertising()
>         ksft_in('Pause', linkmodes, "rx on tx on must advertise Pause")
>         ksft_not_in('Asym_Pause', linkmodes, "rx on tx on must not advertise Asym_Pause")
> 
>         remote_linkmodes = peer.get_lp_advertising()
>         ksft_in('Pause', linkmodes, "PHY does not advertise Pause")
>         ksft_not_in('Asym_Pause', linkmodes, "PHY incorrectly advertises Asym_Pause")

There should be a sleep in here somewhere, to allow the autoneg to
complete.

	Andrew

