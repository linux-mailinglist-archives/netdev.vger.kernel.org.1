Return-Path: <netdev+bounces-187709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E6AA90C3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5613B7E1D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F721FE477;
	Mon,  5 May 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bb5TEMNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770A1F8750
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440287; cv=none; b=X2d1rO2nRFVSmaOyYHuD1jyrMeRUqi9wjtzA6wA3rXIpEIX3mVlT58jVTDLTdjVikdg6rwk6JmxRwLZT3oI6PMs5FdMCfWw8x4mebEKb0wgqZ1uZ7XvxWhuCxJJ0cZ3yxi/UEA3/kPt5TMY1SKBNlRHAhm2gFGRlpZ3LwUk48/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440287; c=relaxed/simple;
	bh=u6UJvftXl/qVaj3cvtTQnsXX+lktC8Txo7KTLoqlWQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkmYQpcR6TElZKLacBEBjlwM03mJH/HeTAy5dbi71kKzwnfAoqB1KqRE/BWuqqmqUuoVWYsd60mu/IokkTh9xhVZcrpReasSc17ESNetmexlj/qqD1D0jOzEJRTA7wPxYd/taPihI+JDm+elb4/IEKfxzKfZZ+XgehCWG9I4aeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bb5TEMNX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acacb8743a7so750766766b.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746440284; x=1747045084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMbhdiZlrz9sQo5PTc3FJMOwGE5ASsIiJRGUlISPKrM=;
        b=bb5TEMNXsEDDBiCxioB7iqQZFAqa1FDpClXNx1rn+KGTZjHiq29Mk0bAEYKL2K5swV
         MhIhZTmU8SSdL7i6aUhm6Zo/qHCabou3xjnCMLGnLMub+m220/g0kZ187YbouWJG/jiW
         v2BRvVSoFYxQUlUQY0xSiHTEdLHjna9vuPvTcXFmgM78k2P9DAeh/jF3JOIFY771mV95
         oRpl/jxA3rL1a30HBJqvlER1rVwEK0ucCKMhXJN6gWXiPj26dkZGygVuP0e58hMcrGpm
         tY2ZzYwAHnBF0l0bgHwDkqL/bA5Hn4KKoAEIuUGfZhSjcGzgGUG1V3UcNCPTDPjIFqiR
         MJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746440284; x=1747045084;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMbhdiZlrz9sQo5PTc3FJMOwGE5ASsIiJRGUlISPKrM=;
        b=MIYIWT0VRQ2x9/5gLzYdDVnsMQkLhCqLs1hf79omucLJaEUw6LfHtzrBZz54QH3qiZ
         5PeZboao823gOeOvS0dWhzjJMU+/C4wOKIagjBFf5ufmqCtMv1AZiyjmYUrLTKKwb4+m
         RT3dlLH3M1OKPPU0qgDR8o0jeoXfRL+mIhMQPtXe3EVOmxk41pY/9Z/kq0rt6Ymr7M9U
         GlmK8VSSDMj1qThZG7oMIeeCYWMRWrTiTZfaVg8hvuoUiSAob3VtANaHcq1EvMIZkrwI
         OOy5bwZNmVXSx+W/NIyNWZbT3A2AGULAAY4PEXOJf5KbHm+rP5sN3bDcUrZwgYFGzlfz
         KfJA==
X-Forwarded-Encrypted: i=1; AJvYcCW/wnhfwGSFUUAU8KwgOyT8dU4sBse1HVrUN0rRbAEiywMjUNWHweccE2DxlVGRBK6wdWpMUxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSCC0b9bO3KKmOKyMnTkVY+wzQ7rQQJc/xzx/zSQscscDPwwW
	5rh74u93ZS48lEvyATpLkteBMCfuc35nLXysPsjMwa9sYROAGQ94qsIQ7lQkLPQ=
X-Gm-Gg: ASbGncvh7e1wK+JqHDSrlXt09cYwciVJIxXzNqB7/eEXOtUsQo8aKX3Fltp/h6sJgoL
	WdrqtbU7paYP3KNZSa7+7PD9iGwKGs63pOEFo5pwZTd1TeZnSWqE6iI+wK2lFXS8PwtasZzfJZj
	aCac3Zv1D80luyqKGkAPovsNtklfpQDnVV8YeorJxtxyvOU63Qp4MvhpKUm8w9qJ2Lnev5gHL87
	x/re+3+yYSqG6PkxfuhwpLJsoxl+k1sctfG9Eb+3tF0W6usP6M8gvqAapRXEhUuCcVYQj/Oq20k
	9JPoqrwucm68cbnJDxytOZcSXeKrDoXxNHgmBfqqzGgd
X-Google-Smtp-Source: AGHT+IE2wY2PK0C5jJCoFtzx86MRmfe79fZW3T8K2lfOOBs1qMJjYT2VLZfOgfwkob8g9n8DTGTI/w==
X-Received: by 2002:a17:907:d041:b0:acb:b9ab:6d75 with SMTP id a640c23a62f3a-ad17af32546mr1000075466b.23.1746440283820;
        Mon, 05 May 2025 03:18:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895400fesm463031466b.167.2025.05.05.03.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 03:18:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Arthur Fabre
 <arthur@arthurfabre.com>,  Network Development <netdev@vger.kernel.org>,
  bpf <bpf@vger.kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Yan Zhai <yan@cloudflare.com>,  jbrandeburg@cloudflare.com,
  lbiancon@redhat.com,  Alexei Starovoitov <ast@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <875xik7gsk.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Thu, 01 May 2025 12:43:07 +0200")
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
	<20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
	<CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
	<D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
	<CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
	<87frhqnh0e.fsf@toke.dk> <87ikmle9t4.fsf@cloudflare.com>
	<875xik7gsk.fsf@toke.dk>
Date: Mon, 05 May 2025 12:18:01 +0200
Message-ID: <87a57r4azq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 12:43 PM +02, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> Jakub Sitnicki <jakub@cloudflare.com> writes:
>
>> On Wed, Apr 30, 2025 at 11:19 AM +02, Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>
>>>> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfa=
bre.com> wrote:
>>>>>
>>>>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>>>>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthur=
fabre.com> wrote:
>>
>> [...]
>>
>>>>> * Hardware metadata: metadata exposed from NICs (like the receive
>>>>>   timestamp, 4 tuple hash...) is currently only exposed to XDP progra=
ms
>>>>>   (via kfuncs).
>>>>>   But that doesn't expose them to the rest of the stack.
>>>>>   Storing them in traits would allow XDP, other BPF programs, and the
>>>>>   kernel to access and modify them (for example to into account
>>>>>   decapsulating a packet).
>>>>
>>>> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communica=
te
>>>> with bpf prog in skb layer via that "trait" format.
>>>> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
>>>> The kernel doesn't need to know how to parse that format.
>>>
>>> Yes it does, to propagate it to the skb later. I.e.,
>>>
>>> XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
>>> CPUMAP: build skb, read hash from traits, populate skb hash
>>>
>>> Same thing for (at least) timestamps and checksums.
>>>
>>> Longer term, with traits available we could move more skb fields into
>>> traits to make struct sk_buff smaller (by moving optional fields to
>>> traits that don't take up any space if they're not set).
>>
>> Perhaps we can have the cake and eat it too.
>>
>> We could leave the traits encoding/decoding out of the kernel and, at
>> the same time, *expose it* to the network stack through BPF struct_ops
>> programs. At a high level, for example ->get_rx_hash(), not the
>> individual K/V access. The traits_ops vtable could grow as needed to
>> support new use cases.
>>
>> If you think about it, it's not so different from BPF-powered congestion
>> algorithms and scheduler extensions. They also expose some state, kept in
>> maps, that only the loaded BPF code knows how to operate on.
>
> Right, the difference being that the kernel works perfectly well without
> an eBPF congestion control algorithm loaded because it has its own
> internal implementation that is used by default.

It seems to me that any code path on the network stack still needs to
work *even if* traits K/V is not available. There has to be a fallback -
like, RX hash not present in traits K/V? must recompute it. There is no
guarantee that there will be space available in the traits K/V store for
whatever value the network stack would like to cache there.

So if we can agree that traits K/V is a cache, with limited capacity,
and any code path accessing it must be prepared to deal with a cache
miss, then I think with struct_ops approach you could have a built-in
default implementation for exclusive use by the network stack.

This default implementation of the storage access just wouldn't be
exposed to the BPF or user-space. If you want access from BPF/userland,
then you'd need to provide a BPF-backed struct_ops for accessing traits
K/V.

> Having a hard dependency on BPF for in-kernel functionality is a
> different matter, and limits the cases it can be used for.

Notice that we already rely on XDP program being attached or the storage
for traits K/V is not available.

> Besides, I don't really see the point of leaving the encoding out of the
> kernel? We keep the encoding kernel-internal anyway, and just expose a
> get/set API, so there's no constraint on changing it later (that's kinda
> the whole point of doing that). And with bulk get/set there's not an
> efficiency argument either. So what's the point, other than doing things
> in BPF for its own sake?

There's the additional complexity in the socket glue layer, but I've
already mentioned that.

What I think makes it even more appealing is that with the high-level
struct_ops approach, we abstract away the individual K/V pair access and
leave the problem of "key registration" (e.g., RX hash is key 42) to the
user-provided implementation.

You, as the user, decide for your particular system how you want to lay
out the values and for which values you actually want to reserve
space. IOW, we leave any trade off decisions to the user in the spirit
of providing a mechanism, not policy.

