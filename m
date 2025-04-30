Return-Path: <netdev+bounces-187154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DFAA54A0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949837AFAAD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58308266B50;
	Wed, 30 Apr 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jy/N7ZZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAD264FB1
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040798; cv=none; b=U+UyHd0UYH2BfiWSI/YjkdvvcvCWrsBjW48PQScjwF/Q7N9Qn+jWcABkctIlDCNk8PDRrV1rUtFwYhCOYoPdHz9EYp9HxFrhMkzMhgBoJcUsIEccP+bIM1b44AVAJlmXs08YSffTrbVupYOq9ywoyJE1rFle+QcNriXF6MT9feI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040798; c=relaxed/simple;
	bh=YPGb8orVplzGnjnESqlgmgnu8BGnCi4sxA7Tu7rueN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+z3R+8ZmoNOlcfHJ98+8pLXBSeJPfS5zH3ECehztVDLCRTrHLVGBr2NcC3OQoPsrhGKJg3jebva27x51T23JxJ1lH+44ygqreeI1+UszosuDozB1CeR03FUIiUYK1mwgCFMQ3ZwZ9a4/tOAL28fGCCrZLCrwZdZS7ctm7a8WwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jy/N7ZZK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so369791a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746040795; x=1746645595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kpEwqfDzBbGKQdnSl3yMorTl0nsw+Xb/pGmM7auwuo=;
        b=Jy/N7ZZK/tiBMPi1nhym/IElAspxpkLaL0kvT6wcvuhsY+qtz4/lOZCbta/N79qzDe
         BLDm71nWnDuLnQgLp6YGLBtmJv4ffjL7b8LYDinA9I+OCABJXFEvlAWoXH90XjTo01rW
         Yx5nf4Q0VyDqzgnOFfQN/PrQAANvZUJJh4H+L7PDgTZwcsXb8VdmsWrEaRU5gGnHLVJ0
         FyX35aoCsahIenCiYTzRjvscPMqM1oJixlK9gNeSkPF+xcM3ijn0M+jyoTDOs+H8/G5n
         UkrwfgNSpaXbWDWWBPB1nw5m0a1a1jNQ8EkPf5X/55C7SXqXFgjhugwVUTZglbC/1LKx
         R+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746040795; x=1746645595;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kpEwqfDzBbGKQdnSl3yMorTl0nsw+Xb/pGmM7auwuo=;
        b=LPnMAqnQ4QZM5ue9zlQ7pUnbnkOIqQ+gck9AIzpynUjtk0YMUh4F0Ifh5688oCRysn
         vmsHtozuIeQf4QHCfBVlE0gz9LIzinLz5QlMZ/1a+hg1inMfMpwOM/LtFdH0AZIchpAV
         4r9oUbQGr7twnltHp/OmmAcer4sfm/dS7lHN7es27/8nmf0CCXc/P7AflRzoTJEpz8nn
         Ruxkj884lvI5GOADeQ09ou2oe+t56izuhzZxwX8/eCdN8O73/SJ5YMvRSjHgJ/NjdXgr
         obAD+wPlhrafojehKybgXyhhhZAMcWrfSs8K8PuLoHkj7UwzBf5rLZUAgp1yGTmHpi5r
         74jQ==
X-Gm-Message-State: AOJu0YxaUcAGsWPPJ/cXU+5vH5i4Ax+/PPJIvuYL+DirxYhH5/UycmDr
	T5KZm4xPx33jl9rszzJG6WnVgMCxOL/6kU828bBK6yLk3SGwlOeHUwJ1xEmMrhE=
X-Gm-Gg: ASbGncsrPknCAi7KzQ7vB42gcDSmnHksy/vpzQiwRubsKmkoU7eZO1ZpC4ttWSZpQlK
	2wTvlryVkTTijtSUU3sdv7XmaGakKzDWh1PB6SCUo3zyX9+Rrz9t2RDb6QrNiTEsOlrL5jVAVy9
	dQo7Uj6WxAEnj7E4Ph8lU87Vijrm5O7HSG96KG8ZW5pAo1ApXOiGtCaMunqbqL2HG/3AEZOaHLY
	+K+nqi4YqXKjk93nMg9xTz0y+KRQA25oxvx9bLk1f229Y3oIUULifL93q5bM+JGZ9MChbvXsqvk
	96+THNvhzlGXt1+YUUZ7PGJGiCDu+MPKvbJIpuEm8dXB
X-Google-Smtp-Source: AGHT+IEd0NEegRoc/fcA5y5/hIIqYPu0koxO5Y7C6jpUVjF9Jb63DctkspNIVv1+JF8b0/hlKFDG9A==
X-Received: by 2002:a05:6402:5205:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5f8af09ae61mr2965964a12.23.1746040794653;
        Wed, 30 Apr 2025 12:19:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:b5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f6770sm9236861a12.43.2025.04.30.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:19:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Arthur Fabre
 <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>,  bpf
 <bpf@vger.kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,  Yan
 Zhai <yan@cloudflare.com>,  jbrandeburg@cloudflare.com,
  lbiancon@redhat.com,  Alexei Starovoitov <ast@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <87frhqnh0e.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Wed, 30 Apr 2025 11:19:29 +0200")
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
	<20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
	<CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
	<D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
	<CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
	<87frhqnh0e.fsf@toke.dk>
Date: Wed, 30 Apr 2025 21:19:51 +0200
Message-ID: <87ikmle9t4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfabr=
e.com> wrote:
>>>
>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfa=
bre.com> wrote:

[...]

>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>>   (via kfuncs).
>>>   But that doesn't expose them to the rest of the stack.
>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>   kernel to access and modify them (for example to into account
>>>   decapsulating a packet).
>>
>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
>> with bpf prog in skb layer via that "trait" format.
>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>> The kernel doesn't need to know how to parse that format.
>
> Yes it does, to propagate it to the skb later. I.e.,
>
> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
> CPUMAP: build skb, read hash from traits, populate skb hash
>
> Same thing for (at least) timestamps and checksums.
>
> Longer term, with traits available we could move more skb fields into
> traits to make struct sk_buff smaller (by moving optional fields to
> traits that don't take up any space if they're not set).

Perhaps we can have the cake and eat it too.

We could leave the traits encoding/decoding out of the kernel and, at
the same time, *expose it* to the network stack through BPF struct_ops
programs. At a high level, for example ->get_rx_hash(), not the
individual K/V access. The traits_ops vtable could grow as needed to
support new use cases.

If you think about it, it's not so different from BPF-powered congestion
algorithms and scheduler extensions. They also expose some state, kept in
maps, that only the loaded BPF code knows how to operate on.

