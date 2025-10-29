Return-Path: <netdev+bounces-233798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88983C18990
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3320434AE28
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BED30C619;
	Wed, 29 Oct 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE8pU5fB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2A30DED8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721991; cv=none; b=n1i4EolS/RhRdXwNNw7sOqjXWu7iMuKdZOFF6HxAXf4hEfRZzf/zMuakmyG/AXj++LZNfv7VFEzrVGD5LCaCBqFcJqFDr+dm6lUIS+UqdVsWpqrXSHpTN4aewKDHKyBm2xjYEkr30jNTfQ5KUrcBzERbtAEeVR8JNuV/k6V4TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721991; c=relaxed/simple;
	bh=2kyOxJJWwjPVbI6PfmUjNp+QaO4Rel2HqvBjPB08TAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FERr8XAQuFenENXsVjSZmk0Aa4ZOAbW6lFbqzQbaEMNUoD3Wi09sZplJZBeIcJ4OgvljRHs7cYfGIQSgx9lLhnUPTnJTWaILk4XapcqgjL+TfchvwaFJuX/I7ct8m4m40bs/vaAz5p3NJaU0Y2X7lNsmQQJYLRk8J/w6G/uJg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE8pU5fB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47721293fd3so1417275e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761721988; x=1762326788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrkuTRXdhrUwPkZ8oJK1F0pLoaivBeR5il7sP7DvySs=;
        b=cE8pU5fBLqAs4RdUskJYqkWQwXrYJjCX3bhDdw5/ZAGrvFnjOZCfi2g+vgtpJmMmAS
         K6I2aG/NaMoN32lmfhftEshgnVuPIE/zmBQ13Uz0eMj0ZAj0r18Gi0sayHn6/KlKkP0n
         /n2ec+YVrIExVgDfEqNsAq7NFZLQ0nyqTuKzg3KNtSIlf+drAEMzYUT0GmW1JXZ5c+ii
         OMe281AnOSEpIprYCP3dN4/rKqkPihSX1fu3ujtQbeWg4dgtYVsmMiHWAYBzEVEGZWUZ
         +wt5W3iCKRXwees3gQI1HVB/O0Z71wkkSlvGGEcrQ48Df3l96ggwvruNe0/wl6gOQBiC
         Cy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721988; x=1762326788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrkuTRXdhrUwPkZ8oJK1F0pLoaivBeR5il7sP7DvySs=;
        b=e+bkdC6J8xz8FxDYkbdLrE0F7sfosvufz14wv3HlBL9E3zgJCJyCBW5qD9HYIrMqAr
         4dyU9yfKnvwqXpq9tFBlHDOd3dY0NDU0s7PK8hQjXnv1wV4JVJN51hrjiEeywO0DzAsO
         vmagZn+wlqNGT1U4kIT3U9m82wxS9qXCiYZlhhgN82a/2xtXxhHxhGgsB8L8Rrrm7EgA
         +xYiTZ+kaff20unbTQz8QT01G1xXnNnP65Z3eWgNDmwo0/RkkAEj2MJpXAaiM/7OOT0N
         so/Vc4svkFduv+KSflZbbENXX5mwK2qjuSJPUwpjOB33L9SoMOBXBf5LedMZAZJ376jz
         kSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpILnOpn/sn1RUy23A+0lNDzcQRXy95OzV/2ee8d8UrrqbevphOvOXbIqgXlaVq3bvuShyW/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIq/3fcnRsc6oHUY6Q/fSIQo7Q7MtpIsZvSJfaAqlbVOQ0OBCp
	GXgP9PEuFD+4H2lopCwvlBvfiGB+E3jTIOPZIhA1AxOORlslH0gHMH1r
X-Gm-Gg: ASbGncscp/zL0ek9i6KYhDjQqGnjxjJbxrc6/HoPJ2t6YQoMBtAqmpO0QCpYWv/P3L6
	/9ImqaaLigUm5cgIqwsM32v9e2NPpAQiD78BIcpZLOvJWZFkMlebLroA7J7xtoIwsnbYLeE0nR9
	fFv5WzrJ1n9bjGzZD4RD+crGeZKm7c9NB54YBTyenLH0llbO9yOXTwBk2cTHTe14F3rethYjxCf
	VqbqnlU1lYB0rlvnRR2LiRr3ExEdtV/heenMfpiysiJ7yIWg4dpxlJyJg1eY4rVDO5gj7XCWvPB
	KTZMmMHCCVldIflV8/qZ/nGqxBA2lgoaYYRQFl9nlsHZ559IgBeXaQnlm5Wu2Wv/ceoVESr4bcP
	s6Fumd2POS82McFDxpfAxVsDK/W+bUrvmoTu1543gl6UJXGQkQiGhUfjRCEgJQJ08rAEH/Ts/5f
	WOTRWxoW3xSSg=
X-Google-Smtp-Source: AGHT+IGEGOsE2OrnbbcDCdmAgcn7mj3aZWx7j5UssiM3k3nBBvBv+aa77XTfyn5OWYHEU6eg94BWQQ==
X-Received: by 2002:a05:600c:534f:b0:477:e8c:923a with SMTP id 5b1f17b1804b1-4771813941emr35517865e9.8.1761721988174;
        Wed, 29 Oct 2025 00:13:08 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm36243085e9.14.2025.10.29.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 37B954206925; Wed, 29 Oct 2025 14:13:00 +0700 (WIB)
Date: Wed, 29 Oct 2025 14:12:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH net-next] Doucmentation: netconsole: Separate literal
 code blocks for full netcat command name versions
Message-ID: <aQG-exiysk7_oX_c@archie.me>
References: <20251029015940.10350-1-bagasdotme@gmail.com>
 <4521c29e-e6c3-4d9b-bbce-8ada0dd2065c@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mYZiC5WpAgVKy3eC"
Content-Disposition: inline
In-Reply-To: <4521c29e-e6c3-4d9b-bbce-8ada0dd2065c@infradead.org>


--mYZiC5WpAgVKy3eC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 09:58:07PM -0700, Randy Dunlap wrote:
>=20
> (typo in Subject: "Doucmentation")
>=20
> On 10/28/25 6:59 PM, Bagas Sanjaya wrote:
> > Both full and short (abbreviated) command name versions of netcat
> > example are combined in single literal code block due to 'or::'
> > paragraph being indented. Unindent it to separate the versions.
>=20
>             being indented one more space than the preceding
> 	    paragraph (before the command example).

Thanks for the wording suggestion! I'll apply it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--mYZiC5WpAgVKy3eC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQG+dgAKCRD2uYlJVVFO
o054AQD43ZwtXso0ovYwZpCUIfBKSjxyG6/LhxxzQMEwtIJDigD/cgyISKbGmv37
2eNL99Mpl+HBiBw/qLw7pZhWoPi9Kww=
=KvAw
-----END PGP SIGNATURE-----

--mYZiC5WpAgVKy3eC--

