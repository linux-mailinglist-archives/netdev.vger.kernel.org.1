Return-Path: <netdev+bounces-80930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED919881B90
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628AD1F21DF8
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 03:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E36AD4C;
	Thu, 21 Mar 2024 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBWF1z6h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2413AD35
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992101; cv=none; b=V31FA044kZuDuc2Pcn9oYlf2J3upsZ9jNcxMiru4I78pTzEztEIa51bMDMIn8Vpl8mAc5k1mfZ2Te9J6GTqM1YiEvqcApIG3bUaxXJLjj2YklWNwrIogWc9Bm1XCtj2pTTlU0586kbRjK+HMIGNN0mIKRApUn/5n1M4+y8MWjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992101; c=relaxed/simple;
	bh=uJNB0ouLsM5mX0vhZpixWr90/zUIKLswn8v/BI6coLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sABl951HtUQUYqivXY4AM4ttiMqx72uuEjk+JksoF1ebb18Mlyp2z2X+CcAG+irfRVmeQHy7BiqCYbF3G3YU9TprmK+pRDh9WeggkdCoW+9aNxTGX8MTbtl7tzQjiS0uArwGkdVz2Bgdfpc6AhTPGdkQRTyXZOWPlcw/DdHrmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBWF1z6h; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ad785a44so54093066b.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710992098; x=1711596898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY9go4rS4K+5KzWoR9L91T28Eqf3ZCL7VqF2SKMaLEQ=;
        b=KBWF1z6hy1WAe+8oZhRuMF/JNq6pqEyBUoUWiFMptX8t9FiP+VguFiM9Y/Ab6f9xeZ
         XEUHzJAJHcdESFrb9tcZ0xKgs+EPNYNQS00MzygqKqWSo7wHF+As0OON7m3do3rQABxg
         TI5tvQ9RV/gQq2hpYQgZwBjxycCKhLdahpZrPkELi99KMlV5IuZXeUycctxPGY3lnaEK
         nqiTtPTp5qRCjCWrO4nimkrhOZgG0dikwm8gBDYPKdqgXJp3e5/yhRE5AIc7WByjyyBu
         w6/sro01deuDUGymvYYm/hy9uaqOxncfEZaOKpiB6J03/NhuLkJGey71QVPt4SJTBAWi
         pPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710992098; x=1711596898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY9go4rS4K+5KzWoR9L91T28Eqf3ZCL7VqF2SKMaLEQ=;
        b=Hlq14BevvwBVAl51OPhmXDHW1q4UeKMDab2rra9Yf42FuM3eSQSJzYhJQ3yFGOsGxb
         DwxWQI+NGtjdlemGOtme0z2WgVqdHKltDaQN8WD2Kfu0JCZMoM0zRQPZFTaQyXrdbjjX
         U02kAYqbdAfkVurkMnTSCIzWwa1sQXvOOK25ObsGP8AxLKtt2ae0KM8riPXHPm3iaOn9
         kIXZK1wqFtnKv512LzQV8TAs81njKifJuNgCVpiyVD5awxu8duyHCvA+7hf6SKu+ORbw
         ENbjaB9Ac+DZ9ppO5jSkC/4yY6UB4DBgf5eSEQ6yAhfLeYoeQNuWY9lvnhw2jsacy89t
         yjZw==
X-Gm-Message-State: AOJu0Yxe+vCjt2s0ZnFpJzzMqcakMIb8qYJuYcmhM04b+ZcMeQaMcpcT
	e9+9oXuj/79h2H4AZjsrrCzaDYbiCYmOfxCL/5iQyGzDhmXZQoLf8E2A/sau0RVKWKIR850IRDk
	QfE/JKv3CVSrL31MxD7ISN2/bjLu46Kxs
X-Google-Smtp-Source: AGHT+IG7RJinuNKrVMVvmnMdPhMORY3kYsx/lUXFT5mu+fhAbY8pZxdkVq1/xDkheWA4Y0Duo2tewx9k0v5slyk4VkE=
X-Received: by 2002:a17:906:f8d5:b0:a46:c3de:2a54 with SMTP id
 lh21-20020a170906f8d500b00a46c3de2a54mr473260ejb.71.1710992098018; Wed, 20
 Mar 2024 20:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710866188.git.balazs.scheidler@axoflow.com> <9f083bed8b74cadee2fc5fb3269f502a8f578aae.1710866188.git.balazs.scheidler@axoflow.com>
In-Reply-To: <9f083bed8b74cadee2fc5fb3269f502a8f578aae.1710866188.git.balazs.scheidler@axoflow.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 Mar 2024 11:34:21 +0800
Message-ID: <CAL+tcoCXCteEBhQXrFuM_9vXaLd+0JQy04yj9nzti75u3twuzw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: udp: add IP/port data to the
 tracepoint udp/udp_fail_queue_rcv_skb
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, Balazs Scheidler <balazs.scheidler@axoflow.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:39=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.co=
m> wrote:
>
> The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
> and destination IP/port whereas this information can be critical in case
> of UDP/syslog.
>
> Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
> ---
>  include/trace/events/udp.h | 33 +++++++++++++++++++++++++++++----
>  net/ipv4/udp.c             |  2 +-
>  net/ipv6/udp.c             |  3 ++-
>  3 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
> index 336fe272889f..f04270946180 100644
> --- a/include/trace/events/udp.h
> +++ b/include/trace/events/udp.h
> @@ -7,24 +7,49 @@
>
>  #include <linux/udp.h>
>  #include <linux/tracepoint.h>
> +#include <trace/events/net_probe_common.h>
>
>  TRACE_EVENT(udp_fail_queue_rcv_skb,
>
> -       TP_PROTO(int rc, struct sock *sk),
> +       TP_PROTO(int rc, struct sock *sk, struct sk_buff *skb),
>
> -       TP_ARGS(rc, sk),
> +       TP_ARGS(rc, sk, skb),
>
>         TP_STRUCT__entry(
>                 __field(int, rc)
>                 __field(__u16, lport)
> +
> +               __field(__u16, sport)
> +               __field(__u16, dport)
> +               __field(__u16, family)
> +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
>         ),
>
>         TP_fast_assign(
> +               const struct inet_sock *inet =3D inet_sk(sk);
> +               const struct udphdr *uh =3D (const struct udphdr *)udp_hd=
r(skb);
> +               __be32 *p32;
> +
>                 __entry->rc =3D rc;
> -               __entry->lport =3D inet_sk(sk)->inet_num;
> +               __entry->lport =3D inet->inet_num;
> +
> +               __entry->sport =3D ntohs(uh->source);
> +               __entry->dport =3D ntohs(uh->dest);
> +               __entry->family =3D sk->sk_family;
> +
> +               p32 =3D (__be32 *) __entry->saddr;
> +               *p32 =3D inet->inet_saddr;
> +
> +               p32 =3D (__be32 *) __entry->daddr;
> +               *p32 =3D inet->inet_daddr;
> +
> +               TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);

Oh, I forgot to say: is this macro a duplication? I mean that it's
good to use the macro but we need to clear the related part (recording
port and addr manually) above this line.

Thanks,
Jason

>         ),
>
> -       TP_printk("rc=3D%d port=3D%hu", __entry->rc, __entry->lport)
> +       TP_printk("rc=3D%d port=3D%hu family=3D%s src=3D%pISpc dest=3D%pI=
Spc", __entry->rc, __entry->lport,
> +                 show_family_name(__entry->family),
> +                 __entry->saddr, __entry->daddr)
>  );
>
>  #endif /* _TRACE_UDP_H */
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a8acea17b4e5..d21a85257367 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2051,8 +2051,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, str=
uct sk_buff *skb)
>                         drop_reason =3D SKB_DROP_REASON_PROTO_MEM;
>                 }
>                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite)=
;
> +               trace_udp_fail_queue_rcv_skb(rc, sk, skb);
>                 kfree_skb_reason(skb, drop_reason);
> -               trace_udp_fail_queue_rcv_skb(rc, sk);
>                 return -1;
>         }
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 3f2249b4cd5f..e5a52c4c934c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -34,6 +34,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/indirect_call_wrapper.h>
> +#include <trace/events/udp.h>
>
>  #include <net/addrconf.h>
>  #include <net/ndisc.h>
> @@ -661,8 +662,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, str=
uct sk_buff *skb)
>                         drop_reason =3D SKB_DROP_REASON_PROTO_MEM;
>                 }
>                 UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite=
);
> +               trace_udp_fail_queue_rcv_skb(rc, sk, skb);
>                 kfree_skb_reason(skb, drop_reason);
> -               trace_udp_fail_queue_rcv_skb(rc, sk);
>                 return -1;
>         }
>
> --
> 2.40.1
>
>

