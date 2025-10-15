Return-Path: <netdev+bounces-229822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C037BE10F4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6922E4E44A4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6552E283E;
	Wed, 15 Oct 2025 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjtI9mlx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAC241695
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760572689; cv=none; b=ZizNA/VnBw9Fw1u8xRu0sGE2Lr3uB3EGFgn9gEO4BJAzN9Shof2v+pZ5p+cRZBMrW81uqWG8/a8BQYDbnXwRKQ11snZePqmBnBSyAlPN7hTVJZDLRrg0aG7I9Kf8YsPHHi1iBV9kpyY1oqj/qMrvXTFIsGoMChrnqAqgDPQvjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760572689; c=relaxed/simple;
	bh=u8uiznWCVqnREUf+CXO4AJ4aXCu7jmn3pb4tv4zAwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SktwKnmHu9hnv24eJIZuLVEhERV8/Zog4qFPi2OOIBDRX4457T9AIlRVko47q9Yzk1D5UBgBlA0KyMal1vTwFHdbcp/RZGTha/xiXa5O/OVQ12ewtxlRXDzSRTUsg6WxfxcJmvizJZNpe/Q+8bAuyR8uj4UQF/eE/j7fWJsH7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjtI9mlx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29091d29fc8so1612775ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760572687; x=1761177487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTdhM5dq4qUOwln9YvvCvYcbtpAId+tRa1KojSh33Ug=;
        b=XjtI9mlxHcxfCYAc0v8bH736hWP8PgdY1EZQq2al1cPk9XQ8MTB2V6afD+ezD8CaAL
         Yhkrw1XX7R9eRwFND/FhXAShDN0cKezz/19NYe/kbMOhuSvJt4eFoLrlwltqpxCguVtP
         US6GSDeCehweMYJd4FO4Wq0aJv6vpHjR5lZemf4pYkTHGZNn4kUS8MzLnVAvZ/4SPBLZ
         OTrCkbGCpDp7MINdf8hDPD4IfrmSnpEWbqur+rB0a+xwUo1fPC570Mw4qfZnxKCL8SJ+
         yP0+M8NlQKLc9Ik1sJkrl9QxnaY8qhTjm18/86ApZQ2GiqG+qMc7Y0AJke6e9gMAFa27
         7z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760572687; x=1761177487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTdhM5dq4qUOwln9YvvCvYcbtpAId+tRa1KojSh33Ug=;
        b=NEQnbp389DIL/e2a1nJ9j2T2Sr0nXrv9boXnoa5JJPKw2tk2z/vVuqw2KEUWqDqicn
         z2ZFnYcaXEXsTX4VK0cB7gxcjYI2YqOX0JYveunuhVhVrKEEl4KfhqBpTwAImv2DrgaQ
         vVLC/cfHKGRIM+aOFMEsMx1qsP9PqG472PeAt3zdyx5qTbdpd9hiT9fo0xmkMAnCd+aW
         mB64eudbbD09q3MziofbLHVGtQw93mdyaEjwO01c5IWaIQohnuFOp1S5YQLTXCNOBsj4
         YoDCueEBnWgUmIAef8T20fLODgp1QxGNYnX67x7AcrbQdQESWAOQZUS5M4KwLIdFe3NV
         ysxg==
X-Forwarded-Encrypted: i=1; AJvYcCWNWo1T/YFFOwSCJ4hMaySYNJSGt78steO/jQGm9eFNmxXCvamXZD3YxFE5dKO3fTLGdNXfpjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2CLWoqOqHN9pZkh/5zLsyHBfQXjK8Wcp80DhuHFxIogufT6k
	+FFLTdh+C+dbkFnRhxBWiFAUnd+/VX5i8IatjsxwRnm7Twp5uGSsuFbq
X-Gm-Gg: ASbGncvmZhj/TrfZeZ9dV7G24OFpywSyOtW1q+gdZpemzKEjaVYTAcwjww80W6xsOlk
	iUuk2JvBlUrj4oaGSKXEhc1MtLCqSq5PwM9B4y5bj7LSW7esdQfjJ+Ke5kjNdqkOO8Ms1bWf1IZ
	UQHlYaEQjC1pqCsNwowkh3uGYb98Rpr5TBEFWuBBQ30cG5zGW5iBtMxh+bacUfO2QFaUEAbIH+S
	OhQ/0ctaeru1isP4H+UucAVK9nTX+3TGyE/kjcB0+lAp8Xv/eBIOm72rALVqdYNdwaNeMt81E8z
	Tdb50Sr44XNmcsfYEcY3JL7GphWk9QYg6ZpXLtGmeXoWaTbCiTg5nlxwCrEgy4HKDQn0j+vhRWy
	WJx1No0uGTk6sT7m0tq3p9UYmFfSWJUXGlVD/9NqQkCxn5VJT0++IGuY4Y4wwkmCsDi925++CXg
	9yx9g=
X-Google-Smtp-Source: AGHT+IHAUXKf9omA7q8TkGJJHfP4J+1Abke/cJs4eEJgCs6mDtovqt2QgeF6g2Mw5XNJRdEPCf3CUA==
X-Received: by 2002:a17:902:fc4c:b0:276:bbd9:4593 with SMTP id d9443c01a7336-290272c1a4cmr361189585ad.33.1760572686460;
        Wed, 15 Oct 2025 16:58:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290ad0004e1sm48585ad.7.2025.10.15.16.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:58:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BDBD8420B701; Thu, 16 Oct 2025 06:57:59 +0700 (WIB)
Date: Thu, 16 Oct 2025 06:57:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <aPA1BzY88pULdWJ9@archie.me>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
 <aO_MefPIlQQrCU3j@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHKkadDGbrovTJ8O"
Content-Disposition: inline
In-Reply-To: <aO_MefPIlQQrCU3j@horms.kernel.org>


--ZHKkadDGbrovTJ8O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 05:31:53PM +0100, Simon Horman wrote:
> I would like to add the following, which I noticed during review, for your
> consideration.
>=20
> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rm=
net.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.r=
st
> index 6877a3260582..b532128ee709 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> @@ -27,7 +27,8 @@ these MAP frames and send them to appropriate PDN's.
>  2. Packet format
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -a. MAP packet v1 (data / control)
> +A. MAP packet v1 (data / control)
> +---------------------------------
>=20
>  MAP header fields are in big endian format.
>=20
> @@ -53,7 +54,8 @@ Multiplexer ID is to indicate the PDN on which data has=
 to be sent.
>  Payload length includes the padding length but does not include MAP head=
er
>  length.
>=20
> -b. Map packet v4 (data / control)
> +B. Map packet v4 (data / control)
> +---------------------------------
>=20
>  MAP header fields are in big endian format.
>=20
> @@ -80,7 +82,7 @@ Payload length includes the padding length but does not=
 include MAP header
>  length.
>=20
>  Checksum offload header, has the information about the checksum processi=
ng done
> -by the hardware.Checksum offload header fields are in big endian format.
> +by the hardware. Checksum offload header fields are in big endian format.
>=20
>  Packet format::
>=20
> @@ -106,7 +108,8 @@ over which checksum is computed.
>=20
>  Checksum value, indicates the checksum computed.
>=20
> -c. MAP packet v5 (data / control)
> +C. MAP packet v5 (data / control)
> +---------------------------------
>=20
>  MAP header fields are in big endian format.
>=20
> @@ -133,7 +136,8 @@ Multiplexer ID is to indicate the PDN on which data h=
as to be sent.
>  Payload length includes the padding length but does not include MAP head=
er
>  length.
>=20
> -d. Checksum offload header v5
> +D. Checksum offload header v5
> +-----------------------------
>=20
>  Checksum offload header fields are in big endian format.
>=20
> @@ -158,7 +162,10 @@ indicates that the calculated packet checksum is inv=
alid.
>=20
>  Reserved bits must be zero when sent and ignored when received.
>=20
> -e. MAP packet v1/v5 (command specific)::
> +E. MAP packet v1/v5 (command specific)
> +--------------------------------------
> +
> +Packet format::
>=20
>      Bit             0             1         2-7      8 - 15           16=
 - 31
>      Function   Command         Reserved     Pad   Multiplexer ID    Payl=
oad length
> @@ -169,7 +176,7 @@ e. MAP packet v1/v5 (command specific)::
>      Bit          96 - 127
>      Function   Command data
>=20
> -Command 1 indicates disabling flow while 2 is enabling flow
> +Command 1 indicates disabling flow while 2 enables flow.
>=20
>  Command types
>=20
> @@ -180,7 +187,8 @@ Command types
>  3 is for error during processing of commands
>  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -f. Aggregation
> +F. Aggregation
> +--------------
>=20
>  Aggregation is multiple MAP packets (can be data or command) delivered to
>  rmnet in a single linear skb. rmnet will process the individual
>=20

I think that can go on separate net-next patch.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ZHKkadDGbrovTJ8O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPA1BwAKCRD2uYlJVVFO
o5njAP9fbcZqLKiQ5Y2DAGi8x1JQMAtVAV+fbBnd60BnvnMaxQD+L7adTKlkQ7JC
fKo24/DpTLZ80pQ7KyjMcqGuJELo/A0=
=1UZq
-----END PGP SIGNATURE-----

--ZHKkadDGbrovTJ8O--

