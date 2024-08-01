Return-Path: <netdev+bounces-114860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCFA9446BC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A81C23C38
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934616EB7A;
	Thu,  1 Aug 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/zuNdKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544F16EB71
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501399; cv=none; b=YAYncv0lI/UP1Rq8675FSa7KWbtHjT2SrYOdSAqQCug5LeGJ81R9bN3ZFBzKosDkjPcwErhSYr1xB6UhOKOIwUh/GzYK+TViqEa/21k0wOH1LJnS2lxLosLZ12c+m7AFzLlzVJWkIdaP6YtY8Tz+7Ju+2IcRP87xxzmoJv5yt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501399; c=relaxed/simple;
	bh=QRlGKUMmVmt518WV0uTgI9pFbibaT70gkSz+hb3qILU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRs+GV4hGcIgsNuxIbBj5g3UAkG+NVysyiq2CKvFwdeFHZuL5Szegsm94V86P0PHoFZustwwQe2AXlQvYeiTENUOyIEBku5bdpI0+Rjpe52lAnGi1j6E9i+EMfi9alzPwVL3gSHIYljYuPJUt/dFcgGGIyeq7gAv1C7LKClK57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/zuNdKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E9C4AF09;
	Thu,  1 Aug 2024 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722501398;
	bh=QRlGKUMmVmt518WV0uTgI9pFbibaT70gkSz+hb3qILU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/zuNdKBwbPojssRnDjn+rldf15HLJUKcR7nYuy1EunfZPAbMAnnS9t7j8KMqrMMV
	 LjnmmEVeXkd0g4+GWoGT26NtpRghg4KMjLGDnRWoROpG0FZJZIMlMuRMmbmcQFXzhg
	 dvqxR0XU0Ac2jQ7LsEjzK0RjjNOpu7Sc6TbrSsTYHMLhEHIIrdpPBX6xnmcrCgUgO6
	 /56WidhyM0EkP+vLmEPRKD7MuW5I4o4FuoGsejTeVPhm2sh5xc4IdPeUuvLKQbFRFD
	 ohBt7g/jUKqkzCzkSuiR1LeYJkKXYOF9CGJ328ywiXz8eYH9oXxAO0kp2rFUipqc+a
	 LsBc9vyIL8sFA==
Date: Thu, 1 Aug 2024 10:36:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH net-next 6/9] net: airoha: Allow mapping IO region for
 multiple qdma controllers
Message-ID: <ZqtJE6VJfENJ5YSU@lore-desk>
References: <cover.1722356015.git.lorenzo@kernel.org>
 <6a56e76fa49b85b633cdb104e42ccf3bd6e7e3f8.1722356015.git.lorenzo@kernel.org>
 <20240731191424.5f255515@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CtHwh6hvxVAAn51E"
Content-Disposition: inline
In-Reply-To: <20240731191424.5f255515@kernel.org>


--CtHwh6hvxVAAn51E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 31, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 18:22:45 +0200 Lorenzo Bianconi wrote:
> > +	qdma->regs =3D devm_platform_ioremap_resource_byname(pdev, res);
> > +	if (IS_ERR(eth->qdma[id].regs))
>=20
> qdma->regs vs eth->qdma[id].regs

ack, I will fix it in v2.

Regards,
Lorenzo

--CtHwh6hvxVAAn51E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqtJEwAKCRA6cBh0uS2t
rP0pAP93grFxu5yiTp9jdlpTIIOftpHDh0ETcQFS2XeSh94UKgD+KRVLK6uY3hcP
CuOMFFu5/MnccPmDcO8xXTXJUilMywk=
=VDsS
-----END PGP SIGNATURE-----

--CtHwh6hvxVAAn51E--

