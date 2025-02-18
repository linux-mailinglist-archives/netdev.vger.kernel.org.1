Return-Path: <netdev+bounces-167349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19534A39DF6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F13A8864
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29016269897;
	Tue, 18 Feb 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMtz+lIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9321CC6E;
	Tue, 18 Feb 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886345; cv=none; b=mf5HyyN7zfzJOY1Q+dr7BQ5rzg1bW1byTHmpUW/LJzf3CW+/isqQNQRzZ7qO0XkNp9dTjz7sXRGWPO6F/+50yLVSZh3jY9AIcKyLPNzTqMvN/1LQ0Ksn12HaZ0o/2Q1E5uqw6LVdJTMlQVriJPb36VGD2WAP/qBq2fY5otmHJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886345; c=relaxed/simple;
	bh=NGVf+P6KvHNTb1CcTFmAMfl9hGQIGIue5R+BMUnA0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgFM1umbYHNzdDU1h06I9TfAJjmiGJc/eqTCBUTrP8rs6vj4chTK6ZnqUBoAqK5f5eJ6Dg0wrrdP5PbZm6S5qrNRx9zVW2fo0X8pWCkrGCGC/LXulgw7h11gIU153eklqHlHnxqqJ0bdavz/zCALuICueTO5nenDujCBlTNg3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMtz+lIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85FFC4CEE6;
	Tue, 18 Feb 2025 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739886344;
	bh=NGVf+P6KvHNTb1CcTFmAMfl9hGQIGIue5R+BMUnA0bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMtz+lIUo5lJA/yhcSPVdzxocKt3ncQeer0uUJhqtEaSVQw4aCu4SDtNRMQt0WS4d
	 kX0ec66X2rAvJGMh/28M8li2Q3cNSfYfmFU4zPfOgSwMPl4+cclCkudB2SNnaTRxqA
	 7OZq9wiIwS668tKQ3ntagl25dodHmPY3HPucf5OXJ0q7YB5k3xT6nlez5axGKQcCV0
	 5OWeWKG/HlsD1CcwFQgU2JBlQDT1LbNFSEekqkwUDzbEApRkOvwxD2skK3OOmI56vF
	 JVVQwzKX+if8AohHa/q2s8S7rN+NBdI+OslrEvT5kXJHLz3PT4pIJQL+G0jEfGZJ76
	 4ouz70a8E6rTw==
Date: Tue, 18 Feb 2025 14:45:41 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next v4 13/16] net: airoha: Introduce Airoha NPU
 support
Message-ID: <Z7SPBfzzKt1nhYFo@lore-desk>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
 <20250213-airoha-en7581-flowtable-offload-v4-13-b69ca16d74db@kernel.org>
 <20250217183854.GP1615191@kernel.org>
 <Z7OMv-7UBVtKaEFb@lore-desk>
 <20250218132756.GU1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bN7niAAw7M/hEpBR"
Content-Disposition: inline
In-Reply-To: <20250218132756.GU1615191@kernel.org>


--bN7niAAw7M/hEpBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 18, Simon Horman wrote:
> On Mon, Feb 17, 2025 at 08:23:43PM +0100, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > > > +	err =3D devm_request_irq(dev, irq, airoha_npu_mbox_handler,
> > > > +			       IRQF_SHARED, "airoha-npu-mbox", npu);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++) {
> > > > +		struct airoha_npu_core *core =3D &npu->cores[i];
> > > > +
> > > > +		spin_lock_init(&core->lock);
> > > > +		core->npu =3D npu;
> > > > +
> > > > +		irq =3D platform_get_irq(pdev, i + 1);
> > > > +		if (irq < 0)
> > > > +			return err;
>=20
> ...
>=20
> > > Should this return irq rather than err?
> >=20
> > are you referring to devm_request_irq()?
> >=20
> > https://elixir.bootlin.com/linux/v6.13.2/source/include/linux/interrupt=
=2Eh#L215
> > https://elixir.bootlin.com/linux/v6.13.2/source/kernel/irq/devres.c#L52
> >=20
> > I guess it returns 0 on success and a negative value in case of error.
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> Sorry, somehow I completely messed-up trimming context and managed to make
> things utterly confusing.
>=20
> I've trimmed things again, and it is the platform_get_irq() call
> not far above this line that I'm referring to. It assigns the
> return value of a function to irq, tests irq, but returns err.

ack, right. I will fix it in v6.

Regards,
Lorenzo

>=20
> It is one of (at least) two calls to platform_get_irq() in airoha_npu_pro=
be().
>=20

--bN7niAAw7M/hEpBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ7SPBQAKCRA6cBh0uS2t
rKsQAP9QYUVrqGhw3N4HoThHMo6upM1fVYEMznrrOpbmN0z4iwEApdOkmd6OHAnI
qAhZUPJpZNB70oO/k90a0TMOLcqBfAg=
=AafE
-----END PGP SIGNATURE-----

--bN7niAAw7M/hEpBR--

