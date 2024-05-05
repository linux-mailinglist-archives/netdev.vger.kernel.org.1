Return-Path: <netdev+bounces-93507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E308BC1A4
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0130281A0B
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0637160;
	Sun,  5 May 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KAyUL/Kh"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F522611;
	Sun,  5 May 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714922544; cv=none; b=peTjDrRDf9kRK3ysNwtgdtZYzG6ydQ8Zvucm7PcY00GQdTOoCXr9rRUhtXI+iKPg2BK+HeZz8zJZmpS8/IFjf0FZSkiRTwMqhycdUlqNbXvz8qFmy6ZUIxdmYKJTcRW3DG2eOyc+6kqhDi/lxUCvUflDK5ClislsecOWYRBrMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714922544; c=relaxed/simple;
	bh=YOzXTa6rAiVOHldd14538pyVa5rmXqDYyMin9bW7Vvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqnv/4fE8bHZ7At7B+qCYsLsgYWC925pYegcGI3FbNmq/6O5WbM8PGEA76Xp6DB7QDxO/yfw7lE579c35nbBZH/KQv0B7WqjYNQVBzb8OKJcxD8wmE5WonWRTKWULzPwmzbHPuqN/E6vZUizoZKbFTlPVdrmI3ACAFkBI0q/NYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=KAyUL/Kh; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714922533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuJ4u/ouTOrJt02FpiNU5j5yMZJgY6im3scH4wwajxE=;
	b=KAyUL/Kh/ITipKh9aVVkTMWPz7Nd3C6g1uWP3LQzc+Ugg0RkDLcTp5BaZlW7tvnajUwbGT
	fc5XyLz2pBTbE/p+ach8JwkkrD8RdoNvXeNYre3fZ+CVLXmHjeRpqJSbT5FzEQqombC3SW
	qLxsGVAYRKQffO5yBGIIHNz6IotbfnA=
From: Sven Eckelmann <sven@narfation.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Subject:
 Re: [PATCH v3] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Sun, 05 May 2024 17:22:10 +0200
Message-ID: <9977759.T7Z3S40VBb@sven-l14>
In-Reply-To:
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12069128.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart12069128.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Erick Archer <erick.archer@outlook.com>
Date: Sun, 05 May 2024 17:22:10 +0200
Message-ID: <9977759.T7Z3S40VBb@sven-l14>
MIME-Version: 1.0

On Saturday, 4 May 2024 19:08:39 CEST Erick Archer wrote:
[...]
> > Thanks for the updates. But I can't accept this at the moment because 
> > __counted_by_be is used in an uapi header without it being defined
> > include/uapi/linux/stddef.h (and this file is also not included in this 
> > header).
> > 
> > See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> > identifier expansion") as an example for the similar __counted_by macro.
> 
> If I understand correctly, the following changes are also needed because
> the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
> question, but I'm new to these topics.

No, it is absolutely no stupid question.

> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index 6e25753015df..41f39d7661c9 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -9,6 +9,7 @@
> 
>  #include <asm/byteorder.h>
>  #include <linux/if_ether.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
> 
>  /**

This must definitely go into your "original" patch

> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..58154117d9b0 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -55,4 +55,12 @@
>  #define __counted_by(m)
>  #endif
> 
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif

If you want to add this (for completeness) then please put it in an extra 
patch. It is simply not used by batman-adv and I would not be able to find any 
justification why it should be part of the batman-adv patch.

> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +

This part can be either:

* in the batman-adv patch
* or together with the __counted_by_le change in an additional patch which is 
  "in front" of the batman-adv patch (in the patch series).

From my perspective, it is for you to decide - but of course, other 
maintainers might have a different opinion about it.

>  #endif /* _UAPI_LINUX_STDDEF_H */
> 
> If this is the right path, can these changes be merged into a
> single patch or is it better to add a previous patch to define
> __counted_by{le,be}?

I don't have a perfect answer here. See the comments above. The file 
include/uapi/linux/stddef.h doesn't have a specific maintainer (according to 
./scripts/get_maintainer.pl) - so it should be fine to get modified through 
the net-next tree.

But maybe Kees Cook has a different opinion about it. At least there are a lot 
of Signed-off-bys for this file by Kees.

Kind regards,
	Sven
--nextPart12069128.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmY3pCIACgkQXYcKB8Em
e0ZBhg//Sno8piH1PoF7IE8mPDXalzTPEW5L8W1iX0gbkT0DRJF3ngI31P7iYtLA
TeYbI1z3YeRD5hNU2J7stFiqwoNbt5wWDmCYNcPoFf5zdimr5XbQYB2CGOVM5hG8
SexX9t6qndx3MWNj2f83XLfSIJh9Sn+B7mLEFixcsISX8CLAvQZfwkwjNpola13v
OZm+qoUsCeocQb18bR/XUhqfra69fMN3KRKHSvRg82xZqCox86RP3nukgcNr7Aw0
mY+RvmuEHzVQezgfkMs7Wz+uSJSGKyXuTSCnkdIhy62kSMIKv9TZhFeIwCQEDWVl
oCBLAqKXjMPr8sldjBScwkMM9mRAlCUgqD3XlIbZ32y2zCJoX9LsyRD+K6frc2tr
z0j/9xAfCrYJCvYhXuWFhqak3bc6owQ08NxB0A0ePx0bBCMiz34J3R55BBtGOaTL
YrXXEuNV79Z3/bI9P/Yk7mRmfuotPYa3p1r4fizuQEYa5294xJUdQkMF6aeH/R1G
YK3IFiRiLHi0rVu4BvdO3nsVJL2nqa1YZeSRtqFtsKhXb9wdQSxuqaJD7YgQm1T6
taFnTfK+6v7DXgEvlEdtUMqiKZkZM/pBDJoCZpI+oJHjYii7s0BiaYoDWHRfBwTj
szbiK24wF/bXmY20iarKe1I1VVaFlhg6N3PXgCWsLJYh6gATkVY=
=H+es
-----END PGP SIGNATURE-----

--nextPart12069128.nUPlyArG6x--




