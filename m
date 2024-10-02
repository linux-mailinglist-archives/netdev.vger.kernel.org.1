Return-Path: <netdev+bounces-131349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C298E39F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D71C232C4
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035AE215F56;
	Wed,  2 Oct 2024 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xPKtvFVo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ev24RbBL"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF912CD88;
	Wed,  2 Oct 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898048; cv=none; b=OaF5FN3IpIk3CiQuZtOQNBbz3ABjkHSqcSqHOh1kSf6WMkVSsSeRj97VL+BVJ7mQTGl0pRZmRlVlXGNzc8RRlG/K/+HXGR1lc3L6yHBpXa15IZTqDMkosvDvyeI18s56YLDWvUv5QW64IDuCYxgQw2sePxEmJNkLUrdKk3caTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898048; c=relaxed/simple;
	bh=LILyfyev/WklbWpVcaXNQXycUXDsHTF3JRuSQOIk+DM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZZ9sJk2Kt/L0zMPkWTbrBm+ewBEwl7LRQmTEEJYbvUD8Er5/eumlKYS8h/waI7W3ZMeF971OPYebrO2ncR0sMrtKJCAYHtqzMRRmKTBuK9BFlCeV3yG6NFy/QLHYutm5wH1FwXVWl5WDLEC40j/hHj9NUHUx5Hr9Lc+WKmovGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xPKtvFVo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ev24RbBL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727898045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EhGotuDayjNZLZBOQ5uImVIDZz84kz1QRNGB91lT0Q=;
	b=xPKtvFVoktK4YMdSk6d2HV4q3M/aSa9mDnoMsMkAd9zCf7mITj3aIm3opnDTf6WAWllspx
	sY0wQIl/Q5c5pKJzrYTzea4/eZy8jsgimNQZrg69+xAbjdReI3MmSK+lDFHO81xvHzgHVY
	nERrcfw6ZbJtHN9A91u2s3/cJUX/mqOELGfJ8cV0XjUwtk6ThCMtY0abzzOIib1loHmfG9
	4N3z8jMag7X7YpJNJQSqJlzpqfUfpS4qeJMl/9NeFYpoLX7qUr+FF0gIi1ifvbhgfw+HnD
	acxaIagAXQcNgoXC/ZHyKcDMz8gd+Dnx0LN061nBmS3D9V/37aE6hzsLnlceMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727898045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EhGotuDayjNZLZBOQ5uImVIDZz84kz1QRNGB91lT0Q=;
	b=ev24RbBLEsZg6NUCvyOpzhTcjVtGpdoAIBp1DD5S4KR+tJx4apG1i8Xf1goS32MhE87Sb4
	wdgSmDLH6oF/0SAA==
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
In-Reply-To: <CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
References: <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
 <20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
 <CAH5fLgj1y=h38pdnxFd-om5qWt0toN4n10CRUuHSPxwNY5MdQg@mail.gmail.com>
 <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
 <CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
Date: Wed, 02 Oct 2024 21:40:45 +0200
Message-ID: <87bk02wawy.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02 2024 at 16:52, Miguel Ojeda wrote:
> On Wed, Oct 2, 2024 at 4:40=E2=80=AFPM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
>>
>> Sure. Some code use ktime_t to represent duration so using Ktime for
>> the delay functions makes sense. I'll add some methods to Ktime and
>> use it.
>
> We really should still use different types to represent points and
> deltas, even if internally they happen to end up using/being the
> "same" thing.
>
> If we start mixing those two up, then it will be harder to unravel later.
>
> I think Thomas also wanted to have two types, please see this thread:
> https://lore.kernel.org/rust-for-linux/87h6vfnh0f.ffs@tglx/ (we also
> discussed clocks).

Correct. They are distinct.

Btw, why is this sent to netdev and not to LKML? delay is generic code
and has nothing to do with networking.

Thanks,

        tglx

