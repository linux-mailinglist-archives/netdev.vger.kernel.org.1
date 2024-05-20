Return-Path: <netdev+bounces-97150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCC8C9789
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 02:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E609D1F210CA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 00:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792DEC2;
	Mon, 20 May 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYEgInbi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fi4i19QF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYEgInbi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fi4i19QF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CECA48;
	Mon, 20 May 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716164182; cv=none; b=SzfziKg6RcqvM6FuiUht1hwkV3IvQceVpvXVUAVrpfY/LlByOC9xaw4r286ImrUcFQkE/mwudMbiND36qmv5LSsQw/3VXEGFjJkYW3Mqv7p9sZU9I5YCLURGcKhohpoIgB5HAK4Zug0pqNinD5tMZ2UPi2gjX9fUJdYTrQc9Ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716164182; c=relaxed/simple;
	bh=5J5Ljl8OuAa3/iEq4o9ADF0TWSA/h5Scio8iyeyiCQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk0T62azsU+P3Nieo3OsG6Twyi7GMNDFvN+4jErOLz55IYvQ2NdlBeYuQjaUN+r1HJCh40aEvHQHZDZYTKDP20BPJ6D9mUQBylvsyg0kmQkYvwfbLiVcNyQbEf6G60VtWHwKQWFaNYfxzghAWYmDJmjKlSHTSlcYoToCT3tJVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYEgInbi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fi4i19QF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYEgInbi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fi4i19QF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6DE333D1B;
	Mon, 20 May 2024 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716164178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csNogiNUsudqXDZ+qewzLCxP7SOijAtAg940egZgOmc=;
	b=eYEgInbiXLt79tJtgkokRt+1/Lf7b2PzmwRr/375aaemhAmbo6OmTkRwuHg3lOXYhUU+b7
	QF0o9ocmgd63zUpF25sHeMKB0OiHILTrZXoymX6GNrbbCgB+6wFDUvw6YbWmZv8tzpS+Lw
	cfHq/AeCO/QXO4+vk39vnyXJRSQbBiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716164178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csNogiNUsudqXDZ+qewzLCxP7SOijAtAg940egZgOmc=;
	b=Fi4i19QFuOYTAQTYdi5fM7XnlKd/vgvAdNSq2u8cnD1WZZsn7rQheDNQJWFNPgKaghVRvm
	DUm4hdjhiUrzDoBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716164178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csNogiNUsudqXDZ+qewzLCxP7SOijAtAg940egZgOmc=;
	b=eYEgInbiXLt79tJtgkokRt+1/Lf7b2PzmwRr/375aaemhAmbo6OmTkRwuHg3lOXYhUU+b7
	QF0o9ocmgd63zUpF25sHeMKB0OiHILTrZXoymX6GNrbbCgB+6wFDUvw6YbWmZv8tzpS+Lw
	cfHq/AeCO/QXO4+vk39vnyXJRSQbBiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716164178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csNogiNUsudqXDZ+qewzLCxP7SOijAtAg940egZgOmc=;
	b=Fi4i19QFuOYTAQTYdi5fM7XnlKd/vgvAdNSq2u8cnD1WZZsn7rQheDNQJWFNPgKaghVRvm
	DUm4hdjhiUrzDoBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 9C61020131; Mon, 20 May 2024 02:16:18 +0200 (CEST)
Date: Mon, 20 May 2024 02:16:18 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH ethtool-next 2/2] ethtool: pse-pd: Add support for Power
 over Ethernet (clause 33)
Message-ID: <yvu6bsmi4d3ib6yfi4vldgwux62bf7xmm4zvx3zrdw2gqgdpvw@ymiciadf6v7m>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
 <20240423-feature_poe-v1-2-9e12136a8674@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wiapqfwk3xiamyyh"
Content-Disposition: inline
In-Reply-To: <20240423-feature_poe-v1-2-9e12136a8674@bootlin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
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
X-Spam-Score: -5.90
X-Spam-Flag: NO


--wiapqfwk3xiamyyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:05:42AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This update extends PSE support to include Power over Ethernet (clause 33=
),
> encompassing standards 802.3af, 802.3at, and 802.3bt infrastructure.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  ethtool.c        |  1 +
>  netlink/pse-pd.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 67 insertions(+)

Hello,

after I merged your patch and pushed to the server, I realized that you
forgot to update also the manual page (file ethtool.8.in). Please send
a follow-up patch with manual page update.

Thank you,
Michal

--wiapqfwk3xiamyyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZKlksACgkQ538sG/LR
dpXcPAf+NvVvR9qe7csPB63ohgoDxmsodxOWSPpvUDmyuLu9HXiCv53v3jnoePS+
sm5zWSCDhCMI61yQ7v2/lgEbw3mOnXmQH1Yhr6SCQu/vnnAkBnExrH8JyjIB7232
rIGGY3kXq89RsQQL+3g0X3yZU/80x+s75P8nXjAYrJkMsP/AXd63fTLUdtF60H34
cf3kmlRpg4zXnV4nQd6pmoD08CeYgtBRk/XanH6C4hpVmcz2/jwwhCJdoNGizdzX
VUCq5xvs43ajvjoEXgCUIm6fj9n34rfGTbXdRNlfj1pKr4VGODAIov/nOy5IvlAu
JUwrrj60xQbIrrP3JK5nzGmHIOHteQ==
=GXX5
-----END PGP SIGNATURE-----

--wiapqfwk3xiamyyh--

