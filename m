Return-Path: <netdev+bounces-135614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B099E71C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34C71F21D22
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FA1E764A;
	Tue, 15 Oct 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYh18z/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC81E7640
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992951; cv=none; b=Ar+YxQd9gd+nxvNVbjwfOmj70u0nIcdv7gccg0evorTf77r/mddLSRE6ZF1JhIvkwG+ed3VFMTW436Nx2LRiQjHVAFjx/Utgha5g2MKpvoB0BRzZrF4dGotW1RuhM6p3b9Xs2fWgh+BAZPi6kPdfqSGLi7O7NVzD9LGpWO1Heb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992951; c=relaxed/simple;
	bh=LNwsw1uVbVCJ2v+7xMauklsNh6wzAl/7e9KsLYhfzCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEaFbEiFZybeVW/5VZQUCLbVMLgIupAeVdq0TYU0nNsc8x48d94KLY7NfB7n91puh9LWzOnPrEk5gaq+9cqd85V/9i3E/NVHwTUc936JSn05cYA/WRJgwOmBGxmQPvKChCOisvSqN8zeQz27vb2141fk3FXA6xpv9WRD75A7a3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYh18z/l; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e989f7cc7aso2249384eaf.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728992949; x=1729597749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnNoUvDvy8NJSqFhvtQChMq30XHN2g+e1YRoM9IqmN0=;
        b=jYh18z/l5EieKWrOc1cjfUuSY/vBRWI8YQ77Vm4f4I8ez/vCewZf6YIQj5jZ7X7EA1
         pm/GJzv4N8WeLWGsquZ6U9TrAZ/9+6fAaJ5YzCRhQz6RxCnPppxNFjH+SStcOUn3yVMs
         y8RIuqOTTC8thI2QOVJI1qEd3NyhOafxbTwelhnVy/WLqsQO4HM7IJy129bKfk6WSCvr
         TyJA3T87+L8Oouaaqzie1g93Zwkly3PZFmLqNGGtX6ORT11aapK30v2FROqKDs9ecpr3
         KzxK/Zc4Y9yzcXftqJorRRRzzMFk1b9PuPryHaeSzPIo+iDgKCvcNHNDZxVu1DxI4zW0
         pqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728992949; x=1729597749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnNoUvDvy8NJSqFhvtQChMq30XHN2g+e1YRoM9IqmN0=;
        b=C+no7Xkswk1n3///m0jKkSBEpj7URqFwEWVxlWN6vwwzkLTyn4A5EEp6ke6X3EIPtN
         /bdiMuSmL/ISAfj+qy2myDLJUD7Rl/gUrpl52n4u0yTCIB7TYx8CwrWRKb7imQtfTJux
         Nl/dqNKiH+35eYecTswsXRF+uLwVLkOeuDSmAeVsYdcMYk5nVFZUpgulXVA9FBramIAn
         dRCsqjqH1snGTyLamLCR1OBdpvF3YCb9HwnoWyUUZKo+nW1bHlMhYOylGumARUR8UGW+
         rIidfcyv/1JVB3lq2w0w6x5JblMjji60MKmp6J9A1JKMMSFLOHW+/7R15Sp/ypu+IHLi
         X/mA==
X-Forwarded-Encrypted: i=1; AJvYcCU6C2BKQ0bf3JJt9md2o1+UKz5cyAt1UQ2FR3R9VrMVBTeAEwcYfQaYOl0nRCgAbZYGcr+npSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ITkLDxuEcqV0fWZ3slCs/PraNd5KPhSAQSK5VNJZLwyp3eud
	hB0+nQUWyEl9QQOekkDPDjhAA4KE1VIYA3Z59QmqIUjY7H6P7WXPgqrI5SCDkD39pcp5kq3GCPk
	MUQR6r/Jn2m1FE7X3tdOcx6iaTck=
X-Google-Smtp-Source: AGHT+IFby9QZ9UCHNxkqDRt4g+bRcIRfpNvaMs+2S45wpEFS5Bp3nNeacEKZ7OcGs3iSRran007eeSaUdp1ezOpWyZ8=
X-Received: by 2002:a05:6870:89a9:b0:277:d9f6:26f6 with SMTP id
 586e51a60fabf-2886ddd3206mr8779044fac.12.1728992949069; Tue, 15 Oct 2024
 04:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728982714.git.gnault@redhat.com> <4c397061eb9f054cdcc3f5e60716b77c6b7912ad.1728982714.git.gnault@redhat.com>
In-Reply-To: <4c397061eb9f054cdcc3f5e60716b77c6b7912ad.1728982714.git.gnault@redhat.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 15 Oct 2024 04:48:57 -0700
Message-ID: <CAHsH6GuCd4K_cWzc4LF3YkXACcY3GAVN4ZT_hLsHk0r=B+t8zQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] xfrm: Convert xfrm_dst_lookup() to dscp_t.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:14=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
> prevent accidental setting of ECN bits in ->flowi4_tos.
>
> Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
> already has a dscp_t variable to pass as parameter, we only need to
> remove the inet_dscp_to_dsfield() conversion.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/xfrm/xfrm_policy.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index c6ea3ca69e95..6e30b110accf 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -291,7 +291,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, =
int tos, int oif,
>  EXPORT_SYMBOL(__xfrm_dst_lookup);
>
>  static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
> -                                               int tos, int oif,
> +                                               dscp_t dscp, int oif,


FWIW this looks like it's going to conflict with a commit currently in
the ipsec tree:
https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git/commit/?=
id=3De509996b16728e37d5a909a5c63c1bd64f23b306

Eyal.

