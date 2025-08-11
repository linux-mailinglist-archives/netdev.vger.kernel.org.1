Return-Path: <netdev+bounces-212593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFCB2161E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B32D1907566
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FA2D877B;
	Mon, 11 Aug 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUPfOxF5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZpc5VN6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUPfOxF5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZpc5VN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C21FAC34
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942827; cv=none; b=ri8H5wp+PQxYYf65NhVpw6ezdF3fXZ9tKX8oI/J9WVhAJf7Ul3ZgvwQiuHk/LT3mSlsjFSm6dwInDiEeq1aqivSmo0zfYvPjHwJJDX5kQkY1fx5LVMyyj1d5WxRpYksvi+v4stnqiSEpyypD//t2ekToWaMOjDgWH7EsyTD8b5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942827; c=relaxed/simple;
	bh=uXynXfy6dDVPmdrWk55BhTzXsofLXUsmrxzpgsAaZyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqGRB943fvcHFaB7JK6M+eHZOFaONcBkvUOrp9mkIlPOT57MM8MMcAQ37AFu+RnlMkdeXEBOERTpTaExVQo0Cqa2wJeoUvrvlAOxXizMXqw95Zbmjpfmx4vnf9b1FOKvXTPLPQRjxUEKf+o/qHZDECTSULNlWOs9cPJWBnzG3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUPfOxF5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZpc5VN6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUPfOxF5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZpc5VN6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 718941F451;
	Mon, 11 Aug 2025 20:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754942823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xK/JbeiS7hTN40685ejcD+CpZYeg4t7PUEXTWIV0Grk=;
	b=NUPfOxF5li4kDnAw6i7kaEx6flUzL68/euAfmHHzSMKxdiG097wilnB/eElnjDEBwWVNsy
	XRNrKDbxnAk6A1eQINtK4WlNqB1nS82wJGxdLa24Fb/OQK0xLyy916Zp8VF4b0DSECSymh
	m7MgGD5awEkVon7B4gbyXUVTJ/RAOUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754942823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xK/JbeiS7hTN40685ejcD+CpZYeg4t7PUEXTWIV0Grk=;
	b=qZpc5VN6+Of0XDiQFdr/S75hp1JyNiXhbSIfd8VMrqTmnYdYhI9My1mxxsmxYqnWLHPkDg
	8+w2NeCDjcKM1eBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754942823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xK/JbeiS7hTN40685ejcD+CpZYeg4t7PUEXTWIV0Grk=;
	b=NUPfOxF5li4kDnAw6i7kaEx6flUzL68/euAfmHHzSMKxdiG097wilnB/eElnjDEBwWVNsy
	XRNrKDbxnAk6A1eQINtK4WlNqB1nS82wJGxdLa24Fb/OQK0xLyy916Zp8VF4b0DSECSymh
	m7MgGD5awEkVon7B4gbyXUVTJ/RAOUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754942823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xK/JbeiS7hTN40685ejcD+CpZYeg4t7PUEXTWIV0Grk=;
	b=qZpc5VN6+Of0XDiQFdr/S75hp1JyNiXhbSIfd8VMrqTmnYdYhI9My1mxxsmxYqnWLHPkDg
	8+w2NeCDjcKM1eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22ABD13A55;
	Mon, 11 Aug 2025 20:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5k1aB2dNmmghNgAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Mon, 11 Aug 2025 20:07:03 +0000
Date: Mon, 11 Aug 2025 22:07:00 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Michel Lind <michel@michel-slm.name>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <b6unuycjddzrl55q3gwtki2rmm2ituknbmgwpuorgten5xr65w@w4dnhvf6mkoa>
References: <aILUS-BlVm5tubAF@maurice.local>
 <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>
 <aJhG0geDvJ4a8CpS@eldamar.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n42sl7ylk5hecazt"
Content-Disposition: inline
In-Reply-To: <aJhG0geDvJ4a8CpS@eldamar.lan>
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Spam-Level: 
X-Spam-Score: -5.90


--n42sl7ylk5hecazt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Sun, Aug 10, 2025 at 09:14:26AM GMT, Salvatore Bonaccorso napsal:
> Hi Michal,
>=20
> On Fri, Aug 08, 2025 at 01:05:52AM +0200, Michal Kubecek wrote:
> > On Thu, Jul 24, 2025 at 07:48:11PM GMT, Michel Lind wrote:
> > > The previous fix in commit b70c92866102 ("netlink: fix missing headers
> > > in text output") handles the case when value is NULL by still using
> > > `fprintf` but passing no value.
> > >=20
> > > This fails if `-Werror=3Dformat-security` is passed to gcc, as is the
> > > default in distros like Fedora.
> > >=20
> > > ```
> > > json_print.c: In function 'print_string':
> > > json_print.c:147:25: error: format not a string literal and no format=
 arguments [-Werror=3Dformat-security]
> > >   147 |                         fprintf(stdout, fmt);
> > >       |
> > > ```
> > >=20
> > > Use `fprintf(stdout, "%s", fmt)` instead, using the format string as =
the
> > > value, since in this case we know it is just a string without format
> > > chracters.
> > >=20
> > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Michel Lind <michel@michel-slm.name>
> >=20
> > Applied, thank you.
> >=20
> > It's a bit surprising that I didn't hit this problem as I always test
> > building with "-Wall -Wextra -Werror". I suppose this option is not
> > contained in -Wall or -Wextra.
> >=20
> > Michal
> >=20
> > > ---
> > >  json_print.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/json_print.c b/json_print.c
> > > index e07c651..75e6cd9 100644
> > > --- a/json_print.c
> > > +++ b/json_print.c
> > > @@ -144,7 +144,7 @@ void print_string(enum output_type type,
> > >  		if (value)
> > >  			fprintf(stdout, fmt, value);
> > >  		else
> > > -			fprintf(stdout, fmt);
> > > +			fprintf(stdout, "%s", fmt);
> > >  	}
> > >  }
> > > =20
> > > --=20
> > > 2.50.1
>=20
> As b70c92866102 ("netlink: fix missing headers in text output") was
> backported as well for the 6.14.2 version, should that get as well a
> new release 6.14.3 with the fix?

I could do that but it didn't seem necessary. If I understand correctly,
this patch does not address any runtime issue (at least not until there
is an actual call of print_string() with null value and fmt containing
a template); and the build issue only happens with a very specific
compiler option which is not only not default but is not included even
in "-Wall -Wextra" (not even in gcc15).

I'm aware that the commit message says that Fedora uses that compiler
option in its package builds but that's something that can be addressed
by a distribution patch. Therefore my plan was to cherry pick the commit
into ethtool-6.14.y branch but not to release 6.14.3 unless something
more serious shows up.

But if I misunderstood the situation and 6.14.3 with this commit would
be really helpful, I can reconsider.

Michal

--n42sl7ylk5hecazt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmiaTVsACgkQ538sG/LR
dpXP1QgAgX13DMhcPxa5Tc/0eAV6OH0zYUFlNaTffDuec8XVLEidL3b5peXmq7jA
SidQQYyIvfnl5rWkkDInryFJpzsKy2S8oTPOsbOIRLVjP2IRuiKqj3Hrt498xOCp
jwF4WnTUpSXxYF6tfmic30SHJXkidiJxed8Tt0qv6CZeeciEpB5iS3b894ANOLKQ
p7utNYJHtc/yLGwhO4UPTnKKxeJZDKNNnvq6CQz+E8NSsW847FRfT1ee6mw8NwMc
sfh196E5GxDnX7hWmNplLHMs6+HFu6KXoVdtk0Cdwq9l9bHEQtOOz38HavoBYumW
Gg0juEWC4St3OWUgcP0rsunC2VJYKA==
=0Ho7
-----END PGP SIGNATURE-----

--n42sl7ylk5hecazt--

