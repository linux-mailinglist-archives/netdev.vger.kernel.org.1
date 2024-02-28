Return-Path: <netdev+bounces-75832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F786B4EF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497331F23F49
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A36EF1B;
	Wed, 28 Feb 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Lx/con21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585966EEEC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137785; cv=none; b=fXO6T2KeJEleb1wyK7FZoZAIv5pnvRYbjLvXWYBatZMXyfecWKrMMfUr+MXHI9JwUrKIwAWUkwTlloYPGarbHYmSphFQC/KaTgfSwv9KkhvIA2TC9pBSM8LX35OQ7gXO0sOI5hY9xNkIKhzTnOY/zwOykjl4qHTm3qOBv9vk9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137785; c=relaxed/simple;
	bh=UV7R/aXcZgNkB2GVRI+H+u2L9N4UFIamsH2SzwTty+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7sGPvxqepl5owjhdVjcKRE5vjuqgmsGZzFkS2sIKODRZUHlOtPVVCxgPJ2z9zAQe9/+LAS/TH02GAgvO5X8DScHe2Tpl8zgq0yZvZnQPD8lNSLXJrwU6idJnJtgFLdFLSQzz4AHvstC1GXwRBInshrxFfSTKaYXH/+YTb6+QyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Lx/con21; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so236536b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709137782; x=1709742582; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UV7R/aXcZgNkB2GVRI+H+u2L9N4UFIamsH2SzwTty+U=;
        b=Lx/con21yf8cN+1PFAQamtt7AcTQNWs2ADfKZfZmHzivYbYPUOs4rwgINj6W89eeVb
         5//1VeOrjFDa5E0hPWtm0yUx3TfZCz0IdfBKv6SbOY6cnnVR9Ag/yXWG7MCxcpBE95Zl
         RWbCOz84YpDhpmNCMxjWe6BWQ6qwMtDjWQJynKTYTtGmI8f536y9b+7XNpJouwejiNSY
         bbWZwya3g53z7UxAzUSsrjHPPcn8ESs8buX1l+bW/W2xY5uy1qeltuRA0YvIAmMX3NrI
         MH6A3Swf59Hz+mfXtOnHqaC9IaYc2d+zDaDj8QYyv0Z3mXtpqxm0xH7GdeC6+5nan9o1
         Co2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137782; x=1709742582;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UV7R/aXcZgNkB2GVRI+H+u2L9N4UFIamsH2SzwTty+U=;
        b=Hn1463U26JFvNP0VkUPGLWPEPOePsPx+JiLgDh2t3EGr8G7xvOd6tyEZI+0tkl3NZX
         65cNHpZ33MkCdfmpY+OVXDGhUxiQeB/HyFD9K1zB+csrp+5UrfDHB+yaCT00SFHwyDCF
         yOMH0kxIZEF1goKzhamwI2epcEjpxsBphA0+DaD/5KdAtHeJiI0jnFxPDPV1lm5Llg4U
         OR7wRBvY7mBRmRju6Zcn3XxGKcYenb2UcXBGjcuCsOt8t4gtpjTN/80hSPRU9oNbFRxh
         OchEhPKeB9SJn7liiA4B9mZeZql1fZoX5FUS058y0gXv0AwkPkijG5v0r4BCnNFnQFdx
         Molg==
X-Forwarded-Encrypted: i=1; AJvYcCVsy0h91ZSTk2M6R5qTWEbkI3Wacz91sQs+nk/wkBYzffEVoOdc6QXUI9xKbWICY+lSrNbrRlSRwqzUCwH14gP7+sHR0d9O
X-Gm-Message-State: AOJu0YwLMv1yeN8vNmeJpud2Wchh03PSQJixAOMDPw5PXyGg7zzkozvc
	Y9FxItw4sjzzAqrG4AiSp+hRpxzCRKIyoDDGcfCR6+SGYMqSxwaT2PhqPtiiCkE=
X-Google-Smtp-Source: AGHT+IHJoTy8gFeDdE2VE5kQBwxgbeLPa8ZoWjN992oDb8EwiFI7OrDyjMTjiqWADxu4nYIsLg0D5w==
X-Received: by 2002:aa7:8b92:0:b0:6e4:7a93:b627 with SMTP id r18-20020aa78b92000000b006e47a93b627mr123196pfd.15.1709137782477;
        Wed, 28 Feb 2024 08:29:42 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id k9-20020a63ba09000000b005cf5bf78b74sm6712875pgf.17.2024.02.28.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:29:42 -0800 (PST)
Date: Wed, 28 Feb 2024 08:29:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ip link: hsr: Add support for passing information about
 INTERLINK device
Message-ID: <20240228082939.1b9e84d6@hermes.local>
In-Reply-To: <20240228152027.295b2d82@wsk>
References: <20240216132114.2606777-1-lukma@denx.de>
	<20240226124110.37892211@hermes.local>
	<20240228152027.295b2d82@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9SLmPWifhJBJsVbych=dIX5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9SLmPWifhJBJsVbych=dIX5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 15:20:27 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> > No new uses of matches() allowed in iproute2. =20
>=20
> Could you be more specific here? Is there any other function (or idiom)
> to be used?

Use strcmp.

--Sig_/9SLmPWifhJBJsVbych=dIX5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmXfX3MACgkQgKd/YJXN
5H7WkA//cIysKqasc9djGT1LvZuwuLdM8u/Ah2Fl75lk9y5C6CFoxBI8vWvkq6IZ
KSPS0TFFV3IuZozQdenXL4dGoU2WXO+apP21kdlvi9O0QbitO4TS7WWEh/oA+Coq
1Ypx4gTj2LIoCsurB6Fqi7/t+ecJjNemEUqmQhXOp/jt77rmevX43V0RMXU1CA8c
kdoCvSi2lKHbczZFlpiChjoGR7au9b1Vy771OjgQD0GK3V+TtI0spF2MuyEn8RBO
vsDRAg2t6UddkSUKzaTeRVWc/crmkbgkbo6PC0GAGem2cOf7DxQqn7zFsZqmTgm6
Mvv5f8i6//T1SGXkim4E/GXDB1zg6NHf6ikv2M+UvxSFg8fOOk7ECEr8FXyiJ4ic
BWSQrPa2zg57Yq9fLft0jOfJUXoe9pjPqFlRNYeE+7RVrJNoh0ZszQtSGK6PWBtP
8HyCPBhZCLWRQpJlJIcXJaVpSWL3eCYimLgEc56IdsqqSMR8BigcDOyqMoujKbgX
R+BQ2T2ZF1ksCKcXexbYo6z3SVgJ59yCNsqVvB2HBTDZkJAu48jHes+qdYDuYlW6
Crf6tixvHMUZJN8Y0cnVcwOZLBfMEYOr9ohSKxxZ4myFPdb3m8kTOU6F53cyDfxe
0uk5FevavKm4tH3Dl+C9fa4DIlQKKWWkWnFJb5zvcQA4ezvBmBs=
=B3Yf
-----END PGP SIGNATURE-----

--Sig_/9SLmPWifhJBJsVbych=dIX5--

