Return-Path: <netdev+bounces-43251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C07D1DE9
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B931FB20D4B
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2961803F;
	Sat, 21 Oct 2023 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DHsr65sW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F163101C8;
	Sat, 21 Oct 2023 15:35:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67760114;
	Sat, 21 Oct 2023 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BOtD5D0dzVsF1bhfF5AoC3Ucig1y1mWUDWFf9HgLUlk=; b=DHsr65sWp8mPj6tGeXprv9XKyu
	Ts8hGULbA5gh7oa0NfOj2SUuY390VUAbjnJ6wCOD7krPCd3zyDK/gu7zy64b7PpFh5VqRRp2qOkl+
	dAJ0YF4bHcvP0jZeuoDdh787Nn60rrGT4x1fYZxKZANKxggXsJHafUjDeJCxmyqEj4qo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quE0e-002tjx-VH; Sat, 21 Oct 2023 17:35:28 +0200
Date: Sat, 21 Oct 2023 17:35:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <eb59a6ce-48f3-4fcc-87cd-4ec4b948617d@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
 <de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch>
 <20231019.094147.1808345526469629486.fujita.tomonori@gmail.com>
 <64748f96-ac67-492b-89c7-aea859f1d419@proton.me>
 <b58e0874-b0d4-4218-a457-4e2e753e0b17@lunn.ch>
 <d7098404-e34e-4067-8d0e-778922aa15a1@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7098404-e34e-4067-8d0e-778922aa15a1@proton.me>

> I think Rust will make a big difference:
> - you cannot access data protected by a lock without locking the
>    lock beforehand.
> - you cannot forget to unlock a lock.

It is going to be interesting to look at this in 5 to 10 years time.
By then we hopefully have Rust drivers in subsystems which do the
locking in the core and those which leave it to the drivers. We can
then see if Rust written drivers which have to handle locking do
better than C drivers, or is it still better to do it all in the core.

> >> We already have exclusive access to the `phy_device`, so in Rust
> >> you would not need to lock anything to also have exclusive access to the
> >> embedded `mii_bus`.
> > 
> > I would actually say its not the PHY drivers problem at all. The
> > mii_bus is a property of the MDIO layers, and it is the MDIO layers
> > problem to impose whatever locking it needs for its properties.
> 
> Since the MDIO layer would provide its own serialization, in Rust
> we would not protect the `mdio_device` with a lock. In this case
> it could just be a coincidence that both locks are locked, since
> IIUC `phy_device` is locked whenever callbacks are called.
> 
> > Also, mii_bus is not embedded. Its a pointer to an mii_bus. The phy
> > lock protects the pointer. But its the MDIO layer which needs to
> > protect what the pointer points to.
> 
> Oh I overlooked the `*`. Then it depends what type of pointer that is,
> is the `mii_bus` unique or is it shared? If it is shared, then Rust
> would also need another lock there.

There can be up to 32 PHY drivers using one mii_bus, but in practice
you never get this density. Because there can be multiple PHYs this is
why the mii_bus has a lock, to serialise accesses from those PHYs to
the bus.

And MDIO is to some extend a generic bus. Not everything on an MII bus
is a PHY. Some Ethernet switches are MDIO devices, and they often take
up multiple addresses on the bus. But the locking is all the same.

PHYLIB core holds a reference to the MII bus, so the bus is not going
to go away before the PHY goes away. This is all standard Linux
bus/clients locking. It gets a bit messy with hot-plug, devices like
USB devices. The physical hardware can disappear at any time, but the
software representation stays around until it gets cleaned up in a
controlled manor. So a read/write on a bus can fail because its
physically gone, but you don't have to worry about the mii_bus
structure disappearing.

    Andrew

