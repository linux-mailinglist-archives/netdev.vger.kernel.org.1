Return-Path: <netdev+bounces-135773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8F99F2CC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84C9280DA3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EE1F6668;
	Tue, 15 Oct 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYSpCLiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D81B3931
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010125; cv=none; b=Fa+P0hnXsV5fE1+zKUPR/pRGC0F4PKWmeJFlUF4nNU2keqP5eNGQCJUjX9uoliXyS9aRaf+U0SOW4vl9AaKP+Pbd+KoFyo6vFw0sA3AQM6xwU9PnixB2amTF+SAZT4SCid03ct+RgWhNHRXrZnl20uDhKaauoA1AtdmD3TmdlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010125; c=relaxed/simple;
	bh=GWm1yxIpKQtW+rkoY8dCflI9QtjF5H4i5xBVGoXK7yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HttJ7J1RmK6MMGGC1ixkCrAiNyEbLI14lpgCJmD4eHkpxjI9dF5Rjuf8ELNRMotXqXlQ3obu9hP+zQQiadjUdZGgwWbGBXe5WtWt6qh8U4Ky3brU70y3EoyrYdt1wTsMUdwJqxW2/Ae2r1qH28APcqW9Wxu8eSFaH1Fu0w2Zu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYSpCLiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8DC4CEC6;
	Tue, 15 Oct 2024 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729010125;
	bh=GWm1yxIpKQtW+rkoY8dCflI9QtjF5H4i5xBVGoXK7yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYSpCLiFFbk99MbwJWuhV/BdLYniMHM6dvnlGCbmKeibF20YGJqJM5wiMkDE8v4xM
	 S6iSfeXv6ljhCX5oQnxxsD4Qz2zpr1f+l0KbXLjVyscMFvMOGqzmYiz2WlxissMvUc
	 ePRVCcwx2788Wdrji3hGK414s7W/ZsYRaTr7dsvezLvU8wbLh+C5rMLzqeUuriBxwl
	 Xqhrnl8GwrhtC/t5T439GRRAsEhzXM/572SJPbIYxhyBCdi484JctA92DhyqCNmFv3
	 lM0MZ2FsAVNJRmWZU1qMBTWUZVD8H05snujJ/vh97mCfIGoJCL+hrUpgt9pFgxVrEe
	 rj2Hhqp2ZoN3Q==
Date: Tue, 15 Oct 2024 18:35:22 +0200
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
Message-ID: <Zw6ZyoJCv0_EOnpf@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
 <20241015073255.74070172@kernel.org>
 <Zw5-jJUIWhG6-Ja4@lore-desk>
 <20241015075255.7a50074f@kernel.org>
 <Zw6QUxpdnJtorc_e@lore-desk>
 <20241015090952.6bcb5856@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CVu69demth5zU5/X"
Content-Disposition: inline
In-Reply-To: <20241015090952.6bcb5856@kernel.org>


--CVu69demth5zU5/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 15 Oct 2024 17:54:59 +0200 Lorenzo Bianconi wrote:
> > > Oh, thought its called on stop. In that case we're probably good
> > > from BQL perspective.
> > >=20
> > > But does it mean potentially very stale packets can sit on the Tx
> > > ring when the device is stopped, until it's started again? =20
> >=20
> > Do you mean the packets that the stack is transmitting when the .ndo_st=
op()
> > is run?
>=20
> Whatever is in the queue at the time ndo_stop() gets called.
> Could be the full descriptor ring I presume?
>=20
> > In airoha_dev_stop() we call netif_tx_disable() to disable the transmis=
sion
> > on new packets and inflight packets will be consumed by the completion =
napi,
> > is it not enough?
>=20
> They will only get consumed if the DMA gets to them right?
> Stop seems to stop the DMA.
>=20
> > I guess we can even add netdev_tx_reset_subqueue() for all netdev
> > queues in airoha_dev_stop(), I do not have a strong opinion about it. W=
hat
> > do you prefer?
>=20
> So to be clear I think this patch is correct as of the current driver
> code. I'm just wondering if we should call airoha_qdma_cleanup_tx_queue()
> on stop as well, and then that should come with the reset.
> I think having a packet stuck in a queue may lead to all sort of oddness
> so my recommendation would be to flush the queues.

ack, I will post a fix for this. Do you prefer to resend even this patch? U=
p to you.

Regards,
Lorenzo

--CVu69demth5zU5/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZw6ZygAKCRA6cBh0uS2t
rECMAQCP8qliDLSMBcAHmqy1hBZkYFYitylH9KF7F5cQFr8FTQEA7c//B45U79ZJ
Fh8jI1y16EPnfJQU1jWQym8vc8S7SQ0=
=KonI
-----END PGP SIGNATURE-----

--CVu69demth5zU5/X--

