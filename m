Return-Path: <netdev+bounces-212776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A3B21E09
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3CA18814F2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2412D239A;
	Tue, 12 Aug 2025 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQ8E5sVQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAFaJaNx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQ8E5sVQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAFaJaNx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D124DCF7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979252; cv=none; b=BjeRIvaLtsHS+TgIk9IWd3RK0hZVCwIcbenzL9DR2I4WSQvLxeksH5Zur9uDO/gPFAu1kJ54bY3E9tOhGiWhp0ZmqmzTfNLhCIvFfx2lxC8EuiLLzFNPIQ+6qdMi12WfcYZDSKb6EP6eRaLxwVowpbM1vwkkyLQFTYqQ3pG9M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979252; c=relaxed/simple;
	bh=AuvZlfgJm/luzwRGNzGdROw++QyfF6nkWXGdj7yqjw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE2hBRXLmVNPvLU+q3lMTAUnxUcc45Et5gWf2VzC3DL6zQNlWZH3dQG5b0TvEbx0Ti3we0IDLLdskezTHkz93PjzsAmkvak9+/svNTceiYUtl95PcKr6VFSZV7QW4B/LxEk81rR2NBfTFk1DgybjWs4r1Gha4eqRIcCctEcL8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQ8E5sVQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAFaJaNx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQ8E5sVQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAFaJaNx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B5C021D1A;
	Tue, 12 Aug 2025 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754979248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuvZlfgJm/luzwRGNzGdROw++QyfF6nkWXGdj7yqjw8=;
	b=mQ8E5sVQrpTZk52ITSsp0AYh1ikV9sgODSSGEfURYiCpd/6VO+1wX0gEj6XgaOSPHoizK3
	qKUfQgzgCAW0+waxqWFQ0WBTwjzj3EYvlzUFAZsmeledatyRqYuDSMjGlTM+/Mi0ShCcN1
	oQdak9/vXqi0P3dbLR3oE9XH201xOv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754979248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuvZlfgJm/luzwRGNzGdROw++QyfF6nkWXGdj7yqjw8=;
	b=iAFaJaNxOMZe3LJg5GWNqoAZ4Cc680LvKsVVrDmlPvLPeclICKWT0J1rhfIH/U2CRvQnwP
	LmhjQVVcv++16XDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754979248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuvZlfgJm/luzwRGNzGdROw++QyfF6nkWXGdj7yqjw8=;
	b=mQ8E5sVQrpTZk52ITSsp0AYh1ikV9sgODSSGEfURYiCpd/6VO+1wX0gEj6XgaOSPHoizK3
	qKUfQgzgCAW0+waxqWFQ0WBTwjzj3EYvlzUFAZsmeledatyRqYuDSMjGlTM+/Mi0ShCcN1
	oQdak9/vXqi0P3dbLR3oE9XH201xOv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754979248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuvZlfgJm/luzwRGNzGdROw++QyfF6nkWXGdj7yqjw8=;
	b=iAFaJaNxOMZe3LJg5GWNqoAZ4Cc680LvKsVVrDmlPvLPeclICKWT0J1rhfIH/U2CRvQnwP
	LmhjQVVcv++16XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23E4D1351A;
	Tue, 12 Aug 2025 06:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B7uyB7DbmmhHRAAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Tue, 12 Aug 2025 06:14:08 +0000
Date: Tue, 12 Aug 2025 08:14:06 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Michel Lind <michel@michel-slm.name>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <z3f7fvab4q3i6aqu23iotjoyrahqxi6aegup7dmfoeoahf6dig@pmvwehb7d4fm>
References: <aILUS-BlVm5tubAF@maurice.local>
 <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>
 <aJhG0geDvJ4a8CpS@eldamar.lan>
 <b6unuycjddzrl55q3gwtki2rmm2ituknbmgwpuorgten5xr65w@w4dnhvf6mkoa>
 <aJpRSuCpo37TCLZZ@eldamar.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibpuypyjowvmhk6s"
Content-Disposition: inline
In-Reply-To: <aJpRSuCpo37TCLZZ@eldamar.lan>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -5.90


--ibpuypyjowvmhk6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Mon, Aug 11, 2025 at 10:23:38PM GMT, Salvatore Bonaccorso napsal:
> No not urgent, but I hit the same issue when preparing 6.14.2 for
> Debian trixie. But I can equally just cherry-pick the commit locally
> and then drop it once 6.14.3 is released.
>=20
> So really no hurry about that.

OK, I'll release 6.14.3 on Friday when I'm back home and can do it from
my desktop which will be a bit easier.

Michal

--ibpuypyjowvmhk6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmia26cACgkQ538sG/LR
dpWOlwgAmS3GYLexRZLULjFbOiDlJSo72esllzSboioQVrrsLnwPhYK9YWE3NDsF
wQ02PqCYkL0Ty6gWQQUH7YbthaSFWR8J68DpwQNi/0nPjhS0w3ZhbApBblYM0oZZ
qjsSmluK+5OlYoOdb5KLBkjPB9ngBFXyTrNQnDjGy1NP8oec+oTJTXb1rCiNth9d
zJKEPIeptM83MT4wX663Je8YZSTUPPvzjZahCtARR/cbAJYRVFGjdCI4uQuNTZ4j
2hVCq2VngtcKyCZLZ+uh0n6AM6YePizBMCIW8fPQAAPePvhUQ3aAipK6SuJEONkE
/nzU6VZc7Gu9bPKH1+GVK0i2SFkVJA==
=hmvW
-----END PGP SIGNATURE-----

--ibpuypyjowvmhk6s--

