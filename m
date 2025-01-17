Return-Path: <netdev+bounces-159197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81013A14BDE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD447A1F3A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4691F8EE5;
	Fri, 17 Jan 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9XIWZZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40235960
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105204; cv=none; b=lEWTQjpLE7HQtD404JtGxi864PxXe4hUXLv/sRwTDPRdAnmCagBPlmXpro0LA6a/BuLzlfxUGiYVcgEJ7cx/tIKEQzyz0O2bLbNd6FqAffWm3f2COnW54C/MDTsG0ULA/vnAqD3VczCJT34SxeHIUKzBtMsceI9OGSP3uxQVSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105204; c=relaxed/simple;
	bh=PRNantFyQnMm+z+Qg3Bn+Or13LcoL6VuT+ErdPcFZXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewjTXAgNYxv87MpRGv/DItJmyW5HIHfgr9ElxAbkiLXLMWMOI7kF9RONzGvlQureVnBm6f4fiL0gs7I1A3DO9QPXLGeOeGaRgkM51me8LjDQB/ht3GTz+pffZaDGufep+VXp/njBEx92FJKJSrPEoKmXLOUZ7g9amOPZ2JVrrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9XIWZZh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4368a293339so19652325e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737105201; x=1737710001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAM8kx5e/afWbeDYvSzLROsFKd+B+b4c0k0I/E5Dlac=;
        b=j9XIWZZhW2IxtovSRjuI0rVW98+6d6c2fi14fFXj36gU6IsqsWfBUw816qcGRHLzSD
         yVLldMHeGuP7GbAWImZ4JJoO8/DqR0KHoESB3gm+eaWooWPRMFLFqXoQjzZxR6hJ7LTF
         VyEA6IkI3nZDMgEGeIPTyzgqO3oBUyBMs5OYwf+0D60mpAX+4FnThVPUJcwNoTPXMYM+
         LG+0CAupJsMT/nuyIRsPo7d6F7T1R9wdwFN/SSYvTS3/QGZGt1F+eREgNw9FRUOI3NhD
         MZ8FrxjyNW4GXToQn6tBlDgtBuDKmTXaLKxVlT0QysmIda8fOGPQTa6giU85/5gPs+pw
         jggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105201; x=1737710001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAM8kx5e/afWbeDYvSzLROsFKd+B+b4c0k0I/E5Dlac=;
        b=LI3bPy+e39pD+zyFkLgiOstRc8/u18EXlmko6E3j0/8alnQdePLmtpffVf3d100GP7
         4ffeAQh2xdIXEc8fxfAk110nI8rAJi2pzoHtWlY88ELZ4S+l4ytDsFC3+EC7AkGIUOk3
         jcMVBqEs0d1xzxl7+fag0z0775hNHOb3f33kpZ2yzN8SSIopWuEXIbykZaVNWlpqTu7I
         amB+6yIDiR71Z3d6FpyiNWzxbpi5hPhqrjw3v2mhE/53Qmx5DPw2qnPIr22m4dnSwHIc
         beIkoYarwxoREj8ZM5cO73m+7kL3L5oIbOtwJNVW8pQ+pp1J/kk8N7dmYOB5BkeNsu7z
         QT/w==
X-Forwarded-Encrypted: i=1; AJvYcCXpSFVgtfhYUotO7dAlsfJo0iG92dnL/mGXHVeCxUPECFf5/RhxTLTo+V2iDwhi9zzcYD5Wd10=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEJMQuSrQ4yMKfMAsyUS/ELWLMaANiZStWjmH0zJ1o9uU0y7U
	+P+u+098Yc17NN5dyo+KMUONBEFGaVJAdn79TsieXa5jI0iK66LgsBJM69WbcXTkQGm8TvN9RaH
	ortd5dsQU5AkiKGrpNHgc1wW6m7x+Q2jBXni1
X-Gm-Gg: ASbGncsShrGcRfTo7J0/zjNCmugD2gY83QhgoaBK3vGpF9TsDeWHTBzFSSu31tOcsCR
	pQ2BnOK5B5A3N99t0FWZTRyCdWX+ryGO/UZB9lng=
X-Google-Smtp-Source: AGHT+IGoKfIDcYzqb9OIA08vetyakky0sbXMEo8krBZvuPEsIuN+t2I7ymdIv+XGJrzznA+vpYbB8I50ryCYbvR6gAw=
X-Received: by 2002:adf:e84a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38bf5686090mr1272148f8f.33.1737105200809; Fri, 17 Jan 2025
 01:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-5-fujita.tomonori@gmail.com>
 <CAH5fLgjwTiR+qX0XbTrtv71UnKorSJKW26dTt2nPro6DmZiJ-g@mail.gmail.com>
 <20250117.165326.1882417578898126323.fujita.tomonori@gmail.com> <20250117.180147.1155447135795143952.fujita.tomonori@gmail.com>
In-Reply-To: <20250117.180147.1155447135795143952.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 17 Jan 2025 10:13:08 +0100
X-Gm-Features: AbW1kvYAn3ce7RD39nEID63_c0BAgBCUpAuFSOMc6Fu7kSbe-ZhSy7GInXTgleA
Message-ID: <CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com>
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

On Fri, Jan 17, 2025 at 10:01=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Fri, 17 Jan 2025 16:53:26 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > On Thu, 16 Jan 2025 10:27:02 +0100
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >
> >>> +/// This function can only be used in a nonatomic context.
> >>> +pub fn fsleep(delta: Delta) {
> >>> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit =
architectures.
> >>> +    // Considering that fsleep rounds up the duration to the nearest=
 millisecond,
> >>> +    // set the maximum value to u32::MAX / 2 microseconds.
> >>> +    const MAX_DURATION: Delta =3D Delta::from_micros(u32::MAX as i64=
 >> 1);
> >>
> >> Hmm, is this value correct on 64-bit platforms?
> >
> > You meant that the maximum can be longer on 64-bit platforms? 2147484
> > milliseconds is long enough for fsleep's duration?
> >
> > If you prefer, I use different maximum durations for 64-bit and 32-bit
> > platforms, respectively.
>
> How about the following?
>
> const MAX_DURATION: Delta =3D Delta::from_micros(usize::MAX as i64 >> 1);

Why is there a maximum in the first place? Are you worried about
overflow on the C side?

Alice

