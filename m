Return-Path: <netdev+bounces-259709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BZgNt5bmGkNGwMAu9opvQ
	(envelope-from <netdev+bounces-259709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:04:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE73167AAB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ED603009E2A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3275D344DAB;
	Fri, 20 Feb 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uTP8vgMl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19691FCFFC;
	Fri, 20 Feb 2026 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771592664; cv=none; b=faOpJXE0lkTZRSGomxHUu44TSDQ0HJxxoakzxARwwze9bPNTvSqsTUqoCiilIDo00YrKg/VFcFzcYUvYmP9yNOw1RdCMJ6pc4UPO9s5UViVGewaSjpksLvG88S9h5wwN4ttnUzoPdyxnMnRjCHqnoQ8+YnBsBnLUoHCUTfA1GsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771592664; c=relaxed/simple;
	bh=ylbVJfXBhgxntel6DHRLnTgdxKcD04pQXhfokeNkGt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCSWlEBYsFjJ1ZqSZEqvN0wPkqP44YOusMoho4Npv+d4gCTc5vQCbZ9ZFRWjWv6q88vZ+TxysfLV43DZnDu/Cq7zsUbyXasXKzv2Qq678bCIhy7350mooSIvHkX9pxk0vtP7hxiuE42TAXcYAQt7y6MRTX7dbTxu5XaOk5X53t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uTP8vgMl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/4NzBCvFv04+Vi0snEc7kDWAhLxT5Ew8rA6Mb2Y1t1k=; b=uTP8vgMlKF62Q3M9U6MLaKWIjy
	7I1AGzOJtQSn3cwrPjiy7gczMyhYr59DcXaLkC3pjaBqO607bYnTGZcZydMadqi4GLIFwIfFH5IDe
	LGtGHkHhktZ7czfk3K/wJ8nQnMRsvnQ6DXEmzpaBXS9LlMuznWd4DeYLj1cZLY3EvL1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vtQB0-0084K4-S1; Fri, 20 Feb 2026 14:04:10 +0100
Date: Fri, 20 Feb 2026 14:04:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: support deferral
Message-ID: <3d0d0727-1bfa-4e43-ae09-2d636b9f7d66@lunn.ch>
References: <20260220021949.40817-1-rosenp@gmail.com>
 <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-259709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 0FE73167AAB
X-Rspamd-Action: no action

> What I actually most of all want to achieve here is to support loading
> the PHY as module, but I suspect that then the ethernet driver has to
> be a module as well so modprobe can do its job.

I don't think that is true. You should be able to have a built in MAC
and a modular PHY. phylib will call out to modprobe, passing the ID of
the PHY in order to load the driver. There are some interesting race
conditions when interface open() is called while the PHY module is
still loading, so you end up with genphy. But the race exists
independent of built in vs modular MAC.

	    Andrew

