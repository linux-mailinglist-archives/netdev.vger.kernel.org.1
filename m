Return-Path: <netdev+bounces-292076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCvjL3RbFmpTlwcAu9opvQ
	(envelope-from <netdev+bounces-292076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:48:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15A5DEB24
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60026300B9D3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A82C0298;
	Wed, 27 May 2026 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gIa5tfSt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129C2DB781;
	Wed, 27 May 2026 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850090; cv=none; b=k03/jzR2hs0hvX7uKgIaVaskH99NY/dc6RsRzxYfFfTja4+hc2Tb7cb6XiNb7j4AONOPeeh3liG2gtKsdG7GywZZ09NXWSQhHlBn9+KVBQ0eyIi6CMV2la/lORhT94kZyoYDgjJuHonR5nmglIFg808Z7gqI0q1hcCH+TPnk6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850090; c=relaxed/simple;
	bh=OhArExhyFxW6G7UNwjQaVgZXmRB/nNTrfg+Kxp+BsiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqwfM1tTVZUtVCozShmmhmyBFaAm5WLe9p5rKcL4Pvze425LLHixEWegbUoU94qEtLtEHS1LDp7yszAdDNVclSa3Vq9x4XxzELBWK7lOwdMviDX3QmSGf/HfZLBQRGDU3mfztDvTCNxPQcCEPh3R1PEzKp2H2/ZE7V1cZ2tvBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gIa5tfSt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NqCAB+KvGtFT9+Ag7X3oNMKQy1eE5n7+jCufEcB2qLs=; b=gIa5tfStp4zgdLLUmF0beJ8kmC
	IURwABeBvUtoEmBv+28aSIJ3xecvXIrHKSKFcjLCAfnO2lYxinUSO79HpUtsBZostQ/qMnEgpyO1g
	TJ+Xie6gQZ5fyeDwSDkqgoWWXS3Vyg/YX0STx1LxAKCYljyEQ8FujzdjNkRw8qAPld3w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wS4J9-004guy-Ri; Wed, 27 May 2026 04:47:47 +0200
Date: Wed, 27 May 2026 04:47:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
Message-ID: <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526172447.10ca4b9e@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292076-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: BC15A5DEB24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:24:47PM -0700, Jakub Kicinski wrote:
> On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
> Foundation) wrote:
> >  Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
> 
> It'd be great to hear from others but IMHO in the current form this is
> not suitable for Documentation/networking/ We can commit the "knowledge"
> part but enumerating the test cases seems odd for Documentation/.

Sorry, not looked too deeply at the actual content yet.

What i was thinking was a python file, which sphinx can ingest to
produce documentation, and place holders were code would be added to
implement the actual test during the next phase.

This is how i've done testing in the past. I would be the evil one who
thought up the tests and described them in detail using sphinx markup
in a python test template file. After some review they got passed off
to a python developer for implementation. And when they got run and
failed, sometimes the feature developer, the test developer and myself
got together to figure who made the error.

I'm not sure we even need sphinx. What i find important is that the
test is documented. What kAPI calls should be made with what
parameters. What results we are expected and why? So that when a test
fails, a developer has the information they need to fix their
code. The Why? is important, and often missing from the kernel tests.

	Andrew

