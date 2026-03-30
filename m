Return-Path: <netdev+bounces-273263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFeRLkqlymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079735ED2B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC75302F9B8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863637757A;
	Mon, 30 Mar 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcthOs63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFA377038;
	Mon, 30 Mar 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887637; cv=none; b=fDWGgG4K0rsttvA4OuEUEYVEpvLjFDYhksxoMFrOBmIPISD+oEmWYDSKggKdgr0R6yzlS0OzFWktRzUPUXPiIZbU2PJipqXaTnSqhY0+jew1CwQ0lWKv5EZwo1mVMHctWq19D56jbObkkufO0CvyU0dGuF/Z6Y/6FdTkK3yevD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887637; c=relaxed/simple;
	bh=rvTE++tgOitsGs2Y5jYidVeu41glWxg6G+cKvLPLnGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayb8fn8EeFdNzdPsIeYeoT0OEB93eN0OTavr96CgTSAVjtemS12QHjzG1Gt6I/sxENeNOKDBDVidN8fpBKeYcVtP+SIcW2GU5sPvCu5yUwsFMqMA5+pmhci/P5/r3G3qFGGMS2gJGBLaH2gGp9dXg31sEjU6iHAgMVTfck0YZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcthOs63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E3C4CEF7;
	Mon, 30 Mar 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774887637;
	bh=rvTE++tgOitsGs2Y5jYidVeu41glWxg6G+cKvLPLnGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcthOs636sJ8lW8i4u5Tm1Cf2Jv6BhCic+msh3mNSCaVdzh/ZuI8fLi9/sMZvLfQX
	 DDSPrCAqV6jAmbAon1d+I8YVkEqbh7Tw530Lr0ti7FwccaW+fmOsDXpa2BJz9I4sPl
	 jzgTMJbIm809bTm30XHfPyeueKsFmob8RWsGVmjYERCklaM1WS6glROFr7MFg6xi6Y
	 r2fojM/A9oCsIQtxBHTrIBRfejmZAFuno2NMOYw0uxg3+Q3u9Id9VMO0c6Gh5sIksF
	 elEF5Exn5HSZhSW1dc/unEUpL6PVCg26OtTaYs8mbxGZsaK3ohGxoNXjsj4YxuJuYK
	 ivGtZyb1dkwVg==
Date: Mon, 30 Mar 2026 17:20:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
	conor.dooley@microchip.com, Valentina.FernandezAlanis@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	daire.mcnamara@microchip.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, richardcochran@gmail.com,
	samuel.holland@sifive.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dave.stevenson@raspberrypi.com, sean.anderson@linux.dev,
	vineeth.karumanchi@amd.com, abin.joseph@amd.com,
	theo.lebrun@bootlin.com, Ryan.Wanner@microchip.com,
	haokexin@gmail.com
Subject: Re: [PATCH net-next v5 00/14] macb usrio/tsu patches
Message-ID: <20260330-repair-unclip-024a203a427d@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
 <177482042554.472023.12757157452690281696.git-patchwork-notify@kernel.org>
 <06a701dcc014$86def5b0$949ce110$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcgC+RFxv1+AgoSL"
Content-Disposition: inline
In-Reply-To: <06a701dcc014$86def5b0$949ce110$@trustnetic.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,netdevbpf,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 6079735ED2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--lcgC+RFxv1+AgoSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 03:12:10PM +0800, Jiawen Wu wrote:
> > Hello:
> >=20
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >=20
> > On Wed, 25 Mar 2026 16:28:04 +0000 you wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Hey folks,
> > >
> > > At the very least, it'd be good of the soc vendor folks could check
> > > their platforms and see if their usrio stuff actually lines up with w=
hat
> > > the driver currently calls "macb_default_usrio". Ours didn't and it w=
as
> > > a nasty surprise.
> > >
> > > [...]
> >=20
> > Here is the summary with links:

> >   - [net-next,v5,02/14] net: macb: rename macb_default_usrio to at91_de=
fault_usrio as not all platforms have mii mode control in

> There are compilation errors after merging this patch set.
> I believe the error occurred where the CONFIG_OF is not set.

Thanks for the report. I have sent what's hopefully a fix..

--lcgC+RFxv1+AgoSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacqizQAKCRB4tDGHoIJi
0vdJAP4q7bBsSYMfBK0DvfsAPRaNeZNEhFURu2I2OdVoIv0TNAD/dzYFRnqFWKSZ
0+nhVpkTC1V1ckbvZ1/OPOxg5PN2mQc=
=kUgB
-----END PGP SIGNATURE-----

--lcgC+RFxv1+AgoSL--

