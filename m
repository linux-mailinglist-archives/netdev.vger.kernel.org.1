Return-Path: <netdev+bounces-132734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E5992EC6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC652B22717
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3261D90BD;
	Mon,  7 Oct 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcPqXvXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA61D798C
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310622; cv=none; b=leIQB0IQxBCV75IegjYyCkbFnTPOP/Q5HEFli/tFOyUIR/e0HbcS6F5o8H6FXs4+ZFzjiFHXup2VSJHVtVeVLkkQe62WZvlUP0EUSSZhVnp1QBbZ9AqZ4g3AhW/IVTFugoKnqdRyTj3+LLnXxXBjhfElFvorLBut2iGmJ498Cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310622; c=relaxed/simple;
	bh=376HqnvNhc5ZE0HBO6XE8aIeQfBue1EBUdnGFKgW028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvUXCh/gdxISXlJpsuJzssV2+P0qll+jWzcrKb+UX1d7YjgI+W0HhjHzdfQwQNlV2DGSoLXejpFgM/xSot4ehE6AgJOhe4cfh4CJ0rHrlVJhqTJhOLbIeDLrnIWup1yNqbmisSQ2e1yhoqUuoI2gFEYSPf/2WbhZcjemZ3b0YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcPqXvXc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso2458298b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728310620; x=1728915420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZotRyJfqUBQUUh0GdjsSXNxbz4lowqfUZ4/U9osmyA=;
        b=fcPqXvXcxEMkgbz11ctygKKwnEzhK4OL6i+PhJxnCrinRC0LpMtkgD474UtFJ8nzk6
         1gPNyUmT3eq+xh6i33Ku1F623wDtyk7LwLwF8VWRHpKlSZnOcIZ7pNmGvwAu5CMFhwmF
         nURwmfU7OJhF5IQHAS8jPhxl3JZoULmxqDhzHpCkdE8UlPD3Zs5rJpKJbFeDBfPf4aHZ
         uMIgGQICxCjO8CTGyfTYIqpmsj2PborSN3a7N5EksxSfUN0tXpCPrdfCdikpRrsCBu7+
         9F1Qz0JRV22GyCSgw3l4nmlfGdZYClqA+29rhA2l3CAa/zEi6qVRHzMwzx3p1nPqi5VR
         Om2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310620; x=1728915420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZotRyJfqUBQUUh0GdjsSXNxbz4lowqfUZ4/U9osmyA=;
        b=DtZUIf/kzYiXFjReoB0Xi/M1nRSfVqUAkEZch6M26Xe/cySExfHU9GaFTAdJInVy6Z
         MGuzj7bytZ35V5UHe3H5x2S+vreIiXkUfmuju5lp/uHtZgRn8SPcvNg1iXDF8cOKDapU
         Ode6x6qcRaZ49XUqJiCONOAk5aP23kphX2u0ADjqOKYpw0wSgR4C9c7vNX7znFo0KZ5U
         bHn1RhDwyJI9tvxet7IHnTKiIAO2S8vhZmvlZgAa2ot+QFIMqpczXKbIPCizVws7KfBZ
         fbJabF7iSgXAzRMEkulSKUm+WYYawfTmf7+UnIIZCgZWFLbTh+n2S2B94o51WMCea8Iv
         RTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG9Y7fwRzbuaipSdNLtd7ZhN+tHbHbO80iRxArkgvB22ZtrTxKehvtElxk+cQXtAztMFkNXj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbabPhn8aICCSaBwrO1zUdSZQJS44UnYGUAy+fClxo5pB8KTI
	VA+5AYojGMoVsIrVYLpyZTulrjhYt4uBoxN0LsfduOHiYE+XiCEV7AbZLublaytTjYrySk1XOpt
	7i/KUMyuEXmnvuMwSqESk2vn1lg+V0DAe+Pc2
X-Google-Smtp-Source: AGHT+IGRirQUTUs43IAYcReXl0EvbBGWtade4ytNJlT9/pAyB7YZGBvddZQaFl4GNDeiuwukPx5yEImABPr95O01a0M=
X-Received: by 2002:a05:6a20:29a7:b0:1d6:e593:1d6b with SMTP id
 adf61e73a8af0-1d6e5931deamr10398837637.6.1728310620266; Mon, 07 Oct 2024
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com> <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux> <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux> <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com> <ZwPsdvzxQVsD7wHm@boqun-archlinux>
In-Reply-To: <ZwPsdvzxQVsD7wHm@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:16:46 +0200
Message-ID: <CAH5fLgigW6STtMBxBRTvTtGqPkSSk+EjjphpHXAwXDuCDDfVRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:14=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:08:48PM +0200, Alice Ryhl wrote:
> > On Mon, Oct 7, 2024 at 3:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > > > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > > > However, this is actually a special case: currently we want to use =
klint
> > > > [1] to detect all context mis-matches at compile time. So the above=
 rule
> > > > extends for kernel: any type-checked *and klint-checked* code that =
only
> > > > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > > > compile time checking for unsafe code. So if might_sleep() has the
> > > > proper klint annotation, and we actually enable klint for kernel co=
de,
> > > > then we can make it safe (along with preemption disable functions b=
eing
> > > > safe).
> > > >
> > > > > where you use a sleeping function in atomic context. Depending on=
 why
> > > > > you are in atomic context, it might appear to work, until it does=
 not
> > > > > actually work, and bad things happen. So it is not might_sleep() =
which
> > > > > is unsafe, it is the Rust code calling it.
> > > >
> > > > The whole point of unsafe functions is that calling it may result i=
nto
> > > > unsafe code, so that's why all extern "C" functions are unsafe, so =
are
> > > > might_sleep() (without klint in the picture).
> > >
> > > There is a psychological part to this. might_sleep() is a good debug
> > > tool, which costs very little in normal builds, but finds logic bugs
> > > when enabled in debug builds. What we don't want is Rust developers
> > > not scattering it though their code because it adds unsafe code, and
> > > the aim is not to have any unsafe code.
> >
> > We can add a safe wrapper for it:
> >
> > pub fn might_sleep() {
> >     // SAFETY: Always safe to call.
> >     unsafe { bindings::might_sleep() };
>
> It's not always safe to call, because might_sleep() has a
> might_resched() and in preempt=3Dvoluntary kernel, that's a
> cond_resched(), which may eventually call __schedule() and report a
> quiescent state of RCU. This could means an unexpected early grace
> period, and that means a potential use-afer-free.

Atomicity violations are intended to be caught by klint. If you want
to change that decision, you'll have to add unsafe to all functions
that sleep including Mutex::lock, CondVar::wait, and many others.

Alice

