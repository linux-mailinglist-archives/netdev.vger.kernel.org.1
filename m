Return-Path: <netdev+bounces-244770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB8CBE4E4
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F2DD302122B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60434DCCF;
	Mon, 15 Dec 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD5W8jQA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC934DCC4
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809184; cv=none; b=FdthGWTFNFYH/EL8vWJikEW6zBQmSLtS0aTYPC0kofd1nKogdOZEKPuQLDJzgvDClDtVGPduhzYHDzjyRZXJfrdhu6aPwcMkXoMepX732UVSo3VRPwl0T2njArj5epoAt0OD8lmbtHEGsEVovx+nZSQSO1vgO9RaF/1r/29vgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809184; c=relaxed/simple;
	bh=qxGuhzzENL2/jmnIvpsLOTktbSkGH0gOmyfnscBlOiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uersYq/GmBqrwCJwwGDJjk9uOEcvUc8gjyGOxTHER6AXDlDcYg9AqitNfLFYTtAheBg0hEDyK678fPf6f1TBnTshxeTxcWMuP2jumH3uX78Fdbh3MuuftD2ryKVU70jRdyWcltyMIpiNHaJj5M04meTKi+1yDFiRuJWoEG9KBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD5W8jQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FE9C4CEF5;
	Mon, 15 Dec 2025 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765809184;
	bh=qxGuhzzENL2/jmnIvpsLOTktbSkGH0gOmyfnscBlOiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD5W8jQAT+LDPgg/i+ZV8y76tvhMEQ6M1uaQhpUyQ14LMpTBNdIhPBEjqERelpRGy
	 MAFo0OjI5gNVvPMGbqpLQLQ4ECC2wkjUaVYnk5o8y6yWpU5u/skGb+Es2ZCJAPymib
	 77uFHAhM20uFVDufTQusThSYmCYfcAD69tx6mBsWgJIpMVvHL2bWHZ+2xbxktlKA/r
	 u5ropR40zYCtvs1QWoT5txpFXHtPT2+VNLY/bdGKxMXY3E8nrAyJkwdbuDJ2QPX4Bd
	 2EDqkkvWDcFC2nCxH1F59pKSRe2QUK9nFEgc4xvuiwUJUCXfVhWpPA9+Ra8EN7LvP/
	 CEcU6p6dyNdSA==
Date: Mon, 15 Dec 2025 15:33:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Move net_devs registration in a
 dedicated routine
Message-ID: <aUAcHVULgJTpdGzT@lore-desk>
References: <20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org>
 <aUAXJ01iHnSJtItt@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CpRBRRZdAIdkXjna"
Content-Disposition: inline
In-Reply-To: <aUAXJ01iHnSJtItt@horms.kernel.org>


--CpRBRRZdAIdkXjna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Dec 14, 2025 at 10:30:07AM +0100, Lorenzo Bianconi wrote:
> > Since airoha_probe() is not executed under rtnl lock, there is small ra=
ce
> > where a given device is configured by user-space while the remaining on=
es
> > are not completely loaded from the dts yet. This condition will allow a
> > hw device misconfiguration since there are some conditions (e.g. GDM2 c=
heck
> > in airoha_dev_init()) that require all device are properly loaded from =
the
> > device tree. Fix the issue moving net_devices registration at the end of
> > the airoha_probe routine.
> >=20
> > Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> As a fix this patch looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

thx for the review.

>=20
> But I am somewhat surprised that the netdev isn't unregistered earlier
> both in airoha_remove() and the unwind ladder of airoha_probe().

do you mean moving unregister_netdev() before
airoha_qdma_stop_napi()/airoha_hw_cleanup()? I was thinking about it to be
honest :)
Since it is not related to this fix, I will post a patch as soon as net-nex=
t is
open again.

Regards,
Lorenzo


--CpRBRRZdAIdkXjna
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaUAcHQAKCRA6cBh0uS2t
rJ+zAP9fyAYNDREzULQu+K9SkC9WRtWhAAKAzSC+7XDJzug54AEAvJJE68/amNbP
+lE2gjA+wHza9p6bnH+vAdDIyHgo0Qw=
=1TE+
-----END PGP SIGNATURE-----

--CpRBRRZdAIdkXjna--

