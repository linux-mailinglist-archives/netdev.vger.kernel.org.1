Return-Path: <netdev+bounces-215952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA40B311A0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C771BC083A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B72E7F00;
	Fri, 22 Aug 2025 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2903OFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2F2E9EA4
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850730; cv=none; b=EH1YuKZT+KuVw1HROHqNLGBuXyb7cRfW234NCqAofHYR0Pj3rxhXNptChAYii54oLgc9yv46hr+edDw+H4Ns8dHaNw43P3uq1IfMn3Z9Z55Yps5kcWJaZJpRO/Y5erAKPvhty9d22OOVJwXp8j/O3dtmpg32HHTz70lF6jZ/z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850730; c=relaxed/simple;
	bh=XdPnd5liO0cA2Uj6Oiyo6rkFEhMd338Di5J5OD0egBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGOgPGiIQgppryBs7kmBny+3oxI2kqmqVNFoUjmDhUEUvQW0ehgVwKnlAmbs6yEEHPgrd2nJY6fY1IVoRgoBtg4P3E5mXxTsFRINpuMv51PoqdMgoUamhDnVULrqRFAC5gnROBLLGiCy2Rhsh1/4UpO3YNukFEl+IYEh87evr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2903OFX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109914034so20968961cf.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755850727; x=1756455527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY1DEXGfk48IHs74ixQpt4xvVtHayEVJfhW2iPPz6qo=;
        b=P2903OFXZDVQwXJ6akJ+v367jebCikR+/Fl/plELZzfGF8mfJ2I+/L7paHQiLIUxI4
         XU5n4XSHKm6CxCUbztKvDSmVfV8p4wuOfUqWYadUhAbf6G6RvuWJ9/3ju3bxmgMTJMQC
         C7wu8wJBfwU0/dlwj94RJm+bFG8W3JROLp82fROzjdCVw2XtFdlG6lqdbj/YnY45C6Po
         0GQovwEkCdyIugEe9pyEDTYznK31aW6shOS7Q/9F75m4YVVqTTowGKMWbN+EZrJBHw7W
         ECHlBPFnDv8zxWbOxVicATzjpSBjapfL0BUeJw/5xacpSMtNAoBkpjGjAkuAtGqWMHuL
         Jdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850727; x=1756455527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY1DEXGfk48IHs74ixQpt4xvVtHayEVJfhW2iPPz6qo=;
        b=bp8EkIXqu8dOuwnTzrB0PHswjnrHM06m9teN3Xmoe1NmnmIBIsa6127PWraaQwCApF
         obmBICkGtr5JJHWa0BzAxeulR0gRyEM3T5VK1PyY1UUdO/hnVVlgUYO9BgZVWxZEwj9D
         jkg4Y8rJXo43yhJeJ7U+AXMdab8SOHpoRvb3B5fhXX41L/5kiA5cGUejobZ1p3bov5M4
         vkUOkn5txhAWLNsxZ7JSo8Nhr8MNttoMcIbo0QpahWzqdFMGev4fdx1nxip5123dbtcK
         0j1m5iozPL4nGIvwAXLaIMmOH5iA0KSaIzdol5vuUuHboa/AYLkaqElU4t6dXbACSOxb
         BUWQ==
X-Gm-Message-State: AOJu0YxO7czUWom5DC0fRv6dR6F/t69yMpukf9+D1DlQhTi8nvTZh9w4
	Dpm3E4lLrPB8GCyVnN+NH72mGfZYZxMeWGUo44cYLiqvjBSNcT2HgUexNmP1LiISexcodm+DUbG
	7F0vbz1EhC9mtcj3Z2HobWZR+trz0ABXAvURpgZ5/H7oGFnwKFHRb3Ycfdno=
X-Gm-Gg: ASbGncv8RhRoHgn3oghMcQysIom3UkP1AYnODws0qahUUUNb2ElXstlhYD5tXrqMk3Z
	Cpo3vbbw8MpGpEse8AlIHfLIvzRp1VHQzww722exy51Tor6jCdnrwLvLk6Ko+qA7I5Z+1JB3T0u
	kzi1QnAAO2RtKRLASDFF+jaQvmSrpNYznHnca8NZTif7eXHDPUkinToelL/Bcclp3vbwuKtLTUR
	k/4zVvGFEsToiM=
X-Google-Smtp-Source: AGHT+IHASA82Ty0/GOFeGfXrFJzqGeYeYUzwYHoP2Hs/WGyJgr+9NVCstvlo8pb7THljJrNujqCsNn0PbsaW5YYTQKM=
X-Received: by 2002:ac8:5791:0:b0:4b2:a7e6:a074 with SMTP id
 d75a77b69052e-4b2aaa55fd7mr25330581cf.12.1755850726988; Fri, 22 Aug 2025
 01:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgnLcw6yzq78CIP@bzorp3>
In-Reply-To: <aKgnLcw6yzq78CIP@bzorp3>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 01:18:36 -0700
X-Gm-Features: Ac12FXymy--oG3rm9I-k_H0MJYpec2H_OAKpI-HdYV4QxN_suBh-qYeyVoJNCaE
Message-ID: <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:15=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> Hi,
>
> There's this patch from 2018:
>
> commit 6b229cf77d683f634f0edd876c6d1015402303ad
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Dec 8 11:41:56 2016 -0800
>
>     udp: add batching to udp_rmem_release()
>
> This patch is delaying updates to the current size of the socket buffer
> (sk->sk_rmem_alloc) to avoid a cache ping-pong between the network receiv=
e
> path and the user-space process.
>
> This change in particular causes an issue for us in our use-case:
>
> +       if (likely(partial)) {
> +               up->forward_deficit +=3D size;
> +               size =3D up->forward_deficit;
> +               if (size < (sk->sk_rcvbuf >> 2) &&
> +                   !skb_queue_empty(&sk->sk_receive_queue))
> +                       return;
> +       } else {
> +               size +=3D up->forward_deficit;
> +       }
> +       up->forward_deficit =3D 0;
>
> The condition above uses "sk->sk_rcvbuf >> 2" as a trigger when the updat=
e is
> done to the counter.
>
> In our case (syslog receive path via udp), socket buffers are generally
> tuned up (in the order of 32MB or even more, I have seen 256MB as well), =
as
> the senders can generate spikes in their traffic and a lot of senders sen=
d
> to the same port. Due to latencies, sometimes these buffers take MBs of d=
ata
> before the user-space process even has a chance to consume them.
>


This seems very high usage for a single UDP socket.

Have you tried SO_REUSEPORT to spread incoming packets to more sockets
(and possibly more threads) ?


> If we were talking about video or voice streams sent over UDP, the curren=
t
> behaviour makes a lot of sense: upon the very first drop, also drop
> subsequent packets until things recover.
>
> However in the case of syslog, every message is an isolated datapoint and
> subsequent packets are not related at all.
>
> Due to this batching, the kernel always "overestimates" how full the rece=
ive
> buffer is.
>
> Instead of using 25% of the receive buffer, couldn't we use a different
> trigger mechanism? These are my thoughts:
>   1) simple packet counter, if the datagrams are small, byte based estima=
tes
>      can vary in number of packets (which ultimately drives the overhead =
here)
>   2) limit the byte based limit to 64k-128k or so, is we might be in the =
MBs
>      range with typical buffer sizes.
>
> Both of these solutions should improve UDP syslog data loss on reception =
and
> still amortize the modification overhead (e.g.  cache ping pong) of
> sk->sk_rmem_alloc.
>
> Here's a POC patch that implements the 2nd solution, but I think I would
> prefer the first one.
>
> Feedback welcome.
>
> diff --git a/include/net/udp.h b/include/net/udp.h
> index e2af3bda90c9..222c0267af17 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -284,13 +284,18 @@ INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_b=
uff *));
>  struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>                                   netdev_features_t features, bool is_ipv=
6);
>
> +static inline int udp_lib_forward_threshold(struct sock *sk)
> +{
> +       return min(sk->sk_rcvbuf >> 2, 65536);
> +}
> +
>  static inline void udp_lib_init_sock(struct sock *sk)
>  {
>         struct udp_sock *up =3D udp_sk(sk);
>
>         skb_queue_head_init(&up->reader_queue);
>         INIT_HLIST_NODE(&up->tunnel_list);
> -       up->forward_threshold =3D sk->sk_rcvbuf >> 2;
> +       up->forward_threshold =3D udp_lib_forward_threshold(sk);
>         set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>  }
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index cc3ce0f762ec..00647213db86 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2953,7 +2953,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, =
int optname,
>                 if (optname =3D=3D SO_RCVBUF || optname =3D=3D SO_RCVBUFF=
ORCE) {
>                         sockopt_lock_sock(sk);
>                         /* paired with READ_ONCE in udp_rmem_release() */
> -                       WRITE_ONCE(up->forward_threshold, sk->sk_rcvbuf >=
> 2);
> +                       WRITE_ONCE(up->forward_threshold, udp_lib_forward=
_threshold(sk));
>                         sockopt_release_sock(sk);
>                 }
>                 return err;
>
> I am happy to submit a proper patch if this is something feasible. Thank =
you.
>
> --
> Bazsi
> Happy Logging!

