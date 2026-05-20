Return-Path: <netdev+bounces-290003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGoEH93aDWrE4AUAu9opvQ
	(envelope-from <netdev+bounces-290003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBA591637
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 014133001FE6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500D33F8A2;
	Wed, 20 May 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AtZ2jJdF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0B33ADB3;
	Wed, 20 May 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292546; cv=none; b=pWPTKiEhvHzG1IZ8SD+VKDjm5bGKKcaU7iFsuRvjmzNz3nQLj6JxnVVPygvqAPcqk00HN84HZWRm4XmmVUQWtDm9Q7oiS0RY2qlA1B/VrInym35WsT0RjnOp/H+Nu5BQ5mVXLSQfZtmlUI84u0z6TJAAMbt+lT4QfxrZ4fzCTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292546; c=relaxed/simple;
	bh=N+l+E5fceXyJecjgVg6Eg+A806Ep0Y/Nudob3AriYgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxqJEhm8Qvvl0XEdIuomQ7nPR9QFkMSy5MozY9+858fuY/S5vOgEatWGUCDNcyZAoc+8BjxPZHnTF3VSvYWenNxiXWLtSu1aRqZbaAb1KAWE2NIIOGU2IlwClgsU2CbuFCA00eGjlI81laTl6vaqN7h2LfvIuZaMNDQxVJwbII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AtZ2jJdF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1u/ohTUB+QTwLw2t6IUBUdKZdPCSQ9E31Qe3GG66JzY=; b=At
	Z2jJdFOSFDLQb0jQv+AeUw3I+xxRH7P7pE0/xWPO95oVlHDM1ABKPguGtHcYDao/e2iZqETvUmQGa
	08Bc/0QuL2lcmJqitzol/kDUCg9YpMkVY9HwB50QlccTl76zze6xYGnaJpcLIdoaxNWI3sFaO0B9j
	LaSQbD9yI3MnlBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPjGZ-003rNX-Fq; Wed, 20 May 2026 17:55:27 +0200
Date: Wed, 20 May 2026 17:55:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "leo.moerlein@proton.me" <leo.moerlein@proton.me>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Buday Csaba <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on
 unregister
Message-ID: <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch>
References: <20260520151355.1371163-1-leo.moerlein@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520151355.1371163-1-leo.moerlein@proton.me>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim,proton.me:email]
X-Rspamd-Queue-Id: 77BBA591637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:13:59PM +0000, leo.moerlein@proton.me wrote:
> From: Leonardo Mörlein <leo.moerlein@proton.me>
> 
> Some PHY devices are discovered again after the MDIO bus is torn down and
> reprobed, for example when a parent driver first returns -EPROBE_DEFER and
> is probed again later.
> 
> This breaks boards where external PHYs have per-device reset lines
> described through reset-gpios. mdiobus_register_device() acquires the
> reset GPIO and asserts reset, mdio_probe() later deasserts it for the
> active device, but mdiobus_unregister_device() used to release the GPIO
> descriptor without first driving the line back to the inactive state.
> If that descriptor was the last owner, then the PHY could remain held
> in reset across the next bus registration and disappear from the reprobe
> scan.

I'm wondering if we are fixing the wrong thing here.

Rather than take it out of reset, should it not be put into reset? I
assume the bootloader is taking it out of reset?

Or does it have a pullup/down so if the GPIO defaults as an input/HiZ,
it defaults out of reset? When the GPIO is unregistered, are we
leaving it as an output?

	Andrew

