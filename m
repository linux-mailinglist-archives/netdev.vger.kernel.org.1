Return-Path: <netdev+bounces-231562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E039BFA996
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D313A7B26
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074402F9DBB;
	Wed, 22 Oct 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUY/wzPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52A2F617D
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118579; cv=none; b=HN8jpyhhJ4j0BOAczAPKB7w9BkH4pD+gXIuDTzKbBYaqKiDqossXXGAgLny/MeU++ZHwLPLYvCrAvYX8Fa7l/6M1NKnKACwzeOE6HSHyxQHOSrJinCnoRSsG8Yb6Myo83lfJJ6NsfASU7elfHyED4OyDMM8o8Ixef0z+Du7gIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118579; c=relaxed/simple;
	bh=HtL0aGay5CU8yJyT2Iu8i0PDBnx2pTOwklzMoFah6lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2vhVGCKJEgSN+7du8LyHc6UDCJahQuZETxVOM5swXsTtsXlISheCVUEr/n0VDi6+kUR3ChEAtooCg2RrCArixJz0/Qmgij5/f2FBbHA3OtR4ybn0zyVedGbfxzM1ihFHjlxojOtGTQ1M64kUOtFQh4DOuWrlL1EVvXbIc3jHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUY/wzPi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d4d421f6so51299025ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761118578; x=1761723378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne8X6oQ4TY+MTpe6fx1BsCXP/E1vxBBg8ZkVw63H44g=;
        b=uUY/wzPifgUsJFUghCJryyQaEuc6ihbjoqkj6Wkcqzd1/nrYhrL4eIr+4Un9uJs5z3
         fEMwkIBT/rGMMXaLONqULUCRot4M+tiRTBn4mZVSNpfl8g/w4wVMPovgvilM3ZubqYz9
         m1wieEl+be7LC2nrn8jXhXlhNnNwejhHSNotWEJDgtvVRgt9rjWIFygOzi0J1MeSTs0F
         p/Dc4mi9PMI0d+4mdVIpplQD1Gg0WQ5r9LkzcqWNlbDjPCK0vZ96w4pkUY+pOp7gF3KG
         uc5xlVZYdDbMbW5hpmysJ8aqgebAxyTuUzw6N0wZFU9q03ItESYdChqjolr933FVMKf7
         lxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118578; x=1761723378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne8X6oQ4TY+MTpe6fx1BsCXP/E1vxBBg8ZkVw63H44g=;
        b=YqM5M25wMYVPC0ai5wA1PXNT4X2DchpeAKYnCmJxqNLAosd5s2U7t188XaBvjPr9yr
         WDX6ceW8zod2sYPP71xZgpu39WUPzkSC2LTmWFIaDv0EjEe4eRT8G0gQlkJVZYyc5Y+B
         KfUIDsyISmjMZ/DrH1sW2wjPKefUv+1zBviAZRpQz/YpGH/sm5J0AoGdMRg5t2G9JZ0O
         tgrp2v67tj5SqBmjxUToPLS752oPztysl5rWm70QeuMENFR8DF5kNSpEO+dMroaHmWSm
         W51rUpCWVBLuHumiQ5/15LYKzjcLJyONDPwBcKfqXGHIcHP5Ue3EeXTLDgK7pJufKZJH
         K32Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpnA+5ZyrS1TX9fT5NuHgW8gQL8xdT1GhmCgWwjM3P2j7rQaRBl4gNHVcoD8Tg5mrYK4VROzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXbv01jJNmCZ6gAb52Zc7GC8kJciup2oevPigqSvfPtAEDmeM
	SEGoUyJV9RBtgAW4Z6BwFu98cJ+6uffksrC3xmWzNi4b5rFK4tD8bdEejkGkC5JFD9WqJlBXg+Z
	W1Uk4ZFJ/t3jAXG7rPMePk2DC4yzmvjlGae1c/wX4
X-Gm-Gg: ASbGncu9jcF2i4fLh2r6VQdbjP2ULC5sWdjOl2sJ+M1vA+otKKGNAOKNrabCiSOomJh
	rsKUv2xsNlc6xWIOP4XU+XNm2VOWXzRGyeFN7OXBNOh8S90T+VkQ1rVckb9kX2jP3tCpk4pJuX9
	OHPGCtZzu4Fj3NgjSSeIjXut9dCC68oPxwT8ZRQL2LZ83kI5jYdyHbG1+HaZka11r9gVPx14kFl
	eq1whUkSPrp06jGwPyXEOqDPS1NFs8QE1DgDV0hTYqyBDdRBfYPY4Ls0Jx9c5NKQ01iny/I8Zoz
	tMp8HbWlbDLKOBS5Gw==
X-Google-Smtp-Source: AGHT+IF46vH0gAmljTCW6BchroEOcDOXkUgTIvPI2YZtYG9N39bSh/pHYkEmo3qgB6WjMhviNr012jnggIGiG1snhbI=
X-Received: by 2002:a17:902:e74a:b0:267:776b:a315 with SMTP id
 d9443c01a7336-290caf844ddmr249836795ad.32.1761118577438; Wed, 22 Oct 2025
 00:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com> <20251021214422.1941691-8-kuniyu@google.com>
In-Reply-To: <20251021214422.1941691-8-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 00:36:05 -0700
X-Gm-Features: AS18NWBKLOhVXyIMHsuYPqRGPiGNf1_PCd92__b5F-phGX71rLqYea5U9RwDCTA
Message-ID: <CAAVpQUAxenM9_MRAo3z5ChFnr3-DN8yq+mR2xC4+ceuOaSL3=A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_do_peeloff() calls sock_create() to allocate and initialise
> struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
> and sctp_sock_migrate() overwrite most fields.
>
> What sctp_do_peeloff() does is more like accept().
>
> Let's use sock_create_lite() and sctp_clone_sock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/sctp/socket.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 826f17747f176..60d3e340dfeda 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -5671,11 +5671,11 @@ static int sctp_getsockopt_autoclose(struct sock =
*sk, int len, char __user *optv
>
>  /* Helper routine to branch off an association to a new socket.  */
>  static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
> -               struct socket **sockp)
> +                          struct socket **sockp)
>  {
>         struct sctp_association *asoc =3D sctp_id2assoc(sk, id);
> -       struct sctp_sock *sp =3D sctp_sk(sk);
>         struct socket *sock;
> +       struct sock *newsk;
>         int err =3D 0;
>
>         /* Do not peel off from one netns to another one. */
> @@ -5691,30 +5691,24 @@ static int sctp_do_peeloff(struct sock *sk, sctp_=
assoc_t id,
>         if (!sctp_style(sk, UDP))
>                 return -EINVAL;
>
> -       /* Create a new socket.  */
> -       err =3D sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, =
&sock);
> -       if (err < 0)
> +       err =3D sock_create_lite(sk->sk_family, SOCK_SEQPACKET, IPPROTO_S=
CTP, &sock);
> +       if (err)
>                 return err;
>
> -       sctp_copy_sock(sock->sk, sk, asoc);
> -
> -       /* Make peeled-off sockets more like 1-1 accepted sockets.
> -        * Set the daddr and initialize id to something more random and a=
lso
> -        * copy over any ip options.
> -        */
> -       sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
> -       sp->pf->copy_ip_options(sk, sock->sk);
> -
> -       /* Populate the fields of the newsk from the oldsk and migrate th=
e
> -        * asoc to the newsk.
> -        */
> -       err =3D sctp_sock_migrate(sk, sock->sk, asoc,
> -                               SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
> -       if (err) {
> +       newsk =3D sctp_clone_sock(sk, asoc, SCTP_SOCKET_UDP_HIGH_BANDWIDT=
H);
> +       if (IS_ERR(newsk)) {
>                 sock_release(sock);
> -               sock =3D NULL;
> +               *sockp =3D NULL;
> +               return PTR_ERR(newsk);
>         }
>
> +       lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
> +       __inet_accept(sk->sk_socket, sock, newsk);

Oh I assumed __inet_accept() was exported to MPTCP,
but it's built-in, and SCTP=3Dm needs this.

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 77f6ae0fc231..ffd4d75d0a7a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -788,6 +788,7 @@ void __inet_accept(struct socket *sock, struct
socket *newsock, struct sock *new

  newsock->state =3D SS_CONNECTED;
 }
+EXPORT_SYMBOL(__inet_accept);

 /*
  * Accept a pending connection. The TCP layer now gives BSD semantics.

--
pw-bot: cr

