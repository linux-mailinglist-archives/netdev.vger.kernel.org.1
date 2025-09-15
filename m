Return-Path: <netdev+bounces-223198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A633EB58423
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2195B17CB49
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0592DAFB7;
	Mon, 15 Sep 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXZwy6kz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043972D662F;
	Mon, 15 Sep 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958984; cv=none; b=skKIM1XhW+p2cRjCQ6g5aI6mid8mpIJNHJq9MRLCtwc/vnfeVq5wR1zRbkYN/weQ0/GwUIDnl9vLVQt/IIb6FzIEhfymVzyuag/LcP0x6T4Tgn03uHgxVniq1yRyoP5YslrU6fnWKsbsaxBdyRWluZd0XQGomgW9tKLNwocd+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958984; c=relaxed/simple;
	bh=UhtlqOXDupzkzc3nSNJvUxuVlPWJGH7dBhTIBsrkvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu/8RVJHwVlBeDW4R7LyuBM+oJyUlMYzxqDdecWbS09LcrEp8N716svh7BmyynjxG6oYGMgRLS0wqaFVxQp2RkFfF7LyEEHCtNmfPmsnmNj1d/CP2YVj5pdEUONpQm8/BLAYPc2Wz6TC16rrjLOy+3+j1wZslSsI8lQaRISxU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXZwy6kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41507C4CEF1;
	Mon, 15 Sep 2025 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958982;
	bh=UhtlqOXDupzkzc3nSNJvUxuVlPWJGH7dBhTIBsrkvzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXZwy6kz1KMTOyFhhyW7IqtB4tCr5+pVG7dXmvQi93dWtvlJbpq3cdaE4FbQUqy1f
	 ej4cPuGHYksVOmiPIVi1r67OsVLXYCgvH8HDwFT21fe9YaNLd9T25nnmjFdeHBVnuL
	 pwz1ZLeC6SgWAmiWyOxUXNSSLEUOEi5v6T90J8nxiNk/27Hl/uA91diEZobWhu3YtJ
	 nTjD1NtjWFr5WLN9ZISaS8v4BmOn9PDgF0BmQVHe8uhRrGuipLDWFib1wYIbar1Ehm
	 F4Bi6WC4EVCyv/H8/tdZ8Dp1jiupnLJCu1+aEUz/JfIrzOE91LwqLaAazeewz47bvP
	 rPsLWYQUpT2Mg==
Date: Mon, 15 Sep 2025 18:56:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v6 1/6] dt-bindings: net: sun8i-emac: Add A523
 GMAC200 compatible
Message-ID: <20250915-golf-antsy-9e71d5398324@spud>
References: <20250913101349.3932677-1-wens@kernel.org>
 <20250913101349.3932677-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PtuhxQmA1Ve8bM5+"
Content-Disposition: inline
In-Reply-To: <20250913101349.3932677-2-wens@kernel.org>


--PtuhxQmA1Ve8bM5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--PtuhxQmA1Ve8bM5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhTQQAKCRB4tDGHoIJi
0ua/AQDDYt/Sy0eQGk4ojQ0b/BXXDaihykUMqx+YkoTxwrYBSQD9Hk7iZgJFQbQi
/RNfwxM6H3OrFi9YeWXkX4kS9q4zCQ8=
=C54e
-----END PGP SIGNATURE-----

--PtuhxQmA1Ve8bM5+--

