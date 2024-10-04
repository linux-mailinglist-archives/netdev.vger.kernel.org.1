Return-Path: <netdev+bounces-131868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED59098FC6B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906A71F21E81
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2081C69C;
	Fri,  4 Oct 2024 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/fCf7IW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0421EB44;
	Fri,  4 Oct 2024 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010193; cv=none; b=RNQedDvtLrd2xrlsWQlYsR8AXwo+b11/fqBqQ97WzwYuxwWSGDa8nkhgBbGTlEDsnIKcH0iUGpfc+vRvMSWyApR0QNQog0e7s4xzklhpTvigwB6BrPLyP12mJDKQFWS8i9/snJc3nLp6RLCw5OaSPmjSNn72zF/NntGdfKGx1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010193; c=relaxed/simple;
	bh=bgcDZmpyp9Go7ne5lzKI7a7C9x9YMiRxlygQUNOFTGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmKwNacGt9CdH5oXTlrqXz/q9U3f2MO0Vs1w5+aUKYWclMxS+PxsFey0EcWJjMoWrkYh119FSOcdCwDhLHBqOjKghHI7YtumaamWcEdrxKEGegRgEMyiWmLDUPkBjjclGjB1sj0vPSRiLY4Fx+RaG6JwR6A4kqkvFaoFWfW2WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/fCf7IW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba9f3824fso13045375ad.0;
        Thu, 03 Oct 2024 19:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728010191; x=1728614991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlfa2WaHR53QQXl7QrIq/1KUxfn3b8pT0dVl+ObCnHQ=;
        b=k/fCf7IWdSD+RjIfwDqY9XxdperGkN9BFKaHQ265x0SmfUkjJzNOkfDvA2SqcwjiOC
         LIvj570U+lyLdKuA9U6Rd6sObKHUCmC0PCrikIOPTukP0romPXD9wmwLpiOUxKgznoVf
         us0+wOql9bXIL4AjeA1nZNsi/Q/9o2QMs8gEL1nNxdX+9g1UklWlnUfmah1Mo8LGIEd2
         vfJT4hoWGwwkkR13GQ28OR4JLh5LZ7s68cLAqi6/9rbCFbDUBlp68n8JW+5bDE+CuYDG
         TbZAlxEcnveQb1osvUXps4HUfhn2WBUgx2FPSzaFgekPIuGfnFrlb87TwAyVuudON5AS
         +lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728010191; x=1728614991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlfa2WaHR53QQXl7QrIq/1KUxfn3b8pT0dVl+ObCnHQ=;
        b=KrubtvXs6tEn8o9Ep8EFZQnXyEEW4y1/ETgrkNFP28cVDc/pJdg3JsgDK2+DsvH7Zu
         JEXYk+2ynGUBTxEE/4KyffDZVuBC9nWSjZT+NMWAYGHKgD0W7/e/aGGBoCwi35FGRG9m
         wZ+ZxMEDAfrmbpXWCRE4HRE9hBUxyEedF9owzbsIaExVuFiG3zQxcBkPIdokthDmz5Of
         MyitZJqaB3W7bUb4upl4MrDnxE56jjR2JQ2CU2y2u7tsvO6WUJ9S66C2roO+oA1Jk+pR
         wKCLbvrFRCMqXofLayx+qPh3aueAUqxQMP/b5xm2BTAJu/ltjUYVNXS+cJBPc50no5hh
         arcg==
X-Forwarded-Encrypted: i=1; AJvYcCW51OApvspC9Q8VUhTwSyPgcooza6EWhV4Guo9Nb9j23UUHlTEKYs/H2YdzGGLmgliE8JjcnbcHBXY=@vger.kernel.org, AJvYcCXqDsRdAF9FnvpAA4qnnRMopEFPgmUX90tRn2q5vUqY0CWaUtjerNN4Ftk8xbGxY5iyXQ3zOv1I@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFWNP6wyssQ3w+wsx1SCxjVUDQXiOHySeBl7zT/Vd4V4DxrDs
	0QkdiKxvP0OkU/slLOdpfbSGYj+wKprjqsWpuuEz8j/IIigJdyRi
X-Google-Smtp-Source: AGHT+IGOFiXKuExLzw6w1Mo/rQf2IO5b3/T2DttYfDhG4a/r2dPJ3ORuf7DrutuJaGbJl7gxEW/x9g==
X-Received: by 2002:a17:902:d2cf:b0:20b:502f:8c2e with SMTP id d9443c01a7336-20bfee333acmr18577485ad.51.1728010191094;
        Thu, 03 Oct 2024 19:49:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2331sm15476505ad.67.2024.10.03.19.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 19:49:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2100845D3292; Fri, 04 Oct 2024 09:49:47 +0700 (WIB)
Date: Fri, 4 Oct 2024 09:49:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] doc: net: Fix .rst rendering of
 net_cachelines pages
Message-ID: <Zv9XyuQ9-76EqoUQ@archie.me>
References: <20241003205248.61445-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FEqjA/q8SI6OQyDd"
Content-Disposition: inline
In-Reply-To: <20241003205248.61445-1-donald.hunter@gmail.com>


--FEqjA/q8SI6OQyDd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 09:52:48PM +0100, Donald Hunter wrote:
> The doc pages under /networking/net_cachelines are unreadable because
> they lack .rst formatting for the tabular text.
>=20
> Add simple table markup and tidy up the table contents:
>=20
> - remove dashes that represent empty cells because they render
>   as bullets and are not needed
> - replace 'struct_*' with 'struct *' in the first column so that
>   sphinx can render links for any structs that appear in the docs

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--FEqjA/q8SI6OQyDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZv9XxgAKCRD2uYlJVVFO
ox4iAQDyB8edaFY79GfVyTWLrflzqzWETIJbWkESwXyJSHGj+AEA16Ls7aZYDE11
gRBBXBo9XJdmTBak2Hm4hfRhDsQ+WgE=
=s7uc
-----END PGP SIGNATURE-----

--FEqjA/q8SI6OQyDd--

