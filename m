Return-Path: <netdev+bounces-293484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA/cDwm/HGpgSAkAu9opvQ
	(envelope-from <netdev+bounces-293484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 01:06:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0F61836C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EECBC300EFB1
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70635C1A6;
	Sun, 31 May 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X15sIGW5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7353345741;
	Sun, 31 May 2026 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268781; cv=none; b=ZQPm1oYf5Lspr5RKRnD4Q39ZWCTeUlqOWyuXbZNz70xVmm4yyh2F5RMIwIIEyfe2O8DurnIsNh/ARDuh//NAq3r3tdKEBmFr9UxHTeTMg37dzQ/0m97QKCLHGgQUEakfQLKNgVp6SfYtMAintTsLCha8Jdq93D0T7Y54AeHkz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268781; c=relaxed/simple;
	bh=WmIcjMVQarmzvevv+/kCuz31SOa/orVtMssPV3u/ee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKE9P1MYj/LX8b+EgXerIMk5HwGz6Jt0xjMU9luL08EB9XjyyAqDaNey0Iocag43zo/LLenJ07akZTxfWRSqo70Zmx2fjubrFpBWlpqQmu4qagQYAuxRtKwUuKscgUlYJ3CCdHLzGS1YIBhQX7jHvOqJFDWhe1Xr26/csZZUnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X15sIGW5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ABYm/QB9deKHbGHTtj52e9CMgc85DpZUU4wuPFJHpng=; b=X1
	5sIGW5VUeiVQ0jPfDZtKESj9rAjlVszh0L0vuvP7n77CBkJqfZlS0xKnZqYaozhY4n81tR4+0D9wy
	aHTwJQUhKt5aVgcqZE7c2gO1vRVjJlGrZ23z0ehcX+Ms/Xj36uyOwAu5PgV1NgpNSJNAemRY1Jy1V
	DBpoLj/5ieyge6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTpEN-005PMW-CB; Mon, 01 Jun 2026 01:06:07 +0200
Date: Mon, 1 Jun 2026 01:06:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: Fix NULL pointer dereference in
 emac_probe
Message-ID: <5c0f8926-0461-4cbe-b362-a23edd22bd61@lunn.ch>
References: <20260531022219.607001-1-rosenp@gmail.com>
 <9f01c5c2-873e-46ff-821d-3f36ab023555@lunn.ch>
 <CAKxU2N9U-OZd-1PYnRurXrC8e+VP3Ow=XCdQ9hMUG0CwN+NNLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9U-OZd-1PYnRurXrC8e+VP3Ow=XCdQ9hMUG0CwN+NNLw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 99D0F61836C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 01:52:04PM -0700, Rosen Penev wrote:
> On Sun, May 31, 2026 at 7:39 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sat, May 30, 2026 at 07:22:19PM -0700, Rosen Penev wrote:
> > > Move devm_request_irq() after devm_platform_ioremap_resource() so that
> > > dev->emacp is mapped before the interrupt handler can fire.  An early
> > > interrupt hitting emac_irq() would dereference the NULL dev->emacp and
> > > crash.
> >
> > Please add an explanation how this can happen, given that iser is
> > written in open() not probe().
> https://sashiko.dev/#/patchset/20260517033621.1839397-1-rosenp%40gmail.com
> 
> Also, does requesting the hardware interrupt before mapping the device I/O
> registers create a NULL pointer dereference regression in emac_probe()?
> The hardware interrupt is requested and enabled via devm_request_irq()
> before the device I/O registers are mapped via
> devm_platform_ioremap_resource().
> If an interrupt is asserted early, emac_irq() will execute immediately and
> attempt to read the ISR register by dereferencing dev->emacp. Since
> dev->emacp is still NULL at this point, this would cause a kernel panic.

You have still not explained how an interrupt could happen before the
interrupts are enabled by writing to the iser in open(). I don't care
too much what the AI says, i want a human to explain how this can
happen. You have put your Signed-off-by: here, so it is down to you to
explain your patch, even is AI told you to do this, and you blindly
did it.

> Having devm_platform_ioremap_resource earlier
> like this is more consistent with other drivers as well.

So maybe this is a better thing to put in the commit message, rather
than something you cannot actually explain?

     Andrew

