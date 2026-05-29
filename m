Return-Path: <netdev+bounces-293112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GItzFsKNGWpTxggAu9opvQ
	(envelope-from <netdev+bounces-293112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4579602957
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68825303C3FD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650712DEA95;
	Fri, 29 May 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VIrr0fo0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E12D949B;
	Fri, 29 May 2026 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059582; cv=none; b=Ml7zfiTAM7HAEV89R05ZJGdX6jP3GX23G3OOVEKEy5k/+f+G6Dr+/NXzl0ELyrbrtjtlb8mGITDtTj/JvxbCTfEp++nXrcZXFVMGYN9kzBKuRWDilvCeZ+LA/BRJeS4UFPTMETvLlNSqwtOxBvnSmW20CNGnjeYqw6cojoXiTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059582; c=relaxed/simple;
	bh=VQJuxRm7Bn2tIF4PNqdXD3fOfowwb5TiwItKks6C9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwlKGKMxwG22CcowscFIoC/Iz6Kr+2YbZPlyMCR0xekvXFeYEIz5FPa3xfix2X56M37sQ+yDyLNWMa2OO4XbfICs4mNrzPWdIxbcejLzQupfNjqRZN7AHC+tpye/VUAQV+8Du1Q/1K3N4FkMBbsGgijkE0FcgJZqQJm6lHnr4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VIrr0fo0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ykkqr/AFKCpdnBy5Nwco+T5dKDYCeBVkIM3xxhZU6es=; b=VIrr0fo07jcYrR9Bq93solgY34
	ROBw9FUsK8Rc06warOLhDDmrxua6WFVNw4PBZQL0Jy0kvG974b0aNzbWdIRw8aeqJCN31vUt1ITBi
	rtGd5U0LV/lpPlkthqBQCWBntwFVrxAe5CRkI6FNl1YbOfRoHpdl+uqfOh64tEYGIzPc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSwoB-0055PK-6t; Fri, 29 May 2026 14:59:27 +0200
Date: Fri, 29 May 2026 14:59:27 +0200
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
Message-ID: <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
 <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293112-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: B4579602957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I think that
> 
>   ethtool -s <iface> duplex half autoneg on
> 
> should be enough, the link should still establish at 100M, I've tested
> that on a 1G/FULL 100MHalf+Full interface and this is the result we
> get :)

Nice.

But i still think the test should check the autoneg result and do
something sensible if the link does not come up. This probably applies
to all cases where we trigger auto neg.

> That said I've tested the following on mcbin, and it seems that acually
> nothing in the code currently deals with Half duplex / Pause interaction,
> and we don't get any EOPNOTSUPP.
> 
> So the broader question is, should we reflect the current behaviour or
> an ideal one ?

What 802.3 says. If we come across cases where phylib/phylink is
broken, let me know, and i will fix it. But we will leave driver bugs
to individual driver developers.

But we also need to consider that for some APIs, we have decided that
a configuration can be set now, which does not actually apply in our
current conditions, but it will be stored away for when conditions
change and it is applicable. The half duplex case could fit that. When
the link is currently half duplex, you can configure pause, but you
don't expect it to actually change the current behaviour. It only
kicks in when the link renegotiates to full duplex sometime in the
future. We have to also consider this the other way around. The link
is full duplex and pause is configured by the user. Something happens
with the LP and the link renegotiates to half duplex. The local end
should not throw away the configuration, it simply cannot apply it
given the current situation.

	Andrew

