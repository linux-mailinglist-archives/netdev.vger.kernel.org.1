Return-Path: <netdev+bounces-221985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A98B528B6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491F41B24865
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBC258EFE;
	Thu, 11 Sep 2025 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OahNIQX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E8258EFC
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572097; cv=none; b=t+WM1tWCcA+im8ee2931BCljXV2/BeIdfPITmaY3yDd3j6Y3XU7pRhkOolCc1U2GgTfZJd1Bv2AmWPP5k6O6hAxT49+HDh7T0N5DTpLaR7MaRPBD3tnm2irI1kHoBlXQ0DF0YygN+VBM5PVfq8F8tWvYOdWluQgOfK39U4um6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572097; c=relaxed/simple;
	bh=PYYYHKVI2ZCj3jiGDJkBZlGHGxQvadVvf0ams7WO248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+cUMllGDJhc8FKMPWzkbg0xUzTLNQAiWvbLjXpeoqJeAdD3PZZ8JCBV1rySz7RwOojMDOkVNy3xZhDFdIK4G0m18M5NqQ+ShI5/3W2ex4dl0l2Ln8lPmJh4ts5zeRPw8FrZlcTYlnBptnTNPvpmVl6VuJ50eeDjUTNwWrLAMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OahNIQX9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5fbd77f40so6347151cf.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757572094; x=1758176894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMGemrsW7qB9nbokjD+kiZDh99c/IOwJ1pIkwa8saew=;
        b=OahNIQX95GjO488JIQ9kDZJA9i/R0W+vRzDILTnDduujozTDSw+QfTcU1p3PQkyCat
         y+/Ujjln/SU96hdqujnubFNF4rZLWFsldGk5ZC/ERTn6sjNFOXw/Zc9gCKopd3CHc/Ay
         iQZiD7xPAMKuQbsMiCp1A6hT8FqmLfhZ5WP2ocGLVbteegtV7+8X6rm8ozAZDe0eHd8c
         Voi2wMsGRlRFPY2492/F03m48Du1z3Mgo8sQkxGYlV1XsDaqzzznXJ44vKcUYm0G1Fmr
         NjrsHnELpFx4BugcpKYiFSxREexSyl8A6O4EC083V219iiIBI21AFLo8atFwO8Z6+2S6
         gFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572094; x=1758176894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMGemrsW7qB9nbokjD+kiZDh99c/IOwJ1pIkwa8saew=;
        b=Hw+L65oKc23LF596OJNzJxsWB7l3sDBFM7rJFT49MPcguOT6D706yUTa+Hgu7yncN+
         w+cJjF2mL7yI2iVMjEcOmafn8rYmQcjYaFOBSoDRsW3O3c+rDoLF0HnbdbVpNycIYk00
         X9MvFUT7T0V5NKD9z2yKEBFJg+N9fesdVzhv6USLSAmTJTzCVXLiBe55KNErUMNMKpkj
         wgVIOxnFRJWQWt6L7Sd/NbNm+XHbT5VmyAuvKewP5SSm1JWLkUuCvg+h+LaAASg/Yu++
         1CDtk0oEq3HxhT3SzRn7itt1rYfGWt3/2uUUvqd67uTuxjUIoAuaz/WZaAAzQzmxM9kC
         qtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR4WOX8XLgaccfPxoUp2qdtP2MWhQi4cMRTVhAaa9g0Bo3aMSxyHgQY9Trkr/oE9IHfOhZxB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJPRxPrye7bsvn6/Do9CuBbRwt71oXU+mXwjiD9nc3j9X/R5L
	mx0s+cpmigaJKTRiqAwJmTdQEFjdA7c5H39muzq1UkzZL4j21GAyQAEtafx/uBMP25OxxSEh7SR
	5BwTeFBiGffsqwiyUV2v7FLT7rEure57cZTCTVsID
X-Gm-Gg: ASbGncvsN0dIcUqgs4Ttj1rxj1MAyB5GCvJrP1BGfRS2ibhWKdwMdmlV4y+cqyr8/CM
	ynbrf4YZ0EyUxNAdQeAVdYA6Fqcvi0FirQy1MmwpZU4OZsI4VjZFfwNjOrV16q1LYFDiMS40hUy
	eDdWvDAtR3LlDscooAaeAk1f/b0KHBx6m873sb0diUpgrWU9lELtwJSp5LdstMWSgDaK8B0FTcK
	KijrzHz0CoCag==
X-Google-Smtp-Source: AGHT+IGB4DzA1ONkuieK4tE8d7qBDPQD1iYeYDx3QJeuGanmEIHDEPSQoryRYvLwYsmH4tPlogrITTVL9lVbld2YDKY=
X-Received: by 2002:a05:622a:1a01:b0:4b6:3451:a159 with SMTP id
 d75a77b69052e-4b63451a529mr33808471cf.49.1757572094177; Wed, 10 Sep 2025
 23:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-4-kuniyu@google.com>
In-Reply-To: <20250911030620.1284754-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Sep 2025 23:28:03 -0700
X-Gm-Features: Ac12FXwR8ra9wnevSW8dPVtUKRamLyQO8o_pYPKOF0cDtBQTXWrF7xRP7KtuMX4
Message-ID: <CANn89i+Z5X5eEDVyAAEayLK60ziAeAs4ynwzw8XLe9bWy9GDUw@mail.gmail.com>
Subject: Re: [PATCH v1 net 3/8] smc: Use sk_dst_dev_rcu() in in smc_clc_prfx_set().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> smc_clc_prfx_set() is called during connect() and not under RCU
> nor RTNL.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use sk_dst_get_rcu() under rcu_read_lock() after
> kernel_getsockname().
>
> While at it, we change the 1st arg of smc_clc_prfx_set[46]_rcu()
> not to touch dst there.
>
> Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> Cc: Dust Li <dust.li@linux.alibaba.com>
> Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Cc: Tony Lu <tonylu@linux.alibaba.com>
> Cc: Wen Gu <guwen@linux.alibaba.com>
> Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> ---
>  net/smc/smc_clc.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 08be56dfb3f2..9aa1d75d3079 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -509,10 +509,10 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_ms=
g_hdr *clcm, bool check_trl)
>  }
>
>  /* find ipv4 addr on device and get the prefix len, fill CLC proposal ms=
g */
> -static int smc_clc_prfx_set4_rcu(struct dst_entry *dst, __be32 ipv4,
> +static int smc_clc_prfx_set4_rcu(struct net_device *dev, __be32 ipv4,
>                                  struct smc_clc_msg_proposal_prefix *prop=
)
>  {
> -       struct in_device *in_dev =3D __in_dev_get_rcu(dst->dev);
> +       struct in_device *in_dev =3D __in_dev_get_rcu(dev);
>         const struct in_ifaddr *ifa;
>
>         if (!in_dev)
> @@ -530,12 +530,12 @@ static int smc_clc_prfx_set4_rcu(struct dst_entry *=
dst, __be32 ipv4,
>  }
>
>  /* fill CLC proposal msg with ipv6 prefixes from device */
> -static int smc_clc_prfx_set6_rcu(struct dst_entry *dst,
> +static int smc_clc_prfx_set6_rcu(struct net_device *dev,
>                                  struct smc_clc_msg_proposal_prefix *prop=
,
>                                  struct smc_clc_ipv6_prefix *ipv6_prfx)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> -       struct inet6_dev *in6_dev =3D __in6_dev_get(dst->dev);
> +       struct inet6_dev *in6_dev =3D __in6_dev_get(dev);
>         struct inet6_ifaddr *ifa;
>         int cnt =3D 0;
>
> @@ -564,41 +564,42 @@ static int smc_clc_prfx_set(struct socket *clcsock,
>                             struct smc_clc_msg_proposal_prefix *prop,
>                             struct smc_clc_ipv6_prefix *ipv6_prfx)
>  {
> -       struct dst_entry *dst =3D sk_dst_get(clcsock->sk);
>         struct sockaddr_storage addrs;
>         struct sockaddr_in6 *addr6;
>         struct sockaddr_in *addr;
> +       struct net_device *dev;
>         int rc =3D -ENOENT;
>
> -       if (!dst) {
> -               rc =3D -ENOTCONN;
> -               goto out;
> -       }
> -       if (!dst->dev) {
> -               rc =3D -ENODEV;
> -               goto out_rel;
> -       }
>         /* get address to which the internal TCP socket is bound */
>         if (kernel_getsockname(clcsock, (struct sockaddr *)&addrs) < 0)
> -               goto out_rel;
> +               goto out;
> +
>         /* analyze IP specific data of net_device belonging to TCP socket=
 */
>         addr6 =3D (struct sockaddr_in6 *)&addrs;
> +
>         rcu_read_lock();
> +
> +       dev =3D sk_dst_dev_rcu(clcsock->sk);
> +       if (!dev) {
> +               rc =3D -ENODEV;
> +               goto out_unlock;
> +       }
> +
>         if (addrs.ss_family =3D=3D PF_INET) {
>                 /* IPv4 */
>                 addr =3D (struct sockaddr_in *)&addrs;
> -               rc =3D smc_clc_prfx_set4_rcu(dst, addr->sin_addr.s_addr, =
prop);
> +               rc =3D smc_clc_prfx_set4_rcu(dev, addr->sin_addr.s_addr, =
prop);
>         } else if (ipv6_addr_v4mapped(&addr6->sin6_addr)) {
>                 /* mapped IPv4 address - peer is IPv4 only */
> -               rc =3D smc_clc_prfx_set4_rcu(dst, addr6->sin6_addr.s6_add=
r32[3],
> +               rc =3D smc_clc_prfx_set4_rcu(dev, addr6->sin6_addr.s6_add=
r32[3],
>                                            prop);
>         } else {
>                 /* IPv6 */
> -               rc =3D smc_clc_prfx_set6_rcu(dst, prop, ipv6_prfx);
> +               rc =3D smc_clc_prfx_set6_rcu(dev, prop, ipv6_prfx);
>         }
> +
> +out_unlock:
>         rcu_read_unlock();
> -out_rel:
> -       dst_release(dst);
>  out:
>         return rc;
>  }
> --
> 2.51.0.384.g4c02a37b29-goog
>

Same comment, I had a patch to fix this without a new helper.

We have hundreds of dst->dev places to fix, very few  sk_dst_get().

This is why I think sk_dst_dev_rcu() is not necessary.

