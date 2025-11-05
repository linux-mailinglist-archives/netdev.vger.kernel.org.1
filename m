Return-Path: <netdev+bounces-236092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A9C385F8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 00:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562BE1881FA8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F1E2D0631;
	Wed,  5 Nov 2025 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWw1J20y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17944221703
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385560; cv=none; b=lfZdJotKC5y2xDD281ew2R1DHb35TQYmNEvVAaoW9jKU2bflUra29wltXy85eXr3653wmDWzS5ZsMJ1EFyiQSQod/Wj5XicPtrAFEP71815RxDTbAWbBuqkuKpFOf/hL69KKP0btyqF+w7NwINMiCGsWl3m8R/76krYhanqToFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385560; c=relaxed/simple;
	bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYocUDVBDd9AxUN2kexkLaE2Fj74S2sgGRzpbjm/ry49my/hyMJFRRTiHp4aG3XD57vit8MFMbkX9FfFX4OmMh6Ml29czVH5pXyfrNlcUOVf2puzmvaJyHFwRtheNXk4k0E3R82Cl5Aub3Oc+V86ePW61wNGS3VB7YpNhmScj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWw1J20y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294df925292so3753175ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 15:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385558; x=1762990358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
        b=FWw1J20yRloskHdSuQWug5keqgd/8WSM/HclUUIknagWX4nXL+HnS9SzgtDPAhTiTA
         MfxUQoE4wh3xS/TZGb/eMkxvuzI9RMOR23MLwdJgevFkv6obOvbUnA/JgX5FTgOTqOVH
         B4ULf/UgKoE5kbXlQ/y9io0kOwJI+ZFhohcY9mdc2lNwY37Y0Z6rbimuOQCnGKlwhuYA
         TgEDHAxCR4AcFprtUMwUAf46Lm2Y02V8K32mpfXIcfVhfmQHSgpzRnxOmhXIBCLjvi6L
         ppQOj80IDomIQiZ2dQvGHJ+MgoL84yuFJOvGmIxY7czD0Fa19/p4z5Usms35sBGNcX0j
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385558; x=1762990358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnTm+ozSRZaCK9bpPSSeJvTXgMs06nW1kYwVBeO3ndE=;
        b=f6JVuepedncDWKS7DJp2JRmhz74Qp9wX11qc9YJ8U+zXbd2zDCYicHfe7LyYwS6q1M
         e4bEIaawVgXo0wYXsxbg6/SDVm3n7B4HcYUsBI/uWnDwCFdCBKcQHCpt0m60CxgTaNuJ
         oQVWaZep0O/XH2Ic8MQkpZ+gh3475GpFM4nOrmkCup20h2VQGaZtYr43zLz7VPsdxUtk
         s2CLwOUqA8mRn9mqp6FZOR1has5ubsRRIKd3vlLPjz1m1zoIefnb6CCEjuzSWvoVGGpr
         Ts8bO606FTaIjknxJeOwnV570bLMzfgs69Lugf028etklDLW5bER2VPeCtY++21SPYE1
         4gUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9yqo/Hg+xE3x4mDqquY+RaRktF8SY7bJ04ru/6I6JAix2k1W3bH/fA2BCr6lx1HS07oUcdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyof/25hsEym+gp070rgNaxxL8p4Y5Rn3PV+T7LGS0SV7OLhSO+
	k2woZ1ZhUEBWNumXsuSSCdwv2FxD6bwEzXHLVN+tCKawHQZlO/BIoWTl
X-Gm-Gg: ASbGncvStf3qxs/LpjFzXsBR/z0vnKpbMlcxptSEdcs6NWOu8KYJjvT9lcUUsJcBAcb
	rCkCWeSCyHEuNS+aLix4TeMZUhKKXi1jSmsbCc+KW25dNlWvSFUX65z/yljdczJdaZeRbVbtspv
	+uNycxt9ubQXHtmUqGObZr3i3jML8snVVfxdqveLDD5vhovzeoSVY2xAZBJkUV71xF8OFFegfBV
	xaW6V7EOcxXGJuSlziVT3QGuBWA+cX7qCK4RNSXjb3Ft84vQ2oyXl7SqwrRfWAIyUdrgUtYwORo
	SFX0ChV2iSsWwTmc7oZyTsxVwhRgGXGdW4wWL1vKh639HHFRSpaIhtlpUfK8xqDg4wT9w3aCbQ9
	sJYzh29aELfV1bPKR7VAGOc65oDQlRleKCvvuokbJgGTrPA1UWFQbbNwaEYFozRXzWWFr+rOiPV
	843O6CCP4EBr4=
X-Google-Smtp-Source: AGHT+IEhPmuR4erigmmxR9eFUPzgSmw6sxAsUVA7h4flt4tHbzQCGMOXFc5w95RmdKQlTP3Q4hRRPA==
X-Received: by 2002:a17:902:d4c7:b0:292:fe19:8896 with SMTP id d9443c01a7336-2962add623emr67834225ad.52.1762385558111;
        Wed, 05 Nov 2025 15:32:38 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm6499405ad.57.2025.11.05.15.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:32:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DC583420A685; Thu, 06 Nov 2025 06:32:29 +0700 (WIB)
Date: Thu, 6 Nov 2025 06:32:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 01/14] ipvlan: Preparation to support mac-nat
Message-ID: <aQvejbf52_GDs9vn@archie.me>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aE3/3REKYeQ2PROd"
Content-Disposition: inline
In-Reply-To: <20251105161450.1730216-2-skorodumov.dmitry@huawei.com>


--aE3/3REKYeQ2PROd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 07:14:37PM +0300, Dmitry Skorodumov wrote:
> +4.4 L2_MACNAT mode:
> +-------------

Please match section underline length to the heading text.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--aE3/3REKYeQ2PROd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQvejQAKCRD2uYlJVVFO
owVcAQDm0PZzhhqLqUC27UoEFbWfodx6ifxImkkq/tQWbG9OwQD/XNmP5oJqoktv
FtqxdYVTu3c9wN0sp329mXF1ZLKppAk=
=OcFx
-----END PGP SIGNATURE-----

--aE3/3REKYeQ2PROd--

