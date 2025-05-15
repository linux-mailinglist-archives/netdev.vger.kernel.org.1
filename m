Return-Path: <netdev+bounces-190626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE4AB7E0B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E915F3A88FE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6292628D;
	Thu, 15 May 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcU7ucYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACC8F6B
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290784; cv=none; b=NPeOb4Gw8/mLr6bhxK3OXAlqiklQ3rmMYnfrNGjuZ6029xV6rYEK6ewKM7f7lgHnHkE1JVObg6rGpH4r2n0lu8YlQZsdPX38RUebFS6Du2ZoZACaeEdxFzqgUADZAOWKHhEjgpeb9iXViJbSUyXNoyMKjKOIqAqVbOkTwFTFOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290784; c=relaxed/simple;
	bh=dTu7FCPLVb1Lmds6U8zszxWLIezt2U7rDOMAZnWiCZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZxlVLPaq6lJ0bk0YRxmLRQq9/rFCgtlaXJTKNexil4XeMxSnpDo3aSDSi85aaoaegqoPvK9CR5q7T8eVu4047rgLieMSO7ybfx+9LhcXwuQFvApGbUY3+56HzjzvrWpwbS6G7bhpKi92s38/rBVnTui6M+VRx62H5yMCf8a5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcU7ucYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07020C4CEE7;
	Thu, 15 May 2025 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290783;
	bh=dTu7FCPLVb1Lmds6U8zszxWLIezt2U7rDOMAZnWiCZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcU7ucYnFEIkGfgSkwONAAOY9aBvKHrsovgOpGWO2SWxch5ZCzm3Bn4Q0KAUhfjNL
	 WvWGGYeZ7MzUhx8HJmQTnNQj8+Qum7RPuHHLqeBSGtigNROXZfpht12cboWZDRIiu6
	 JBZpAh0DObCz5in/GQIbRK4nkBknkNaabB+JVjVFqxcpWJ+JNTpQ0Mf+TZ4myXIYVW
	 tPFo8CQk5TspWIeNiTJWFLImEt0MEVXXsXyayubDASSsfNM/EcjqOVC18tEzEct3eV
	 1WIkEZBssQjtRWPCCiE16qV1mbfLIuM2MPetFkP9exzPQcB6nGl2veJTT2pnm2pXOf
	 aO7c5Bn0F9WTA==
Date: Thu, 15 May 2025 08:33:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix page recycling in
 airoha_qdma_rx_process()
Message-ID: <aCWKnGVkjlS_d1I2@lore-desk>
References: <20250513-airoha-fix-rx-process-error-condition-v1-1-e5d70cd7c066@kernel.org>
 <20250514190917.4b0ff404@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9w4VoQ4TwqdOLLxN"
Content-Disposition: inline
In-Reply-To: <20250514190917.4b0ff404@kernel.org>


--9w4VoQ4TwqdOLLxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 13 May 2025 18:34:44 +0200 Lorenzo Bianconi wrote:
> > Do not recycle the page twice in airoha_qdma_rx_process routine in case
> > of error. Just run dev_kfree_skb() if the skb has been allocated and ma=
rked
> > for recycling. Run page_pool_put_full_page() directly if the skb has not
> > been allocated yet.
> > Moreover, rely on DMA address from queue entry element instead of readi=
ng
> > it from the DMA descriptor for DMA syncing in airoha_qdma_rx_process().
> >=20
> > Fixes: e12182ddb6e71 ("net: airoha: Enable Rx Scatter-Gather")
>=20
> Missed your sign-off.

ops, let me fix it in v2.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--9w4VoQ4TwqdOLLxN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCWKnAAKCRA6cBh0uS2t
rN7HAQDQFLb17eTABm57pebhvFKxz2kZe7oY+Vv5UTosiivHLAEAkRGdFjZE+cCN
R+BHEX1w4Vw3LFDvYR0H+gPQMhIyuQM=
=bbGj
-----END PGP SIGNATURE-----

--9w4VoQ4TwqdOLLxN--

