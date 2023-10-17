Return-Path: <netdev+bounces-41939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A076C7CC58A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52AA1C20A4B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29BB43A92;
	Tue, 17 Oct 2023 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="izYj5Ga6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82C436AF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:05:06 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304FF5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697551501; x=1697810701;
	bh=WbdP5fcQx3fwBJjucXlAM/p4DeJcbvea89fpjicPDuM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=izYj5Ga6Cz2CtBXXdG4cukES/JT4vVkO/l8Df/chhwTefcLTP6DCoiOS8z7qJS6p6
	 ZS224f9z204CDVcwQ6bS+GmmbZ7lznwx329FkJL0/8eowidB85Tmd9+RQSoN4iB1uL
	 jLPLwfowtMZjxTESljz0voATZTqVqq7nHu3thUlhf9GkfkJfO+rOG1jKvLNDhEx53y
	 0hH4UxOR3Qm+lYn3Csql71tt9es8qcf3GpCwhXFEm1RuDFjGYg5TdInVFwrVWJaVqf
	 V2vM6opC48mgLU5DZvfXlZvmm3ZfnMziZMB3bmODNnU/Tdkq64Gc3ztzI2OU/wnDWy
	 bHKt+FLjx9DFQ==
Date: Tue, 17 Oct 2023 14:04:33 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me>
In-Reply-To: <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me> <20231015.011502.276144165010584249.fujita.tomonori@gmail.com> <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com> <98471d44-c267-4c80-ba54-82ab2563e465@proton.me> <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.10.23 14:38, Andrew Lunn wrote:
>>> Because set_speed() updates the member in phy_device and read()
>>> updates the object that phy_device points to?
>>
>> `set_speed` is entirely implemented on the Rust side and is not protecte=
d
>> by a lock.
>=20
> With the current driver, all entry points into the driver are called
> from the phylib core, and the core guarantees that the lock is
> taken. So it should not matter if its entirely implemented in the Rust
> side, somewhere up the call stack, the lock was taken.

Sure that might be the case, I am trying to guard against this future
problem:

     fn soft_reset(driver: &mut Driver) -> Result {
         let driver =3D driver
         thread::scope(|s| {
             let thread_a =3D s.spawn(|| {
                 for _ in 0..100_000_000 {
                     driver.set_speed(10);
                 }
             });
             let thread_b =3D s.spawn(|| {
                 for _ in 0..100_000_000 {
                     driver.set_speed(10);
                 }
             });
             thread_a.join();
             thread_b.join();
         });
         Ok(())
     }

This code spawns two new threads both of which can call `set_speed`,
since it takes `&self`. But this leads to a data race, since those
accesses are not serialized. I know that this is a very contrived
example, but you never when this will become reality, so we should
do the right thing now and just use `&mut self`, since that is exactly
what it is for.

Not that we do not even have a way to create threads on the Rust side
at the moment. But we should already be thinking about any possible
code pattern.

>>>> What about these functions?
>>>> - resolve_aneg_linkmode
>>>> - genphy_soft_reset
>>>> - init_hw
>>>> - start_aneg
>>>> - genphy_read_status
>>>> - genphy_update_link
>>>> - genphy_read_lpa
>>>> - genphy_read_abilities
>>>
>>> As Andrew replied, all the functions update some member in phy_device.
>>
>> Do all of these functions lock the `bus->mdio_lock`?
>=20
> When accessing the hardware, yes.
>=20
> The basic architecture is that at the bottom we have an MDIO bus, and
> on top of that bus, we have a number of devices. The MDIO core will
> serialise access to the bus, so only one device on the bus can be
> accessed at once. The phylib core will serialise access to the PHY,
> but when there are multiple PHYs, the phylib core will allow parallel
> access to different PHYs.
>=20
> In summary, the core of each layer protects the drivers using that
> layer from multiple parallel accesses from above.
Thanks for this explanation, it really helps!

--=20
Cheers,
Benno



