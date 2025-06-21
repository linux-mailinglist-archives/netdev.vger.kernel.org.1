Return-Path: <netdev+bounces-199960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEFAE28C5
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 13:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C23B9A69
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF66206F2A;
	Sat, 21 Jun 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgspikS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C11A2632;
	Sat, 21 Jun 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750504922; cv=none; b=tiCG8LDieJmy/NSVuwCledpZ8VjgZn7wrogN/M6nViXA5DTj2+DffvrLzftSbrfYbSC1xWXaET9U0GtdcjNVzsEPjb7pOUSFEW0ZZo1rqOTrKawXM5yTcHL6jWzEvBIbEtL5c48FDJgPurpBsyLtKE95DfY41pgPncenanWIkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750504922; c=relaxed/simple;
	bh=ohRWAiCfbgS/aXA4RVDCNgMCTaTOzaemdQHvS/o3vaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQKJpq9UE9vuVniZWoAyXS5hstLFgkMhIBBDhNqbsuNIi7jERU4y9M4Hjel+eIo5XTZI0YnHxV5esOdS0i+m6MI+BcoRvZUYrq23ssUzleIJ7xp1gmUpC8SjnAvsHgt6hQOhY5jSLktjk8f3ymAi6TNO3LH4nAqKKtbqAvZG3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgspikS3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1226539b3a.2;
        Sat, 21 Jun 2025 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750504920; x=1751109720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=woaxyv+j8Y1KBB+MeQ1QihpwoORfG9XIi5cXFKLshHY=;
        b=LgspikS3QWbS7AEfkDfIyHrBxJXHptEDK4tNt+Fni4VsppADcWd4cpOTbk8gsZJFGn
         ZzWC5mYPEPJmcU4Y5rArCcoS6i0HI9YvIpkZUnqQJELHVL9fcD/Be43LC9XCHg44duDy
         qOwv82obbAQyiDpYZUI/x4lSNglNIpWMWSVTd6PpNk9CPe1sBGeruaBqz3hRQVgIvuI9
         I/gq1BgDpNS39Jx5rW7ZcHALVpkCauGk80ZZ6BlhB3MxiYH0/L2XN/WhtlijHX90OcHp
         4YARCs9B/jWQW+ROfpwJxoDHxqdo+WdR3+MwwJwiaK/VimspuEcud3t29U8VywpI+XQH
         1xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750504920; x=1751109720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woaxyv+j8Y1KBB+MeQ1QihpwoORfG9XIi5cXFKLshHY=;
        b=cydzBnGzkhkILjKrfTh6nlsJs+YUrBakmoMe/JHJjvGG2UOhoCHEOXJzRf6ODDSCcH
         GYIzD4+mem1tgQ3Hhkf5T7r2OfRTPGYtyqUxPOgTx7IHtuHt8x0XC2VExpRG4sjtMV2D
         SiGFE/t0DYBUCyM8qRlDeAlHGkVF6C4V7+hYAic7UpCi2kGQZ3u5sr+OLPg4+U7fZ3mZ
         nrwg8vqby8TqEdJ9UED7ou7OVw73o93uOEDDRYbS1D/mZ3wz529CPvCbiJRD+mZDrOfU
         NGIZy/4xRiXNdX7e1A0Rgv/YIpRke3+XJ03s3o8N/IBRG8WVcT5K5DWI9walGwaA++5T
         Jq+A==
X-Forwarded-Encrypted: i=1; AJvYcCXRNfaiQoekEDDupNMVEPNIsov8+/46C/B2UM4etV6Jltlgn9RxF8spD2R/myh+9iZxV0IqlBsELrJV/h0+@vger.kernel.org, AJvYcCXjCGgvgdImHP89VL7bJIesQ0oibfNiPJeSi16747o0QL4kVMXp8RonRon1fkOQ5XIBXTW0TjFR@vger.kernel.org, AJvYcCXqE6dv92Wkb9BEaKzHCjMKHVnViAZaKg0wsFjkxZmeMFs2TL1NHkkGUqtIJWDlkyNUvKrryH/pKH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1UkW/qyVmf11Ebb5oyJRGYRtvucyDBO8BIFk3DDOn/UCTLt4
	DB6BWzJ3NlbY9txf3iCD8tmOVLbRSgZCY8cULxHQJ+Flj+Drd1YGKP52
X-Gm-Gg: ASbGncty4QxyQxJHcDrGoTJqQNtPTRC17qBpizN+x0LtGk+XDgSrC9i55cxIFCHNMIK
	WKygWHFb28IZ3StVwHfGE60xkVcJhjvO6Cs7WWES0s4zVrqtt/IGLmpTJmjVP3ZXBxmNr4cg2GH
	6pS7MKiKg0+2sFqQwZdJnRek6atzakQRF5+DdhU11ojvMrutAwUYFw7skb6q1qwYTk+kn7CCVbm
	fAHLxvXXCT9wKHlsllS4LJ1Pr1VD/KUY/BCOE8w6aOEQzvBQn2xNs25yv/iW8QXo6jI7l6wAzlo
	w1xelkGZEUaMj/sYx+fQ19zFU4Eb08Wd2eUe2dJOXfV2adtpKLM6otwOn6OTiw==
X-Google-Smtp-Source: AGHT+IG/O8T1LnjkmwUuzaEvqwFNIWd0CfKLMGROZs4Ty0QlCl2WpaGZb0qmuhiRZruQg4JzjsVl/Q==
X-Received: by 2002:a05:6a21:68b:b0:21a:d061:2f84 with SMTP id adf61e73a8af0-22026fa63a8mr9871935637.30.1750504920143;
        Sat, 21 Jun 2025 04:22:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a4ac6b2sm4099007b3a.69.2025.06.21.04.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 04:21:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0A4874207D0B; Sat, 21 Jun 2025 18:21:54 +0700 (WIB)
Date: Sat, 21 Jun 2025 18:21:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.com, jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH net-next v3] docs: net: sysctl documentation cleanup
Message-ID: <aFaV0kD6zI6N0Keg@archie.me>
References: <20250620215542.153440-1-abdelrahmanfekry375@gmail.com>
 <aFZ5OhP3Ci5KzOff@archie.me>
 <CAGn2d8OT0SS+wYphKBmM21Lo__N_ZFRyZCQ8pL34c0Z0bqDoag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQzEutQpcKFcOvi9"
Content-Disposition: inline
In-Reply-To: <CAGn2d8OT0SS+wYphKBmM21Lo__N_ZFRyZCQ8pL34c0Z0bqDoag@mail.gmail.com>


--LQzEutQpcKFcOvi9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:58:46PM +0300, Abdelrahman Fekry wrote:
> On Sat, Jun 21, 2025 at 12:20 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On Sat, Jun 21, 2025 at 12:55:42AM +0300, Abdelrahman Fekry wrote:
> > > +     Possible values:
> > > +     - 0 (disabled)
> > > +     - 1 (enabled)
> > > +
> > > +     Default: 0 (disabled)
> >
> > I see boolean lists as normal paragraph instead, so I have to separate
> > them:
> >
>=20
> Thanks for the fix , should I resend it or is your modification enough?

Resend (v4), with the review suggestion applied.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--LQzEutQpcKFcOvi9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFaVzgAKCRD2uYlJVVFO
owp9AQC6yCLXGLrK6u9AU7f1j4MGLkn7iAokGhf3h4Sn5sFUFwD+NWMMTo0awl4Q
nQikhcvXjjXr+nCOmOTomS1uS3ZQEwU=
=8KNA
-----END PGP SIGNATURE-----

--LQzEutQpcKFcOvi9--

