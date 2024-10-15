Return-Path: <netdev+bounces-135764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2399F206
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC562833A8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35001D514E;
	Tue, 15 Oct 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me6mUSlJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2514A0A7
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007702; cv=none; b=KYlv+VrJOkmI37LMaJNbdBP3FCkBwEosP9LvytB8XtZFQJZM7X6cuZ8spr/pY6xE7CXMGadk1Ut8HTW5kL8twSpR9WWw11KM+bYdSAgeMLs5rxDtA0G8oV2Yzz1OpMsPq+UHbfbOTlnWP2Vr/L6wem1GJDTgpa1TuusDBGtIcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007702; c=relaxed/simple;
	bh=FZT8eUVAP1Th0PhWw2NBLyprwi9M9ThW0WrOYeOJ1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNZkYDRTHT+omrDUaI/3btEgK3Nzv8uJT5MMY7AIg2OwHeJqvHjjEDTY//JarjlG68HHtYuoyEe81yMjahCesBfbdB/7YbbYwodCi3HVZTyKvfVwCo8yIkkTxZ5ayi9l0JKm9tcnOrywoC39jJjaJjvSVmL0Sybm4yqo7rJvmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me6mUSlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4594C4CECF;
	Tue, 15 Oct 2024 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729007702;
	bh=FZT8eUVAP1Th0PhWw2NBLyprwi9M9ThW0WrOYeOJ1ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me6mUSlJBOODqtENnFguUrYd2grSuTFrIEjflVdbxhijjEN1wVDSv5C3eiQehdfh5
	 PZgnTuMFb7HH8nRmaB/XG+ZUDGEswzxkZuu6Y4pvFGJx0XweHnQrfyAAVrLrZLGFyp
	 x0DUu9PM8mrsknA+ceaAn62sG0Dp2rC2opS8zPr8AvDAkFDEugF8JGW7/mX+b+VNEq
	 WxhHeFq/NJCM3yfo7sfXsHW2QY1OJKNEeRfeARGZh7Zldvhn/uXEZMdO7B3MlWRfgY
	 tGJIjHwGZRpqUfBEl5lzYEjWcMaZbbm97Dq6eNWuaoDQuHq3SKWBKMoF6Gq6YqBaqT
	 Ty6NDEmJ99jrg==
Date: Tue, 15 Oct 2024 17:54:59 +0200
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
Subject: Re: [PATCH net-next v2] net: airoha: Implement BQL support
Message-ID: <Zw6QUxpdnJtorc_e@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
 <20241015073255.74070172@kernel.org>
 <Zw5-jJUIWhG6-Ja4@lore-desk>
 <20241015075255.7a50074f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6qBPvwxWse3BTuY"
Content-Disposition: inline
In-Reply-To: <20241015075255.7a50074f@kernel.org>


--h6qBPvwxWse3BTuY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 15, Jakub Kicinski wrote:
> On Tue, 15 Oct 2024 16:39:08 +0200 Lorenzo Bianconi wrote:
> > On Oct 15, Jakub Kicinski wrote:
> > > On Sat, 12 Oct 2024 11:01:11 +0200 Lorenzo Bianconi wrote: =20
> > > > Introduce BQL support in the airoha_eth driver reporting to the ker=
nel
> > > > info about tx hw DMA queues in order to avoid bufferbloat and keep =
the
> > > > latency small. =20
> > >=20
> > > TBH I haven't looked at the code again, but when I looked at v1 I was
> > > surprised you don't have a reset in airoha_qdma_cleanup_tx_queue().
> > > Are you sure it's okay? It's a common bug not to reset the BQL state
> > > when queue is purged while stopping the interface. =20
> >=20
> > So far airoha_qdma_cleanup_tx_queue() is called just in airoha_hw_clean=
up()
> > that in turn runs just when the module is removed (airoha_remove()).
> > Do we need it?
>=20
> Oh, thought its called on stop. In that case we're probably good
> from BQL perspective.
>=20
> But does it mean potentially very stale packets can sit on the Tx
> ring when the device is stopped, until it's started again?

Do you mean the packets that the stack is transmitting when the .ndo_stop()=
 is
run?=20
In airoha_dev_stop() we call netif_tx_disable() to disable the transmission=
 on
new packets and inflight packets will be consumed by the completion napi,
is it not enough? I guess we can even add netdev_tx_reset_subqueue() for al=
l netdev
queues in airoha_dev_stop(), I do not have a strong opinion about it. What
do you prefer?

Regards,
Lorenzo

--h6qBPvwxWse3BTuY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZw6QUwAKCRA6cBh0uS2t
rCyKAQDDWOwLJQOoDmMd9LiMu19jaoyDYvhimdVvvRQYcr5rcAD+JJizGAhBA8wi
/V2iQsgIkeOGWyDjiuxvCNclacQM/ww=
=cJ72
-----END PGP SIGNATURE-----

--h6qBPvwxWse3BTuY--

