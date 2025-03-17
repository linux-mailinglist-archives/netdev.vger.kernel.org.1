Return-Path: <netdev+bounces-175204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95142A64504
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71B7171456
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFB21D00E;
	Mon, 17 Mar 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zm+pCnOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97821CFF6
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199559; cv=none; b=qzMGLyUU2KcVNcxGQfVWuzdr+p3jc8X2Re0GWBVwVQUyCnBhA4+dqbbgXcbwSBDCjy/qDqhwm3bwooKxMqwYwIXhFlyAwCLEvkPspIrH1itv0xiWDmzgubzI85HaXo8Slj00EsWzet30eVHsKi/JPHajv9CPfo0r5Oc6qvoVlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199559; c=relaxed/simple;
	bh=AC5b3cOdcuPvQOXOujuOCv5VyyVIXIlom9fJtvwDBAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC7FW8y9QytgXfDOcl6DvVYWNp7RGmthjPQAm4r+/sJyKNlVhwXwEEK2Eqm9ZR2towd18vEil6M6ER2Wy8nIQ+gPToTaXJKv/ViDB12kFBcemA9IYX7ZC5X/02/eFzIB4CIR1mdpkXMrjE7EBYgA0v5QWwStGjhb564ME02h9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zm+pCnOv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4769aef457bso47537301cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742199555; x=1742804355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dmAl3f2a2eQALrDQqK+2x+vrO6J4Ix9fdjwK9KU9dg=;
        b=zm+pCnOvvVtJC5smx5wFyQwj/cf8nEKmsB+81+K6+0UfWLGqL0WCRWAOmtQ+s5/quR
         FhP67WPyuxn3Rzh3fZsIzfX/7dNcP7sf4MdamjubrI0M87BaStRaPvWgtUoTk1Zx9EME
         50vxMe1CKtotCe0m0DXAjQuRUX1DMu8PQwKPhoCoG5fHQKndxZXjDD0A2DK76TCTR9J0
         kvdMs32FcMDK0HGEVAbv0hzS6yEcFygcjM8ryD+qpsppKEBBLxeMSOKGik5qh+/QED4c
         YTPn/cUFBd4zpzQKroCpCkT+frvPS/198ug+RXJwyU2UtN/fHycR+hiUqFPWwrwURz5V
         V6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199555; x=1742804355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dmAl3f2a2eQALrDQqK+2x+vrO6J4Ix9fdjwK9KU9dg=;
        b=r5kHFH9iJaBmCZw7ulPhpKzuIXf2ddX3awYAIWuXg5xmwE/9ngy+J/yohI61xN0y1F
         gt1SwFPlyh+XcboGp77JmvitmWaRAw+UtA/I7MtKLiB3AJsJt9qdwgk6gFkducoI9q94
         YSf8Un6ZgdTtDB1/vYI/ysFMxCvygmgNiAnepqCsATv9vY0fKRTJCj8Qo9yTD17lWi7e
         hjqZPaV93qqHT4QEjgqLCMcyzp22Wru9O0u4W60JMabAnXou9FncBHOv6MUhz0mONRAc
         5/s3Wuj5WIz/z+VGuDDFBgHjGZ/S0QRzrFYv5T8LR37BeLUa9uvw6o6QSdzcBZi/KQBi
         rVag==
X-Forwarded-Encrypted: i=1; AJvYcCXRAVN+Jl/yUHs09MTA1kqp/9P90QyPYAAeVgzzpk+ezqJVjxlfw9K0IqQGaodyzZSvgckmf/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybFoQETbqOA31JnkGu82zVEEw2yJCkd2xmgIiLdjT1ympSn18
	ZYvWGo3psTfsXai+T4T7EhnT1TyOr8XCBairlw4Yn3yyR/j3iky4bhzT2ND680YfCoXlfKg8RKw
	6N7qm30SviA11Ws36DPctGXn0+VmEA66s4JJZ
X-Gm-Gg: ASbGncvdR898Sspzfmko3KgTCPpAfn3EJhpoR6f/reA3uBlGiDkM43x+KUqnA6jJWLw
	qsXXGILJCjBvtG9UNMi7lKHSpxaP5pUJ3y+4fgijBASbhiAbY/mwM0G4SPxPEM5QkPshaKyeHCW
	f1p81XBbJ883kRta4oJtYqL9mNPSM886tmJvwFVg==
X-Google-Smtp-Source: AGHT+IEzy2OwmJNbTR+LoL63WELKekffIl6f07YU6uyVtWxBMpwrlDuP9NJrtsxwFqMyzs0G5HunpMAE1csZ9MBVPn4=
X-Received: by 2002:ac8:5fcc:0:b0:476:a969:90d2 with SMTP id
 d75a77b69052e-476c81515c4mr153398991cf.26.1742199554797; Mon, 17 Mar 2025
 01:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316022706.91570-1-kerneljasonxing@gmail.com> <20250316022706.91570-2-kerneljasonxing@gmail.com>
In-Reply-To: <20250316022706.91570-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 09:19:03 +0100
X-Gm-Features: AQ5f1Josz2brwD4quZO-R6vvdTcPKXTxl2qqVLf43BuHp_BiXWmV0OR2gHzRuOE
Message-ID: <CANn89iJsZ4z50KWh22wZyRHUj9rF3ef4HbMvmKez2xHLT=UT2g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: support TCP_RTO_MIN_US for
 set/getsockopt use
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, horms@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 3:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Support adjusting RTO MIN for socket level by using setsockopt().


This changelog is small :/

You should clearly state that this option has no effect if the route
has a RTAX_RTO_MIN attribute set.

Also document what is the default socket value after a socket() system
call and/or accept() in the changelog.

>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  4 ++--
>  include/net/tcp.h                      |  2 +-
>  include/uapi/linux/tcp.h               |  1 +
>  net/ipv4/tcp.c                         | 16 +++++++++++++++-
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 054561f8dcae..5c63ab928b97 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1229,8 +1229,8 @@ tcp_pingpong_thresh - INTEGER
>  tcp_rto_min_us - INTEGER
>         Minimal TCP retransmission timeout (in microseconds). Note that t=
he
>         rto_min route option has the highest precedence for configuring t=
his
> -       setting, followed by the TCP_BPF_RTO_MIN socket option, followed =
by
> -       this tcp_rto_min_us sysctl.
> +       setting, followed by the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US socke=
t
> +       options, followed by this tcp_rto_min_us sysctl.
>
>         The recommended practice is to use a value less or equal to 20000=
0
>         microseconds.
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 7207c52b1fc9..6a7aab854b86 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -806,7 +806,7 @@ u32 tcp_delack_max(const struct sock *sk);
>  static inline u32 tcp_rto_min(const struct sock *sk)
>  {
>         const struct dst_entry *dst =3D __sk_dst_get(sk);
> -       u32 rto_min =3D inet_csk(sk)->icsk_rto_min;
> +       u32 rto_min =3D READ_ONCE(inet_csk(sk)->icsk_rto_min);
>
>         if (dst && dst_metric_locked(dst, RTAX_RTO_MIN))
>                 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 32a27b4a5020..b2476cf7058e 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -137,6 +137,7 @@ enum {
>
>  #define TCP_IS_MPTCP           43      /* Is MPTCP being used? */
>  #define TCP_RTO_MAX_MS         44      /* max rto time in ms */
> +#define TCP_RTO_MIN_US         45      /* min rto time in us */
>
>  #define TCP_REPAIR_ON          1
>  #define TCP_REPAIR_OFF         0
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 46951e749308..f2249d712fcc 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3352,7 +3352,7 @@ int tcp_disconnect(struct sock *sk, int flags)
>         icsk->icsk_probes_out =3D 0;
>         icsk->icsk_probes_tstamp =3D 0;
>         icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> -       icsk->icsk_rto_min =3D TCP_RTO_MIN;
> +       WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
>         icsk->icsk_delack_max =3D TCP_DELACK_MAX;
>         tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
>         tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
> @@ -3833,6 +3833,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                         return -EINVAL;
>                 WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies(v=
al));
>                 return 0;
> +       case TCP_RTO_MIN_US: {
> +               int rto_min =3D usecs_to_jiffies(val);

> +
> +               if (rto_min > TCP_RTO_MIN || rto_min < TCP_TIMEOUT_MIN)
> +                       return -EINVAL;
> +               WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
> +               return 0;
> +       }
>         }
>
>         sockopt_lock_sock(sk);
> @@ -4672,6 +4680,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>         case TCP_RTO_MAX_MS:
>                 val =3D jiffies_to_msecs(tcp_rto_max(sk));
>                 break;
> +       case TCP_RTO_MIN_US: {
> +               int rto_min =3D READ_ONCE(inet_csk(sk)->icsk_rto_min);
> +
> +               val =3D jiffies_to_usecs(rto_min);

Reuse val directly, no need for a temporary variable, there is no
fancy computation on it.

                   val =3D
jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_rto_min));
                   break;

> +               break;
> +       }
>         default:
>                 return -ENOPROTOOPT;
>         }
> --
> 2.43.5
>

