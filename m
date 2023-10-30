Return-Path: <netdev+bounces-45188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433507DB542
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C708EB20D89
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182FEA4A;
	Mon, 30 Oct 2023 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lE64VVpA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C40D2F3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:37:47 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC3B4
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698655064; x=1698914264;
	bh=0MjG7vhtzY0IVoXAS8UeP+C/VlIo+0UC/dER+pqvngY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lE64VVpATEY/30Wm7MeQN+PPjDys7QwAiQJ6U4wJT8BPZGb0t7jyH+hZMKvO6IJQN
	 SeR/yO707sBdOPUoNaeq2uG4XN5xzGcblo9aOJsIaCG72pNJNh3p5/RaBTqIwXUKzH
	 kVG4+5JeidQTrjUbjMgTlS+H2XyB8vItktff70HQWEvm9T5Y/4KfEWEElMCb26RUVa
	 wKyIISqhm+ca6AINzTc42L7PpJKf1hnP42y1AN6eilBSt8zFKyjXMLE8MAPy1MYAiP
	 c/NDYHdkHfy7ioq5RTEVanDEfcM0VkBBPkucyMrWZc83NkFt4m8RAXEWHczq03lUov
	 UWqlF6YgL9Wnw==
Date: Mon, 30 Oct 2023 08:37:33 +0000
To: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <c3fbe144-9b17-4e25-929d-9785901dfaa4@proton.me>
In-Reply-To: <03089090-6822-439b-a725-bd907b6d69ce@lunn.ch>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me> <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch> <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me> <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com> <03089090-6822-439b-a725-bd907b6d69ce@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.23 18:32, Andrew Lunn wrote:
>> The current code is fine from Rust perspective because the current
>> code copies phy_driver on stack and makes a reference to the copy, if
>> I undertand correctly.
>>
>> It's not nice to create an 500-bytes object on stack. It turned out
>> that it's not so simple to avoid it.
>=20
> Does it also copy the stack version over the 'real' version before
> exiting? If not, it is broken, since modifying state in phy_device is
> often why the driver is called. But copying the stack version is also
> broken, since another thread taking the phydev->lock is going to get
> lost from the linked list of waiters.

It does not copy the stack version over the original. Since we only read
the `link` field in the discussed function and we hold the lock, it should
not get modified, right? So from a functional viewpoint there is no issue.
(Aside from increased stack size and the data race issue etc.)

> Taking a copy of the C structure does seem very odd, to me as a C
> programmer.

It is also odd in Rust.

--=20
Cheers,
Benno



