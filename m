Return-Path: <netdev+bounces-81117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FB885FBF
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4580F1F23426
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824817590;
	Thu, 21 Mar 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJTVmX13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644812B70
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042011; cv=none; b=e7LJqeWSoMMZH34NCNXqTcmNE72F7rehNLQMVcYu1GuzCXb8Ms17LJJ7sV6o9tXlckX/xufEw5YNHTAl9/5ito4SzohsRdi7xPGQF/BfPrd9i6hrc34Z6xWhDOWMgv8o3D0kKEqwI+SaUQrQuX7BUeTCYQ1Epc3zN+eD93A92l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042011; c=relaxed/simple;
	bh=eHfGNekPeqgTdNfnbuggn1bvsFBIfTAKt34IgCV6COQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYzN4BQhtbsMyOZILT3gEItCjlzXqsh0ooAq1/TpTCEjcgNRybhPUjFt3wuS8ZDgv+fa5jpFKXQd5MhhtY98RM9EnuYceeV83AU3uWPy5YB0KYz6m+5JM5UWE4hKQmlzJ3abkgB1TyZ+0lDeM6hhMWGMElYCw0XI8EuNDPhWepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJTVmX13; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so1309a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711042008; x=1711646808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3KhRi9HypoEDo9NmtxhKlIbo2gn4h+SB35O9Z96fQw=;
        b=BJTVmX13mj2LFvkvEn8TdjKz/PvvmhNgqvDyzTze+EA7VR5WRjWVHgEVVFnaSor0b4
         wU2AH4URfw6f8X/S89Id7mzPwSnUa03nRzT0eFTIXtP8yyBgSkWkh5OL7XmepefXjpAq
         JxFgDxNsrX86ZwYZP20IOtGASwxQ/R3c9jEbC2WfXZGj4RH8xKVF+6EHcSOcdTRcpxeD
         XNJfXyLi2b/eykYpeXvxlC94hVMq3JNVFko6IlIfe6nqEUcqtp65c7gthBv18Gq1o3Bj
         /QSkAcDYRBhXiTyOZpYDDuBlSogsCh69Ji4ZTTQxQ+jZi1ByEURPGT6bLLoINiUOdGIc
         xynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711042008; x=1711646808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3KhRi9HypoEDo9NmtxhKlIbo2gn4h+SB35O9Z96fQw=;
        b=P1VxQFw0n30omgYCxxTmNr4a9G9+rYsNvRlGDeF1KNyII+sIfMVj7yDS0iXd3RcBPr
         /a31zSgmoTiv8lQcm0csNhNNojfMWgZetSIps7ccGKMUjsd4sHaxiZBymtCoC+BvvSQa
         5+hMx/kKrbyJzP7fnaxYvVU4UOQTs/+Ehcfcs3vtxHNikkz0D2b0NWs/6UN/02pq2/Fe
         aMw/RPUuDzocRsvYkgz4quKUUR1MJkINunyK7Ll4kH7CEaR68uLhyjDYjP/7GfCt2Jjn
         OQ+AIcOV2DOl0gPjvQV+1d//tWLqJChbEfLjv0XbajAqC8W9oR3RT6CGcbJFhP1GCQeV
         CZdg==
X-Forwarded-Encrypted: i=1; AJvYcCXNxhUVJqe8UGLDDFgOUl95eWApxFKUrUA2GoS2pFwk+eAqYeCMrfqcRxw2Jg0cpJOBNW2B+l9FkdiBgAWGxM9cnisc/jW6
X-Gm-Message-State: AOJu0YzfZ/uCTZWlCeC30UE+3wkHn/yobw99w0DZu/V703flPZg+p1cF
	RVsd32fzACZtC96zgg4L7mYq4hUnFJHoCRZGd8QeZxuiBK4Cq5P6nF7Bf8BvKj0xuFNCBSKGlLO
	C6Qc9Wb58HEWAbDi4Tae273jFKQHh2kN9CxIq
X-Google-Smtp-Source: AGHT+IH1uktBVWMhVCQoGFxuySxVqIQVSpQZyZG43McxLxBjkHN27hP1S5Y4+K2AyVfIrbZfdDsQNAtJFq8oQr+5ld8=
X-Received: by 2002:aa7:d355:0:b0:56b:c269:6169 with SMTP id
 m21-20020aa7d355000000b0056bc2696169mr178112edr.5.1711042006051; Thu, 21 Mar
 2024 10:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303052408.310064-1-kuba@kernel.org> <20240303052408.310064-4-kuba@kernel.org>
 <20240315124808.033ff58d@elisabeth> <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org> <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev>
 <Zfw7YB4nZrquW4Bo@shredder>
In-Reply-To: <Zfw7YB4nZrquW4Bo@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Mar 2024 18:26:31 +0100
Message-ID: <CANn89i+kqdRZrM6Z4TaUcW8q3UL1yzrsOm76mkP2znDAVX2YFA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
To: Ido Schimmel <idosch@idosch.org>
Cc: Gal Pressman <gal.pressman@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net, fw@strlen.de, 
	pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, 
	Paul Holzinger <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:51=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Thu, Mar 21, 2024 at 02:56:41PM +0200, Gal Pressman wrote:
> > We've encountered a new issue recently which I believe is related to
> > this discussion.
> >
> > Following Eric's patch:
> > 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr=
()")
> >
> > Setting the interface mtu to < 1280 results in 'ip addr show eth2'
> > returning an error, because the ipv6 dump fails. This is a degradation
> > from the user's perspective.
> >
> > # ip addr show eth2
> > 4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> > default qlen 1000
> >     link/ether 24:42:53:21:52:44 brd ff:ff:ff:ff:ff:ff
> >     altname enp6s0f0np0
> > # ip link set dev eth2 mtu 1000
> > # ip addr show eth2
> > RTNETLINK answers: No such device
> > Dump terminated
>
> I don't think it's the same issue. Original issue was about user space
> not knowing how to handle NLMSG_DONE being sent together with dump
> responses. The issue you reported seems to be related to an
> unintentional change in the return code when IPv6 is disabled on an
> interface. Can you please test the following patch?
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 247bd4d8ee45..92db9b474f2b 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -5416,10 +5416,11 @@ static int inet6_dump_addr(struct sk_buff *skb, s=
truct netlink_callback *cb,
>
>                 err =3D 0;
>                 if (fillargs.ifindex) {
> -                       err =3D -ENODEV;
>                         dev =3D dev_get_by_index_rcu(tgt_net, fillargs.if=
index);
> -                       if (!dev)
> +                       if (!dev) {
> +                               err =3D -ENODEV;
>                                 goto done;
> +                       }
>                         idev =3D __in6_dev_get(dev);
>                         if (idev)
>                                 err =3D in6_dump_addrs(idev, skb, cb,

Good catch, thanks !

Not sure why ip command is so picky about the error code here.

There is no IPv6 on this device after all.

The following seems to react quite differently :

# ip addr  show lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host proto kernel_lo
       valid_lft forever preferred_lft forever
# ip link set dev lo mtu 1000
# ip addr  show lo
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever



Reviewed-by: Eric Dumazet <edumazet@google.com>

