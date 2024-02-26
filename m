Return-Path: <netdev+bounces-74801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253FB86687B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE18E280C08
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD23101D5;
	Mon, 26 Feb 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC9+i748"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB4DF58
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916734; cv=none; b=jr+cS1KiK7QDw8uzZOzXtJBAQJBROH/wgK9El7CrXiSCx2rXqxOc0PPi6RQcAvXsfwyD9lzkSoIhq6As/zBX6R/un5GfoGUTZsSON82X1y/t+/TZozs4N6wg0u2FjlhEFYDBR/OFYlzbO8QkgrBCYfcvAeRw7VMed6OYljVN0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916734; c=relaxed/simple;
	bh=fEJSN6x3n29NHazIwfGkrzjIFG03nnOvc5d5fdqlpM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdxEyC01lkld6U04jMuPO48wfIMLXyuN5KuXGeSyLFns2hxzNkrWV4w8+guNCqpEmeJN3psdTtWZaxa6iYvAboyEGrT3hh4uwG1nf0iAe4loG03bfAEMyJ0MNZvh2/ijILKlqcJLx5HPSkOFpYFSKTKNiwOmhO4kxSHcaxpkOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC9+i748; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so516308a12.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708916731; x=1709521531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvbiMtCpLI39EpPQmi/rVfStuUXnBqhA//jhMWNH7Ek=;
        b=nC9+i748L5bfGYwzLNf/tGWTL0D+LsgHPfz8cWZMPyQV+7dsMtGvFaf3u5RttBJc2e
         KEcikve+xUblv+tq1asPH+FVXh38qEepWtWMO9ZfYqNQ6lJql1dZPgehn5GsHnQ5b5Of
         XqZMYhzpp5ZM0aqZyk3QYpDTvfpIoqm1+NG1nLIUPQ7B4SQwIaKg5zSxuAQUdjz//JBH
         C5YgqYGGWW1hQ5BjPRYtqzQtfJg5LNkxR5+1eay/fhUTY/YSNihmrdnS5QVIlDUY+azQ
         oJyKwQ6Z3VJVXux5lee8MT4AlGuv90blx9RN0bOhv3KPVlo5fm/qgGEENATgTXPg+kCD
         Gcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916731; x=1709521531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvbiMtCpLI39EpPQmi/rVfStuUXnBqhA//jhMWNH7Ek=;
        b=Ho6DD5tJ80Zxx2mIGrB5GW2S3yxng/gHNToVcJphiElbgjGQ+I470kqT6YtLPxrrE7
         rEpreiFOZhKzqMPHRBArmtra2McFPdDvsE5+doJ40kIQRW/zbSoypF6tie4gQWrwYDzq
         3imsejyNf0si1lhV6GCHA7ssM0xzXdHPLVXD0W1o0pZfxZPgoBvDyyPtjl/ZV0HlCa86
         bZk4AcGZvDaOYGzUisjzZF4nplqRu7+QGRxhmMW5ykHbt/ZiPQucrn8u98A3lgbFg0ec
         A4lBLaUN+Uu7Qy0kP4oZUVxH6HfDE3nICkGHx7/mL0MOo6Wk4zJr2hRiqmBYajIVc5D4
         GqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCULp2Ktja/wziu1x6yRVAHJQRZDLwQttN3UzPOylt+PtFBMdODdV+zspb9k+WdH7s5Lx8HiNDjyvSSVjYckrQYlREV5+HNd
X-Gm-Message-State: AOJu0Yw2lqmPcKYi3PZqsTD3Pd6M4/zNn2NGErlEDuqDxierRZx3YFDb
	FBv3L/cRUwWPUKn3DiZkFodnVmt3ELe5sjV/W1bo8ngNICD6N32FlpN+qE/WdUQbez5xgwF0ERu
	dKws1jQj4LnJDsFdkJ0lsBSnjt+U=
X-Google-Smtp-Source: AGHT+IGaa0qI+LdcaJ8L+ZJNIqFnJlmcGWdrGvZsSVphPWPgdaADKav3vLBgf/ilvPZYvnRnYAOELI45WkzzfCLtx1w=
X-Received: by 2002:a17:906:2e95:b0:a43:6864:d0a1 with SMTP id
 o21-20020a1709062e9500b00a436864d0a1mr356816eji.76.1708916730710; Sun, 25 Feb
 2024 19:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223102851.83749-10-kerneljasonxing@gmail.com> <20240223194445.7537-1-kuniyu@amazon.com>
In-Reply-To: <20240223194445.7537-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 26 Feb 2024 11:04:54 +0800
Message-ID: <CAL+tcoCAQADGDYNTaVGG1AOzjp3rr-YzmwPTRQpuTUQN3G2few@mail.gmail.com>
Subject: Re: [PATCH net-next v9 09/10] tcp: make the dropreason really work
 when calling tcp_rcv_state_process()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 3:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 23 Feb 2024 18:28:50 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Update three callers including both ipv4 and ipv6 and let the dropreaso=
n
> > mechanism work in reality.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> two nits below.

My bad :( Unfortunately, until now, I know why every time I have to
encounter such an indentation problem. I set ts =3D 4 in my config file
of VIM...

Will update it in the next version soon.

Thanks,
Jason

>
>
> > --
> > v9
> > Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fd=
a1@kernel.org/
> > 1. add reviewed-by tag (David)
> >
> > v8
> > Link: https://lore.kernel.org/netdev/CANn89i+Uikp=3DNvB7SVQpYnX-2FqJrH3=
hWw3sV0XpVcC55MiNUg@mail.gmail.com/
> > 1. add reviewed-by tag (Eric)
> > ---
> >  include/net/tcp.h        | 2 +-
> >  net/ipv4/tcp_ipv4.c      | 3 ++-
> >  net/ipv4/tcp_minisocks.c | 9 +++++----
> >  net/ipv6/tcp_ipv6.c      | 3 ++-
> >  4 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e5af9a5b411b..1d9b2a766b5e 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struc=
t inet_timewait_sock *tw,
> >  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
> >                          struct request_sock *req, bool fastopen,
> >                          bool *lost_race);
> > -int tcp_child_process(struct sock *parent, struct sock *child,
> > +enum skb_drop_reason tcp_child_process(struct sock *parent, struct soc=
k *child,
> >                     struct sk_buff *skb);
>
> Please fix indentation here,
>
>
> >  void tcp_enter_loss(struct sock *sk);
> >  void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int n=
ewly_lost, int flag);
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 0a944e109088..c79e25549972 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1926,7 +1926,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >       } else
> >               sock_rps_save_rxhash(sk, skb);
> >
> > -     if (tcp_rcv_state_process(sk, skb)) {
> > +     reason =3D tcp_rcv_state_process(sk, skb);
> > +     if (reason) {
> >               rsk =3D sk;
> >               goto reset;
> >       }
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index 9e85f2a0bddd..08d5b48540ea 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -911,11 +911,12 @@ EXPORT_SYMBOL(tcp_check_req);
> >   * be created.
> >   */
> >
> > -int tcp_child_process(struct sock *parent, struct sock *child,
> > +enum skb_drop_reason
> > +tcp_child_process(struct sock *parent, struct sock *child,
> >                     struct sk_buff *skb)
>
> and here.
>
>
> >       __releases(&((child)->sk_lock.slock))
> >  {
> > -     int ret =3D 0;
> > +     enum skb_drop_reason reason =3D SKB_NOT_DROPPED_YET;
> >       int state =3D child->sk_state;
> >
> >       /* record sk_napi_id and sk_rx_queue_mapping of child. */
> > @@ -923,7 +924,7 @@ int tcp_child_process(struct sock *parent, struct s=
ock *child,
> >
> >       tcp_segs_in(tcp_sk(child), skb);
> >       if (!sock_owned_by_user(child)) {
> > -             ret =3D tcp_rcv_state_process(child, skb);
> > +             reason =3D tcp_rcv_state_process(child, skb);
> >               /* Wakeup parent, send SIGIO */
> >               if (state =3D=3D TCP_SYN_RECV && child->sk_state !=3D sta=
te)
> >                       parent->sk_data_ready(parent);
> > @@ -937,6 +938,6 @@ int tcp_child_process(struct sock *parent, struct s=
ock *child,
> >
> >       bh_unlock_sock(child);
> >       sock_put(child);
> > -     return ret;
> > +     return reason;
> >  }
> >  EXPORT_SYMBOL(tcp_child_process);
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 0c180bb8187f..4f8464e04b7f 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1663,7 +1663,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >       } else
> >               sock_rps_save_rxhash(sk, skb);
> >
> > -     if (tcp_rcv_state_process(sk, skb))
> > +     reason =3D tcp_rcv_state_process(sk, skb);
> > +     if (reason)
> >               goto reset;
> >       if (opt_skb)
> >               goto ipv6_pktoptions;
> > --
> > 2.37.3
> >

