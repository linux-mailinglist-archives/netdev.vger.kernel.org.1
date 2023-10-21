Return-Path: <netdev+bounces-43256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B257D1E43
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DF8B20E5C
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FAFBEE;
	Sat, 21 Oct 2023 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VajpImTp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF22208B1
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 16:31:51 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FE112
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697905903; x=1698165103;
	bh=/R3b3Uby0tPUxUMEGn7N7zK5JjMjmZWHqpWHTu+T4zo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VajpImTpwW7K5kNGfWpUVB9Olyyj8OiINDjZRSZrg6gqI8B7MYkhoaME99ghUlcZR
	 toKjMq0YeNPN658vOe8r7eqM2P1YDU2jKF5QKZplg8+p3q+u7v4444IjD1Pf67jfkL
	 U5ZDN9TXUm6fHejKx5Yo4Ra/wUBbr/RjrmwXCA9w4zxHIYhQ5ZIgHk/8jlSAy3PU0Z
	 GR9us/ATjAbIEHhGD0hEQqqCpnIN9oyj8FXd1WMXyCXgPTDsTNmMxh1LMZFfueoxdp
	 sMHVU7Zmwoiy4rRry6hc8mbnFUA/XtNvgtLFCp+638ZvATCQkzpld3ZCT4NalefUtC
	 xcrZ8QE9tyC7w==
Date: Sat, 21 Oct 2023 16:31:32 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <5e493b59-728a-43ee-a503-3ad989579720@proton.me>
In-Reply-To: <bbd1b455-a228-4523-a18c-58792925dd85@lunn.ch>
References: <d8b23faa-4041-4789-ae96-5d8bf87070ad@proton.me> <20231021.213834.76499402455687702.fujita.tomonori@gmail.com> <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me> <20231021.220012.2089903288409349337.fujita.tomonori@gmail.com> <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me> <bbd1b455-a228-4523-a18c-58792925dd85@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 17:57, Andrew Lunn wrote:
>> I see, what exactly is the problem with that? In other words:
>> why does PHYLIB need `phy_driver` to stay at the same address?
>=20
> Again, pretty standard kernel behaviour. The core keeps a linked list
> of drivers which have been registered with it. So when the driver
> loads, it calls phy_driver_register() and the core adds the passed
> structure to a linked list of drivers. Sometime later, the bus is
> enumerated and devices found. The core will read a couple of registers
> which contain the manufactures ID, model and revision. The linked list
> of drivers is walked and a match is performed on the IDs. When a match
> is found, phydev->drv is set to the driver structure. Calls into the
> driver are then performed through this pointer.

We have several examples of abstractions over things that embed linked
lists upstream already (e.g. `mutex`) and have developed a special API
that handles them very well. This API ensures that the values cannot be
moved (and if one tries to move it, the compiler errors). In this case
I was not aware of the requirement -- and it was also not noted in any
SAFETY comment (e.g. on `phy_drivers_register`).

> A typically C driver has statically initialised driver structures
> which are placed in the data section, or better still the rodata
> section. They are not going anywhere until the driver is unloaded. So
> there is no problem keeping them on a linked list. Dynamically
> creating them is unusual. They are just structures of pointers to
> functions, everything is known at link time.

In the ideal case I would just like to store them inside of the
`Module` struct (which is placed in the data section). However,
that requires Wedson's patch I linked in this thread.

--=20
Cheers,
Benno


