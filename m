Return-Path: <netdev+bounces-187091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A986AA4E1E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ADB4E628E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781125D8F6;
	Wed, 30 Apr 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q91X8Er2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92EF254848;
	Wed, 30 Apr 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022268; cv=none; b=lQlQiDeGhs1hknU3GBAJenH+L2hAEsDfHgC7pJiee+mgEzYSZCC3mRpHVW9iiHFHFC5Epl12ZHN3aG5dnN7qmt/Bhfv52BYTwcu70jAa0q40g54SS5CrEysGMMIvv5vOo2jPrk7T4x2TtYHhVSwr0KdBKWCZ2Gpy3XYeu12Bpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022268; c=relaxed/simple;
	bh=dsud/2U/NzgyuLT4SAm3RqXxWU7GCVGgm+BpDHgFKOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES22lZTRkfoRAb5pNwOvAVA2D3PNMlHtAno+urtWvEKP0WKMC1UAi7cjgV8EXL/5y/OZxbqblHiBFWtnBFGFF8sTxDdaKUu/auS9CF+5dUsztdO11kUxDxCXuVW54f2jl3NHoGZALovFIoPx72ZK+MR6rm30nJf7RZu00eiJSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q91X8Er2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22423adf751so74399965ad.2;
        Wed, 30 Apr 2025 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746022266; x=1746627066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsud/2U/NzgyuLT4SAm3RqXxWU7GCVGgm+BpDHgFKOM=;
        b=Q91X8Er2FWy5XuziDzEhyuXEpbFeztavwyS5Lz9NtiAw/9M0PKhS17wn6/11Fw7D01
         pR0hHxSdaAdxpoeqp3McTIB18TKn2Lxea/vZGr0HLfCOvTiPUB0gMz4lOhs/lH09jC0H
         hcEoZBWhMK7J9Tzj49Dx3uHdZtMK0/SXjYpIFjN9kRQALWgtWDBYW4k48fQ1CbedKbbE
         TNqiWbS/LWvnjh3nA0CxXEOTsi+fJ646/NUx472kSSMW56l4wB/4DI1Yd909kaMWauyM
         cjX5K/QlilZv+yXD5t4hVxW0my+RJmrrbwUYG5yifdpmWvhzivLhH4SbuIFmbYe7F3p7
         s3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022266; x=1746627066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsud/2U/NzgyuLT4SAm3RqXxWU7GCVGgm+BpDHgFKOM=;
        b=cZfcxkImocnJydPtjxqReFU22RIrkuUl2eD7b4KzbOzUrjTSMY/xWUCjOdIgWdf/Oc
         BYDb0tRIUYolMulSUyO9MaSUbl7ISJADOvaW+v7rRhKuXRgU0ruvjg9UG6mLWDFWHNOh
         dihDkRJY6m2NIUnTkrXb5JvHcIH2oImPbLZUlV6Jbd8jHFP2Izri73kKjoVBT2P36uOg
         ZLTvbVHxe6QQHNQs3ShOgrYjxgLdBWr5wnPBSqm9PFdYafEQlXx/z3k0yoVaCMC+crTa
         w/czzJtOQbR2bNtUOJ10b1zxXDFwbTRFFQjBw+9EzQeRGF5QZVamlRSSYk0jRz3BIpV7
         I8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUCF3SBgOLhuk6yc9WrFAU056NM9n9XZl/YtNL0i+LnYsYDYLRDVEQVmvYnC3Ukr8Pek7YbqcDB/rIUMfof@vger.kernel.org, AJvYcCUh+dXPaUgcdngbG9Ni/IELDwv4H1tXKRkj1aMP6WxWO23YARDBys0tkp8ohymOMTwpYB7kKPvD@vger.kernel.org, AJvYcCX34bLABcwFq7lZpyTvgBt84ahJc+A8EK+I1hHDN3PwgMd3FqHRR9H057ml0aZ/hxwP6Js43x0rj9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwet+bh2G38ptf6a2iYDNpyPzu7gKNMmJV+dBv/cwLifCv6Oi
	w1CZxTV2DRYWDIESMaTVG1UKDDfxp47VQRFTOpmkej+n0G7z9Qq8
X-Gm-Gg: ASbGncuRBfVOgo3A7bzfTx+UvfFwVcOtC35n8M6vs8GiKFRVJ8zu/axNyMfFpUWK1uv
	9yatsqrWJpTwzv/Mm5YxMwKL3rrUEZUVXpdpHlhfj0f4YgxMQQCOdg0lQIKCn/eCb/iX632epOK
	JJfknY9c6V4WQd62y+9LgCP4QWBzlZxNcaLXzAR18uUkTWqjjCax30LymGijm19Ij1+SPd5o8Ct
	QfBUTdSLW5swbU21GhVnXk9+oOXXR8LZ5q3LRJkCTIsJKA8G0VAQSUCPlX+msaH5aqwiLJKDfYj
	oQq7WqFE4OCWInN32VQxNKMxy5KF9HU0YyGQkxuW
X-Google-Smtp-Source: AGHT+IF0trVfcRYBBwO9lBLK8KETXWSFQfqRdeh2DW8hkHBJS+ZTFbNfty9mP4zPhIeEhtDyItzp+A==
X-Received: by 2002:a17:903:4405:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22df35cad23mr55838435ad.49.1746022265792;
        Wed, 30 Apr 2025 07:11:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a9fsm121976415ad.111.2025.04.30.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:11:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8AADD4208F70; Wed, 30 Apr 2025 21:11:02 +0700 (WIB)
Date: Wed, 30 Apr 2025 21:11:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Alyssa Ross <hi@alyssa.is>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: ioctl-number: Extend "Include File"
 column width
Message-ID: <aBIvdqKy9cCQPLox@archie.me>
References: <20250429130524.33587-2-bagasdotme@gmail.com>
 <66e4a803-05bd-4fbe-96bf-84415eefe412@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JY5zQzvXTsAY1P1v"
Content-Disposition: inline
In-Reply-To: <66e4a803-05bd-4fbe-96bf-84415eefe412@linux.ibm.com>


--JY5zQzvXTsAY1P1v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 06:38:27PM +0530, Venkat Rao Bagalkote wrote:
>=20
> Note: There is other patch [1] <https://lore.kernel.org/linuxppc-dev/aBHo=
dTu4IjqzZeXb@archie.me/T/#m013297a6731d3ca3dc1e0f23d161774850d6b41c>
> which has a different approach to fix the reported issue.

Then let the maintainers decide...

--=20
An old man doll... just what I always wanted! - Clara

--JY5zQzvXTsAY1P1v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBIvcAAKCRD2uYlJVVFO
o/EaAPwKtcQ1wbetpC3zLm+DuLSa5qEQtOm51qI4RngKFscKnQEAmrD6Y/Ovyazo
mBa6qHv4bKKYjW2KLekEMQyFs4iPHg0=
=NWAu
-----END PGP SIGNATURE-----

--JY5zQzvXTsAY1P1v--

