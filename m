Return-Path: <netdev+bounces-114857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D494464A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A31B1F22F48
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6C01586C6;
	Thu,  1 Aug 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXhvcHMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7E15748A;
	Thu,  1 Aug 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500134; cv=none; b=PXcKjGYYxzUujVovK+9rTOMPNrxeeJMiDZreTHRXVYPqD4PDph8DscKsJ+esJ5GghChQ7WdCv+oMHJfrG57mKuejNLpefzcgFodk7fjpvQqjKGI/ntJSoPW1d/IAsFYC4L5maQ2jt5m9s4LXmHN9G4UFIJV6/6KGvhgao25khrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500134; c=relaxed/simple;
	bh=D0BRTDKOL4ZwOxBIvmqwChx6SK9IgZhrOoIUpIoIr6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVul6i/17xyFP+CiXgXWdEd2kNfjaMkWYPD5EQQ8GIgxIcS8xO5j09pY06TYHmm94LmvvxG8lrG1KUX2xqEf4QInQJFXS+A8QSx7e2+U48Z3yUXndDGoVn25pw3RAGFOUdJo9bTNUff8x13PNfaz+fbYdwxQIXVdsUiEkol58dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXhvcHMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8FCC4AF0A;
	Thu,  1 Aug 2024 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500134;
	bh=D0BRTDKOL4ZwOxBIvmqwChx6SK9IgZhrOoIUpIoIr6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXhvcHMMa7wLCwAmyAaKJozjxb+FP5FormbfFAsDQIujiZX7/RP2q+LrP3MXfktZ9
	 dC7f0zMu4NJmWmZp2yzL05tLud0ykUVpsL7mdZj4NkC3Vo/PR1LO4cQ0dhdmWMJyvb
	 z0jxTjraCKhhrzht5s3VCG1Awqtm5D07H2n0rryh90VTUsLlPTJZ9bqEmGiWDnbuzf
	 xnsDQx8wVEsb4ALsAHiw6gRH1ky1R88gXGox1LbVstDCxeyCIcQ3cMbsRPrmkKKT8m
	 fPla8XxGkYBwER7fn73hRCu11iM4oVDHGu0hSGtM/E3L0xGy9s7/BzZKEJoG8quP/T
	 JbXhafXFtEZdw==
Date: Thu, 1 Aug 2024 10:15:31 +0200
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
Message-ID: <ZqtEI4k2KBzz_-cr@lore-desk>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <ZqfpGVhBe3zt0x-K@lore-desk>
 <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
 <20240731183718.1278048e@kernel.org>
 <CA+SN3srMPLcmQ4h_iNst71OkQPFcCYxBRL0Q9hR=7LjJ86TFFA@mail.gmail.com>
 <Zqs5hcFMx1g42Zrd@lore-desk>
 <CA+SN3spwT1hrXQRmk8TkDOfBwp66WWqEAczvNCS7QaTe_eM=Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eNalxqZ9keOVn65"
Content-Disposition: inline
In-Reply-To: <CA+SN3spwT1hrXQRmk8TkDOfBwp66WWqEAczvNCS7QaTe_eM=Vg@mail.gmail.com>


--0eNalxqZ9keOVn65
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Aug 1, 2024 at 10:30=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > nope, I added page_pool support even for non-XDP mode for hw that does
> > not support HW-LRO. I guess mtk folks can correct me if I am wrong but
> > IIRC there were some hw limirations on mt7986/mt7988 for HW-LRO, so I am
> > not sure if it can be supported.
> I know, but if we want to add support for HWLRO alongside XDP on NETSYS2/=
3,
> we need to prevent the PP use (for HWLRO allocations) and enable it
> only when there's
> an XDP program.
> I've been told HWLRO works on the MTK SDK version.

ack, but in this case, please provide even the HW-LRO support in the same
series. Moreover, I am not sure if it is performant enough or not, we could
increase the page_pool order.
Moreover I guess we should be sure the HW-LRO works on all NETSYS2/3 hws
revisions.

Regards,
Lorenzo

>=20
> > > Other than that, for HWLRO we need contiguous pages of different order
> > > than the PP, so the creation of PP
> > > basically prevents the use of HWLRO.
> > > So we solve this LRO problem and get a performance boost with this
> > > simple change.
> > >
> > > Lorenzo's suggestion would probably improve the performance of the XDP
> > > path and we should try that nonetheless.
> >
> > nope, I mean to improve peformances even for non-XDP case with page_poo=
l frag
> > APIs.
> >
> > Regards,
> > Lorenzo
> Yes of course it would improve it for non-XDP case if we still use PP
> for non-XDP,
> but my point is we shouldn't, mainly because of HWLRO, but also the
> extra unnecessary code.

--0eNalxqZ9keOVn65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqtEIwAKCRA6cBh0uS2t
rKCEAQCYVsSLb/+cpyxgo+0vejfJAGAfcQ4rWZE6BwZQX9gzLwD9H8bmdVfHms3q
rcqMITuGtKfT6S7dKQJa0nlKm1qxcQc=
=59Ad
-----END PGP SIGNATURE-----

--0eNalxqZ9keOVn65--

