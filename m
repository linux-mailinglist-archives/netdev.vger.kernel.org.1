Return-Path: <netdev+bounces-45279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5F7DBE36
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D2EB20C24
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AE18AE9;
	Mon, 30 Oct 2023 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AKkvXzPc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAEE179BD
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:45:51 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32DBD
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wkbu3yfqxrarpmy63ckbs5nyge.protonmail; t=1698684347; x=1698943547;
	bh=CQ62yiP4YAeNGVwQvdyT+r74XigJb1jet13gT8EdrNE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AKkvXzPcgmN11YmiGJvz4hEbugpcDQzya4q6Pd8ha4DYLk0rSD4vAIeCiJBNCGf/C
	 p/laJD1o3ThHr+vA5G0J5K2xiDZgUFaNH+uVpubhrgYYvohfSrUSGHKBdDB0iHGb2e
	 97lqZEH0tAEun0hXtFAuYOqMrv78fvz/iY2kPelULLzVfzri6gE/K+YVEDfNGmwtE9
	 b7Jc5+DWzHqMNFnWMTKnCHyIhp3aU9e97r+SQXHSMN+hzdW08Oig83TaH1y4eghfW9
	 02pVHEk+tjbZOfLOsbdAu0bJafcL69WdTg0a8xM4GSm1ZYUUocqK2vayZluHHWMBaN
	 E9DU9C9iyV/yw==
Date: Mon, 30 Oct 2023 16:45:38 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <1e6bd47b-7252-48f8-a19b-c5a60455bf7b@proton.me>
In-Reply-To: <20231030.214906.1040067379741914267.fujita.tomonori@gmail.com>
References: <20231030.075852.213658405543618455.fujita.tomonori@gmail.com> <ZT72no2gdASP0STS@boqun-archlinux> <41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me> <20231030.214906.1040067379741914267.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.23 13:49, FUJITA Tomonori wrote:
> On Mon, 30 Oct 2023 08:34:46 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>> Both comments by Boqun above are correct. Additionally even if the write
>> would not have a data race with the read, it would still be UB. (For exa=
mple
>> when the write is by the same thread)
>>
>> If you just read the field itself then it should be fine, since it is
>> protected by a lock, see Boqun's patch for manually accessing the bitfie=
lds.
>=20
> The rust code can access to only fields in phy_device that the C side
> doesn't modify; these fields are protected by a lock or in other ways
> (resume/suspend cases).

No it could access all fields in `phy_device`, which means it could also
access `phy_device.lock`. Since that is a mutex, it might change at any
time even if we hold the lock.

>> But I would wait until we see a response from the bindgen devs on the is=
sue.
>=20
> You meant that they might have a different option on this?

No, before you implement the workaround that Boqun posted you
should wait until the bindgen devs say how long/if they will
implement it.

--=20
Cheers,
Benno



