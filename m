Return-Path: <netdev+bounces-189363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C550AB1DF4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06209986E83
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A867269CE8;
	Fri,  9 May 2025 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="GFvgPdKG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="yHJ/hEj9"
X-Original-To: netdev@vger.kernel.org
Received: from e240-11.smtp-out.eu-north-1.amazonses.com (e240-11.smtp-out.eu-north-1.amazonses.com [23.251.240.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AB267B15;
	Fri,  9 May 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821880; cv=none; b=LbC5efQcV/TbHL9f9K97eCIkXHJwc3sUrMmUymN5KnlOdlVHnWOVHSJCnrN7qO9vhjXFEkZqwMkHyZ4ZNuHL3q7GAjwYva6Qx7dRH7wsQdmOIib2p4LG05JpKS7D8Om/qPskLkTHsmUHbQTXJw+xyVQYbNooLB8EuVVqExdBhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821880; c=relaxed/simple;
	bh=bPhvn4iaWI8Ged+E6nXof9/6JcXF5NPtQoes+O4WqUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzKxJbi9nFtucL6PmzrH0sRoZgc9lGxUx1zWlMAiVishVBL5fAANzvf0RI7vHgL9R23a8bfvMhRhftSVisuPrnLfP259wT+KnFLz/ez8PnLUGnRuHWwc1X9m0rQFdUtW6alRUeWmqaMNTyI6PIvIvXmIdnrrMfmP+Dc6ae9uCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=GFvgPdKG; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=yHJ/hEj9; arc=none smtp.client-ip=23.251.240.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746821875;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bPhvn4iaWI8Ged+E6nXof9/6JcXF5NPtQoes+O4WqUY=;
	b=GFvgPdKG+NQl/aKLXczMdTWAKcPIhMK60PA596rVOBap+mAF39udKlaGb7rVlqdW
	U36JuruTqpYk9XPWrOPBJSug6E7HKACR0qNj5Sef0ahGFe9iwjNWv6ulvmO7qH9gwye
	7eQicCL3O+ig0MYW+LKolUr2BgRPYBaHFX+l3Oj4b+k5C3k/6St24LKONxteDFDcVCL
	Bs8B4N3IGQEXykiuz195BY/1zjwWcoPQ8evfpHkju8NAZ6D0kn+btzm0mYB8GnkqZnz
	+EjhBwBGpLTWxXdL12df/gfn5pSUvtvEPJYfZ+5zplIiCN1OlALRam/Wq3hAvyBayky
	VEj56p4pXA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746821875;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=bPhvn4iaWI8Ged+E6nXof9/6JcXF5NPtQoes+O4WqUY=;
	b=yHJ/hEj9scogmo0UV7ab/Ta6dCUSiCrT5XPkt4aCF0cwsnihhmE7xZtGHyIeNWLD
	yLjLLhH4DWeEvBX62rcv54EbanzQAni/20juSVK2KJ+aSUz0oQyhfm8/KvMnPjjtDKj
	rp59WGTsZw/c2NMF5vH/e28AbLJ2qtMU3FF/VW9c=
X-Forwarded-Encrypted: i=1; AJvYcCUOQE1GN7PfUDYmhQ5Pbys6W2ttdFhZSWInDaj4GudCQp6ICs95tC1qDc+gxzZm2g7KgiQNK+ak/hk/eGU=@vger.kernel.org, AJvYcCWkVGh3z83pBat2mVjAZg41gKIiTNq2b8q7W1ggZljwPy+n6md4o9s4ABS9aHnbzBsp12Ku0Gon@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl7qG//2KVTDp3rqltXrfGKHEufscnt4LOWpTR/jssdLDRZuqX
	dt0IATNxB+5/klGRndEeJ4NkvubH1w/zEtkyeFoLGK1CobJmZ9xkFM3oHcE4blsPoAuQTaSHNBt
	txKFB5xZVsDWlypnnzNakw5liELM=
X-Google-Smtp-Source: AGHT+IH57Tmngi6mdzemve+Vx5JsO/iqNRQHzyH7IZdpUXulJq3gVkzq6K0wSkdaMqvT4454xotTMPIUkw6AaAutEUw=
X-Received: by 2002:a17:902:ec90:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-22fc91ab45fmr76129505ad.53.1746821873108; Fri, 09 May 2025
 13:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
 <01100196af6a2181-4f17e5a7-799c-46cd-99f3-9393545834b1-000000@eu-north-1.amazonses.com>
 <CADVnQykrenhejQCcsNE6JBsk3bE5_rNTeQe3izrZd9qp8zmkYg@mail.gmail.com>
 <01100196b0157e73-161274ae-dd13-401c-b7ac-d7dd7d50f017-000000@eu-north-1.amazonses.com>
 <CANn89iKeafqV+pTptNZtEsjNchRSxe2mC7FOaWtwXNMaXjzcPQ@mail.gmail.com>
In-Reply-To: <CANn89iKeafqV+pTptNZtEsjNchRSxe2mC7FOaWtwXNMaXjzcPQ@mail.gmail.com>
From: Ozgur Kara <ozgur@goosey.org>
Date: Fri, 9 May 2025 20:17:55 +0000
X-Gmail-Original-Message-ID: <CADvZ6EpicwKCSiZQO0qtZ9hiH0HJLM_c+KWJNFDSre7OMUJumQ@mail.gmail.com>
X-Gm-Features: ATxdqUEbpU318qrNBdXWA6KhVi5zhCQi-DnCqctaS16C35YgOnrD79OAe7lfMjQ
Message-ID: <01100196b6b28830-bda13534-f814-44ee-93f7-1517626293ba-000000@eu-north-1.amazonses.com>
Subject: Re: [PATCH] net: ipv4: Fix destination address determination in flowi4_init_output
To: Eric Dumazet <edumazet@google.com>
Cc: Ozgur Kara <ozgur@goosey.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.09-23.251.240.11

Eric Dumazet <edumazet@google.com>, 8 May 2025 Per, 18:02 tarihinde =C5=9Fu=
nu yazd=C4=B1:
>
> On Thu, May 8, 2025 at 6:28=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> wrot=
e:
> >
> > Neal Cardwell <ncardwell@google.com>, 8 May 2025 Per, 15:54 tarihinde
> > =C5=9Funu yazd=C4=B1:
> > >
> > > On Thu, May 8, 2025 at 6:21=E2=80=AFAM Ozgur Kara <ozgur@goosey.org> =
wrote:
> > > >
> > > > From: Ozgur Karatas <ozgur@goosey.org>
> > > >
> > > > flowi4_init_output() function returns an argument and if opt->srr i=
s
> > > > true and opt->faddr is assigned to be checked before opt->faddr is
> > > > used but if opt->srr seems to be true and opt->faddr is not set
> > > > properly yet.
> > > >
> > > > opt itself will be an incompletely initialized struct and this acce=
ss
> > > > may cause a crash.
> > > > * added daddr
> > > > * like readability by passing a single daddr argument to
> > > > flowi4_init_output() call.
> > > >
> > > > Signed-off-by: Ozgur Karatas <ozgur@goosey.org>
> > >
> > > For bug fixes, please include a Fixes: footer; there are more details=
 here:
> > >    https://www.kernel.org/doc/html/v6.12/process/submitting-patches.h=
tml
> > >
> >
> > Hello Neal, I will pay attention to this sorry.
> >
> > > > ---
> > > >  net/ipv4/syncookies.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > > index 5459a78b9809..2ff92d512825 100644
> > > > --- a/net/ipv4/syncookies.c
> > > > +++ b/net/ipv4/syncookies.c
> > > > @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk,
> > > > struct sk_buff *skb)
> > > >         struct flowi4 fl4;
> > > >         struct rtable *rt;
> > > >         __u8 rcv_wscale;
> > > > +       __be32 daddr;
> > > >         int full_space;
> > > >         SKB_DR(reason);
> > > >
> > > > @@ -442,6 +443,17 @@ struct sock *cookie_v4_check(struct sock *sk,
> > > > struct sk_buff *skb)
> > > >                 goto out_free;
> > > >         }
> > > >
> > > > +        /* Safely determine destination address considered SRR opt=
ion.
> > > > +         * The flowi4 destination address is derived from opt->fad=
dr
> > > > if opt->srr is set.
> > > > +         * However IP options are not always present in the skb an=
d
> > > > accessing opt->faddr
> > > > +         * without validating opt->optlen and opt->srr can lead to
> > > > undefined behavior.
> > > > +         */
> > > > +        if (opt && opt->optlen && opt->srr) {
> > > > +                daddr =3D opt->faddr;
> > > > +        } else {
> > > > +                daddr =3D ireq->ir_rmt_addr;
> > > > +        }
> > >
> > > Can you please explain how opt could be NULL, given how it is
> > > initialized, like this:
> > >         struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
> > > ?
> > >
> > > And can you please explain how opt->srr could be set if opt->optlen i=
s
> > > 0? I'm not seeing how it's possible, given how the
> > > __ip_options_compile() code is structured. But perhaps I am missing
> > > something.
> > >
> >
> > The issue is more nuanced than opt being only NULL, while opt =3D
> > &TCP_SKB_CB(skb)->header.h4.opt gives a valid pointer to a structure
> > and the contents of that structure might be uninitialized or invalid
> > in certain code paths.
>
> It must not.
>
> TCP stack is called after IPv4 traversal.
>
> We are not going to add in TCP defensive code.
>
> Instead, if you think there is a bug in the way IPv4 options are
> decoded (before reaching TCP),
> please fix it in the correct layer.
>
> Thanks.
>

Hello Eric,

okay got it so i will look at IP layer and try to understand it.

> > My patch adds defensive programming by checking three conditions
> > before accessing opt->faddr: whether opt itself is valid, opt->optlen
> > is non-zero and opt->srr is set.
> > This prevents undefined behavior when accessing opt->faddr in cases
> > where the structure's fields haven't been properly initialized.
> >
> > The previous code (opt->srr ? opt->faddr : ireq->ir_rmt_addr) assumed
> > opt->srr was always valid, while the new code safely establishes daddr
> > =3D ireq->ir_rmt_addr as the default, only using opt->faddr when all
> > safety conditions are met.
> >  However, the issue lies in the validity of the struct ip_options
> > content, particularly opt->srr and opt->faddr. If the
> > TCP_SKB_CB(skb)->header.h4.opt structure is uninitialized or reset
> > (e.g., via memset or incomplete parsing), fields like opt->optlen and
> > opt->srr may contain garbage values, leading to undefined behavior
> > when accessed.
> >
> > A specific example of this vulnerability occurs during early SYN
> > transactions, particularly if tcp_v4_cookie_check() is called
> > directly.
>
> How 'directly' is this done ? Are you talking about an out-of-tree code ?
>

actually yes, its in out-of-tree code because i thought it could be
for example LSM, bpf or any hook or handler (if a module is added to
kernel).
Maybe special socket operations, mechanisms such as tcp fast open can
be triggered before state is fully established.
In short, if someone calls function at wrong time syn cookie
verification will be done in the early state and in this case I guess
so state will be created or spoof syn will be turned on.

Maybe i should test this and look with csope, strace and reconsider.

Regards

Ozgur

>  In this scenario, opt->optlen might be zero while other
> > fields contain garbage values, which could lead to memory corruption
> > or security issues.
> > So this patch ensures robustness against invalid options, especially
> > in edge cases like malformed SYN packets, with minimal overhead.
> >
> > am i mistaken? if there is missing information please forward it.
> >
> > Regards
> >
> > Ozgur
> >
> > > thanks,
> > > neal
> > >
> > >
>
>

