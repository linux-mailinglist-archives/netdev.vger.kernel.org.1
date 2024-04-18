Return-Path: <netdev+bounces-89004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBB8A9316
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB3E2815E1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9375763C;
	Thu, 18 Apr 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwHcRACu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JW9GgSaL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwHcRACu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JW9GgSaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D223D7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421852; cv=none; b=PZUCt0l+90Wgdy5NiLo3Ljg0fenzdF2WIhK57VSyoM1VCtYzToCEeBdChBEUWR5A97/UIxEIscoW0u0hoLrDpPaYX/lehhSjUlkP5PfdSi+dVLF59RGsaqLfB9vx3vBiPKwWr2phDx1fjRgE0LuyC62MUgH7iivFvalD7ZXTF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421852; c=relaxed/simple;
	bh=G2gnspNuSd+NuI/7lxBDv7TJn2P9GNT/BCgm6KJ4PNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhSPYS2plrbZm6Nl69KwUjPwl5DACXNYg+d6yJ4d0YgS2HH3xULx5YkHksTwwXT82RVajvrnJjmdql68Z+qhBkebXMoweFSkcNgnH6560BZknQ61D8o31QLSAyrxhec0uz8gxl1+t/vC12HPU2TpvPWDI61XVHrg8yrJdvxAVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwHcRACu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JW9GgSaL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwHcRACu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JW9GgSaL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB29634A35;
	Thu, 18 Apr 2024 06:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713421848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RKm8I+l4wuksOhW8zfBXgab51W6eVgsGE7EgBsenCo=;
	b=TwHcRACuq9DwTkuW5EnpPj+UB9OBOE08+Y+I7i7BZ+sEsowUjgBy9E/q+a390y948l8LhB
	vKhtyMlZJWMqu69vYa0utwP1KUA78cI26RnUVWqGZzAYKfNPPiMEnaXQUcJ5MYKtIhDx24
	B35WKX5ZCQu93VUS9nVVvUMEVpSSvhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713421848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RKm8I+l4wuksOhW8zfBXgab51W6eVgsGE7EgBsenCo=;
	b=JW9GgSaL9mYXuQjEvBE1t868SJTzsDtvCQUGBvOEVUPetGMGSqolpjy9TBka+oNK+Gs6r5
	ZMIe8+3ASqEPemBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713421848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RKm8I+l4wuksOhW8zfBXgab51W6eVgsGE7EgBsenCo=;
	b=TwHcRACuq9DwTkuW5EnpPj+UB9OBOE08+Y+I7i7BZ+sEsowUjgBy9E/q+a390y948l8LhB
	vKhtyMlZJWMqu69vYa0utwP1KUA78cI26RnUVWqGZzAYKfNPPiMEnaXQUcJ5MYKtIhDx24
	B35WKX5ZCQu93VUS9nVVvUMEVpSSvhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713421848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RKm8I+l4wuksOhW8zfBXgab51W6eVgsGE7EgBsenCo=;
	b=JW9GgSaL9mYXuQjEvBE1t868SJTzsDtvCQUGBvOEVUPetGMGSqolpjy9TBka+oNK+Gs6r5
	ZMIe8+3ASqEPemBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B9D2E20136; Thu, 18 Apr 2024 08:30:48 +0200 (CEST)
Date: Thu, 18 Apr 2024 08:30:48 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
	vadim.fedorenko@linux.dev, jacob.e.keller@intel.com, pabeni@redhat.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, gal@nvidia.com, tariqt@nvidia.com, 
	saeedm@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com, wintera@linux.ibm.com
Subject: Re: [PATCH ethtool-next v2 0/2] Userspace code for ethtool HW TS
 statistics
Message-ID: <ig5425idiwrshunkl5mw3nkb7w6pewsy3e7tbsewio4qnnj2au@vqr4ivgh67iv>
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
 <171338943006.32225.7031146712000724574.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjrdmcuu7x2a7nqw"
Content-Disposition: inline
In-Reply-To: <171338943006.32225.7031146712000724574.git-patchwork-notify@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.19 / 50.00];
	BAYES_HAM(-2.79)[99.11%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.19)[-0.974];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdevbpf];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.19
X-Spam-Flag: NO


--vjrdmcuu7x2a7nqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 09:30:30PM +0000, patchwork-bot+netdevbpf@kernel.or=
g wrote:
> Hello:
>=20
> This series was applied to ethtool/ethtool.git (next)
> by Michal Kubecek <mkubecek@suse.cz>:
>=20
> On Wed, 17 Apr 2024 13:38:27 -0700 you wrote:
> > Adds support for querying statistics related to tsinfo if the kernel su=
pports
> > such statistics.
> >=20
> > Changes:
> >   v1->v2:
> >     - Updated UAPI header copy to be based on a valid commit in the
> >       net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
> >       the catch.
> >     - Refactored logic based on a suggestion from Jakub Kicinski
> >       <kuba@kernel.org>.
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - [ethtool-next,v2,1/2] update UAPI header copies
>     https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=
=3Dd324940988f3
>   - [ethtool-next,v2,2/2] netlink: tsinfo: add statistics support
>     (no matching commit)

Looks like the patchwork bot got a bit confused here. I accidentally
updated the UAPI header copies to the same mainline commit yesterday
which was probably identified as accepting the first patch. But the
second (i.e. the important one) is still in the queue.

Michal

--vjrdmcuu7x2a7nqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmYgvekACgkQ538sG/LR
dpXgYAgAy4HWa2fCuk0gZlxoBNwoGr7yJjPrN72x7ULo/YCHJ1TKSF8vjuLtGd1d
Q3fL+r/5h1GAIlS2OS4WHhzLTfKOhU3AgWRD7Nw0qUtoKTpS4V4zs4VH3pMtst+y
CjMtIpSXNY1T5WfRQm1sjcu0ExrZGu7iZYKQ8Em+XbMb+u7aOOrPIVQDdnnO4nev
zQo0Alv8+o7xDqiWLG3JTB2SxuPvR4UkKqplIo0FLExzsMZFus5iigCtJ0X2lBj3
SysT+3oRbaxtR/H7GyIoIMObKqdjpt+4Auh/xswgtNNKqBkvtMhGBaCEuM3eDJTZ
3ZpssFh7u2JkZdyxQk4Jh45wuE7bSA==
=W9i2
-----END PGP SIGNATURE-----

--vjrdmcuu7x2a7nqw--

