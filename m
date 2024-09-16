Return-Path: <netdev+bounces-128599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF097A828
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EEF28BF8A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3915C131;
	Mon, 16 Sep 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RPLmTAB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgutY9Y/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RPLmTAB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgutY9Y/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81C5258;
	Mon, 16 Sep 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517492; cv=none; b=ldvhsU0S/r6BLBbh3Vd/cMJ18bAek0o1GR1QzECPHuZQB1cN8UStYVKT/U0UmapAGPh4+OK+bFW/uQI0j0AJ/zegXnlshu0BuFbaNufeQs6srjH/MLGyM9p3jQcOwOhL3YJbKA8+C2mfAiwwf98GAJvRlZUjpcvSGa1LWQO/wIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517492; c=relaxed/simple;
	bh=cWmkW6p+a48CvQupsSoBxjReqvjHAeV4x0TqfyT00Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6NsDXir9hCMoN82QduLyzEKFhDnVqAm8emN6MxLt1eEEBUH6kEPSkYt23k2wCafffpRHx+dhD1xxiVZdbwYZkWMapuKkY/wReVbkT0TUOPUYu57AoTRj0gLiLBGBmySP6RBaEfRVP5wjAGXGcvDkLikvh2qsiSiqLuAABEzXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RPLmTAB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgutY9Y/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RPLmTAB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgutY9Y/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC53421C29;
	Mon, 16 Sep 2024 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726517488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QksCJ97Q9Tn4Z+mI0GvL5/7ruXlE99v0+oGl+RXvOfU=;
	b=RPLmTAB5a9Ck+ZB/hxLGJ6gmwK88R93He0Ix6m1h/54LBc8dbSLkycdWE2Gjz1XP2nMEWN
	gNq/SvxKPE0JjTJN3+p9jjPoWhAXSGuoE+pejgeZkyZ3sNsstztKtNBMSFGkQYWGvGj3+e
	q2JP6ua6uFivQNQ5Svu4nQjdLMFr43U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726517488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QksCJ97Q9Tn4Z+mI0GvL5/7ruXlE99v0+oGl+RXvOfU=;
	b=DgutY9Y/sO2V8WtW/L/dyMbUt3UzA9nu49p+pfcIbpiOXvFq4nKPdX5I7ngPCn3luz9IwL
	CBcxXcs+hDTvQFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726517488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QksCJ97Q9Tn4Z+mI0GvL5/7ruXlE99v0+oGl+RXvOfU=;
	b=RPLmTAB5a9Ck+ZB/hxLGJ6gmwK88R93He0Ix6m1h/54LBc8dbSLkycdWE2Gjz1XP2nMEWN
	gNq/SvxKPE0JjTJN3+p9jjPoWhAXSGuoE+pejgeZkyZ3sNsstztKtNBMSFGkQYWGvGj3+e
	q2JP6ua6uFivQNQ5Svu4nQjdLMFr43U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726517488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QksCJ97Q9Tn4Z+mI0GvL5/7ruXlE99v0+oGl+RXvOfU=;
	b=DgutY9Y/sO2V8WtW/L/dyMbUt3UzA9nu49p+pfcIbpiOXvFq4nKPdX5I7ngPCn3luz9IwL
	CBcxXcs+hDTvQFBg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 98F402012C; Mon, 16 Sep 2024 22:11:28 +0200 (CEST)
Date: Mon, 16 Sep 2024 22:11:28 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Kyle Swenson <kyle.swenson@est.tech>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool-next 0/3] Add support for new features in C33 PSE
Message-ID: <ohcflwsvztqatsaudheougap3sxkdah5lagtyzr6d55u2nzcwq@iaaoyutqdbj7>
References: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="edbgzcd7rbqkl4fn"
Content-Disposition: inline
In-Reply-To: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 


--edbgzcd7rbqkl4fn
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:20:01AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This series adds support for several new features to the C33 PSE commands:
> - Get the Class negotiated between the Powered Device and the PSE
> - Get Extended state and substate
> - Get the Actual power
> - Configure the power limit
> - Get the Power limit ranges available
>=20
> It also updates the manual accordingly.
>=20
> Example:
> $ ethtool --set-pse eth1 c33-pse-avail-pw-limit 18000
> $ ethtool --show-pse eth1
> PSE attributes for eth1:
> Clause 33 PSE Admin State: enabled
> Clause 33 PSE Power Detection Status: disabled
> Clause 33 PSE Extended State: Group of mr_mps_valid states
> Clause 33 PSE Extended Substate: Port is not connected
> Clause 33 PSE Available Power Limit: 18000
> Clause 33 PSE Power Limit Ranges:
>         range:
>                 min 15000
>                 max 18100
>         range:
>                 min 30000
>                 max 38000
>         range:
>                 min 60000
>                 max 65000
>         range:
>                 min 90000
>                 max 97500
>=20
> This series requisites the c33 PSE documentation support patch sent
> mainline:
> https://lore.kernel.org/r/20240911-fix_missing_doc-v2-1-e2eade6886b9@boot=
lin.com
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

The series looks good, except for minor detail: the new parameter
c33-pse-avail-pw-limit is documented in the manual page but is not shown
in the "ethtool --help" output.

As far as I can see, the kernel counterpart is present in 6.11 so that
this series could technically go into ethtool 6.11 but as it was
submitted so shortly before the release, I would rather leave it for the
next cycle. As you submitted it against next branch, I assume you are OK
with that but I better ask.

For now I applied patch 2/3 which is a simple fix independent of the
rest. Is it OK to apply the rest (with added help text) after the 6.11
release?

Michal


> ---
> Kory Maincent (3):
>       ethtool: pse-pd: Expand C33 PSE with several new features
>       ethtool.8: Fix small documentation nit
>       ethtool.8: Add documentation for new C33 PSE features
>=20
>  ethtool.8.in     |  37 +++++++-
>  netlink/pse-pd.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 311 insertions(+), 1 deletion(-)
> ---
> base-commit: 1675c9c8df2e13c2c800ef4d86cfc5a37ddeaa3e
> change-id: 20240709-feature_poe_power_cap-56bd976dd237
>=20
> Best regards,
> --=20
> K=F6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>=20
>=20

--edbgzcd7rbqkl4fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmbokOoACgkQ538sG/LR
dpWUfAf/ZQNDYXxtfiII2wIU7W9kdU0foKTbmfiEMhfA2WfJhCCQFAylo98RTCF3
iWRoTdpcfJxCI9ygRGiWZD7OcYOIK8zm+EZ/1K4SPd9jxjnVZO32MvXOUG4hQMUR
z0OJgAIQug423RBxBYUN4f2RGcIDoouM2rV22X1fM3sL5E1bwrRq+5Gyl/kSvn7S
vlJeXbo5e4JvvXJsXU4iVdzsb7KgUoxW+dXUxgZzk0+h9lKfD7K/faXGRfl+8Wjf
Ug8BEAmFVO88SEuIfmtHzvfkiXCRUJQkpbKcRiLv7V6CgkXk6e6zDRr3/VxsMBDe
oBctYGFoiKYgDplZ1J/OuMvzk+muzA==
=hI7K
-----END PGP SIGNATURE-----

--edbgzcd7rbqkl4fn--

