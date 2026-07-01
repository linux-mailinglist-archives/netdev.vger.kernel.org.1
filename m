Return-Path: <netdev+bounces-303703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VSjhKzApRWol8AoAu9opvQ
	(envelope-from <netdev+bounces-303703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3F6EEFAF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=imXC22Hj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABDF230EA389
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A2349CD9;
	Wed,  1 Jul 2026 14:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F934A3AB;
	Wed,  1 Jul 2026 14:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916380; cv=none; b=uklO0VR0NcYVLQ7O+l4hfm5M3uaFoFbZJ5Gb6Ct6nX+c/L2JhgCyfQ3wn8G3M2vRnz0XrojDvvTC8Ht1GMm+s9B+tDS6ZN+67w/SdxY9Eu26wo18FzSS27DJLhk240dezC+cmICchquACUv3A7UIBDO1QbYmgYYPz6Ra7sWn/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916380; c=relaxed/simple;
	bh=iwW0yaAypSyo6hwff9OUVhDwHVYyHZ51Ck+6K7RqP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPUMyf/EFOgL2YD7QqO5Mpph4i7otDKLmyFBFZQruLG27xzfj4ugGGiOX/09a4t714CTgORRteCDjgcBmhP3hWxe0z68ZRFj+Fg+SrwZAed1zIB30ON64Oq8y9R+096IqsjN2oRtzFCWeSEQVbozd4H9IdMu7+jiLp1GTYw1kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=imXC22Hj; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DSlKJeVPx0TZyfKvWqzdvEvnU87xuN/vChHfrWxBrfs=; b=imXC22HjhlOkc9h4b18XVYlGGW
	O4dhAyf+be6Xme2EZyOOcVPmU8/NlC6Hz2MXsL3viBKs19fkysVtCab9ZvJLpYynNorsE0btcBHHW
	SRZQzOATxGtiywnlc+EmaenzaDoGf+Z1nfquitPstqZd5w+fzj5At043GykggATUg7t4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wevzV-00ABKo-CO; Wed, 01 Jul 2026 16:32:41 +0200
Date: Wed, 1 Jul 2026 16:32:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: Breno Leitao <leitao@debian.org>,
	"Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>,
	"Frank.Sae@motor-comm.com" <Frank.Sae@motor-comm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <677882ca-16cb-4fd7-86d9-b00d62147bf9@lunn.ch>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
 <akTLmyF0r70Jyn9m@gmail.com>
 <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303703-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiaoning.wang@nxp.com,m:leitao@debian.org,m:xiaoning.wang@oss.nxp.com,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[debian.org,oss.nxp.com,motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20B3F6EEFAF

On Wed, Jul 01, 2026 at 08:16:13AM +0000, Clark Wang wrote:
> > > In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> > > driver uses phydrv->features. Drivers that implement .get_features are
> > > responsible for reading the EEE abilities themselves.
> > >
> > > yt8521_get_features() does not do this, so phydev->supported_eee stays
> > > empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> > > not supported", even though the PHY has the standard EEE capability
> > > registers.
> > >
> > > Call genphy_c45_read_eee_abilities() at the end of
> > > yt8521_get_features() to populate supported_eee.
> > >
> > > Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521
> > > gigabit ethernet phy")
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > ---
> > >  drivers/net/phy/motorcomm.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/motorcomm.c
> > b/drivers/net/phy/motorcomm.c
> > > index b49897500a59..46efa3406841 100644
> > > --- a/drivers/net/phy/motorcomm.c
> > > +++ b/drivers/net/phy/motorcomm.c
> > > @@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct phy_device
> > *phydev)
> > >  		/* add fiber's features to phydev->supported */
> > >  		yt8521_prepare_fiber_features(phydev, phydev->supported);
> > >  	}
> > > +
> > > +	genphy_c45_read_eee_abilities(phydev);
> > 
> > Don't you want to return error if genphy_c45_read_eee_abilities() fails?
> 
> EEE is an optional functionality, and the call in genphy_read_abilities() has the following comment. Therefore, I do not return its error here either.
> "
> 	/* This is optional functionality. If not supported, we may get an error
> 	 * which should be ignored.
> 	 */
> "

This conversation then raises the question, should this be a void
function?

	Andrew


