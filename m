Return-Path: <netdev+bounces-73589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E661085D3BC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158A11C22AD6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489333D0DA;
	Wed, 21 Feb 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wgso6MVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F73D0AF
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508102; cv=none; b=m5GPQO08islNZOXbCebdwnENn13IZ+8gJPNzJzSKwC6nKmdFKeOGB4l7CrFAkxAqUA19CkV5+a4Na69XMJ/GUWe5149BLzMfFUDMf58OsSoDpo830WFm05oN3hQnrmGsBZnYWvStrms/Flm5sLvd1AXM1jGhR+n8XJS40wT5CXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508102; c=relaxed/simple;
	bh=KRQ0Y5PAifeEkZWuWYGD1nnZzD2uy9YX4tDLIlsiBrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBDzGL2T3Y9b2+oNE3FMYI3EolIqsLEJR8d+EOk/k/+VY64Z3LbZBMuHhyX0Pp21swQ6XWffLUtC5uoHpkOgclwkKl9+ddFdQmQKhDG+E7Tp9I7jdnC8HASLl7Dyxe8J+upISEKkZt8332dEomkoxbe6xMQkqwNFiNTB1zVgx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wgso6MVR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564f176a4d5so9139a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708508099; x=1709112899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHIbT0SpRlsNqB62jfvQK8H9basgP7hEZbBF5kvKiz0=;
        b=Wgso6MVRNBJhbv+bZE4eQZ9d5dahcjjrOb5tD7o4q2ovA2JgbGl4VxbDUW1S4knIxJ
         R6L9Ou71ZEUXL2evjBkiFydBwjumTGYLDzEOv4Ao4RLCGbTc23n3Ulz/SaN1pJnP95/0
         UoXXUuSVcmPgnQR0Yfu4CnwdsuL2WWNcv3F33ejN0iGCKJX63WipOphjS/K7lrH7SHpM
         xmLYrUxeSyNbcNRW2TeXqsQsTe9F9UC0ChHkXS3MGTq/h2ImPtfyuYqlWxqYDYRFAlN3
         MutTf6z2zCfW/akxveQHKyg5yj/DmktxPnWSmdHqKRxpw3EN6aFcbzXd0dchQ9aUQlMw
         lONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508099; x=1709112899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHIbT0SpRlsNqB62jfvQK8H9basgP7hEZbBF5kvKiz0=;
        b=iIlqEBwIbbOXj6DMcms4lqUzY3W0qtZOBApmieJywgSr98dvW8oadgLZJ2q3OfChse
         iAkaTF8MayPoU3amp/YmFnnyUEOFOVBinbO6TxycSlAbHZGgY6LzwikhU2BpwsXvi50b
         MgGs/i9EozfAOV9y4iAp1ys/tirrRyrEzJ3KIENe/rNGde828x3WK7SmCjWCmnRl5Gw5
         f2U4RUG1E5aJeaJZaguc+5S0GGEx8pLlgYsfc4clpMIA3LoAOwJ4vKL9GygK2GG0twjm
         75f/L1XhqO6dZhqPs+Sz+EqoI0KOBtZaMPQRyEkklkBM8LVHyjmq6EUFaDLuiaUKtiYl
         4/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVxzrXBkVVH0vOqzgLRQEJkt7+7zmP4mfAA2XzUCWbW76QTUnvO6Ac9Y+NdjLAinO+EiDjwqJKlDnC2O9qD7ZLJFzZCCJ
X-Gm-Message-State: AOJu0Ywn5HjYclSDmwL7QbJg0eMEAv7PnGb9M+wbVA/4N2WbHKRtb+0A
	SH61hCRy6U3w6/6EiRdlIsfEhfKrmLL1y2u1tlaHigkruWa7bakFaveZiT2A7KDwhr0sf4Eh3Dc
	KOr9IH9X2jJq+RMhZ6tsegcGFV+6jiTtz0Cuc
X-Google-Smtp-Source: AGHT+IEbiJqgGzX7PGTmxHdKtFs/SjUQhe+NvUfQ3Dnpe2AAnvsq0X8tB4409yC2H7EYdCHIfNH2Qo7w24hysWvRRt0=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr8117edb.3.1708508098650; Wed, 21 Feb
 2024 01:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:34:47 +0100
Message-ID: <CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com>
Subject: Re: [PATCH net-next v7 03/11] tcp: use drop reasons in cookie check
 for ipv4
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:57=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Now it's time to use the prepared definitions to refine this part.
> Four reasons used might enough for now, I think.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v6:
> Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon=
.com/
> 1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
> an indicator which can be used as three kinds of cases to tell people tha=
t we're
> unable to get a valid one. It's a relatively general reason like what we =
did
> to TCP_FLAGS.
> Any better ideas/suggestions are welcome :)
>
> v5:
> Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=3DJkneEEM=
=3DnAj-28eNtcOCkwQjw@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c=
@kernel.org/
> 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (E=
ric, David)
> 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket alloca=
tion (Eric)
> 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> ---
>  net/ipv4/syncookies.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 38f331da6677..1028429c78a5 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>                 if (IS_ERR(req))
>                         goto out;
>         }
> -       if (!req)
> +       if (!req) {
> +               SKB_DR_SET(reason, NO_SOCKET);
>                 goto out_drop;
> +       }
>
>         ireq =3D inet_rsk(req);
>
> @@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>          */
>         RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
>
> -       if (security_inet_conn_request(sk, skb, req))
> +       if (security_inet_conn_request(sk, skb, req)) {
> +               SKB_DR_SET(reason, SECURITY_HOOK);
>                 goto out_free;
> +       }
>
>         tcp_ao_syncookie(sk, skb, req, AF_INET);
>
> @@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>                            ireq->ir_loc_addr, th->source, th->dest, sk->s=
k_uid);
>         security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
>         rt =3D ip_route_output_key(net, &fl4);
> -       if (IS_ERR(rt))
> +       if (IS_ERR(rt)) {
> +               SKB_DR_SET(reason, IP_OUTNOROUTES);
>                 goto out_free;
> +       }
>
>         /* Try to redo what tcp_v4_send_synack did. */
>         req->rsk_window_clamp =3D tp->window_clamp ? :dst_metric(&rt->dst=
, RTAX_WINDOW);
> @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
>         /* ip_queue_xmit() depends on our flow being setup
>          * Normal sockets get it right from inet_csk_route_child_sock()
>          */
> -       if (ret)
> +       if (ret) {
>                 inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
> -       else
> +       } else {
> +               SKB_DR_SET(reason, NO_SOCKET);
>                 goto out_drop;
> +       }

You can avoid the else here

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index be88bf586ff9ffba2190a1fd60a1ed3ce5f73d06..d56b0e309cfc0a58dcd277881fe=
2b364ab3cc668
100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -475,8 +475,11 @@ struct sock *cookie_v4_check(struct sock *sk,
struct sk_buff *skb)
        /* ip_queue_xmit() depends on our flow being setup
         * Normal sockets get it right from inet_csk_route_child_sock()
         */
-       if (ret)
-               inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
+       if (!ret) {
+               SKB_DR_SET(reason, NO_SOCKET);
+               goto out_drop;
+       }
+       inet_sk(ret)->cork.fl.u.ip4 =3D fl4;
 out:
        return ret;
 out_free:

