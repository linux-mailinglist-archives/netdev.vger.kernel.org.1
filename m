Return-Path: <netdev+bounces-137845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B912C9AA10F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F5D1C22633
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0219AA72;
	Tue, 22 Oct 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="KScSEomr"
X-Original-To: netdev@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A3140E38;
	Tue, 22 Oct 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596216; cv=none; b=QroQ2ZVslPr5QHWt0Dy/XK4mYhL1LOYE5sjH8dyoW729ElARR9F4FPmWQ22iafUoqmHF7+f5HUQLJtQeMAPKvu+myIpxxhnll/zZDkUY4QShRcbDnsjz/LPaluATfsTqQDPF5RCscuOExKwiC5ZUdd5FAqDSBtdP0Rqdh6IOQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596216; c=relaxed/simple;
	bh=8ZlVBrAFCLigMhxmLxO+F2t6P6BJzYK4tLvHohRTsL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4xdp6lGuICxKUZC4+4D6nzT3yIUAXo8QL2SgM3ogcF8gyaJA9eppQuB4lCk0kaaWRoaTs6UeAozf4Jv8JImkB0+Igyr7XiSzVVBCmIA5/azmH7pEdxdMgboYS10QSgI9WZE3lict2TP97u3fXZLvuQrSKOxIRvfwmghrsCN5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=KScSEomr; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 279711C006B; Tue, 22 Oct 2024 13:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1729596211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39KRZWvo5Yy4ranqCiOxVcJtONW373NlZQ4ZGJHBab0=;
	b=KScSEomrwMfrUR+Fe4mjX5CUvNe4sT2T7414kv/4dejE5ZuN17Cyw2GOkKdr98EnzC3vge
	6uhzkE/fKiC/hcoD9FT4YjHfZzY761jwEs0yvCXGt8Te/kwDx2GLAXHGfH6lJIR1+eMjve
	tJ4RwkaM4d6KPyyjFVG/jC4N1K9mUy8=
Date: Tue, 22 Oct 2024 13:23:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	bryan.whitehead@microchip.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, anna-maria@linutronix.de,
	frederic@kernel.org, richardcochran@gmail.com, johnstul@us.ibm.com,
	UNGLinuxDriver@microchip.com, jstultz@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
Message-ID: <ZxeLMu1Hy2VCqzJ6@duo.ucw.cz>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
 <20241009072302.1754567-2-ruanjinjie@huawei.com>
 <20241011125726.62c5dde7@kernel.org>
 <87v7xtc7z5.ffs@tglx>
 <20241015162227.4265d7b2@kernel.org>
 <87frowcd7i.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RBdm1UO8TvIRCV4R"
Content-Disposition: inline
In-Reply-To: <87frowcd7i.ffs@tglx>


--RBdm1UO8TvIRCV4R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > I'm guessing we can push this into 6.12-rc and the other patch into
> >> > net-next. I'll toss it into net on Monday unless someone objects. =
=20
> >>=20
> >> Can you folks please at least wait until the maintainers of the code in
> >> question had a look ?
> >
> > You are literally quoting the text where I say I will wait 3 more days.
> > Unfortunately "until the maintainers respond" leads to waiting forever
> > 50% of the time, and even when we cap at 3 working days we have 300
> > patches in the queue (292 right now, and I already spent 2 hours
> > reviewing today). Hope you understand.
>=20
> I understand very well, but _I_ spent the time to review the earlier
> variants of these patches and to debate with the submitter up to rev
> 5.
>=20
> Now you go and apply a patch to a subsystem you do not even maintain just
> because I did not have the bandwidth to look at it within the time
> limit you defined? Seriously?
>=20
> This problem is there for years, so a few days +/- are absolutely not
> relevant.
>=20
> > Sorry if we applied too early, please review, I'll revert if it's no
> > good.

It is no good :-( and it is now in stable.

It needs to goto out in the error case, to permit cleanups.

Best regards,
								Pavel

+++ b/kernel/time/posix-clock.c
@@ -312,6 +312,9 @@ static int pc_clock_settime(clockid_t id, const struct =
timespec64 *ts)
                goto out;
        }
=20
+       if (!timespec64_valid_strict(ts))
+               return -EINVAL;
+
        if (cd.clk->ops.clock_settime)
                err =3D cd.clk->ops.clock_settime(cd.clk, ts);
        else




--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--RBdm1UO8TvIRCV4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZxeLMgAKCRAw5/Bqldv6
8jy8AKCaVffVFfqDL6JJTNU1oiTk+jWBIwCeM8VYRowpg0ftE/JyPn6s/YeJI54=
=VLVA
-----END PGP SIGNATURE-----

--RBdm1UO8TvIRCV4R--

