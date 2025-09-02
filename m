Return-Path: <netdev+bounces-219355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F59B410A1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F41B63EE8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C61E9905;
	Tue,  2 Sep 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="apcsHi9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20923B0
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854956; cv=none; b=p8BbiZ5pD5K+Pr1fVUpQAropNDRh1u9WRYXAxbpA013f7Mihyq+lG+9Bi5LLRkLnSEh24DrCdOFvJb6UZgzvZtLtOpeyz+ziwL4c1x37RUh3OD801MN9IyVRcL5uItJIO9sBtk20ObDqau7pQ59BXffYJ2GCOnzJQt074ZXGyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854956; c=relaxed/simple;
	bh=DbQCvqYChsHNKA+kj4v8hsxID/VZEKq3C7g+d7mEY2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3k00hHjuxDp3BZAPNaW9Dt/Mi18g5AetO+neBeJ9PE/eWMLUOaXpmuHCLjHKwY8wggRLKIxMj+Qp1z/rx9UkjLem5paXfYRBa2nZDqdSzzfpTbYoiDFj4bfTmkxxRUlfDpjInkzWKNTgDqHnSHuCKq17Mh/VIbsIK1Wjfb5U2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=apcsHi9K; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aoJ6mDX6X02ow2aBjJLKBdD9+WaCfDN9/SM8s+5Nlk8=; t=1756854954; x=1757718954; 
	b=apcsHi9KqdgLksiTd9Bh47fEp3J2tRwVpKI/fj5gwMnyil6HK4/NcsTNAF2Bfk5AxWFu6UzJyn7
	7AMruRijEtYpgHOtCkKjKUNx/4ARp2vKbs3lgvAxr+s0dSBSwhtmmy81jwnlITcqSW58pLz+T6sFI
	nxZK51E4SHgIb8Iv1mYp0/qeYouPpuodTXXQ4QR8rNzi+RW13AmurnzO08Ru1gyj4rYRv13Q8tpOI
	uj3t6GJKolL8/zsYl6B9Cw26eovw9/6SxiHFHtpjqMMUk4GHzIxZ2sUuzz25b3tr8gXGm+6xaEjss
	+eedi7teuz1aTo/tmusa0hlm6AR9RjIYhqjw==;
Received: from mail-oo1-f49.google.com ([209.85.161.49]:43173)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utaED-00021k-8B
	for netdev@vger.kernel.org; Tue, 02 Sep 2025 16:15:53 -0700
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bc52fd7a4so296601eaf.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 16:15:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFd1ra9NxoXoKAEm/ip8UXxNAyQ7LhRW81ikinX0cWHcpxmxcH
	toi+RQcro/k/ZJRpI/oJnVCjazc3kgIPqlHcuGDuqNnt44xWn77XGsGaojHPgAsCFTCgg9jM8Qd
	uki+IgHqd3rLLA5hGu+gAINxIdn9oG+s=
X-Google-Smtp-Source: AGHT+IFDmUqLrMrDvFQcSAno+peXY3+dIeWyvNeHNxD7xyDuC8Uw6DgCi0fiidAXA4sLsUItN5gq0brlkbOqQtIoGfA=
X-Received: by 2002:a05:6808:4f23:b0:433:fabb:9b19 with SMTP id
 5614622812f47-437f600c0e8mr5900610b6e.3.1756854952645; Tue, 02 Sep 2025
 16:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-15-ouster@cs.stanford.edu>
 <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com> <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
 <6efc1a99-b5b1-4a22-9655-fb9193e02a7f@redhat.com>
In-Reply-To: <6efc1a99-b5b1-4a22-9655-fb9193e02a7f@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 2 Sep 2025 16:15:16 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzgw3FCgXaKHQr4fFJw-ETsuD_uyZC54AHV76BGH280vA@mail.gmail.com>
X-Gm-Features: Ac12FXwvrXeVqzLQ4ZkOFBIj-Mmo1OgC1yixS93zsuBbAF8b0LKj9ddcAGrBOLY
Message-ID: <CAGXJAmzgw3FCgXaKHQr4fFJw-ETsuD_uyZC54AHV76BGH280vA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 1c1d34d4ae2aac1d1f929c6f17b0cb0c

On Tue, Sep 2, 2025 at 1:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 9/2/25 12:53 AM, John Ousterhout wrote:
> > On Tue, Aug 26, 2025 at 9:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>> +             header_offset =3D skb_transport_header(skb) - skb->data=
;
> >>> +             if (header_offset)
> >>> +                     __skb_pull(skb, header_offset);
> >>> +
> >>> +             /* Reject packets that are too short or have bogus type=
s. */
> >>> +             h =3D (struct homa_common_hdr *)skb->data;
> >>> +             if (unlikely(skb->len < sizeof(struct homa_common_hdr) =
||
> >>> +                          h->type < DATA || h->type > MAX_OP ||
> >>> +                          skb->len < header_lengths[h->type - DATA])=
)
> >>> +                     goto discard;
> >>> +
> >>> +             /* Process the packet now if it is a control packet or
> >>> +              * if it contains an entire short message.
> >>> +              */
> >>> +             if (h->type !=3D DATA || ntohl(((struct homa_data_hdr *=
)h)
> >>> +                             ->message_length) < 1400) {
> >>
> >> I could not fined where `message_length` is validated. AFAICS
> >> data_hdr->message_length could be > skb->len.
> >>
> >> Also I don't see how the condition checked above ensures that the pkt
> >> contains the whole message.
> >
> > Long messages consist of multiple packets, so it is fine if
> > data_hdr->message_length > skb->len. That said, Homa does not fragment
> > a message into multiple packets unless necessary, so if the condition
> > above is met, then the message is contained in a single packet (if for
> > some reason a sender fragments a short message, that won't cause
> > problems).
>
> Let me rephrase: why 1400? is that MRU dependent, or just an arbitrary
> threshold? What if the NIC can receive 8K frames (or max 1024 bytes long
> one)? What if the stack adds a long encapsulation?
>
> What if an evil/bugged peer set message_length to a random value (larger
> than the amount of bytes actually sent or smaller than that)?

1400 is an arbitrary threshold. This has no impact on functionality or
correctness; it is simply used to reorder the packets in a batch so
that shorter messages get processed first. If the NIC can receive 8K
frames it won't change this threshold; only frames shorter than 1400
will get the scheduling boost. If a message shorter than 1400 bytes
arrives in multiple packets, all of the packets will get the boost.

A sender could cheat the mechanism by declaring the message length to
less than 1400 bytes when the message is really longer than that. This
would cause the message's packets to get priority for SoftIRQ
processing, but all of the extra data in the message beyond the stated
length would be discarded, so I'm not sure how the sender would
benefit from this.

-John-

