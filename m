Return-Path: <netdev+bounces-43254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27457D1E13
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5173EB20E96
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66ADDC5;
	Sat, 21 Oct 2023 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BGny6SfY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B481A714;
	Sat, 21 Oct 2023 15:58:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D9F98;
	Sat, 21 Oct 2023 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6BRvKNJQurqeIt1Yl7Te1Oixeykoc6vsZKgReXOOJVU=; b=BGny6SfYfD/Bi48H3eJD5lf2NJ
	j++mic9QrOWGryFkBOHuOm64+fzbPronHEvoFpcL3YSuy6GBBIrrHgQybyv1cutegJdxg7FfN9BUf
	mka5wWMY+GHkuFgW0CKlJUdeJvUogzg3ySg8Mbkbb9+FD1AoHs6QxQuPeyb9Vb9IuOgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quEMM-002tnX-SP; Sat, 21 Oct 2023 17:57:54 +0200
Date: Sat, 21 Oct 2023 17:57:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <bbd1b455-a228-4523-a18c-58792925dd85@lunn.ch>
References: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me>
 <20231021.213834.76499402455687702.fujita.tomonori@gmail.com>
 <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me>
 <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com>
 <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>

> I see, what exactly is the problem with that? In other words:
> why does PHYLIB need `phy_driver` to stay at the same address?

Again, pretty standard kernel behaviour. The core keeps a linked list
of drivers which have been registered with it. So when the driver
loads, it calls phy_driver_register() and the core adds the passed
structure to a linked list of drivers. Sometime later, the bus is
enumerated and devices found. The core will read a couple of registers
which contain the manufactures ID, model and revision. The linked list
of drivers is walked and a match is performed on the IDs. When a match
is found, phydev->drv is set to the driver structure. Calls into the
driver are then performed through this pointer.

A typically C driver has statically initialised driver structures
which are placed in the data section, or better still the rodata
section. They are not going anywhere until the driver is unloaded. So
there is no problem keeping them on a linked list. Dynamically
creating them is unusual. They are just structures of pointers to
functions, everything is known at link time.

	Andrew

