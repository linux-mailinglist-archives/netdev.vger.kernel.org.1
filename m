Return-Path: <netdev+bounces-179558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD05A7D98E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E31895967
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F1422FF44;
	Mon,  7 Apr 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="HWQ80ZTx"
X-Original-To: netdev@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427422B8B0;
	Mon,  7 Apr 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017708; cv=none; b=lwmMJH7vP46+KggaTaumxpJMSCJi/85f7rXWX1/iiYr1Png/6uJEDas8B6EXptS2DYw0g3O0NydOB0onciPQ9z+NzlwWKvR6BUe8EpnbVCWwzzIoPvZCemz8yBV0NMNQITlkUME84WXGd0GlBhLVWMed6bKwb3mOWfFainFZiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017708; c=relaxed/simple;
	bh=vlHXXG98PgWKxGxcZYLCRP/TU5pgXiI5WxEWwcpmfhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDXvoqVaj6J+e7DK2PWOgFmJztC7QA0NKjjxWgoYZ9o4wYEEuS1t4BeLfdc/8d1RO3mebICPCr3Za9aEte3SSVJI3/Bg9frOBjIMlo3ZeUuSbU8ee6EY1J9FZcRusPYmihpn9p5D9XkYS+5IgheNJxWwWHIbpRVC5plzWSA4u6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=HWQ80ZTx; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id A6A4E62DD1A0;
	Mon, 07 Apr 2025 11:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1744017702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlHXXG98PgWKxGxcZYLCRP/TU5pgXiI5WxEWwcpmfhA=;
	b=HWQ80ZTxEG5UnyG7P9JMbkv47UEZourqaoZAbgle4OKb4AEfJSo1zomrOgB+0UCTrsI0El
	qRpXGKWbr4/a2sG6UBWwEhYeNIAd95Afh+HV9ILmJwr5i1G1BZTp51y1CFGmn5fxURmwji
	rSNpV3ltsvQ+xQWX+W7qrYb8rO01WRA=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 11:21:27 +0200
Message-ID: <5874052.DvuYhMxLoT@natalenko.name>
In-Reply-To: <fdb5d23c-8c39-4f73-a89d-32257dac389b@intel.com>
References:
 <4970551.GXAFRqVoOG@natalenko.name>
 <fdb5d23c-8c39-4f73-a89d-32257dac389b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6142846.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6142846.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 11:21:27 +0200
Message-ID: <5874052.DvuYhMxLoT@natalenko.name>
In-Reply-To: <fdb5d23c-8c39-4f73-a89d-32257dac389b@intel.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 7. dubna 2025 11:03:31, st=C5=99edoevropsk=C3=BD letn=
=C3=AD =C4=8Das Przemek Kitszel wrote:
> On 4/7/25 08:20, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > With v6.15-rc1, CONFIG_OBJTOOL_WERROR=3Dy and gcc 14.2.1 the following =
happens:
>=20
> have you COMPILE_TEST'ed whole kernel and this is the only (new) error?

It's not a new warning, I've observe it for several recent major kernel rel=
eases already.

I do not build with CONFIG_COMPILE_TEST.

I've also realised I see this warning with -O3 only. I know this is unsuppo=
rted, so feel free to ignore me, but I do -O3 builds for finding out possib=
le loose ends in the code, and this is the only place where it breaks.

> > ```
> > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mas=
k.isra.0() falls through to next function ice_free_flow_profs.cold()
> > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mas=
k.isra.0.cold() is missing an ELF size annotation
> > ```
> >=20
> > If I mark ice_write_prof_mask_reg() as noinline, this warning disappear=
s.
> >=20
> > Any idea what's going wrong?
>=20
> sorry, no idea
>=20
> >=20
> > Thank you.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart6142846.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmfzmRcACgkQil/iNcg8
M0sq2hAAgv9gMejnpHVI+Cxnx+H+zNepzIt+NeOM1RI95cqJCAWkNIFl2msIJcy5
fn5ycnUTeVCuIBFi2Rsjs3offXq3B7gARMBL5nE7qKphSjgGsg8Spo4ckSfH7kgJ
74sgXuPHwNw5n0RaWcvuq75vojemqZ5AmO/YybDdJFXElLyPfy96fDx85DN/wmw0
9jsbNW+e/p+xpOIMcJqsVrbRmWLtTDMEOYK1jCCq6LX4GHzVhtWIUT0xIZ/hdC8S
5Sbrq6sLaH0WFfVum1ibwUmqD+pcN4zDsipSorobrkZ5oPG6J9oTmeQPFS+PoO/s
M6pbP5shs+q+HDcxUTb6XaeVnj4IhFJMBmP5FPNRqhiacj9hWHcXUk7++2VxeANF
cS8HF38eYZ3DWm89uec0gZR3TGwi5+bTGXfppsbGbrY0FwThbugSMkImCRKgJlGi
lMLzAujx4S1hYo7vqoPIc7eN0ogPezI1zpY7zb7Nm5qK2X80qX+Ky5KC7piPU363
vX8Trfl+gPIN7KgKvlafM+0pRjNklrtfGod/rWsHR86lshVzopB/g0HLE47kuXkQ
0L2Ea4DYfODrXXPZBZZs258wH6IakUGDz9nXBNe52p6eGBSMqvAL/EQR+IZIGXo8
OnAOqWELkQ30ZaE+FBKfdQhjyPO7IBfyh4TtmouGyTBOQoLWjug=
=/Gz6
-----END PGP SIGNATURE-----

--nextPart6142846.lOV4Wx5bFT--




