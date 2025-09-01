Return-Path: <netdev+bounces-218953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551F2B3F144
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 00:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CA5487580
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D92848A6;
	Mon,  1 Sep 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="QuuzYlIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E627E040
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756767256; cv=none; b=aC5uQmiMMTuUvryA2zGRMWwXnNbS4LHI2ksRAn2fYU2vcpvJPEUvXcqew4kvOqTjDngb/zkbJC1pXQvHcJqEIPoi5FmOf9k4HKa6sBvOeVhkuCjwjowDmHbZOL0DF9XeADS7JuFyqce7K23/CaiKbHEd+A+pKQ2gsuBY5avEqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756767256; c=relaxed/simple;
	bh=PMz28xRj3Hg630kd7aDLd+/aYr3B11hoj3GjxCa8Pw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBXIrscuDMu9vAzIj+P2wnHy+SynVbEf01GOj0gwZpj2RITQ2WkeEjOLnq0VTH0apI2HdX9Kgbud639gpkeJDnaRnTW+izJDrK6tjWlXWsQMW8ZJhliIzP2lHO8wkG9TWuwmOZ25DMYZDWBpfz8xQvL1yXnJ9q1alKJEsloQ1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=QuuzYlIV; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UHIMcOOtjMACXSXTU/aEmnIa0vIq7rEOhxOgp5Aj5cQ=; t=1756767254; x=1757631254; 
	b=QuuzYlIV2+yJUzoI89+lv/SUegVVODey/uQ1Gqhqqxv23FmPj2VrDVeiwZWyE/SPqDzu7J5ZyhK
	321dhOIrwj3uGtR2j8GOioQuEZyaiiINHWZP+D7VX6PBOclttBljpXygzBFQgU+WRCjPXlOPBC2fy
	5r8ehMrsMpeJDGcOHWltKZxBXFioMVAQCujH/wLqER1hF82SCYdW2D2dB8dBiI/J1FnGX1+8APBdS
	tNFuBeX2AmZMrjG6pDlxmoOfYBY2nuHKJ8dNBeLqJy1Z4q5i7WQWDzdVuJMawgDEp2TuXsNx2KOnu
	BxkKfSz9c6g/duuzbfGSTQk5NQtMQNtXNXGg==;
Received: from mail-oa1-f48.google.com ([209.85.160.48]:55649)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utDPg-00036o-E7
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 15:54:13 -0700
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-315c0bc5a8cso862006fac.3
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 15:54:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzfr0Qu/RSjH1qOw1pGVJZKKKRIGICMwAHoD4NJ3Stm8vOIWZuK
	wYou3zhreSP1M7+GQAYGLLe3Ls8Hp9gVMavc2qc7kL/cdS9P1Q0CBw06MYeuXRR51LjMSBi9I38
	iaHdhJPnJFWq1un2IE9EOJUlbJO3Y0HI=
X-Google-Smtp-Source: AGHT+IEBU2Qxh03jDdzo/O59rdo9/s1RHiC75rZfZJfWkvVVBnmL8YQfknTodCMqeEGBIRaMUrD2oYRSXn2ZNHJ/nbI=
X-Received: by 2002:a05:6808:7005:b0:434:231:3e41 with SMTP id
 5614622812f47-437f7d994damr4276326b6e.38.1756767251751; Mon, 01 Sep 2025
 15:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-15-ouster@cs.stanford.edu>
 <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com>
In-Reply-To: <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 15:53:35 -0700
X-Gmail-Original-Message-ID: <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
X-Gm-Features: Ac12FXyXUwkpKpicK7_RAYNDZL6UKUxgJ7cc3AdZVLK9v1In2ad5sbGvmr99Ujs
Message-ID: <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: bd27203d7a2d5412f70ab6183b407a6c

On Tue, Aug 26, 2025 at 9:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> > +     status =3D proto_register(&homa_prot, 1);
> > +     if (status !=3D 0) {
> > +             pr_err("proto_register failed for homa_prot: %d\n", statu=
s);
> > +             goto error;
> > +     }
> > +     init_proto =3D true;
>
> The standard way of handling the error paths it to avoid local flags and
> use different goto labels.

I initially implemented this with different goto labels, but there
were so many different labels that the code became unmanageable (very
difficult to figure out what to change when adding or removing
initializers). The current approach is *way* cleaner and more obvious,
so I hope I can keep it. The label approach works best when there is
only one label that collects all errors.

> > +/**
> > + * homa_softirq() - This function is invoked at SoftIRQ level to handl=
e
> > + * incoming packets.
> > + * @skb:   The incoming packet.
> > + * Return: Always 0
> > + */
> > +int homa_softirq(struct sk_buff *skb)
> > +{
> > +     struct sk_buff *packets, *other_pkts, *next;
> > +     struct sk_buff **prev_link, **other_link;
> > +     struct homa_common_hdr *h;
> > +     int header_offset;
> > +
> > +     /* skb may actually contain many distinct packets, linked through
> > +      * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
> > +      * pass through the list to process all of the short packets,
> > +      * leaving the longer packets in the list. Also, perform various
> > +      * prep/cleanup/error checking functions.
>
> It's hard to tell without the GRO/GSO code handy, but I guess the
> implementation here could be simplified invoking __skb_gso_segment()...

This mechanism relates to GRO, not GSO. I suggest we hold off on this
discussion until I submit the GRO patch; I'm pretty sure there will be
a *lot* of discussion about that :-)

> > +      */
> > +     skb->next =3D skb_shinfo(skb)->frag_list;
> > +     skb_shinfo(skb)->frag_list =3D NULL;
> > +     packets =3D skb;
> > +     prev_link =3D &packets;
> > +     for (skb =3D packets; skb; skb =3D next) {
> > +             next =3D skb->next;
> > +
> > +             /* Make the header available at skb->data, even if the pa=
cket
> > +              * is fragmented. One complication: it's possible that th=
e IP
> > +              * header hasn't yet been removed (this happens for GRO p=
ackets
> > +              * on the frag_list, since they aren't handled explicitly=
 by IP.
>
> ... at very least it will avoif this complication and will simplify the
> list handling.

As with the comment above, let's defer until you see the GRO mechanism
(a preview: Homa aggregates out-of-order packets in GRO, or even
packets from different RPCs, so it has to retain header information in
the aggregated data).

> > +              */
> > +             if (!homa_make_header_avl(skb))
> > +                     goto discard;
>
> It looks like the above is too aggressive, i.e. pskb_may_pull() may fail
> for a correctly formatted homa_ack_hdr - or any other packet with hdr
> size < HOMA_MAX_HEADER

I think it's OK: homa_make_header_avl pulls the min of HOMA_MAX_HEADER
and the packet length. This may pull some bytes byte that aren't in
the header, but is that a problem? (this approach seemed
simpler/faster than trying to compute the header length on a
packet-by-packet basis; for example, )

> > +             header_offset =3D skb_transport_header(skb) - skb->data;
> > +             if (header_offset)
> > +                     __skb_pull(skb, header_offset);
> > +
> > +             /* Reject packets that are too short or have bogus types.=
 */
> > +             h =3D (struct homa_common_hdr *)skb->data;
> > +             if (unlikely(skb->len < sizeof(struct homa_common_hdr) ||
> > +                          h->type < DATA || h->type > MAX_OP ||
> > +                          skb->len < header_lengths[h->type - DATA]))
> > +                     goto discard;
> > +
> > +             /* Process the packet now if it is a control packet or
> > +              * if it contains an entire short message.
> > +              */
> > +             if (h->type !=3D DATA || ntohl(((struct homa_data_hdr *)h=
)
> > +                             ->message_length) < 1400) {
>
> I could not fined where `message_length` is validated. AFAICS
> data_hdr->message_length could be > skb->len.
>
> Also I don't see how the condition checked above ensures that the pkt
> contains the whole message.

Long messages consist of multiple packets, so it is fine if
data_hdr->message_length > skb->len. That said, Homa does not fragment
a message into multiple packets unless necessary, so if the condition
above is met, then the message is contained in a single packet (if for
some reason a sender fragments a short message, that won't cause
problems).

The message length is validated in homa_message_in_init, invoked via
homa_softirq -> homa_dispatch_pkts -> homa_data_pkt ->
homa_message_in_init.

For comments that I haven't responded to explicitly here, I have
implemented your suggested fix.

-John-

