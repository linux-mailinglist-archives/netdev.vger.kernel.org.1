Return-Path: <netdev+bounces-159298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC3A1500D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2F16444F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542A1FF608;
	Fri, 17 Jan 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkBoyQep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB61FCCEE
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119167; cv=none; b=ffCh6kilOo00fhKli461338BHeGbIA8hbdHz4xpW0Y8vMhxwedwTJQXFniIJ5PRtrPl0VUOCGJDfnPNm+wwrdrLi7+XeacxjFStdXNtEsb+493Ux1rKhjJqIC5IMPSYqwlg1nCnZHiMtFJLoNyj7NM8pm6V4El58krWc5DoCzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119167; c=relaxed/simple;
	bh=hQ9e6rbR6HiF0VYlbEEItopkOeT1txabxJnTwEAQWtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUHENXQtRzQ0qbAJX1BeaPSEABfh1qJLHHySje1s9YRuSOkMtir9IchK4sUmQ+0Iih/LVXpaAd2dUh7vGbIbxVR8DiCaODAVNzWwgtGwD5nDUXJDZRSusYnogwx9gTvEViYU/siJioGNBxosIj/v+gfoDJ9Mvwk+26tPk3kwprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkBoyQep; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43618283d48so13903835e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 05:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737119164; x=1737723964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MffWZy2qG7Y6JWmoh4iHVpcAaSZTVr3Q5Le/78Z0tU4=;
        b=HkBoyQepFj8rA5LGyw8tTJKgtRmFNoVD9Y8hi45fLgT11oV9fEnnPbgx94MHnRmjcH
         09lzG3ZtHg2HBruL6G57oD8pLqWF/ECuo/e37bNxraU6ZI7BgjEV9QsP7Lh01bDOwQoJ
         zD/xbykgjgMct0c5Nnjb2wx9TO6oLm+5jz7f7R8shtyhJf6uEf6quonrXHeKuAe5642N
         SIGgBb6FkDIB9zC7uGqBWDHSOocTevDQ1uzZohY754ItlHOG3nrtAA+Z1k9n0XSmSMgZ
         Syn7BCgX4S8j4yynsJD6LFGWzCH9/y03WkPwFmsFEB4AgbJY0dDsKDiJfIt4B4siNaCW
         Qs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737119164; x=1737723964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MffWZy2qG7Y6JWmoh4iHVpcAaSZTVr3Q5Le/78Z0tU4=;
        b=Vm9h/SSUAEYgW+UjVEUcFKLR8mGZl1JLcKHWk/48fdKs7JYx+IlbdH6emWvE7aHmMV
         Tajy/BL8Na5wqMfWWsU9tYcIHn7GzKy88uviT6gFy6sWEF4q4puvTML7afU1MHKeKKar
         gh/p6ETQzigv1zuGihtIJG5hLA3F5YAo+BDCidDHYuFEy8kD+Iy1/66FTlBheNGNg8Op
         vvCXZguT8kXH0LbYogieaxHXBrRi31XdxZy26s2yTVlGAuaGWZ4OyRrWyK+tthDSBaSQ
         OAcEg8x/R9Vw4oi90QTi1Ut1/Bor6cfhS6NwYGJ/t9CufCl7MCDYWU/ymo8iPHPJ0vwu
         y2jg==
X-Forwarded-Encrypted: i=1; AJvYcCVoFahq7cbfweF26fbJjQjfc38QNZ+hagg1TdJsgXn6CarVTCvRL5pbW7hYuBdT77Y05fCDpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJiq2mAz+ehaW1NUWWadM0GALeJ5hRXEW8R9xmrbaZCpgCvao
	2W3Vae8kSqRm+0xlWHGJhsSrQtNcMrg460AE6ItUlBkkVUNvsArOOkXPQORv+sXewr1wKnLNNpe
	nxZDN+rsMSGuyBcBaDm6y5jxu4+EMnNno+r5b
X-Gm-Gg: ASbGncvsDgBQDcgNPgsZaPaO6KvUyDr8Ic+A6jCqnkmCLptL/6RJKm2BajVr+2qDVXC
	hJRSEk61enB8K0CCneQH36WiJEb4emHFr8U6d5Ic=
X-Google-Smtp-Source: AGHT+IFIrgN0kXkKi1laseLg/MV2oUQuJQaUgpoC2ZJDGiSWy3dT9jT1ButtO2C/XovaEoCIWMhN7wBieoH1VVtyfF8=
X-Received: by 2002:a05:6000:2a9:b0:38a:2798:c3e0 with SMTP id
 ffacd0b85a97d-38bf57c9b83mr2372799f8f.54.1737119163705; Fri, 17 Jan 2025
 05:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117.165326.1882417578898126323.fujita.tomonori@gmail.com>
 <20250117.180147.1155447135795143952.fujita.tomonori@gmail.com>
 <CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com> <20250117.185501.1171065234025373111.fujita.tomonori@gmail.com>
In-Reply-To: <20250117.185501.1171065234025373111.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 17 Jan 2025 14:05:52 +0100
X-Gm-Features: AbW1kvbrFl85FFffgJR887ohWA8nRSfhdN_SJdP7V78TZ56SODUNWQNtZKv4CjU
Message-ID: <CAH5fLghqbY4UKQ2n1XVKPtvnLfJ4ceh+2aNpVmm9WxbUTu8-GQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:55=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Fri, 17 Jan 2025 10:13:08 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Fri, Jan 17, 2025 at 10:01=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> On Fri, 17 Jan 2025 16:53:26 +0900 (JST)
> >> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> >>
> >> > On Thu, 16 Jan 2025 10:27:02 +0100
> >> > Alice Ryhl <aliceryhl@google.com> wrote:
> >> >
> >> >>> +/// This function can only be used in a nonatomic context.
> >> >>> +pub fn fsleep(delta: Delta) {
> >> >>> +    // The argument of fsleep is an unsigned long, 32-bit on 32-b=
it architectures.
> >> >>> +    // Considering that fsleep rounds up the duration to the near=
est millisecond,
> >> >>> +    // set the maximum value to u32::MAX / 2 microseconds.
> >> >>> +    const MAX_DURATION: Delta =3D Delta::from_micros(u32::MAX as =
i64 >> 1);
> >> >>
> >> >> Hmm, is this value correct on 64-bit platforms?
> >> >
> >> > You meant that the maximum can be longer on 64-bit platforms? 214748=
4
> >> > milliseconds is long enough for fsleep's duration?
> >> >
> >> > If you prefer, I use different maximum durations for 64-bit and 32-b=
it
> >> > platforms, respectively.
> >>
> >> How about the following?
> >>
> >> const MAX_DURATION: Delta =3D Delta::from_micros(usize::MAX as i64 >> =
1);
> >
> > Why is there a maximum in the first place? Are you worried about
> > overflow on the C side?
>
> Yeah, Boqun is concerned that an incorrect input (a negative value or
> an overflow on the C side) leads to unintentional infinite sleep:
>
> https://lore.kernel.org/lkml/ZxwVuceNORRAI7FV@Boquns-Mac-mini.local/

Okay, can you explain in the comment that this maximum value prevents
integer overflow inside fsleep?

Alice

