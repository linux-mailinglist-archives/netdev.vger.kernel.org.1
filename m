Return-Path: <netdev+bounces-292260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OBgJZTgFmo9uQcAu9opvQ
	(envelope-from <netdev+bounces-292260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6D5E3FFD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11959300B631
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5D2EBB99;
	Wed, 27 May 2026 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zh/CFXTr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41E256C8B;
	Wed, 27 May 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883731; cv=none; b=SL5OU0BkkekLESw1SVZRkrMy7jJdWu7X1/bf2dnCGGpyNlWorWzWnXbB666pEG5+YjlrLCj2r+E8qLuVqbC9lM883xiCNm4UTie1S5/mJTVRWgOcss9uPINKfmipdecIrdnB2cX6/V84W6QkjDBuwMlxiVLZ9KEryk6hAM5I36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883731; c=relaxed/simple;
	bh=4zOX4y6Aruc8X+mmbvAQlp0KXASTGTcN5BBme+WiecY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP452vDz7E8P61IQMMe04ZVg9N5X311DKzHEK0RKPp6E1FT0oiNBY8GXEGKnYB7t5CCi5F/yDo6bQplhcLYhZ1IyJc5XC87z6txkOro1XZsGYUNGTJc0BF23XYGzWSQXS9V4CGKaZRXJzmLRJoI1fCGrQFJZAY5eI1+bFpPPf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zh/CFXTr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2uOGS6PFx1PoazRF6TE6ggG0V1Hfkd9DJj63Ysfrd4o=; b=Zh/CFXTrP4ptmgn7+w8N70lZs3
	tMC/5fsbxbn2wHOpNU1jVkLqf3ApHx2T2eiV2k/odiQmzSgWVLEejy2NnEYJBR7wSlzRKe9MNdWsb
	Uz250CCe8+lcaFy+gYDl/SBQlQtRkxsG9gVYJhCzZMWPSzG1MZDgnm8bxM3Co9TERa5A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSD3m-004k5J-LQ; Wed, 27 May 2026 14:08:30 +0200
Date: Wed, 27 May 2026 14:08:30 +0200
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
Message-ID: <81777bc8-b046-4c76-9f53-e33563b6ad62@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <f9d0b5bf-e285-4694-8147-e7b59164da00@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d0b5bf-e285-4694-8147-e7b59164da00@bootlin.com>
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292260-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E5F6D5E3FFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> As for the kAPI testing, I agree that the end goal is to get driver
> authors to get their flow control implementation right running this
> suite.
> 
> But I don't really see how we can validate kAPI itself, as we're down at
> the ethnl level.

All we can do is invoke the kAPI in different ways, and test we get
the expected results. When it fails, it is down to the developer to
figure out why, which layer. But they have a description of what the
test is doing, and why? In most reviews, all i need to explain is the
expected behaviour, and the second version is correct. So a test with
explanation text should sort cut that process. I don't think we need
any more.

To some extent, we have an iterative process here. We have never done
testing of this, we don't know exactly what we need. If we get
feedback that a test is failing, but they cannot figure out why, we
might need to help out, and then extend either the text, or add finer
grain testing to narrow down the problem space. If we get a submission
which passes all the tests but review turns up problems, we might want
to ask the developers to extend the tests to catch the failure.

    Andrew

