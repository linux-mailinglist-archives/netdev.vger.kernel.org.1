Return-Path: <netdev+bounces-222854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA083B56AC4
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE96177A8A
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40AB1D95A3;
	Sun, 14 Sep 2025 17:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE01EEE6;
	Sun, 14 Sep 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870136; cv=none; b=CJayQrfaaL4hQvAGytbrEdEZ2SmPxmZ/Ki+Ux30K88Yx+QNCNdcWK/Z3V77ZzFfTqWeiUI2ktk6GDo7E/h2HrCtY0jINGtQ5C3M6cBVNWLeipL/73GqSaG2Ig/wZ3wYEpb545wxd698kcF67+dOR/uuLa3W7QKuRGFZtLuZInDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870136; c=relaxed/simple;
	bh=mCY7CFjzHorofJ89F2uXcM9RFrcQISKb9+9Ln9zOgO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8bs8fJyQtAXBLUAsy5uH6KoZYSq0VSLlSUno1oYYt5/b0YdkThP+mRV8EYZVa558uBGaJmUpk2wfJwJclZBnacp6Rr+YoTo9hGF50DCKu65ulEqmmk9izG+qtkbJQgyP6VCKvxHa9/D99DQhN9efdd/H5DlAEunz+4/9H64yaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Sun, 14 Sep 2025 19:06:12 +0200
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Helge Deller <deller@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org,
	Linux parisc List <linux-parisc@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate
 page_pool_page_is_pp()
Message-ID: <1757869448@msgid.manchmal.in-ulm.de>
References: <aMSni79s6vCCVCFO@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yGQQKzeyEZMtAyaE"
Content-Disposition: inline
In-Reply-To: <aMSni79s6vCCVCFO@p100>


--yGQQKzeyEZMtAyaE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Helge Deller wrote...

> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en
> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000007c=
 on
> 32-bit platforms.
>=20
> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify page p=
ool
> pages, but the remaining bits are not sufficient to unambiguously identify
> such pages any longer.
>=20
> So page_pool_page_is_pp() now sometimes wrongly reports pages as page pool
> pages and as such triggers a kernel BUG as it believes it found a page po=
ol
> leak.
>=20
> There are patches upcoming where page_pool_page_is_pp() will not depend on
> PP_MAGIC_MASK and instead use page flags to identify page pool pages. Unt=
il
> those patches are merged, the easiest temporary fix is to disable the che=
ck
> on 32-bit platforms.
>=20
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Linux Memory Management List <linux-mm@kvack.org>
> Cc: netdev@vger.kernel.org
> Cc: Linux parisc List <linux-parisc@vger.kernel.org>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Helge Deller <deller@gmx.de>
> Link: https://www.spinics.net/lists/kernel/msg5849623.html
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")

Tested-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>

--yGQQKzeyEZMtAyaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmjG9gAACgkQxCxY61kU
kv2OKg/+I5r7SmuFKfUeJR8lmfesg5+t/EObRKadkYWCImIHaUX2omjB2mblcKP8
3HrhbTGSJvEaqud7y12GGP62Q0elxTUxBQmjedaIibtL0oknVyPwiFrVGrKQ5nPR
Q9DQNFh6GEIiiME2uWh+gmc2lVz8mLnrxtZj/eTlNXYCRwKz9GgEgOVEeJDSrHNE
wcFJQH5Yvteb8n3C1opZNO2+uokGahlH0OCfEFZsGvaFdvusRgTAlyNyV9PXzAlM
okIqWJv8EABX3Zfl8+GA82FSTGT8Bn4sQRu5IrXarzM2POw/nlYnQP36RJrFe6M0
9tFkaLTcKaYWhWSZ8YxtfWjbGufGYNhikqgL5w9MSAeH3twAGGFbx03Q0dzUT8XC
xwq0gfQqGagnADmtvHXF40PTSjeb98El2QQ/Vz/fV/dfJcn6EbNjzYraKtMuMZuX
BlI6wxJEaj/PaGjpPeQ1FcMmuJYSbW/6TKEB8gD5Hgmh0ngbZQ5zJuM1AR0Oe/JZ
mhsio08zmXM8A0wIvWXFsrXsXzSV3hXn9I+sn4DAMz9gx3+O/Ek9/wbww9rcA4lH
DU/zroDnn050JvMJZr00pCFmYeBuvy8cWE3sh6tgN0kdSRUPb222KGLD4dZxfPag
3LuZXw/cgYGtMgw6RxtuiY6nfrouzsYLrQJBNoseZTYCn3VCxNE=
=Qki2
-----END PGP SIGNATURE-----

--yGQQKzeyEZMtAyaE--

