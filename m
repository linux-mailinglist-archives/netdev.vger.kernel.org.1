Return-Path: <netdev+bounces-177830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86004A71F5A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C03217B0AA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74A255E27;
	Wed, 26 Mar 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SPtI7YW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF4255E2E
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017919; cv=none; b=GUo6hGEipLUDB/0weClJlOYD8GKy2MwRobuwm7yBdUnrFYltf2DGCtsrv1xIoHY7n6E0RhGO1bSxA40QDS9u7Cz5TWUQ/c17ihpliWwXdOMyNQwr8wjXtbkLkzE68V9BUMPVv1iyIACKg1rKNMcXZ+ghq4sxDIeU1aLMCzHuFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017919; c=relaxed/simple;
	bh=3w4M9U/6KMoXnHUmGA2Lbn4KvHbZmjf8oMnVhzAkMas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucJ8974B7lAS+5OAhdq4SSPdo8lfe/ESGVAX0+1gVnGTjPdzrd5aXKy3KvnxOozw80MTDtN2zgOKt7rDjOHOt3Bw8WWEtsa3an/7fBV1sCbkaujscAG4B05uT5vTfDuoepbboWzPI8TNO62x76S8l6jJCSII80j/BUXVWwR77Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SPtI7YW9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so246718276.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743017917; x=1743622717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37blrJ4dA4pbuNAhm4qoJ4s8JjE8q0/IzkGXMncvmgs=;
        b=SPtI7YW9hruD3jTLpYMd4BOFVnzWvq4gewA/J4It6G89jQ3IB4MYte098qHXDkg6ym
         qCEmscQwUAEPxJO5g7IFw/22q/9NidZYeEmokN6lCtBFBpTS6IIokmpxNhoQsTSERmrD
         UHf/D4hbfUrXezZRp878wok25HJT49imr8fsewED+nJL1ZvMESJzkdBmBb/6wfejUqnB
         4+TG+Sg0L7hEHOhgvEm79R/o8YQN/g5dy1FcCk8LsvYbPfniJ61oUYfCyMiF1s+Xv4D9
         s2PkoN2mI1Q1vv2Fi20x9YO+X+q5cM/ozD2TaU5CvW52KuCYK2nQUEuIfEOMM4ApM04s
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017917; x=1743622717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37blrJ4dA4pbuNAhm4qoJ4s8JjE8q0/IzkGXMncvmgs=;
        b=TEKUKDmhONpni0I680boJSMDpSMgnM7b65OH1BWh25rbvuS5+yv0vIqO5AANg34GnV
         ufo5d6IABd3tl/lbpFXadQ9I79cwXPWmWW2BnJgAuhnph8rnNT+8lgH39y1zml0dxN9r
         VWuEZh+UmUjhea5b4O6qlSiLyZHzDxihrIicZoxRVZ69Ratkq+FHt5SL6fg9JNuclHLO
         bvm9VFJnTBK1OxsYWffVRdh/IXbxvNBsZ5+WjTOEJ37hrtur6peQnhxW2V9tlEBUZ5g0
         Mk1jxU/E3rwM89rs/kvEGro/UfWr59RnLz6aIPbtmanAmXGpIdTStgi4bNxRrZ6CoOAo
         wuVA==
X-Forwarded-Encrypted: i=1; AJvYcCXT8IBGeXt4UQIkmkbIdTpgk6JasmNz6FxECYtOOv1FDclEdPKMa8XSDnAdgNmaAOB1/T1549c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1pORq9BykXtf75ls4hwzuG8WgGB4dkekuUif++n61Quw9NYw+
	AEukQN2MC5DZpeGQuB9CfBlO8XT43Ymgt+4oQsgD4CSGkGqsSzdB4dL2BmDF/1pKp84km4IzGMF
	bsZeLmja6AoAlrp6xg101IcjviVtum9TuUDfz
X-Gm-Gg: ASbGncuDSXl2oAo+nqmjWybuDa7lc+K2plT6voXAsivLWOQlQLn+PBarR7Pmyssn8zD
	Y3LUl7MpOKccYp6wllF9HyB/cqLdXOpPiEsLclUPvesHTXTVCAdMuuTMEQjf6g9mDOSlr+yyH+i
	v3hEE48THh1LzJWaUjAIIOKfSEUg==
X-Google-Smtp-Source: AGHT+IEKQn/nJM0uTtrV4JZhrCW9IJH+yJidlTMVM2nALH+VjfWmiWTfWqHmGlsegAJ2Tfw9AccjfAhu1hVM+OJq0PI=
X-Received: by 2002:a05:690c:968a:b0:6f6:d01c:af1f with SMTP id
 00721157ae682-70224fbfd87mr11354817b3.16.1743017916900; Wed, 26 Mar 2025
 12:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326074355.24016-1-mowenroot@163.com>
In-Reply-To: <20250326074355.24016-1-mowenroot@163.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 15:38:25 -0400
X-Gm-Features: AQ5f1JpWlU1-iecgrVs8fJXGenKH2jxovnmTGIWOOp81NIsiGDtaZoSu2Wqu7J4
Message-ID: <CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>
Subject: Re: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on
 IPv4 sockets
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Debin Zhu <mowenroot@163.com>, 
	Bitao Ouyang <1985755126@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:44=E2=80=AFAM Debin Zhu <mowenroot@163.com> wrote=
:
>
> Added IPv6 socket checks in `calipso_sock_getattr`, `calipso_sock_setattr=
`,
> and `calipso_sock_delattr` functions.
> Return `-EAFNOSUPPORT` error code if the socket is not of the IPv6 type.
> This fix prevents the IPv6 datagram code from
> incorrectly calling the IPv4 datagram code,
> thereby avoiding a NULL pointer exception.
>
> Signed-off-by: Debin Zhu <mowenroot@163.com>
> Signed-off-by: Bitao Ouyang <1985755126@qq.com>
> ---
>  net/ipv6/calipso.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Adding netdev and Jakub to the To/CC line, original lore link below:

https://lore.kernel.org/all/20250326074355.24016-1-mowenroot@163.com/

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index dbcea9fee..ef55e4176 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
>         struct ipv6_opt_hdr *hop;
>         int opt_len, len, ret_val =3D -ENOMSG, offset;
>         unsigned char *opt;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         if (!txopts || !txopts->hopopt)
>                 goto done;

For all three function, I'd probably add a single blank line between
the local variable declarations and the code below for the sake of
readability.  I'd probably also drop the comment as the code seems
reasonably obvious (inet6_sk() can return NULL, we can't do anything
with a NULL ptr so bail), but neither are reasons for not applying
this patch, if anything they can be fixed up during the merge assuming
the patch author agrees.

Anyway, this looks good to me, Jakub and/or other netdev folks, we
should get this marked for stable and sent up to Linus, do you want to
do that or should I?

Acked-by: Paul Moore <paul@paul-moore.com>

> @@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
>  {
>         int ret_val;
>         struct ipv6_opt_hdr *old, *new;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         old =3D NULL;
>         if (txopts)
>                 old =3D txopts->hopopt;
> @@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
>  static void calipso_sock_delattr(struct sock *sk)
>  {
>         struct ipv6_opt_hdr *new_hop;
> -       struct ipv6_txoptions *txopts =3D txopt_get(inet6_sk(sk));
> -
> +       struct ipv6_pinfo *pinfo =3D inet6_sk(sk);
> +       struct ipv6_txoptions *txopts;
> +       /* Prevent IPv6 datagram code from calling IPv4 datagram code, ca=
using pinet6 to be NULL  */
> +       if (!pinfo)
> +               return -EAFNOSUPPORT;
> +
> +       txopts =3D txopt_get(pinfo);
>         if (!txopts || !txopts->hopopt)
>                 goto done;
>
> --
> 2.34.1

--=20
paul-moore.com

