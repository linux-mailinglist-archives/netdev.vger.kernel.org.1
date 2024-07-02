Return-Path: <netdev+bounces-108556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B9924362
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E966B2684D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C11BD001;
	Tue,  2 Jul 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GlbGd7z8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GlbGd7z8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AD186E4E;
	Tue,  2 Jul 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936918; cv=none; b=KhJ/9J3V1vwxyitqYaMOEcuwQshNJXKvHt02ZVPdSPmjQTWp28WCwhpBinbd5ay1C4vyC3P51gouF3lRaS9Z9whU+UjU9OqkpBrr3eT+gsMo/jgKRJqtqi+Cp6qpbohSnLlxAmBpky4wXxCLYEuKfw94rei6BCI0aVU9qNAcIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936918; c=relaxed/simple;
	bh=IuDiAF12ZQKS8CNeA2BJMM5LrqhJ69EnKFX8mJznFX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik0E0EayfEHYduLPq9898BudjUqCU6RN/ugKeYdG3vCgm01VY9ZtPl88vy+GNuO1JwNG546wKGo7h5k8LPphA83M1zG/6diZ6rh7FAjprggoac8aFPGDW0dCPqt5SBXFaBHUx0+vSpGpgyfVjvW7Dls3MYZf0EX2uQh3+0vHH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GlbGd7z8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GlbGd7z8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73ADC1FBAE;
	Tue,  2 Jul 2024 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719936914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPF79yl8Plj5EQmnm7P5IyOOgOSlg/APv+AJCwGC+hM=;
	b=GlbGd7z8/b/SDvI3RlaYEDg1gKz2HE5vdF6Tqu4FxdNO2My8JZXKTd+h9cWioabi5I3sZ8
	jAcVFM5RXiBhMcUQ+RhDBCBSH4ZekxIRgA09gOsNMh9FMPDiK4qmyyC6SzFvSnptu7HxN1
	BTiVF2Yrbhs79VvxaogcR9OV6GGx894=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GlbGd7z8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719936914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPF79yl8Plj5EQmnm7P5IyOOgOSlg/APv+AJCwGC+hM=;
	b=GlbGd7z8/b/SDvI3RlaYEDg1gKz2HE5vdF6Tqu4FxdNO2My8JZXKTd+h9cWioabi5I3sZ8
	jAcVFM5RXiBhMcUQ+RhDBCBSH4ZekxIRgA09gOsNMh9FMPDiK4qmyyC6SzFvSnptu7HxN1
	BTiVF2Yrbhs79VvxaogcR9OV6GGx894=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67AB313A9A;
	Tue,  2 Jul 2024 16:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gg7uGJInhGZGNwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 02 Jul 2024 16:15:14 +0000
Date: Tue, 2 Jul 2024 18:15:09 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Subject: Re: CVE-2021-47285: net/nfc/rawsock.c: fix a permission check bug
Message-ID: <4bka5bbczovc7z3tplqjlsfukf6qneg4wwddixgodsgqkudwlu@yws3uczmtzsn>
References: <2024052155-CVE-2021-47285-4fee@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gc3npna75i4w57gm"
Content-Disposition: inline
In-Reply-To: <2024052155-CVE-2021-47285-4fee@gregkh>
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 73ADC1FBAE
X-Spam-Flag: NO
X-Spam-Score: -6.11
X-Spam-Level: 


--gc3npna75i4w57gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, May 21, 2024 at 04:20:39PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> net/nfc/rawsock.c: fix a permission check bug
>=20
> The function rawsock_create() calls a privileged function sk_alloc(), whi=
ch requires a ns-aware check to check net->user_ns, i.e., ns_capable(). How=
ever, the original code checks the init_user_ns using capable(). So we repl=
ace the capable() with ns_capable().
>=20
> The Linux kernel CVE team has assigned CVE-2021-47285 to this issue.
> ...
> 	https://git.kernel.org/stable/c/8ab78863e9eff11910e1ac8bcf478060c29b379e

Despite the patch changes guard related to EPERM bailout, it actually
swaps a "stronger" predicate capable() for a "weaker" ns_capable().

Without the patch, an unprivilged user is not allowed to create nfc
SOCK_RAW inside owned netns, with the patch, it's allowed.

That's a functional change but not security related. Or have I missed a
negation somewhere?

Thanks,
Michal

--gc3npna75i4w57gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZoQngAAKCRAt3Wney77B
Sdx2AP9vtrXzCwvchKdCIKKUQkDEYnTC2x7JqVRWCEf6a5eWSAD/fXa7jO/XmQv8
3VniBJ0oXj7Nt9b2LUB4KTfmQwX0dQg=
=AxFm
-----END PGP SIGNATURE-----

--gc3npna75i4w57gm--

