Return-Path: <netdev+bounces-179953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221CA7EFD7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E933A7C7B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441A205ABF;
	Mon,  7 Apr 2025 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="LC3gxE5V"
X-Original-To: netdev@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79505B672;
	Mon,  7 Apr 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062623; cv=none; b=blcIDc+SNKBzxqUesfIJg+59Jh+nMZo1GusiVWDjWxlYCRrrxAjxpvneCQ0UeUp6mHEYsvzrKowreoiYdbeMQtAlBDROCk0kK1gn/0gocwpMIZDWEeJzDqBhLExy8B92iiHrKuAW2DwB1FUZE4zOTmRUtybrbagyZKiqldr1qXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062623; c=relaxed/simple;
	bh=dTTtQINgOmcAEPJfigLOj/BUnIrZ7vpHtP8H7uhII/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYAgzg7ARPti1iw5P5QovuH6onyeSBbDIOf/SXkXh1EqZgZPkjlBt8OeO3DUFUwlHWjR8zdXpbajUTjWVCHIJLKwQePNHyJ4/n6gmBZIDgw/tOeniDUTjKr/VFYTA70qAeKb5JburTLf1nM0NjR6O93ArLKFQR1rTqt9b+aasZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=LC3gxE5V; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id A20EE616710F;
	Mon, 07 Apr 2025 23:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1744062615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gU9lD+RqDMo0wEfUDiyRdrBfsjXAPrpF0e2SpfAHy3o=;
	b=LC3gxE5VZ4L+DEwuwpOEE+tzW6EXFqsP2z9PdoW+xbBc6jHNK+Kw/5ptPjToRWcdggytT1
	LtD7iF+q19Ny6NbPcHiSlggLtsT/A4YojUngAdMGoLxJy6gl5op/Y2FI7bigtNMnzmi3FX
	wPdW5gI0b3YnHEZV34kX+mgbSC+J2Q0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 23:49:35 +0200
Message-ID: <2983242.e9J7NaK4W3@natalenko.name>
In-Reply-To: <ficwjo5aa6enekhu6nsmsi5vfp6ms7dgyc326yqknda22pthdn@puk4cdrmem23>
References:
 <4970551.GXAFRqVoOG@natalenko.name> <5874052.DvuYhMxLoT@natalenko.name>
 <ficwjo5aa6enekhu6nsmsi5vfp6ms7dgyc326yqknda22pthdn@puk4cdrmem23>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3343055.aeNJFYEL58";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3343055.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 23:49:35 +0200
Message-ID: <2983242.e9J7NaK4W3@natalenko.name>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 7. dubna 2025 23:42:51, st=C5=99edoevropsk=C3=BD letn=
=C3=AD =C4=8Das Josh Poimboeuf wrote:
> On Mon, Apr 07, 2025 at 11:21:27AM +0200, Oleksandr Natalenko wrote:
> > It's not a new warning, I've observe it for several recent major kernel=
 releases already.
> >=20
> > I do not build with CONFIG_COMPILE_TEST.
> >=20
> > I've also realised I see this warning with -O3 only. I know this is
> > unsupported, so feel free to ignore me, but I do -O3 builds for
> > finding out possible loose ends in the code, and this is the only
> > place where it breaks.
> >=20
> > > > ```
> > > > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof=
_mask.isra.0() falls through to next function ice_free_flow_profs.cold()
> > > > drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof=
_mask.isra.0.cold() is missing an ELF size annotation
> > > > ```
> > > >=20
> > > > If I mark ice_write_prof_mask_reg() as noinline, this warning disap=
pears.
> > > >=20
> > > > Any idea what's going wrong?
>=20
> This type of error usually means some type of undefined behavior.  Can
> you share your config?  No guarantees since it is -O3 after all, but I
> can still take a look to see if it's pointing to a bug of some kind.

Sure, thank you for looking into this.

Here's my recipe to reproduce the issue:

1. expose -O3

```
diff --git a/Makefile b/Makefile
index 38689a0c36052..5ce5b44fa1496 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -858,6 +858,9 @@ KBUILD_CFLAGS	+=3D -fno-delete-null-pointer-checks
 ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
 KBUILD_CFLAGS +=3D -O2
 KBUILD_RUSTFLAGS +=3D -Copt-level=3D2
+else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
+KBUILD_CFLAGS +=3D -O3
+KBUILD_RUSTFLAGS +=3D -Copt-level=3D3
 else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS +=3D -Os
 KBUILD_RUSTFLAGS +=3D -Copt-level=3Ds
diff --git a/init/Kconfig b/init/Kconfig
index dd2ea3b9a7992..03b1d768d1a55 100644
=2D-- a/init/Kconfig
+++ b/init/Kconfig
@@ -1481,6 +1481,12 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
 	  with the "-O2" compiler flag for best performance and most
 	  helpful compile-time warnings.
=20
+config CC_OPTIMIZE_FOR_PERFORMANCE_O3
+	bool "Optimize more for performance (-O3)"
+	help
+	  Choosing this option will pass "-O3" to your compiler to optimize
+	  the kernel yet more for performance.
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size (-Os)"
 	help
```

2. use this config with v6.15-rc1: https://paste.voidband.net/2BVaYDQS.txt

3. compile:

```
$ make drivers/net/ethernet/intel/ice/ice.o
=E2=80=A6
  LD [M]  drivers/net/ethernet/intel/ice/ice.o
drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.is=
ra.0() falls through to next function ice_free_flow_profs.cold()
drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.is=
ra.0.cold() is missing an ELF size annotation
=E2=80=A6
```

=2D-=20
Oleksandr Natalenko, MSE
--nextPart3343055.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmf0SG8ACgkQil/iNcg8
M0vxehAA03RuT6O689+5Jdr4noiuWvqomKVkLszYT1147iwghBc2GiXu4qBx2ft4
Jq38NpHncquNMkr4I6ZHWR6dtqpdvlhYCVSFZWBzGzXQDZEGh64Yabro1FcoVszE
OGCnaJBXcs8q5vgBIg0hnRvkeyEczcrWAiywXbTcuBzNQFhLct+ewYzUJGeHyRMW
OZZ97N7lRGOzCjwbH2a5n8vqyv2rtOYRAg3BbAsIuLfVf5U6xGEXXjBvGGsGDxKM
2WeQBLzsXU4CIHZ3BXUBunDSTDCoUvdu3IppzHaptlGeVBlv481Phaanne3uGbkf
qv4kYELOm7V/FGw5lKKgQnqzwzQaMqbr6ds6aiIkABdewjQpIPi4qYpHEBqO14Bl
jBiC1OghCz2oCwK2KQtoOAobWXhLTDSQ6ykpX20BqO2YGodTG4SjWi4sTly11zSC
Cwo7dpeNTQOtwbDsBCHhiu2R5265qc9cg2cNBLM2P5UFrcOI6qVAR/r1/yXpUnoY
qKTGhb4vrqlyctCzgfqAEaJ70BUUIR33nVhmSEZ1vPmxrYLiroFzFWHc3bvkdfvC
2DFrbO5MNnnBi1anMDXlU3NIIx/i9lhjBKUnYvS/0heVnSkBapdcZPQaB4KCK0Hw
AVtDt1wPysYqWRL0JgxGf+P3BfDU307+2QhNVKbuP5JenUcFUE4=
=FX5o
-----END PGP SIGNATURE-----

--nextPart3343055.aeNJFYEL58--




