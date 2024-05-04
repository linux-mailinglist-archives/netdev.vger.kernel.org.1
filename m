Return-Path: <netdev+bounces-93421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F08BBA4A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB4A282E3F
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED6168C7;
	Sat,  4 May 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="okWKVeJ1"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE6639;
	Sat,  4 May 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714815353; cv=none; b=UYJKa7PqiSR/vif1iXhsri5L6YNvsMuaOe6CKRoOy5+z5Zm2LfJObvND+ioFunt9bdQ/yGvTk3Ry5s6EGYeX1g4GDzRht+xsZdSZcVKsj2sHRpyL7a4ioBcTN57I0tfsKRE6KLz6RFrd9REy1pQgmHjbrDXxbojQsL5CWPZdMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714815353; c=relaxed/simple;
	bh=9dc1UlSXIXdl2vRtQFyLOal8xPLWWcPry+UL2rhypu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX53qumpWA7jLjigJdLHZvu8XIBZvvBOOKe44g3bSbkVDayzyjASaOzLcfjcnN//OjxATe+jm9uOemYXlAO8SESTSxq2FH4mQpe07Zggr28ggtDCt19KIuq8IijwB1oO1FN2wnde9mxSkPisJ+W/ohpJCehfZsqCQJIevZOAh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=okWKVeJ1; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714815342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mw7SFuN2SHyU67C8OH1gLXKRgrvpMA94gKGdBbC2U5Y=;
	b=okWKVeJ1LP27/Ihu8TKZpJV5+kdcRHrkgkz0ecctRtlkJ282/Py2klIdLw6RKUKpJqZCuz
	Q7Zq68Db9+BwMxEPvBY9lMElzorY66vigachpn46RQk2RGlW1eEGYjYcP3weo2837HXabl
	7WVzBNxDpncV72/vcVthNbJj6zHVWjw=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>
Cc: Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Subject:
 Re: [PATCH v3] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Sat, 04 May 2024 11:35:38 +0200
Message-ID: <3932737.ElGaqSPkdT@sven-l14>
In-Reply-To:
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6497797.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6497797.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 May 2024 11:35:38 +0200
Message-ID: <3932737.ElGaqSPkdT@sven-l14>
MIME-Version: 1.0

On Wednesday, 1 May 2024 17:02:42 CEST Erick Archer wrote:
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 6e25753015df..dfbe30536995 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
[...]
> +/**
> + * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
> + * @flags: translation table flags (see batadv_tt_data_flags)
> + * @ttvn: translation table version number
> + * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
> + *  one batadv_tvlv_tt_vlan_data object per announced vlan
> + * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
> + */
> +struct batadv_tvlv_tt_data {
> +       __u8   flags;
> +       __u8   ttvn;
> +       __be16 num_vlan;
> +       struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
> +};

Thanks for the updates. But I can't accept this at the moment because 
__counted_by_be is used in an uapi header without it being defined
include/uapi/linux/stddef.h (and this file is also not included in this 
header).

See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
identifier expansion") as an example for the similar __counted_by macro.

Kind regards,
	Sven
--nextPart6497797.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmY2AWoACgkQXYcKB8Em
e0aJDw//f+el64xroKLns43gvY+Z/mPIwf7Iy+THUq6U9zVQ0wp3XbW9QTmXP/5K
8it8yX2aNEEPu4Cd5w6eIrwxIdhDZW3pHxI9ipdgTjF/i0Jh40SpM9HOlgMLjCys
Ls0Innvs24uQ99h4OSk4TGuHay+6Z0aMEV0PrFsj6jsoB7su7nmQ6ebEpdY40246
soQfO7aJ3vrSYbuCJFOlMESNHm0wRxQu4QjK8RDmyk1wEyJIkQyVQ6QkjYj6ulkr
+eai2uDQWKEPav2vantbXXsTK4gu7nWEGTcHn2NoJJ/bqtzCrz1FS2u55PZ9l9P+
auO/nPz1RB2hHAA3t8igC5jRK6AQ9CdjRMt3rQ8Pmk2jZKt5G153j0lgQdq4nDaf
V6ji3IrDnjQvIAeUN5vkIlwqbmVo2BbIqHDXK1JMmUEryQCt9HHFCnLYVr0v2WuM
tIj/T68pcEThoF4TU2B30ScZUfMeZ8e3im53RPU+29ljldyX6WCxIGLIyFZM2mbo
U8cqULn7tN8LfMcB7CYf7+H6GDCOq+m+Xd50oQsIYb0LDIk5CuEAVBCA1/wNog5q
+HVplKYtp2LSIKQKMey2u0loQFq/EnwH0pS0Vv5SylRQMZ1PRFq54tWRDsjwDw4/
BMP9cF5Njh9uyD2Db0uZRZ+OWKH0KC41A+cvue7gjWA5uNDv6uA=
=qo9D
-----END PGP SIGNATURE-----

--nextPart6497797.GXAFRqVoOG--




