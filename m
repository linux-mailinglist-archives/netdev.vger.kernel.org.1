Return-Path: <netdev+bounces-125456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E403596D20C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F671C2503D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A868194A6F;
	Thu,  5 Sep 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqKNVD2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1156189518
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524680; cv=none; b=BJPgmvuh78cq6jyuco5+xX/GCGpyHttIz2Kv4TsS9Ia2SHN9c0n25c38wH4el2A9WtBscUUq4Xx4jQt8Dew4yITggQTPBqHd8N4xXE+8Js70DaXPbgr+u6xMtJO5und2GVmUpCoYLXEe3hh6Kig+cQrBTDVsSWfViAYFWqGZGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524680; c=relaxed/simple;
	bh=pJ7zntbRM1090fR7dXCuDEpa5qFUSBCsMd/I8FGZ30c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMIt5e+b+nzYmXp+MLSpCTnSPvT5KIbGisOwd9RTHvRBcfsnop1IRp7VvBvZtMx26LcA16EB3Hg4V2OhW0G9Urnjz2b6VeRHUCBqYrq7hlGWGVKNzCqPRkE4dAjKxQHh9CzYeK3VC8EbyR9yPKJAd4lJfzrIEc/LpQPykNEFubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqKNVD2H; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39f37a5a091so1678395ab.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725524678; x=1726129478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qg7kz0a77rJ9FvMBXLFQO20FfWRgn3QuCYyGE6IIMI=;
        b=FqKNVD2H6tElZW+LuIZlyuv4BKPHX73jsGxCb3HSd6Awqfv1GzPX8QG3BxaOckPiFj
         9of4tOZ40+qJixkCp0Ugml9xXHE3MgVQuOglPnLxLVbIZLbBhBhOg7rxjsQSVNbd8hyI
         7xSpMSuuctJDcvdT8tOkYjgPROP2fZ/nZ1KKqGgjpawo6Ex6XtSg4l/yNb+9k0stpUxR
         PtsaYAuvhlcugYNr7TBFNfl5isUAqZ5+6KB/qJVqHJyEWBDGvlzlyDinljqCM5K1BnS7
         bMLbyJ3WLIDQi6WlPIaF4+VNkCnvbXuI1sYZYOZlVAcJbDE7NLxcw3JNiYDnkCHTrE0e
         Rq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524678; x=1726129478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qg7kz0a77rJ9FvMBXLFQO20FfWRgn3QuCYyGE6IIMI=;
        b=Z3pmK0cFZM4Xi/r4uZM+bo+UBzgolm6oNVG4EERPw0rkk8sJ4m2iojME+JKG0fqiAr
         KvF9V7ymsk2pucJx3SCHmD611NrwZcJPFzyKOmkcz15C9K4+66WNLK7h4Lg+36cLrXZP
         XjR8EmUkzTUm65ZNEi5DgwpLex30c6w5463oJb3JiVY3Wi7P4Kw5Z3IOMDO6l37chptz
         gGcEgbGcboKc7m+HSuXwMSWVeJqqGlRJ8Ydw3GK7zTobrJ0CMURIZpTFcs++YPvYcEQP
         zQFKHx+vNpoBtzBf3n1nob6iWNUO7+vdDiGdU0RhM+ts0sXO91eS4MHA2B07InaaPXTG
         3Cpg==
X-Forwarded-Encrypted: i=1; AJvYcCWhgd1PBDdQ6DsAiK72QsCWzsC5x7zJ4BhwWM0bPV15Nn8xwVis2+xYUU5Ar+I78YJ6MI45dHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYzr+rAmQ0J/gtjx+QMTVJU+plqL9kPU2rIzfcNXeoueTCs8E
	R5lcMoaHRDj+8t0UjgT0Zy3BDbdrJX7EUhHytq851f1DyHu7Mk3xMAsNMQIp+6+zZwZHOqAHm3G
	1BCI0u64JMXa8N3Q0BOQ90nKUejk=
X-Google-Smtp-Source: AGHT+IGDZqnfACQBYiLv+hh057I0u0I4Qr7/Bhz2Jk4ueQ8Xv+SZ58FNZyb5ayYoXsGcF3k1fsJZN8GwcxF55F6ZxhA=
X-Received: by 2002:a92:c56d:0:b0:3a0:43b1:4c32 with SMTP id
 e9e14a558f8ab-3a043b14d46mr36307255ab.25.1725524677746; Thu, 05 Sep 2024
 01:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904113153.2196238-1-vadfed@meta.com> <20240904113153.2196238-2-vadfed@meta.com>
In-Reply-To: <20240904113153.2196238-2-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 16:24:01 +0800
Message-ID: <CAL+tcoAO=0g0mkmgODzNWLJZgRxNvJiXM7=DgoCgdbFsJ0cJEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Vadim,

On Wed, Sep 4, 2024 at 7:32=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
[...]
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tst=
amp.h
> index a2c66b3d7f0f..1c38536350e7 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -38,6 +38,13 @@ enum {
>                                  SOF_TIMESTAMPING_LAST
>  };
>
> +/*
> + * The highest bit of sk_tsflags is reserved for kernel-internal
> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING=
*
> + * values do not reach this reserved area

I wonder if we can add the above description which is quite useful in
enum{} like this:

diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstam=
p.h
index a2c66b3d7f0f..2314fccaf51d 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,7 +13,12 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */

-/* SO_TIMESTAMPING flags */
+/* SO_TIMESTAMPING flags
+ *
+ * The highest bit of sk_tsflags is reserved for kernel-internal
+ * SOCKCM_FLAG_TS_OPT_ID.
+ * SOCKCM_FLAG_TS_OPT_ID =3D (1 << 31),
+ */
 enum {
        SOF_TIMESTAMPING_TX_HARDWARE =3D (1<<0),
        SOF_TIMESTAMPING_TX_SOFTWARE =3D (1<<1),

to explicitly remind the developers not to touch 1<<31 field. Or else,
it can be very hard to trace who occupied the highest field in the
future at the first glance, I think.

[...]
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f26841f1490f..9b87d23314e8 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1401,7 +1401,10 @@ static int ip6_setup_cork(struct sock *sk, struct =
inet_cork_full *cork,
>         cork->base.gso_size =3D ipc6->gso_size;
>         cork->base.tx_flags =3D 0;
>         cork->base.mark =3D ipc6->sockc.mark;
> +       cork->base.ts_opt_id =3D ipc6->sockc.ts_opt_id;
>         sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
> +       if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
> +               cork->base.flags |=3D IPCORK_TS_OPT_ID;
>
>         cork->base.length =3D 0;
>         cork->base.transmit_time =3D ipc6->sockc.transmit_time;
> @@ -1433,7 +1436,7 @@ static int __ip6_append_data(struct sock *sk,
>         bool zc =3D false;
>         u32 tskey =3D 0;
>         struct rt6_info *rt =3D dst_rt6_info(cork->dst);
> -       bool paged, hold_tskey, extra_uref =3D false;
> +       bool paged, hold_tskey =3D false, extra_uref =3D false;
>         struct ipv6_txoptions *opt =3D v6_cork->opt;
>         int csummode =3D CHECKSUM_NONE;
>         unsigned int maxnonfragsize, headersize;
> @@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
>                         flags &=3D ~MSG_SPLICE_PAGES;
>         }
>
> -       hold_tskey =3D cork->tx_flags & SKBTX_ANY_TSTAMP &&
> -                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
> -       if (hold_tskey)
> -               tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> +       if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> +           READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {

s/SOCKCM_FLAG_TS_OPT_ID/SOF_TIMESTAMPING_OPT_ID/
In case you forget to change here :)

> +               if (cork->flags & IPCORK_TS_OPT_ID) {
> +                       tskey =3D cork->ts_opt_id;
> +               } else {
> +                       tskey =3D atomic_inc_return(&sk->sk_tskey) - 1;
> +                       hold_tskey =3D true;
> +               }
> +       }
>
>         /*
>          * Let's try using as much space as possible.
> --
> 2.43.5
>

