Return-Path: <netdev+bounces-71993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8918560F7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA6C1F21292
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470212AAC3;
	Thu, 15 Feb 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0A7bOSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8775127B6D
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995341; cv=none; b=LPbA1EFFcISc3dv7FkUrZ63NWzbq2C0HuIHJt5mkBu7Lh01GgzqHEI0uyey4Qkr8Oqv64ihFuXaozhUKkLSorj5JPZxfYQyj66J+7pZmy8jKc5fJCfD17Nv6ZIEmwez7ep9sjRpuO+bC/WYBdoPJoGXWlPii7wJLmOCX8qsFzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995341; c=relaxed/simple;
	bh=C8zDuNCtvAvOU/gsvl4Q6K/P9HsY4GAZgSvWntVfAxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmmNeTQt+xJwxV6C/G4f1Crol9ZnhXVZQZK87mhV3ycq2bCmbym9OLpHVroF0f7UFyXfeW7eD6bvr1qY7VdfJ2mmfsUV9AxSFvSW4GGusmRTlWQhrORVKdUa8dDYI+C16re6JUuRsrHjJaNkqr6vPNlj8jDHjQ1k5wsk1UG2ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0A7bOSG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so955970a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707995338; x=1708600138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WYqu1uGvpOq+dRkjJudJW22GWPChtm8s4VU+hAgVC8=;
        b=i0A7bOSGzC6hqFIdA0FW/XUEDXci0czeO1se7N/r/GhRRDE51qgoANgin8/l3ZP1rO
         X7OQRCmAOLk6HLzlre7qoQA853I2iEokN3J+QUs6hVUKsfs/4o1tirgm9NSb3YuEDyoU
         RSILMufmaJNmFSquGEG2gbWARg+9VnWTttEONYGwRXzp3DJutXCa4nPzIgTDLEcPzAvx
         WmSdjyiR+EM5yTaK73nCYHcdaAhu8mRCpMzocEGkPqrW8LJYIxVB/sGCog10d7ZZdIKb
         Niiho5bo13XfvLnqtntIuDsGRzH/lT22Z5pS/WzOFoyZAxT2WamRMfwOB1fWP0YfZDd6
         eaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707995338; x=1708600138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WYqu1uGvpOq+dRkjJudJW22GWPChtm8s4VU+hAgVC8=;
        b=tnEGZ4kMUIkVadmByW0oYYwaqNtYgliNFtN5Ef7QavL2GXELkE1jl8ZqYOguIul1cC
         t2A6600e8ca9IiMMdZHJY5cddrbZI3W1IVY3hqqmArs+bi1N2RY0l6qkuBfNEEr/Q3ZP
         BToVv4Gzmd8aFtIGSxw9sZW2iUo4x+uu+3bxVfjPoPczvB7Bq/qdMcAXqu76MsdGmV7e
         Vdf8vWD+5AkB9mTv9ORlOhOjvtsMAqZHVFWyfaKZKfbGTdqVTesekJfKYO9D1yEnwi9i
         XkNuowpchEpKF6zka16tdx5nxK8WhgASdZe/NKCO7nUES6q81YGcwRgVIna0hUvlfFZi
         zTrQ==
X-Gm-Message-State: AOJu0YzR3VDFI0t8zos4Ujz9ta7Y9n+VzY56zeycTWihrlMVXiE38wmd
	mVltqxm0NF6JjNO67vqd/x2h8RVytLRQ82ubgLb9g5BZw79sLkC1ueL8HGNcDv5UaX1Z1oyuViw
	bwK2NeenY+NXYrKFdbzriWaw+EU8=
X-Google-Smtp-Source: AGHT+IGVoyvGqjsIsW6jB8UzETJkce/xaAFHhNBg4FbEZTbKEEBIYi2oYp1uyvS1c3GpZF3j+vP0iVYjTLtVoLTLTAk=
X-Received: by 2002:aa7:d047:0:b0:55f:ec52:73c4 with SMTP id
 n7-20020aa7d047000000b0055fec5273c4mr1176947edo.34.1707995337623; Thu, 15 Feb
 2024 03:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215012027.11467-1-kerneljasonxing@gmail.com> <20240215012027.11467-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240215012027.11467-5-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Feb 2024 19:08:20 +0800
Message-ID: <CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/11] tcp: directly drop skb in cookie check
 for ipv6
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:20=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like previous patch does, only moving skb drop logical code to
> cookie_v6_check() for later refinement.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v5
> Link: https://lore.kernel.org/netdev/CANn89iKz7=3D1q7e8KY57Dn3ED7O=3DRCOf=
LxoHQKO4eNXnZa1OPWg@mail.gmail.com/
> 1. avoid duplication of these opt_skb tests/actions (Eric)
> ---
>  net/ipv6/syncookies.c |  4 ++++
>  net/ipv6/tcp_ipv6.c   | 11 ++++-------
>  2 files changed, 8 insertions(+), 7 deletions(-)
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
> index 57b25b1fc9d9..1ca4f11c3d6f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,16 +1653,13 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
>         if (sk->sk_state =3D=3D TCP_LISTEN) {
>                 struct sock *nsk =3D tcp_v6_cookie_check(sk, skb);
>
> -               if (!nsk)
> -                       goto discard;
> -
> -               if (nsk !=3D sk) {
> +               if (nsk && nsk !=3D sk) {
>                         if (tcp_child_process(sk, nsk, skb))
>                                 goto reset;
> -                       if (opt_skb)
> -                               __kfree_skb(opt_skb);
> -                       return 0;
>                 }
> +               if (opt_skb)
> +                       __kfree_skb(opt_skb);
> +               return 0;

Oops, the above lines went wrong, which could cause the error that
Paolo reported in my patch[0/11] email.

The error could happen when if:
    nsk !=3D NULL && nsk =3D=3D sk
it will return 0, which is against old behaviour :(

I will fix this...

>         } else
>                 sock_rps_save_rxhash(sk, skb);
>
> --
> 2.37.3
>

