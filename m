Return-Path: <netdev+bounces-201711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A804AEABEF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6AA1656F8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E26522F;
	Fri, 27 Jun 2025 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPEIW/r3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B608219E8;
	Fri, 27 Jun 2025 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985343; cv=none; b=AuA/z002yBwsnKj6Vhm1DTM7rbKDla/aW19Aa0xs7Xzpu4scYAXur6hyK8x9d2xJ2N5E9RTWKWAllhxrgbqZEfQA67CXwgcS2YgNJzyre/hWja3UgvU/2MsrrDVkumTV5QLzQW1z//fbAsOscM4gOThOUuPVLVnYQ4k15tYOKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985343; c=relaxed/simple;
	bh=5oLOQYAMuarWeQyZW0I633F/GlCg3p2uhMcx+ReqRcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz2s0NTqksHLiSAkTYUKyCURi9+QsFUkaZyyWJcbpyhGfMwbKeh9uPWQNGicdjv4pjQOCeHGCXaPrOpQ9UoOyvdfUQXsrStViIWW5i35FdWlesYK34qjWDwKiR5JPujt+B9ywMBF+bG4bYc5fV8q+8qHaesODh7hdIMvUJNGxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPEIW/r3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236470b2dceso18121885ad.0;
        Thu, 26 Jun 2025 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750985342; x=1751590142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUh54we8qQgEjajINTYGgfwX0bLCQRW15F1qeTz390A=;
        b=DPEIW/r3jNaCxAJGoG/7IeAXdAdyPsz8p9exzNNckKn63Sur/EYzSWVhcjzSdLAAQl
         0bdM2tWgGsKUW7F/zcgcq6jERYXFpKrwSU5sxAbphZCpEArvJ9YJ9RbCdYSsN0X1ItJQ
         ZfFTVPTXBlfrTwjG6OkJYmz7eEUullUPJlDbD13OU5Ld0+QeCHURQwl8Iqv26Hs5cE92
         EhF/AKTJVODKT2SKXV6Xk5DhqhZGnTFzPF8g00hCe9kzVLL4Senwgz/c3U2oATnddGih
         vAZn6Fg3ffS0/7FSaiLlw55/91+OhoojDZ2p6ftxLAeSHBjPRn27ORuAg54XnGTtX0T9
         XY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750985342; x=1751590142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUh54we8qQgEjajINTYGgfwX0bLCQRW15F1qeTz390A=;
        b=es0UcWFKo4AkgjRrEenddMrOVBge2YLrTYZK+abGoWCCkbrcp6P0abU0pGiLsJa/Tw
         w3q9miCDd3nUmYvs/QzzjAgNwZ44twJT2IqIjRDKoTP7RK9rkkX6ptRwNRxWf/QBP4Tg
         4OJuvys4Gn4BU+yAoLq6hnMXSGeFcsMAyofZfgkozdo7TjHASv4OesBCL0YpAyhyjJo6
         srMhKHkFFHB4NH7m+hSFWHH19QFxi3pUJUA5GWm+RMHl+aYU83w6wDfeFVE+VjouSrKJ
         ewRU7hN/gLShO3ZLsXKPXHe85Uu56iK7BgbN3/GaH5upRriWRx3HohMzyE2DY+UxZY6u
         Yz9w==
X-Forwarded-Encrypted: i=1; AJvYcCXLIgLG0XrQk7yiVjVQB+CmWlK/Gidjr+3GScVEnArysnDHT1bpWqBlweDRZSMhVng0ZSow1N3Z0ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hcqMw7b7/HmzENBlm5tL5wfn5QkZ7Y1fj4lbJuT5cscCt6YO
	EwnOzun1O2t8O5Pyn5UJeS3j9q3SaCFiouZKT5IlThRTiobr3dZ16xGeFyvxeQ==
X-Gm-Gg: ASbGncsmEz4WrIeq8Js+Jyo5Dan/CKLnLn8Cch3uaCrgG5h2pGuuijhJgT83N36tKAu
	UPtTNfChqDV9MaiN9YXcqTIYLK5uRnFslX7NBbsNyEr2T9Au6NO/iIJAYcXka7vwjfHql9o0rmw
	2OLwqtXuce/F5jICBNt7CmJs4k13w2ppPLeOw0Vis4m1RI9kAG86b3ak00rYDzJdK2zPiFhKttN
	ydv4GmFkq9xRcM4QOO+Pa47O13biO/WX8GKEijQLGd5cJk3iJ6cnNsGZFAWtqiv+lPuxfqtYpPI
	FYI6b/X310jsT3ER7WBzlFZM3EgfsBipJDsIwiW29mSuDcRui0p9sHtRsCE0qQ==
X-Google-Smtp-Source: AGHT+IH3XP6ZqYnskGg62bI6GoHr+BwRDgXeQARNuU/0NSTvvfDYYB8vFqg406aoZFsCGadYV3kyMw==
X-Received: by 2002:a17:902:fc8d:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-23ac3afd437mr21438655ad.16.1750985341546;
        Thu, 26 Jun 2025 17:49:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c8d99sm2564815ad.248.2025.06.26.17.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 17:49:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 839F14207D0B; Fri, 27 Jun 2025 07:48:58 +0700 (WIB)
Date: Fri, 27 Jun 2025 07:48:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: correct the heading level for
 co-posting selftests
Message-ID: <aF3qeuJupkykvtpV@archie.me>
References: <20250626182055.4161905-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="074WrdyqrDJ/fiQe"
Content-Disposition: inline
In-Reply-To: <20250626182055.4161905-1-kuba@kernel.org>


--074WrdyqrDJ/fiQe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:20:55AM -0700, Jakub Kicinski wrote:
> "Co-posting selftests" belongs in the "netdev patch review" section,
> same as "co-posting changes to user space components". It was
> erroneously added as its own section.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/=
process/maintainer-netdev.rst
> index 1ac62dc3a66f..e1755610b4bc 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -312,7 +312,7 @@ Posting as one thread is discouraged because it confu=
ses patchwork
>  (as of patchwork 2.2.2).
> =20
>  Co-posting selftests
> ---------------------
> +~~~~~~~~~~~~~~~~~~~~
> =20
>  Selftests should be part of the same series as the code changes.
>  Specifically for fixes both code change and related test should go into

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--074WrdyqrDJ/fiQe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaF3qdgAKCRD2uYlJVVFO
o9hDAPwPVHtvsPDRbE2pyJh8XRAmEwXedr+Ri4+mIiK0rrspAQEAxaWKGa3c/YCA
S1RooAMM981amEykpAy6wyaiHu/fdwc=
=bpfR
-----END PGP SIGNATURE-----

--074WrdyqrDJ/fiQe--

