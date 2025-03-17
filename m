Return-Path: <netdev+bounces-175288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62BA64DE2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CECA1887261
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58E2356B4;
	Mon, 17 Mar 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiIQMXAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEE2E3373
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213090; cv=none; b=qqmsYna0TmBLnjOJHF4uqvD7pyE/cxC/fHM9QlmJfbq5dEEIFkjejV7u2XaFwKxrn92gWja/U6qwyqxgAuai0vzdy9Hm3Goqfliq0f5OIeiatEwkMdQ7FEgJNBuxH5VoDbtJX6jDox+5XLB2b5WfOhXV3T2Yoo5VUHXY7FdsCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213090; c=relaxed/simple;
	bh=odjvZkipRLUSspyFF/vVKAHmRTdQhzSizmVEClYKgdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8Mvb8U8CFbTwFIloHP8NMu4cAc+AZhHuITR5RdKEJuSxlP/OL/dwPqhd0+x73LzEdPvItjEOmqoQ4kOqGlrEQlPYV0H4AFAteDENtsqlPoGth28phkfJCLgEG4WIysNCTzPanD89n6/ZkKOBeb7uODKtYv8HhbW+PEES70L37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiIQMXAK; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b515e4521so134257939f.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213088; x=1742817888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe0hSM3H1Me77b5ZcoQVlEdfaDMPbAGK1KiZ4OC+WlU=;
        b=AiIQMXAKxyPMl2q+3xoNCSIjgS/5WvqyRv+Jsq5KXR6ZhggRjpKgqPm9IKmYHNGxrP
         iHA0hH7ZiJXBwg6MmxzB9yR41t6BJhc5GpfKvFtFLWMbV3WO5sJz9rUUGhSiN0GW8YWz
         bes+RY53DJL6J5UIv35ITKdBRsqzex6nvM9280Rtos/cbpoluQwaYgPjbb3qp/oRoXtS
         eiVxB+BRjv+Kruzdm86NGCK2FNhJrVc4rkmh7oTvNqrdkdjvcn8o5wlKs0MfnUvpg7Eh
         Z2l4NlfS8+ro7t8luVTTu/W6jk9sIMs4JJ8qQhzor7E4qYhjL98KHrDEhv+WOfRUrpu+
         FA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213088; x=1742817888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe0hSM3H1Me77b5ZcoQVlEdfaDMPbAGK1KiZ4OC+WlU=;
        b=nFUkzfT77h1zSSWFWBMHMPECMPdnGiuR8dI0q/k9QeJzng19IulXGigJr6EkHyZtBf
         ICRotx2TWwkhhCF+sDcgW8BMVBfV6XwcP9yAyBhted2nN2ITR6Ip2pj94M3xVJum7lFV
         +pKib6nT+SacfVpKsPdKeOJn3IuAAP4hWn1qAOqsp07wn55gvzOuPw0L44h5bcHDhHmu
         /goRy7q5styCFA0WR9IYJ7cFjPC8Yanu9n2+ot1kLHmigHVQpU0TY7GHghdLJGLXTKNp
         +N6Xao2ZCXsx8HKNYrOdBfhRs+JNsZxw6PkoGoywAzF9A5g2DxGGtXF3Vljqkvc673ty
         O5uw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5rD5J0PXRggLgP3eYqSrsUMr3cNKBME/X/KixWxgjTadcAqQ1VDhBuNWMrxpVIaxISbSxyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPGXaw/CLMTt8rzx9Eh6wdv2d34Y9xVrGcE/q5ZpZbU+nhQoG
	jaSUphP4IJPT/sGEizP1fFL5AI5w9MiGFFVanoJx8MpXl45USGVeoZ/lCz8mEy+N9lMlRDfnkm4
	kBXazh1jjKfh6R0RN5iFWfXuHsx4=
X-Gm-Gg: ASbGnctqz/oSVfDfcTHNmoEHkxzbrxGQyZTuy0MoemRaPr+tQfbvmb/Ugc6wi+knTN1
	vyMVOQT/Mz6IyJ43hj/Wa8cw4TJyzmTymc/RUNAeQ3hLIwoZhi4RzMz6Um3aryJhqEKOW5hLSBp
	BbfBczyHZZJBGmQAw+utFCqCRiXw==
X-Google-Smtp-Source: AGHT+IEYY4NgD37UP4PgzWnsNwsh1osKCl3ZZ78ovs6to60vNU3UTsSr4j++EYbA3XCT5YVCxgbH30VzCIxxuCmHyx4=
X-Received: by 2002:a05:6e02:3b88:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3d483a09c27mr140359385ab.7.1742213088069; Mon, 17 Mar 2025
 05:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316022706.91570-1-kerneljasonxing@gmail.com>
 <20250316022706.91570-2-kerneljasonxing@gmail.com> <CANn89iJsZ4z50KWh22wZyRHUj9rF3ef4HbMvmKez2xHLT=UT2g@mail.gmail.com>
In-Reply-To: <CANn89iJsZ4z50KWh22wZyRHUj9rF3ef4HbMvmKez2xHLT=UT2g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Mar 2025 20:04:10 +0800
X-Gm-Features: AQ5f1JrAc0m1JVZG03T6ydzmHe-FPsIp5SAPTrO2QeQ9iKsS-tT16rb0x4LxYzk
Message-ID: <CAL+tcoB0gitCLZ_JvjK79FYnaxQXzXYM+Os3Nv1TVB30BnRFyA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: support TCP_RTO_MIN_US for
 set/getsockopt use
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, horms@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Mar 16, 2025 at 3:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Support adjusting RTO MIN for socket level by using setsockopt().
>
>
> This changelog is small :/
>
> You should clearly state that this option has no effect if the route
> has a RTAX_RTO_MIN attribute set.
>
> Also document what is the default socket value after a socket() system
> call and/or accept() in the changelog.

Thanks for the review.

Will do it in another patch as well.

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst |  4 ++--
> >  include/net/tcp.h                      |  2 +-
> >  include/uapi/linux/tcp.h               |  1 +
> >  net/ipv4/tcp.c                         | 16 +++++++++++++++-
> >  4 files changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 054561f8dcae..5c63ab928b97 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -1229,8 +1229,8 @@ tcp_pingpong_thresh - INTEGER
> >  tcp_rto_min_us - INTEGER
> >         Minimal TCP retransmission timeout (in microseconds). Note that=
 the
> >         rto_min route option has the highest precedence for configuring=
 this
> > -       setting, followed by the TCP_BPF_RTO_MIN socket option, followe=
d by
> > -       this tcp_rto_min_us sysctl.
> > +       setting, followed by the TCP_BPF_RTO_MIN and TCP_RTO_MIN_US soc=
ket
> > +       options, followed by this tcp_rto_min_us sysctl.
> >
> >         The recommended practice is to use a value less or equal to 200=
000
> >         microseconds.
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 7207c52b1fc9..6a7aab854b86 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -806,7 +806,7 @@ u32 tcp_delack_max(const struct sock *sk);
> >  static inline u32 tcp_rto_min(const struct sock *sk)
> >  {
> >         const struct dst_entry *dst =3D __sk_dst_get(sk);
> > -       u32 rto_min =3D inet_csk(sk)->icsk_rto_min;
> > +       u32 rto_min =3D READ_ONCE(inet_csk(sk)->icsk_rto_min);
> >
> >         if (dst && dst_metric_locked(dst, RTAX_RTO_MIN))
> >                 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> > diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> > index 32a27b4a5020..b2476cf7058e 100644
> > --- a/include/uapi/linux/tcp.h
> > +++ b/include/uapi/linux/tcp.h
> > @@ -137,6 +137,7 @@ enum {
> >
> >  #define TCP_IS_MPTCP           43      /* Is MPTCP being used? */
> >  #define TCP_RTO_MAX_MS         44      /* max rto time in ms */
> > +#define TCP_RTO_MIN_US         45      /* min rto time in us */
> >
> >  #define TCP_REPAIR_ON          1
> >  #define TCP_REPAIR_OFF         0
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 46951e749308..f2249d712fcc 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -3352,7 +3352,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> >         icsk->icsk_probes_out =3D 0;
> >         icsk->icsk_probes_tstamp =3D 0;
> >         icsk->icsk_rto =3D TCP_TIMEOUT_INIT;
> > -       icsk->icsk_rto_min =3D TCP_RTO_MIN;
> > +       WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
> >         icsk->icsk_delack_max =3D TCP_DELACK_MAX;
> >         tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
> >         tcp_snd_cwnd_set(tp, TCP_INIT_CWND);
> > @@ -3833,6 +3833,14 @@ int do_tcp_setsockopt(struct sock *sk, int level=
, int optname,
> >                         return -EINVAL;
> >                 WRITE_ONCE(inet_csk(sk)->icsk_rto_max, msecs_to_jiffies=
(val));
> >                 return 0;
> > +       case TCP_RTO_MIN_US: {
> > +               int rto_min =3D usecs_to_jiffies(val);
>
> > +
> > +               if (rto_min > TCP_RTO_MIN || rto_min < TCP_TIMEOUT_MIN)
> > +                       return -EINVAL;
> > +               WRITE_ONCE(inet_csk(sk)->icsk_rto_min, rto_min);
> > +               return 0;
> > +       }
> >         }
> >
> >         sockopt_lock_sock(sk);
> > @@ -4672,6 +4680,12 @@ int do_tcp_getsockopt(struct sock *sk, int level=
,
> >         case TCP_RTO_MAX_MS:
> >                 val =3D jiffies_to_msecs(tcp_rto_max(sk));
> >                 break;
> > +       case TCP_RTO_MIN_US: {
> > +               int rto_min =3D READ_ONCE(inet_csk(sk)->icsk_rto_min);
> > +
> > +               val =3D jiffies_to_usecs(rto_min);
>
> Reuse val directly, no need for a temporary variable, there is no
> fancy computation on it.
>
>                    val =3D
> jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_rto_min));
>                    break;
>

Thanks, I will handle it.

Thanks,
Jason

> > +               break;
> > +       }
> >         default:
> >                 return -ENOPROTOOPT;
> >         }
> > --
> > 2.43.5
> >

