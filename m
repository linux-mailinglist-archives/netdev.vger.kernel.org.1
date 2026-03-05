Return-Path: <netdev+bounces-264442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MZdD6GbqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:05:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A792D214219
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC11130A5095
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005333B52F5;
	Thu,  5 Mar 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GS+cMH0u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E139C621;
	Thu,  5 Mar 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722708; cv=none; b=IfBT5GNzfATB5MzWrnIJwxdi94r+n83qqk19d5TOHDBYoiP3AnFJ8hTDPuf/mxpt+azmJM0/ohIR3YVt+sYnNo0YqhKtRaMK/kzCoPlE1LQTcLUInxvLdNqgroLOxNssEgIgua6lKK+DYnYBXAyHmcmseUQB1JD5PWMqWW6irco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722708; c=relaxed/simple;
	bh=hz6nHUvavp9qE3wnfR9Q16aFCS/det6SPcPFwoAqDxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiO96/h9SbAGyqMAb6BY4urKnAdwzhn/rySCqtuZtPSJAFRSipbfs5MNvTbUEmBuS7XhNXHII9VRtpFjnuAZjKpahy8o6NpqOeIILSHBmSPiquWRof7+5xZDe19Aydu7SV6QeVmvGbWGuRKrwgF3XMiigWLsju/KS3Gk8Jw3Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GS+cMH0u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rr7zogytiXL931QjRnSg1sWBY/f8/mK1a99OXMJXVgE=; b=GS+cMH0ui+heX7pFZKovFYZLwI
	HNSnhMBrADaiXQLvAiEbpqIsz5hqs/pGB2XZZO7bND7qFoxjCe6gapKDACkOn8pvjEa4DRIeswfsL
	Ea1Ra0q38SPe//jCyN1wZVaTrFq9nXA2J+aPMNfJwPm2hznO5m0wiU3Zt0Bv6nMxCUBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyA9Y-00AKje-Dr; Thu, 05 Mar 2026 15:58:16 +0100
Date: Thu, 5 Mar 2026 15:58:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Message-ID: <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-4-bff8ca1396f5@microchip.com>
 <aahWu2-3YT92vMuC@shell.armlinux.org.uk>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
X-Rspamd-Queue-Id: A792D214219
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264442-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > > +     /* We configure delays on the MAC side. When the PHY is not responsible
> > > +      * for delays, the MAC is, which is why RGMII_TXID results in
> > > +      * rx_delay=true.
> > > +      */
> > > +     if (mode == PHY_INTERFACE_MODE_RGMII ||
> > > +         mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > > +             rx_delay = true;
> > > +
> > > +     if (mode == PHY_INTERFACE_MODE_RGMII ||
> > > +         mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > > +             tx_delay = true;
> > 
> > PHY_INTERFACE_MODE_RGMII means that the delays are provided by the
> > board layout, so this seems wrong to me. Please review the phylib
> > documentation concerning RGMII delays. I'd like Andrew to comment on
> > this too.
> > 
> 
> The idea with this was, if the PHY does not provide internal delay, then
> we do it in the MAC.

That is not really what we want. The default in Linux is that the PHY
adds the delays. In general, MAC drivers read the phy-mode, and pass
it directly to the PHY. The MAC does not add delays. There are a small
number of boards which don't respect this. In the past, there was been
claims that an RDK used a PHY which was not capable of adding the
needed delays, so the MAC had to. In practice, all the PHY drivers in
linux which supporting RGMII support all four configurations of
delays.

So, the best thing to do is hard code the delays in the MAC to 0, and
pass phy-mode to the PHY.

Now, this is a switch, so there is one complexity. Some switches make
use of an RGMII port to connect to the host. You then have the host
RGMII MAC connected to the switch RGMII MAC. Delays have to be added
somewhere. Since the switch MAC is playing the role of the PHY, in the
eyes of the host, we allow such a port to add delays.

However, this is a multi-giga switch, with high speed SERDES ports. My
guess is, a SERDES port is used to connect to the host, not RGMII. So
i would not implement this, until somebody reports having a board with
RGMII connecting to the host. KISS.

      Andrew

