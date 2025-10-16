Return-Path: <netdev+bounces-230163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99DFBE4D3D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8581A66D55
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78430FF3C;
	Thu, 16 Oct 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiiaMXrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F72FCC16
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635239; cv=none; b=CB/pzXgyFgfDcn5pCkH4PRYZVcQ2MuEJW4Fto7yedpA6XN51oiclBsarTuqMUQDZ9X3JtroO8JAZ0fe0ecaxHmAefi36wbDhvj+ScMS+c1IJfTrynNAGWfFvTUlzG1C1XJkTr1BmTWQ6GnjZkzUmQQfHXsXk9jaURwmKE6zD4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635239; c=relaxed/simple;
	bh=pCSGntMl8ABptLwDAU2TFk4mc9b3X12Q+izhQyFra3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIgTwpIcw/Dkmt/2KBX0NPFo4fw/oY/K6rA38IzwMDJas3KJTuB9v/1aTG60oR0SwRc9WGyC/Pn9Pu+VbNdlJ2Qvzq8i6oUsPRVt1iKlOldgLNeYFhYGhQ6VWCSRaZqe22HHzB14cfxDHqDqla06KvbSkk+lzOtcPE6tQKYIkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HiiaMXrL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so643174a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635237; x=1761240037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZBc0KXHM0aBaogGXDmPlA//1VN+b8Y+Q7pEi8zeECE=;
        b=HiiaMXrLMdFaDtfy27HMvGWj4qrlOrm+wxMMIOQpZb9nGA3V8EO2KaGS8kPQsjM05C
         rxQUDMErjYl5eHvezOslV4qztQnOXcY1AgmZXKweGnXKDGRI/5VZuy8C4B9JGGsog/bE
         e9LS8IP+DVGywTaUqVcIosE7zsAac3IuCte2xJ+jpOwe7EWkqjATzRIZ+BkNIK1MWWfC
         KvvoYDSnrRFey5JphMIb72TFCl6b6wS3+BrM2I8rMdzVLUhYjdryGwpfOF2EvJZp2Op+
         zk6YDhsj/dGq/qfxRT3TQ5zZxh7qcnh83/XCIkMdT4TMwdvgknZjLNPMuaHqvdSNAM6W
         Xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635237; x=1761240037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZBc0KXHM0aBaogGXDmPlA//1VN+b8Y+Q7pEi8zeECE=;
        b=xDWS+ZpqHmC68PqyccAwQORwlagEw+oKwUo6eApK62BqyrvYBM+/2NWK+boEXgSQip
         ef92aTIHWM8W3RyUkWIb4dqHRrBYqu12vLZbkb88wQElLIndVsARmFNlS7LZfT95KXHo
         ZLuBySErr6aOilFfWfXzo5HSKyKuU1IPzTqyFlHOgPjII4uZyQJmj3yzOM7tSqIYg94l
         b+RScaoiS/gxLYJIjlKLED93J/CzRLYWAWYrKO0FnXlbjBh69wV9BjTcqL+bmt+0gThS
         EbEplLDk0Wz4p5Lr/BMCgpfQPruHFlyap3X7fX6GEwnbpRH2aICV652Gd9106VEDF/cH
         X3sg==
X-Forwarded-Encrypted: i=1; AJvYcCUV4UTPOTM640AO0aJ9iG8aChc9Sav2p3nRWDMkLsceU2HMWLdl1rHyydMFmJdimjURgBrnyBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYC8ADFMnwE4TE+FDIDv9KIPz19IaMgrHoVsdxTy86f4YsJdsF
	LCj+pLqnCD03T5MV5VwkuN72v3fMVQLDk4mflg5gfLIKO+KYhwB01Hblc7/4jY7LWgXO2ncFPxF
	AUlhbKW+HIwj2fOcY1+v9m+57CoOoogmVuHnOzHyd
X-Gm-Gg: ASbGnctJo0FM6XxODGVV66pT6srknHG5iPifArmNN7J1piUHsTEvEF0xgl90i64TA5I
	mL0wvvlK0VdivN8LCUYoNYfyTyQzt+UcFfBEzJCVvwZLxFRncqoiS60/qQyyTyVFbRtwGL9WWd9
	LhMaTX8/IkUkOF2q/SDrnITf9YB+eMFsHtbYkNHKvbHSrJNrQrZmQhMxIB/FuzpLMDanTKq+yL+
	9/A33FGMso50TboDWTYvMn90GlrjqUWqtPjcAX0FAZi5w18lunKgxGITIf3GB72d5srXy9KjPjU
	LIyiZDrvWYpOk1hqnQ==
X-Google-Smtp-Source: AGHT+IFV5yledTgaHHFceWBGywptSKJLxtiDG9kT94U03Mnld8fhGiWIdqpx0ZZ3SbiQ/tWSoLisMHKk1uXHv7cUdKQ=
X-Received: by 2002:a17:902:e944:b0:270:b6d5:f001 with SMTP id
 d9443c01a7336-290c9cc3ec9mr7660205ad.23.1760635236802; Thu, 16 Oct 2025
 10:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
In-Reply-To: <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 16 Oct 2025 10:20:25 -0700
X-Gm-Features: AS18NWDT_jBV9tkOyjH3SrHB_r45DzL0AEkYeqvwwSH1bbUq-TD0D7ktC9QJ-dw
Message-ID: <CAAVpQUA+TEDAQ_8ZNuErMMqngVNRSkzArrRQkyaPU3qE2aUFfQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 9:11=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 15, 2025 at 9:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > In tcp_send_syn_data(), the TCP Fast Open client could give up
> > embedding payload into SYN, but the behaviour is inconsistent.
> >
> >   1. Send a bare SYN with TFO request (option w/o cookie)
> >   2. Send a bare SYN with TFO cookie
> >
> > When the client does not have a valid cookie, a bare SYN is
> > sent with the TFO option without a cookie.
> >
> > When sendmsg(MSG_FASTOPEN) is called with zero payload and the
> > client has a valid cookie, a bare SYN is sent with the TFO
> > cookie, which is confusing.
> >
> > This also happens when tcp_wmem_schedule() fails to charge
> > non-zero payload.
> >
> > OTOH, other fallback paths align with 1.  In this case, a TFO
> > request is not strictly needed as tcp_fastopen_cookie_check()
> > has succeeded, but we can use this round to refresh the TFO
> > cookie.
> >
> > Let's avoid sending TFO cookie w/o payload to make fallback
> > behaviour consistent.
> >
>
> I am unsure. Some applications could break ?
>
> They might prime the cookie cache initiating a TCP flow with no payload,
> so that later at critical times then can save one RTT at their
> connection establishment.

For that RTT purpose, we send the TFO request in all fallback
cases unless the client sets the no cookie option.

I think this is better than sending TFO cookie w/o payload because
when a cookie in SYN is valid, we do not generate SYN+ACK
w/ a cookie unless the received cookie is the secondary one.

Also, errno is not changed in all paths.


>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/tcp_output.c | 39 +++++++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index bb3576ac0ad7d..2847c1ffa1615 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -4151,6 +4151,9 @@ static int tcp_send_syn_data(struct sock *sk, str=
uct sk_buff *syn)
> >         if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->=
cookie))
> >                 goto fallback;
> >
> > +       if (!fo->size)
> > +               goto fallback;
> > +
> >         /* MSS for SYN-data is based on cached MSS and bounded by PMTU =
and
> >          * user-MSS. Reserve maximum option space for middleboxes that =
add
> >          * private TCP options. The cost is reduced data space in SYN :=
(
> > @@ -4164,33 +4167,33 @@ static int tcp_send_syn_data(struct sock *sk, s=
truct sk_buff *syn)
> >
> >         space =3D min_t(size_t, space, fo->size);
> >
> > -       if (space &&
> > -           !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
> > +       if (!skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
> >                                   pfrag, sk->sk_allocation))
> >                 goto fallback;
> > +
> >         syn_data =3D tcp_stream_alloc_skb(sk, sk->sk_allocation, false)=
;
> >         if (!syn_data)
> >                 goto fallback;
> > +
> >         memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
> > -       if (space) {
> > -               space =3D min_t(size_t, space, pfrag->size - pfrag->off=
set);
> > -               space =3D tcp_wmem_schedule(sk, space);
> > -       }
> > -       if (space) {
> > +
> > +       space =3D min_t(size_t, space, pfrag->size - pfrag->offset);
> > +       space =3D tcp_wmem_schedule(sk, space);
> > +       if (space)
> >                 space =3D copy_page_from_iter(pfrag->page, pfrag->offse=
t,
> >                                             space, &fo->data->msg_iter)=
;
> > -               if (unlikely(!space)) {
> > -                       tcp_skb_tsorted_anchor_cleanup(syn_data);
> > -                       kfree_skb(syn_data);
> > -                       goto fallback;
> > -               }
> > -               skb_fill_page_desc(syn_data, 0, pfrag->page,
> > -                                  pfrag->offset, space);
> > -               page_ref_inc(pfrag->page);
> > -               pfrag->offset +=3D space;
> > -               skb_len_add(syn_data, space);
> > -               skb_zcopy_set(syn_data, fo->uarg, NULL);
> > +       if (unlikely(!space)) {
> > +               tcp_skb_tsorted_anchor_cleanup(syn_data);
> > +               kfree_skb(syn_data);
> > +               goto fallback;
> >         }
> > +
> > +       skb_fill_page_desc(syn_data, 0, pfrag->page, pfrag->offset, spa=
ce);
> > +       page_ref_inc(pfrag->page);
> > +       pfrag->offset +=3D space;
> > +       skb_len_add(syn_data, space);
> > +       skb_zcopy_set(syn_data, fo->uarg, NULL);
> > +
> >         /* No more data pending in inet_wait_for_connect() */
> >         if (space =3D=3D fo->size)
> >                 fo->data =3D NULL;
> > --
> > 2.51.0.788.g6d19910ace-goog
> >

