Return-Path: <netdev+bounces-179444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D3A7CBD9
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CCB16DF08
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E820330;
	Sat,  5 Apr 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YlgVg4fD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB63FC3
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743886444; cv=none; b=PO1gSLCBfby520euF27+Q390OYLWCZj6i5rLajh1oUBQSK8fkO5W8kMAhfci+cXGhMxVvWMIsbX7NID4UQd057OZpLWGoardH5tSiyImHqDA2ZmHkxRTAyqL0gE6wMgDRZrtLCo+SwVnaKDcP923A0JBykla5OoMmncMZRb31Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743886444; c=relaxed/simple;
	bh=uhfi5oNfo/10SbmK8vrhr+Uh5xy9kScKj1CVOCQYpk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ9sljxhT7n/aiRaqnFSxtwR7vjSGilGGxQp03A8Ouc3djZ0X8wYmXOkUbCs7AcqvCZYy/H/ZTBMxakOaer8wwgczcDehIrHGY5jlb4AwAoz6coRE4d25IqePh8W5IrQkmkfhtLM23oqTYIwqnS0mzwc97jdePQFaRDdvfaFxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YlgVg4fD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cLH9MSPwb0T4ZtsP3iJYbThMG7q7pctmLhzYRxXvDlQ=; b=YlgVg4fDDYWUN+wqpTeqNPca12
	EFKcd4MxMLqGj1jU/nZgHr7fa/YZOoQlcnYNxNBwJ4HczxqA1C7hFE7Psr7c8pF8ZyO1v26PGq921
	KIGYfvXHc5nQfz0McNoRKDoTL/zvwfM3/3GgK4vyqiq5Ql9k6r3/qXtOR2uwSAd8FBfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1AWZ-0088Cd-At; Sat, 05 Apr 2025 22:53:55 +0200
Date: Sat, 5 Apr 2025 22:53:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <674f5050-1d87-45bc-a117-e4bf233d7045@lunn.ch>
References: <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
 <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
 <eb115770-a8b1-4806-b8b9-ec98f44a98ee@lunn.ch>
 <CAKgT0Uf1R0BadAZe0ANMpS00AZB228e2-Am9LaZxzeSTCWS4aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf1R0BadAZe0ANMpS00AZB228e2-Am9LaZxzeSTCWS4aQ@mail.gmail.com>

> So the ugly bit for us is that there are no MII interfaces to the PCS
> or PMA. It is all MMIO accesses a register map and a number of signals
> were just routed to registers in another section of the part for us to
> read to or write from.

The API is pretty forgiving, so you might be able to make it look like
a normal device. You need to implement:

        /** @read_c45: Perform a C45 read transfer on the bus */
        int (*read_c45)(struct mii_bus *bus, int addr, int devnum, int regnum);
        /** @write_c45: Perform a C45 write transfer on the bus */
        int (*write_c45)(struct mii_bus *bus, int addr, int devnum,
                         int regnum, u16 val);

It could be you can implement a lookup table to map (devnum, regnum)
to an MMIO address.

	Andrew

