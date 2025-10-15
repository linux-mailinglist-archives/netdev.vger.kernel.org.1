Return-Path: <netdev+bounces-229821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85502BE10E8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CA719C63FA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6D1F91E3;
	Wed, 15 Oct 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmNo3KLc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6D239562
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760572608; cv=none; b=r1I5Py/Xz8Is9L8hsOdeNB44fyI1JRJomWm+c5cMo75siFQvNjlQrCeJa5Oi0PbNYH2ElsZZaZ1A5+hg+AKk+OJpOjN3tFAtl01P4fD4mOs1J14VY/7nuDZ5cW8kwXFaRrFPxYY5I38BxexTUi2yG6GVyIdC0UFwrgEFh2Zm1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760572608; c=relaxed/simple;
	bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2uMzdSltgGSL8RS+3zVca6LWTb64ts3SCfrLIPPif/G6tYDJCAVICuQkEXj2uJ8jaTYe53JcKhjH3kyXVYFt63w2ezgtHdl5HzQr9FtsBvPlYiKeAD1FkCx4ZXV/6F6VsYB+A4HoFW35k2tficax1A4OsI9QzbC/HPmLHpq8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmNo3KLc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28832ad6f64so1637545ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760572606; x=1761177406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
        b=EmNo3KLchX5BOKY+Gug74htQ8237XXTPl3MyGg0kEITSNrVU8h1+FLzUn28cRCsDPA
         llyHcg+S7CNE7CkiQHold5YA/XgVMZmYq1sIB+nIcBrEtFlnTI5bLbFPQa4a7yTOiZno
         9eAQLi/pTtJRsshVJ262jo7eCXIWorVjq6ADgz0EejBNAko1bw8mztDFN2kvdmFal2Ub
         8fgIYZGor3QsKXjOsrbL5/Hllp/ttwSCO+pv2ImM+sGSRI24e0GouTxd/VEqZiQf9DUh
         Ie6DG8CZ+cehNFLnIRPmYVMVOV4NsS8Vg35M4BxtOSq6eyxvMf37h5ilaE11pSOpO+xM
         bF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760572606; x=1761177406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
        b=vBT8q2vehIbejquyhKSuPOFHFYDO1PIInpt2DTwZfl8i0h6lK7aX0vX/Fu+u3RoOEd
         PHVwZgJYaZ+Glw8YB1y3oUOJGgcrTBQd3tA34f2r2CSrCGVB1AU+pHoqQfL8NyUiY5tV
         nC9yA06L7x6kPABKz0g3dqJrTVOS2Uswp43zJwdY+TfC7jSDPnv1jKvaMdPAKaehfP8O
         DUyPydB7DebIoCo/y0JdcwJMb5Vy3T9h+jGgv6lJtFIdKs3WJwewg4fsRpFD3/2uk2Vp
         zAjmBPdD+2TGP9GeWZFykTFaXKzfO0hvG5BZFh8fiCSlEbr2f/aawbsbAxo1AJGSfCdJ
         tvlA==
X-Forwarded-Encrypted: i=1; AJvYcCX101/97p/5Sp8LOp58LetBa0TG6sdzotb2FgY7Vi3azQT4m5PEUxiUov4vOzhDLTFgLvukIiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qMkFGj+hCGHlNwGxnrevrU9Ot0syGiP+i9++lwYNa9KiVhnN
	MZqMsp+GzUVV3Pv/jcSINp0unQRciYbyGAnOqUtAU/qTLfdCY5ycZibT
X-Gm-Gg: ASbGncv+yBKOHt6DDTTi927ARGOHOVgn+oG1vtY3QNi8pwv0GhzHJyyY3W/BpKd9uy8
	R/tvrypYU6vr4xgQqYq8z7g3lcy4A3+6A+V224/0Za9OLnT9SFH28RCDArvR3UQX9gLSEtwlORB
	nokqZwWMdIkEN6qUOorRaPd1bepKWRSzhzXbQROnTiGcDR95js6nzWqC0ehNoCLdGkfUnrPf/cw
	tySmhSUMXkwVoyaH9V6n+vvsei+GrxswPB6iMSaNzPstQjoo/7AaUcDbCaaEV7PJfAmfevnQCZG
	KDdyC+VSOfeqzhFkWivNl24IKqNYpLo47x03MDcYmnbNNMpNRlNVAmCpcwpPVg+odXlI0AP48qQ
	d6m1i2Al2Fvi00rBKK8GTBdXGM+E4CxiLL2pbr/a60SivESZMGu+vAqPwCPd3kY8GESvFqQktt3
	XZC4iXdyJZoszPbYjx3/lF3x2o
X-Google-Smtp-Source: AGHT+IGSJiLb5NMgZSUQODUANG+2COIewb92cwb9YvRlW3gs67WecUf+O5HmxRj2ud/Z7M+Voe3WDQ==
X-Received: by 2002:a17:902:cf41:b0:267:776b:a315 with SMTP id d9443c01a7336-290272c2019mr363652655ad.32.1760572605763;
        Wed, 15 Oct 2025 16:56:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97878b03sm3872453a91.16.2025.10.15.16.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:56:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 27E53419B28D; Thu, 16 Oct 2025 06:56:42 +0700 (WIB)
Date: Thu, 16 Oct 2025 06:56:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vasudev Kamath <vasudev@copyninja.info>,
	Krishna Kumar <krikku@gmail.com>
Subject: Re: [PATCH net] Documentation: net: net_failover: Separate
 cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Message-ID: <aPA0ucheaqqhuUqb@archie.me>
References: <20251015094502.35854-2-bagasdotme@gmail.com>
 <aO_OPBukiAjmO43g@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwZlaeVNL9Fp5cUU"
Content-Disposition: inline
In-Reply-To: <aO_OPBukiAjmO43g@horms.kernel.org>


--pwZlaeVNL9Fp5cUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 05:39:24PM +0100, Simon Horman wrote:
> Hi Bagas,
>=20
> For the above maybe this is more succinct and intuitive:
>=20
> Debian cloud images::
>=20
> ...

Thanks for the suggestion! I will include it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--pwZlaeVNL9Fp5cUU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPA0tQAKCRD2uYlJVVFO
o4oFAQDBERR//Sh1k48W7RWGnLb3IrKcEpaa2Ru8q8OMSFVD/wEAzCIBRrvx10Ap
XZKRtUoSLGf+YfhBQfKerigKla/hpg0=
=GtTb
-----END PGP SIGNATURE-----

--pwZlaeVNL9Fp5cUU--

