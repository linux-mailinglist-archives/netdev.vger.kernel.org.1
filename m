Return-Path: <netdev+bounces-83263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B888917AC
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59CE1F22D93
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE46A8AB;
	Fri, 29 Mar 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWjGKJtk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8486A33E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711458; cv=none; b=EzaCF0SV+mLZoSSdNlEOR39pAcIpexWoHjCc2C+YENCtuRZbdL71JrY08Fqlag4hvsmZrL4zazqIU8hNpk5w8DujzHLIA7/IMyuMK4ziqGTogy0/F3bEyDsv87p+E4AwvfvPYrmV95ki09X3Wocyv/EitKdSPfy180chSPj4GxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711458; c=relaxed/simple;
	bh=Tt2KY5GVmmEQbIxEpnQw371Sgo3J/qWEHfjOsc2kl9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZmZM4bUlKmgxUdvImo9DlQdSgFaTVfyd74s+KfLM+kzRMY57vh33STQMQlij/8zXZJCK67sM9rORcDW6z+XPDKos+ur8cG2PQvgYR2jiQEyzNBq4Wb7AlOM7/Zz5LJgPBxm7jUNGVqHbrrwZgLaAbKmjApEv+q13nL5/aG2RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWjGKJtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711711455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C8s55tLfnmRrIPQWxF9kdixgw2in2sipa9Snpr6QoMU=;
	b=FWjGKJtkQyePyCZrXP//WfNQBXYREgTjFy8Fe+F7qeAfKvOKtThd/eBtVPVCXXaVScALQp
	Uqnd0pewxctQRUn+SqsmLFxatnI+vcTocBwrYugpGLlPPJPJqXRnlNElzLCBVNPi/6x41s
	Fhv2mL2jsKaNeZXVt2UWp2KQyArxbIQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-arFgGQYhMP6yQP-_5YI_4A-1; Fri, 29 Mar 2024 07:24:13 -0400
X-MC-Unique: arFgGQYhMP6yQP-_5YI_4A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso469249f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 04:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711453; x=1712316253;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8s55tLfnmRrIPQWxF9kdixgw2in2sipa9Snpr6QoMU=;
        b=O1Zi8Jnk6c77FEtB0Gimsb/Qbg78MC/Ou3B+aD9x4m+o909suWo4QQOb7OYgM6ICQn
         ti6EyG2mCGc5+W7+s+csi4vYFMRxu7OFTLRuxevlnM0qO92BoV5g67QfwsACRrw3SC9M
         NwmuCr5i22FWsbb+wRdQ+0KmY3FeiQm12sTn/qNCedqkDDP2s4jeIlRsSW6qnzXooUp6
         P7K9p8WQ4oC6Goni8BAtJx8Ej6YwOLGuN+dbzifnJKPmKn5Xvwj8xBtdtXchFiztQRAJ
         newT1JiALTqFj5iJUK8VeIDn3+gHj/yb5BXWUnC4Od5lT8ij7zaYl327/1/1q2FHStQr
         h+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcLq4BDxYMUb146IiO8As0TDecPNoH4pk4xG/p/0tUAa98xhqjqX5J0PJ0Fb1VjERggdjoNy9dW6i1pRzacpK2NuYizcxp
X-Gm-Message-State: AOJu0YzI6+n14PsZiZ4ZxpP4ZM0LEMM7tVdnwl1mct7vIoxeruMth4GU
	5Q0wfkFSd3K+u+FFns54O9fJIjZsZ2OXbK7o+Q9ey7/3ZRp+pmglTMVzlK5mP5y3pg/gip1IHJC
	mlrm95hr3//wRe9fFQfqhKwEhOyeus2yGBZqTCSj0jBwK7fL/INYPjg==
X-Received: by 2002:adf:eb82:0:b0:33d:32f7:c85 with SMTP id t2-20020adfeb82000000b0033d32f70c85mr1068943wrn.0.1711711452782;
        Fri, 29 Mar 2024 04:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGEQeJkOkNGs01IN92BAJ61pKiAvorsJpwp1Itu2OoXPkX5FABwIzkvQhKmQeYKtQxDWjJbQ==
X-Received: by 2002:adf:eb82:0:b0:33d:32f7:c85 with SMTP id t2-20020adfeb82000000b0033d32f70c85mr1068928wrn.0.1711711452423;
        Fri, 29 Mar 2024 04:24:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-47.dyn.eolo.it. [146.241.249.47])
        by smtp.gmail.com with ESMTPSA id m10-20020a056000008a00b0033ec91c9eadsm3958165wrx.53.2024.03.29.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:24:11 -0700 (PDT)
Message-ID: <9f29a7b0bb641b132ddfee6c773c4c504c7f2edd.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] udp: avoid calling sock_def_readable() if
 possible
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Fri, 29 Mar 2024 12:24:10 +0100
In-Reply-To: <CANn89iKexr_2Ept9kAmfib6p3-UcrnqhUf=TFq1Mrug6P+Kg_Q@mail.gmail.com>
References: <20240328144032.1864988-1-edumazet@google.com>
	 <20240328144032.1864988-4-edumazet@google.com>
	 <db5a01a1256d4cc5cf418cd6cb5b076fc959ae21.camel@redhat.com>
	 <CANn89iKexr_2Ept9kAmfib6p3-UcrnqhUf=TFq1Mrug6P+Kg_Q@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 11:52 +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Thu, 2024-03-28 at 14:40 +0000, Eric Dumazet wrote:
> > > sock_def_readable() is quite expensive (particularly
> > > when ep_poll_callback() is in the picture).
> > >=20
> > > We must call sk->sk_data_ready() when :
> > >=20
> > > - receive queue was empty, or
> > > - SO_PEEK_OFF is enabled on the socket, or
> > > - sk->sk_data_ready is not sock_def_readable.
> > >=20
> > > We still need to call sk_wake_async().
> > >=20
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/udp.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index d2fa9755727ce034c2b4bca82bd9e72130d588e6..5dfbe4499c0f89f94af9e=
e1fb64559dd672c1439 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1492,6 +1492,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> > >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> > >       int rmem, err =3D -ENOMEM;
> > >       spinlock_t *busy =3D NULL;
> > > +     bool becomes_readable;
> > >       int size, rcvbuf;
> > >=20
> > >       /* Immediately drop when the receive queue is full.
> > > @@ -1532,12 +1533,19 @@ int __udp_enqueue_schedule_skb(struct sock *s=
k, struct sk_buff *skb)
> > >        */
> > >       sock_skb_set_dropcount(sk, skb);
> > >=20
> > > +     becomes_readable =3D skb_queue_empty(list);
> > >       __skb_queue_tail(list, skb);
> > >       spin_unlock(&list->lock);
> > >=20
> > > -     if (!sock_flag(sk, SOCK_DEAD))
> > > -             INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, s=
k);
> > > -
> > > +     if (!sock_flag(sk, SOCK_DEAD)) {
> > > +             if (becomes_readable ||
> > > +                 sk->sk_data_ready !=3D sock_def_readable ||
> > > +                 READ_ONCE(sk->sk_peek_off) >=3D 0)
> > > +                     INDIRECT_CALL_1(sk->sk_data_ready,
> > > +                                     sock_def_readable, sk);
> > > +             else
> > > +                     sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> > > +     }
> >=20
> > I understood this change showed no performances benefit???
> >=20
> > I guess the atomic_add_return() MB was hiding some/most of
> > sock_def_readable() cost?
>=20
> It did show benefits in the epoll case, because ep_poll_callback() is
> very expensive.
>=20
> I think you are referring to a prior discussion we had while still
> using netperf tests, which do not use epoll.

Indeed.

> Eliminating sock_def_readable() was avoiding the smp_mb() we have in
> wq_has_sleeper()
> and this was not a convincing win : The apparent cost of this smp_mb()
> was high in moderate traffic,
> but gradually became small if the cpu was fully utilized.
>=20
> The atomic_add_return() cost is orthogonal (I see it mostly on ARM64 plat=
forms)

Thanks for the additional details.

FTR, I guessed that (part of) atomic_add_return() cost comes from the
implied additional barrier (compared to plain adomic_add()) and the
barrier in sock_def_readable() was relatively cheap in the presence of
the previous one and become more visible after moving to adomic_add().=20

In any case LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


