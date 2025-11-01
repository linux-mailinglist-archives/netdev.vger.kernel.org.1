Return-Path: <netdev+bounces-234820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF9C27AA3
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 340CA4E285B
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697642BE7B5;
	Sat,  1 Nov 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsEDrVzY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DC29B783
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988484; cv=none; b=QE9D5f3ql74nLa2Lk3Fz24+3incLGZu8OoISP/othqbznPZxeKivfvP7mXKqTeDi0fcO624vDIuVnvRat28jVwh859LNXxD6nZ1z5GT3cybzCQYqQOjVVSyvft/yho33Wk7wcyXfCNlSu14FnBA2bC/Odg/Ar/YF1smR+a7kQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988484; c=relaxed/simple;
	bh=bcrlFnjZggziM0QjMVr/YX7dISMIrIzKScqkwXuRVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvvzD+NCSWxEpHFujhvPAxkwZuBM3T3J0yVGCYa6LddMgHJTG/NuHOxjGIhTs7Gp4x9X/rWQ0pUgH2/+zcg5w15khwOVAdTH/crTlZHjfMTNyF1lkntGu6ORUaMqnIIF55C6TE/YzyPccvw+gTpQ34pgFcb/nxXfMO5xcKzKpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsEDrVzY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso514264466b.3
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761988481; x=1762593281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjIH77hSFGTlPjPYXJoBf9VYrU+klsU2kyIOYwEmpag=;
        b=ZsEDrVzY2Sw7IOsPUFyPEquNjVCBKVmnWv8CvhQqnIXQeq+H3BHzFJk06V8dJmX8mx
         jUzED/yole49OUO3wPQB0SMnFsN50Zamz40+5u+uNNBJliE53/Xs7rsTJad/myMNzX8Z
         ykkrhhTowNOpP4XGqdNiyNmrWmcDHv4sfPLVAtFzeren6yPOTsC9AAIKn2vwcC0A4BMn
         k2urr8yCc4mpTKmaOkm41WP0ajzsZxl7YlymErFfc+6AuG5o3mOcng0R2tIFg0Aaaj1x
         C0NJhhVAkAlGbDWnFmeWjNGXXcbYOCN5ILwgK1CNa9uW5ijjQVnOtkoSOxN0zvTskwsS
         CX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761988481; x=1762593281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjIH77hSFGTlPjPYXJoBf9VYrU+klsU2kyIOYwEmpag=;
        b=bsO4OPFnKVuP98lUh7wwpjOAQOI1ykH8KOaXyicKBPm211iOQJiLIUYIGTV/ONcXmd
         4V7ACfelUfPZzf9/qlL5h4f/LRvPB/D2xSv57Ha0Df8e8sP97saxZ2meWxy/OWHXM/QG
         FDCjbZJK7fqOTnxGtJUs6jttm0kwgB79TamnAo1nMVPMKL/Xwc15esQEt1+zC+V1yIBL
         O8fg6gcuS2TFmejfaNcaHNXzrVVNWOdGPOKmibtgtoK9EsmHKAKie2aFuajU17CuUE5f
         gcK5jmHKIYPrI2ponQYF2/fC5ruDHwt2Krr5b55ft+qcJ38GMWgbTrbmn4RtodmerBh7
         sNUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/5MUFMeQg54fOyTTYMipaQ/Ki64PF4Xj0+oCj3i5k12z4KoGa8IteSF98ONsJ/yo5ITANP+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDRUx8kTuV6BO30yjgnkHtwyxcHGnsDKzF1c2fAJZramjSSLvc
	TGb7leqZyeBmPjnLdK+DINxscLHcCAzm8eROh8gx7/slXaRL9BcXpPKn
X-Gm-Gg: ASbGncsxsYy9Imar9K3MgEywu2DCXK+p5wZHKZR1KZWHSDfv0PAjE83S2hMsvpIk19a
	d//w9XqWXRQmv/HNlSCSxRNapDsVzJ1h0Xa4rZ58IbUAWqfC7/4NCOtDFNYQFnSOoBmNfhhHre7
	gBcHT6HpZL68oEV9Gk4agSFfMCLgFm7CJLit0mrSV01aRRDkSEFEmg3yJJUlsJKOKiqsSq/GoJf
	BnY7U1hgEUs/axnS15i/4kkSLMVHu4TD+d8yOLzxIZmqJexkjLn4yQX5bJxAIpW/fQjCovG8a2N
	DlfS9WzEbX+rDMqmP0lsPRofRVFDQtccDnVyf3YfB58CZhYdqyCIOHEFL2HFZC1hkm1/AoG6Nye
	Np618ZsBNSOgx+B7uek4OfKUgyn7qZbL/Z2suAtvreHSu64YZcRugKXMs7Z0M5eQbMXBup8WUkg
	zyEcSR8ZmjzV0=
X-Google-Smtp-Source: AGHT+IE4m8jWVnUeKVDtexD4VIUk1rWLovwGz6eGHJUc/54gMaEdRZBIb1qgJ3mc6oZKZWsrxXePlQ==
X-Received: by 2002:a17:907:3f82:b0:b6d:2773:3dcb with SMTP id a640c23a62f3a-b7070138988mr589022366b.14.1761988480766;
        Sat, 01 Nov 2025 02:14:40 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm409785466b.22.2025.11.01.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:14:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B9D14209E50; Sat, 01 Nov 2025 16:14:35 +0700 (WIB)
Date: Sat, 1 Nov 2025 16:14:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 0/6] xfrm docs update
Message-ID: <aQXPe49BkkZ1W1uM@archie.me>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
 <7148e00e-14c4-4eb7-a940-112e86902bc2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6h14tAqlT9+a5/Iu"
Content-Disposition: inline
In-Reply-To: <7148e00e-14c4-4eb7-a940-112e86902bc2@infradead.org>


--6h14tAqlT9+a5/Iu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 09:58:33PM -0700, Randy Dunlap wrote:
> OK, one small nit. 3 of the section headings end with ':'
> that should not be there.  See xfrm/index.html:
>=20
> XFRM Framework
> XFRM device - offloading the IPsec computations
>   Overview
>   Callbacks to implement
>   Flow
> XFRM proc - /proc/net/xfrm_* files
> Transformation Statistics
> XFRM sync
>   1) Message Structure
>   2) TLVS reflect the different parameters:
>   3) Default configurations for the parameters:
>   4) Message types
>   Exceptions to threshold settings
> XFRM Syscall
>   /proc/sys/net/core/xfrm_* Variables:

Sure, I'll clean them up in v2.

>=20
> Oh, and could/should
>   Exceptions to threshold settings
> be numbered, 5) ? It looks odd to be unnumbered.

Ack.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6h14tAqlT9+a5/Iu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQXPdwAKCRD2uYlJVVFO
o7MJAP9oppzWwRobyPNTMy/S+a83Bl9LCyQUEYE9ompFmbp8rQD+PNBr+LTiJ8ac
5XEpfnhav7RYgjmpzWnVM2z5LwA5agY=
=jv2q
-----END PGP SIGNATURE-----

--6h14tAqlT9+a5/Iu--

