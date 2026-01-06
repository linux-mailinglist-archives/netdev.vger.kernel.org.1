Return-Path: <netdev+bounces-247359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D95CF8626
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5125D3012C76
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD8327BF6;
	Tue,  6 Jan 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2raWdsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00317320CB1
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703720; cv=none; b=WwXNxzj/f+wHbdl+WoZ8eZ9fp6pFs1Y55vWCunxnk/Mf8UcEUKnw7uvUWe9mItGT/7U0yaCoRPQo4VsfQunFjrPI8RnY6nS0MbpKVncIbrRps1xiOh94TTbyxicQ7ss3nrweNW9lh8z/T91uKheRuhO1l4yLg3El1MPYtKoV+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703720; c=relaxed/simple;
	bh=BBii3Mq4q0YqkEg21YmRCOxXIkp+RWiyrkBYvkUYnvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G50dqu/NICpo3+fagpBxUbVfr8mDXaHu+bebLAZTxNVosGgU8/vYBk2x9TfDHy0w1XclLIRyNCEBVbOoraAlA8rk3ovSm5+uNALswzlR80t8b2eWyL1lqY0MAAhaVp9asrk26ZFjQHi0EOS2qT5+Odvj545TJ00IksFwYgI41MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2raWdsU; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fdb90b670so9540537b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767703718; x=1768308518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBii3Mq4q0YqkEg21YmRCOxXIkp+RWiyrkBYvkUYnvg=;
        b=L2raWdsUkwJ5krRvoFG/1CPkIdJL08RThTfeUjxmx5xdXKzBHJTtRnihrJyLNpd+8o
         J0s52AdnOkb+u9PnHChyAD9Qe/CIadRtu0XRPzr68X1R2QaYaoojdKave+VV+iCOe/oU
         FSLdCns/KVvGZIpDZZt3wHzjla30niWxnCFVty8Q/oEaWG9BCkMbXZxC5FgF01T+w5B+
         aeOIcEBMaoRwsY7NUk727SOEY4SxyJRkXDEXTyYkyLbAq2ibA6+iYEt5e+fsm4aJfEQs
         QXcW5ijedpZOsLuHcy7RhXr4fI39hJcaATycIRnbkvX20kDqxJf8u1mmLT3UIDsbQpVH
         Ge/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767703718; x=1768308518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBii3Mq4q0YqkEg21YmRCOxXIkp+RWiyrkBYvkUYnvg=;
        b=KOjDsNKb65IPtWZPhb0FjHIKhsUrnFVU49My0SPGBP2HNfSTHo4+t4ln1WhHw7m1qI
         +92WUkLbp/cHYiB37aR/R1A+ehEbOCsrrqdr+VVFyUSnh1+jNWaSQdNECJrF4jgcNMUT
         HPX1ft3ewGEWJbK+uK1UMC4fbRbqocaZbajZaLfn+N/iOxw5tZqNZGHowVRb6OE6JlMo
         JVKfKR958Utwb0szyjqY4uv8FaEHigKxthpNa5G48mWbJCBzPsA+K2UXSffcWYzE7znH
         8ze0CWO3++iJsPB62xK4Puy2cy8/osQlo38mwLBtvMkCqeQ5wVXyOlYGzZcaAnfx6vEd
         LVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV690wOCFLXmt4SRVM+aiByUUdxmb4XPeiT/jyEYYFKV/6GHz+jsDCcwzAbeIHLn2oHNjpr6cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdA1apk+sThZ2+yvBjTlWC9yNceiru+fOGsV98D7hK8FB5nSga
	ekT7qQigZmmk/w3fgWhymun+/z9oXpjNCJ8wN6da+oeoYW+iU0KWyuSRS/Xt4yWXR6BdqMGIc0y
	t9QP4QbM0e64yaiQuVAFiybli9sz3rp0=
X-Gm-Gg: AY/fxX7saStfAOQuYOgEXBPuIJfZseDYZaj8VjZDmVQbhjFJt8Rq7iV/ymP3UydK/+N
	fSxk7453BWBQaPYVqNgtbmNQ8E/gDtLZkb8dTw8TvipVnlbr2bVb8JFUCErrllhNvs71GjfWm42
	iXjj+6XN9KTQ7fsbqWH5i5ZGzlLRs/ClW5LKcaiRLmvWaxPrurh+0FQSOsKflp7++8lt79+5nya
	imi//enqt65YiFj32DooTU4cmTXaAKE+XStQkqLxNIk9v/a1EIsOJeuHbt/VaZ/EkBYX+E=
X-Google-Smtp-Source: AGHT+IF8KI89KLf3bKzqNc4G6bPsWOgabSD/4ejctOlkcIk8jmKq5n+X1mNRYhKI+jrfFGHOQ4AKo7Gs2QW00RTYVCc=
X-Received: by 2002:a05:690c:6305:b0:787:f69e:d156 with SMTP id
 00721157ae682-790a8a341cbmr23366437b3.1.1767703718010; Tue, 06 Jan 2026
 04:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
 <CAEf4Bza4fD5WWWBxJk0dd_xvgPR0ORZpcp1wiahyMPjvdoWG0w@mail.gmail.com> <aVzN28i92roV1p4q@krava>
In-Reply-To: <aVzN28i92roV1p4q@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 6 Jan 2026 20:48:27 +0800
X-Gm-Features: AQt7F2oMLxxCEkG2LRnAb9qTRqDKHwSyzwbk6vVaBtzJHaof8kpyIcVVg2wTECc
Message-ID: <CADxym3Z5vPsNktM6ehc5E=9HBqdYwRRyFcyfDLASoz0bjMGQcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:54=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 03:20:13PM -0800, Andrii Nakryiko wrote:
> > On Mon, Jan 5, 2026 at 2:33=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > > >
> > > > In current solution, we can't reuse the existing bpf_session_cookie=
() and
> > > > bpf_session_is_return(), as their prototype is different from
> > > > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > > > bpf_fsession_cookie(), we need the function argument "void *ctx" to=
 get
> > > > the cookie. However, the prototype of bpf_session_cookie() is "void=
".
> > >
> > > I think it's ok to change proto to bpf_session_cookie(void *ctx)
> > > for kprobe-session. It's not widely used yet, so proto change is ok
> > > if it helps to simplify this tramp-session code.
> > > I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
> > > will enforce PTR_TO_CTX for kprobe and trampoline.
> > > Potentially can relax and enforce r1=3D=3Dctx only for trampoline,
> > > but I would do it for both for consistency.
> >
> > Yeah, I'd support that. It's early enough that this shouldn't be
> > breaking a lot of users (if any).
> >
> > Jiri, do you guys use bpf_session_is_return() or bpf_session_cookie()
> > anywhere already?
>
> np, we can still adjust, it's in PR that's not merged yet

Nice, wait for me :)

>
> jirka

