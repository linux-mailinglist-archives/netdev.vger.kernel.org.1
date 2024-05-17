Return-Path: <netdev+bounces-96950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A88C8661
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B31C219A8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236A4316F;
	Fri, 17 May 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3G4UbzGU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+7uak/i8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3G4UbzGU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+7uak/i8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78E7F9;
	Fri, 17 May 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949538; cv=none; b=YBO0Vr4DleYTtk9nDJ2mMy5Cavrpz8jd8vqzEF29X5GSYv7jGQRr79QlAq6K+jHVysv3xeHAD1zDo8IxZ3l7yOLwXzyMm+nN8xxofeE+5nlR6or8IQinGc+ZFYIRLUUUkLAJtHUX80bsSXrAlixCXsOX3wBryn3BozeFNs197wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949538; c=relaxed/simple;
	bh=NMyuqGNEe1rwzavrQnoFlFNOyHQJqVmNF07SKH9W7Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJOphWkny96XOn4m3oZHfAgcqi5YEKleP10Ioik62kEZolJSV6rPRSgEQ8+YiEUgZJlNb9SBvKOT8qr512+ubtS4ow98kqCzDhotKii8dncBhO3AkHLrJqB8w6gBYjxwfikJpxtDOUVsPeR1/ulYU9z/0l8roiVgBEIpVF41VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3G4UbzGU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+7uak/i8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3G4UbzGU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+7uak/i8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 787E922D99;
	Fri, 17 May 2024 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715949534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMyuqGNEe1rwzavrQnoFlFNOyHQJqVmNF07SKH9W7Cs=;
	b=3G4UbzGU/Vm1UKyy25gUFX5DmDuR9WszvbV64najWXYbbD7wHhagxRIjC0RCnMitxrcadN
	NyUeEtntXrKHUchAclEQJvZv+Tyfz/A/sUIBqy96YkfuFWdEJGZNJ7gVdvQ5xsbA4XG8KF
	pp+kvCKVJESGzh3PuA3laYCRnYIeBUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715949534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMyuqGNEe1rwzavrQnoFlFNOyHQJqVmNF07SKH9W7Cs=;
	b=+7uak/i8p9E+IAEDFkYDeVS18p1jzKuiK5Ozb3Zg2os0Tbsv+exozm+J3zkN6vYRxR/HD2
	cTTmEzXSf2ItPmAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715949534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMyuqGNEe1rwzavrQnoFlFNOyHQJqVmNF07SKH9W7Cs=;
	b=3G4UbzGU/Vm1UKyy25gUFX5DmDuR9WszvbV64najWXYbbD7wHhagxRIjC0RCnMitxrcadN
	NyUeEtntXrKHUchAclEQJvZv+Tyfz/A/sUIBqy96YkfuFWdEJGZNJ7gVdvQ5xsbA4XG8KF
	pp+kvCKVJESGzh3PuA3laYCRnYIeBUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715949534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMyuqGNEe1rwzavrQnoFlFNOyHQJqVmNF07SKH9W7Cs=;
	b=+7uak/i8p9E+IAEDFkYDeVS18p1jzKuiK5Ozb3Zg2os0Tbsv+exozm+J3zkN6vYRxR/HD2
	cTTmEzXSf2ItPmAA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 6632F20131; Fri, 17 May 2024 14:38:54 +0200 (CEST)
Date: Fri, 17 May 2024 14:38:54 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH ethtool-next 0/2] Add support for Power over Ethernet
Message-ID: <4asgo5rtu4daknofzmyyk7x47adcyfpdej2pbbv2vdaxnjf6yn@thkh274ismmb>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
 <20240517142803.6c28b699@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mewes6f5fdmqckkr"
Content-Disposition: inline
In-Reply-To: <20240517142803.6c28b699@kmaincent-XPS-13-7390>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.85 / 50.00];
	BAYES_HAM(-2.95)[99.78%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
X-Spam-Score: -5.85
X-Spam-Flag: NO


--mewes6f5fdmqckkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 02:28:03PM +0200, Kory Maincent wrote:
> On Tue, 23 Apr 2024 11:05:40 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Expand the PSE support with Power over Ethernet (clause 33) alongside
> > the already existing PoDL support.
>=20
> Hello,
>=20
> Any news on this patch series?
> Would someone have the time to take a look at it?

I should be able to get to it this weekend.

Michal

--mewes6f5fdmqckkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZHT9oACgkQ538sG/LR
dpUA9Qf/V99WeQK/DbHCdeUgx61nGXol1rkXgqP5m0B+lGbTadlZ2QaOVps4ue39
cQ8TE1kmaD/E96YGbRAdnkemCZMrLqHEHL/BN9lY9P6JaYB9LL6nnaAUIBg3v5tS
kIEaZXPmKpY9VqKU1gSP3KMe5aCgZVyIyZo3H7ESnqQGefng/Lvcm3oHOdxMTZvu
M2vcqZwjrsZtmuK5DSGalExChQzEfI3t5payAQc+IudSi8X/ezoIUxeDpRC82bCW
Mgze88eCR77K0/RSfJwCMZ0Fc4BG7ixL5RFBZaw/pMDG3B2ItdpNj8gY4CCch5J+
ioCVQIb8v05Ue2DyFH80m46plWnBCQ==
=QOj6
-----END PGP SIGNATURE-----

--mewes6f5fdmqckkr--

