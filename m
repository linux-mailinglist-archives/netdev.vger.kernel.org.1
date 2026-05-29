Return-Path: <netdev+bounces-293107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBASBb+HGWqdxQgAu9opvQ
	(envelope-from <netdev+bounces-293107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D36024EB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC28C301E96E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FCD3D75CE;
	Fri, 29 May 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v7anjzoL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF632256D;
	Fri, 29 May 2026 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057826; cv=none; b=eqGj93kAV9Io1brDvXTHrONPQX9DmjBCt44rp4l23czvKPNiPRZPw+kC7pdiPpntEnVjt8mtkxs3pBM8kC8JLg1FmVIOV8ZvF8MkPj3IqCCV2VB6APaZ1MWwvnWX9Pl33Dc2a2YC7IF1ojWWuWxCI2a7LZD9bx4lvTLQR2DG+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057826; c=relaxed/simple;
	bh=WnWXsM/KA0ZsFUqpU0bOa1Ya+m90eOIpzAnE+XypZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/UQRwujr8SNJ+I1CpdUFB4MuIUXqmrD7JwcLXpzCPrhOk8RbZTVzMOh6Aa3a18LLqLeTizlESehWTzqnaEbn9eJe1SgPy8JrCA9YqB+QV1U+6+W5X7f/7U7go9Le5kmCBZh3LD5upcTIIh4S2N9UlmHMABc0lvfhIsU44f1bS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v7anjzoL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NkZ6IlpbH32Fqzw6lbS5A9mwLrFAzoEui0vFhTv7u54=; b=v7anjzoLo8lwreamgaU8zcQ9BO
	NFHjmmAd1QTXp4BlQEa98b/27oWxyKaUAex9mwJAF8Z+VcCdHd3V2t65w7qB7xZ7GoItdMsb9BKjn
	WrtQkrGA4D7SgqaoFsZijFBMOXbFhqTXeS9nuAzCzc2PJak5WI0hUTELRlKTb/GdQlkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSwLl-0055By-VJ; Fri, 29 May 2026 14:30:05 +0200
Date: Fri, 29 May 2026 14:30:05 +0200
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
Message-ID: <4f1300e6-7cc6-48c3-b1a4-1479e8e8365c@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <20260527162516.0d012503@kernel.org>
 <452cb18a-29e7-4fc6-bf74-e9d67e7d4c70@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452cb18a-29e7-4fc6-bf74-e9d67e7d4c70@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-293107-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 6C6D36024EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From what I get from Andrew and you, the test definitions is lacking in
> details w.r.t the start conditions, the return code handling as well.
> 
> Having that in the doc is going to be too verbose, but in some python test
> that could really be great.

My experience with such documents is that they are verbose, very much
cut/paste repeated text, with just one parameter changed between test
variants, and a slight different expected result. And i personally
tend to make a lot of cut/paste errors :-(

Return code handling is also important, so i think it should be
stated. It is also potentially the most complex part of it. It happens
in all the corner cases which are going to get the least testing when
implementing the tests. They only really get exercised when the tests
are thrown at oddball hardware by developers trying to validate their
hardware.

There are also cases where the hardware reports it can do something,
and then returns EOPNOTSUPP when asked to do it, which is a bug. So
the tests becomes a sort of decision tree. The hardware reports it can
only do symmetric pause. We go down the branch that makes sure
symmetric pause passes, but asymmetric reports EOPNOTSUPP, etc.

There are a lot of combinations/permutations, and limited resources,
so it could be we cannot actually test everything. We might need to
accept EOPNOTSUPP at any stage as a pass, simply because we don't have
the resources to test all the corner cases.

I would normally actually concentrate on the corner cases, because
developers should have tested the happy path cases themselves.
However, for pause, we often see the happy path being very wrong, so
we should spend more time testing the happy path, and less on the
corner cases.

And that is probably true for all the testing we are doing at the
moment, because we are concentrating on subjects where developers
often get the basics wrong.

     Andrew

