Return-Path: <netdev+bounces-168689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC3A40315
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F3A3AA589
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1207C24C67A;
	Fri, 21 Feb 2025 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDE5GPdA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1E1EE028;
	Fri, 21 Feb 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178583; cv=none; b=uHnlQwJJIRNx0T+isuhlqPMmcSbitt6a+rpyU+hMkdAu7DWpFq6eLOILFVAKrLH3nT7KLHMViJ/KR+7wKEP92/3YZA9LZ7vXSa9k7JevO3UIckmPHgYT6aNrI57Zn51UycXXjhrgaajGTHPHX1/OlM+FDG7XZSx+K6MgMXjGJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178583; c=relaxed/simple;
	bh=Ka0DRUByZEjytukX3Y0ZxmgbHJ1AWQmN9+6GeZEtS4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ3pzxD+xwxK7ByUSjD5hVtKxAQ/X6t+aBWDNgoKzX94qSp3hhUrbpfoxWgCuPfLx6rcdnBGalltG9AZVVWk31moFJltcUmkO8U7JJD2IDm3t8ySUtfd7TcDu8WDJhFfNPPEyNmh9dr8ZFxx/X/cJ71iibG8xAn9UdAgPGiVOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDE5GPdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8C0C4CED6;
	Fri, 21 Feb 2025 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740178582;
	bh=Ka0DRUByZEjytukX3Y0ZxmgbHJ1AWQmN9+6GeZEtS4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDE5GPdAG7hNwNwiVAGT5GKN5nMZOLXIP4mGEaCei8HTmqX9awjC7Zh4T/WuEjDds
	 xHRkcpygkdgnd3JhxUVS3bNTcuQHUfU+Coq1cDF+5JP9MriVUsVukyxCS+5XmRnTk8
	 HcsRhTqyPji+EdaYxEnT/ol7pL7Fdzz1HHxQXxw8TeLTtc4edZjHy2xgj822tOea8O
	 Gd6zjeTX+o4V3ZxdNpKCyvwpeEiNFuDy3spAIj970ElH4SOXrbRYPZ9xVi1Kci+Cbs
	 hHwraMPN1skgXbc1ypMM5m2Ybogs00JjlQuT25Zg68lAmix5XtPazKY0qRk+R+mXS4
	 Mcleg14SatFvg==
Date: Fri, 21 Feb 2025 23:56:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v6 12/15] net: airoha: Introduce Airoha NPU
 support
Message-ID: <Z7kEk1EduSiIQ-_g@lore-desk>
References: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
 <20250221-airoha-en7581-flowtable-offload-v6-12-d593af0e9487@kernel.org>
 <20250221141635.4d01e792@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdu6KHnWeLWh1Yn3"
Content-Disposition: inline
In-Reply-To: <20250221141635.4d01e792@kernel.org>


--cdu6KHnWeLWh1Yn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 21 Feb 2025 11:28:13 +0100 Lorenzo Bianconi wrote:
> > +	addr =3D kzalloc(size, GFP_ATOMIC);
> > +	if (!addr)
> > +		return -ENOMEM;
> > +
> > +	memcpy(addr, p, size);
>=20
> coccicheck says:
>=20
> drivers/net/ethernet/airoha/airoha_npu.c:128:8-15: WARNING opportunity fo=
r kmemdup

ack, I will fix it in v7.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--cdu6KHnWeLWh1Yn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7kEkwAKCRA6cBh0uS2t
rIf3AP4jBL5NkpvTLF12BAQUCaZnPrUQS87ss38GQIdjJ1jWqgEAvsBOs54/Vn+i
u4hGD/DEtqYAZNRviFUfHTuumTOidAM=
=WZls
-----END PGP SIGNATURE-----

--cdu6KHnWeLWh1Yn3--

