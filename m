Return-Path: <netdev+bounces-132643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0C992A08
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8A51F22FA0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFEF1C9DC8;
	Mon,  7 Oct 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOrGhj8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DA2AD05;
	Mon,  7 Oct 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299394; cv=none; b=ARG1/BNh4aFWe4XZLIMuDA5DzAgYLiqzMYGlbCNYzm08BdLtyPl5l5jcDrWIQNBPFY71paBpof1Ix2HLLQOZO3lTlv/JWCHePHx5dmHKPwRFRNbBM5BPtjKzUHbO6F2ynqOL+Js7ipTACG+/lClahX7/GJv6enDfLpM9xTkB8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299394; c=relaxed/simple;
	bh=5wbY/RQk+dZVFTuD2NZblqMNoawXgnQwA7gGNgkOd8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+pQd1DEsLqwMGCgYZtX1kR4aR/txCQRcLpFjTerg7fqetNwRTcdmIf7pWkeh1DRS0v1+EKYI7SWdBIf8Bxkto4u0n0ZOEU/N8dSplYjg4Ch0XlRp28jOoAm33lKtjcvvuLI2qkID4cLCR4GaCaOc4CpbZByLkj6e1jO9/tB4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOrGhj8L; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so3490983a91.3;
        Mon, 07 Oct 2024 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299392; x=1728904192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqk+8hebPA4ti95Da2Yr/B6Svo5BcjtL6Vb/SKjC1tw=;
        b=XOrGhj8LR7V9F4d1Q5IBuc/XwVor9r4PhtQxjhCO9goEqDRjtauFysLMNGZGTpxtsk
         E19BXmL5jHv5w9DrQ4faOcgWjSALMBMOYDlxVcKkb2i8gLqmJaI55F8l/L0jh5uVk7dq
         YMUxMRJnQhfGZYxU6JCwGXdmWapW+z82rdoPV76L8xb9D3PentVjeSr+BO1BaOmdhDQY
         4INDwn1mEN40nI9QSGB4RdPooK1vuOogECGczg+xR4aD6IhMhOtv8HqqxJMqwhL20Gj9
         Z4gdMojx32mvFInnkb1HVWG4xDZN0q27MgZhP1pZGiaCn5Q0rwO4awr683FRtoYAtWY/
         Giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299392; x=1728904192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqk+8hebPA4ti95Da2Yr/B6Svo5BcjtL6Vb/SKjC1tw=;
        b=ubFwaS4Vm1BpKrhVMRUIqgMKS32lEtOS0LCt5i0nuU1ToWprcOEBTLaDpicYCEj44k
         jlaaI57VjqjvBmyWTFgNKRlN4m3bZ9CF285REgyk4un2wIOcK3r0tQ3DeRTgCz0cSTBM
         uNAlVhRrOfBIkblNI5O8xWpkuuUubgpcFcH8lJFISpYhKzh6TxJp3UhbDo408mQvWL0r
         NbEechxi7oc3NYN7YVK9YI41f3iyMqxRAzZVJI/udLGjn581NHBJBIvLcuyjBq0jMXeu
         wdenURhyAAgzaEOZTLKN2adFmuu++gcnt/F5tT/KZnDrXrXckxWyfXmWnwWnFaAjNL9M
         pGKg==
X-Forwarded-Encrypted: i=1; AJvYcCV1RkHReYkCV1MOwwj++V/garPHDLEUkdPwJ1JqZI6brotOSE4sEi7VDlO1iUfQzEHR+2X/ZR+Rj3c=@vger.kernel.org, AJvYcCWuNBcC0Or/gEH2a/iDjuLHf2idsGKSiVK/BXwrCXQzv5Ixe5CxD2C/1JdsLAemLNPp5ZacQF1E@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnNTkU6wRxFu+PjsE4fISqw5oobi65PeU5/4dv+paG6gzuzNA
	ab6HElXeH1FrDWWIHUW/WKuXOPoAaWziOe5aLaATM3QcdQ63ydNY
X-Google-Smtp-Source: AGHT+IH1i/YLuuYzyJRautzgLh1IeiNrFLRhSMUkMmzG3WVXdLa7AlCZLM4wJywivW5iMKi0OsFxGA==
X-Received: by 2002:a17:90a:e7c7:b0:2e0:9b59:c0d0 with SMTP id 98e67ed59e1d1-2e1e63e3315mr10767696a91.41.1728299391946;
        Mon, 07 Oct 2024 04:09:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b12e245sm5046992a91.52.2024.10.07.04.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:09:51 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D22464422BC6; Mon, 07 Oct 2024 18:09:45 +0700 (WIB)
Date: Mon, 7 Oct 2024 18:09:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3] doc: net: Fix .rst rendering of
 net_cachelines pages
Message-ID: <ZwPBeSnyNyaYCDql@archie.me>
References: <20241006113536.96717-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fz7Re0cZD2nr0VQd"
Content-Disposition: inline
In-Reply-To: <20241006113536.96717-1-donald.hunter@gmail.com>


--Fz7Re0cZD2nr0VQd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 12:35:36PM +0100, Donald Hunter wrote:
> The doc pages under /networking/net_cachelines are unreadable because
> they lack .rst formatting for the tabular text.
>=20
> Add simple table markup and tidy up the table contents:
>=20
> - remove dashes that represent empty cells because they render
>   as bullets and are not needed
> - replace 'struct_*' with 'struct *' in the first column so that
>   sphinx can render links for any structs that appear in the docs
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Fz7Re0cZD2nr0VQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwPBdAAKCRD2uYlJVVFO
ozwGAP4/coDHQrhUmkSBHDX0x/ec0iWraLQ4QnxbZyScSTQI0wD/R+sYJci4t5sh
hHySaerPFQQ3WpA5aG/PnaXlWbBPegg=
=Zt80
-----END PGP SIGNATURE-----

--Fz7Re0cZD2nr0VQd--

