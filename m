Return-Path: <netdev+bounces-292953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIf5Mi4AGWpApggAu9opvQ
	(envelope-from <netdev+bounces-292953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764665FC8BC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D01301AA5D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1B3624CF;
	Fri, 29 May 2026 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="drqCdeB/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA528851F;
	Fri, 29 May 2026 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023155; cv=none; b=p+xf2mkY5cS+jJvnGvBFgAyLyr6hNyhHLNgDIb5olHoXRG6XgmcPyT+OU5HXBpx8pmMOjT7rl/h+nusoETloka6kUtgsRTz+ca+MFzQ6yAYCNgY/jcL+IM1KN5wcX9Df5w5VpZXM9edWWs+Beq+QzG3wnjTnJMg1uIJ7iuiOfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023155; c=relaxed/simple;
	bh=3WGbppdhHouD7QB+hA+APQACUt/MRfn0Fb/C0LBEjHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG2FsbOoPHe8Sa3S2VRf4HdV9pvwBoGQBJrGtrp5LtSlb5RmmIXSw55Kg/Yg8iuRndrekCdzWIzG9eovGky5d6U4UtX/pPqPszbKMAJ0W+NUZcjZdo5Hx1XuNNNeV/BPNe0JYqDxikKN/wb/XJFv2wflb41VNFi7lVb6CrWWHiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=drqCdeB/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QP3Cvy2+WySoayTMbD1DI6BdpYhvxEICeVvCegdqfZo=; b=drqCdeB/cRv91LCxj7It/514M6
	insA+5NsE8XBcCE8HvGjOh9kayzx1ej75iE/uELItB7B1kB28R85hsKbJ2BbNZ4uQaonIbPInhw0q
	7IFHr9zgfaD/rzMiXdXSMoA2AjkoJxXL/AIgErDhiQfXcmRnOVb/zW8iK4ovuzrqo4dU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSnKU-0050AX-9h; Fri, 29 May 2026 04:52:10 +0200
Date: Fri, 29 May 2026 04:52:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <b8ecd274-b299-40d1-b3e4-1ec475675f68@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <f9d0b5bf-e285-4694-8147-e7b59164da00@bootlin.com>
 <81777bc8-b046-4c76-9f53-e33563b6ad62@lunn.ch>
 <1780018791.8076131-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780018791.8076131-1-xuanzhuo@linux.alibaba.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292953-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 764665FC8BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> So I've been thinking lately: should we let AI generate and maintain these tests,
> including kselftest? This would give us a much richer and more comprehensive
> set of tests. Plus, each test could come with a complete explanation of its
> purpose and methodology. In short, much of the work we used to do manually
> can be offloaded to AI. This way, we can build a massive test suite and
> achieve much broader coverage.

A test suite only has value if it is correct. It actually has negative
value if it is wrong, because you are forcing developers to make their
implementations wrong in order to pass the tests.

Do you have the knowledge to validate whatever you generate via IA?
Can you argue it is correct? Do you have a range of hardware to test
it on?

It could be an interesting experiment, but i'm sceptical, until proven
otherwise.

	Andrew

