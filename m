Return-Path: <netdev+bounces-102969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA4905AC2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DB0B23FE3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02D3B2A1;
	Wed, 12 Jun 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="iX4SAKjS"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958883A1BB;
	Wed, 12 Jun 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216583; cv=none; b=gsRuEKmiHutLoOc4dQ4kSnx00T1Kn+usgn2U8dV8LuKkhx4GFObw6zS1K8YLLSjk+rV90j6ZpcOjdlnw6rrnhlR/vL/UaC5w3LfujfhbdUoadE6OLfu7JXJhI0v+SbTLn0av/0xML3yvPsPqfyR/UiwEGEApfTd01W/ZCUZnbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216583; c=relaxed/simple;
	bh=S/fn4KpsKyYIb7wyOqQFmHywMa1Mz95vU/XpulFss3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RS2ooC/e0SAmuiOAzlAyXVdq4FCcXRXp0LO0UqPiBw51GreX+UiyS1hgZUOJAkVEdu+s4Wsk1KKcrxlBinJit1voScVUtjQt4tHRvVxH2G+YqDLDy3tk67PQfxYpdvQMTTUvTeAuS2gXx6BA/p/6jOWOnYe6RrvwHPW9ujKhI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=iX4SAKjS; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1718216572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2DIMPyxXsUsx3z3UHNDfQvmHitGXJiStJK05XL6M2Q=;
	b=iX4SAKjS85UNGwt2lkaEQqSxCKTvFY5YqaV5lR5uo6cmb3yqiPqSy0QTNp06jX/47CgtUt
	gAs50cZL2EXRva9Xf0iAnCBIhRpgC+JEqUqNnjqVVm/4Kb3sCo4e2qiroY/jdGH1zwk4e7
	fzTxXeRhTjT6C0prhAE+4lu0OZ+Sxu0=
From: Sven Eckelmann <sven@narfation.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
 netdev@vger.kernel.org, rcu@vger.kernel.org,
 Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject:
 Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with
 free-only callbacks"
Date: Wed, 12 Jun 2024 20:22:49 +0200
Message-ID: <2328482.ElGaqSPkdT@sven-l14>
In-Reply-To: <ZmnNfU44NekafjA_@sellars>
References:
 <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
 <ZmnNfU44NekafjA_@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4898629.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4898629.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Jun 2024 20:22:49 +0200
Message-ID: <2328482.ElGaqSPkdT@sven-l14>
In-Reply-To: <ZmnNfU44NekafjA_@sellars>
MIME-Version: 1.0

On Wednesday, 12 June 2024 18:31:57 CEST Linus L=FCssing wrote:
> On Wed, Jun 12, 2024 at 09:06:25AM -0700, Paul E. McKenney wrote:
> > We are looking into nice ways of solving this, but in the meantime,
> > yes, if you are RCU-freeing slab objects into a slab that is destroyed
> > at module-unload time, you currently need to stick with call_rcu()
> > and rcu_barrier().
> >
> > We do have some potential solutions to allow use of kfree_rcu() with
> > this sort of slab, but they are still strictly potential.
> >
> > Apologies for my having failed to foresee this particular trap!
>=20
> No worries, thanks for the help and clarification! This at least
> restored my sanity, was starting to doubt my understanding of RCU
> and the batman-adv code the longer I tried to find the issue in
> batman-adv :D.

Thanks Linus and Paul. I've queued up the revert. But feel free to submit a=
=20
version with updated text in case you want to incorporate information from=
=20
this thread.

Kind regards,
	Sven
--nextPart4898629.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZmnnegAKCRBND3cr0xT1
y/2ZAQCJLtdWIbCPUrkTqkI9mv1ThzM/ZcLceVmbFSKhVCSe8AEAtVQx2GE9aUCk
S1OPFkU0m5zCxxMHHIygDnw3SwaMvAA=
=mD28
-----END PGP SIGNATURE-----

--nextPart4898629.GXAFRqVoOG--




