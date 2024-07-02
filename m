Return-Path: <netdev+bounces-108366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D7D923904
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60450283BEC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF0148300;
	Tue,  2 Jul 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQL0KU2X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydx+YnGf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQL0KU2X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydx+YnGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777271A28B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910827; cv=none; b=A2+lsgCXCzNuTdCL9JENcXZng6dUGifpc4w3+Swj7vnrlgYlIfd6RoHwJeZZJmL3ga8qlBpb69WLcBt8bfGnV8l4EoPcjKIkQSGrtFGKkhR9QcTEnJXh2AgwjlG+vgfSMu2+UJj/chvIP5qbAfFEty/s8ruQk2Fe5B7Tdfg03Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910827; c=relaxed/simple;
	bh=ZTX09FjxYQ2ukBVd6nk+L51XoFCx6VLCd1dHWS3IERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ43ebfgp61oAzAxTMP3WilP7SuSCLx7os7FjWHiK1EusuIa14+pltGMal56Mw6vR7k+yKvbQQCBl+5vBEJ9HVCWN+wd1CvpfBF6CZASEFgZ62qrCWgCgmeXmhgvtmBbPBTt51Y0P87fYLGdp7DM8EJer1kt0I2bMjL1dRHHjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQL0KU2X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydx+YnGf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQL0KU2X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydx+YnGf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 661FB21B14;
	Tue,  2 Jul 2024 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719910823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTX09FjxYQ2ukBVd6nk+L51XoFCx6VLCd1dHWS3IERs=;
	b=iQL0KU2XVX+mJ1+tN9WOwodFuCqbn3nsYRU5n4PKByIsMZLiDFUCj6ZkyvO4O6IneWrJpV
	PRZ9HPcnHJ5MPcwr80hOt7VhjOSr6aOnHFGsIJ2SBZMeaZOY5bPTBcu8ZyVimfKCgddKPl
	9BzHQyAQhnlWiFCQqNvWNkaOGXduG8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719910823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTX09FjxYQ2ukBVd6nk+L51XoFCx6VLCd1dHWS3IERs=;
	b=ydx+YnGfMcrPKozQUwSd5UK/iakvO3UMEvbgnh/0kaB/ZDd+lNwIbx/v3L7uub2fRn7IRw
	3OrsXbZJfDeJspCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719910823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTX09FjxYQ2ukBVd6nk+L51XoFCx6VLCd1dHWS3IERs=;
	b=iQL0KU2XVX+mJ1+tN9WOwodFuCqbn3nsYRU5n4PKByIsMZLiDFUCj6ZkyvO4O6IneWrJpV
	PRZ9HPcnHJ5MPcwr80hOt7VhjOSr6aOnHFGsIJ2SBZMeaZOY5bPTBcu8ZyVimfKCgddKPl
	9BzHQyAQhnlWiFCQqNvWNkaOGXduG8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719910823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTX09FjxYQ2ukBVd6nk+L51XoFCx6VLCd1dHWS3IERs=;
	b=ydx+YnGfMcrPKozQUwSd5UK/iakvO3UMEvbgnh/0kaB/ZDd+lNwIbx/v3L7uub2fRn7IRw
	3OrsXbZJfDeJspCw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 5168A2012C; Tue,  2 Jul 2024 11:00:23 +0200 (CEST)
Date: Tue, 2 Jul 2024 11:00:23 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 1/2]: add json support for base command
Message-ID: <vaqyae5gc2rorkjele7u26zjnmt4nwxtw6uj6dbefa5uf4tuxb@nx5uurbfiuhc>
References: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
 <fdb32bba-9576-4836-b013-8c07f07cf307@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kpcqr43geqgkpj7y"
Content-Disposition: inline
In-Reply-To: <fdb32bba-9576-4836-b013-8c07f07cf307@pengutronix.de>
X-Spamd-Result: default: False [-5.84 / 50.00];
	BAYES_HAM(-2.94)[99.73%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.84
X-Spam-Level: 


--kpcqr43geqgkpj7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2024 at 10:21:14AM +0200, Fabian Pfitzner wrote:
> I have not gotten any response to my patches yet. Any feedback or
> information if it will get merged into upstream soon? Am I missing
> something?

The patch looks fine so far, I just need to take a look at the JSON
output and check its consistency with existing JSON output of other
subcommands. If there are no significant problems, it should be merged
by the end of this week.

Michal

--kpcqr43geqgkpj7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmaDwaEACgkQ538sG/LR
dpUvMggAgKK0uSDFcPRaduCFVrfAF9uw8oDSjc/2WS5WHFHMq4HgtoKdx2GN5e2a
NdTQcFULz2/ulBSiLtFOt69nfUVIcnP496mz6w0cyQApa8jmnCtEYKLanE5EEYYg
b3AZQK31XmqrMss1Kzw9N1GUfzYFdIK9YBIc+pDFmAPmbJ57x5ddCEu7eOIneoPq
wwkeA8Q9P0PeYbyRDimipd1zfSJiXSujm6cdCI2D5UdhC0ofAbrJ3Q7DzasdLGyH
dmfFjJdnC/swXtBwzWX1LZOSqU/WsFmvlKqwGOGnLysS25XPDDEQYmSxcFi60W1e
Lz8RiXLg0w50A0T3mfylhj0p+hbLkg==
=0gMz
-----END PGP SIGNATURE-----

--kpcqr43geqgkpj7y--

