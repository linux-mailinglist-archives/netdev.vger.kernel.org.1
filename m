Return-Path: <netdev+bounces-140642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 938BE9B75FA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22511C21848
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211B14A0B9;
	Thu, 31 Oct 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0I08RCd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AD148310
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361611; cv=none; b=a3022g2GPwxdQkw8xkkN0YySyP9dpm2X7Fs565XcNlIA1HryZJE/8CLiDI663HojjQeMZ3v/3Ad8uj9fX+NKi+k2Do33qbJQigAIKGgNQFfSajuPH1UMOuOklST7Zik6NiTcEGsBbXTW8ox4CP2xjw3IY+PjKLH2aL6dHhzvZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361611; c=relaxed/simple;
	bh=e3iIIsHdt0hU8MfSeZgGRpSJ44GLBXxPqNvTCuiOI5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ5YoAImDOMSRzeEWOkkZmkpbIl/A5SYBuS3rU3DMeEmr5nDX/DhjjrvZ0TFDqdljRkE2KFMzJVhZYKnKO762WqAbCTBh+siF6RknbVxJvlB+jz870Uc3OLsuI1wAJN02q89FruEzgZa0ULK3wI3u9ttA16RRUycC46j6leMuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0I08RCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6E2C4CED3;
	Thu, 31 Oct 2024 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361610;
	bh=e3iIIsHdt0hU8MfSeZgGRpSJ44GLBXxPqNvTCuiOI5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0I08RCdez8G0E5woyLMg+7nH8n1if0hCokbc43feCFXLjAP1iiginHANInomDPat
	 orlS1Kpim6rQZdnR9H7sLn3HWkXIbCvVkfOff5aOPqi3rneD/rRc3qCHl5LoEhhm5u
	 m/VYHtAXB/Pa4Mgqvcnc8lu9et9aqE+Z6DNOThN/LYPh7XVG1CLtH00r0ecvVcTtKf
	 9jG3sDwezSomJcC9zPsnk5zWX6CzXiLwiShF4HsTU1Q7zkA1J/Mi0dSNYFe46nYK8X
	 918eyfWUHHAMsnBIAZGjdl6OOyVDF3P9MWgfS8m9efdA0PpockdhNyNN4Pe6qapQBy
	 3WZkflGpFjsFw==
Date: Thu, 31 Oct 2024 09:00:08 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add TBF qdisc offload support
Message-ID: <ZyM5CPfQYHc_Eolh@lore-desk>
References: <20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org>
 <a66528bd-37cb-46b2-90e5-37b10dfa9c78@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CRyyJPZZJWWbrdrI"
Content-Disposition: inline
In-Reply-To: <a66528bd-37cb-46b2-90e5-37b10dfa9c78@arinc9.com>


--CRyyJPZZJWWbrdrI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 30/10/2024 22:29, Lorenzo Bianconi wrote:
> > Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
> > dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
> > traffic. Enable hw TBF just for EN7581 SoC for the moment.
>=20
> Is this because you didn't test it on the other models? Let me know if
> that's the case and I'll test it.

yep, exactly. I have tested it just on EN7581 since I do not have any other
boards for testing at the moment. If you confirm it works on other SoCs too,
I can remove the limitation.

Regards,
Lorenzo

>=20
> Ar=C4=B1n=C3=A7

--CRyyJPZZJWWbrdrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyM5BwAKCRA6cBh0uS2t
rJU8AP9azI73svyRHG9RCHfUeyWXViqHMnwQqtgO+m4YcEk0NQD/RabxUzVWEZIN
1FkIS7NJ9hfIsvxHuZ9X16moqYkPeQM=
=QqDa
-----END PGP SIGNATURE-----

--CRyyJPZZJWWbrdrI--

