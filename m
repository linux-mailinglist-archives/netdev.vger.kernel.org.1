Return-Path: <netdev+bounces-165223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806CA31166
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B863F188146C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20A25332A;
	Tue, 11 Feb 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG70fRgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000052AE6A;
	Tue, 11 Feb 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291470; cv=none; b=uopkr64Utzxfqn12z8+5s0ZmKJcugiH7YvicEkkaaEjyj8J9hQLsUGNqWeN0PLgP1ZNCdh6IeGhOytq8XMyc/RGWlj5rEGHT9ryGOAM4DFqttIZKqJ5QZ3aS7dzTaWVTfZSq6rt09nfcLB6RHzQ7Ti1F4dUkNo5esXBNmDQgE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291470; c=relaxed/simple;
	bh=oNhS/OBG05YZ+KCQ5QX2hfKKhn/P9r6dBgmu5lyTEck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWapyF6r/N4MSr9rlUO/38mOl9zXcF4pWC4LiRLZHJ+wBnrrfWy4x9IFy0UZf84GrO4tuasKSCi3TtNBlxCcK/F5anyuoScUkKmD5lwDPloIIC2KCPzeMT6kqtYFNA3N2sGsdj0iBGO00ueuTFhRhpf/sIbJbadnRLFxnIbKyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG70fRgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D06C4CEDD;
	Tue, 11 Feb 2025 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291469;
	bh=oNhS/OBG05YZ+KCQ5QX2hfKKhn/P9r6dBgmu5lyTEck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NG70fRgbr/NArbeLI4XwktHJ14RVRgAUMRyVVKt+VVJiehyoI0RrETiIRDzicTvhl
	 7HjgRml0wM+6lKDGa6BXOM7L8qIWhOAqfaVspzZ38BqQ1Qw0xb2ZpLtNFIK+am5ueC
	 6c2Wcuh35njecJWyK7aQ/EurXnODJK/rnDQqhNxZCHIHpv8/MV8FdigUeT8rWM/wnX
	 lQ2Jv2RtNT51wUtYvb/iCO8JcoVQt16Axa1JF4j8SP+N8uLsH/prWoBASkF5K976Ec
	 q5jF8l5dZbCoT9/kBQNjt3QyQ0zWviXDPHbN15b5cWVKkL78nVe6K1s2UgWufupyDP
	 ntm5IEEZzgMng==
Date: Tue, 11 Feb 2025 17:31:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH net-next v3 13/16] net: airoha: Introduce PPE
 initialization via NPU
Message-ID: <Z6t7SuFurbGwJjt_@lore-desk>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-13-dba60e755563@kernel.org>
 <20250211-fanatic-smoky-wren-f0dcc9@krzk-bin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2jqDdovRQTl6Nrb"
Content-Disposition: inline
In-Reply-To: <20250211-fanatic-smoky-wren-f0dcc9@krzk-bin>


--g2jqDdovRQTl6Nrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Feb 09, 2025 at 01:09:06PM +0100, Lorenzo Bianconi wrote:
> > +static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
> > +{
> > +	struct airoha_npu_core *core =3D core_instance;
> > +	struct airoha_npu *npu =3D core->npu;
> > +	int c =3D core - &npu->cores[0];
> > +	u32 val;
> > +
> > +	airoha_npu_rmw(npu, REG_WDT_TIMER_CTRL(c), 0, WDT_INTR_MASK);
> > +	val =3D airoha_npu_rr(npu, REG_WDT_TIMER_CTRL(c));
> > +	if (FIELD_GET(WDT_EN_MASK, val))
> > +		schedule_work(&core->wdt_work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +struct airoha_npu *airoha_npu_init(struct airoha_eth *eth)
> > +{
> > +	struct reserved_mem *rmem;
> > +	int i, irq, err =3D -ENODEV;
> > +	struct airoha_npu *npu;
> > +	struct device_node *np;
> > +
> > +	npu =3D devm_kzalloc(eth->dev, sizeof(*npu), GFP_KERNEL);
> > +	if (!npu)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	npu->np =3D of_parse_phandle(eth->dev->of_node, "airoha,npu", 0);
> > +	if (!npu->np)
> > +		return ERR_PTR(-ENODEV);
>=20
> Why? The property is not required, so how can missing property fail the
> probe?

similar to mtk_wed device, airoha_npu is not modeled as a standalone driver,
but it is part of the airoha_eth driver. If you think it is better, I can
rework it implementing a dedicated driver for it. What do you think?

>=20
> This is also still unnecessary ABI break without explanation/reasoning.

At the moment if airoha_npu_init() fails (e.g. if the npu node is not prese=
nt),
it will not cause any failure in airoha_hw_init() (so in the core ethernet
driver probing).

>=20
> > +
> > +	npu->pdev =3D of_find_device_by_node(npu->np);
> > +	if (!npu->pdev)
> > +		goto error_of_node_put;
>=20
> You should also add device link and probably try_module_get. See
> qcom,ice (patch for missing try_module_get is on the lists).

thx for the pointer, I will take a look to it.

>=20
> > +
> > +	get_device(&npu->pdev->dev);
>=20
> Why? of_find_device_by_node() does it.

ack, I will fix it.

>=20
> > +
> > +	npu->base =3D devm_platform_ioremap_resource(npu->pdev, 0);
> > +	if (IS_ERR(npu->base))
> > +		goto error_put_dev;
> > +
> > +	np =3D of_parse_phandle(npu->np, "memory-region", 0);
> > +	if (!np)
> > +		goto error_put_dev;
> > +
> > +	rmem =3D of_reserved_mem_lookup(np);
> > +	of_node_put(np);
> > +
> > +	if (!rmem)
> > +		goto error_put_dev;
> > +
> > +	irq =3D platform_get_irq(npu->pdev, 0);
> > +	if (irq < 0) {
> > +		err =3D irq;
> > +		goto error_put_dev;
> > +	}
> > +
> > +	err =3D devm_request_irq(&npu->pdev->dev, irq, airoha_npu_mbox_handle=
r,
> > +			       IRQF_SHARED, "airoha-npu-mbox", npu);
> > +	if (err)
> > +		goto error_put_dev;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++) {
> > +		struct airoha_npu_core *core =3D &npu->cores[i];
> > +
> > +		spin_lock_init(&core->lock);
> > +		core->npu =3D npu;
> > +
> > +		irq =3D platform_get_irq(npu->pdev, i + 1);
> > +		if (irq < 0) {
> > +			err =3D irq;
> > +			goto error_put_dev;
> > +		}
>=20
> This is all confusing. Why are you requesting IRQs for other - the npu -
> device? That device driver is responsible for its interrupts, not you
> here. This breaks encapsulation. And what do you do if the other device
> starts handling interrupts on its own? This is really unexpected to see
> here.

As pointed out above, there is no other driver for airoha_npu at the moment,
but I am fine to implement it.

Regards,
Lorenzo

>=20
> > +
> > +		err =3D devm_request_irq(&npu->pdev->dev, irq,
> > +				       airoha_npu_wdt_handler, IRQF_SHARED,
> > +				       "airoha-npu-wdt", core);
> > +		if (err)
> > +			goto error_put_dev;
> > +
> > +		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
> > +	}
> > +
> > +	if (dma_set_coherent_mask(&npu->pdev->dev, 0xbfffffff))
> > +		dev_err(&npu->pdev->dev,
> > +			"failed coherent DMA configuration\n");
> > +
> > +	err =3D airoha_npu_run_firmware(npu, rmem);
> > +	if (err)
> > +		goto error_put_dev;
> > +
> > +	airoha_npu_wr(npu, REG_CR_NPU_MIB(10),
> > +		      rmem->base + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
> > +	airoha_npu_wr(npu, REG_CR_NPU_MIB(11), 0x40000); /* SRAM 256K */
> > +	airoha_npu_wr(npu, REG_CR_NPU_MIB(12), 0);
> > +	airoha_npu_wr(npu, REG_CR_NPU_MIB(21), 1);
> > +	msleep(100);
> > +
> > +	/* setting booting address */
> > +	for (i =3D 0; i < AIROHA_NPU_NUM_CORES; i++)
> > +		airoha_npu_wr(npu, REG_CR_BOOT_BASE(i), rmem->base);
> > +	usleep_range(1000, 2000);
> > +
> > +	/* enable NPU cores */
> > +	/* do not start core3 since it is used for WiFi offloading */
> > +	airoha_npu_wr(npu, REG_CR_BOOT_CONFIG, 0xf7);
> > +	airoha_npu_wr(npu, REG_CR_BOOT_TRIGGER, 0x1);
> > +	msleep(100);
> > +
> > +	return npu;
> > +
> > +error_put_dev:
> > +	put_device(&npu->pdev->dev);
>=20
> Missing platform_device_put()
>=20
> > +error_of_node_put:
> > +	of_node_put(npu->np);
> > +
> > +	return ERR_PTR(err);
> > +}
> > +
> > +void airoha_npu_deinit(struct airoha_npu *npu)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(npu->cores); i++)
> > +		cancel_work_sync(&npu->cores[i].wdt_work);
> > +
>=20
> Leaking device put.
>=20
> > +	put_device(&npu->pdev->dev);
> > +	of_node_put(npu->np);
>=20
> Best regards,
> Krzysztof
>=20

--g2jqDdovRQTl6Nrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ6t7SgAKCRA6cBh0uS2t
rGOSAP9ajQ5bBXTGIXJFOaDlhfq5P0lEKUu7Bq7as0Wrb/CiHwD+MjobPeqtgWPG
gTwY8bZNqtz2FbpzlvqWNUyz/50ToAo=
=svVA
-----END PGP SIGNATURE-----

--g2jqDdovRQTl6Nrb--

