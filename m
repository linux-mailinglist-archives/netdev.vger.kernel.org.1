Return-Path: <netdev+bounces-275101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNygJAXaz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3F395B07
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9CD3029253
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8F33D6F7;
	Fri,  3 Apr 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v4ep86YW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC43ACA65;
	Fri,  3 Apr 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229381; cv=none; b=oZZ3DtEQBOvmlWZngjdtQz2wZ00uU6gpKY4qUmdq1BH7pkIZbsUwsS/OsN994JV/5F4aRRItvzlvKZfE7ZpSo+/n1hVEfp6r5hUPL0Hh5qy+rHIloPtQyfGsuzUe5XQIfJmCmwrKX0BEyR2yD0ULnM0gGpJItrSa1fFmI9vS53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229381; c=relaxed/simple;
	bh=2ma10qab2Y1pCS8QVtU8aOcDIEzbaBnCFVvIa4dlVjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0tymHo5TIUNrGE3pUfDgHIR+GduUzTSbOBQlP8Bl0lX2OepBGgUNRVhvtMNxNjNPgdNrelXWIgBy8Uvu0tJzRyCxMqn66Xg3a7JP+RCy/2JSzsf48T876e4vhK/A7yk4ynz6Zang5m9jP7MASaQV7Y8a9MBerGcJoyzW0RHJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v4ep86YW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+Ekjw4WSxb7l6wGDHXPf+PWcy0BnDxxS0WaVQVeiqzI=; b=v4ep86YWb3FKNV+VOqDpszwBkf
	oMym/+4+30Av+IGzjGATMn8fmWiDIV7kJzSnHcg141uA5+gNTfBLEJvRnj/Pq3biaBx5ljcrwmncN
	t4czaDElNQwWuHkPFxsvdFEIob5Tvh5DsK9SQlQbPxZ510ZRH7y8YnTHf6R5naJv6Cy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8gFg-00EgE4-IR; Fri, 03 Apr 2026 17:16:04 +0200
Date: Fri, 3 Apr 2026 17:16:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
References: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
 <20260403133111.3304497-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403133111.3304497-1-github@szelinsky.de>
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
	TAGGED_FROM(0.00)[bounces-275101-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: DAA3F395B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:31:11PM +0200, Carlo Szelinsky wrote:
> Hi Andrew,
> 
> Thx for helping me! 
> I thought of keeping the eager path so we still catch broken DT bindings
> early at boot instead of silently failing later on first ethtool access.
> But you're right, dropping it would simplify things quite a bit. Do you
> think that trade-off is worth it? I will follow your lead. 

I suppose, the real question is, are we fixing the correct thing?

As a general principal in Linux, you don't register a device with the
core until it has all the resources it needs. This is what
EPROBE_DEFFER is about. If it is not registered with the core, the
uAPI is not available, making user space simpler.

As i understand the problem, by deferring the probe, the regulator
gets turned off, cutting the power?

So is the real problem with the regulator code? Do we need a way to
indicate a regulator should not be turned off if it is unused?

Or can we change when the regulator code turns off unused regulators?
I don't remember all the details for deferred probing, but i thought
the driver core had a timer and would keep running the deferred probes
until that timer expires. When does the regulator code turn off unused
regulators relative to this timer?

	   Andrew

