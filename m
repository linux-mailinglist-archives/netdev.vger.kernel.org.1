Return-Path: <netdev+bounces-161197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC56A1FFA2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EB165111
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13E1A83E7;
	Mon, 27 Jan 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4n4m865"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52D1991DB;
	Mon, 27 Jan 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013176; cv=none; b=ennbrHk3et+KPeU1hxM0w3ShrURFYwxDBx0io43AC3ul2kA4PDcvLfvspqagMEm02NeXj8IHDdoksbSNuMVW8yZj8nYQJBh82zuApH/GPbnhnAZ7NrxWe70HSpi+2Ka+BbskK/epkcOjuvKZiomUz2yf7s9gft8OW6dM1W3GJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013176; c=relaxed/simple;
	bh=QAaResm0/vzRlOO6saYYIgXwJLkzNdgOxZIyumQb76g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtjrgLRUDFiVGTu9NmDtYlaqYWBGMXBMnVqLtnKu3kLJDENAXgpFHeJeGir1YC9xMTLx5S2LNY849J1gF/+Rn2xBPtiOYPYYa6rNIjx+dkww7s6TyoLETr9V4IMb1fhq/Z3euTsT3qXYx44cNxYJBEExRRFp1pcakPRHg6FFUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4n4m865; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a293339so56606765e9.3;
        Mon, 27 Jan 2025 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738013173; x=1738617973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yN+ZyQS4tTOzCysPn7ZDeo/0sC55Fh1GGIYP0zPjeA=;
        b=c4n4m8658KqgWaqQMiBeqtJzvmtLfpt5Ft/lStYjOi1InFrEdUhMpQmh+mib8DYTJL
         3GJwse7yOX+F2o2OLyzhwICBfAE6ucvrZAiVZHqsSZvDTjfUYF3YRBGLVt/nBCgYO7rj
         FsWcjzo5Nx1UZq9fl5D0k7Bdtz0BkhD/3cNFAAqZMCOZBiFJsPlzhnCf5ShYfSpszdYk
         fkpZZwMfVTzrSXKw+jjGv/D+YOg8zp76Xp2BTgfvaxMJtzqYJEZm0puJg0fSf285XMnl
         QWfj+Y5KoD17lMXpFIDnzo6wrFPLyWAdgESiSTW3De64o4mTHVcoGkvELCwOMPDWa7JO
         8JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738013173; x=1738617973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yN+ZyQS4tTOzCysPn7ZDeo/0sC55Fh1GGIYP0zPjeA=;
        b=OKNGFlgH7Dfcsqp3ejQZjIYzUYl8AG1uITqHMS5ApItfUArHLGSDPSFeE2mBeiXJ9g
         njNzGflRJWWK77H8m9gvZ2a8df9tvAzWR6ty3OMH94UbVFvv0DSE5mzd5UuxpOQTPT58
         aOii5t8avihh8m2KGS0sWGgbFXNQB1I7Zlt7OmP9nmjwvNsvbRG5yl2AI5d4tUBYSHR/
         eYyQka4A6FHTB1N/cYxr6ZPFg8yvaAm1n6mAhRF/G1ecsSZZQ7O27COUpfdbGCxiPDRB
         7Qejfh3t0ksNlJYyC1QcXHK2Mx9zc7qqQ0OB1/IUt+Cl4j2TjhHW//7yC6Z1fujOZ/fw
         zk2A==
X-Forwarded-Encrypted: i=1; AJvYcCUlLvtbW+peLI+plDYcvB+ME83PSQX83xevtwjgw0s1n83hTZMc0fFkqEsH0lPKs6olXUtJRs70uLDeH64=@vger.kernel.org, AJvYcCVkxoBsiWc6D1ol94y5eV59neKHbooZOitzc2D4PL0QgubgFLm3fZpGK7gtA7eeeLwIImhJZ7EW@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHM549bszjVpLMull02i/+qE4DXT4ku6BIWMJ5VXfZVmC980e
	uC4L3si6Q293Yn5BB5uSZx60JQP1QnmIzpOdiWz6Ltr7cP7XXLf5
X-Gm-Gg: ASbGnctbyHo+BvHH5dFlTwV6AotM9aYAzBllbUGJokTf03t+qYkZgggTZzSYtpKt0RO
	Kto3ZWILNhxie1niraegIMrlKOw3dxpgtVLVSunxGjAh7XMYi6elPhxd0Gar9tMWRorpfR07AM1
	WDVlFAonqLjsYs6qp9Cs3v3g2oDxt0m1Gg0xXQFWVHqw0PA/mb9LAu8DnBASklPtYq78p7s/oAQ
	gpqaED0OaqKnkOx7Ssw3Mn57ncZ/nzRrSquTT9mMWhrYJ9BamHcDNu05MBEfFqaLzS2lSfg1+zm
	L7WELj9PQsAYQYQGjOkhoUJ3tmYo1lVM0qi6YcULXBI=
X-Google-Smtp-Source: AGHT+IGKzyJhASw/tnqD4QPz5EgXKhD9y+zM+a4TmL3g2gUTl6RHWWyihT9Ca4RtWj2mKZzrSk+jrg==
X-Received: by 2002:a05:600c:1c16:b0:435:192:63fb with SMTP id 5b1f17b1804b1-438913bed1bmr363672735e9.3.1738013172843;
        Mon, 27 Jan 2025 13:26:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa479sm148195905e9.5.2025.01.27.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 13:26:12 -0800 (PST)
Date: Mon, 27 Jan 2025 21:26:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <horms@kernel.org>, <krisman@suse.de>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <lmb@isovalent.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <tom@herbertland.com>
Subject: Re: [PATCH net 1/2] udp4: Rescan udp hash chains if cross-linked.
Message-ID: <20250127212611.74681753@pumpkin>
In-Reply-To: <20250127203304.65501-1-kuniyu@amazon.com>
References: <20250127194024.3647-2-david.laight.linux@gmail.com>
	<20250127203304.65501-1-kuniyu@amazon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 12:33:04 -0800
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Mon, 27 Jan 2025 19:40:23 +0000
> > udp_lib_rehash() can get called at any time and will move a
> > socket to a different hash2 chain.
> > This can cause udp4_lib_lookup2() (processing incoming UDP) to
> > fail to find a socket and an ICMP port unreachable be sent.
> >=20
> > Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
> > that the 'end if list' marker was on the correct list. =20
>=20
> I think we should use hlist_nulls for hash2 as hash4.

=46rom what I remember when I first wrote this patch (mid 2023) using
hlist_nulls doesn't make much difference.
The code just did a rescan when the 'wrong NULL' was found rather than
when the last item wasn't on the starting hash chain.
ISTR it was removed to simplify other code paths.

>=20
> ---8<---
> commit dab78a1745ab3c6001e1e4d50a9d09efef8e260d
> Author: Philo Lu <lulie@linux.alibaba.com>
> Date:   Thu Nov 14 18:52:05 2024 +0800
>=20
>     net/udp: Add 4-tuple hash list basis
> ...
>     hash4 uses hlist_nulls to avoid moving wrongly onto another hlist due=
 to
>     concurrent rehash, because rehash() can happen with lookup().
> ---8<---
>=20
>=20
> Also, Fixes: tag is missing in both patches.

Semi-deliberate to stop it being immediately backported.

While I think we have a system/test that fails it is running Ubuntu on a De=
ll
server and I don't think the raid controller driver is in the main kernel t=
ree.
(We're definitely seeing unexpected ICMP on localhost - hard to get otherwi=
se.)

	David

>=20
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  net/ipv4/udp.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 86d282618515..a8e2b431d348 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -425,16 +425,21 @@ static struct sock *udp4_lib_lookup2(const struct=
 net *net,
> >  				     __be32 saddr, __be16 sport,
> >  				     __be32 daddr, unsigned int hnum,
> >  				     int dif, int sdif,
> > +				     unsigned int hash2, unsigned int mask,
> >  				     struct udp_hslot *hslot2,
> >  				     struct sk_buff *skb)
> >  {
> > +	unsigned int hash2_rescan;
> >  	struct sock *sk, *result;
> >  	int score, badness;
> >  	bool need_rescore;
> > =20
> > +rescan:
> > +	hash2_rescan =3D hash2;
> >  	result =3D NULL;
> >  	badness =3D 0;
> >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > +		hash2_rescan =3D udp_sk(sk)->udp_portaddr_hash;
> >  		need_rescore =3D false;
> >  rescore:
> >  		score =3D compute_score(need_rescore ? result : sk, net, saddr,
> > @@ -475,6 +480,16 @@ static struct sock *udp4_lib_lookup2(const struct =
net *net,
> >  			goto rescore;
> >  		}
> >  	}
> > +
> > +	/* udp sockets can get moved to a different hash chain.
> > +	 * If the chains have got crossed then rescan.
> > +	 */                        =20
>=20
> nit: trailing spaces here ^^^^^^^^
>=20
>=20
> > +	if ((hash2_rescan ^ hash2) & mask) {
> > +		/* Ensure hslot2->head is reread */
> > +		barrier();
> > +		goto rescan;
> > +	}
> > +
> >  	return result;
> >  }
> > =20
> > @@ -654,7 +669,7 @@ struct sock *__udp4_lib_lookup(const struct net *ne=
t, __be32 saddr,
> >  	/* Lookup connected or non-wildcard socket */
> >  	result =3D udp4_lib_lookup2(net, saddr, sport,
> >  				  daddr, hnum, dif, sdif,
> > -				  hslot2, skb);
> > +				  hash2, udptable->mask, hslot2, skb);
> >  	if (!IS_ERR_OR_NULL(result) && result->sk_state =3D=3D TCP_ESTABLISHE=
D)
> >  		goto done;
> > =20
> > @@ -680,7 +695,7 @@ struct sock *__udp4_lib_lookup(const struct net *ne=
t, __be32 saddr,
> > =20
> >  	result =3D udp4_lib_lookup2(net, saddr, sport,
> >  				  htonl(INADDR_ANY), hnum, dif, sdif,
> > -				  hslot2, skb);
> > +				  hash2, udptable->mask, hslot2, skb);
> >  done:
> >  	if (IS_ERR(result))
> >  		return NULL;
> > --=20
> > 2.39.5
> >  =20


