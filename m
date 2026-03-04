Return-Path: <netdev+bounces-263871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFOkHzBTqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:43:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A22030D4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7668331FD334
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFC359A62;
	Wed,  4 Mar 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qOu6ePib"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230E34D4E9;
	Wed,  4 Mar 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638464; cv=none; b=JPS3LOADgLx9aExsjulhApJjcywKtso0lAHwal8lCBbgcmVdWoN60e3VfJxkeJyzZMtD956iEVCCk7Jmt2sxpemk3CVXHBjpDQwU6B7F6+CNgJVXAvyqj39is9gsTifnfQi3jPPWUvV5XqwT0oMHhNE4QdeCvCv7peWjS23jacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638464; c=relaxed/simple;
	bh=JEW4/mYA2XOun9IB4xWiRhR+DnPv1bX2ovJhr36o+es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMPRIvFIK+xU0FbJLtZYFC4H4QwR0Tzbn9PWKF01xtql919m22qDy1JzC1WyBTvYFfe9xBrMO/Vn2AGlMPjQ/mIdrf5an9Ssl6zT31R2FO0iq2LTtnLWSxPaxeFInwyCzobW5dbHLsEnQTF+9BwHwRTaxuCThWKfq+AQgkzPF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qOu6ePib; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w7CjWWjog3juJYmm9HCe5Z2xtmDkcTaqZK/4UtPTnNc=; b=qOu6ePibtJHDVym7mJ9MeWvAmf
	8gaN0cHadBJJ1M9vck/nLIQwYbUS+kfb6xg4B3itsLr0ZjwWpzSf8nuUAcdrv6PA3vkthJvNAH2Fe
	btHB8Kp0gbDCmTbKTaQJ9/YdaHfRjvSiQRQ3EOMM+QLqKUkMxJqqbj7/OGEIVZvCyjk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxoEn-00A7yL-Is; Wed, 04 Mar 2026 16:34:13 +0100
Date: Wed, 4 Mar 2026 16:34:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/8] net: dsa: lan9645x: add mac table
 integration
Message-ID: <8a08bb19-f565-4363-9617-a752c83a762e@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
 <20260303152709.nospd2qq3dju2tev@skbuf>
 <67a34d22b8f59964fd3bfaee99c8418a21526f3e.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a34d22b8f59964fd3bfaee99c8418a21526f3e.camel@microchip.com>
X-Rspamd-Queue-Id: D05A22030D4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-263871-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> > > @@ -6,3 +6,4 @@ mchp-lan9645x-objs := lan9645x_main.o \
> > >       lan9645x_port.o \
> > >       lan9645x_phylink.o \
> > >       lan9645x_vlan.o \
> > > +     lan9645x_mac.o \
> > 
> > Is there some particular ordering here? Because it's surely not
> > alphabetical.
> > 
> 
> I just add new files at the end, I thought that made the most sense. Should they be
> sorted by name?

This is part of the whole 'sorted' story of lists in Linux. By keeping
lists sorted, insertions are spread out across the list. That reduced
merge conflicts. Within one driver, conflicts are less likely, but
always adding to the end of Makefile, Kconfig, core code, etc will see
merge conflicts if we have two developers adding drivers at the same
time.

So if you have any sort of list of items, please try to keep it
sorted.

	Andrew

