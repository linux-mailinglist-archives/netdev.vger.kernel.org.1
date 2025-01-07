Return-Path: <netdev+bounces-155657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD1CA0348D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15DE16135D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC29125B9;
	Tue,  7 Jan 2025 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXZT6+SX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4801CAAC
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213518; cv=none; b=ZeSwj+9PdKJW+elBNdBi6S5a+jHWwgIPoYEwd7xOCkhfHVXGqxOX8nulr0eBHmN6kTjuf1+RG43uSEmA65X/Y6cPFhSOxbI0yFJQ0fyY2rD1yVJNT85mhjpO2pEZCCBdIyRA9qzng0oPkXKTu2i8Bbeh5M6XgXOmYFYDxiAr7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213518; c=relaxed/simple;
	bh=WzlbfHCxWFqsEdcnKONGEknwt1JGxMV4PdG9GxMZGK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chx4rE7nrYvvwSeELV8kwk4ZyfU7TNK0bdBMv/F0yi1NkagvgAmpiwBxnd68yC5cpQJ14+IoDzsGV82kZ0zDnITpVwWx3EBYuY0jF8rr3A1BHSBaPvO6jKJ3Q8xclI9m8c64Y++2R3N2tO3By0e48gw9C0MPR9/Eb4j+Q1NXbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXZT6+SX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9d5a7ecc3so55ab.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736213516; x=1736818316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwRPTSkp34G59ZgdzGq1eY3SLuwV40n9AbkzdlULjnM=;
        b=SXZT6+SXWaS/gS3GxzYzdz3U37Hmfc5/WZ89ywfBFrDMtU2bSrp0Ghj62ZVX+bSapk
         9PjFwY7iZvG6uHU/c+wXhtt+5Gc7+cWcyx5MASflDYCyDHe4RIzEQ+fKnQK7bEvz9HHv
         CArIRDazen3DFPx330MJuIKEL4jmVaUcXgcJSW/siRNSGMWX4MdeCAT1NqYVlAYCxdus
         r0USUd2X3GFSRK5imdgZb/Rw7tZmD4vhma/jKb8xdvW51WwTo19Wi8El6zYYgB6CZiFG
         uc0MhYwS7d4truflkGOOYjPpegsUcY4UjDFafqJIAhNmbsauGivFrXucspnYEaBWxHGL
         85uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736213516; x=1736818316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwRPTSkp34G59ZgdzGq1eY3SLuwV40n9AbkzdlULjnM=;
        b=h5eUaqAG7JEw88RBBIIY5AnStAp6tXYCvCHp3tdo3UtLp4oUmcubAH7qeb2jwexeH2
         fdf5wIFZyaRGN8m6Q9SAB0qVepbH8DV2YzMxHnRe8irSU3j1lAYnFsj0kT9HFiDi7V/w
         7DUHxA7vLmzJdj2lqs7Onzgau5zjmKi3uMEtNEKMbiFCvaJQetqOaTi5CNpYVZIPKOYU
         Y6Yni7Sn5IdLcUHQtMegvMP46J0G/mrNBS3Bd1M2jPkr3trPXzF2YmwlufhY/uU4ULJA
         QhCaxRgCRqrEmt/UDLQUSa/jlmjl6TKH9OGwnAWvpxd7FFpBzIbxgR4TTviFLsuDrcpM
         9Wrg==
X-Forwarded-Encrypted: i=1; AJvYcCVwReJeQvoLSpHOs41YaWIUYMQl/JxI2s4fUfpRp89yf/Op0uXyIDrFFZob9qboaQ0+fN584Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9R/vf8zE0FGaWt5AtOo013i9W2+GtSNMZA5BcIemdg4CsAaQ
	ay6QMWCFiD73Erw5M/bJIAm7BFcpxLYvMRfg42oX4qBaqBq4jK3kJZyOi+K6K/0iOZCjrHl9D2L
	Dt+51YMI+iTmFRPPljAGk/xM0TmCbUO/XORTg
X-Gm-Gg: ASbGncvVNXGdnbom93wTxunFo55EtynuClfTZ5hMUPfjnh+utYoNfRij3tmcsJ0gUrb
	9uBvXKE02IjzjMlfnaIwemQlKs8yts6enPfRCKyJUTnZW6IgOvu3W/H6uaamxsWmdY3Ca
X-Google-Smtp-Source: AGHT+IHR+fwIb5fGV/wN/fVbA52GNCUhxVN8GVTFCn8QQ/3er9IsYSO1fznIJ5lXytnhGH1X9lSO7nDDSueBcYXb00k=
X-Received: by 2002:a05:6e02:5af:b0:3ce:32ef:d1ea with SMTP id
 e9e14a558f8ab-3ce34b3c1e3mr20795ab.1.1736213514993; Mon, 06 Jan 2025 17:31:54
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105020016.699698-1-yuyanghuang@google.com> <cf625a44-0db1-421d-acf9-e7ec60677697@kernel.org>
In-Reply-To: <cf625a44-0db1-421d-acf9-e7ec60677697@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 7 Jan 2025 10:31:18 +0900
X-Gm-Features: AbW1kvZhCVvamjeqJ3NIE2H18vr0JfMc3_-erHEqCPmOOG1PsJiCeTX4J0E2CTw
Message-ID: <CADXeF1GgDTusBUrDv-7v6n9P-Wurhn19Z68KiEhxM5PMy_kpLQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next] netlink: add IPv6 anycast join/leave notifications
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>0 initializations are not needed.

>simple error message should suffice; stack trace does not provide
>additional value.

Thanks for helping with the review. This patch is superseded by the v2
patch. I will adjust the comment in the v3 patch.

Thanks,
Yuyang

Thanks,
Yuyang


On Tue, Jan 7, 2025 at 2:53=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 1/4/25 7:00 PM, Yuyang Huang wrote:
> > diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> > index 562cace50ca9..6793ff436986 100644
> > --- a/net/ipv6/anycast.c
> > +++ b/net/ipv6/anycast.c
> > @@ -278,6 +278,40 @@ static struct ifacaddr6 *aca_alloc(struct fib6_inf=
o *f6i,
> >       return aca;
> >  }
> >
> > +static void inet6_ifacaddr_notify(struct net_device *dev,
> > +                               const struct ifacaddr6 *ifaca, int even=
t)
> > +{
> > +     struct inet6_fill_args fillargs =3D {
> > +             .portid =3D 0,
> > +             .seq =3D 0,
> > +             .event =3D event,
> > +             .flags =3D 0,
>
> 0 initializations are not needed.
>
> > +             .netnsid =3D -1,
> > +     };
> > +     struct net *net =3D dev_net(dev);
> > +     struct sk_buff *skb;
> > +     int err =3D -ENOMEM;
> > +
> > +     skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > +                     nla_total_size(sizeof(struct in6_addr)) +
> > +                     nla_total_size(sizeof(struct ifa_cacheinfo)),
> > +                     GFP_KERNEL);
> > +     if (!skb)
> > +             goto error;
> > +
> > +     err =3D inet6_fill_ifacaddr(skb, ifaca, &fillargs);
> > +     if (err < 0) {
> > +             WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
>
> simple error message should suffice; stack trace does not provide
> additional value.
>
> > +             nlmsg_free(skb);
> > +             goto error;
> > +     }
> > +
> > +     rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ACADDR, NULL, GFP_KERNEL);
> > +     return;
> > +error:
> > +     rtnl_set_sk_err(net, RTNLGRP_IPV6_ACADDR, err);
> > +}
> > +
> >  /*
> >   *   device anycast group inc (add if not found)
> >   */
>

