Return-Path: <netdev+bounces-306010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MP6gByzaTmrOVQIAu9opvQ
	(envelope-from <netdev+bounces-306010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:15:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFF72B110
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="km//TbkL";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306010-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306010-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02D37301274E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C38378D74;
	Wed,  8 Jul 2026 23:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848C14A60F;
	Wed,  8 Jul 2026 23:15:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552548; cv=none; b=CggoE06fTrAfrD22uFxYmNRQ2rigCayHPbNy2lbwTWeuoNrwBCAfAWWX3RXVZQGOxKdAIvwa6zWNkNDUw9NLRa6Cic7xkkWZKmoapNVFBED/Gm3EbTLPZ+9d5+IXZqj8Ftn2qsB5iOY6LfvMpe9BNzTSYlM3/rkCz9fJrmuEj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552548; c=relaxed/simple;
	bh=VX4vjjA4u85KuWgvvCeORL6MUd01AAQTbmn/J2BZVfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+d5abAueQ6CY6q2APlUqwTHnfk+NghzEl+y3VI1Qvqm6bsRvJAuVDakTyw/CCvzHqHkldAJcZoT3gPLk81VhAuEGM9rSdPoSzAhKl5xbz0iEWk0YIuD+R540yCm8PCZ7S79sm+5vBVz/CJvUAVHhik+cnZcKTfklvw3jz8uW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=km//TbkL; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BzS0ZxhAqv0xPwvd9MAUNmXADZ39TihBc+TR253aYHQ=; b=km//TbkLdQ1cZgTt0aHFWpJlz7
	BW0uu0j85s/JtJNESP6yK8yb1cqcVWS1yylXizSczHImnZBzn47wVO2WR5im1j3l4lqvFRFEF/Z+U
	V0WbqUxlpMjQW4GaS8w97QHmsbrjiJyRV3oY8GVHYLtvzsVasVyU1cHVIPT4k6EDiIFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whbUM-00BPJK-HA; Thu, 09 Jul 2026 01:15:34 +0200
Date: Thu, 9 Jul 2026 01:15:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <98505e14-d684-4225-9415-f4d872113998@lunn.ch>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
 <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
 <ak6o7Ovekjb_evPs@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6o7Ovekjb_evPs@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBFF72B110

On Wed, Jul 08, 2026 at 09:45:48PM +0200, Daniel Golle wrote:
> On Wed, Jul 08, 2026 at 07:22:49PM +0200, Andrew Lunn wrote:
> > On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> > > Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> > > SMDIO register access. MCUboot rescue mode only exposes clause-22
> > > registers; the existing clause-45 MMD interface is unavailable during
> > > firmware transfer. The MDIO bus lock is held per-transaction (not
> > > across polls) so that SB PDI polling during flash erase does not
> > > starve other MDIO users.
> > 
> > What other MDIO users are there? It sounds like once the switch is in
> > rescue mode, switch management is dead. So how can there be users?
> 
> The MDIO bus lock refers to the host bus which is used to connect
> the switch management interface. The same bus can also be used to
> connect other unrelated PHYs (eg. to provide a WAN or management
> interface independent of the switch).

Thanks for the explanation. Maybe 'does not starve other non-switch
MDIO users'?

I've not got to the rest of the patch yet, but i wondered if phylib
might still be trying to poll the switches PHYs.

	Andrew

