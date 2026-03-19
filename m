Return-Path: <netdev+bounces-269368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOj2CNK8u2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:07:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BD2C85B7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC3531D9482
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AD3A5448;
	Thu, 19 Mar 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3/vYhrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCD3A5438;
	Thu, 19 Mar 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910950; cv=none; b=QCCf0pEwF73Dhg6/tjvsB4yCyiqrNGEZjzFUlDIxf5E50KKPQMltzBvPjUkx1Kq4oDimVxmt3DHzuLW+PQc7DAsQS2VpOmoMyvuZivAAuUyusOLR/rOnyG1M+lShHvs2Jxz00TCnydIzH7Su6Fh5FmYwye72z9gclNf4lpGjRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910950; c=relaxed/simple;
	bh=7VaarauVAUlZAF8hWS497Tc062mkllGjXCpmZsHJ+uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYGZXf0MKjXOOv4+CVRnCeZK4efmUHcJiMkbmM9bNZlxfdxt/NaiHTzlbXhBDiejYNMjrsFgJP8nYK0IIa/52OE10R1e+cwtM/f2FommG7btdpNCXjIwk+Xdof+Peh5Pap3ssTnFyz2YwFOVMCldtNWDFEPURpOqQSUjzCLQQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3/vYhrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7871C2BCC6;
	Thu, 19 Mar 2026 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773910949;
	bh=7VaarauVAUlZAF8hWS497Tc062mkllGjXCpmZsHJ+uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3/vYhrzVWItNRYWpKWFWCn0Af38vhj2aOuqCs+BVorOCkalSLc4Dzt2HMw0/6ScR
	 dnrUOC1EgUWUACklVH5wSLc/b3i5xMVLRVFsjzbSjdV8cOeefx5186q8L5Dc62QvkI
	 ZqABWhHLSoVBmS7fTHlFY642WO2lvJlxpaopF2KDZNyNjhKPGrLvowUECAfmejEVJV
	 SzfXoRjy/DaCPb2VoaqHlEWPEBIaEYZ16prqPPcLqEuBcKyq1KqZ5xHWsqzzPvALa3
	 GEV8VZdxD7bx1KdkAY4qyBXXQBp2KlcaHfsP6to+ThHIJU6OYJjqqhIUzTMhBYFvut
	 OKVOWnx2JxMfg==
Date: Thu, 19 Mar 2026 10:02:26 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net] net: airoha: add RCU lock around
 dev_fill_forward_path
Message-ID: <abu7oifGm-OW74e9@lore-desk>
References: <20260319032649.337812-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hVix+0JsXNG2f6eM"
Content-Disposition: inline
In-Reply-To: <20260319032649.337812-1-dqfext@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269368-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B24BD2C85B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hVix+0JsXNG2f6eM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
> dev_fill_forward_path() should be called with RCU read lock held. This
> fix was applied to net, while the Airoha flowtable commit was applied to
> net-next, so it hadn't been an issue until net was merged into net-next.
>=20
> Fixes: a9af709fda7e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git=
/netdev/net")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index ec5ce41dad80..02deb739a1c7 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -227,7 +227,9 @@ static int airoha_ppe_get_wdma_info(struct net_device=
 *dev, const u8 *addr,
>  	if (!dev)
>  		return -ENODEV;
> =20
> +	rcu_read_lock();
>  	err =3D dev_fill_forward_path(dev, addr, &stack);
> +	rcu_read_unlock();
>  	if (err)
>  		return err;
> =20
> --=20
> 2.43.0
>=20

--hVix+0JsXNG2f6eM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabu7ogAKCRA6cBh0uS2t
rOgBAQCIxff9R0PFxxGK2Xf7PNsoJs3MKg/JgyhCTFimM4plUwEA3uRTHFbu2J0/
0/u8vg4OXU00HB05uIfaAiQ0jcdCAAU=
=fFpm
-----END PGP SIGNATURE-----

--hVix+0JsXNG2f6eM--

