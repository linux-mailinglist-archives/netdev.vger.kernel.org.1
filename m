Return-Path: <netdev+bounces-132487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE290991DEB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE7A1C20E92
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB71741F0;
	Sun,  6 Oct 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="dq8y0TQ0"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919952F2E;
	Sun,  6 Oct 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211513; cv=none; b=fRIpXCDKex74ySwBtoYBOy8hZXG+6Nc5o4fpqQrihUTYXIf/pb7KjRUnHsXE6o41i5AbzULGVVewuvm2Wet2dqJ5SmrdE5AXfMCQHtlgML2t4PXS0XDZNXkt/A9npf7gMiVkUAS1Lz+kch/eef8zK3Ud3TtCCDBjA67zWH9gUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211513; c=relaxed/simple;
	bh=CPhsJDr1Y8WXIZybKLVZDghsipg79KfwwGX3fuXsAZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT4wHCEK8z+ErniDwKwnXIG7VfcXftkVi6gNXzNW7ChIVu9HlVsblqQtu4NIUQQ9tW4hWL568aOBhlsedVExs9+1CzoV5bRRtHTh3tTfNDoe1W8OQlcQIEr59nlMzRfJ41NZy66g1yBScLf8xBcfHMvLjUIK7kLuFAo024vpZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=dq8y0TQ0; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1728211507; bh=x4bc5/MtmtxPmd8Avrd5pQhLXoVlTs3I+eKRvlangz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dq8y0TQ0ZhAjglJ0eWWsvZNxDSR/1P1QD859vD9H/koF/h27qzKjqVTOQxwOcyQdA
	 95dHY76TMK4X8K472BeYXJ6Hr4AIMDFaOwubKs1cl/1G9vUBCaDLoRZdHeXijXesLW
	 7xRVsevhh+67sH64lKF3tGzE5tYQezeDyeQ11aYI=
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime
 and Delta
Date: Sun, 06 Oct 2024 12:45:06 +0200
Message-ID: <A3581250-0876-42FC-9B3F-67F437CC16AC@kloenk.dev>
In-Reply-To: <e540d2cd-2c47-4057-9000-8d403247abf6@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-4-fujita.tomonori@gmail.com>
 <e540d2cd-2c47-4057-9000-8d403247abf6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 5 Oct 2024, at 20:07, Andrew Lunn wrote:

> On Sat, Oct 05, 2024 at 09:25:28PM +0900, FUJITA Tomonori wrote:
>> Implement Add<Delta> for Ktime to support the operation:
>>
>> Ktime =3D Ktime + Delta
>>
>> This is used to calculate the future time when the timeout will occur.=

>
> Since Delta can be negative, it could also be a passed time. For a
> timeout, that does not make much sense.
>

Are there more usecases than Delta? Would it make sense in that case to a=
lso implement Sub as well?

Thanks,
Fiona

>> +impl core::ops::Add<Delta> for Ktime {
>> +    type Output =3D Ktime;
>> +
>> +    #[inline]
>> +    fn add(self, delta: Delta) -> Ktime {
>> +        // SAFETY: FFI call.
>> +        let t =3D unsafe { bindings::ktime_add_ns(self.inner, delta.a=
s_nanos() as u64) };
>
> So you are throwing away the sign bit. What does Rust in the kernel do
> if it was a negative delta?
>
> I think the types being used here need more consideration.
>
>     Andrew

