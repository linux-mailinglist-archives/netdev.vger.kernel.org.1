Return-Path: <netdev+bounces-232012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B7BFFFAC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9745A3ACC07
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D53019AF;
	Thu, 23 Oct 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJjFc9O5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D0301707
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208997; cv=none; b=NQp7plQyoqHrmgang4cEvpasvBAALapqcI8QOf2h+xY+BrPPSq3rnCMseB153c+XUaWljZ7emoyyVdwD15ARrEmbwei2DM/rNcs2nXGBx95e8RVerHYjnU++HmGLzhbiawdhMoXV4mHdaam5OtQ6UZN7LXPOdN0nGR4C5IhenEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208997; c=relaxed/simple;
	bh=h277j0BdJAJJfrnn3LPaDfuaMi5C0Xtj1wAoSJszDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJwj5JiQpUujJ7I8wz2Qt5GQBfZwoBk4ZXI2NdK0jNk+6BVPKzvy/qJEfFWtWxbtHH29upumtvB10sN+cSesV+zFdvxqdMe0Cj+n0hX8sF6+F3bp0yu9dwb5dVT11eFZBR/0Vm4ARmRIbhCvUdcqxI5u8HMqRSRmjyTIX2uWSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJjFc9O5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b679450ecb6so428676a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761208995; x=1761813795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqheznwEahoAcIc95fCF8gQr8sHNf2ct8iY0MfSeg6g=;
        b=AJjFc9O5UZLxwUqH5yBwCk4w0whgnAKEYXROjOGZwucwIMD8k04nBxjBxte0aZY8NL
         E1+oAJwO0iYWuzKZ45foqRGzebxOSm5+4M1koj0jxxDntetjG/en0wMr4Ufz5BczRs8t
         5e23RVZPdMjoDm/FW4u53FMltS0HHnImtwB21Hj2GE6B+sU7Ws85iTm7xNSFDRvW9tD/
         AeWa8yRnmsiyNM6ZKl26R59nDcWfllI9i5zYs1driEyPMLkc6SXVi3wuSbnfPI0FG95p
         CRHi9eY+JOWvlHLRgV73oDrvOHgRAPZqNHGigmFUYr5ib72OyLXpgi9NqyLPYDIuDsiV
         T8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208995; x=1761813795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqheznwEahoAcIc95fCF8gQr8sHNf2ct8iY0MfSeg6g=;
        b=iQY/dj4zK9XwHNTK+N06k5D0ZD/ER1btjOH2Nxw263TeAhfY5jCbEO0W7/dCFIJena
         CexPKiS+RZabCbZWCT4no4Td9KdX02MvKZNX2XlCmBbfWvBg18Quf8K8IO95VSdscYDU
         P22yELDma9fwNZyxmyASuF4tWERhzfl4ERD8arT6PktFd236RJLWPDUWR0A46GlaZiNa
         uQpg2UEfPWGmYSxg2jL3vUb5Oe9i53crZmDgIvQ3m+Mn0YfrRMp34nw4I+PrG7lHQM3v
         ZR9/OD/Mm4sg2Phwp65ZvIu4/ICk8CPugbnOemg0vDIC7Da6tzWZRNR+fSzaX5SiPLtk
         ptKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM5VZ2Fjn18a5eMubj2PB8QTCoXPWYTvY+0/YLwq4Ua/HGxzQPZBL5rGQfFRA0osZif9duszk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+lxw//3rSOjX4/sTl179WxE/d5vqXF0dMFoB5PZKS2EPA8r4
	shxlGcptl46ZkAEDJuUZ4hqpHpib7e+hDNoUIgumaI5eYpA1EnUeCF+N
X-Gm-Gg: ASbGncvbm6nzRc1dVNdnZUa4xGlkUG+WlB8nAxCmKf+hXnjuBFn3gjMWsX9SVmTn1EL
	NkgvNZkl5Rc/S+T5B57pvEL6V5wPjdgg+T/cdf24v7VkSNCaBUeAi2B/Pw5qaHYxFwJTij5z1jN
	RNMoZJMHCwNN0SKxc9svHj1A0MhnJdx5t+gYrodO9rL3RbhCIo7nCg2txc+nCZU0/nllqVSJih9
	HYkW7U9N058rKNEr8qPzqO2fvW40cm8fQDTs5JbmOgyIqJc2pGYHIgwCFlTcQC9IKABq3LiPAxI
	N0yMbyflWs4GFnR//+CyGU02Dq1BeijWHuvvTEPR1rk3zHOxluD/EOCwbb6JYWQBC7ZbQNF29WV
	Wu2ehHsPaG3bujx3kFb837bgV9Hcy8iGbR9W30TgEmXF3ObF/sVE8HjsNpV2Hd3Fq0bqVPYoije
	AQ0hjNXdfH9/w=
X-Google-Smtp-Source: AGHT+IHEOgGN5yNyJpbzAdkY2kAXHAbs03hm9RTq1jzAuwC08hoEOkO/K6ScXyZjbWhH2WaZz9e7+g==
X-Received: by 2002:a17:903:1c9:b0:278:9051:8ea9 with SMTP id d9443c01a7336-2946e117e69mr21542875ad.40.1761208994856;
        Thu, 23 Oct 2025 01:43:14 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e21fbbdsm15563255ad.99.2025.10.23.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:43:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 94D994206924; Thu, 23 Oct 2025 15:43:11 +0700 (WIB)
Date: Thu, 23 Oct 2025 15:43:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Avery Pennarun <apenwarr@worldvisions.ca>
Subject: Re: [PATCH net-next v2] Documentation: ARCnet: Update obsolete
 contact info
Message-ID: <aPnqn6jDiJkZiUfR@archie.me>
References: <20251023025506.23779-1-bagasdotme@gmail.com>
 <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sYkyoOFIpjBoikjz"
Content-Disposition: inline
In-Reply-To: <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>


--sYkyoOFIpjBoikjz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 09:21:43PM -0700, Randy Dunlap wrote:
> I'm wondering about one thing in arcnet-hardware.rst:
>   it refers to www.arcnet.com.
> Did you happen to try that web site?
> Looks like it is something about AIoT.

And it's membership application form, though. (I'm on the err side to not
enter my personal data there.)

> I found the ARCnet Trade Association at
>   www.arcnet.cc

That's ARCNET Resource Center.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sYkyoOFIpjBoikjz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPnqmgAKCRD2uYlJVVFO
o1d3AQCRe0oF2MekWkvylVGpjC6ok/H13SiWxWu7yovWlHyVCAD/eYNUs9+dyZCa
NX/jHGU7SuQ8ikjpge0Y+EPxhi4V2Ac=
=jNqa
-----END PGP SIGNATURE-----

--sYkyoOFIpjBoikjz--

