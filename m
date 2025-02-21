Return-Path: <netdev+bounces-168497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC35A3F281
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9128719C5147
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF21F0E27;
	Fri, 21 Feb 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npskyKb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE851B21BD;
	Fri, 21 Feb 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135074; cv=none; b=BhiFzVrhgtQPzEsAFEf9PYTFgXihOb/Hdk47SJ59U0XGZ9wOpMO7a4Hv3mkEl5+4oxRb+yUnWn3O8CSiEjiKMzj7qky6HHaB5PfuUGMD8uYLkPeD5yrEAzc7OrKMyg4db5L03At3A1tD4L5Qq1D/ojdV3SW1tasAPCJms4n4lN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135074; c=relaxed/simple;
	bh=wmFqjYa8a5eCHdYKi30u2HafgimEj+zvhQqORbDcDC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geY2GFzQ1c8yD0+YmbAT04QxG379XIACrDvOtO6gXgLbthaaHi7AbiV04M/VQyHpjiG/O5JFL9ivR+JN0Y2Vj/FXaTdCf0SMiePTUlgoRPcD4SHwO+cSkbga56Df4vQtix1oNzkcdM/YTBfUv7had4OcXxs2tZ8YfSo31L44ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npskyKb0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e989edb6so52992835ad.1;
        Fri, 21 Feb 2025 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740135072; x=1740739872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyOp/QWfba/Jz3bRg2EOc4zHdl+EH4bjvd0km6rm81Q=;
        b=npskyKb0RcjpAFxrp2ld885VcPV7DpuDg35vRlI4zr79IHkd9G2ZqtrztyrTJ7auwR
         rg7vPvl/iO6gn7vdM9kw2TIUd3gwiBi9jlMbft2Mcc29eQ4Aq4SoCD9RFkJQ91LS3N2H
         6JLPsX6FBCqJH33RXmhIaLpom9U9AhAs27VZkACv+FaP9AAxXkT//qWny/ita2z57p94
         1nY3IUUsmzzF+WbZn+i4gdoTe9TAIvXSe/NUSXfWQDyJG2H7MAtyNbBJq5Ixqy+FSF5e
         1O3TvjyDwwju5TmA0WruyuQKTPxmDM7py9c6mknkOxJoBufFfr6412uC4afD3lcUlYrA
         eMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740135072; x=1740739872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyOp/QWfba/Jz3bRg2EOc4zHdl+EH4bjvd0km6rm81Q=;
        b=JUX+fd1jrtGGdK88cIVcds2WgxTHjaU+IpesZRuHPQX1rEcL4CURnMUSJjMrJYzEN9
         ex0iZr84TGXrjinSEAZfcAZD2orF5I2QVos8FT7gdJ7+b8iCQcrKuPwA/sc+133Appl1
         qtrlJAREi47rRGdPHoSrTIMiTP+ON4A6OWv2q6rL0Aaa8RcbYrKohd2vOMCbsjyDEJgm
         8vAEozxg+BzbctcwfgNyDsR+oGk1YFJd/7k4dnBz2Pzwl8HyH25tRAIbMSaijHMRwY1A
         0AAMZEqjkfV0dqabFORJ4h3jp4HoKfLzJ2RR+JwiNn3BOD1YgXyhLbjfrM/AsQ1/kw0M
         FAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV50YXZDdMvrIXVLcZEHWCSUEaZCnpIP8mKvjfnGJt6RdTo4l3x0F3LsIpHcF6S6NDQnzyCwRXgHmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRA51tDDg/78g+/l4DwpVdjbuOA1Ab46uOhR5vU916tRQ1hKj
	Oy9fJEEqpD0eQNJzIrrI+8+fIMT54ZHsfohCzDPusSpeLcKLR0mv
X-Gm-Gg: ASbGncuvaoKIVmXTxQRx2HJbbfth4A0ga4MjOZMcijfHvo7If2krYpuWaTt/pWf8QdH
	AUx8B1def7RlSbA+URqTIQc4wr6c6XXWTvGoHKqTgKUp3ex01hL3NVHT+RI8aDUfDXQiSMRGnEm
	bT1k6bu8h5UmI1mvlxZ1ZkGVrZv9a5xMxSIRBquYbZYpEznQ272jqWYkLbi5ra3nVWuk+tTKojt
	ZFYhAL0b5JwciFQMMEQbeB9ph+IoVXKW2M/AtdcyzGSDS6oP/yhI3nLuqJRd93Rg7dEV4eeSOxT
	sjop9Au2naubAJhp4Joq1pzPSw==
X-Google-Smtp-Source: AGHT+IElN7PNKXXNardH/79MQQ6j05wRq6P1pqgGH53PQZSnj9M3S5jPcUG4LexfE1bnD5HytTktZg==
X-Received: by 2002:a05:6a20:3d84:b0:1ee:b033:6dde with SMTP id adf61e73a8af0-1eef3c720d5mr5604907637.3.1740135072183;
        Fri, 21 Feb 2025 02:51:12 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm11825555b3a.29.2025.02.21.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:51:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 244004207D0D; Fri, 21 Feb 2025 17:51:06 +0700 (WIB)
Date: Fri, 21 Feb 2025 17:51:06 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tariq Toukan <tariqt@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 1/5] ethtool: Symmetric OR-XOR RSS hash
Message-ID: <Z7hamnWPXmsD24P-@archie.me>
References: <20250220113435.417487-1-gal@nvidia.com>
 <20250220113435.417487-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enHkbFxuiGy1aRGy"
Content-Disposition: inline
In-Reply-To: <20250220113435.417487-2-gal@nvidia.com>


--enHkbFxuiGy1aRGy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:34:31PM +0200, Gal Pressman wrote:
> +Specifically, the "Symmetric-XOR" algorithm XORs the input
                                               or transforms?
>  as follows::
> =20
>      # (SRC_IP ^ DST_IP, SRC_IP ^ DST_IP, SRC_PORT ^ DST_PORT, SRC_PORT ^=
 DST_PORT)
> =20
> +The "Symmetric-OR-XOR" algorithm transforms the input as follows::
                              "..., on the other hand, transforms the input=
 ..."
> +
> +    # (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^=
 DST_PORT)
> +

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--enHkbFxuiGy1aRGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7hakgAKCRD2uYlJVVFO
owhsAP9wWLgcNu0N+4ekUsCsa0ZiHt9xdDkPt+QK1d3mswoUrQD+MPx8/JOhm4GP
eOsDMI1r7PqE29HmrR5/iZom+3P8fAY=
=kRjE
-----END PGP SIGNATURE-----

--enHkbFxuiGy1aRGy--

