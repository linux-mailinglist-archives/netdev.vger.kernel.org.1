Return-Path: <netdev+bounces-272915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJNmI5cuyWm9vgUAu9opvQ
	(envelope-from <netdev+bounces-272915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:52:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD943524D8
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C3F13010B90
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2037996C;
	Sun, 29 Mar 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xmve8yqE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C82FFFA4;
	Sun, 29 Mar 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774792340; cv=none; b=dA3J0JrUc0sn+NK9PxCMOfwUziLguBw82g/g7NR4vZgveHtYz9pKQdDc9ZmXIVs9uxMw1+pZwWJe2FwVeIPzrrWdnQN1UlA7mvvHZnb06mLuvOqcXR1nK/rsyYH+ScZdN+5G8TtygKXdR7wKR5y1BuyWtKrHiHlyY1Cl93mxrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774792340; c=relaxed/simple;
	bh=bHKNWaGCUGSGNZ7LHJw78ILCBmetKycG76Sp7kzNxfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7+xqvSvvVoxfryqvshDXJHcDDKQ6eaisLrj9FlojbQfxvPu/sdyjYOcNd2J/u0floWDdWXi65RycJiuW2RLsR5IYeQh3W5N1JyqntpGRIFKPsUwMszniTMliKcABCYPTdwwa1APT2C9NS6/M+tYPuaS79HQFZ3YP9gIeaeasYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xmve8yqE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JiOXC5tUqwiQgWrex87guzd4v1xV7Ik/86legiQ+FcI=; b=Xmve8yqEmVWKin35alRy1MlzuL
	U5IhH0uL+VCS9S8e2BAsfJngSi45SCdy9zhq3lf7BkIxBf1hvwXvPAaY/U/X5lVqa2AMxvX8wTJME
	SOTg3OMHKpg2GDTbUeUrfdMEdI+7Tsr9gbqyRPdnPzIMITzh8J+EZgB6tmxxaqxwX+n8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6qYd-00Dtqy-3a; Sun, 29 Mar 2026 15:52:03 +0200
Date: Sun, 29 Mar 2026 15:52:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Popov <alex.popov@linux.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	notify@kernel.org
Subject: Re: [PATCH] ethtool: don't touch the parent device of a net device
 being unregistered
Message-ID: <cf7b22ca-71da-464c-96c9-7286b06d5aca@lunn.ch>
References: <20260322075917.254874-1-alex.popov@linux.com>
 <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch>
 <eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com>
 <20260323150827.24a6259c@kernel.org>
 <1c41e408-15f2-4c83-8a0f-24b46b1ec1c1@linux.com>
 <676733D7-814A-4B66-9E49-93DD1259ED48@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676733D7-814A-4B66-9E49-93DD1259ED48@linux.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBD943524D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> >> That's not sufficient detail. ethnl_parse_header_dev_get() is under RCU
> >> and unregistration does an RCU sync after delisting the device. Also
> >> not sure you're distinguishing struct net_device and struct device.
> >> 
> >> How did you hit this issue? What are the net devices involved?
> >
> >I've provided additional details about the reproducer of this vulnerability to Jakub and to security@kernel.org.
> 
> Hello! May I ask about the decision on this patch?
> 
> At patchwork.kernel.org, it is marked as "Changes Requested":
> <https://patchwork.kernel.org/project/netdevbpf/patch/20260322075917.254874-1-alex.popov@linux.com/>
> 
> However, I don't have any instructions on what to change in it.

You need to add to the commit message to explain how it can happen.

My question said i _think_ devices are arranged in a tree, and release
happens from the leaves towards the root. So a parent should not be
release first. If i'm correct, this crash indicates a problem
somewhere else, not here. So we should fix that. Your commit message
needs to convince me the change is fixing the real problem, not
papering over the cracks.

    Andrew

