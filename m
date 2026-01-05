Return-Path: <netdev+bounces-246937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368FCF27A5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E01030AAD18
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74034310644;
	Mon,  5 Jan 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK3Dce6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F262288C26
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601988; cv=none; b=r4+G/a37G13TPcudqR+SdsS4zk3YaM40ZBPdd327YkWPanfgefNUayrCePeDJ/7n3fkVj5BYfzwNsog95ln9d2Blw0nl/AznxHjR09WSDddA8v262IxqhU4xpjU6Ruhq2blJXKd1DV3aXc7AubUditvfUD8ykQu3Y88MyhofeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601988; c=relaxed/simple;
	bh=jR4fFLVRiuegFqSf3wGQVE9BvrmQiyfEnJAXr4ps4Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQmWAFGr1LlCDKmy7cidW/1RqNEJrVVoFP0a6WEAsPmRdOR3YGXY3HosgArjYqaEEulWnDRrmaAkNAoH8+JJtwF7M0Vb+CdPsrAQXnz0n01A1/sX2xUTUrScplMmkt/uzTj1ncVEyGZ9ZIQpS9neIJ+dCUS/LqYoj7mZc/TT2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK3Dce6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57010C116D0;
	Mon,  5 Jan 2026 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767601987;
	bh=jR4fFLVRiuegFqSf3wGQVE9BvrmQiyfEnJAXr4ps4Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK3Dce6S+YtTWs/Rlbr7cbBA/AcEhlPFHOM5rRNu8ft8yJYAhfFxN6T2gRTuH2MKD
	 UOCv2DQ4WnUZl4pDsT71NtcqecqnM2MHGl6rP3eFd+So5+9LCDLR5+GQeY4j3HeCfl
	 fUOflI3v1aq8o36rS1l0/L8450oJ2uljS5RGcuLeO6OYQx79kcItfxiGdeWwWOI7OQ
	 CovGMLXQ6XN0PsMB36cNcm1VU24lOezbyiGEBiaYhttKnIe45zE51nFRfQQZKlLz53
	 tPhLPapYsbcS0HvZeaom+07J5yc5y0CEuZRNF2GLKad6GTN3tuyJBqhupNp0KRcBHU
	 fcgZEmmMEy7uQ==
Date: Mon, 5 Jan 2026 09:33:03 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Message-ID: <aVt3P_sAeb0UtshZ@lore-rh-laptop>
References: <20251223-airoha-fw-ethtool-v1-1-1dbd1568c585@kernel.org>
 <20260104095748.70107b9b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJ2NtbytHDl8SsTF"
Content-Disposition: inline
In-Reply-To: <20260104095748.70107b9b@kernel.org>


--fJ2NtbytHDl8SsTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 23 Dec 2025 22:56:44 +0100 Lorenzo Bianconi wrote:
> > Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order to fix
> > schedule while atomic issue.
>=20
> The information in the commit message is not sufficient.
> What "schedule while atomic issue"?

The issue is we run kzalloc() with GFP_KERNEL in airoha_npu_ppe_deinit()
in atomic context but we do not really need atomic context there.
I will fix the commit log in v2.

Regards,
Lorenzo

>=20
> > -	npu =3D rcu_dereference(eth->npu);
> > +	mutex_lock(&flow_offload_mutex);
> > +
> > +	npu =3D rcu_replace_pointer(eth->npu, NULL,
> > +				  lockdep_is_held(&flow_offload_mutex));
> >  	if (npu) {
> >  		npu->ops.ppe_deinit(npu);
> >  		airoha_npu_put(npu);
> --=20
> pw-bot: cr

--fJ2NtbytHDl8SsTF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaVt3OwAKCRA6cBh0uS2t
rOkJAP4jrr9vVu+SoLlKEvC8/13XPzrDIHx03ib3U4KbcNisjQD/WfD6TFYOSFEG
UOd9aqYCXOtyhpoyTsUnD/vsLMRmlgE=
=vvTn
-----END PGP SIGNATURE-----

--fJ2NtbytHDl8SsTF--

