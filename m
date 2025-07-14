Return-Path: <netdev+bounces-206477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B81B03414
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78E21894C41
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6D15B971;
	Mon, 14 Jul 2025 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1CIfxuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB21FC3;
	Mon, 14 Jul 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455106; cv=none; b=YZYSc0nE4+YOpO9x5Zkk/xApt+PuSVuGadXONxtB31YRk8oIHC+eGidwzESdvUCNiLXg8OFFr54P5QwbMaoAzDUvOe43dkIeQ6As1nizKH73VJjpIU/AvwbFEVP1x55Q/DARXpkSoMotRWdMetIc8uWmu5iNi1c9oSKCS6x3QdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455106; c=relaxed/simple;
	bh=E/HmxZ5n2gH3WP8x7Vk/0dgXQoFkSgWA2r9qtpCAcU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvnp+IaV7A6m9gpcZCw+2eOSh0o1uJETOeIAae9bSYpw7TulnsWsqafzTKLIQLnFgsr9nAe5eiDPVZDFGmyBbz5SKxFS6wQHR7WkUkg3L/j/dDrAPNaQRqBt08c4fEooTdZFHXzGxFIrTapV/okZaSNeR45KIIZiMaVpHnOmO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1CIfxuy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so666164266b.2;
        Sun, 13 Jul 2025 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752455103; x=1753059903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgjzoolF9QAkZAGrz9Zh/lCii89swrUvWtInk88c+zg=;
        b=A1CIfxuylgfQR/8/i2GOtOheK9qIeNmj7X7xmqXRboiOjNfFnaa7e+yJoq2zq0brNE
         FYrGjXxcQlk7q7jenaKNGMRqsYP+k6YTKNZlyE+3kqzZXE5juTmlo1NPRIEzX9Uqocai
         a6vW2I44mbLjp1e4DVryoF3Xlknyob2J02vyiWUNlaV5msMYc3jQz6Ble2mO7xEC+mO5
         kk7owijORhhKYOW8U9pTzVUb7jsYZ7STseUF4PEGdfzeTFhJXYgLbUkZanzyWX9LsPvU
         vns/3x5bDBkd+aOiaIpxzpOp5KyVl0rdRu/XUnzpdjTFOzUwl3nGAZUkHvrN0d2YRwNR
         SwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752455103; x=1753059903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgjzoolF9QAkZAGrz9Zh/lCii89swrUvWtInk88c+zg=;
        b=hwYD+Kxfz7lsklua00ngX7cB0VBfP2I/cqS4/DR1Jn4VwKVO45S7v0E6guVDC4Votl
         4OUU4WuLzpoo+aAwxqnPnUGcEBdNHdqPFeVmPy94ukFcBOYAdjVQe0EJGWnhbPmgHUP2
         tPPP9n/I7lSiQVfxIh8M9kCRoMCJGmc3av7lYFl1ZjlScPwPaRU1SrDrYIfmX1WuHkGv
         eWpfPsyB8iqOt1r0hD+4mGVfq6GPSEWpRY+z4G1v3fo2gMOEjkmgtDsWfjR2+mUpG6J+
         fnK+rwdKga9BMIe9pPT+F7FoLnhLS//9c6IxZCCcOoNW8DFrVXhYRCobsuRhDqdAsvW+
         BPpg==
X-Forwarded-Encrypted: i=1; AJvYcCVn1bVLm7SD2oygJnCgTGqOY3Q/9yVqR7Y7lQf/vtaZqD2AEZb5oEapuGWZCgR0cRqcaWNOfOgE4io=@vger.kernel.org, AJvYcCVsJTYSngMdBkhcQEgUx+XRWN0b2W/8fqbWv6voo7guU1i7E8wE8s1Zso9Wgm8DICmL9dT/A/qb6Nlpsbnf@vger.kernel.org, AJvYcCXaD7Z8dnyF1E/JEgnO1Wp4r7FfpymRNocx0x7OZycLw9dS03Tp7I5xcEdkyeK0fkKN5/LZnNq9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fjMg2nOsWijPnpu+F9HYZDRz4ckLldaXUtRJ9UwWbDcJO3F3
	zkF/zXm5FxUqxUwgFKVCns8SjTgtwFDHq4sZ8kHwMEkP7lKN+6M/xqf/ERckWQ==
X-Gm-Gg: ASbGncu507Or93mNRMf5XjyVH3hk1vMyzGu4940OzSnem3OeFmLhxDYkPpAoTxbE8Yh
	yOsJYi+Ww8R17b2mSxPyvCpfs+GrL8bk8C/V1gVfj4CUzDMRXDRAvC4ZiKMSeteBtELbTF7N77Q
	yz3mvRRqs8yflEK3NDZ/2OlCpmfdesoEJZsn9cDUoKcyfgX9TF6TbiQ5W2q4Glxq3sJth7RRZbn
	CLGbTFisPjLK62yJ52HzVJ9oBtPHfbYIIVTqavwiCMoM587aSfreN/D1Al3NQakgFimuXcevaB7
	rZep+tEXXd2HQlcA38NjdTaq5SAu98Bx/3YtO46gllZGKCsTN5hJkc9CLMWQJ36UwKAhQ5qYWpv
	xcHDqrftB8krGDGg3ikRP0A==
X-Google-Smtp-Source: AGHT+IF4N0NBIMf66QVWdB2Wvpxc2yAm9emz4Bom0q51CWzc2xcY8yNkAgcJ3cJqRGg6aAKkWLvcpA==
X-Received: by 2002:a17:907:6e8b:b0:ae0:c976:cc84 with SMTP id a640c23a62f3a-ae6fbda3f38mr1099077466b.24.1752455102421;
        Sun, 13 Jul 2025 18:05:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264756sm737302166b.105.2025.07.13.18.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 18:05:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 52EAB420A817; Mon, 14 Jul 2025 08:04:55 +0700 (WIB)
Date: Mon, 14 Jul 2025 08:04:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Haren Myneni <haren@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH RESEND 1/3] Documentation: ioctl-number: Fix linuxppc-dev
 mailto link
Message-ID: <aHRXtzxOeL3CnR5L@archie.me>
References: <20250708004334.15861-1-bagasdotme@gmail.com>
 <20250708004334.15861-2-bagasdotme@gmail.com>
 <3cdeef45acba94a1ab14e263cbb9764591343059.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KXgAq2S9Sh2ErA+o"
Content-Disposition: inline
In-Reply-To: <3cdeef45acba94a1ab14e263cbb9764591343059.camel@linux.ibm.com>


--KXgAq2S9Sh2ErA+o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 11:23:30PM -0700, Haren Myneni wrote:
> On Tue, 2025-07-08 at 07:43 +0700, Bagas Sanjaya wrote:
> > Spell out full Linux PPC mailing list address like other subsystem
> > mailing lists listed in the table.
> >=20
> >=20
> Please also add:
>   Fixes: 514f6ff4369a ("powerpc/pseries: Add papr-vpd character driver
> for VPD retrieval")
>   Fixes: 905b9e48786e ("powerpc/pseries/papr-sysparm: Expose character
> device to user space")

OK, thanks! I will add these in v2.

--=20
An old man doll... just what I always wanted! - Clara

--KXgAq2S9Sh2ErA+o
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaHRXsgAKCRD2uYlJVVFO
o9QUAP9hSnB9sVrTHZuYxdfH5z761AvDoeyCceLOal5lxQ5VoQD+KxDB/HFCPvXc
UeYj+rGMuNLiSKWOuxQcSY0TQLyOcQ0=
=Fvx7
-----END PGP SIGNATURE-----

--KXgAq2S9Sh2ErA+o--

