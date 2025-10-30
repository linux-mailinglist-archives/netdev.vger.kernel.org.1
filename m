Return-Path: <netdev+bounces-234287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E26C1ED0E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D455C4E8032
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D2337B85;
	Thu, 30 Oct 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDQfTdex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7719E99F
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810052; cv=none; b=YvY4KB4/y/C4Lu+jfYrSzyHrSevGiDDxX5JLOzOOc+1VeNAQdJC1G1tLPknWz5IBLmq17MjCSes8yYRyPuOql5lRMcK6zxX1ObLEN3pVEWk7eDDiMIZCO0gZlLhi1nIv1eAJk5u6kqCNxKvW3KAe+dZk0ObZ3R9nNT6U1iNPz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810052; c=relaxed/simple;
	bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjKKSRjGUlliuiwUFVppstqzJ+KmL0lMzsnaJkG4aBoM+d6nE/Isk4ntscF15ZNGTeTLV2gtqlY6nPo/X1i1/kx5x3zAW+3zs+0O8JW7r7y/SU9L2CihDb+T5MfGE7hqNl7aDSPcf0tL6LNUI+OZCJcmscycg5g/MZvI70eucV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDQfTdex; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so642766a12.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761810050; x=1762414850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
        b=DDQfTdex7r2tKhbvtJhdJQnl1VIYrxggBEO9A31p5H5dDCW8sMEVcFNI6M04Qnt2rj
         oGYweSn0EC8NNgEP+ip8ZKYbboivkpqdfWWGowk7tqnmGbBUP7zAoJ4jtIQFGEGGjzBU
         Vupgs3Jtkk1brsvOy6dF1bT1jquMLhUXUInk+LsTZsGouSuEdeYU5uwoD9F7SgCW6Qgx
         34AZbpZLSkw4+Ya0MS/iAwOfPTnrAETU2mjU+iLb90TkuzPnGk/eMXqycO0JWh/7xzvz
         4mvVkWw49Dh3r+ETaaLYWbdHVgrwoCAzqg5TV1U++AkLwzTsT5S8zvAkbiITH+gFdJH9
         Yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810050; x=1762414850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1hjxQGjEC5L4T4UtQNNrJaSLGQSRQrdJRzQ9oj29ac=;
        b=r4qMJPGW0YaenmtaGmuVeYqbmEal5BDF1V/GfQx7YQaKJFCTvYjL+qUlGAIva5Wpct
         vI4zJaRrxY4XDuofvCT/vUI7tS4NssrR/1W5qsECW9xPdO8bCKzOM+qA4FiaK+SkbVcw
         TVO0XKgQfqclDssl2PZkLo97oVEaw2Meemd3gfhIVGoia4fsH32DnrB33uBermOYxvuW
         YgbB4nbtkRJTJC6cLNU8bJe4uk4DrfRMr16BmQxLV7zuUZakIXBS5iH5/WSUJ0yhKG1c
         /BwqrU6Cs/0bIy0NZzYD2qrU7k0gnE15QDi98tzwrcYqRWkuSDeIFTrL6mg3EUhNqgC5
         PGkA==
X-Forwarded-Encrypted: i=1; AJvYcCXkX7y/0UDpnOM+SUpQVKweClreGrkXqsvXi/BfFVDbORqMd5MD4E6Xc7slEaov7hHNXHWqjPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2UATmxUXlttqRZTGLKdrNxly5n6ENBxPliva+uGzeTWfJ7Ml
	gv2an/UrxHiRy/5vt/U94dK/ygWG8z+ExAnR2oFz3ht0gSYjEIiFOktn
X-Gm-Gg: ASbGncvTNA9DjmL+yIDAgXsmvTiHJwqE6HnsjFeqx2e0brrkUnQCQE0ICpWYzBjkOf6
	gOPffZMXsKrCnP8zrsJfuzgcOhTfaefVonPgVE4T1pTd8zx/wLYRjmL9y65gXA9n56r0dByeMRe
	fZjMWeeGuicB7p+VB5SbVnnwplabLF9anThSLXtOnmOfF3TzXvBKr3hd8p4bnCOdM4VUJC3v85a
	0p/QQj6SerngXAbiJZaINB6FYC/B0titp/qOoZnKjj4xo6k/VF3Kv0v6FWNCNi0ECMyQ2V6zPcF
	/nDQCI25m99M0HK+M2dyYCoyy1yYQwDaz1Gy2qo+y1lGRc7GtdYnVQqoaB3Ok2ZHGHLI1mPZrU8
	AAUSMGztYYflyohk1wM3yYEKWY+bxV82R81of3JovsJ29alY+nx3Jkuz8pnw9p18856WKWbhQtm
	KrW/MbhWDxUEs=
X-Google-Smtp-Source: AGHT+IEhJrBVY2OU2QdJTvc4eWg0c6Su8jbKCtvPUTeYudGOdXSEj26zmCHIN6FgAx0W7VrJvvw/gw==
X-Received: by 2002:a17:902:f601:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-294ee479ab4mr28678895ad.58.1761810050370;
        Thu, 30 Oct 2025 00:40:50 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09a33sm174420525ad.32.2025.10.30.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:40:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 130774209E4B; Thu, 30 Oct 2025 14:40:41 +0700 (WIB)
Date: Thu, 30 Oct 2025 14:40:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: netconsole: Separate literal
 code blocks for full and short netcat command name versions
Message-ID: <aQMWeZyZoT2vV-Z3@archie.me>
References: <20251030072945.38686-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqaALex6Sku4dIYk"
Content-Disposition: inline
In-Reply-To: <20251030072945.38686-1-bagasdotme@gmail.com>


--KqaALex6Sku4dIYk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 02:29:44PM +0700, Bagas Sanjaya wrote:
> Both full and short (abbreviated) command name versions of netcat
> example are combined in single literal code block due to 'or::'
> paragraph being indented one more space than the preceding paragraph
> (before the short version example).
>=20
> Unindent it to separate the versions.

Please ignore this patch (missing v2). I'll resend shortly.

--=20
pw-bot: changes-requested

--KqaALex6Sku4dIYk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQMWeQAKCRD2uYlJVVFO
o7SuAQC6Oq6KaPgD/blKnKE2tBWgL49wdzToS+7PXDDYHKZU1gD8DYRUeyiRXmJT
h5Qq9SRDuqwPzWA50zNlXOYlpQH/dg0=
=8ULH
-----END PGP SIGNATURE-----

--KqaALex6Sku4dIYk--

