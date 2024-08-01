Return-Path: <netdev+bounces-114828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB0944572
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D539CB21BDE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA6158845;
	Thu,  1 Aug 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jukcYLVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69B158529;
	Thu,  1 Aug 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497418; cv=none; b=XEqap9z+ZsaPKPPk8i8dCjbTHAzFsiaG9Kd6ZvO9UtueHkv7s13d/9MhLPQo4F3zdmAB/GxuudnH/TZyLdi5gIGkbWEU51JWghHq9H1p45KbAUymkt9+kjuL49BgrmHtJwby/xNQn9ldS7FiJY1Ro9OjMveqxS8mG4ZcjUpWo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497418; c=relaxed/simple;
	bh=WzBD7IMujxoOrTLMylUbrnQpAGsXY6JVI23pi1Z1PkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1gVDKXNrJvkvU7RL1cpDKmroPOGuJQun13qecZbiNLNQZURd1lcVoMCLZWSjGMv+Cn3Wku/39zGEJsa9BmIeB118ftrdmZWuTIC93CEUIS46//9WemkV6i5fDauIBb2YGxWMO4GkR9kGweZZvR7EzsfJzwF/gG7+w3F41luBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jukcYLVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE09C4AF0A;
	Thu,  1 Aug 2024 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722497417;
	bh=WzBD7IMujxoOrTLMylUbrnQpAGsXY6JVI23pi1Z1PkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jukcYLVtOi9LIv2gj0gl9XwGfAEC28HOav2+AeGJ3J5KdJDQrD+NIMDsIWQXtGJQk
	 DW65asz/5fiPWSvZTR2UAoQvuNYP2I+RwhVYgnUI20XCj8aEjnk5Vc2ktQl1glZXZm
	 Q37TVZU5U8NurGvlmUwNLrc9tmsZkwsjxbEhfoEpM/eVWkrdMZmbePjLuYwPiUu1kL
	 aPaY7fZMp7owGCecDgyo0kjyYK7OC9j7MTy/qj1vH/5j11airUkYcMiaOqhxm+405h
	 kVaE9p3dTxP4IWqEcAJn43qQ0enM7neb6Oyz5XJgYTpbyFuqvp++MsoeOch76ON5ev
	 nrXUtL73v+TWw==
Date: Thu, 1 Aug 2024 09:30:13 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX
 performance
Message-ID: <Zqs5hcFMx1g42Zrd@lore-desk>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <ZqfpGVhBe3zt0x-K@lore-desk>
 <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
 <20240731183718.1278048e@kernel.org>
 <CA+SN3srMPLcmQ4h_iNst71OkQPFcCYxBRL0Q9hR=7LjJ86TFFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rYSnn6hAqwxzEyp"
Content-Disposition: inline
In-Reply-To: <CA+SN3srMPLcmQ4h_iNst71OkQPFcCYxBRL0Q9hR=7LjJ86TFFA@mail.gmail.com>


--5rYSnn6hAqwxzEyp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Aug 1, 2024 at 4:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue, 30 Jul 2024 08:29:58 +0300 Elad Yifee wrote:
> > > Since it's probably the reason for the performance hit,
> > > allocating full pages every time, I think your suggestion would impro=
ve the
> > > performance and probably match it with the napi_alloc_frag path.
> > > I'll give it a try when I have time.
> >
> > This is a better direction than disabling PP.
> > Feel free to repost patch 1 separately.
> > --
> > pw-bot: cr
> In this driver, the existence of PP is the condition to execute all
> XDP-related operations which aren't necessary
> on this hot path, so we anyway wouldn't want that. on XDP program
> setup the rings are reallocated and the PP
> would be created.

nope, I added page_pool support even for non-XDP mode for hw that does
not support HW-LRO. I guess mtk folks can correct me if I am wrong but
IIRC there were some hw limirations on mt7986/mt7988 for HW-LRO, so I am
not sure if it can be supported.

> Other than that, for HWLRO we need contiguous pages of different order
> than the PP, so the creation of PP
> basically prevents the use of HWLRO.
> So we solve this LRO problem and get a performance boost with this
> simple change.
>=20
> Lorenzo's suggestion would probably improve the performance of the XDP
> path and we should try that nonetheless.

nope, I mean to improve peformances even for non-XDP case with page_pool fr=
ag
APIs.

Regards,
Lorenzo

--5rYSnn6hAqwxzEyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqs5hQAKCRA6cBh0uS2t
rNZrAP0eoKULRJ3mk5g+ma9i4CaSGMfF3dbb7VK1e4BzjNQvzQD/W6jl6gOfuYuJ
K3hcqA1i0ABxgAdLVpxeoE6H4UBzzwA=
=7+zW
-----END PGP SIGNATURE-----

--5rYSnn6hAqwxzEyp--

