Return-Path: <netdev+bounces-174471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF57DA5EE7A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051617D0F3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52C26158A;
	Thu, 13 Mar 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kw1J9EUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D92620E4
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855919; cv=none; b=gZOo3+BzKkjqHPaJ3dn1CW1AqKRheRp9cZxt7ITA6gzFi55U/XCClWks4wRIpjeNxuJZ+d+du7rJjtuG32mI9uwyOtpn/Gi/EHes1fUVNB/DV5Q38KgGO5+srS2iNR8TVepvy0erQDwf6oTMIqPtE6A2LSQ+9GX555ciFa233C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855919; c=relaxed/simple;
	bh=pPSlP/flZ1//ElBtEMUdU/Jl89L1Zf5afNhaHq1C4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NptUfT+32ctPlqPtpYc7LcZa9QFQehCBbjpLlwFYle4RJ3csXpxduNhPOYLa76uMoDrIwZB6s9gULKaYR1riCAl9N2nXVaoq0gzBBxIAtpVFRSbCCGronJRjOHakQ8aLghu2uS+my/c/aTeC6yuvRKyOi1DFuhh0DqfaauOuofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kw1J9EUK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476b89782c3so8570861cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741855916; x=1742460716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCNuzuQCrC9fQ/wUHtGFFCguDdSldzIFixPSb3ebiNQ=;
        b=kw1J9EUKIR3u0ZFHGJNxWWtI4wQH8zXjgrpshrJqzroooJui2y7ugBcqLFBFSqnBi5
         MmWDobZyUM0p4fWm/FvRTX7ZdwbSOlzsjez/RuFPC1txCwpNrFRKM2f4RXFZTrMResSK
         zZdUq6tARb9XyfsLODzH2p83OuZx9X3/omko/zCgt14ydXjpvx/baXggTU8JygYALsMq
         cNof9F1Pm4+EjtXx4ZsgWpaqivjk1Upx6UNOfJwBiJYwC6uCpHC0zJLSNjtxm4C6DPVE
         y03pBLl728T/c7IJmlCzH4lOzRjETdHkrNnSRxn3I1UwOvgqfR9VSqW0JPML99uze6wp
         4OlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855916; x=1742460716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCNuzuQCrC9fQ/wUHtGFFCguDdSldzIFixPSb3ebiNQ=;
        b=LTGnITMy4zpqFbQQu2vAhkkNKxkGjld/X35FwGgWC4Nu4LWwr4NwR+d2jLEwLQwLvb
         X89i5VTEmQTNzmbLQlR32sZbhcCvSAB52akEHd+KdcTdI0IaSl6PZx6DKy9QEfXlWe3g
         foepJ3qR4TV15o2VLZHTK5oCE1gr8NR6n/3s/y7QZ7K8C8h4dhEx7q4pB0VKMww5XESd
         +QgfDBvUo1kax0JdcGxBq5UnxiC0L90tb6XfKgqMrYQ/YdW0mUhitlm7qSagfBR6tgHC
         pr/uahIxNgeKgjN+WUuKTh7zAsdMK0/LUY6RvfJU0OfQtSkZXCvUaaqtyGhIhDXWxG/S
         3ZMQ==
X-Gm-Message-State: AOJu0YwL7TM424cafnRmTUQjMqJ8lFXNDN/HoDDlgCU1wSinegPiFOA+
	6+S7URmmE9CYxb9ZUbqhDQHT5HxkTDPhOL3rs3tZZZMr2ihIwYTspx8aO0eeXz6ZFmJoxOmXfmo
	dwZf0A/cElSRTb408ttieCCWEKnGrkfIAb1TElUt8QA7s9sg2ZAU1vAWSYA==
X-Gm-Gg: ASbGncuUx7QEwk9bsNp7icCxiUjuqfUhSZ1DlLu0lUzWrulmbeAi2TfA2dB0DThcYBC
	qRlH9ZABlRKM1UokjTbFJsE8pfOdpz9d5zkv9+cEtGrZe08y2IIipT/uVPCzhkUO+25rDJXNReW
	20hYVYi3ujF8CXxaWxB3CA8/cyheDlL0/sgiRN
X-Google-Smtp-Source: AGHT+IGHOIgz97FIKMRxwZ9CzwecVJYGzQmr6f63g86khWv4/HSiaqbFjdfAZlAR9bn7svVfCTnt8LREdMJRGX7zqE8=
X-Received: by 2002:ac8:5902:0:b0:472:1225:bd98 with SMTP id
 d75a77b69052e-4769965cf1cmr179597501cf.50.1741855915782; Thu, 13 Mar 2025
 01:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305163732.2766420-1-sdf@fomichev.me> <20250305163732.2766420-5-sdf@fomichev.me>
In-Reply-To: <20250305163732.2766420-5-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Mar 2025 09:51:23 +0100
X-Gm-Features: AQ5f1JqlO2YBC00bvYq4fxHwcbBER8TCUQ2gQEFcHPoBrR4Uvs3sMXBIIC_nln4
Message-ID: <CANn89i+4F1f2FSUxmxP=qqir0z_3ZDNpQoqkE3X7bwp81U3sCw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:37=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> Qdisc operations that can lead to ndo_setup_tc might need
> to have an instance lock. Add netdev_lock_ops/netdev_unlock_ops
> invocations for all psched_rtnl_msg_handlers operations.
>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/sched/sch_api.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 21940f3ae66f..f5101c2ffc66 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1279,9 +1279,11 @@ static struct Qdisc *qdisc_create(struct net_devic=
e *dev,
>                          * We replay the request because the device may
>                          * go away in the mean time.
>                          */
> +                       netdev_unlock_ops(dev);
>                         rtnl_unlock();
>                         request_module(NET_SCH_ALIAS_PREFIX "%s", name);
>                         rtnl_lock();

Oops, dev might have disappeared.

As explained a few lines above in the comment :

/* We dropped the RTNL semaphore in order to
* perform the module load.  So, even if we
* succeeded in loading the module we have to
* tell the caller to replay the request.  We
* indicate this using -EAGAIN.
* We replay the request because the device may
* go away in the mean time.
*/



> +                       netdev_lock_ops(dev);

So this might trigger an UAF.

>                         ops =3D qdisc_lookup_ops(kind);
>                         if (ops !=3D NULL) {
>                                 /* We will try again qdisc_lookup_ops,
> @@ -1591,7 +1593,11 @@ static int tc_get_qdisc(struct sk_buff *skb, struc=
t nlmsghdr *n,
>         if (!dev)
>                 return -ENODEV;
>
> -       return __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
> +       netdev_lock_ops(dev);
> +       err =3D __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
> +       netdev_unlock_ops(dev);
> +
> +       return err;
>  }
>
>  static bool req_create_or_replace(struct nlmsghdr *n)
> @@ -1828,7 +1834,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, str=
uct nlmsghdr *n,
>                 return -ENODEV;
>
>         replay =3D false;
> +       netdev_lock_ops(dev);
>         err =3D __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay)=
;
> +       netdev_unlock_ops(dev);
>         if (replay)
>                 goto replay;
>
> @@ -1919,17 +1927,23 @@ static int tc_dump_qdisc(struct sk_buff *skb, str=
uct netlink_callback *cb)
>                         s_q_idx =3D 0;
>                 q_idx =3D 0;
>
> +               netdev_lock_ops(dev);
>                 if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
>                                        skb, cb, &q_idx, s_q_idx,
> -                                      true, tca[TCA_DUMP_INVISIBLE]) < 0=
)
> +                                      true, tca[TCA_DUMP_INVISIBLE]) < 0=
) {
> +                       netdev_unlock_ops(dev);
>                         goto done;
> +               }
>
>                 dev_queue =3D dev_ingress_queue(dev);
>                 if (dev_queue &&
>                     tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_=
sleeping),
>                                        skb, cb, &q_idx, s_q_idx, false,
> -                                      tca[TCA_DUMP_INVISIBLE]) < 0)
> +                                      tca[TCA_DUMP_INVISIBLE]) < 0) {
> +                       netdev_unlock_ops(dev);
>                         goto done;
> +               }
> +               netdev_unlock_ops(dev);
>
>  cont:
>                 idx++;
> @@ -2308,7 +2322,11 @@ static int tc_ctl_tclass(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>         if (!dev)
>                 return -ENODEV;
>
> -       return __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
> +       netdev_lock_ops(dev);
> +       err =3D __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
> +       netdev_unlock_ops(dev);
> +
> +       return err;
>  }
>
>  struct qdisc_dump_args {
> @@ -2426,7 +2444,9 @@ static int tc_dump_tclass(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>         if (!dev)
>                 return 0;
>
> +       netdev_lock_ops(dev);
>         err =3D __tc_dump_tclass(skb, cb, tcm, dev);
> +       netdev_unlock_ops(dev);
>
>         dev_put(dev);
>
> --
> 2.48.1
>

