Return-Path: <netdev+bounces-302006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZsRIWpJPWpP0wgAu9opvQ
	(envelope-from <netdev+bounces-302006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:29:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334076C710D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="LUTqox/R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302006-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A48FD3049E0B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03A3E835F;
	Thu, 25 Jun 2026 15:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25783E8321;
	Thu, 25 Jun 2026 15:29:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401378; cv=none; b=KSeS05Y1JeC6dmwHcrXRNHCfa9bLJgsDHEHtzshuS3VFQiH3oMdK0L6NJen+MPFML5PQf/qI3ZPdwp4bHW9eVCkbLaEB3F3kc6FZhg6K9Lm1vW2FDfvXxW8C4ex3Bngz0ZD2DbIc1FmoW/rw5s9nZU4H9MH0cMuH+pOU0gyQFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401378; c=relaxed/simple;
	bh=9qnepkFYV8JpT0R+WCOwV/NO7C2ZhGyacdhokBHqAxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrtN/4JWkEJFYOD2aVWJQkKBt91sDSmdJkMkGaEdfBieSESyAw7yBjIQDR2sRVVzivMzOD4deORe8r8C9wijAUp8MHKMBWxX8DOENIr0Yf62Uvt4rL7hw5wG0ZBzVj7K2mnghwmMOiaZUU/iDZpk1B2iM3yPAP7268qU5LMA0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LUTqox/R; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 561441A0996;
	Thu, 25 Jun 2026 15:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1406B5FF03;
	Thu, 25 Jun 2026 15:29:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84DEE104C8392;
	Thu, 25 Jun 2026 17:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782401372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4Viu3OpkamDZjnNOfz+R+bFCVzP7fjIDEzbr6zL3TWI=;
	b=LUTqox/RCvwCVLBjaXIWJfnO1G7LKJSBYExR7PiTQh10Un5gstEMJhnAQkggDUnXFMNras
	A31yvKQDR6wju4jFRVszG03x4B/VlPiKKDFFuW3qxT7260ycDbBf6GaG6Yuij1EF4j5D7z
	Yv9RHjXvsZ+pvSgg9w9yEx2f8fHVujGxuvLJiF2QbCCFzT7CaIN0GIn9g6tgHL/uKJCH07
	+C1W+gABl80mTzH33tHI4C0YrxsXt6LcUhkhk0Y5XPKr/SJCRChajfPv0vGosehAayOHxa
	gdrpNxbcaFSs/zmrhOZFMB3jhQAj+3o5H4zI7tkhl/KW2oN67fXjCHzurTfCnw==
Message-ID: <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
Date: Thu, 25 Jun 2026 17:29:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302006-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 334076C710D

Hi Andrew,

On 5/27/26 04:47, Andrew Lunn wrote:
> On Tue, May 26, 2026 at 05:24:47PM -0700, Jakub Kicinski wrote:
>> On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
>> Foundation) wrote:
>>>  Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
>>
>> It'd be great to hear from others but IMHO in the current form this is
>> not suitable for Documentation/networking/ We can commit the "knowledge"
>> part but enumerating the test cases seems odd for Documentation/.
> 
> Sorry, not looked too deeply at the actual content yet.
> 
> What i was thinking was a python file, which sphinx can ingest to
> produce documentation, and place holders were code would be added to
> implement the actual test during the next phase.
> 
> This is how i've done testing in the past. I would be the evil one who
> thought up the tests and described them in detail using sphinx markup
> in a python test template file. After some review they got passed off
> to a python developer for implementation. And when they got run and
> failed, sometimes the feature developer, the test developer and myself
> got together to figure who made the error.
> 
> I'm not sure we even need sphinx. What i find important is that the
> test is documented. What kAPI calls should be made with what
> parameters. What results we are expected and why? So that when a test
> fails, a developer has the information they need to fix their
> code. The Why? is important, and often missing from the kernel tests.

This isn't sphynx, but I've come-up with something like this for a
test definition :


@ksft_ethtool_needs_supported_anyof([Pause, Asym_Pause])
def test_ethtool_pause_advertising(cfg, peer) -> None:
    """Pause advertisement

    Validate that changing pause params through the ETHTOOL_MSG_PAUSE command
    translates to a change in the advertised pause params, and that these
    parameters are correct w.r.t the supported pause params and requested pause
    params.
    
    This exercises the .set_pauseparams() ethtool ops for MAC configuration,
    as well as the reconfiguration of the PHY's advertising and negociation.
    
    On non-phylink MACs, the MAC should call phy_set_sym_pause() to update the
    PHY's advertising, and restart a negotiation with phy_start_aneg() if
    need be. Failure to do so will result on the wrong advertising parameters.
    
    Pn phylink-enabled MACs, phylink deals with the PHY reconfiguration provided
    the MAC driver calls phylink_ethtool_set_pauseparam().
    
    Failing this test likely means that the PHY driver is not correctly advertising
    pause settings, either due to the MAC not triggering a PHY reconfiguration,
    a misconficonfiguration of the advertising registers by the PHY, or by
    mis-handling the phydev->advertising bitfield in the PHY driver directly.
    
    The validation is made by looking at the advertised modes locally, as well as
    what the peer's 'lp_advertising' values report.

    cfg -- local device's interface configuration
    peer -- peer device handle
    """

    # Initial conditions :
    # - Local interface is admin UP, and reports lowlayer link UP
    # - Remote interface is adming UP, and reports lowlayer link UP
    #
    # Test 1
    # - SKIP if supported doesn't contain "Pause"
    # - run 'ethtool -A ethX rx on tx on autoneg on'
    # - FAIL if the return isn't 0
    # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
    #   "Pause" or contains "Asym_Pause"
    # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
    #   "Asym_Pause"
    # - Succeed otherwise
    #
    # Test 2
    # - SKIP uif supported doesn't contain both "Pause" and "Asym_Pause"
    # - run 'ethtool -A ethX rx on tx on autoneg on'
    # - FAIL if the return isn't 0
    # - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
    #   "Pause" or contains "Asym_Pause"
    # - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
    #   "Asym_Pause"
    #
    # ...
   
The annotation defines the pre-requisites in terms of locally supported
linkmodes, we have a docstring containing information for developpers
to debug their drivers, what I'm unsure about is the commented-out part
below, so either one big function testing multiple adjacent scenarios
or indivitual functions.

We could also use annotations to enumerate the various combinations of
modes to test.

That's just an extract of the full test suite for Pause, but before
writing the whole thing down i figure it's better to iterate on a single
test's design.

What do you think ?

Maxime

