Return-Path: <netdev+bounces-190500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2307AB7174
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F817D446
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989C278E60;
	Wed, 14 May 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xr8D7gC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A61B040B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240407; cv=none; b=nDka7JLtkUtiPd76eP1cqbtgjjqpKTQFpe+gcyoG9vP4XAss1mVsC0vF+RiLVJ1WjrklF6/PEc9CAfi6UqqEpruirxKazd11L3XDm9AuMs9Abv+7J18xEvmxoQAJ/GNteGZM2ooq1svc1HZDcOx0jMpFsjM1tpUas7KJ5Z28oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240407; c=relaxed/simple;
	bh=aN+rnFOSdvfxkAXI+G9iur3QXg0oyC1gMvypEMd3EiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4vEAc504yP+DC52aPXFFIYZuYyF9V77i5T+8hVWeJfVVbL4ivK6CSMFp0dJZzY7VZ8IsYV0iOK9MLAxrcEVESPQHJRn34LAWX5HkqVpSu/7JOfndR4uGsmET3MaTpWD4RDiiattH6InGHWK0GPF5X3t62bdGwjWeysiiT1K5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xr8D7gC1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4772f48f516so13165171cf.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747240405; x=1747845205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTr0b0obTtw9ojP0R3nWphlHo+UEF4QOrw/NKMGl+sk=;
        b=xr8D7gC1ZNe07Y2SzrgNcjmIc9qAK0xCjyEC4fU7Wad4xurehu+oi1SuyTThuRQOuD
         hBnc9hhbwvqvK/iWy4n3aaT8Uw0PhzGKi9f+FGSb9hlhffb6Rf7vkaAAlK7JTgqaCgQ0
         vv927qsy38uWbQXKSCgU3czbbspXnCtgy31XYIQiDqoR2NBFLnrrs9OqBzcAY4ibkIxe
         eafnnACsv851foLkme6aysDNI3hpn1fqeCCch5uF+5KXS7ovKQttp47Qd5QavgM2InK5
         S4qqAAtX63Tgq+iC3jIZ5jOnsdm1owDOp3OHadoA/4eBH67kqahLUnnJpxSCGzdXBlN9
         08Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240405; x=1747845205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTr0b0obTtw9ojP0R3nWphlHo+UEF4QOrw/NKMGl+sk=;
        b=sIzoVUAFr5Kt/OX5cjDWJmBeEYXVBrS6Q6QRDo9MbyaKluHr/614FRtltIjU4xOSk5
         STQMzXpbVgriNZLSeeIgNBIh18+7VQlaQ0YugkCDQGN5C6yc83+w7j1OHp1z6ucO5d5e
         7DFvxh1fufzbTYvYnvREhn1LwnbpRyhcZR9/vPrNf9ihP2qo/d0G5sknrY/7PtqlvQw9
         n4y7V7jXEJHy2D/fVcdLfp+Q+kd0w34RI24gtOLs4r1m9eIqfdsJ6qw2pQ/iH+gq07u/
         TuXd4VOpDccdMC02ghR3a1aUV3Fw44kb15cLiDxRZnyLkv1sr5ZNw4SFzcqMLbaB3frg
         AV0w==
X-Forwarded-Encrypted: i=1; AJvYcCX2qW9NK2x7r8LsoQKEP72KSuzTNO1ianfDZ+4FsEqO2ZPYbR+LU9nk+6CItTNap/DBgM1NKWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+7GksKr/wBiUeFr6/e5IZCcBQnGKAyAePEwHwveRo1s9cI7J
	mALsTLzXiHErBC0J3m2VpLSHq4XibGf33lcxiCkzB2jym3DRMNBYTQga6TQfM8ZsxYpP/2/ABDg
	eRA6SVOvV0dByv+rBSjDynAMZ3fnqUWmVcm5RRIsv
X-Gm-Gg: ASbGncs0B71a8WZupBfDOWue6o/0hzyWpsVAqZGSlOA3dWD47zpo2x/dmCDAqUN5nY+
	ngGOlpwPnxBWcV62Vh0p63tTj+baevY0rh6rBcV4wY8Tu3iZr7zt2wnVX6KMtBxwW/aq8LjINIQ
	/LfQPOpjzldl0hJyihuTfoUcvEL0cj6Dg6Rg==
X-Google-Smtp-Source: AGHT+IHb/oV51+C8bHw3ZmuIYuK5a7WXuGVTrV+d0RyX6JVGCSghs3TfMaF2nT0BqI4n3GXPuMxOoRdxvnQ9GGeUkII=
X-Received: by 2002:ac8:580a:0:b0:494:7043:8a2 with SMTP id
 d75a77b69052e-494a0e2e15bmr2650691cf.16.1747240404582; Wed, 14 May 2025
 09:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com> <20250513193919.1089692-2-edumazet@google.com>
 <51c7b462-500c-4c8b-92eb-d9ebae8bbe42@kernel.org> <CANn89iK3n=iCQ5z3ScMvSR5_J=oxaXhrS=JF2fzALuAfeZHoEA@mail.gmail.com>
 <a9ecd6a0-74da-4f68-81ec-5c2d5b937926@kernel.org>
In-Reply-To: <a9ecd6a0-74da-4f68-81ec-5c2d5b937926@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 May 2025 09:33:12 -0700
X-Gm-Features: AX0GCFv_-XNxDRGreezLb1JSwMwuKBM4xRHlbRamHRnqZgMLTWabCkXq18f1giA
Message-ID: <CANn89iJCzRA-i1R57txita9F9c74gvXX0R-eOXTNTMcRJJCoMw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/11] tcp: add tcp_rcvbuf_grow() tracepoint
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Rick Jones <jonesrick@google.com>, 
	Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 8:46=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 5/14/25 9:38 AM, Eric Dumazet wrote:
> > On Wed, May 14, 2025 at 8:30=E2=80=AFAM David Ahern <dsahern@kernel.org=
> wrote:
> >>
> >> On 5/13/25 1:39 PM, Eric Dumazet wrote:
> >>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>> index a35018e2d0ba27b14d0b59d3728f7181b1a51161..88beb6d0f7b5981e65937=
a6727a1111fd341335b 100644
> >>> --- a/net/ipv4/tcp_input.c
> >>> +++ b/net/ipv4/tcp_input.c
> >>> @@ -769,6 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
> >>>       if (copied <=3D tp->rcvq_space.space)
> >>>               goto new_measure;
> >>>
> >>> +     trace_tcp_rcvbuf_grow(sk, time);
> >>
> >> tracepoints typically take on the name of the function. Patch 2 moves =
a
> >> lot of logic from tcp_rcv_space_adjust to tcp_rcvbuf_grow but does not
> >> move this tracepoint into it. For sake of consistency, why not do that=
 -
> >> and add this patch after the code move?
> >
> > Prior value is needed in the tracepoint, but in patch 2, I call
> > tcp_rcvbuf_grow() after it is overwritten.
> >
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8ec92dec321a..6bfbe9005fdb 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -744,12 +744,16 @@ static inline void tcp_rcv_rtt_measure_ts(struct
> sock *sk,
>         }
>  }
>
> -static void tcp_rcvbuf_grow(struct sock *sk)
> +static void tcp_rcvbuf_grow(struct sock *sk, int time, int copied)
>  {
>         const struct net *net =3D sock_net(sk);
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         int rcvwin, rcvbuf, cap;
>
> +       trace_tcp_rcvbuf_grow(sk, time);
> +
> +       tp->rcvq_space.space =3D copied;
> +
>         if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
>             (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
>                 return;
> @@ -794,11 +798,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>         if (copied <=3D tp->rcvq_space.space)
>                 goto new_measure;
>
> -       trace_tcp_rcvbuf_grow(sk, time);
> -
> -       tp->rcvq_space.space =3D copied;

I think I prefer leaving this write here, instead of having to go to
tcp_rcvbuf_grow(()

> -
> -       tcp_rcvbuf_grow(sk);
> +       tcp_rcvbuf_grow(sk, time, copied);
>
>  new_measure:
>         tp->rcvq_space.seq =3D tp->copied_seq;
>

