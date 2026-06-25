Return-Path: <netdev+bounces-302011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 40eWMopNPWoG1AgAu9opvQ
	(envelope-from <netdev+bounces-302011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:47:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DD6C7281
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=G23Ure3i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302011-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7942D301A341
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DD246BD5;
	Thu, 25 Jun 2026 15:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B5288BA;
	Thu, 25 Jun 2026 15:46:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402418; cv=none; b=TTdFQyyCaLtJYV0uTA+oJwfXGIw3LersY4f1cIOAaWNTqVrEeFOAC5HxL6/+503/4Eau9HM1xN9RsLSqQQntikYS2kh4U3YGBkaUORpQ3ECioZsDm/Q4BT3HKzyrZAqCZ5VRM6DYHzXBEb15yy1gvqTXxwhEmJn7S3ePKphFFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402418; c=relaxed/simple;
	bh=ODT3avnaz7oswxFIAEftgyw6Ekn3mLA617/3LAFnmss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHDqNknnpevy3Weanpfc8YKNH4Ll4l4hmkZkuIxMiHu1hPJ1u+9xr8Dtk8nDsIpBDhVhhufk6b1tBDMKxhIyeBIgmy1aKYQdfFPgehfrwhVm+ar7qi7gZAjjWpv9IxDldI2rZoPULknSoXjLoqH4zmcuMBVlqsOVKsp2t/FLd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G23Ure3i; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qrO5XXovPTROcUSGPMbOtwQSRtRpLmvYd6OF+atbOVI=; b=G23Ure3iixNMBidJD6bxmgYPpY
	h5lNUpnidpt6D9Cl1Mq1rVJLHnqvcb/O0xFlMLVaVSGKnqpiJpupJDV4Vdk1stIZxmxEziDuZV4VB
	hKDYEUPvguhf4BnY+R++oXngbtwB17UJgjfGR82NnJvIP2TnWbcI0ZgW8q9GmsFRivGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcmHf-009G1T-V5; Thu, 25 Jun 2026 17:46:31 +0200
Date: Thu, 25 Jun 2026 17:46:31 +0200
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
Message-ID: <dfee1484-fa2a-4b98-af5a-1e67ac716905@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
 <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
 <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
 <7a88fee8-bbb3-480f-9c93-677b7270a940@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a88fee8-bbb3-480f-9c93-677b7270a940@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302011-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C25DD6C7281

On Thu, Jun 25, 2026 at 12:46:44PM +0200, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On 5/29/26 14:59, Andrew Lunn wrote:
> 
> (This discussion was a while ago, but this bit of context should be enough)
> 
> > But we also need to consider that for some APIs, we have decided that
> > a configuration can be set now, which does not actually apply in our
> > current conditions, but it will be stored away for when conditions
> > change and it is applicable. The half duplex case could fit that. When
> > the link is currently half duplex, you can configure pause, but you
> > don't expect it to actually change the current behaviour. It only
> > kicks in when the link renegotiates to full duplex sometime in the
> > future. We have to also consider this the other way around. The link
> > is full duplex and pause is configured by the user. Something happens
> > with the LP and the link renegotiates to half duplex. The local end
> > should not throw away the configuration, it simply cannot apply it
> > given the current situation.
> 
> I'm writing the test description for HD with a better formatting, so the
> HD test wouldn't be about "are we using pause stuff while in HD" as it
> doesn't make sense, but rather "do we correctly store the pause settings
> aside for later".

O.K.

> I'm realising that we don't really have an API to report the *true* in-use pause
> settings. Taking HD as an example :
> 
> # ethtool -s eth2 duplex half
> 
> [588209.379363] mvpp2 f4000000.ethernet eth2: Link is Up - 100Mbps/Half - flow control off
> 
> # ethtool eth2
> 	[...]
> 	Supported pause frame use: Symmetric Receive-only
> 	Advertised pause frame use: Symmetric Receive-only
> 	Link partner advertised pause frame use: Symmetric Receive-only

Does it even make sense to advertise this when in HD? But i don't
think we need to consider this now. I consider HD low priority, i
doubt it is actually used very often. We should concentrate on FD
testing.

> # ethtool -a eth2
> Autonegotiate:	on
> RX:		off
> TX:		off
> RX negotiated: on
> TX negotiated: on
> 
> 
> Sure, pause and HD don't make sense, however what I find confusing to some
> extent is that the only place we have information about the *actual* pause
> settings is the "link is Up" log in dmesg.

Maybe we should extend ksetting get to return the resolved pause
parameters? But i'm not sure how much that actually gives us. Anything
using phylink will just ask phylink to fill in the ksettings
information, and it seems unlikely phylink gets it wrong. What we are
really trying to test is drivers which don't user phylink, those are
the ones which are generally broken, and they are not going to
implement anything new in ksettings. So i think the test has to look
at:

> 	Advertised pause frame use: Symmetric Receive-only
> 	Link partner advertised pause frame use: Symmetric Receive-only

and check these match what we expect.

    Andrew

