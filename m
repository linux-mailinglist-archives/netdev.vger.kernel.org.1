Return-Path: <netdev+bounces-223658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDBB59D4E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FB3A1972
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3090283FCB;
	Tue, 16 Sep 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ImIyao6Z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17B27A124
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039308; cv=none; b=JooGiL0cIQvhTCSeAzOQkgA8zqP4J/+OSdBh2GPL3nj04loNM10VkJjiYtx41WLyRdJQua00o7QMHcT8f7qd3W0MccfSK25qkBoJlIYqAbxnz1EO084i///ftFDXw05hBMYS2dZlfpKCdb/4TYqP7ibkjIyS4YlD0n3OnIYOQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039308; c=relaxed/simple;
	bh=xOphGYhJ8lsGgHbblG5jZiOYXiDc+HCTYWuxZPeFO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpRgkyLtfCLXhE5DOX+s10bRzXQcwF2XInlkzQ+3UBae5FD76mW9PRhpX0c1+lTGefOObrAMxEl+GFTd2CVq0vb4XDgpVFyo2ybhMCAImNxKgEth4GS19L1ojGSjE1n3R3uQrJxcUEEwI3gDjgX+h/a2Ugx85F+hLenM614wc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ImIyao6Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/uIcgmM2l00VsLgd3/qjZ7bijAvUIe9z+uBl99P7uw4=; b=ImIyao6ZWtzaCX9osVDQ/qTxdO
	TzsYl6dJ/nbY4Eg5bJ8ijTz1CJKfBST9x6omha2ziqeMEsyUVB+CCSMeZtGzXT0LCDtqlnT538alE
	05jHlJbU0g/5+Z6OUErxBEZP54PPDleMnhi0ia45/fdTzE2qS6akCYS585causEj93i/nUKccdqmh
	s4plnimZ7fZqkn/evlrzuai3LqFTyd1NWzYJkH8qJkYUy1OVK3JWpcvIDhgYEYN/aUDbEAJEGbGHH
	iN2oJ7VKrTq8T9ygRmw+2mc7IpGXiYefMMU9HIOUY0koc3mgT6zkB9sl99KuJNJwvZzBN/CzD4jsq
	6EC040Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44350)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyYKb-000000005D1-0Uwf;
	Tue, 16 Sep 2025 17:15:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyYKZ-000000007n2-0uKF;
	Tue, 16 Sep 2025 17:14:59 +0100
Date: Tue, 16 Sep 2025 17:14:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 1/5] net: dsa: mv88e6xxx: rename TAI definitions
 according to core
Message-ID: <aMmNA-JIisiV0z2z@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uN-00000005cF5-24Vd@rmk-PC.armlinux.org.uk>
 <20250916084645.gy3zdejdsl54xoet@skbuf>
 <aMlnwFGS-uBbBzRF@shell.armlinux.org.uk>
 <20250916143533.3jqqlpyp62gjwhh7@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916143533.3jqqlpyp62gjwhh7@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 05:35:33PM +0300, Vladimir Oltean wrote:
> On Tue, Sep 16, 2025 at 02:36:00PM +0100, Russell King (Oracle) wrote:
> > On Tue, Sep 16, 2025 at 11:46:45AM +0300, Vladimir Oltean wrote:
> > > On Mon, Sep 15, 2025 at 02:06:15PM +0100, Russell King (Oracle) wrote:
> > > >  /* Offset 0x09: Event Status */
> > > > -#define MV88E6XXX_TAI_EVENT_STATUS		0x09
> > > > -#define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
> > > > -#define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
> > > > -#define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
> > > > -
> > > >  /* Offset 0x0A/0x0B: Event Time */
> > > 
> > > Was it intentional to keep the comment for a register with removed
> > > definitions, and this placement for it? It looks like this (confusing
> > > to me):
> > > 
> > > /* Offset 0x09: Event Status */
> > > /* Offset 0x0A/0x0B: Event Time */
> > > #define MV88E6352_TAI_EVENT_STATUS		0x09
> > 
> > Yes, totally intentional.
> > 
> > All three registers are read by the code - as a single block, rather
> > than individually. While the definitions for the event time are not
> > referenced, I wanted to keep their comment, and that seemed to be
> > the most logical way.
> 
> What I don't find so logical is that the bit fields of MV88E6352_TAI_EVENT_STATUS
> follow a comment which refers to "Event Time".
> 
> Do we read the registers in a single mv88e6xxx_tai_read() call because
> the hardware requires us, or because of convenience?

For the packet timestamp registers that follow basically the same
format and layout, they're defined as a block that can be accessed
atomically. Nothing is stated with respect to these registers.

As the status register contains bits to say whether the timestamp was
overwritten, if reading them were not atomic, there would be no way to
be certain that the timestamp is remotely correct, especially when the
hardware is allowed to overwrite events.

Consider this scenario, where overwriting is permitted, if not atomic:

- event happens
- read status register
- read time lo register (first event time lo value)
- event happens
- read time high register (second event's time high value)

If it isn't atomic, there's no way to be certain that the time high
value corresponds with the time lo value.

If overwriting is not permitted then:
- event happens
- read status register
- read time lo register (first event time lo value)
- event happens
- read time high register (documented in this scenario to be invalid)

which is worse - and we wouldn't have read the status register to
know that the second event happened (which will flag an "Error" bit
in the status register in this case.)

So, the only sensible thing is to assume that, just like the other
timestamp capture registers, these behave the same. IOW, they are
atomic when read consecutively.

(The format of the timestamp registers have the same status + time lo
+ time high format, but with an additional PTP sequence number
register.)

> For writes, we
> write only a single u16 corresponding to the Event Status, so I suspect
> they are not completely indivisible, but I don't have documentation to
> confirm.

The write is required to clear the status bits, (a) so that we know
when a new event occurs, (b) clears any interrupt(s) that were raised
for it, and (c) if overwriting is not permitted, allows the next event
to be logged.

There's two modes for this register. DSA uses the "allow overwrite"
mode, so reading this better be atomic like the similar PTP
timestamping registers.

I suspect, however, that the answer is "we just don't know". Is there
any Marvell hardware out there where the PTP pins are used? Not that
I'm aware of, none of the ZII boards use it. Maybe Andrew has more
information on that.

> This is more of what I was expecting.
> 
> /* Offset 0x09: Event Status */
> #define MV88E6352_TAI_EVENT_STATUS		0x09
> #define MV88E6352_TAI_EVENT_STATUS_CAP_TRIG	0x4000
> #define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
> #define MV88E6352_TAI_EVENT_STATUS_VALID	0x0100
> #define MV88E6352_TAI_EVENT_STATUS_CTR_MASK	0x00ff
> /* Offset 0x0A/0x0B: Event Time Lo/Hi. Always read together with Event Status */

Okay, I'll change it to that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

