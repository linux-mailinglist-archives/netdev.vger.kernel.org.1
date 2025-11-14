Return-Path: <netdev+bounces-238733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F229C5EA92
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556C53AA6B6
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EDA345754;
	Fri, 14 Nov 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rb0DIDpw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FB34676C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142504; cv=none; b=oLOhfvvOXSyXswfW+j/MfwcNJMmndKaP9ZQOaMBWtUn2c6vWKflEF4kOEuyCgSNWxqTH4uCJhCWCFe1vauStCf9pWFjcVubEEGJ4G0UTaZGbXdV9bpVjbZCC55sidUwInhJiTB0puW3Q7ez+5VCvRh0BOlNcrqwpJe/Y2AZyH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142504; c=relaxed/simple;
	bh=M3lRJLmEZ7JGwWTvf6UoV64DNFaFI5lqaxXQ8tgqiIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onJ6H7MQurNz40wxb9ooOroRsKGAoN5/qLX3DjXxqA8sK4e2l6reKR25qKFHk+ikdDelIgbUklrmm9uPL3ECdEtRjGbljnFV6Tlfj2rW0+eMTsQL1SV0mVoLDe/pADhiG2BYBBRFUeWbgI5r+jt2BOvQWfkouMQgTj+E9F2qnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rb0DIDpw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so3950054a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763142500; x=1763747300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg7DjlCq7wS0LcCCJEhlzHEukmpZjrkwro9CVQtSZwo=;
        b=Rb0DIDpwklbLQYFDjYQo8wBKZ7R4t6Lt28tfOx7AlVJ3XcE+sUI/KwSG+XZLPbixiR
         U4TNgFO3Ec1fh5jsI6DSxYkAm3FcswDm4DtIYx/HTw5jiCihP4CR21ULKbhe25eIiBOI
         LVO8WzEVdPtEfyFB6FdIWhdEcCtzLPP6p7ITQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142500; x=1763747300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zg7DjlCq7wS0LcCCJEhlzHEukmpZjrkwro9CVQtSZwo=;
        b=B9Zz3zX5/sFSFDKFPqwx8AtJGgVu4InN7v9ys1v3orj5aI0rtQBrVv0WUHbpUKZXQk
         iBI8pvfRdUHBWohKu9VnEc7jmiD2CAeJhmwqSmx6J98HI0usWJXVX0mHombe16ukASJ8
         xSWh7PQf32ddBquXMGBEKgmG4xWtRJeOxzhWcn/zhHLXCqt4SyhJxTH3aeUXvuFyu/n7
         4yVjgcjvBt7ao2778FEyHaAPSgC40GW67MyjKCH0izqi6hoWGz83IZ4rlf4UPum+UZHf
         4C83uZst0bGkHegN8IwAO221pE9ejds7DEcXXUeb1xkWqpnlkt0RSbKI9dzpDXtAOlsU
         U/qw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ewf7jV3bKawKFl0vjW5dCplCOGA9dw3QI2HhU60vVTOxgVkD3rP7WsSfkrlPTbMhblhEsNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1pGN3A2cl7t6xeafC8HW4/h33L0EL2Yl5b3CpKueDzowosbd
	PyPaPeAqeN0kxilRjKCJR2mjvbrwU7JxAClnFZegwnreQWPSeczsf7KODWhSZQs/eo8hmi6shfm
	UY4fjWVA=
X-Gm-Gg: ASbGncu3T+U7j9Ldwfsmgg06yYNUPK9GQjlKJ72wjI3kgQG+ueBxQPxhqjKA3nFy4rM
	IcIhraToxpbBXsbIP6HDey0B974kmP6jdY6EwfZA7jVry8xYv4A1Iyv1yBCSzsX0y1hBSLx6Vi4
	JsmZekeb4q1pp3C5/tV9Bbk4mmdHqtgnfDNmUMatpQ9QH9qThwypb6AoreXb5SW9rdDVd4gXu2b
	rqgPo8s8qwQQNqkKdN4cAsJSAt44a/prEQUvXFd3sZbSJ/UvIxSuxQHx3gcl5RqzgSbY8Nlt9VL
	RnMgN1yHjHU5cL6Y9eEhtIjVUIuYn34ZgIiKZs3uIJPA2S/ZK6LryvpMlsJzm7m4p8GT3wp4lR8
	O0UQDkJku4JPeBBXUSva3Etsf5N8pBaTKoHNn2srzlnEzACEC8//t90cy5FeD2FEvv/pwZopLct
	Q0JCYeSXOyAcH+Tx3RGTPuWNZS630GulxD47kfqyvw0mzlnaeBCA==
X-Google-Smtp-Source: AGHT+IG+v0A674ArG5RISRgRatWMDSXLz4EvNWMaqs/dd1eVzqM825f+bHn5/HtugahH6Vz1YHOZBQ==
X-Received: by 2002:a17:906:f58b:b0:b4a:ed12:ce51 with SMTP id a640c23a62f3a-b73678b33c7mr332050166b.23.1763142499922;
        Fri, 14 Nov 2025 09:48:19 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81172sm430839966b.15.2025.11.14.09.48.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:48:18 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73669bdcd2so218704866b.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcOy5qrPssq/8QSyAB070+lhXvnjQmN+Wkq+rMrwHO4/1YtdFjmPr/m9QFvtH8aBXvXeuitIE=@vger.kernel.org
X-Received: by 2002:a17:907:a0b:b0:b72:5e2c:9e97 with SMTP id
 a640c23a62f3a-b7367b8b6bfmr305496966b.36.1763142498394; Fri, 14 Nov 2025
 09:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
In-Reply-To: <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 09:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
X-Gm-Features: AWmQ_bk0jgyM9fIRt_Ee0fGAZtYocBkhM5AivJHg1mQmAcGyfeiZb7v3Ov-HW6k
Message-ID: <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 at 06:53, Jon Kohler <jon@nutanix.com> wrote:
>
> > On Nov 12, 2025, at 8:09=E2=80=AFPM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > It has been used even before this commit.
>
> Ah, thanks for the pointer. I=E2=80=99d have to go dig to find its genesi=
s, but
> its more to say, this existed prior to the LFENCE commit.

It might still be worth pointing out that the LFENCE is what made
__get_user() and friends much slower, but the *real* issue is that
__get_user() and friends became *pointless* before that due to SMAP.

Because the whole - and only - point of the __get_user() interface is
the historical issue of "it translates to a single load instruction
and gets inlined".

So back in the dark ages before SMAP, a regular "get_user()" was a
function call and maybe six instructions worth over code. But a
"__get_user()" was inlined to be a single instruction, and the
difference between the two was quite noticeable if you did things in a
loop.

End result: we have a number of old historic __get_user() calls
because people cared and it was noticeable.

But then SMAP happens, and user space accesses aren't just a simple
single load instruction, but a "enable user space access, do the
access, then disable user space accesses" for safety and robustness
reasons.

That's actually true on non-x86 architectures too: on arm64 you also
have TTBR0_PAN, and user space accesses can be quite the mess of
instructions.

And in that whole change, now __get_user() is not only no longer
inlined, the performance advantage isn't relevant any more. Sure, it
still avoided the user address space range check, but that check just
is no longer relevant. It's a couple of (very cheap) instructions, but
the big reason to use __get_user() has simply gone away. The real
costs of user space accesses are elsewhere, and __get_user() and
get_user() are basically the same performance in reality.

But the historical uses of __get_user() remain, even though now they
are pretty much pointless.

Then LFENCE comes around due to the whole speculation issue, and
initially __get_user() and get_user() *both* get it, and it only
reinforces the whole "the address check is not the most expensive part
of the operation" thing, but __get_user() is still technically a cycle
or two faster.

But then get_user() gets optimized to do the address space check using
a data dependency instead of the "access_ok()" control dependency, and
so get_user() doesn't need LFENCE at all, and now get_user() is
*faster* than __get_user().

End result: __get_user() has been a historical artifact for a long
time. It's been discouraged because it's pointless. But with the
LFENCE it's not only pointless, it's actively detrimental not just for
safety but even for performance.

So __get_user() should die. The LFENCE is not the primary reason it
should be retired, it's only the last nail in the coffin.

             Linus

