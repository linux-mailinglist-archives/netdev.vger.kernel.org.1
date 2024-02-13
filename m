Return-Path: <netdev+bounces-71444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093FD8534A8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B74C1C22C41
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E85DF3A;
	Tue, 13 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hy6kIPWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A5224D5
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838228; cv=none; b=m0zt2uqTyoOnqpAx+cpm8Z+ZyZ9gKWkmn2kiCPCJTkZdDoxioqOoenRLkzkD6sKOywbTgoAdNNeeY3yWoYVQa6FD+5egT5KHZKrxzDdAQx8jo5iveMDUCs909aaAGqUkS2cVDfruQ4DpNl0UmAUm91xdbpeKP3L4snPvsxhp1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838228; c=relaxed/simple;
	bh=CAgXvg+i/K0CkvSR8o0JD3Gct53CdAOwuR+4hxXpBto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5109ZQ/Baw+tyfpBJE9YPa2MydrNdbe9fCCsSvoChymV2UhAkgFGhTliutyB9q2h0Xc8wcKyhUWYL6rFS1tWatn3K5pXFvPz8ZcbKDazMFbn4Z+Kw06HXYwSdsZ2Ja8LWrtjhyyBm/H95mt8BXbZmRJ6YB6y3IqkiFb0g/5INI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hy6kIPWD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso10800a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707838225; x=1708443025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfpESeG3wb4XI2bDfml3Sycrz8PTOoZrzom6MqvzqqQ=;
        b=Hy6kIPWD2dzzxDHnPbtaq1lNoS6lBmjct7KlkYZnM+t3caJqxOwP+a/04mXNfL5WCO
         gOiZd9IbQbLGCc/vXEY4C4L9iHZFkPZwSfXyw0Uq1sm9KkVfvw+C8+jmD+tLrWu762ND
         DYVonGNM3oOynMsRQRWjOlKHov34Hrut0SnvX9vBvKwI6IQGB0ew5wcxPlCSxIuZhCpy
         GoQ4wFrDnF3ARjhsnArFZnVoWxSR8LGv6vy8QWPfuMtuuxJF0tEwzA7Cf8Ninaj0QR+r
         vaZ9ogj1ejCzRNhbmpXkEnrYsTDfYk+hS6Rs4SxnNI0b2hLW+hPc9SQb8Xql3t12wiWj
         yIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838225; x=1708443025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfpESeG3wb4XI2bDfml3Sycrz8PTOoZrzom6MqvzqqQ=;
        b=T22CcEuOrUIGvijWE6mB24Flc9g4/fH0QEFaoGFhKqaNnDPOltBsySHsFPZ2nn8nUJ
         uJBXRmvKXROoOR8uLLwx72+h62fdGX2rc8hqDuwikQ5FJKTWExY+6yBdGyIl8rJGWaWT
         V9asUMvy+FatZInpeol+oVkMlumVgO1cCYTkLafcnP9N0pvhcnHcXZoz9EX8u+XIQwfn
         r//ttqgQ4B8Vvg1+P1h2gKlzCHMgYhHdPWGKSbvU0VSX8D0+2n5Z70GQMzHuyf/5VT2d
         w1sEnkBx7S0ol9txW7P5qY+cPNe6TNokyHFkPfVfianJJIb7y6NxYxo2Mcp1SIv8DUPh
         c60w==
X-Forwarded-Encrypted: i=1; AJvYcCWF29Z3mGTzBcRC7oZBFX+1IjYoVGVX21t/VbWfS9V2zPQCU9yOWF24X2v/NBiDY4oRwaShx2BDWGrOBSbsPtouxGJs2p5z
X-Gm-Message-State: AOJu0YxyPCSpE564X1UwUBLH+utYlLRNF8XGwNIwe1h4rBtKSXjxryj/
	nBmNDV07hQR/pqGPBEUMM9U7YFctuYfKsddIjSDEAXwkryKGW/W/9MaGpd1DyobmtxPgnoIgboS
	yGssLwqzb/VH5K+F0E4j1PuN8juccY4uR/vCC
X-Google-Smtp-Source: AGHT+IFov3mt7ShIxh0fHF+NVdeD4a7/PexM1R8RJXKbywG7S/6niUTbPFlUnoK2DgHQCFdIQwg33BCRv2zu5/hSXjg=
X-Received: by 2002:a50:9b5e:0:b0:55f:8851:d03b with SMTP id
 a30-20020a509b5e000000b0055f8851d03bmr136452edj.5.1707838224645; Tue, 13 Feb
 2024 07:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134205.8705-1-kerneljasonxing@gmail.com> <20240213134205.8705-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240213134205.8705-5-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 16:30:13 +0100
Message-ID: <CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/5] tcp: directly drop skb in cookie check
 for ipv6
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like previous patch does, only moving skb drop logical code to
> cookie_v6_check() for later refinement.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv6/syncookies.c | 4 ++++
>  net/ipv6/tcp_ipv6.c   | 7 +++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 6b9c69278819..ea0d9954a29f 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>         struct sock *ret =3D sk;
>         __u8 rcv_wscale;
>         int full_space;
> +       SKB_DR(reason);
>
>         if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
>             !th->ack || th->rst)
> @@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
>         ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);
>
>         ret =3D tcp_get_cookie_sock(sk, skb, req, dst);
> +       if (!ret)
> +               goto out_drop;
>  out:
>         return ret;
>  out_free:
>         reqsk_free(req);
>  out_drop:
> +       kfree_skb_reason(skb, reason);
>         return NULL;
>  }
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 57b25b1fc9d9..27639ffcae2f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
>
> -               if (!nsk)
> -                       goto discard;
> +               if (!nsk) {
> +                       if (opt_skb)
> +                               __kfree_skb(opt_skb);
> +                       return 0;
> +               }
>
>                 if (nsk !=3D sk) {
>                         if (tcp_child_process(sk, nsk, skb))
> --

or perhaps try to avoid duplication of these opt_skb tests/actions.

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9d529e3c53778ef09b65b1ac4c9d5..1ca4f11c3d6f3af2a0148f0e50d=
fea96b8ba3a53
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,16 +1653,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *=
skb)
        if (sk->sk_state =3D=3D TCP_LISTEN) {
                struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);

-               if (!nsk)
-                       goto discard;
-
-               if (nsk !=3D sk) {
+               if (nsk && nsk !=3D sk) {
                        if (tcp_child_process(sk, nsk, skb))
                                goto reset;
-                       if (opt_skb)
-                               __kfree_skb(opt_skb);
-                       return 0;
                }
+               if (opt_skb)
+                       __kfree_skb(opt_skb);
+               return 0;
        } else
                sock_rps_save_rxhash(sk, skb);

