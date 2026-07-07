Return-Path: <netdev+bounces-305521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HKfLBZ0hTWpevgEAu9opvQ
	(envelope-from <netdev+bounces-305521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F271D8DA
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=UGIrmmcr;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305521-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CA4A301727D
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DB42F6E3;
	Tue,  7 Jul 2026 15:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2E19E992;
	Tue,  7 Jul 2026 15:52:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439541; cv=none; b=obWLYYyVOgW1f6V88TH8PWTKVcg4qhpH1gfguktsKP4C/lFR9kTmZzI5KSIs9OczEC7V90DwUPg2Tj/d0FbEccJSk7oaL1b7XK9Z+l/AaZYYqDzGTGi3+dN4tcFWQr15BWqJjZSDEoM0HFqYHJSQOt2cHzInYMUTINrsL6dtYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439541; c=relaxed/simple;
	bh=mn2695PwULigxAPZXJmQkZmHEVMELMbWQTGEzdNQaw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg/w6INcixaqijEufRL2MC0e08P9kUy8Ut3qgl588WSpg+/eLTbsyimb/plb/UN57ylfVwhpqcLN8PRPivApoZy5fe/1cLCUlWR+VKdHSb9tY7O7EpPvJcCJb261+6ZuOO5F38v/Np0m8psLRXlMAz7sqpKb2ISbY0xW5SBfDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UGIrmmcr; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3bzyZ7EjHwGyaRoVnVC0MJKRQRV90xppXyfG+tEsghk=; b=UGIrmmcrRNye4Plc5jlKCJLfOc
	d27TO81g2gunK4MmL2mQfk8rhPfYU3lFX6T98240QWTQan/ZJ/yeu2anh1wl/vr/PGrCJN2qtyVC3
	mR3rEZTCHrQD7P6tTEIf9S4x9i6kZ0QFl3bQcMLC7ItWDGcc+Z442w8bXObzp69+cAJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh85f-00BBqa-VQ; Tue, 07 Jul 2026 17:52:07 +0200
Date: Tue, 7 Jul 2026 17:52:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: reject unsupported speed/duplex
 in ksettings_set() with PHY
Message-ID: <90ef4462-d086-4c02-97af-d55a19ac03bc@lunn.ch>
References: <20260707062735.17776-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707062735.17776-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B1F271D8DA

On Mon, Jul 06, 2026 at 11:27:35PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> When using ethtool to change speed and duplex on a phylink-managed
> interface with a PHY attached, the requested speed/duplex combination
> is not validated against the MAC's supported capabilities before being
> passed down to the PHY layer.

How are you invoking ethtool here? And what other invocations have you
tested, with this patch in place?

> @@ -2989,6 +2989,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>  	if (pl->phydev) {
>  		struct ethtool_link_ksettings phy_kset = *kset;
>  
> +		if (!phy_caps_lookup(kset->base.speed, kset->base.duplex,
> +				     pl->supported, true))
> +			return -EINVAL;

Are base.speed and base.duplex always set? When looking at
phy_ethtool_ksettings_set() the values are only used when base.autoneg
is false. So maybe they are not always valid?

   Andrew

