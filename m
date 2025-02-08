Return-Path: <netdev+bounces-164281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CEA2D39D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A297F18873EA
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA41714B7;
	Sat,  8 Feb 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5t95YaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF015E5B8;
	Sat,  8 Feb 2025 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738987116; cv=none; b=OjAopflYJfy+KkFwcqK/JCwpKzB/Z+2RBxk9XXswjGh15HIRwnPRVAlcClm9ppI5cmGMMNfhKDl+b61Orj5jHooePbxnNCVIXZ5hvxEDMfIKCq4mjbpdVN3tctoUhyL9kKfOIJt+/XVibRPWnkoBkuoUIHs6274QNmUf/ok7rkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738987116; c=relaxed/simple;
	bh=hVfSHYfS0vABHC0bsTt8JISrVLmvWHnTFhXTgV9zWTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1BYlAdk8atCah83FTwH4VXB2XeNLBulziS+vo9bUx97TzJkVgCdweb9BV6e7ew/w/7f2vZDccDhhQLxIEgS+Xz9S9V9q66EisNKGGCcZtAZXD6VquRgvkgwEYyoOi6bNk09PE9fims2Td5dDALY28ql2lrgC167EzfAm02jQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5t95YaD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21c2f1b610dso67645945ad.0;
        Fri, 07 Feb 2025 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738987114; x=1739591914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snSzU3y4SYB+Rvb2oNUbT3gLzbFZ3CF+oDS8ezVbZ0Q=;
        b=l5t95YaDVG5d6rSi9CxAW0lxo7MMNL8Bd/RzknyAO4TJDdQyrGTy/h0wpn0a27ha7G
         HXc8QXlwO+DyoXivSDtJoo7X/PAHkmvckADve3m5Ate538Iwco9xdjWQdVIbyii8dVvS
         G7t04RjaUxAEzn4XmY+lgA75DfxzN/gBnvEJWCc3dpq5BzZEf1BSoEHH764H4+kMqQuJ
         kNf06QkTg6lVVvMNykQS8QBaleEBhuG8TVMwdVBCB293hf6HO+mVC0gPdkAEYE+ikd/c
         Zdqm+AaHrSzolH/mnmhLYEiC7lYgtBRenp6d25rYN5P5pG2WXjiHRdALpsjPoeMwtOKE
         6D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738987114; x=1739591914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snSzU3y4SYB+Rvb2oNUbT3gLzbFZ3CF+oDS8ezVbZ0Q=;
        b=uyBOgfFLOADLCwi0uKH6kJM71HjwTcjy6zGBPrV9CFl/fswxdoJiFuKxIxGpIOSJOI
         N9xxTfTmvSW2D7ndLlmLPG3Fagh4jtshClrZ/QUSCQPQtxeWgsf4kFKQYTWdCsbKx80/
         mBSDc0XPB6gCzEKyYeKgeDW8QTx1clKz2sc4KskgTg+Vz+P4Ixk99Vd0ORHLU4pe+XUa
         xNspNo+8z2TeXfWuWU4gzBMWPDuQ6Ra5hHvck+3H5aruySnNlSwpNdKRG4ZSgO2LLXw7
         DsXx4W19yZNWkT/Fn6Co6H/g2mUfecFFZexxO7YwWgFM9tOBVJC3uwrxDUj0rjC2RGb1
         /hAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/kRuow/Q6fu/94wEdIjx7OM3NdxyuNP/QUQ9tXlmkNjMgUyeCjxXWb+9kPVuK8wtNb9GvFKSBjhg=@vger.kernel.org, AJvYcCU0lpS5aLQViOvkvTrbmULCYmLDBckSqjSJPsNCCxc0mC5BXBEH9M7Km4HeSH8V/f0zQP803Wyt@vger.kernel.org, AJvYcCWr0oOOvkVYrjxl9GK8DbK9pu3g7zjzxhWGCMGkZZvPELAEoMqM1KidzIMvRJIp7J5gkayPGkedyT3cMJY9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsa4/W898vlCi8dx3BmaqRHFqrkK2j/SjpsCGRbPyThJnD206N
	ixPb1vz7WUmSRu1XDwd02IcC30LNFuHNhh/mkCIK2E9+1V3oRr3y
X-Gm-Gg: ASbGnctIWmN5cxTmr75ygRdvQsOVTObqxBSvC0n8c0EXD6kpVLDoqnLCMnG/HnDl96h
	IcqQ02ZSoAB9SjhBGPP5IJ4sQkwnAJLoCW0CgelYP3GIu/5uTWDlsT5SKymxkCnMVL7XDX62QHU
	7+9C0+v+ZwPlTcVDdvZ3yw/LGSuH2RiFDs82IS6+644JSNwR8TpCU3SJ0YZ1VtFoJP9G5PYMNXJ
	wde0Zi0Zy42bJYUWU8oMJxReZKDhpAbU5uIumXKRHBV7DhPB+U90LkypfH8t7LFSCP5IuhZ/E1Q
	djjCjtcKElp06Vs=
X-Google-Smtp-Source: AGHT+IGlsdM2otW4mn5iBpSVAmZG13eaJ1Xemc3rUL60sZYfVsoKnhpX29usQLefCuYDuc329vvVdw==
X-Received: by 2002:a17:902:dad0:b0:216:42fd:79d2 with SMTP id d9443c01a7336-21f4e7f1129mr92878125ad.49.1738987114018;
        Fri, 07 Feb 2025 19:58:34 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0cceff11sm4156460a91.10.2025.02.07.19.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 19:58:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6CFD84208F47; Sat, 08 Feb 2025 10:58:30 +0700 (WIB)
Date: Sat, 8 Feb 2025 10:58:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] documentation: networking: Add NAPI config
Message-ID: <Z6bWZkf-xm0EB6uD@archie.me>
References: <20250208012822.34327-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QJo/HyYKmTOzl2kz"
Content-Disposition: inline
In-Reply-To: <20250208012822.34327-1-jdamato@fastly.com>


--QJo/HyYKmTOzl2kz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 01:28:21AM +0000, Joe Damato wrote:
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking=
/napi.rst
> index f970a2be271a..de146f63f09b 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -171,12 +171,42 @@ a channel as an IRQ/NAPI which services queues of a=
 given type. For example,
>  a configuration of 1 ``rx``, 1 ``tx`` and 1 ``combined`` channel is expe=
cted
>  to utilize 3 interrupts, 2 Rx and 2 Tx queues.
> =20
> +Persistent NAPI config
> +----------------------
> +
> +Drivers can opt-in to using a persistent NAPI configuration space by cal=
ling
> +netif_napi_add_config. This API maps a NAPI instance to a configuration
> +structure using a driver defined index value, like a queue number. If the
> +driver were to destroy and recreate NAPI instances (if a user requested =
a queue
> +count change, for example), the new NAPI instances will inherit the conf=
iguration
> +settings of the NAPI configuration structure they are mapped to.
> +
> +Using this API allows for persistent NAPI IDs (among other settings), wh=
ich can
> +be beneficial to userspace programs using ``SO_INCOMING_NAPI_ID``. See t=
he
> +sections below for other NAPI configuration settings.
> +
>  User API
>  =3D=3D=3D=3D=3D=3D=3D=3D
> =20
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
> =20
>  Software IRQ coalescing
>  -----------------------
>=20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--QJo/HyYKmTOzl2kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6bWYQAKCRD2uYlJVVFO
o+auAP9tc3yGiExQWnNTRFcDQP5rMd2xy503uEVK/Ys92j1Z8AD+Pjr/rgz8jdL6
O1asp8NUqDkO59utbN3j9OVOiMxUGAg=
=NlDe
-----END PGP SIGNATURE-----

--QJo/HyYKmTOzl2kz--

