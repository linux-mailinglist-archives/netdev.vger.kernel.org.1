Return-Path: <netdev+bounces-270210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COpLEkKZvmlPUAMAu9opvQ
	(envelope-from <netdev+bounces-270210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:12:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4392E56F9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E372E300615C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC272DC357;
	Sat, 21 Mar 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK1XDnNX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B220E702
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098577; cv=none; b=lw+xXW6eBAe/YoNba03PrqTHTwGThdnafTJDk7Jzl4sAVI6XuwHtvU7KoyvGkth35f6dUw9/uOaG5jSyjuGHzyYbegS+4uNJCV9jV694t4ZM/UJUNkFJCfzbBpehgCWvosbLUCXGLAYZvT65KWobXvlT1qW6TbN9Hdm7ltfEmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098577; c=relaxed/simple;
	bh=dTmt0CpKQWFrPI2bQR7wWvu2/uBaYz30e6vvB7xr+D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d72GfC+FxFu1sMc8QdNEvwr37cdIL1oU59yP5DmQEqDYBg+JsOLpdTrGXTObaOeu9NO64WXehVgQJftDw1DTLYuv+YtFcnVSYRjonKIeW78/0lcAcnNhe54vsGHK6YbJekYBHcXi5yzKyF57bHTpyfmQpR95UG0Sgwe1M9P/D/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK1XDnNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F69C19421;
	Sat, 21 Mar 2026 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098576;
	bh=dTmt0CpKQWFrPI2bQR7wWvu2/uBaYz30e6vvB7xr+D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NK1XDnNX7jKHvW9R9uT9CawmULfhovJZTIsIzwrqu89k7RbHmtbLxRgVlsnfjBbLm
	 5sbcnMcJ6Ju6k2OgkqJ5TW6KaxRp3IbBgbIKDdod92fGhFfDJX3z9SDKwKgsHWbA8T
	 ty5z2wQy6LzmhDipnAo9DkNwFzsZwXFNsvLoV2XpZZtFybY3ZwbsEINecHQ5pB2qju
	 2FjoZ6TVBuRsdOYXGn4hpU3jfdlC410nH9+P5o9/Q4Eh3aXM7OGI33RNEZ6HEfGsGl
	 FJVrEwj2lrrgh7FWe7QrqkefL2+xyZQc32SQw3Ad1OSX1DxItD7KC63/gVFq8aBDmN
	 y/T1WPiT2KgZw==
Date: Sat, 21 Mar 2026 14:09:34 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Rework the code flow in
 airoha_remove() and in airoha_probe() error path
Message-ID: <ab6YjhbSbUNt_KR4@lore-desk>
References: <20260320-airoha-remove-rework-v1-1-adeef7e3c01f@kernel.org>
 <20260321094429.GW74886@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EZz7n3wwzIYEdEN2"
Content-Disposition: inline
In-Reply-To: <20260321094429.GW74886@horms.kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D4392E56F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--EZz7n3wwzIYEdEN2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 21, Simon Horman wrote:
> On Fri, Mar 20, 2026 at 09:42:28AM +0100, Lorenzo Bianconi wrote:
> > As suggested by Simon in [0], rework the code flow in airoha_remove()
> > and in the airoha_probe() error path in order to rely on a more common
> > approach un-registering configured net-devices first and destroying the
> > hw resources at the end of the code.
> > Introduce airoha_qdma_cleanup routine to release QDMA resources.
> >=20
> > [0] https://lore.kernel.org/netdev/20251214-airoha-fix-dev-registration=
-v1-1-860e027ad4c6@kernel.org/
> >=20
> > Suggested-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 82 ++++++++++++++++++------=
--------
> >  1 file changed, 47 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
>=20
> ...
>=20
> > @@ -3028,7 +3044,7 @@ static int airoha_probe(struct platform_device *p=
dev)
> > =20
> >  	err =3D airoha_hw_init(pdev, eth);
> >  	if (err)
> > -		goto error_hw_cleanup;
> > +		return err;
>=20
> Hi Lorenzo,
>=20
> AI generated review warns that eth->napi_dev is leaked here.
> And that does seem to be the case.

Hi Simon,

right. I will fix it in v2.

Regards,
Lorenzo

>=20
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
> >  		airoha_qdma_start_napi(&eth->qdma[i]);
>=20
> ...

--EZz7n3wwzIYEdEN2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCab6YjgAKCRA6cBh0uS2t
rNf6AP9KP6eC4+MHzMb7WFbxq92nj5wfHEpgj5oEBa1ehx8vawEAiqgEov1K4lLS
0i3wDxbABgh92m891ZGxsVx+2UzXcgU=
=SzaX
-----END PGP SIGNATURE-----

--EZz7n3wwzIYEdEN2--

