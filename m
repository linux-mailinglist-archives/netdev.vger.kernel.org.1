Return-Path: <netdev+bounces-43345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978667D2A85
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD381C2085F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588EB5670;
	Mon, 23 Oct 2023 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ctnLLCxV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869015693
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 06:36:11 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF2D75
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 23:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698042965; x=1698302165;
	bh=zPF2RQ2OFzJ6gq6NUSE8gDXRJMxY86Zjx2W0Sl9O7KM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ctnLLCxVNnlWrhKCBU39EvSYg6feTvpGc2U/vdMQkzS8thpN8j66RdWsnSsGJqlEV
	 mAXULNAo6l54ktQodFEE/HDmPRlDrSVzO6f5OHF+ocbbZ1RbrNPWCZouTuznFxqSaw
	 9HLQVUdE4tlZdu3YiyXtoVi5AB7kKK5lyjR1/fGvd4Exijved2uVtCMXt1cPid13sp
	 iARE8M0710PRHiGid9kdGL9aOM/K7iJRwcty/Ns2c4w0gnsJgweAMyeIgMhVDtYiIc
	 Di5z7HcQdLNG5uTTmuYgFPinlsQEZtmLwY4kDlPDww2XvI3BGK8YdyuWiYlDpuUB0N
	 d02kKxpbNc+EA==
Date: Mon, 23 Oct 2023 06:35:58 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <7e6ae279-9667-409f-9818-95683118971f@proton.me>
In-Reply-To: <20231022.064501.394351620043801227.fujita.tomonori@gmail.com>
References: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me> <20231021.223115.1115424295905877996.fujita.tomonori@gmail.com> <cd3ff8e6-214e-4a80-980e-e92751223002@proton.me> <20231022.064501.394351620043801227.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 23:45, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 13:35:57 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>> Currently, it needs &'static DriverVTable
>>> array so it works.
>>
>> That is actually also incorrect. As the C side is going to modify
>> the `DriverVTable`, you should actually use `&'static mut DriverVTable`.
>> But since it is not allowed to be moved you have to use
>> `Pin<&'static mut DriverVTable>`.
>=20
> I updated Registration::register(). Needs to add comments on requirement?
>=20
> impl Registration {
>      /// Registers a PHY driver.
>      pub fn register(
>          module: &'static crate::ThisModule,
>          drivers: Pin<&'static mut [DriverVTable]>,
>      ) -> Result<Self> {
>          // SAFETY: The type invariants of [`DriverVTable`] ensure that a=
ll elements of the `drivers` slice
>          // are initialized properly. So an FFI call with a valid pointer=
.

This SAFETY comment needs to mention that `drivers[0].0.get()` are
pinned and will not change address.

>          to_result(unsafe {
>              bindings::phy_drivers_register(drivers[0].0.get(), drivers.l=
en().try_into()?, module.0)
>          })?;
>          // INVARIANT: The `drivers` slice is successfully registered to =
the kernel via `phy_drivers_register`.
>          Ok(Registration { drivers })
>      }
> }

Otherwise this looks good.

>=20
>=20
>>> The C side uses static allocation too. If someone asks for, we could
>>> loosen the restriction with a complicated implentation. But I doubt
>>> that someone would ask for such.
>>
>> With Wedson's patch you also would be using the static allocation
>> from `module!`. What my problem is, is that you are using a `static mut`
>> which is `unsafe` and you do not actually have to use it (with
>> Wedson's patch of course).
>=20
> Like your vtable patch, I improve the code when something useful is
> available.

Sure. If you have the time though, it would be helpful to know
if the patch actually fixes the issue. I am pretty sure it will,
but you never know unless you try.

--=20
Cheers,
Benno



