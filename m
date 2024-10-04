Return-Path: <netdev+bounces-131911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5C98FEEC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788581C21883
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480384A32;
	Fri,  4 Oct 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Bw81LC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914461802E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030621; cv=none; b=oIThM33JNXRM8vgDxqyMUy757WICRvXuVpF9tX3JlyNvr23AoRWVw1zYBMgeeuLQf1mQVft9oSPzy0a1zefLm0iOIIOe0rInAjhFcwap8J6AaYuoCmHSwinkTMOGSI4tNtcm2K9CaBPV9osIrKGya1bSZ/0hFsCjGIOtwnN7Osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030621; c=relaxed/simple;
	bh=ONouNg2hF9X/86Cv/92Njjj7IySTDtFAXczcRyccvTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogGddk/VLG0vnPP5RXM26hL2XlsFORN2MDOHte3D9gcopPg/04Iw81OqsX0UAllZ0PF4UqUSGhpHKeyjMHwR7QmJefbOR8nMSFjaCgA3cTtNm9vEiaJUj9ZLUUq8oLT0Mth5IbkDfW0uCzffKV0p7ByBA/zEb0Knfz2wH8Sw8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Bw81LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C925C4CEC6;
	Fri,  4 Oct 2024 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728030621;
	bh=ONouNg2hF9X/86Cv/92Njjj7IySTDtFAXczcRyccvTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0Bw81LCVRE2qnKCTReH//grgrJpgftd1AdMIrIBZ0f+2GNjcQmxr9M/9m3GOH2lQ
	 O7jO9cC/JMrEZaB9oZO+88nQsoZFWCp2ih74OmmoKBgnigg2qCag81qpp7qWIzFVfA
	 N0ppC18YJCg8VXfuvI988OGA1xYYi8cNESwVm/enN2XH9QQvegdW4v+GpxSWgJHctL
	 CywtXVcoHGpEO+cRn0rBVAM4Y+67LRoGJJh193tbLrWeZG7CHbP/uXIH437/xQZTqC
	 wIUzukI/k5cHdQWbH+KB8YWjBqLdgA4OAZq7Gp8j07xO9Yg0FcEXFSr9WnnXeh/q+y
	 qtUwN4KdKVLJg==
Date: Fri, 4 Oct 2024 10:30:18 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next] net: airoha: Implement BQL support
Message-ID: <Zv-nmru1Qx6lk9o4@lore-desk>
References: <20240930-en7581-bql-v1-1-064cdd570068@kernel.org>
 <20241003172407.1bf35bf1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rEW0/ZG3FlIaXvJn"
Content-Disposition: inline
In-Reply-To: <20241003172407.1bf35bf1@kernel.org>


--rEW0/ZG3FlIaXvJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 30 Sep 2024 14:58:35 +0200 Lorenzo Bianconi wrote:
> > Introduce BQL support in the airoha_eth driver to avoid queuing to much
> > packets into the device hw queues and keep the latency small.
>=20
> This patch got set to Superseded in patchwork, somehow, but I don't see
> a newer version. I think you're missing resetting the BQL state in
> airoha_qdma_cleanup_tx_queue() ?
> --=20
> pw-bot: cr

Hi Jakub,

for an unknown reason my email about dropping this patch has not gone throu=
gh.
Sorry for that. I need to rework this patch in preparation of qdisc offload=
ing.

Regards,
Lorenzo

--rEW0/ZG3FlIaXvJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZv+nmgAKCRA6cBh0uS2t
rNCEAQDrvLXLmeoE6s/7ZGvUBRDhTOD+QYZSjAMKknKkkoNhVwD+Ke9qn46kmxyu
t/XdrlTpEiVE5LvLitObOxZIMCX4Egg=
=J9rN
-----END PGP SIGNATURE-----

--rEW0/ZG3FlIaXvJn--

