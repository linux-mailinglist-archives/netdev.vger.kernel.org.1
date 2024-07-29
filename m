Return-Path: <netdev+bounces-113754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C7C93FC62
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D982811D9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DC15ECD0;
	Mon, 29 Jul 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yn48yO1s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A935028C
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273797; cv=none; b=r7gG0VtDdq4QuaRUc/ThN30jrAyYizwJgjQwfmw84+OQC84czn54c28k1qBMFqW/eXJWOLSOoNrEPjyTeGXDREhOKgkB3xuGFdcGFKj6jPSISEzfFg45KA2/oIgF+ZkSqvdl8frYG2pkpDdeeq0F5bbn94JJQEw9xQHMpg5IlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273797; c=relaxed/simple;
	bh=wkeoKsIDYZTSYe4NIgqYHGKbRFJkQ3Z1baEhP19U1yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCL4BMTSjYXYOLs/4Fer9B/fICectfB/sbRglQdFEcSr0eY+R/zyfEn3I3xKOLPr9ehJ0J5Lr9BLQ0VNk2Q4/NyjWSIY4jpNPxvd5WhI4sa7we4LneNoGFNbnFskV3wSd8AfikDDogmTeHQf6mFmlTIx2JqrZv0qqMFBn5FCXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yn48yO1s; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so862a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722273794; x=1722878594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO+S0yIk9J3yZcwAWEY+g4MZfIfCxqlUWZzMDvRfn0Q=;
        b=yn48yO1sJTFzgZ6mW5pMzIeCwzdjRx4jsynhgZF3rnDDoZqJK0s3bKnx3JboaeDmRP
         AfC6djZS+fYdrBcyfqj3UPC8CRl1Sx3ecIh6EKAMRh2Q9aOvZMJMW5Ueu6EsJJKzDFH2
         brxA4R/0DWvolYBwtYRpa0tMKGLA2mM0q6dE1LE5ct7xPnABoF2dIos3unwy6kJo/qg9
         ridKZRWryBlkXk1zgfm6+jZVALooCCC0w1/R3Rxemf9qBpsM9KSI5+J3m34ij1Yu/pnJ
         oxZJpWkiTUFo0ZlBPypWmeSmidPAX1dSD2kxLW0LJUi/2QTPcibQtcDks9Smr/I8iv7O
         FRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722273794; x=1722878594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO+S0yIk9J3yZcwAWEY+g4MZfIfCxqlUWZzMDvRfn0Q=;
        b=SJhfVk4+YW7qsOw+uceCK3SUk0al6iW5jGOgyiM6ZjS8pQiQlfMTU7HXXL2Ls2Q4Ij
         a5C4rEYPUqYwhQEX+gu3+b/3Lbs5K6I+CY3QOqPQZh1JZTEMUkSeGebPiZKqUraDx3Jo
         eoS1Qw3Xk8IkerfILja557fb5V/8RUHMo4Ik+p+IrMpnXHeWNXThek86vj33OCjGXT4B
         3/BlM6JFQP7+gPLEw9LB5V4YBOYn2Z5dpWXFlYdGi9NL0Few5MSG3Hk8w3N95qL4ZkXS
         QcBQBU5OfYnjEk9T+F8eysOvbGdgCdKEhz57npYXoOHeXH86pYTjCcb+kjD+/UGNlKBx
         QF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVve8YWyxPjLUHtLd4WbjgvuJWELisfA6ywSY80L6LKLgXXoLxCJihVzZdbn8IRtrn4lRYb7ZV24f/10l1xuvWDno5Mr+mO
X-Gm-Message-State: AOJu0YxQ9UQX9zH1Vw6mkofiNqcg4VzwxKWHuu/rcb93mfYl2qKw0a27
	QrlCtvB+PF92DzmQ+5H8cpzK6gpRCuB3g4h6yWWmcm+MO4dnCuCxq/EfpyqXW0IT2y4ThHmsPh7
	KtBwRU2IX+Hjk6mNvE6m5TMhP2JJgWMvu515b
X-Google-Smtp-Source: AGHT+IGxSyD55J6fyyYqZa/JDg3OhbibbRk6ijKOE2jecHLvLJ1XsqBJPrRqYybvWY+95RYez10SY9P1xaSdhuk2iio=
X-Received: by 2002:a05:6402:26cf:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5b408519156mr43893a12.0.1722273793343; Mon, 29 Jul 2024
 10:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726010629.111077-1-prohr@google.com>
In-Reply-To: <20240726010629.111077-1-prohr@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 29 Jul 2024 10:22:57 -0700
Message-ID: <CANP3RGdVFDp3mpOn7OV_Fh=cFO+HbMN8S+zSMcoQNAi=5iR+2w@mail.gmail.com>
Subject: Re: [PATCH net-next] Add support for PIO p flag
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	David Lamparter <equinox@opensourcerouting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:06=E2=80=AFPM Patrick Rohr <prohr@google.com> wro=
te:
>
> draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
> Option to signal the pd-per-device addressing mechanism.
>
> When accept_pio_pflag is enabled, the presence of the p-flag will cause
> an a flag in the same PIO to be ignored.
>
> An automated test has been added in Android (r.android.com/3195335) to
> go along with this change.
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Lamparter <equinox@opensourcerouting.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 11 +++++++++++
>  include/linux/ipv6.h                   |  1 +
>  include/net/addrconf.h                 |  8 ++++++--
>  net/ipv6/addrconf.c                    | 15 ++++++++++++++-
>  4 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 3616389c8c2d..322a0329b366 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2362,6 +2362,17 @@ ra_honor_pio_life - BOOLEAN
>
>         Default: 0 (disabled)
>
> +accept_pio_pflag - BOOLEAN

I wonder if this should be 'honour_pio_pflag' instead?
accept seems weird since the result is actually to ignore...

> +       Used to indicate userspace support for a DHCPv6-PD client.
> +       If enabled, the presence of the PIO p flag indicates to the
> +       kernel to ignore the autoconf flag.
> +
> +       - If disabled, the P flag is ignored.
> +       - If enabled, disables SLAAC to obtain new addresses from
> +         prefixes with the P flag set.

I think the phrasing/grammar here could use some work...

perhaps 'if enabled, the P flag will disable SLAAC autoconfiguration.'

> +
> +       Default: 0 (disabled)
> +
>  accept_ra_rt_info_min_plen - INTEGER
>         Minimum prefix length of Route Information in RA.
>
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 383a0ea2ab91..396b87d76b55 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -89,6 +89,7 @@ struct ipv6_devconf {
>         __u8            ioam6_enabled;
>         __u8            ndisc_evict_nocarrier;
>         __u8            ra_honor_pio_life;
> +       __u8            accept_pio_pflag;

perhaps 'ra_honor_pio_pflag' to match 'ra_honor_pio_life'

>
>         struct ctl_table_header *sysctl_header;
>  };
> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 62a407db1bf5..59496aa23012 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -38,9 +38,13 @@ struct prefix_info {
>  #if defined(__BIG_ENDIAN_BITFIELD)
>                         __u8    onlink : 1,
>                                 autoconf : 1,
> -                               reserved : 6;
> +                               routeraddr : 1,
> +                               pdpreferred : 1,

would 'preferpd' be better/shorter?

> +                               reserved : 4;
>  #elif defined(__LITTLE_ENDIAN_BITFIELD)
> -                       __u8    reserved : 6,
> +                       __u8    reserved : 4,
> +                               pdpreferred : 1,
> +                               routeraddr : 1,
>                                 autoconf : 1,
>                                 onlink : 1;
>  #else
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 55a0fd589fc8..3e27725a12fc 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly=
 =3D {
>         .ioam6_id_wide          =3D IOAM6_DEFAULT_IF_ID_WIDE,
>         .ndisc_evict_nocarrier  =3D 1,
>         .ra_honor_pio_life      =3D 0,
> +       .accept_pio_pflag       =3D 0,
>  };
>
>  static struct ipv6_devconf ipv6_devconf_dflt __read_mostly =3D {
> @@ -302,6 +303,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_m=
ostly =3D {
>         .ioam6_id_wide          =3D IOAM6_DEFAULT_IF_ID_WIDE,
>         .ndisc_evict_nocarrier  =3D 1,
>         .ra_honor_pio_life      =3D 0,
> +       .accept_pio_pflag       =3D 0,
>  };
>
>  /* Check if link is ready: is it up and is a valid qdisc available */
> @@ -2762,6 +2764,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8=
 *opt, int len, bool sllao)
>         u32 addr_flags =3D 0;
>         struct inet6_dev *in6_dev;
>         struct net *net =3D dev_net(dev);
> +       bool ignore_autoconf_flag =3D false;

I think you can skip '_flag'

>
>         pinfo =3D (struct prefix_info *) opt;
>
> @@ -2864,7 +2867,8 @@ void addrconf_prefix_rcv(struct net_device *dev, u8=
 *opt, int len, bool sllao)
>
>         /* Try to figure out our local address for this prefix */
>
> -       if (pinfo->autoconf && in6_dev->cnf.autoconf) {
> +       ignore_autoconf_flag =3D READ_ONCE(in6_dev->cnf.accept_pio_pflag)=
 && pinfo->pdpreferred;
> +       if (pinfo->autoconf && in6_dev->cnf.autoconf && !ignore_autoconf_=
flag) {
>                 struct in6_addr addr;
>                 bool tokenized =3D false, dev_addr_generated =3D false;
>
> @@ -6926,6 +6930,15 @@ static const struct ctl_table addrconf_sysctl[] =
=3D {
>                 .extra1         =3D SYSCTL_ZERO,
>                 .extra2         =3D SYSCTL_ONE,
>         },
> +       {
> +               .procname       =3D "accept_pio_pflag",
> +               .data           =3D &ipv6_devconf.accept_pio_pflag,
> +               .maxlen         =3D sizeof(u8),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dou8vec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         {
>                 .procname       =3D "accept_ra_rtr_pref",
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

