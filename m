Return-Path: <netdev+bounces-179400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B714BA7C5BC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4FD189F786
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38141A4F2D;
	Fri,  4 Apr 2025 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQrc0buc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSRpmvxG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQrc0buc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSRpmvxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78A2E62A3
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803142; cv=none; b=cxV8E/m7S9zzYRL6GEz5zfup7vhV0fbezowds379821nzlr4vHSGJPDRMvjmewOfXac+QA14+xKdqPtYrj+Eh7u/b7xpSLgi7rmur1EGhZW9aqEEWFTPggp8iIVYLLCsPbS8cY6m/YW17OfjodMW4cDm9U+b3fMSEHHxPwFcVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803142; c=relaxed/simple;
	bh=86K/5TRz9CHCJdgWshNoul6LvLef4+rDFWtRbEoCmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMJZvBB3W/uQTZlltUvJiZsgSbaEOQJwQr1i8W+M2uHehu11u84nx+qC45jcVAcGS/4Co0EAr86CsGHNVaebtEistyYz5WV6HfpQgPyZC/grW10Tt9O+M1SQoPfAuW087wPoi/1l0DpDvNHbAX1dyQHJrUl1khITBPPmphbWlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQrc0buc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSRpmvxG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQrc0buc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSRpmvxG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A75B0211A6;
	Fri,  4 Apr 2025 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743803137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86K/5TRz9CHCJdgWshNoul6LvLef4+rDFWtRbEoCmF4=;
	b=pQrc0bucqhAPabBYv09DCexAJA1/xF91EOVy4SkcJeNZqmJW6FtWxYJHRwZL/okODGyWOh
	Nqc2z/gBUT5DIBM4pSoLZF9UY+FkVVUnPSANW3FBWF7YN0KuXyZboZ4oWI5t6Qn2iQiCSa
	xcOTZnlicH6+/FBxFNLpl0i8+Xcs/yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743803137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86K/5TRz9CHCJdgWshNoul6LvLef4+rDFWtRbEoCmF4=;
	b=kSRpmvxGbrMS53C1acis6iU4mIcSkrkDpQPXoiS7oHdjpeEriOB4S+7YrPNt0r7rEarR0q
	ByZnuiFr6ZMf27Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743803137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86K/5TRz9CHCJdgWshNoul6LvLef4+rDFWtRbEoCmF4=;
	b=pQrc0bucqhAPabBYv09DCexAJA1/xF91EOVy4SkcJeNZqmJW6FtWxYJHRwZL/okODGyWOh
	Nqc2z/gBUT5DIBM4pSoLZF9UY+FkVVUnPSANW3FBWF7YN0KuXyZboZ4oWI5t6Qn2iQiCSa
	xcOTZnlicH6+/FBxFNLpl0i8+Xcs/yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743803137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86K/5TRz9CHCJdgWshNoul6LvLef4+rDFWtRbEoCmF4=;
	b=kSRpmvxGbrMS53C1acis6iU4mIcSkrkDpQPXoiS7oHdjpeEriOB4S+7YrPNt0r7rEarR0q
	ByZnuiFr6ZMf27Cg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 92F0D20057; Fri,  4 Apr 2025 23:45:37 +0200 (CEST)
Date: Fri, 4 Apr 2025 23:45:37 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: ethtool: Don't call .cleanup_data when
 prepare_data fails
Message-ID: <jbrczz3ylkccyw332pkrzpphe3nrhkcfx3pup6adiufrrwe5s7@zfpk343qajtc>
References: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3gxmzin6gbc74vrl"
Content-Disposition: inline
In-Reply-To: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
X-Spam-Score: -4.40
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,vger.kernel.org,bootlin.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 


--3gxmzin6gbc74vrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2025 at 03:24:46PM +0200, Maxime Chevallier wrote:
> There's a consistent pattern where the .cleanup_data() callback is
> called when .prepare_data() fails, when it should really be called to
> clean after a successfull .prepare_data() as per the documentation.

Agreed. The rationale is that only ->prepare_data() callback knows
what exactly failed and what needs to be reverted. And it makes much
more sense for it to do the necessary cleanup than to provide enough
information for it to be done elsewhere. Except, of course, the simple
cases where ->cleanup() is just a bunch of kfree() calls with zeroing
those pointers so that it can be called repeatedly.

>=20
> Rewrite the error-handling paths to make sure we don't cleanup
> un-prepared data.
>=20
> Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>

Michal

--3gxmzin6gbc74vrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmfwUv4ACgkQ538sG/LR
dpV9WAgAmAQvOmiUsfgCtsDtNaPQ2jFdGJ9EcfJx2h/fk5NXz/Erg6BWtLcr5Kqv
8Ox4G4BWUCv3IK2hADvoDKXm13DhT0ykeIFEgIldD4gn0yypZMzb3tz1RmRRgtfB
yKEqB+Q6/KVscxJhvDdXHdC+p7aloDAvrKqp7RiBU46uafLtXTzNjLHh8mcWhiAM
19JxyGPCpSWjtJ4BMeDz6KDkib/t+yKcRWtQwCngkbzDoJQhRP+YsRytM5w/Acsb
5WwdDTvzYe2vjmZ9gD8Nf4I3WRAWbVyIphwL+hlEDeQdDtKyUQxZFVEUvNq0nOMS
KaI6him2/ydDyjUIQjT0kV8D3JGW5Q==
=jzlY
-----END PGP SIGNATURE-----

--3gxmzin6gbc74vrl--

