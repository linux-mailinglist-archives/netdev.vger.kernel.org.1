Return-Path: <netdev+bounces-168477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CCA3F1D6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1817A32C8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCEA20102C;
	Fri, 21 Feb 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvcUqRO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68071C1F2F;
	Fri, 21 Feb 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133309; cv=none; b=eSzmWC7X8UsFxUSVj1J4NaixKFmkEWs/NDx5WPfnJGT9LaFYSHxEk2smQmk7VHFLKqvORSeYEnpuZRGcuOyv80YDKve+9ou/dJLrHkzrrUeu2Nc0i28cYSqBl/YpfeA+k1A2wV2+ewKRr18Ja8AHdatix44tvlmlhy4cRuIRi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133309; c=relaxed/simple;
	bh=XGK2u8TzDSVYk6sYqHcLEUtV1chH/9Nf1/m1rp6PLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaGlTS/uDFrkw2P23Vaoh+vuZdHJTI1oXMxi+MsbbbqvmS7/j3x25giQKnZrb3pTGz0hIccpDqyK7v+JYhKTvspyII6dnoc+N236YMoDgaJOvPrs03C51NwGerx/zS7sfmVONmP1u+zrZTj/gQRB1t7iWOqBVrFYY0Kgq5vUMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvcUqRO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB3C4CED6;
	Fri, 21 Feb 2025 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133309;
	bh=XGK2u8TzDSVYk6sYqHcLEUtV1chH/9Nf1/m1rp6PLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvcUqRO/wdyzQqZ5+SB544WaloOOKDZNuHTBCKvW+7CKs50oi/U8PLV45rCydbztx
	 eI03a66HfPq+gU/kWT3snjZAMEzAdno1YL2FwkdFu79HZY60KB2YVpGSd7lH05mpfq
	 NEOHRSOBFjmBUin5DC+CUoLSCFl1pNq+hwQGu4bJSC/TZnd1VJeFJ5+Nkq/anr72XT
	 Srd42611UD0zqqp3wNGozkxmgbOhJEvmsPB6lJf0UDrGa6yfMdgLE4xos9FNIm0eyj
	 739Y04BzEU5Zc5miWg53unjJMXGzla/6gHq6nZvheOQXrmMBKyUwu56ZJ9n9q7Efib
	 4TjYeFeJhLMuw==
Date: Fri, 21 Feb 2025 11:21:46 +0100
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
Subject: Re: [PATCH net-next v5 12/15] net: airoha: Introduce Airoha NPU
 support
Message-ID: <Z7hTujrG-zOiBcZe@lore-desk>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
 <20250217-airoha-en7581-flowtable-offload-v5-12-28be901cb735@kernel.org>
 <20250220143839.5ea18735@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RxJWLYxefS/CP3b0"
Content-Disposition: inline
In-Reply-To: <20250220143839.5ea18735@kernel.org>


--RxJWLYxefS/CP3b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 20, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 14:01:16 +0100 Lorenzo Bianconi wrote:
> > +static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> > +			       void *p, int size)
> > +{
> > +	u16 core =3D 0; /* FIXME */
> > +	u32 val, offset =3D core << 4;
> > +	dma_addr_t dma_addr;
> > +	void *addr;
> > +	int ret;
> > +
> > +	addr =3D kzalloc(size, GFP_ATOMIC | GFP_DMA);
>=20
> You need the actual "zone DMA" memory from ISA times?
> I think that's what GFP_DMA is for. Any kmalloc'd memory
> can be DMA'ed to/from.

ack, I agree. We can drop it. I will fix it in v6.

>=20
> > +	if (dma_set_coherent_mask(dev, 0xbfffffff))
>=20
> Coherent mask is not contiguous on purpose?
> Quick grep reveals no such cases at present, not sure if it works.
> Maybe add a comment, at least ?

Ack, right. I think it is wrong. I will fix it in v6.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--RxJWLYxefS/CP3b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7hTugAKCRA6cBh0uS2t
rANTAQDEQ8k7BX7x63iA2wmUooQvqpv1wCUZnNUKVcwf10KapgEAwCZGXymtR/Vg
ssK3jSJEkoXsWRojYyqODeH7VvJcfgA=
=KhfQ
-----END PGP SIGNATURE-----

--RxJWLYxefS/CP3b0--

