Return-Path: <netdev+bounces-131247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A898DB99
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E9E1C21C6D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D61D0F6F;
	Wed,  2 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0NdXQnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3F1D0F66
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879253; cv=none; b=p8avfripfmIcyoGIv3N2LDWkmJwxC8LH16Zqs9y44R1zKztdmTfCvkgvaAncTYN2rAGqlhxHB75Ei8TWijmaCaySAQii06LjWTGu91ADiTkuSTwP4XvqJidOwn/unVucqDcdWNt6DLQiYysSg852hnuv1maULzxBlugFAWy0520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879253; c=relaxed/simple;
	bh=6gZGtwXT0UeHa4PCsRrEyrA1BaUn/tinw6lXWkQk/a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0IBYB6tWAcAavlTGdtYXyp3+OZ6fUZz2THRtr5Np3QhYmjKta29zwiZOjWCXaU8Yb+huEmz30MdbSGYJe04j57sIgP2ZkGJcfblqFFdXUJih3QRC7f72KHId174Zk3z4n1IAQnoyucwQGiCFJp4JGMI5WS32o8SA236v262u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0NdXQnP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso3922952f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727879249; x=1728484049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vome0jBYeRQ880YVIwEIz5cqcUYdUm5aLZDCRbiT54=;
        b=K0NdXQnPQeVOE/MhbS+419sJN1b5Ak3tpwoFy5r7xYvgE7IKcgJxff8s+dJ7bwOs/y
         eeM50L9GfHdMFv9sKnUwsnk3G3U2XJ9ix0H8agBk54P9PUHHVBVgSZrBEa7XjlZbDAUv
         RrDci5eQfxL/6ecHMUDa9+GwfV2StZnSAByEFHaShZDIqREbwNywsbWMeNjKxCA3VpOi
         hnt22Z5jePS/lv0CdmN2UaQeu7uzvz/JbWR6Zf/1AU+fDgSxui7d2jemDRX6/qcTpa+h
         OjQM4KbTmHTNjwlp20FnTJ/NTwbkjQkPAoXMR2u4XaN8K7ItyCHjkoi6l59gg0HiRYgy
         yrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879249; x=1728484049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vome0jBYeRQ880YVIwEIz5cqcUYdUm5aLZDCRbiT54=;
        b=wDqYVqpUIl0kN6Od7YsttwueYnulnyJ6LCkqenaK9JTGRgqFtEfSO1Bi0rc6Bs8Ic+
         MmTwHIFU0k2s7rnLZac6a25qc7kiaKLGuxwC6GUf2DfP/HjqJun1MUAzYoUFMB26sJuC
         J8yFHuxIvsIw7uD53dm/G4447VZ6gXk4MTVu7T7vbJh1yjrkw+DAlX6o3ORlFmw6JFEp
         RvCPDmDJwlyvqRKaKkorQ0rHfaF0rBlJYLCxweZuqMIOOEocsl0KB4MOgoB2+nVXvQkP
         aiHiOAJu5E2Q2lSSlG384mUoEtR0SWntd6IwZMkEs9f4APVofvfE2f0KFN/gLBdj1pdO
         7wGg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ofm0qRw3/mnzUjVXR8XC4MtEEEvs6TToW9EWOzzPdslKPFFm/ImpAxr/gWoRKm6+R3OiKLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jO98nY3jMFvEm7NVFnWThw3WnSZCyu6kU+eObgsnF+dlCH/y
	1FbIvdniNQF0M2tivax5xe1HUbnVEliFq2dqC9QnS3hdw2yqtxI1pAxLM9gnvDyput+srTCYkN4
	VpXl4SE5Kv9x1OklJ24iTPiBgrtNyP/72vVOQ
X-Google-Smtp-Source: AGHT+IGukuBN9cCJnVsbKBYae7JrAL7IzazwuaA/viB7RcfQC4VkWNFvvdb7cwNkh3i36oLMPb9Gx6/8exNHfYwBlkM=
X-Received: by 2002:a05:6000:18a1:b0:37c:d569:467e with SMTP id
 ffacd0b85a97d-37cfba20c94mr2763175f8f.59.1727879248680; Wed, 02 Oct 2024
 07:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
 <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch> <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
 <20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
In-Reply-To: <20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 16:27:17 +0200
Message-ID: <CAH5fLgj1y=h38pdnxFd-om5qWt0toN4n10CRUuHSPxwNY5MdQg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:58=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 2 Oct 2024 14:37:55 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Wed, Oct 2, 2024 at 2:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> >>
> >> > > I would also document the units for the parameter. Is it picosecon=
ds
> >> > > or centuries?
> >> >
> >> > Rust's Duration is created from seconds and nanoseconds.
> >>
> >> How well know is that? And is there a rust-for-linux wide preference
> >> to use Duration for time? Are we going to get into a situation that
> >> some abstractions use Duration, others seconds, some milliseconds,
> >> etc, just like C code?
> >>
> >> Anyway, i would still document the parameter is a Duration, since it
> >> is different to how C fsleep() works.
> >
> > I'm not necessarily convinced we want to use the Rust Duration type.
> > Similar questions came up when I added the Ktime type. The Rust
> > Duration type is rather large.
>
> core::mem::size_of::<core::time::Duration>() says 16 bytes.
>
> You prefer to add a simpler Duration structure to kernel/time.rs?
> Something like:
>
> struct Duration {
>     nanos: u64,
> }
>
> u64 in nanoseconds is enough for delay in the kernel, I think.

That type already exists. It's called kernel::time::Ktime.

Alice

