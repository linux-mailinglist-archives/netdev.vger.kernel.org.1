Return-Path: <netdev+bounces-68886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CB848B12
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 05:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6910BB23A5C
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 04:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA017F7;
	Sun,  4 Feb 2024 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uLWl3YQo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010286127
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021977; cv=none; b=VS6QUPB1dFrDrkLdyOrbAltm7WZXx+sP+/QVmVMMf5MrTBcfuZz3tj7uzR4YK6B4MM39aXnVzz9gdqEUaUf+XBIKZWNkh6z2emr7OmFJM5tbK2FYCj5kIKQCEVaI3DIxSqNq8HBS5bb+rD9qurOVIQsStlSN+E1+wZJaZvGgtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021977; c=relaxed/simple;
	bh=AI1tsVcwCyhE2nIdp74GYCaBxWYQEjgqsJJfenRBYkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8C523bQBnlLW3i32Tz5NXYXwoPaiRhstdNCMG6CX93Tc7lMbkvckKasWYMfdHNJA4k9rm3FS2AmHU44/L8a78qSpiim1h+KNV8vpOyF34ViGkUm3aDcYc7S+D64pH/gLQ+tjIB7nLe1yaFhy00OSedm1BzuX1WU7EV8efOOqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uLWl3YQo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GaPcsxiBtGjKaf9jWGPAcwiCQqDvoPcDFw9cLud6UyY=; b=uL
	Wl3YQoJiFn5aXjMJvbriLc3Nb5JM5lXMvoNxiMeMZ6IH7p2yumRgyN13K9hQXI7MMi/DzRQ8w5WaZ
	4B6xfSGeIXGMzB/3EcqSy7UWdrgGmcPt3qQOduwBlnvCIAurj+GSO7oJHm675q0DhsSXZqAmYGwx4
	4PEwCR6F/EPT0hE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWUOH-006wLT-8G; Sun, 04 Feb 2024 05:46:01 +0100
Date: Sun, 4 Feb 2024 05:46:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Message-ID: <4cafbe42-5050-4e98-aaab-fc05f76a32b4@lunn.ch>
References: <10510abd-ac26-42d0-8222-8b01fe9b8059@gmail.com>
 <e65b8525-eae0-4143-aa57-009b47f09005@lunn.ch>
 <CACKFLinhkS8-=QtZu9Es9ATiSMAyosuCfuPVFUOxzqJk4Tr2rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinhkS8-=QtZu9Es9ATiSMAyosuCfuPVFUOxzqJk4Tr2rA@mail.gmail.com>

On Sat, Feb 03, 2024 at 04:16:51PM -0800, Michael Chan wrote:
> On Sat, Feb 3, 2024 at 1:59 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > -     if (!edata->advertised_u32) {
> > > -             edata->advertised_u32 = advertising & eee->supported_u32;
> > > -     } else if (edata->advertised_u32 & ~advertising) {
> > > -             netdev_warn(dev, "EEE advertised %x must be a subset of autoneg advertised speeds %x\n",
> > > -                         edata->advertised_u32, advertising);
> >
> > That warning text looks wrong. I think it should be
> >
> > EEE advertised %x must be a subset of autoneg supported speeds %x
> >
> > and it should print eee->supported, not advertising.
> >

> I think it is correct.  EEE advertised must be a subset of the
> advertised speed.

I don't think that is true. At least, i've not seen any other MAC/PHY
driver change EEE advertising when they change the general
advertising. What i expect is that the PHY and link partner first
resolve the general link speed. They then look at what is being
advertised in terms of EEE and decide if EEE is being advertised by
both ends at the resolved speed. So it does not matter if the link
speed is resolved at 1G, but both ends advertise both 40G and 1G for
EEE. The 40G is simply ignored because they have resolved to 1G.

What does however matter is that EEE supported lists only 1G, but user
space ask for both 1G and 40G to be advertised. I would expect the
driver to mask the requested advertised with support, see that
unsupported link modes are being asked for and return -EINVAL.

	Andrew

