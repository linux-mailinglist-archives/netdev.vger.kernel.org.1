Return-Path: <netdev+bounces-238377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249DC57F1F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06BC235929D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255E28506C;
	Thu, 13 Nov 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJdhqnK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nw/zRJKk"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E23287503;
	Thu, 13 Nov 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043877; cv=none; b=NVyTXoNSvPTiPO5XZeBePADlacOrF0WV8RBbfzy0DqaoqqX8wGP+KsaLUioK94FdAxN1ALqsuJjKsZ5WmyzpoKsdTDbkfpG3eXk5ts8Vn1Y8K5rW728fPixMIplzG4nKPDUswpX9zuMluagoc4XK7eHrjjyRD0BQFHz9bUIm0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043877; c=relaxed/simple;
	bh=eo9939pfvnlDo4pJP2jZvQpJQJTZ52rHWEAb4cinhCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjbPTj4nYoA0RiCzSa3rj6DvA7SXywFwU98LVCjNelIUAwGxYcS62F4EuAXCmxsWo+2XMgcI/7vRhq9WFuNUagS7Q3gPsiUevGKTTAktW1zOr6UFZ2sSpBWY0wUegylTvR5usSZWBQLaiufcsKKJKk9r64IhdzmjJIcqrWA2kQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJdhqnK/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nw/zRJKk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763043873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eo9939pfvnlDo4pJP2jZvQpJQJTZ52rHWEAb4cinhCE=;
	b=sJdhqnK/SkR73TkX52fYDI9lwY0F/0lAxT1n7PmaMi/gooyOqFMF0a0AjkHEzJ/60/hVtp
	a74HTyRwjOV3gQA6HIJ8MamtU7Hjy2ujzbYxYWo+w0qKVE6TyNX4DM4JASZ+HHf9gQ22TQ
	Ezav1ygRY8C3JDJ+eVGL3YvU0ez5XC7yheaFCxZsti87XLokjbsm5v09FnEZunopChbbkK
	zIt0YHqwq6QCbv8tmtvJbzuUFWPt8+ncDcqNb93soETy4CKJ0H5mYy2BnB4TPDcLLWQK1b
	mwawYdAdJxg1qLiLcp3M3NiBLsFnPqLpl+ciq2QQ4w3MJDP1bCfuELwyTK6m1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763043873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eo9939pfvnlDo4pJP2jZvQpJQJTZ52rHWEAb4cinhCE=;
	b=Nw/zRJKkDdvLEvFqJNhVgpiMpJTmcGlVLaICtmITHYm6/93GT8cOWkk5vhHnvqflWDhlUI
	DQNEvUxrg/SnqvCQ==
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: dsa: hellcreek: fix missing error handling in
 LED registration
In-Reply-To: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
References: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
Date: Thu, 13 Nov 2025 15:24:31 +0100
Message-ID: <87v7jej9i8.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Nov 13 2025, Pavel Zhigulin wrote:
> The LED setup routine registered both led_sync_good
> and led_is_gm devices without checking the return
> values of led_classdev_register(). If either registration
> failed, the function continued silently, leaving the
> driver in a partially-initialized state and leaking
> a registered LED classdev.
>
> Add proper error handling
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 7d9ee2e8ff15 ("net: dsa: hellcreek: Add PTP status LEDs")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>

Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmkV6h8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghh1EACafD9DxOIh4f86GMXXNDnszrPeFu93
U2U1D2tm9oKwrXL6R9mjJFsTCyiOS/QH44DE8RCCL9FmiIugXs5heiN7jf4Fdc6n
mVDRjGMUsGvhsb9EviQmtEtE8XHPPMGkwqjujwdvscXLd+/MBHl6NwzNNXQhaPoX
b4NLArKyBuhjAcl76ir6yE9b3lO2MjPUA6qM5ZSa9eYSGjYJbEtR4wQ5UrwJsuSI
7gCqONu0w9k15sbQ7i259n9lX6vI1TAba7+Nd5nnypdrJqQaoPdFEOcTbLYwTtA6
am0aJ523+SsgDKC/qkigq/leWscOJFj/MZH0ErQarxBjEy64Dy5wWzRFS4PsZivG
QAhbODIUHPBDE5JUTjBtI+eBx20iHT2JJHHM4Hs+1Mhul4oYPfKt7hqE3a39WOyd
DnLymU/dIdIQNpX98Q/lhaZGkBuByRALSUu3JQuDCcc3hdZC4excjm7RC2FuNTJn
mOfPXMoQ+tn/ChG/8aPWcIvii4CPxg1LTv2mE1QF+1P9ugbxW3MVcYuDq8kCch/H
Uf5PE7c608jgHAGjGTmGo+8wJHcostvLgY9JPtjMweJLGlfIR73ThYUYsM0ghlX8
uLHSzj1NclDQ51Z41qASNC0ti/TUdS6aLYK+7kDXtww++Z07+33qMeBrUPXlhQcp
UmgkJDEizYooWA==
=6Ohz
-----END PGP SIGNATURE-----
--=-=-=--

