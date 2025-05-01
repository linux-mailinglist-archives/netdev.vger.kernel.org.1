Return-Path: <netdev+bounces-187220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8490EAA5D65
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9BB4C411B
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA721B180;
	Thu,  1 May 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLaKCkVu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341C221555
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746096198; cv=none; b=Mvi5Goh/28DTG7Qh2SlbsnAbyjX2zD3pXfGSOJgh/duXlC84uvRN3dmzGFQ0u1bbliKbPekhC/kDlMTakqyWjg50Pg8pqH5HBBCxEkrq0EWoOPdYhJkzR1TG5imFM+nT4QUlruMKGlkW0OWfZQEsAmiILgyPgagShVxeeJqm+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746096198; c=relaxed/simple;
	bh=uFwiqbBT7QiRct0/SRVF+W9Nz3gjwIgP+qqQUe/60xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUIpwy2zKVtc4Tcf3ubpye37o9qYotGW1XUjl7VALVzhoJ4k3iCbYJj7GZXOwmUmmkk8UXYG+kL4oVLLkmIw/zSj+QFbEnIJwmoABT59+PofOWHQAO8IizPm8bu8oNkHYWrskxWwi19AqQ46xffm6zh9jcKqP8aX/pHmMzcnfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLaKCkVu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746096195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiDFoQOB+YriU47Yf7CEanBcEHOAtpPsQZhUMA1nA84=;
	b=GLaKCkVufTJLdkz6jG2Ut4tmjwuBP4T2rC8i/HD34NpXxvyQ869dkwz+0CtqDRRLTvpZeT
	gBbHXM3xzg66IztPjS//KNoIKbd3JOQHnskD5xnr7ZeHv3ZeyRJE8rgr7N9OIVm6jxyJha
	8Ri3YfztLYiEwYBgEmOlIghleeXg6G0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461--AEyMeFqMf6jmR7Ny4IKfg-1; Thu, 01 May 2025 06:43:12 -0400
X-MC-Unique: -AEyMeFqMf6jmR7Ny4IKfg-1
X-Mimecast-MFC-AGG-ID: -AEyMeFqMf6jmR7Ny4IKfg_1746096191
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf9ed6da1so3160141fa.2
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 03:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746096190; x=1746700990;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiDFoQOB+YriU47Yf7CEanBcEHOAtpPsQZhUMA1nA84=;
        b=sMF21zpqglMi51dUTKbnT96oP+l2xagp3JjTX55o94IiWGbe376C3F3nM3DlKAiw/y
         3s6xE6g7qxVD5+PUvIlfaqYcqLUSkl3Yrb414OKqd8WFFnHHUEvzHqHzM88yNyJFEt8Y
         gCYYJtxGqOGH5Ga/Afwv705sy0DZlCRBemefqfaM2EU6NXilhgCc5VIdqHRUekyxpQXQ
         mZ5SyNf9KujLcblFt3u7xgNyL6h2GSszuB8mHPLCht8KflVxdyoRSSrh/xrFL7ZiLmWg
         Mhu1CajbemgD7zz3oxGLP3PVrcUmKbDLSho1j55MNxhLozGxzWjxEOJ6+NeW+B3APvnP
         pOdg==
X-Gm-Message-State: AOJu0Yz99uFTwxPQiYmlBgL7VZle89BimWPjbSo4CCapPJp1wjZHvRR7
	5wiGzQvglofS4n3KcVQZxGGgN5j2rz27JwSUplggfkINy8d6gsXZuKmI62/J7cz51LVTCQKKkFX
	sc8F2HI9l5No5Fn6w+jx7wzTrdH941FixROzJbZV75EolvLq1EFfOLA==
X-Gm-Gg: ASbGncvVH8bQccmd39Js+t6LlB5q2suupImd7m6HekD/phm6mO+8Lbizy4/HFy7TB27
	0a8t0FSi0SkLu8jBbT2w31rLhSHlRJDgps42yGJ5ABog6x+bGmzjcECQy3BqkgF2cPM7DWeeFpj
	+SjoSmtPCiKHVumd9vYdAhnqpcORqv4BuEgOk7fvBqkwZgJNlA0lMhFTBY9h6yB+Xx8Z1pc/HqE
	C2UR4bpRGMhqQFDOdUB5vvYLtj9XoDT1HWneRSYjov83RMh4i7/2iFS6tJ2dVgj5/RmdfFvo1U1
	ydqumcYzLwA+r6GKnDJOpQ7t9igAUV2xfa1e
X-Received: by 2002:a05:6512:23a3:b0:549:66c9:d0d9 with SMTP id 2adb3069b0e04-54ea33b45f7mr2109623e87.53.1746096190495;
        Thu, 01 May 2025 03:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHngkBRxO36POnN4Us1uA3Ii4VPY1PcVyxolJIqXZfmRksIwyZrazkF5hMgJ4+LQ7HoOSyNXQ==
X-Received: by 2002:a05:6512:23a3:b0:549:66c9:d0d9 with SMTP id 2adb3069b0e04-54ea33b45f7mr2109614e87.53.1746096190075;
        Thu, 01 May 2025 03:43:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c08e7sm62779e87.73.2025.05.01.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:43:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3EF91A0825C; Thu, 01 May 2025 12:43:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>,
 jbrandeburg@cloudflare.com, lbiancon@redhat.com, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <87ikmle9t4.fsf@cloudflare.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
 <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
 <87frhqnh0e.fsf@toke.dk> <87ikmle9t4.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 May 2025 12:43:07 +0200
Message-ID: <875xik7gsk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki <jakub@cloudflare.com> writes:

> On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfab=
re.com> wrote:
>>>>
>>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurf=
abre.com> wrote:
>
> [...]
>
>>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>>>   (via kfuncs).
>>>>   But that doesn't expose them to the rest of the stack.
>>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>>   kernel to access and modify them (for example to into account
>>>>   decapsulating a packet).
>>>
>>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
>>> with bpf prog in skb layer via that "trait" format.
>>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>>> The kernel doesn't need to know how to parse that format.
>>
>> Yes it does, to propagate it to the skb later. I.e.,
>>
>> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
>> CPUMAP: build skb, read hash from traits, populate skb hash
>>
>> Same thing for (at least) timestamps and checksums.
>>
>> Longer term, with traits available we could move more skb fields into
>> traits to make struct sk_buff smaller (by moving optional fields to
>> traits that don't take up any space if they're not set).
>
> Perhaps we can have the cake and eat it too.
>
> We could leave the traits encoding/decoding out of the kernel and, at
> the same time, *expose it* to the network stack through BPF struct_ops
> programs. At a high level, for example ->get_rx_hash(), not the
> individual K/V access. The traits_ops vtable could grow as needed to
> support new use cases.
>
> If you think about it, it's not so different from BPF-powered congestion
> algorithms and scheduler extensions. They also expose some state, kept in
> maps, that only the loaded BPF code knows how to operate on.

Right, the difference being that the kernel works perfectly well without
an eBPF congestion control algorithm loaded because it has its own
internal implementation that is used by default.

Having a hard dependency on BPF for in-kernel functionality is a
different matter, and limits the cases it can be used for.

Besides, I don't really see the point of leaving the encoding out of the
kernel? We keep the encoding kernel-internal anyway, and just expose a
get/set API, so there's no constraint on changing it later (that's kinda
the whole point of doing that). And with bulk get/set there's not an
efficiency argument either. So what's the point, other than doing things
in BPF for its own sake?

-Toke


