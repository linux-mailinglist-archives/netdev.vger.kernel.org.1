Return-Path: <netdev+bounces-165456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEFA32230
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A063A6226
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622771F0E56;
	Wed, 12 Feb 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjTfijJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EE2B9BC;
	Wed, 12 Feb 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352725; cv=none; b=d1XLIMsw7B+siI9dXHqG/erQCI1cUbE20fw4ljlbiUw287/L2HRBdGvmfzxm1bXK5s0KkG8+NC107n3DSnJJtzvI2zZf8VMawm0WFXNTDlU8R4/4/gMd4HFYAS29qLehsGVw7ImbuPCzghSENsfthySFpIqmv5eYLssSD5+bLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352725; c=relaxed/simple;
	bh=9pTolNQ+XqJ4URq9Vk/Xw++m/9IEeXkG2WXe/BEl7xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUUNhWxHwvdLoC86UjIVdQsVugkn1xYRqKOP3cNtspCI4CZ891gFAhUDrGT/8W90JiJL1x21nbmZHo2muYxJJrnoQPH1VgxPYod+dtC6EDt/N1J0AdTldqh/PwdkCWas+Vw/MgyG5LT3j325BDW7oV9cZ0vPuJcrKr253snisJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjTfijJL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa1c093d6eso7947465a91.0;
        Wed, 12 Feb 2025 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352723; x=1739957523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5DmmKO72SaGBOzQSc/JkhpJVRIV+UZwXCKdV/BgHww=;
        b=KjTfijJL71BIHyDbzQxawS3ZL3weSZokIxQ3i7bvPeMjQUt4fz7diUYb51IbRZKNdy
         5dT17zvU7nJkxLBv1Sic2a28jp3/xf1b/iHK+A5H3qgKZ25GM+I1pWvMx0gsX6QI9AVP
         +WYZ2+nx8LxojgDs6CF5LSx0YjIEGqGPqumC48FA9B3EOHuz3pz7YtbAOsGdo6M+Uffg
         fhLXZdd4d5u6iHtLFo7Bd3Cbrcv8LMUGFQuSlEYh4pK2h02VR6hsz6WILFH57uTfk6O6
         Dp6a9SeXG8bUfH5nKvmrAs63YAWCbva4IDibKjMFqGmM5Pg3sqRduk8YUnBkjRg7RnfB
         HtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352723; x=1739957523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5DmmKO72SaGBOzQSc/JkhpJVRIV+UZwXCKdV/BgHww=;
        b=X3HK6EXHGmUDs+6xN+ZAin9h1PsF9j4YRWKWyyppy1PGwoH7xNS0R0r9We0Xe/Yks6
         /9syJbuoA5z0mHjc9AjAaFEmbuELlQff6e0/1leIh9ry4THcG6dXQEQk5ZTRDQxAcRwa
         pmTDrEuOddLfr6rI1Ch9ahy1DFzLjQXv0dlCTOLi13AC5XRvu4euYgRq/ozWQxv0vExw
         PvGcWzBCt+YqszK9Rs422A6bNVsS2YlSopPUlTJJfmU3gHhTwdH/KGfSodVYZVW+PyjT
         jLdRKUrpOd7l+DO75C3v+fTDdxO71pv22b+3cxDYKPEAxn9xWPqm7lf3FVhSA33j/uOe
         3u+A==
X-Forwarded-Encrypted: i=1; AJvYcCUAfxPNMBDITRcKiRiRaGMcFeAYGwIa/NA4JVEkFQvVHA1MJ4ZaBSPZKt6gT/tMuipOhnWBi/A1BG9S00i4@vger.kernel.org, AJvYcCUkezG5Y1aFc13AJl72BDw1wSI32WuGO43fXtALz12XKzWDXG1MKGcPZyQMK3D10CrbL6Y72WT2@vger.kernel.org, AJvYcCW5MTxGol+6uOBxInmevJuOIZ11TYO9YgCUizDLWYT0uct1I8S2uOn9g+Z2o7XfO/qSwv5Tn67ovpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDPRvJ/4BaObC/jA0dK4bJPAPj3Z/O4jeKwj7HEhow5JO5bik
	IPZ9qWZN+yNP+LCj6HiFLBLxOlMzu6sc06sZmivuSLgXVzXgn1mi
X-Gm-Gg: ASbGncve0sPLUK9V0uF76+iQ650VMHvfG517jj0/lJVWL/IISdwt1Zhbsbigv+gxQ39
	6kbUJ0uFcJgYHevec8nXMQFi5beXnoYnr+sVv9Qp/fYbWKPP+OPxBXK/qnhvSTMJtij+A3y43Ju
	/FyISpiFPFCxRHoD52ryLsFGbFfZ+8wnrDxy85wWWS+Lj1HSKGld6gNLsq4WiurW2lDUW65ohWf
	oj7IIyYp2y4FPXx/GX1MXZMN3cOsbreq7QDOkn3Hxft6a4/JzeqklygXTD+aoB5cjTCXnJdOwnl
	kSNRg9nmfxf8o+M=
X-Google-Smtp-Source: AGHT+IHmRC7uaZIrF/FOX0ISVnivbMGm9aw43E3iyh18+4pTXlXSwaj4w0wma18l2IjmXtm4CB974w==
X-Received: by 2002:a17:90b:4c04:b0:2f2:a796:26b with SMTP id 98e67ed59e1d1-2fbf5bc07famr3593478a91.1.1739352722791;
        Wed, 12 Feb 2025 01:32:02 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b79easm1020925a91.14.2025.02.12.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:32:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B1DE741F5559; Wed, 12 Feb 2025 16:31:54 +0700 (WIB)
Date: Wed, 12 Feb 2025 16:31:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, rdunlap@infradead.org, ahmed.zaki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <Z6xqipobYH_Ood7A@archie.me>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cF2FwkLKTADE1R5c"
Content-Disposition: inline
In-Reply-To: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>


--cF2FwkLKTADE1R5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:06:03PM +0000, Joe Damato wrote:
> diff --git a/Documentation/networking/napi.rst
> b/Documentation/networking/napi.rst
> index f970a2be271a..d0e3953cae6a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> of a given type. For example,
>  a configuration of 1 ``rx``, 1 ``tx`` and 1 ``combined`` channel is expe=
cted
>  to utilize 3 interrupts, 2 Rx and 2 Tx queues.
>=20
> +Persistent NAPI config
> +----------------------
> +
> +Drivers often allocate and free NAPI instances dynamically. This leads t=
o loss
> +of NAPI-related user configuration each time NAPI instances are realloca=
ted.
> +The netif_napi_add_config() API prevents this loss of configuration by
> +associating each NAPI instance with a persistent NAPI configuration base=
d on
> +a driver defined index value, like a queue number.
> +
> +Using this API allows for persistent NAPI IDs (among other settings), wh=
ich can
> +be beneficial to userspace programs using ``SO_INCOMING_NAPI_ID``. See t=
he
> +sections below for other NAPI configuration settings.
> +
> +Drivers should try to use netif_napi_add_config() whenever possible.
> +
>  User API
>  =3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  User interactions with NAPI depend on NAPI instance ID. The instance IDs
>  are only visible to the user thru the ``SO_INCOMING_NAPI_ID`` socket opt=
ion.
> -It's not currently possible to query IDs used by a given device.
> +
> +Users can query NAPI IDs for a device or device queue using netlink. Thi=
s can
> +be done programmatically in a user application or by using a script incl=
uded in
> +the kernel source tree: ``tools/net/ynl/pyynl/cli.py``.
> +
> +For example, using the script to dump all of the queues for a device (wh=
ich
> +will reveal each queue's NAPI ID):
> +
> +.. code-block:: bash
> +
> +   $ kernel-source/tools/net/ynl/pyynl/cli.py \
> +             --spec Documentation/netlink/specs/netdev.yaml \
> +             --dump queue-get \
> +             --json=3D'{"ifindex": 2}'
> +
> +See ``Documentation/netlink/specs/netdev.yaml`` for more details on
> +available operations and attributes.
>=20
>  Software IRQ coalescing
>  -----------------------
>=20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cF2FwkLKTADE1R5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6xqgQAKCRD2uYlJVVFO
o81lAP4z/yUAyaOjOOztxdyySiDTD32H5qQDDqSlytkoDtTUjAD9HiD25Uc/PYP3
amQcPLgp9Og74lJ41fy+4Yw+Lil98ww=
=e5TW
-----END PGP SIGNATURE-----

--cF2FwkLKTADE1R5c--

