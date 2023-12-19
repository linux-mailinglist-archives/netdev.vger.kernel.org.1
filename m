Return-Path: <netdev+bounces-58764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F15818051
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 04:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD42834FE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31D4C9C;
	Tue, 19 Dec 2023 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZjvlTjF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D08C12A
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc6ea4452cso24256721fa.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702958281; x=1703563081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFMDBuRI0yIhgu5G0f945foLHQ4bi+M6kOncymn8N3c=;
        b=PZjvlTjF9Qo99wE18FhwaD/EImCzUcU4B64KC6ysvXc15qD8FepPBos1CS0LACRSNq
         Zh0IwV2Ft3sb9R07D/tpnxTkjz68hVwI51g0a2SK6mC8ohog0ZNHaA6iM99QPDfl+3wm
         R0mVajHSYpnAO1CjWjTAFUMyiWlB4cELZwrJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702958281; x=1703563081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFMDBuRI0yIhgu5G0f945foLHQ4bi+M6kOncymn8N3c=;
        b=wyFiJEagmlN4MxO2ficULBL8/tnmyf8Ibv4LTfXPtiM0lijMNo9icsCsuYPPxRBixY
         9rDQhI4w3Cq6AyrmB3cS+rEyUgjq3ql0H2IgblDMih1epW2FakP/APo9HiHgx/rPObX8
         Tyv2HKWUEIGMIPj6o/KipwW1hAtVyRc4iHZ2J164GnhoISWBaPNvErgwQtolWMWpfjsU
         RlV6s7oHO9EqGk4QKoYOJOpDYWt3dgxYbNRA+PeKrPRxqLSfs84P0CSBrxZcnCkqxvhL
         uJBSNtXSoZrxgUm4gwLpZB3tNlqPN2+dgD87IeZN8iYMxsbZGlpAeuKfpwmsFXUvz14t
         Gtvw==
X-Gm-Message-State: AOJu0YzpemVJQmcONBKulmfkQBxGgBMyjfdXsqNdBguyjE5JyN47OsfL
	mBDte7KBL8tYft/Y8EA5pbsj6UKXzzZ8lRRJ0OA/80yy
X-Google-Smtp-Source: AGHT+IGU800R+4wqtPnd2KgqOnwI/2aSxpQo7DIzoTEifgvlU2RbuqvFIx7wRkiJJDVKjsGqdY8mJA==
X-Received: by 2002:a2e:a278:0:b0:2cc:7667:48e8 with SMTP id k24-20020a2ea278000000b002cc766748e8mr927078ljm.33.1702958281047;
        Mon, 18 Dec 2023 19:58:01 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j24-20020a2e6e18000000b002cc7027da2bsm635954ljc.127.2023.12.18.19.58.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 19:58:00 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso102296e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:58:00 -0800 (PST)
X-Received: by 2002:a05:6512:220f:b0:50e:44a4:f7e3 with SMTP id
 h15-20020a056512220f00b0050e44a4f7e3mr233393lfu.81.1702958280178; Mon, 18 Dec
 2023 19:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com> <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
In-Reply-To: <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 19:57:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
Message-ID: <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 17:48, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> Point taken.
> We can do s/__u32 token_fd/__u64 token/
> and waste upper 32-bit as flags that indicate that lower 32-bit is an FD
> or
> are you ok with __u32 token that is 'fd + 1'.

No, you make it follow the standard pattern that Unix has always had:
file descriptors are _signed_ integer, and negative means error (or
special cases).

Now, traditionally a 'fd' is literally just of type "int", but for
structures it's actually good to make it be a sized entity, so just
make it be __s32, and make any special cases be actual negative
numbers.

Because I'll just go out on a limb and say that two billion file
descriptors is enough for anybody, and if we ever were to hit that
number, we'll have *way* more serious problems elsewhere long long
before. And in practice, "int" is 32-bit on all current and
near-future architectures, so "__s32" really is the same as "int" in
all practical respects, and making the size explicit is just a good
idea.

You might want to perhaps pre-reserve a few negative numbers for
actual special cases, eg "openat()" uses

    #define AT_FDCWD -100

which I don't think is a great example to follow in the details: it
should have parenthesis, and "100" is a rather odd number to choose,
but it's certainly an example of a not-fundamentally-broken "not a
file descriptor, but a special case".

Now, if you have a 'flags' or 'cmd' field for *other* reasons, then
you can certainly just use one of the flags for "I have a file
descriptor". But don't do some odd "translate values", and don't add
32 bits just for that.

That's also a perfectly fine traditional unix use (example: socket
control messages - "struct cmsghdr" with "cmsg_type = SCM_RIGHTS" in
unix domain sockets).

But if you don't have some other reason for having a separate flag for
"I also have a file descriptor you should use", then just make a
negative number mean "no file descriptor".

It's easy to test for the number being negative, but it's also just
easy to *not* test for, ie it's also perfectly fine to just do
something like

        struct fd f = fdget(fd);

without ever even bothering to test whether 'fd' is negative or not.
It is guaranteed to fail for negative numbers and just look exactly
like the "not open" case, so if you don't care about the difference
between "invalid" and "not open", then a negative fd also works just
as-is with no extra code at all.

                   Linus

                     Linus

