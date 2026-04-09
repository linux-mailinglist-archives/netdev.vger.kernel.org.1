Return-Path: <netdev+bounces-277053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKycNBPJ12lVTAgAu9opvQ
	(envelope-from <netdev+bounces-277053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:43:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FD3CCEBC
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0896E3015490
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9B3DCD81;
	Thu,  9 Apr 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6OFml1VU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F93B530A;
	Thu,  9 Apr 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748918; cv=none; b=usgRaDxdSCpcsaN6ZKeTZV7eJf3mVXIph9gAoQ193aDpStsxSOPIw98umPS6Bm/GqEWwCk5NcQz7FKET1AdsV2YytDb5elC4cP3zLGUzFDNnJaLApTrYx/z3g2lXkxfryziqPcQhUtVoRbQfxdMDNOVyro8met9uevthNWwd1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748918; c=relaxed/simple;
	bh=7pwlIq2JeZ1FTjjOWDqbqWBiY1lab7aRmCBSQzm15Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqqLd4HDDqTD5GfNkCr1O0rMy7vwEO1qgREB14jqD74OARV3ldYu9s1l9KM5c+6mftV5YiprWUDBlww5ItqWYH1teGnNRQwnk2skHGZ94s9rpP7ACito6x+Joic7ElwGGeL6woE6UtQP5CsKuiBm0EyICAU5+nFvZew36cdjexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6OFml1VU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NrQnaPrMbnua6w9I9OFiqojfECRYW4w2RGDqp0uUzDI=; b=6OFml1VUesRPpcWBy5QqT9mVAv
	nGNK4ZF+8vZuB4ASXPYbYW5UISkLk+uxLa6ZrBteUQKx7dacPYL6F+sSDOezCdxjboD0kj1eXzb6Y
	HWrvmlXq2BbmZVy8vJkWZN78sZ80u7G7VFdRsFmLWfTkeOknWrYgiN2vQ7OAwx50wRHo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wArPE-00FS6s-8F; Thu, 09 Apr 2026 17:34:56 +0200
Date: Thu, 9 Apr 2026 17:34:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
 <20260408210711.439068-1-github@szelinsky.de>
 <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
 <20260409150922.74d82c39@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409150922.74d82c39@kmaincent-XPS-13-7390>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277053-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szelinsky.de,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 446FD3CCEBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I don't think we should associate it to the MAC. In a hardware point of view the
> PSE Power Interfaces are wired the MDIs. It was associated historically to the
> PHY, because, at that time there was no representation of the MDI. Now thanks
> to Maxime there is, so in the future we should associate the PSE control to the
> MDI only. We will already have to keep the PHY association compatibility to not
> break binding API but please do not add another layer of association that will
> increase more compatibility burden for the future.
> 
> As I proposed in another thread, if the PHY can't find the PSE PI, we could
> save the phandle of the PSE PI somewhere in the PHY structure. Then at PSE
> register time, look for each PHY and try to resolve every unresolved phandle.

I still think we should be deferring probe until we have all the parts
available. The question is, how do we actually do that?

We could insist that MACs being used with PSE need to call
phylink_connect() in probe, so we can return EPROBE_DEFER. We might
actually need a new API method, phylink_connect_probe(). That can call
down into phylib, maybe again new API methods, which will not bind
genphy, but return EPROBE_DEFER.

This helps solve this problem. And it puts in place a solution for
other similar problems. We have seen PHY drivers which download
firmware get into a similar situation, genphy used because the
download takes too long. It needs MAC driver changes, which is not
great, but the changes themselves should be easy to do.

I don't think having MDI represented helps us. We still get into the
same situation, open() calls phylink_connect() and there is nothing we
can do except use genphy.

    Andrew

