Return-Path: <netdev+bounces-294201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZPUgJB7NHmotVQAAu9opvQ
	(envelope-from <netdev+bounces-294201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CD62E0A5
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=NfC4t2Sr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294201-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0352301016B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B82F25F0;
	Tue,  2 Jun 2026 12:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776632FFDFC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403442; cv=none; b=XuuiXsxYXH6OE3TuT0WpnktijXvBT5tavUJFJOu99wbSBNIjp+BF2Mik5LPx0t/+c1T8pSLrP6Tfw6eoE7CshHCsRXhVa7FQWUobmUoTOAkQqkF9uuFnzdQ86I5xmTOyAy1+JFpFJg+erlNg/lld9fm34cwyLlk2YA+aL4jkTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403442; c=relaxed/simple;
	bh=kMVaFTgr1hQyIZ6cpZR8XMvvPO75gXFwRLpGv1DOB8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLM6uYyDOb4w+p0xyqKSY4HVPUBYL9OFUKGEhnfF9iP/pEa8vqFfg9V3tyHXTIeSyCJ3gykfxpjC3YKdNZjXubZTov/5HZLEwLrw6mgGFh+1IWtJv5INi7bI/i9oBE5XRdJvffCwpvs6KoiIb1gV44coiJUFcvoK10nNfrMQYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NfC4t2Sr; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mPaYzKfSH5pX7NTEXYPJ+Y0/6FQqLCIlP/m8X7gU4qA=; b=NfC4t2SrzVlpS/yRlT2QgAOiIY
	LrwpEzG2BpaJxlfF6Qt8IMbiNPLSjs1DFbPnPqacLy8JZRcOWSN7Gu22/0rmX6zJCH3G4JzExMx8J
	Wuc21AuKpeW5zPw5gCXnZTxN5+15YeqFtMw0O7kNT6GixfpZN9+/CqAkntkCBO6ra2zw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOGF-005gaZ-2l; Tue, 02 Jun 2026 14:30:23 +0200
Date: Tue, 2 Jun 2026 14:30:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Convert port
 lookup from O(n) to O(1)
Message-ID: <6ae0d4c1-bc9a-4972-8d4d-b1580a4565e2@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-9-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602052640.93083-9-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C78CD62E0A5

On Tue, Jun 02, 2026 at 07:26:40AM +0200, Markus Stockhausen wrote:
> When addressing a PHY on a bus/address the driver must translate that into
> a port number. This is currently done with an effort of O(n). The driver
> loops over all known ports and checks each if bus and address match. This
> is very inefficient especially for the following reasons:
> 
> - The lookup must run for each single read/write operation
> - The SoCs have very low specs (e.g. RTL838x one core, 16K cache, 500 MHz)
> - High-port-count devices RTL839x and RTL931x provide up to 52 PHY ports
> 
> Create a reverse lookup table per channel during setup. This stores the
> (overall) port number per PHY (on that channel). Take special care about
> absent ports that are missing from device tree because of hardware design.
> Save memory by using s8 type for the table (-1 = absent, 0..56 = port).
> Convert the lookup in otto_emdio_phy_to_port() from loop-based to
> table-based.

Generally, for performance patches, you would include some benchmark
numbers.

What percentage of the time of an MDIO transaction is doing the
lookup, vs shifting bits out the hardware and polling for completion?
A 2.5MHz bus is not very fast, compared to a 500MHz CPU.

	Andrew

