Return-Path: <netdev+bounces-286507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNPKMfmPAWoVeQEAu9opvQ
	(envelope-from <netdev+bounces-286507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:14:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849C509EDA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08072300909C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4043BAD91;
	Mon, 11 May 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF/hmwi3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C3B52E3;
	Mon, 11 May 2026 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487213; cv=none; b=I/+CnAef+PzUH7IMY6lDc83C7sfKZWWGiTVaka4uERagMJUhaptL0T0XUyT6zo/d1Qsaf0C//W7BU2YWN3d266eUrA6QEj5ISOMG8yBJDzvvTy9ij2atnsWktfaZy2yKcy/GFBnno18lP9ew6qn7nIglLixbI/CGFVOfqKO11F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487213; c=relaxed/simple;
	bh=2dphLYFLCvVUOzZNHaPCmUqQfVBRlR+I9k+BZWO5l2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfcF7SGUeeVOdO13A8QQIRmHkX7fOh57ZoMt/9VnRID80Sa4oT1r1EBc7tBkvM9E38b8H9QPx1lHxKrJuTzeR8X+IeqGG9UK9nG+bumghd2bReRvan62y4wX2zZXymTUp5Nt6XmuPDZoA+agkHSInL76/RMWXMPyIsCxYz25vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF/hmwi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857A8C2BCB0;
	Mon, 11 May 2026 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778487211;
	bh=2dphLYFLCvVUOzZNHaPCmUqQfVBRlR+I9k+BZWO5l2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tF/hmwi3wxtVVGYtNUIUCxMAsZ8/d7Xk6yHYI/AISGSFV/PSFAL4P4ot3P0h18wxp
	 jjGBz8s7T01LkT31rxLXgnEb8OszYNFb/dqj4RGT1DeS8B7rKK2oo96fKH289G3ixg
	 Q7u+mCE4BrmrqPP7vWMu1CuHkDzZK2cedB+BHJrbLw+TGoif7QrJFERLb7fQgseAT/
	 y7vkpy/nAoiq3Wbd+D5xB+TX/SUplURmO648NwZRWhqJHea6kQhkx8zriP4uaUnqmL
	 RawiNji04HT9Jr37LdYRzguSUFXNi+aof7TAIM4k4qvSgUAoFa5P0xETeAQLR0cAKi
	 ZJKg4389Oy2DQ==
Date: Mon, 11 May 2026 10:13:29 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: airoha: Reserve RX headroom to
 avoid skb reallocation
Message-ID: <agGPqVvwyCbVbROt@lore-desk>
References: <20260509-airoha-eth-multi-serdes-v5-2-805e38edc2aa@kernel.org>
 <20260510140502.B244EC4AF0B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qZEFo0epdC7n3CCp"
Content-Disposition: inline
In-Reply-To: <20260510140502.B244EC4AF0B@smtp.kernel.org>
X-Rspamd-Queue-Id: 7849C509EDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--qZEFo0epdC7n3CCp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Missing bounds check adjustment for RX packet length allows buff=
er overflows
> --
>=20
> commit f34e8812cb62dd63f96801a39b0d65ee905cd258
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Reserve RX headroom to avoid skb reallocation
>=20
> This commit reserves NET_SKB_PAD + NET_IP_ALIGN bytes of headroom for
> received packets to avoid skb head reallocation when pushing protocol
> headers into the skb.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> [ ... ]
> > @@ -627,10 +629,12 @@ static int airoha_qdma_rx_process(struct airoha_q=
ueue *q, int budget)
> > =20
> >  		port =3D eth->ports[p];
> >  		if (!q->skb) { /* first buffer */
> > -			q->skb =3D napi_build_skb(e->buf, q->buf_size);
> > +			q->skb =3D napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
> > +						q->buf_size);
> >  			if (!q->skb)
> >  				goto free_frag;
> > =20
> > +			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
> >  			__skb_put(q->skb, len);
>=20
> Does this code overlook adjusting the bounds check for the RX packet
> length?
>=20
> Earlier in airoha_qdma_rx_process(), the software validation check
> uses the unadjusted lengths:
>=20
>         data_len =3D q->skb ? q->buf_size
>                           : SKB_WITH_OVERHEAD(q->buf_size);
>         if (!len || data_len < len)
>                 goto free_frag;
>=20
> If the hardware descriptor returns a len that is larger than the newly
> adjusted dma_len but smaller than or equal to the old data_len, the
> check will pass.
>=20
> Since skb_reserve() shifts the skb->tail forward by AIROHA_RX_HEADROOM,
> will calling __skb_put(q->skb, len) with this unvalidated oversized len
> push skb->tail past skb->end and overflow the skb_shared_info structure?
>=20
> Similarly for scattered fragments, could an oversized len passed to
> skb_add_rx_frag() cause out-of-bounds memory accesses beyond the allocated
> page fragment?

ack, I will fix it in v6.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260509-airoha-eth-=
multi-serdes-v5-0-805e38edc2aa@kernel.org?part=3D2

--qZEFo0epdC7n3CCp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagGPqQAKCRA6cBh0uS2t
rO72AQDvA7/niPO4yeyKs0rtSPk8+ow7Dxz9QLxaPhPQyzVw5QD/eRwgM68iCKuS
xVwvKSRijfyXRKGUmKBzERC8c8PwHwg=
=DNP2
-----END PGP SIGNATURE-----

--qZEFo0epdC7n3CCp--

