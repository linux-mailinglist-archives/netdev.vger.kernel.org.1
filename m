Return-Path: <netdev+bounces-73719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986985E022
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCE528B186
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3F7E764;
	Wed, 21 Feb 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQQ60MSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234133D393
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526669; cv=none; b=LWJrHuJGhV9mwwoMR/lxPgKY1EhzrkXXstRy/GxffC1HpQM0+ejzZ8qhu5Jnly8dfOmPfz6Fp2sLb8LEWxuDjd0jVgVzILIJ8Rvn3B2lVxZamRlh2Eav/Ln+2MJlTZex4oLbQoJa6xT7FvXqbDcATtrzhKYqEErF2bdV5pbyBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526669; c=relaxed/simple;
	bh=g7u+DKzUlMMWdhzCCS5PCR/BztnqGnebUS7TQuexJmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vp41YKiT/PWTqpafEWGcd/uKpBYq9gl/ZS//yDMRuCJAl77InVQ9+6k4tpl3pkC+tkUyAdEJZtz/NGACMoRv3uMTr5eGWaOPRo6E7AVqGNuVzAqHXh41z5jm4z04+TyMZymb90v4u/sUHWuC3oJPoP3s9s/63+PVLhIcJw2PCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQQ60MSY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410acf9e776so64755e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708526666; x=1709131466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtdfXyTJZ9cnwrutt1Q746VnioNBSzYvrI+ZmsrAU1k=;
        b=OQQ60MSY3CylmfdnYbOH2voXFtZDYpdf/wYAPEKaIslCzTy5VmWHeYqqTGNcy/NkiC
         4OrY66bRDU2CnstyWZnm9Dw2FkCSBghGuhpKP1laNriZAe9IA1Li2ZxKcY5jgOMRxGaw
         KX4v7yxoTDpHLcVWR6SeZosaXrVj+FmWN0l4HX3JiQxY+zqPMdNgcyxNwccp+R5Ux8X+
         E8RqQ5HHj26FVzhtgG0KG/ljkYQvMAzQPoYL7AndCcy6BpVT4TL2gMU+nEROINWdpVyo
         02MaErAX9xxyKmhM0FxQ3dqe0VikBUV13ivGB/R4VdN3yd7v7gE6lEsFYaRyCiWLMQ/l
         GUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526666; x=1709131466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtdfXyTJZ9cnwrutt1Q746VnioNBSzYvrI+ZmsrAU1k=;
        b=YLiv0J3RnMVj+/T0lj35LQ68mJ3TE45TSotkMppqK0S3io3ZUIyees1WRDIE7/eYdB
         3OXdUsBgnLp+SUZSHJV5giOqJH5ylu3vm3KTCv0U8Rq8HbpUOM7Fqn5q7+X2OcPagnIr
         5f4SDgR3d7q+FrtvxuNO7UNUfZrMz1g8wjGJbxWebOq+bNcxrIi8KKkgk9uzznpkLqbg
         QWTY9ZrWqpQxddhBCut2qfMZ7XaSoxR8Bgjo2Ff8OBUONbpXIDnnkgWo/WNY5GCmT6dw
         qm+q4NofOx+aL+SnW2LNwxmc1vYiPLyGzzAIhfv46V9i7cc03PoJe9EcdPOvdn+Dhj/4
         c1yw==
X-Forwarded-Encrypted: i=1; AJvYcCXDFlnGvc/MDTyJHGIjre/AbGRUGv59vLkcUUNfZRxYnk0ex0hoIt+kwr8Fqh+r49bGHPuX3tKsIbeU4c8gAGHHRAOrKTlc
X-Gm-Message-State: AOJu0Yzlxq60BbVhnVXqRJOiy8zW3nf9sMzqRQGPN1BbrP6fZSkKK9Wx
	x5jWQNkHH/5RDEmcEFHL8xHTrHy+rikVuvnCCUhyxOR/HSkMNf6DDG1PXYNZQz2Ze2/v0HHZAZA
	0zmtW3aEsxSxFrauWsNuf0Jewnm9Sfvkq0Fvw
X-Google-Smtp-Source: AGHT+IG6iuKuFBiEG6wgOYcOmYEz+rtDWG7quWS51dAzvsiL+EhfaOSBS+JFSoL7ekcVmH7oXQj1NRhN1nomn5SUcsY=
X-Received: by 2002:a05:600c:3d08:b0:412:766a:3ba5 with SMTP id
 bh8-20020a05600c3d0800b00412766a3ba5mr114980wmb.6.1708526666209; Wed, 21 Feb
 2024 06:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-11-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-11-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 15:44:15 +0100
Message-ID: <CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/11] tcp: make dropreason in
 tcp_child_process() work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It's time to let it work right now. We've already prepared for this:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v7
> Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.co=
m/
> 1. adjust the related part of code only since patch [04/11] is changed.
> ---
>  net/ipv4/tcp_ipv4.c | 16 ++++++++++------
>  net/ipv6/tcp_ipv6.c | 20 +++++++++++++-------
>  2 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c79e25549972..c886c671fae9 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1917,7 +1917,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>                 if (!nsk)
>                         return 0;
>                 if (nsk !=3D sk) {
> -                       if (tcp_child_process(sk, nsk, skb)) {
> +                       reason =3D tcp_child_process(sk, nsk, skb);
> +                       if (reason) {
>                                 rsk =3D nsk;
>                                 goto reset;
>                         }
> @@ -2276,12 +2277,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
>                 if (nsk =3D=3D sk) {
>                         reqsk_put(req);
>                         tcp_v4_restore_cb(skb);
> -               } else if (tcp_child_process(sk, nsk, skb)) {
> -                       tcp_v4_send_reset(nsk, skb);
> -                       goto discard_and_relse;
>                 } else {
> -                       sock_put(sk);
> -                       return 0;
> +                       drop_reason =3D tcp_child_process(sk, nsk, skb);
> +                       if (drop_reason) {
> +                               tcp_v4_send_reset(nsk, skb);
> +                               goto discard_and_relse;
> +                       } else {

No need for else after a goto (or a return)

> +                               sock_put(sk);
> +                               return 0;
> +                       }
>                 }
>         }
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 4f8464e04b7f..f260c28e5b18 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1654,8 +1654,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
>
>                 if (nsk !=3D sk) {
> -                       if (nsk && tcp_child_process(sk, nsk, skb))
> -                               goto reset;
> +                       if (nsk) {
> +                               reason =3D tcp_child_process(sk, nsk, skb=
);
> +                               if (reason)
> +                                       goto reset;
> +                       }
>                         if (opt_skb)
>                                 __kfree_skb(opt_skb);
>                         return 0;
> @@ -1854,12 +1857,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_=
buff *skb)
>                 if (nsk =3D=3D sk) {
>                         reqsk_put(req);
>                         tcp_v6_restore_cb(skb);
> -               } else if (tcp_child_process(sk, nsk, skb)) {
> -                       tcp_v6_send_reset(nsk, skb);
> -                       goto discard_and_relse;
>                 } else {
> -                       sock_put(sk);
> -                       return 0;
> +                       drop_reason =3D tcp_child_process(sk, nsk, skb);
> +                       if (drop_reason) {
> +                               tcp_v6_send_reset(nsk, skb);
> +                               goto discard_and_relse;
> +                       } else {


 Same here

> +                               sock_put(sk);
> +                               return 0;
> +                       }
>                 }
>         }
>
> --
> 2.37.3
>

