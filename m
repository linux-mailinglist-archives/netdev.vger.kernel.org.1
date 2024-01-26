Return-Path: <netdev+bounces-66148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00783D821
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC62F28BF4A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566E1A29C;
	Fri, 26 Jan 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/yh3JDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD41BF4D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264042; cv=none; b=GUPSjYg1jivAmZWNjmRBCaBGQ1rjYUrzEHZO60+hmApmiAQcPuYdUDIsa+cnaswE2l0gmggqdryZpRAbCnVY34B55VFsNV7NSRElP0PnwZJ0Ae2ufCortQAl8UfIqmLHZjJVfCN1XTg0izAVj3def+v9efuntWC4EPnTvCmRd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264042; c=relaxed/simple;
	bh=7+8Qzhe6mHmLH6kd72kk3HmiTh9u8aRtYsmoWmyDwg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1rjaj8ue7AsH6JG0gR6XNEO3m7lgG4Y2YIN7SogxmzGN5A+fJMQ8grH+Mz0W7A1jTB6VfvYGEAA0s6XMKyejN3hluNweYPndIxklPmPDyx2pX+R+L+c8esVKS1XRrvbTVVefcURTsUUNv+LXC0hQdrFz2I3KbJ4gR2pkW+gbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/yh3JDd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11515a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706264039; x=1706868839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvqEquYt/bZVYH7bHyLPXtUBeFueS0MJ3q9sGV+6qNk=;
        b=r/yh3JDdBtmAF4TWcNuld0qWynjLfetXqeWvg89oHiiGPqJ/iTHfbYn24/sJ9fdMiM
         8icI0BbBZ++ibf1HJSrDUeoDUcWclR0Nt0CMnEhXLU4IvSFngyHiwXy/AkyUMKUT0lV3
         utiTN7OE6ZoHsxHHyXxVp+pCF8YtvyBUiaFpX4zfvOuR2aCNSZOE/8JKsWS1CGtjg2uH
         b+luLQwWkIjqpOBbHeSmUKnOLlDdnZJtpm1ljg7CaP+CIRn0+zVNHc8Gl2g1WaVnYu0O
         o2M7PmVL5TNeEsGJv1+oyEadmUD+MW9FID8kvQIpgZDPk5IkQCjdAbA04mqRJxayG5ax
         31wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706264039; x=1706868839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvqEquYt/bZVYH7bHyLPXtUBeFueS0MJ3q9sGV+6qNk=;
        b=CXwPg34VRtOGLyXgo0fl6FsClCvdKUc1OY02lgX8siWVO0BayUybylKAWtsMATxtkv
         H5PlDAJiW8ic+cfyXhA+SKwHOTb8T1+USFIBIPuX7p64GGO1whKMvDV+jrZqmBVLew0w
         M766rxKojXwrwLxaAfdb0gXpN2ddMLmaGZq1+L+8pfSTpalaZxAxtv5x3bA04c56AhFz
         RXcKtQnYdsGatwPR+UBJWDntUpBlOcqoDfElsG2dv2A3xSpGYJUxkJwzMlg1+1oetSYO
         iPw/3Sy7BXF/wvvQT8Q6K6ctJ9CHLvg7yWwSERhbMHsA9BQCTzHVK6Eq0wSBQSvAfaRv
         uaFw==
X-Gm-Message-State: AOJu0YzIt22uFnLC4tWPn92z8gIJuOHRktC8eEBPtW8HudIWo4TY9xn3
	lsRgqlOFm5sofFqeQsh72JsUfiPe9C9+l0ZSd28ng4Yo8foDezsr+xS/p1zjKhJuNcs5qN+Aq0v
	SzG6KI5K+BCA60hDxWLsA3SCcI4vofF3wWZB6
X-Google-Smtp-Source: AGHT+IEMEhpxf4J9tTeaGOXnw61oDRUQSFt9uZf+HhtkSJBGuheZqdh/y4uxkchX1z1aJT3Ly1bE9HhF0DZixf8sltw=
X-Received: by 2002:a05:6402:3092:b0:55c:2493:2b31 with SMTP id
 de18-20020a056402309200b0055c24932b31mr86268edb.3.1706264038379; Fri, 26 Jan
 2024 02:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126075127.2825068-1-alexious@zju.edu.cn>
In-Reply-To: <20240126075127.2825068-1-alexious@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jan 2024 11:13:44 +0100
Message-ID: <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:51=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> When inetdev_valid_mtu fails, cork->opt should be freed if it is
> allocated in ip_setup_cork. Otherwise there could be a memleak.
>
> Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  net/ipv4/ip_output.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b06f678b03a1..3215ea07d398 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1282,6 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct in=
et_cork *cork,
>  {
>         struct ip_options_rcu *opt;
>         struct rtable *rt;
> +       int free_opt =3D 0;
>
>         rt =3D *rtp;
>         if (unlikely(!rt))
> @@ -1297,6 +1298,7 @@ static int ip_setup_cork(struct sock *sk, struct in=
et_cork *cork,
>                                             sk->sk_allocation);
>                         if (unlikely(!cork->opt))
>                                 return -ENOBUFS;
> +                       free_opt =3D 1;
>                 }
>                 memcpy(cork->opt, &opt->opt, sizeof(struct ip_options) + =
opt->opt.optlen);
>                 cork->flags |=3D IPCORK_OPT;
> @@ -1306,8 +1308,13 @@ static int ip_setup_cork(struct sock *sk, struct i=
net_cork *cork,
>         cork->fragsize =3D ip_sk_use_pmtu(sk) ?
>                          dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
>
> -       if (!inetdev_valid_mtu(cork->fragsize))
> +       if (!inetdev_valid_mtu(cork->fragsize)) {
> +               if (opt && free_opt) {
> +                       kfree(cork->opt);
> +                       cork->opt =3D NULL;
> +               }
>                 return -ENETUNREACH;
> +       }
>
>         cork->gso_size =3D ipc->gso_size;
>
> --
> 2.34.1
>

What about something simpler like :

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b06f678b03a19b806fd14764a4caad60caf02919..41537d18eecfd6e1163aacc35e0=
47c22468e04e6
100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1287,6 +1287,12 @@ static int ip_setup_cork(struct sock *sk,
struct inet_cork *cork,
        if (unlikely(!rt))
                return -EFAULT;

+       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
+                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+
+       if (!inetdev_valid_mtu(cork->fragsize))
+               return -ENETUNREACH;
+
        /*
         * setup for corking.
         */
@@ -1303,12 +1309,6 @@ static int ip_setup_cork(struct sock *sk,
struct inet_cork *cork,
                cork->addr =3D ipc->addr;
        }

-       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
-                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
-
-       if (!inetdev_valid_mtu(cork->fragsize))
-               return -ENETUNREACH;
-
        cork->gso_size =3D ipc->gso_size;

        cork->dst =3D &rt->dst;

