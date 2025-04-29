Return-Path: <netdev+bounces-186758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B2AA0F0C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2634A151C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF782163A0;
	Tue, 29 Apr 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc5fz24B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE120E6E4;
	Tue, 29 Apr 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937324; cv=none; b=l4Lgc2ilFfQiVFsoBDvsFdzcy8xauGscUOzKUIw/dodJSL4mZERJF28K/pzo+qpa1nFkt9HGZWXROe8nMWya31qYkDLrM6C3J43ckwElzdHY5eEGiiVN+2CvvBRtqGVu7uNbUNiOMN2bXh4k6KfHMBWaDyEmfQiUngergobM3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937324; c=relaxed/simple;
	bh=M1+knUKG6TTov+SVyavkYGTfg+D4/yr759A0vy/Q4Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA4N2rK1gx6K8ox6WxxUXYGwryz7FjdUonTn7fZLww3E993NjVA2vlJPJRiis6m6EoSuMJLkZBavvRvtOousy5iD1mqYs9whf/vD9+SuejCnupLBphusYzp7CTfAFQTEUopFWEI7y/gi7qr9B+iaj/a4lEIIAbQO/ytLN9InkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc5fz24B; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so458810a91.2;
        Tue, 29 Apr 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745937322; x=1746542122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1+knUKG6TTov+SVyavkYGTfg+D4/yr759A0vy/Q4Tc=;
        b=Yc5fz24BsvIr64gh8bgOXq42oSjmHaYSED4hwWXzwnioNYkk+GSaQgbsUPgSV9jPIh
         Y/rdFfc2uz2OGCkmfDoZ1XnrjsWyuNjt0rJLIDJsAO9US6JqwrmzjRa1TYgS6Dt+dIeW
         cU2Hxifxa3lm/GfDCBTWk4adQJvQYV/LlW2vxnP2Dk1kTn88/W0AW955TdxwqyG6JkEb
         yS41J2SPE6EKC1JR0IFhyPJBolNLCOCDptS9yrULsy4ETW6+v8OAc2+OaehM4mNjr59Z
         5czQPMm4CFSh1QQyQQ6Svuta+bOtMqF/TPkblq7kYPSIhFndI3nwx2KSSqkzE2PDe5mH
         t/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937322; x=1746542122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1+knUKG6TTov+SVyavkYGTfg+D4/yr759A0vy/Q4Tc=;
        b=XJr2w8Dki836GbDbr255osDWAUi0gQcqdsJBAVPHECBnAbHhpCj8yLZ7yJlOkb9XPi
         JuNnW13HO01tQySD7NWqlNfP4Qh7DoAh8hQ/ILJ+zG6vhaATVYXvsJnvg0BMroLbCb0m
         GzYV74DtTPUohA/MeFK0Gyfie6y+0Si+qmXgL5BAtnSdDsNORoekqoAVB+skeX9qMy3T
         O8B5pd8OQFc1MY0E+UlxQRHHRzNHKGAAsgw3a2q4x/ukxcCYDocSuui8e41jfAEBzZ9Q
         hsrf3E2kQFwxSSQsmu8RW2qLx6Ts8wjeNlKu5WGqfJuCMoPIo+xmwKRPZ5t+BJd0S+JG
         fgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0daINhg4b4QKDehWroEYtS0okuQRxjNhfCVewga/fMTWE1tual55s0JXl6Odp1dX6XBy7ssIbihxgxNt3Ugk=@vger.kernel.org, AJvYcCX19wckuROKR7J5uE7qzKoAUQdB2ZOjBEeo0u0RLD7pZ6uAcUipSr4MIq2Q88bckcB9gdtDOJfOd7W9iRg=@vger.kernel.org, AJvYcCX3N/PLalXbOnrX5BVo11Fw3k0UDFZCJ6KGsVUqO8vipIdB33oPH+ehu7Cs2ESkWB/mIvX3zji5@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyWkJ5JJy2WuSXal6Ca8wvz7hANdDuPqN504Y+fI1OcQ6sA0+
	VIBDw+StfuLKcKq/5k1SJQkh0hpyW0COe0/xfj6MFC/QZVErfUCeaQdC0YGGleVRIuaXvcvJDIQ
	x5TZsVkzpuuMajpsK+Dz8QeSszxM=
X-Gm-Gg: ASbGnctfR2bLCjCrT7IGKCT2goqauoBCfEIkwv+b2jmQhFQV4EEmM7U4DHUMv+nLXC7
	0yJiEZVmJduhItWTabb10kjfBTsK7ieGWqP3a2iWaqLwWq6la7iSWjasWgbqZUF66902KB2nD4Z
	rDiFUy42ApV2uRBuYCjLXnrg==
X-Google-Smtp-Source: AGHT+IH7CK5hSE1FAeJHgUDxmm11Aa2H2XbPybD4WjpTwuusd+PKeukJu7v6ReDITt3ORObJ7yzVckVxWpfVYsp2XY8=
X-Received: by 2002:a17:90a:d886:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a28e2a145mr1184773a91.3.1745937322220; Tue, 29 Apr 2025
 07:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com> <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
In-Reply-To: <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Apr 2025 16:35:09 +0200
X-Gm-Features: ATxdqUHPLOCidXgmHEGgpFzgZ_cftZ3L3nnmGZTQqUHW7BdIqxEdrU7e6YXR1EU
Message-ID: <CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, gary@garyguo.net, 
	aliceryhl@google.com, me@kloenk.dev, daniel.almeida@collabora.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, 
	david.laight.linux@gmail.com, boqun.feng@gmail.com, pbonzini@redhat.com, 
	jfalempe@redhat.com, linux@armlinux.org.uk, chrisi.schrefl@gmail.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 3:17=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Ah, 64-bit integer division on 32-bit architectures.
>
> I think that the DRM QR driver has the same problem:
>
> https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4rnx=
xKvx+HvWdBLopZfrQ@mail.gmail.com/

Yeah.

> It appears that there is still no consensus on how to resolve it. CC
> the participants in the above thread.
>
> I think that we can drop this patch and better to focus on Instant and
> Delta types in this merge window.
>
> With the patch below, this issue could be resolved like the C side,
> but I'm not sure whether we can reach a consensus quickly.

I think using the C ones is fine for the moment, but up to what arm
and others think.

This one is also a constant, so something simpler may be better (and
it is also a power of 10 divisor, so the other suggestions on that
thread would apply too).

> +/// Divide a signed 64-bit integer by another signed 64-bit integer.

Perhaps an example wouldn't hurt. And if `unsafe` or fallible is
picked, then the example allows to showcase (and test) what happens in
the zero divisor case that Christian points out.

By the way, apart from that case, we should also consider the min/-1 case.

We may want an assert under `CONFIG_RUST_OVERFLOW_CHECKS=3Dy`, too.

And it wouldn't hurt to test a few other boundary values, with the new
`#[test]` support.

Thanks!

Cheers,
Miguel

