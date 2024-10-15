Return-Path: <netdev+bounces-135713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0199EFC4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB04281663
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9261C07D5;
	Tue, 15 Oct 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtGxrool"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543514A4E0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003151; cv=none; b=UiO4ON4VeWWnt0k4KMn+R+rKq02btZhzoPGYrqMM37jNXYNh3bdcCJLbGD3lDg6XukBl6d4hDdaTrX9DdagxfryRAlm/qRdkNPEC+fs/xbkXi4LEfBWaizFQjuDmhjBS3IyeTL3ZmRlCY55qkwqZwamU+qB8xGHWZr3m/LzkDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003151; c=relaxed/simple;
	bh=3dIkEUiVTAefPTGSQ1DsXqyfC5j2X1Y+KoR2VozeEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjzf4DNvBGFeRQMBCObveJpASo7PhQxspXtaP1wsbrx9u8YFyHPLll9mh42PwIpSwspmJRZSMFJCIc2pjdnY/p7DQXJE0083cjktwpc6k3PUlkuOjErssSmzQhzl6z3v+pGb2TICSOrrlCqYlA5OWtrBp0DUGjCIv7EXij0hBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtGxrool; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CE9C4CEC6;
	Tue, 15 Oct 2024 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729003150;
	bh=3dIkEUiVTAefPTGSQ1DsXqyfC5j2X1Y+KoR2VozeEkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtGxroolEmsbOtOKKHbMCn+g5f0W9pfoaAh+Ba/uHiEiUudMFgJeEiQxXQ00l5j/L
	 RwGm7erY6HUazc/Qu9hLJ6b9u/nZK0BPheiJx16ch66k8jMJmnsSzfkF3yWEDAfaLn
	 LzbUJXPvnjHiSUvJSAjc+Q/x6RImhJP7Q1snr3FZzIF2wNMSnQyyFyFM2Nn9aOT+Fs
	 qxmIvcO8JznHz4DtcI0UTHBX2D86ysnFhaG7ETTfWP5hFk2pARH4zYBpBiTWKsXAYu
	 DymuFFsnWrYgnSlZfH5OQngSNciPTCo2YLd42AHOiBm8DSwvk/bSEruWPPNlpnyHBC
	 i+LXZgMW9x9og==
Date: Tue, 15 Oct 2024 16:39:08 +0200
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
Message-ID: <Zw5-jJUIWhG6-Ja4@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
 <20241015073255.74070172@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S175T165iell00YN"
Content-Disposition: inline
In-Reply-To: <20241015073255.74070172@kernel.org>


--S175T165iell00YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 15, Jakub Kicinski wrote:
> On Sat, 12 Oct 2024 11:01:11 +0200 Lorenzo Bianconi wrote:
> > Introduce BQL support in the airoha_eth driver reporting to the kernel
> > info about tx hw DMA queues in order to avoid bufferbloat and keep the
> > latency small.
>=20
> TBH I haven't looked at the code again, but when I looked at v1 I was
> surprised you don't have a reset in airoha_qdma_cleanup_tx_queue().
> Are you sure it's okay? It's a common bug not to reset the BQL state
> when queue is purged while stopping the interface.

So far airoha_qdma_cleanup_tx_queue() is called just in airoha_hw_cleanup()
that in turn runs just when the module is removed (airoha_remove()).
Do we need it?

Regards,
Lorenzo

--S175T165iell00YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZw5+jAAKCRA6cBh0uS2t
rIkQAQDqV7Mo4T8/4fbzV0YPdonPq6Q1aTiXxWBuWts88w+ccQD/bxU3AHKNspoN
I0jY9vv4CmS5Hug8lff1CnSIryiGhgQ=
=+BUs
-----END PGP SIGNATURE-----

--S175T165iell00YN--

