Return-Path: <netdev+bounces-187000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBBDAA46D3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273387A4984
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1B1E991A;
	Wed, 30 Apr 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPJcuV/t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934621B8FE
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004777; cv=none; b=DGbLj4/iW7zlOqvyONkZFa53jxpY/chcexRdtcaNAreRp42oJdb6oJiRsWT63uavOVtEcA1jeCVzctNYQs6/a9tUuy6WheeFDWIq3U6H4vK25rBuaF+si0P0aQIEWtUjK8chL20CnOQp32rTB5vPCqsYNszPCaDL9MGOLsUHJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004777; c=relaxed/simple;
	bh=NzjqY65tKTzm4sSMqkn1nzfqqg/tfpr0O5YMnpyemL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kifQnHx/tyZrqfV2cMfFBm6yfXyjx6W8+IVC6a+FLWApvnXSVWQBTwtNhilh2CGFr/hr4ZgWJ6XMkzkTdOkC78xhgPyvbZaGrWsUbyRf/vE4/DEJISNTIrB4fsy+eamNqml7cFF1tEcAmwN/01Wi7VbxrAHKb7SB7Jx5EZKONqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPJcuV/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746004774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SWvXC3ZakdpUd/TztKqtB1vPaAP+Ptq9p8VGkhV5eY=;
	b=dPJcuV/t0aL4t7YdEMiO8vMnpcqkKsxmKaXtaSO4x3FwdAdLATxrpndFVg0XWA6p3Ocuht
	S+5BcXRqeO3x79u/qia+7i/DULWh8dGNxk6X2PbLjbRlka7BNsroA61NWHD9AOSM9SH+kN
	bU0oaOEj4+ErHYYdWdrS9NWpn1AQ5sc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-hXHugPYuNr6akhQgQ6fq7Q-1; Wed, 30 Apr 2025 05:19:33 -0400
X-MC-Unique: hXHugPYuNr6akhQgQ6fq7Q-1
X-Mimecast-MFC-AGG-ID: hXHugPYuNr6akhQgQ6fq7Q_1746004772
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3c219371bso540325466b.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 02:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004772; x=1746609572;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SWvXC3ZakdpUd/TztKqtB1vPaAP+Ptq9p8VGkhV5eY=;
        b=wCvGBO5ILmKYZGHUYzugKRCBzYSiiNglqZCRkckDOn4k2trlnqK01NT8gh2mYEweIQ
         BjLdvFP23tpyoZHNkxgITJ63yrDWbuFeEx/vlb0tp4Tl6npLUaf4kAaFYoASRtyHfKdg
         xRRaaHyYdY1Ac0CCE7yLmpNcP2OAX3x/XpYJ7+fJ6jAZ5XX+0GeMhIV04JPJ0RGLToEh
         jSMsGuEDhwclCIoHBuhhjdz3IzyBpELDFqfAdScOWY4Q8K9Vmc23HXoEJZtcLjmDw8+6
         MjOgge+N8vGHpWiWS1HqzIYAQnD685BOW8ko9QNzgLZh0DMa6BBYWkf16Daii56erESP
         Mrjw==
X-Gm-Message-State: AOJu0YxFjHToD14/FCPAG2kPPFuaYP62OkOWIyEPE1BPJfKNex2IV9nK
	iVkv2iCifM+MTaLbmhKkcgGWJCd6GeINlnCWvBMhXcEvGoVKuTgubO7BhcFfSwh0Pjlxx3t8bG2
	2vQLl4zLd7r3QBGuiK71/WlkketyDWTL4nK0+tviOJ/4qNJWtoRmg/dIu8AAaLA==
X-Gm-Gg: ASbGnctY5QXocysaj5etXNEcC/7ba4xZxyYZqQ00fmqUonMOj6DGqN6euM54bFKeG7Q
	YcENbTlszEO3b0X7NbE0NxISEQb4gamguN1c97cB1VNBW0s33AVIKJLPwROws9T+S+jR6IJ20+h
	qnU3Oxh8kxrIR8mRM6EQxJdv9GijnEQVa4n/JYM3rcc2m3j3splWja9zColAN1Xeg/b13GOZ30e
	Bj8aET7jDPBWQSOeWybSevJLexRw+00HN6TxQADi1B/PWk+Z5luqLoC+3QCvVcEAp/2Yr3BvuK1
	v+E5IYOY
X-Received: by 2002:a17:907:3ea2:b0:aca:db46:f9a6 with SMTP id a640c23a62f3a-acedc7581admr273477266b.59.1746004771661;
        Wed, 30 Apr 2025 02:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWNG3emj92p4lNvwA+5hV5l4Uq+FjhLN8E2MV+BvNksTdqkMcnXWTOLiSP6vSlgGLiS81cA==
X-Received: by 2002:a17:907:3ea2:b0:aca:db46:f9a6 with SMTP id a640c23a62f3a-acedc7581admr273474466b.59.1746004771190;
        Wed, 30 Apr 2025 02:19:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41b5e7sm919465466b.13.2025.04.30.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:19:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 74CBF1A0816E; Wed, 30 Apr 2025 11:19:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arthur Fabre
 <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>,
 jbrandeburg@cloudflare.com, lbiancon@redhat.com, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
In-Reply-To: <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
 <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 30 Apr 2025 11:19:29 +0200
Message-ID: <87frhqnh0e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfabre=
.com> wrote:
>>
>> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
>> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfab=
re.com> wrote:
>> > >
>> > > +/**
>> > > + * trait_set() - Set a trait key.
>> > > + * @traits: Start of trait store area.
>> > > + * @hard_end: Hard limit the trait store can currently grow up agai=
nst.
>> > > + * @key: The key to set.
>> > > + * @val: The value to set.
>> > > + * @len: The length of the value.
>> > > + * @flags: Unused for now. Should be 0.
>> > > + *
>> > > + * Return:
>> > > + * * %0       - Success.
>> > > + * * %-EINVAL - Key or length invalid.
>> > > + * * %-EBUSY  - Key previously set with different length.
>> > > + * * %-ENOSPC - Not enough room left to store value.
>> > > + */
>> > > +static __always_inline
>> > > +int trait_set(void *traits, void *hard_end, u64 key, const void *va=
l, u64 len, u64 flags)
>> > > +{
>> > > +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
>> > > +               return -EINVAL;
>> > > +
>> > > +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
>> > > +
>> > > +       /* Offset of value of this key. */
>> > > +       int off =3D __trait_offset(*h, key);
>> > > +
>> > > +       if ((h->high & (1ull << key)) || (h->low & (1ull << key))) {
>> > > +               /* Key is already set, but with a different length */
>> > > +               if (__trait_total_length(__trait_and(*h, (1ull << ke=
y))) !=3D len)
>> > > +                       return -EBUSY;
>> > > +       } else {
>> > > +               /* Figure out if we have enough room left: total len=
gth of everything now. */
>> > > +               if (traits + sizeof(struct __trait_hdr) + __trait_to=
tal_length(*h) + len > hard_end)
>> > > +                       return -ENOSPC;
>> >
>> > I'm still not excited about having two metadata-s
>> > in front of the packet.
>> > Why cannot traits use the same metadata space ?
>> >
>> > For trait_set() you already pass hard_end and have to check it
>> > at run-time.
>> > If you add the same hard_end to trait_get/del the kfuncs will deal
>> > with possible corruption of metadata by the program.
>> > Transition from xdp to skb will be automatic. The code won't care that=
 traits
>> > are there. It will just copy all metadata from xdp to skb. Corrupted o=
r not.
>> > bpf progs in xdp and skb might even use the same kfuncs
>> > (or two different sets if the verifier is not smart enough right now).
>>
>> Good idea, that would solve the corruption problem.
>>
>> But I think storing metadata at the "end" of the headroom (ie where
>> XDP metadata is today) makes it harder to persist in the SKB layer.
>> Functions like __skb_push() assume that skb_headroom() bytes are
>> available just before skb->data.
>>
>> They can be updated to move XDP metadata out of the way, but this
>> assumption seems pretty pervasive.
>
> The same argument can be flipped.
> Why does the skb layer need to push?
> If it needs to encapsulate it will forward to tunnel device
> to go on the wire. At this point any kind of metadata is going
> to be lost on the wire. bpf prog would need to convert
> metadata into actual on the wire format or stash it
> or send to user space.
> I don't see a use case where skb layer would move medadata by N
> bytes, populate these N bytes with "???" and pass to next skb layer.
> skb layers strip (pop) the header when it goes from ip to tcp to user spa=
ce.
> No need to move metadata.
>
>> By using the "front" of the headroom, we can hide that from the rest of
>> the SKB code. We could even update skb->head to completely hide the
>> space used at the front of the headroom.
>> It also avoids the cost of moving the metadata around (but maybe that
>> would be insignificant).
>
> That's a theory. Do you actually have skb layers pushing things
> while metadata is there?

Erm, any encapsulation? UDP tunnels, wireguard, WiFi, etc. There are
almost 1000 calls to skb_push() all over the kernel. One of the primary
use cases for traits is to tag a packet with an ID to follow it
throughout its lifetime inside the kernel. This absolutely includes
encapsulation; in fact, having the tracing ID survive these kinds of
transformations is one of the primary motivators for this work.

>> XDP metadata also doesn't work well with GRO (see below).
>>
>> > Ideally we add hweight64 as new bpf instructions then maybe
>> > we won't need any kernel changes at all.
>> > bpf side will do:
>> > bpf_xdp_adjust_meta(xdp, -max_offset_for_largest_key);
>> > and then
>> > trait_set(xdp->data_meta /* pointer to trait header */, xdp->data /*
>> > hard end */, ...);
>> > can be implemented as bpf prog.
>> >
>> > Same thing for skb progs.
>> > netfilter/iptable can use another bpf prog to make decisions.
>>
>> There are (at least) two reasons for wanting the kernel to understand the
>> format:
>>
>> * GRO: With an opaque binary blob, the kernel can either forbid GRO when
>>   the metadata differs (like XDP metadata today), or keep the entire blob
>>   of one of the packets.
>>   But maybe some users will want to keep a KV of the first packet, or
>>   the last packet, eg for receive timestamps.
>>   With a KV store we can have a sane default option for merging the
>>   different KV stores, and even add a per KV policy in the future if
>>   needed.
>
> We can have this default for metadata too.
> If all bytes in the metadata blob are the same -> let it GRO.

But that is exactly what we do with metadata today, and it is limiting
use cases. For instance, timestamps are going to differ, but we don't
want that to block GRO, we just want to keep one of the timestamps. So
being able to set a "GRO policy" *per key in the KV-store* is useful.

> I don't think it's a good idea to extend GRO with bpf to make it "smart".

That would be a separate project; for this, the proposal is to make the
kernel understand a couple of different policies (block GRO, keep first,
keep last, discard) per key.

>> * Hardware metadata: metadata exposed from NICs (like the receive
>>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>>   (via kfuncs).
>>   But that doesn't expose them to the rest of the stack.
>>   Storing them in traits would allow XDP, other BPF programs, and the
>>   kernel to access and modify them (for example to into account
>>   decapsulating a packet).
>
> Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
> with bpf prog in skb layer via that "trait" format.
> xdp can take tuple hash and store it as key=3D=3D0 in the trait.
> The kernel doesn't need to know how to parse that format.

Yes it does, to propagate it to the skb later. I.e.,

XDP prog on NIC: get HW hash, store in traits, redirect to CPUMAP
CPUMAP: build skb, read hash from traits, populate skb hash

Same thing for (at least) timestamps and checksums.

Longer term, with traits available we could move more skb fields into
traits to make struct sk_buff smaller (by moving optional fields to
traits that don't take up any space if they're not set).

-Toke


