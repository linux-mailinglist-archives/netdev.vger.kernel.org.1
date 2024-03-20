Return-Path: <netdev+bounces-80733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD7880BE0
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 08:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B6BB20A15
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4621EB44;
	Wed, 20 Mar 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJhrHo2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17B20DCC
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919078; cv=none; b=u+w2B2Ly1SKOAAxZ9e6T+28UfBuLMbsZy8+yJGr2wgZuOSdHUvpveATvZmM2uz7ZDbIWG2lERh5Y8FyVXqDmtSzHkZOXSNNunvnXpV4QEXBQsuT4zDJkqOxu3a4Z6M4ZTkFIU2jOynIKGB5eaIWVNmP7puBDuAzI967eJ6dvXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919078; c=relaxed/simple;
	bh=giQIs/wvEozo7PbpDWIVGqdjUORVXuzRLz254UEWR2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkthwMmMGYA1S7UNw/QdFyUV2bxdPOijCd9Fty8qay9LmolVeZQrD/ISHgFnkbAyO43b3CwrOAxJpDK4s0ntkIGm/Jvz7iinbLq8/RR8w3LcvTdPFCgByOeOel9D/1pd2XfbJAvzoRrpfNOuW9pcKmm8zSnFOyWBuPkNUZoOfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJhrHo2/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a467d8efe78so695354266b.3
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710919075; x=1711523875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOnSEQvLXSUkr1W5gMr2uGIVxZ4qa1zZkqw4BlYcGM4=;
        b=hJhrHo2/KUa0+E0n6QlonOJ4J9XSVscM1djY8MPk3VuAlHGEpcZDbYSUfvsM1r5FEZ
         v/4XTGxSZO9stHDUtDgkXmHO/EL2hQo62o+7O9xQfG3otQdmb+EVVZMxgBBAjuGMyTbO
         A7Qpxf2iSUb5qdV6gMKFLg+hRG6N9ipHsiPSxMIdU5NNo/fTt09kSPOF5cC42gdEGaFt
         hb3rqS+Q4wlev7FjiegLve+dbkq8t1ohd4GP/SKNvYMmvAbHv6PlOTqrKSjGFOZBTyeH
         WI0sZj9eQhYzlbuvQSgW6Zu0oDkFXO1bLy3S2nb2mdKIaRJL6PZccRTOk/ksJtx1HOh5
         xIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710919075; x=1711523875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOnSEQvLXSUkr1W5gMr2uGIVxZ4qa1zZkqw4BlYcGM4=;
        b=Hg1uKd1u9fUnixhMrlxd3ZlFYrA6axloeXibeoMGXOiZ3WOlzUA32n5TUzJ5qK7p/k
         bGiIyxuhvNTxICN4T4LYBpjU2BNLwWpTqBuyc9Ot5E6xsdBvL4vcmeH0EznpVdoRWeDP
         MqgRITZozlZOwHTkkxDvHPDof9o4WQ+fv4ZzCU1vo9b/vNP69R6Qhvp6eM1Mvc4ZxzSs
         wlRVUvEfD2w/BIHgaRe61GZKKJZO89msmV3rAZs7obMll6hy3od4A9sQx6IqmIWcQoKR
         fXL3vHUpWNZjIb2cYHTNrw+VeQ3kTyKD5OI8n1T0KXvixuVJSGoxK61tu1tbRHtpQ6EG
         AhNg==
X-Gm-Message-State: AOJu0YwfUCgOS87xK8hSVPckspVJAyz4jm3gH6BrPsS1EunKjOxLRJv7
	auOKO4wyIeuNpql47bhwv/57e5RcqO+3AS3wUT1Xn/gR1q/7B3oY63Z2dWSo3m3rg2AvuCgaPhv
	XanG09yk9rS/0jc7Pbdtp8/mBiBcK/gymh9CEmA==
X-Google-Smtp-Source: AGHT+IG3iFww97Moc+p8mSLh+sOv2NgDzfRvjHjHKHf5q0g86Z+Al3MDMu0Raowg+k4y3e1pvwHOOFkiSacriKn4Af0=
X-Received: by 2002:a17:906:6dca:b0:a46:cf41:5792 with SMTP id
 j10-20020a1709066dca00b00a46cf415792mr3747932ejt.14.1710919074652; Wed, 20
 Mar 2024 00:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710866188.git.balazs.scheidler@axoflow.com> <9f083bed8b74cadee2fc5fb3269f502a8f578aae.1710866188.git.balazs.scheidler@axoflow.com>
In-Reply-To: <9f083bed8b74cadee2fc5fb3269f502a8f578aae.1710866188.git.balazs.scheidler@axoflow.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 20 Mar 2024 15:17:17 +0800
Message-ID: <CAL+tcoDX63aQr_iGRZ3UJi19V6HR+piXW+Di6RCZGAreLA5Ngw@mail.gmail.com>
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

I saw your reply to the previous thread[1]. The lport is redundant as
Kuniyuki pointed out before. I don't think it's inappropriate to break
such tracepoint compatibility, or else we always add more duplicated
fields which can replace old ones (it really looks ugly). Let's hear
what the maintainers say after you rebase and submit in one week.

Besides, you should send/CC to maintainers specifically. You can run
./scripts/get_maintainer.pl and know who they are :)

[1]: https://lore.kernel.org/all/ZeBGy0Wt2rmR0j74@bzorp2/

Thanks,
Jason

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

