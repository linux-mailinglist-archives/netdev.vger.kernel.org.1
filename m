Return-Path: <netdev+bounces-253589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9+L+3Hd2lOkwEAu9opvQ
	(envelope-from <netdev+bounces-253589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E98CD85
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE3773013D7D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEB2989A2;
	Mon, 26 Jan 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQpeICey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AD13957E;
	Mon, 26 Jan 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457641; cv=none; b=Ug3NZPxb3YsrIrRAhg4CiHfI/faKYOjs+2D2D6P/bQrIxyNueY+XKh1AjjvZ4UEMwsZGDh2WJpekotngm2lGxt7uFBwESWyNM9mtQ4mshYbCAh59ASO7B79YW1gCF6/S6iozW8vBb6W7+gx9AK7E3Hqaozu2zojt1/YIl1yQjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457641; c=relaxed/simple;
	bh=W/s9B8G5AAVa1Ka8hwUbZ0G6I72DbzHIqE5HpGQCPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj2t5pGCEMF7AXzx/CpG7ZORiLENbS0GY7gupcYXafUNkZibqq9WCVA9dLL4S+XGeAIItUaxzo+sr/1g5RulNLw/643OeIBO8mJGYr0DSI/we+u47AK72NkLIawKDoNZB5tXy6IJy2kQUX8cO3E9lHx3OnM+9vXSj8/OTlYqtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQpeICey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E6C116C6;
	Mon, 26 Jan 2026 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457640;
	bh=W/s9B8G5AAVa1Ka8hwUbZ0G6I72DbzHIqE5HpGQCPNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQpeICeyJSjkOhlUCdhsHfBjOVMQbxJZt5iv694GjcLRSgCdNa70WSlPLusbcNSIG
	 cf7KBZEUGxL7QkUkQmqPRUFfGjPUxIu2D2ugRxPTcbsnbB9AN3a7LhW/vJL0M0n2Ki
	 L5w0znY9rQ5iBzW9JnwxwmEynbt7Hl8LnZ2YNbpywE7BVbGpt1Or/HrmpshUPduDm6
	 OKoBYCLyyvrtN0n25eTeS+/3E84PyvcO1me1ZMeo99FNFowVq2CWwoGlKmj/VEVwYm
	 gno+nZ5oYW8my4Lrun/5mweiK8UP4tn92qiPzifhiby96RbUkuic0livRkinilnaxf
	 DKj7WQMGi/IBQ==
Date: Mon, 26 Jan 2026 20:00:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <20260126-blinker-secluding-a745f60caccb@spud>
References: <20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com>
 <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>
 <20260123-dinner-aloft-e57deb6c546a@spud>
 <aXdiNb92B4HH+ZFt@lsv051416.swis.nl-cdc01.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yK1i+yQq5ZBwutQC"
Content-Disposition: inline
In-Reply-To: <aXdiNb92B4HH+ZFt@lsv051416.swis.nl-cdc01.nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253589-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 285E98CD85
X-Rspamd-Action: no action


--yK1i+yQq5ZBwutQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 01:46:45PM +0100, Jan Petrous wrote:
> On Fri, Jan 23, 2026 at 05:13:03PM +0000, Conor Dooley wrote:
> > On Fri, Jan 23, 2026 at 11:09:55AM +0100, Jan Petrous via B4 Relay wrot=
e:
> > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > >=20
> > > The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> > > set them to allow using Multi-IRQ mode when supported.
> >=20
> > The binding only supports s32{g,r} devices, why is the existing minimum
> > retained? What devices are going to not have all 11 interrupts
> > connected?
> >=20
>=20
> The original idea was to support backward compatibility, as older DTs
> didn't contain queue-based interrupt lines described.
>=20
> But now, when you asked, I started to think it is not needed,
> the requirement for backward compatibility is managed inside the driver
> and yaml shall describe the hardware not used configuration.

Just to be clear, cos the last portion of that "yaml shall..." isn't to
me, you mean that the driver will support 1 or 11 interrupts but you
will make the binding only allow 11? That would be fine.
Just note in the commit message that all of these devices have the 11
interrupts.

> Is it my understanding right? Should I provide v4 with minimum =3D 11?


--yK1i+yQq5ZBwutQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXfH4QAKCRB4tDGHoIJi
0tNuAPoDxV/IAeHe/4sVvqAaVI5emQP++yc9VFODMCulOLOD3wD/ZLyJy71N+Tg4
4efjJ30p/XNWBZVQgvn0cruDyAqP1ws=
=0Jjo
-----END PGP SIGNATURE-----

--yK1i+yQq5ZBwutQC--

