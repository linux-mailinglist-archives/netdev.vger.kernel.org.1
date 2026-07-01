Return-Path: <netdev+bounces-303713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5v6dGfYsRWry8AoAu9opvQ
	(envelope-from <netdev+bounces-303713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:06:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0206EF1B1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Gdn7HtEm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6064930000AB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570613546F3;
	Wed,  1 Jul 2026 14:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B535200D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 14:54:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917667; cv=none; b=JKBsnRG+Q4UzBTLjd0tCtlNuW0WejVZBZgRCa3aMPltzQ10bipqhaoUAOpDxqHIWc+0R4Dp9fRtATeZURtnQ5lpGy/HMR8rxWU2JMG+II9bK81vmLBS96S609J0tIhpjglFaXLRbtk/XO7wnlBQbol0CEu63N6EL31igvc7+f34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917667; c=relaxed/simple;
	bh=6WsiYY7Yuh4V3BiyQgLCPCmp0ZegI+9PTpK9K+M22jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aru4Y36u8CrRV4ngaaSWhuyu6O00z2uob91Hvguap2Md/BQLCK8G/YnM8bofuevjVX0YPbeSwIfVq0vpjAL9bnKoVXDvd0h8Pqz2PvxAdXt6ZSr/+/oy7VarQyPVEnx58WiZaoxn/UQLc76R7GthV0D9dg18nD5XPh+QigNDA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gdn7HtEm; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lw/Pr5lLrRdlWXDOCu198oxf1Z0xLB5sJLAaQ70oEz0=; b=Gdn7HtEmYHfWvM37+TNWC/Y76G
	C5OGjXe2izppaFXKHDCFHIO7rtmCxuqtvo1o/EFOTq0cdosAr8aKk3+UZjEiLVNnUGuMm9AxHjeB4
	8Co+HafWu9o005dFht5k9CXgA/7+M69XSHNkuqlzUJIdJNsbjwkaila4KNm2BINkzuLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wewKV-00ABXA-Le; Wed, 01 Jul 2026 16:54:23 +0200
Date: Wed, 1 Jul 2026 16:54:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH] net: stmmac: recalibrate CBS idle slope when EST is
 enabled
Message-ID: <7e8fe62b-9f08-47d5-90e3-3b610e30ca95@lunn.ch>
References: <20260701053244.17172-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701053244.17172-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303713-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B0206EF1B1

On Tue, Jun 30, 2026 at 10:32:44PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Hi Nazim

Please take a read of

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

It would be good to get the Subject line correct, and there are maybe
a few other things in there you currently don't know.

> +	/* If EST is not enabled, no need to recalibrate idle slope */
> +	if (!priv->est)
> +		goto config_cbs;
> +	if (!priv->est->enable)
> +		goto config_cbs;
> +
> +	cycle_time_ns = (priv->est->ctr[1] * NSEC_PER_SEC) +
> +			 priv->est->ctr[0];
> +	if (!cycle_time_ns)
> +		goto config_cbs;

The use of goto like this suggests it is time to refactor this code
into some helpers, so making the structure clearer. Otherwise this is
going to turning into spaghetti.

    Andrew

---
pw-bot: cr

