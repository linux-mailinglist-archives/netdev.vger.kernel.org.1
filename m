Return-Path: <netdev+bounces-189018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D426AAFE2E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A534C0A89
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D493279781;
	Thu,  8 May 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH99HF57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EE279325
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716565; cv=none; b=iegTAhhDCkn5j7PMf9mmIOFM41HmNGNklwRyCJ/pvZIWJv2L5w9FbUi76tqUMO2iM7kMsrSKZexB6gRZAagbSAmliV3CQwUMlZJipA0EU+I9D+ecDccA7YLdwRZgN3CTvuPmGY+pFDsJBFqIUHUk+ChaWDIXhQMxOZc195+5mKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716565; c=relaxed/simple;
	bh=EZCvFRjapwT1JiMrANLJ7ekCA73CkioldVqCMyA1sNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8fEWrnSp36Pp5mrKqHx7akV7VDQb6kTlFjYn/f01ccB0tkRgUbcAdMYwdn+ZY9qsSs13XxFJwjbRuvpa5AGDTi+JUHSh+bD8MQwV7ichoYY0Wi+MRugGUuauxyiensU/e19RNcf00rmtN6yjTOARagDteepY85/uSKO0FhQrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BH99HF57; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47ae894e9b7so2632581cf.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746716559; x=1747321359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW1P+DXju6yG1XR81dsWPHfLBDLXKnzB7JGh49YcNog=;
        b=BH99HF577pEYwChZV2646VxoPn+c9Qm6H4kCcoss6Apha+Fs2g0lLapU9C/DvgoPok
         knjFa9hxO98p6Ftjthao6P++D3ONQ24jGYxaKTQ/pGfQTKG+y6OkVT80lY6COM1YxVUc
         z7PanyBrrPN11fsM6s+PkK3+/QdZ1LWhVg7EilhgIajQ7Ye5nyCQXB2LU+VMsChvQaAy
         W4EISy0lSv2rlUkUmfz6CiQTwqjmW0cGZwKJNTukzni+D/++YvrGiF5glprrMzUWdJ7k
         qcuBQGzuOddKHf5Dg4nXtEh7EmnuqeMw6wD36tzpNibYAPIG2NQmPV6lZMPqdd4gTyZn
         fkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716559; x=1747321359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW1P+DXju6yG1XR81dsWPHfLBDLXKnzB7JGh49YcNog=;
        b=KBRGEWpEcOIuEZzcT9j9WJ326DMiuOOl2H89M+DqKbKkOAm5R1bs4kk2dQZayTzmCR
         ytjy7chpXbp0Pj5tQQhz5LczDlhABNaRrUuir7k5gujqwZx49AVCPNIzInS6xRNFE9NG
         Rj2KJlILcoMSbzo1YCzilp8BOEFth3eI3mntbgo3S2ds5Muefcn0+mqzPSfBVjPTOtmh
         oYc4lnpN63mmwYIPqHVuGdlbfiYp63GSltvk1v5BZ8UpPdqYnJhymB+15wO3tOeYlZVz
         ryHhaq+SYBqotavBHj5EDqGf5Zg//jiaPz25JI0I8pJL1ijtrf3y9YdnuILPh81+bFxK
         64vA==
X-Forwarded-Encrypted: i=1; AJvYcCXuUx0fRMLpQjl8MAN0RN2QAUPZrx8rcDBpfOOEw4RitcNvcNgA960Owomi1GjF9+pItv0R138=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8k1kwAMu1tsw57ZZotN7z+t3vletCf9aFm9QusXQc8qECMqj
	xeW+nqjVh/d+wOR264aa2RFhX4rT6JybPuHFROlcIdeVdDalJ+tfca2lp2djeF9IDVYLmKDsscL
	0y92D+Gpt3aZhvE6dwybAeiLCOHMVQEs4zhQB
X-Gm-Gg: ASbGncvAGyD0bbxaocC230idq9CbUUNLZ3HbjEd334bxfrRPp+mZl/SD8iWchz6iGgT
	sjWwgneQXIKH5l/K53OA8PlIj37pkN67Y+tTkLSw3p6IMuqOyGIHdDCL9cHhfsBUV17Z/E1zUac
	wkhgviu562YfrczGUSSmhJ
X-Google-Smtp-Source: AGHT+IFX2bbcbZYx5CWRt8rOHd81GYWCQ65Vrbx5GwA0ylDFOFZZIynXcSAh4JOJrwr3lCWbeujeVOk3ZZrLLvUwLsM=
X-Received: by 2002:ac8:7c53:0:b0:476:b461:249b with SMTP id
 d75a77b69052e-49225b36f9dmr102225771cf.12.1746716558628; Thu, 08 May 2025
 08:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
 <01100196af6a2181-4f17e5a7-799c-46cd-99f3-9393545834b1-000000@eu-north-1.amazonses.com>
 <CADVnQykrenhejQCcsNE6JBsk3bE5_rNTeQe3izrZd9qp8zmkYg@mail.gmail.com> <01100196b0157e73-161274ae-dd13-401c-b7ac-d7dd7d50f017-000000@eu-north-1.amazonses.com>
In-Reply-To: <01100196b0157e73-161274ae-dd13-401c-b7ac-d7dd7d50f017-000000@eu-north-1.amazonses.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 May 2025 08:02:27 -0700
X-Gm-Features: ATxdqUGRZWQV34Q6KIsWrg2SQHgdyWq0NfthQaiLCNVQULIzg_E48YaUwLGgimk
Message-ID: <CANn89iKeafqV+pTptNZtEsjNchRSxe2mC7FOaWtwXNMaXjzcPQ@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: Fix destination address determination in flowi4_init_output
To: Ozgur Kara <ozgur@goosey.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:28=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> wrote:
>
> Neal Cardwell <ncardwell@google.com>, 8 May 2025 Per, 15:54 tarihinde
> =C5=9Funu yazd=C4=B1:
> >
> > On Thu, May 8, 2025 at 6:21=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> wr=
ote:
> > >
> > > From: Ozgur Karatas <ozgur@goosey.org>
> > >
> > > flowi4_init_output() function returns an argument and if opt->srr is
> > > true and opt->faddr is assigned to be checked before opt->faddr is
> > > used but if opt->srr seems to be true and opt->faddr is not set
> > > properly yet.
> > >
> > > opt itself will be an incompletely initialized struct and this access
> > > may cause a crash.
> > > * added daddr
> > > * like readability by passing a single daddr argument to
> > > flowi4_init_output() call.
> > >
> > > Signed-off-by: Ozgur Karatas <ozgur@goosey.org>
> >
> > For bug fixes, please include a Fixes: footer; there are more details h=
ere:
> >    https://www.kernel.org/doc/html/v6.12/process/submitting-patches.htm=
l
> >
>
> Hello Neal, I will pay attention to this sorry.
>
> > > ---
> > >  net/ipv4/syncookies.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > index 5459a78b9809..2ff92d512825 100644
> > > --- a/net/ipv4/syncookies.c
> > > +++ b/net/ipv4/syncookies.c
> > > @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk,
> > > struct sk_buff *skb)
> > >         struct flowi4 fl4;
> > >         struct rtable *rt;
> > >         __u8 rcv_wscale;
> > > +       __be32 daddr;
> > >         int full_space;
> > >         SKB_DR(reason);
> > >
> > > @@ -442,6 +443,17 @@ struct sock *cookie_v4_check(struct sock *sk,
> > > struct sk_buff *skb)
> > >                 goto out_free;
> > >         }
> > >
> > > +        /* Safely determine destination address considered SRR optio=
n.
> > > +         * The flowi4 destination address is derived from opt->faddr
> > > if opt->srr is set.
> > > +         * However IP options are not always present in the skb and
> > > accessing opt->faddr
> > > +         * without validating opt->optlen and opt->srr can lead to
> > > undefined behavior.
> > > +         */
> > > +        if (opt && opt->optlen && opt->srr) {
> > > +                daddr =3D opt->faddr;
> > > +        } else {
> > > +                daddr =3D ireq->ir_rmt_addr;
> > > +        }
> >
> > Can you please explain how opt could be NULL, given how it is
> > initialized, like this:
> >         struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
> > ?
> >
> > And can you please explain how opt->srr could be set if opt->optlen is
> > 0? I'm not seeing how it's possible, given how the
> > __ip_options_compile() code is structured. But perhaps I am missing
> > something.
> >
>
> The issue is more nuanced than opt being only NULL, while opt =3D
> &TCP_SKB_CB(skb)->header.h4.opt gives a valid pointer to a structure
> and the contents of that structure might be uninitialized or invalid
> in certain code paths.

It must not.

TCP stack is called after IPv4 traversal.

We are not going to add in TCP defensive code.

Instead, if you think there is a bug in the way IPv4 options are
decoded (before reaching TCP),
please fix it in the correct layer.

Thanks.

> My patch adds defensive programming by checking three conditions
> before accessing opt->faddr: whether opt itself is valid, opt->optlen
> is non-zero and opt->srr is set.
> This prevents undefined behavior when accessing opt->faddr in cases
> where the structure's fields haven't been properly initialized.
>
> The previous code (opt->srr ? opt->faddr : ireq->ir_rmt_addr) assumed
> opt->srr was always valid, while the new code safely establishes daddr
> =3D ireq->ir_rmt_addr as the default, only using opt->faddr when all
> safety conditions are met.
>  However, the issue lies in the validity of the struct ip_options
> content, particularly opt->srr and opt->faddr. If the
> TCP_SKB_CB(skb)->header.h4.opt structure is uninitialized or reset
> (e.g., via memset or incomplete parsing), fields like opt->optlen and
> opt->srr may contain garbage values, leading to undefined behavior
> when accessed.
>
> A specific example of this vulnerability occurs during early SYN
> transactions, particularly if tcp_v4_cookie_check() is called
> directly.

How 'directly' is this done ? Are you talking about an out-of-tree code ?

 In this scenario, opt->optlen might be zero while other
> fields contain garbage values, which could lead to memory corruption
> or security issues.
> So this patch ensures robustness against invalid options, especially
> in edge cases like malformed SYN packets, with minimal overhead.
>
> am i mistaken? if there is missing information please forward it.
>
> Regards
>
> Ozgur
>
> > thanks,
> > neal
> >
> >

