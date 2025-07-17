Return-Path: <netdev+bounces-207841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F9B08C69
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D460A46D36
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DB29CB59;
	Thu, 17 Jul 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cyQKJkV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP0fVfIO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQ6XB1PK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8MXG4BRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277329E0E5
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753886; cv=none; b=BrUKBNeX2JjdNFbIcqVuWHlQUKbfGksUl0QPudpoYX7Jx7Bq0NFznUmXogYyLOBYE4pzGHzHNNxydC7rvTbpZd3+7C5mTBWIIu0h9SMc+LR35jrMn9Y8tIaRMxo0tuEmms3ZYePAm1YWccowB6huQr8K58lcW/WwAUrH6AY7ZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753886; c=relaxed/simple;
	bh=uZn980vKjdbX7LP+aatmaqDjwVhDtsBfnSidK3wbclU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRCVQY7pEIprIW0Rkl+bRTu+UVVgEuVXtBiKiLTxrFXxCK0SaDe9GEptUGBb5GsdXgrTkaTJGDwA9+mLDu3S8a7VBsU+c9zV2k2TVzLQDw1M2KsqUwM5fW5um87a8asdeswo0gM849f95dg/N3lsx0gzzVWVnXPXMChvdXS+LnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cyQKJkV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP0fVfIO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQ6XB1PK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8MXG4BRP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9A841F7DD;
	Thu, 17 Jul 2025 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752753876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZn980vKjdbX7LP+aatmaqDjwVhDtsBfnSidK3wbclU=;
	b=1cyQKJkVZmM4dbVBCbw5i0gdtiY2hhYymXY9JYrYtRZJYfqETBQYOggUwCwLSlDYpL17Uy
	wVaRY1ZGrBGQVmUAQrHr4Va8l9H4+NKjyBjDqCErDKba5Pa4emYRFSyD+aSfgYloYzIKbV
	632wjDAb1GB+mIi7G7604xMxf9y/2lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752753876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZn980vKjdbX7LP+aatmaqDjwVhDtsBfnSidK3wbclU=;
	b=PP0fVfIOfl0lQvftJbe+XjwoWwVnrTwOvM7C6DQIvFJRnI+4ML8tYqbC88fh41lac5AUEs
	t1Qjg3/01nEBgEDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rQ6XB1PK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8MXG4BRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752753875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZn980vKjdbX7LP+aatmaqDjwVhDtsBfnSidK3wbclU=;
	b=rQ6XB1PKbbC8Fm0dXTW59gnC/8pHJ8oQ5mQwesivYNxxvlfh+83Pnmu0+pYak3E4m/2oEp
	TykBz1pJD7LwUiGIdz7Lfjmxv56bQqRrXtvtPPix6e+oZsvLMP5Zfj6FJEuYJghN+2gnvM
	WtfpfqM2BOoLlz48CA1kyrCMDCI2IFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752753875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZn980vKjdbX7LP+aatmaqDjwVhDtsBfnSidK3wbclU=;
	b=8MXG4BRPIcMbz+oYlObKqBWdnPaAIX6QNZ/MMNRQgCXyyywK2ZLikylR6RaIIARcFSP19x
	XGesevXfuTaWTJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC3013A6C;
	Thu, 17 Jul 2025 12:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XriHJ9PmeGhNBwAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Thu, 17 Jul 2025 12:04:35 +0000
Date: Thu, 17 Jul 2025 14:04:28 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ant.v.moryakov@gmail.com
Subject: Re: [PATCH ethtool] netlink: fix missing headers in text output
Message-ID: <v6k7auiald3serp6sbsyyjt4wfstt4oeshmhrsjnwzqbnwyiet@l3c62hwaqpqn>
References: <20250712145105.4066308-1-kuba@kernel.org>
 <20250715064010.164c1c4b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n5cwy6gbznv2obwp"
Content-Disposition: inline
In-Reply-To: <20250715064010.164c1c4b@kernel.org>
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E9A841F7DD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.11


--n5cwy6gbznv2obwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Tue, Jul 15, 2025 at 06:40:10AM GMT, Jakub Kicinski napsal:
> On Sat, 12 Jul 2025 07:51:05 -0700 Jakub Kicinski wrote:
> > The commit under fixes added a NULL-check which prevents us from
> > printing text headers. Conversions to add JSON support often use:
>=20
> Hi Michal!=20
> Would you be able to apply this ASAP and cut a release?
> AFAICT this bug has made its way to Fedora, at least.
> And some scripts try to match on the section text..

I'll see if I can do it in the evening. The problem is that I'm on
family vacation (until Saturday) with very poor connectivity. At least
SSH seems to be the only thing that works reasonably well...

Michal

--n5cwy6gbznv2obwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmh45sgACgkQ538sG/LR
dpULHgf/cWwGvfVX7+A6MunRqL3rSRb/mgL2M0Q8wPXYqhLelCPR1l6R9uZ+pthQ
JtOuWMNJEBxDHdThUjCmNTMT9CFgzbzIxrVtVfC2tfP8O8zKq2eiG+oHMFL3Lj0R
RjjuNBbyH2qgOKL193Yu1SCS9lKEtALkmFbecgMgmejova7IWGyceA2Hxq4HRaHB
SP35So92RkLGOEq8gWtZG8D0rJKya3uvrfqxRfeg6Cmrfg04bcHtVa5RBPtALl6P
Z/dpzT2MmSEvIwM2J6QeHBqefyDeRCVq2lAINEZurr6UAcAvknnwKCb+UYmbmnFP
BCXJ7xjmCLIFjemIJACTUDtMa1NvNA==
=eX69
-----END PGP SIGNATURE-----

--n5cwy6gbznv2obwp--

