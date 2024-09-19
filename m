Return-Path: <netdev+bounces-128976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48B97CB1E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DB0B21E20
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A619F495;
	Thu, 19 Sep 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/fncxpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F419F41B
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756850; cv=none; b=pgFhJn6jvAj68LtX3kuHgRgPgwTqNmsP28w0yhONrvpxsLmXWyuxEGaHLMXaU5BoRbrPSHPzzqI3Ejx0jFwYwMvBSZw0SSNMKMc3CwYIusIayuQGsjblbrOX1OI7ZFxsjZuTBrdly8r1U5zl5OeNBIEYiYShsOIqGfEGyodkjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756850; c=relaxed/simple;
	bh=DtaXDtIlQ+aZv3XeFJdds6mqTEjBCovbRMFB5xz3VRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKvuj7qkLX7sjJdffEob/Au3FECGxzUCk6NYuZLBckaKkpFPN258O20cQhFsJ83Snf/okqMJosaKbwGtufeM3P2JwRfKp6sIuvlm9FsHTm6fJbJjJm/+Qj4olTBf1aJsjl74VK/1aWt58+zg0y5JbZlFlYCsGZ2lVcG5YMM9uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/fncxpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC355C4CEC4;
	Thu, 19 Sep 2024 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726756849;
	bh=DtaXDtIlQ+aZv3XeFJdds6mqTEjBCovbRMFB5xz3VRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/fncxpNGg8lXlXWpP4iqecKl6t0r64SrwUKC/ELG35CBvL4uDdXzkv4gdOoTmO3v
	 jcAAqJINj6tNXeut7mSZJYIS8WzeSTVmmtOKI7NCasMSEoW+6yqs95Bgp1EJnbcwjn
	 2mAlMKDA14XMoA7Ky/ziQaTNzfkJHEnW3Ful8VcQaoyVZ7TLNu8U8HS+qaNmg0GuLl
	 AoK7dUIC61Nod7UAuDkV/fbgOZrDBcJk+o026x/cxjFvKIrz/G5+pbnBoNcRzayZF0
	 9NmGb46JEOe9vc32XJYioQNIedbOU4q49Wj4PZj2OpKOghSep7ao0MsyYWyoobzbVx
	 aLMWk/jolWqCA==
Date: Thu, 19 Sep 2024 16:40:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Message-ID: <Zuw37gJFhnVdfSuV@lore-desk>
References: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>
 <20240919074210.GE1044577@kernel.org>
 <Zuwf57d09WBYKtSS@lore-desk>
 <20240919135222.GC1571683@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jf6gr5Sasy5BNssU"
Content-Disposition: inline
In-Reply-To: <20240919135222.GC1571683@kernel.org>


--jf6gr5Sasy5BNssU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Sep 19, 2024 at 02:58:15PM +0200, Lorenzo Bianconi wrote:
> > > On Wed, Sep 18, 2024 at 04:37:30PM +0200, Lorenzo Bianconi wrote:
> > > > Align PSE memory configuration to vendor SDK. In particular, increa=
se
> > > > initial value of PSE reserved memory in airoha_fe_pse_ports_init()
> > > > routine by the value used for the second Packet Processor Engine (P=
PE2)
> > > > and do not overwrite the default value.
> > > > Moreover, store the initial value for PSE reserved memory in orig_v=
al
> > > > before running airoha_fe_set_pse_queue_rsv_pages() in
> > > > airoha_fe_set_pse_oq_rsv routine.
> > >=20
> > > Hi Lorenzo,
> >=20
> > Hi Simon,
>=20
> Hi Lorenzo,
>=20
> > >=20
> > > This patch seems to be addressing two issues, perhaps it would be best
> > > to split it into two patches?
> >=20
> > ack, I will do.
>=20
> Thanks.
>=20
> > > And as a fix (or fixes) I think it would be best to describe the
> > > problem, typically a user-visible bug, that is being addressed.
> >=20
> > This is not a user-visible bug, do you think it is better to post it to
> > net-next (when it is open)?
>=20
> Yes, I think that would be best.

ack, fine to me.

>=20
> If you do so please don't included any Fixes tags.
> Instead, if you want to refer to a patch, use the
> following syntax within the patch description.
> AFAIK, unlike Fixes tags, it may be line wrapped as appropriate.
>=20
> commit 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")

ack, fine. I was not aware of it :)

Regards,
Lorenzo

>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > > Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for E=
N7581 SoC")
> > > > Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > ...
>=20
>=20

--jf6gr5Sasy5BNssU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuw37gAKCRA6cBh0uS2t
rBqRAP9X7zSpYurYZzc13ZVBPyfcbcBSS82Z1mV5gswUUIWyhAEAunu6uKQwoQIz
Mjj4oVkKbrY2CJQq1NzCkgJRvTZK0A8=
=z+1M
-----END PGP SIGNATURE-----

--jf6gr5Sasy5BNssU--

