Return-Path: <netdev+bounces-188974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB18AAFB51
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242E54A46AD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907022B8D1;
	Thu,  8 May 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="aPoqFINc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="tn8u8XxC"
X-Original-To: netdev@vger.kernel.org
Received: from e240-7.smtp-out.eu-north-1.amazonses.com (e240-7.smtp-out.eu-north-1.amazonses.com [23.251.240.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984F22B8B0;
	Thu,  8 May 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710926; cv=none; b=HdKTm+2RaF755bltO+9f8Vv2SoXWZZ0BfuHNsd5R5nrJNEcu9P7qgbk/uPc11uriLQwitk1putWgXYC3fa9NoM4qmP02yGHUgL+Q6Ljn27gvIhSWriZmmBbMX6B7mxIsS3TwcAvRBdOtExS788sPwhLMOqra00wWW4jLCPucDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710926; c=relaxed/simple;
	bh=LQLMHViaAuulEUk9EIvBIfDrzzlTpwuQK+oYnrSNoOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS1sUxwpCu/wJkE0Nf3AIRMconbPdYvD2DAamjQ5bg3Ye8NH19Ror6mZOfyuhHKNCOlO3YvBJSzemLLj5HCEEBErq9q/4i2X6Ha/1QEIqL8bXMdGfVKwbbHX5EzRFDGiDpUrcseqX44/XIbI738GAX1RsM5r6uhav3AF3SooUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=aPoqFINc; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=tn8u8XxC; arc=none smtp.client-ip=23.251.240.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746710920;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LQLMHViaAuulEUk9EIvBIfDrzzlTpwuQK+oYnrSNoOI=;
	b=aPoqFINcP4KrsAYETd+SSurUH9hn/smdiwUZBFG0o3ieGYYi1OrOYIti8+P/a4IO
	je+bdd5rsWgDWKZJPNcjesc56iLJ8SnOqUckPi/mDpkoUbSK6BWUODibQl6OYK6oIU0
	nyFwXwx55GOdHu5NjkghuZYUIUUch/ealEQe/+vwyqMnjVzVJ0sa5qa4SIW9NZsWON5
	jv1GR4eCweMFugetKw9g67jMS0eqBWGZPPR+PUzJTPG+dqfQHgDxA/TiHEVtgsDfwta
	YslNKWBF6n8l8LrTWSzZZf1G48qK5DlRXUmqOwS1oHqsG58Xgo3g6G+M8DzsjyBrkGX
	udahFIMUcw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746710920;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=LQLMHViaAuulEUk9EIvBIfDrzzlTpwuQK+oYnrSNoOI=;
	b=tn8u8XxC+8dRICqcr7UJLSzk1I3ii0sEMIrQf2h+im3m0IKrUwXuPbWQJGlO05P6
	DHr2p9g1T+uqeKZfmT6q3N0ATgWI5Y+hANf8dWnPBqgIXnG9VcvGxd7wlX81tLRaWMr
	zllEE6Y6r8ZVVsL3dEajTZ6KlHfBselbMYf6xAsw=
X-Forwarded-Encrypted: i=1; AJvYcCWLK5+RWEiYjgByhPXHQq2aJx2TEuOsMFwCMr1TsqcOUx0GQOmWsYM8GUDLS7OzaOB5Y3SAal8hIePJI3k=@vger.kernel.org, AJvYcCXz2fKeXTGCJVWBSLFU3w/VCI0HBgWDnyyDCfCxo9C5W6KCJn9O++RpF/u9IFzXRZ9vjXy2kw0R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxglb2YG3daTo4IQGGUEEjD+VTxd3wIHK3cPkZ8GsEujIKfNTTG
	ooxKHNzeNoxCSkC98EaKjGk+lTMXO8E47Ef5OgjTig8ipoYeXBrjE/jImeZ0FefWiyXJgqaZkBa
	ctGOdtHQfV91NHmP4j98akCaaElw=
X-Google-Smtp-Source: AGHT+IHJ1FIgIVjncNwpLeyC4o6xebiauozP9PnaHoQzAHFcmeeLukcE/U3qANsD4ArPdcs6EXK8pu6ipKVLNMP5tK4=
X-Received: by 2002:a17:90b:4c08:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30b32c3fa6amr5828892a91.12.1746710918354; Thu, 08 May 2025
 06:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
 <01100196af6a2181-4f17e5a7-799c-46cd-99f3-9393545834b1-000000@eu-north-1.amazonses.com>
 <CADVnQykrenhejQCcsNE6JBsk3bE5_rNTeQe3izrZd9qp8zmkYg@mail.gmail.com>
In-Reply-To: <CADVnQykrenhejQCcsNE6JBsk3bE5_rNTeQe3izrZd9qp8zmkYg@mail.gmail.com>
From: Ozgur Kara <ozgur@goosey.org>
Date: Thu, 8 May 2025 13:28:40 +0000
X-Gmail-Original-Message-ID: <CADvZ6Ep7KeQb1BnBRGmqJ7D191LEDMg6CX2YLyX5QSDOQtDnpA@mail.gmail.com>
X-Gm-Features: ATxdqUGmTyHUiyIUJ-kcDWXsIyC47YpMBwP19-9DSRD_Q40DUpjEE6LfqojGdLY
Message-ID: <01100196b0157e76-acca71aa-f8d0-45b0-bb09-de38e1bfa341-000000@eu-north-1.amazonses.com>
Subject: Re: [PATCH] net: ipv4: Fix destination address determination in flowi4_init_output
To: Neal Cardwell <ncardwell@google.com>
Cc: Ozgur Kara <ozgur@goosey.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.08-23.251.240.7

Neal Cardwell <ncardwell@google.com>, 8 May 2025 Per, 15:54 tarihinde
=C5=9Funu yazd=C4=B1:
>
> On Thu, May 8, 2025 at 6:21=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> wrot=
e:
> >
> > From: Ozgur Karatas <ozgur@goosey.org>
> >
> > flowi4_init_output() function returns an argument and if opt->srr is
> > true and opt->faddr is assigned to be checked before opt->faddr is
> > used but if opt->srr seems to be true and opt->faddr is not set
> > properly yet.
> >
> > opt itself will be an incompletely initialized struct and this access
> > may cause a crash.
> > * added daddr
> > * like readability by passing a single daddr argument to
> > flowi4_init_output() call.
> >
> > Signed-off-by: Ozgur Karatas <ozgur@goosey.org>
>
> For bug fixes, please include a Fixes: footer; there are more details her=
e:
>    https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html
>

Hello Neal, I will pay attention to this sorry.

> > ---
> >  net/ipv4/syncookies.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 5459a78b9809..2ff92d512825 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk,
> > struct sk_buff *skb)
> >         struct flowi4 fl4;
> >         struct rtable *rt;
> >         __u8 rcv_wscale;
> > +       __be32 daddr;
> >         int full_space;
> >         SKB_DR(reason);
> >
> > @@ -442,6 +443,17 @@ struct sock *cookie_v4_check(struct sock *sk,
> > struct sk_buff *skb)
> >                 goto out_free;
> >         }
> >
> > +        /* Safely determine destination address considered SRR option.
> > +         * The flowi4 destination address is derived from opt->faddr
> > if opt->srr is set.
> > +         * However IP options are not always present in the skb and
> > accessing opt->faddr
> > +         * without validating opt->optlen and opt->srr can lead to
> > undefined behavior.
> > +         */
> > +        if (opt && opt->optlen && opt->srr) {
> > +                daddr =3D opt->faddr;
> > +        } else {
> > +                daddr =3D ireq->ir_rmt_addr;
> > +        }
>
> Can you please explain how opt could be NULL, given how it is
> initialized, like this:
>         struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
> ?
>
> And can you please explain how opt->srr could be set if opt->optlen is
> 0? I'm not seeing how it's possible, given how the
> __ip_options_compile() code is structured. But perhaps I am missing
> something.
>

The issue is more nuanced than opt being only NULL, while opt =3D
&TCP_SKB_CB(skb)->header.h4.opt gives a valid pointer to a structure
and the contents of that structure might be uninitialized or invalid
in certain code paths.
My patch adds defensive programming by checking three conditions
before accessing opt->faddr: whether opt itself is valid, opt->optlen
is non-zero and opt->srr is set.
This prevents undefined behavior when accessing opt->faddr in cases
where the structure's fields haven't been properly initialized.

The previous code (opt->srr ? opt->faddr : ireq->ir_rmt_addr) assumed
opt->srr was always valid, while the new code safely establishes daddr
=3D ireq->ir_rmt_addr as the default, only using opt->faddr when all
safety conditions are met.
 However, the issue lies in the validity of the struct ip_options
content, particularly opt->srr and opt->faddr. If the
TCP_SKB_CB(skb)->header.h4.opt structure is uninitialized or reset
(e.g., via memset or incomplete parsing), fields like opt->optlen and
opt->srr may contain garbage values, leading to undefined behavior
when accessed.

A specific example of this vulnerability occurs during early SYN
transactions, particularly if tcp_v4_cookie_check() is called
directly. In this scenario, opt->optlen might be zero while other
fields contain garbage values, which could lead to memory corruption
or security issues.
So this patch ensures robustness against invalid options, especially
in edge cases like malformed SYN packets, with minimal overhead.

am i mistaken? if there is missing information please forward it.

Regards

Ozgur

> thanks,
> neal
>
>

