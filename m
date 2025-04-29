Return-Path: <netdev+bounces-186856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4EAA1C48
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141004A865B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFC255239;
	Tue, 29 Apr 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nrse8DIK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7PvDBOIJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lidwEU0b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z8kG9lZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D421CFF4
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959062; cv=none; b=ol5zpOMfYylMv6wT4FOks51EtZGVfaCp6pkQrnVST5LGNnqqJzNBRS1uCjwvPV6wSymUaKewyq5BjU5CYS2eesSzxamVnve9fHVQcztvNlqjGoF8ggILpNEWQa79MkJv2WWy4wivHtPLIAisfk7bcfy3DBRVdlA9qFXWuptYuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959062; c=relaxed/simple;
	bh=Aia2cY8NfjXLGBSszOwNkQPHsU+Jdunyz9sJnW28+W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODCK4c2J85ux9vt4b4eRNSBCDG8JLFi82Tez2+xaTVQ3j41aQKPo6bjzsVKnK1/seNT4OT6YxRHpI2OfMi2h9Xi/7W/ej0CoNeUl7em6GJqn6Zl/rmqbRHr4apRNtqnLu5sVs5Fc3HkYq7BaaDF+kYPyR7P/XCXdDdpix+xko6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nrse8DIK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7PvDBOIJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lidwEU0b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z8kG9lZP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B98A2211D5;
	Tue, 29 Apr 2025 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745959057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpmAPa+CAzcO+iq0YprPzPqozURDwJRbHXCC5FqlNRI=;
	b=Nrse8DIKn4PqzLccny0su1oBT1e58FVQrYcXR7gHzLQO/eWhYzTHP1u5fPPdSSsNEORkdz
	JLCPZkgym30ig/OaY0/6newOHxDvbNNXUmz48mkaaI6dX+bGky3nSWlcHkB0eiqMCG02A3
	K4ZghTjJd+aRu2A4AhlTk8Zbn5jELys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745959057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpmAPa+CAzcO+iq0YprPzPqozURDwJRbHXCC5FqlNRI=;
	b=7PvDBOIJ0/5iG8A4gvQfNYSgoswufgBhuAuk6mR1v87dSJOsRBxAAEVBu+n9vARmrc/8X8
	YhideCEOk5evjVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745959056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpmAPa+CAzcO+iq0YprPzPqozURDwJRbHXCC5FqlNRI=;
	b=lidwEU0bZK4WNpgr7xPtGAc8thFpYdqSm0NpXABJprc45mFVjIxlqvMSFr5qliHeKI4x5c
	uqWpJhvEH7jPxrACVzYjC29KCu6aHixCM80fqlIjowfx2QPyO6dz4TJn68NtKYVibg3UYi
	aNMN7AgDt8R/tNHt6xxrAt6mk3wiaSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745959056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpmAPa+CAzcO+iq0YprPzPqozURDwJRbHXCC5FqlNRI=;
	b=z8kG9lZPrwIUlwkC+TzEiZoMpv21saVK3FDMGpjHlbL70+0SJ6T+fbSfy9+wh7itpYh6kd
	zBwQn6Uzs44vRMAA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id A51CC20057; Tue, 29 Apr 2025 22:37:36 +0200 (CEST)
Date: Tue, 29 Apr 2025 22:37:36 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org, 
	Robert Scheck <fedora@robert-scheck.de>, AsciiWolf <mail@asciiwolf.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <utlmo4lzclx5u3w3a7kp6jrpsv2zkjobzxnb6meusclp3dxv6j@43t6mqbglfqb>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
 <aAo8q1X882NYUHmk@eldamar.lan>
 <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>
 <aAvknd6dv1haJl3A@eldamar.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lmaxqethifabh274"
Content-Disposition: inline
In-Reply-To: <aAvknd6dv1haJl3A@eldamar.lan>
X-Spam-Score: -5.81
X-Spamd-Result: default: False [-5.81 / 50.00];
	BAYES_HAM(-2.91)[99.62%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asciiwolf.com:email,hungry.com:email,freedesktop.org:url,lion.mk-sys.cz:helo,seznam.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 


--lmaxqethifabh274
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 09:38:05PM +0200, Salvatore Bonaccorso wrote:
> From 7daa26e40d0888c13a2346053638408c03376015 Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Fri, 11 Apr 2025 15:58:55 +0200
> Subject: [PATCH] Set type property to console-application for provided
>  AppStream metainfo XML
>=20
> As pointed out in the Debian downstream report, as ethtool is a
> command-line tool the XML root myst have the type property set to
> console-application.
>=20
> Additionally with the type propety set to desktop, ethtool is user
> uninstallable via GUI (such as GNOME Software or KDE Discover).
>=20
> console-application AppStream metainfo XML at least one binary provided
> must be listed in the <binary> tag, thus add the required value along.
>=20
> Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented=
 supported hardware.")
> Reported-by: Daniel Rusek <asciiwolf@seznam.cz>
> Co-Developed-by: Daniel Rusek <asciiwolf@seznam.cz>
> Link: https://bugs.debian.org/1102647
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2359069
> Link: https://freedesktop.org/software/appstream/docs/sect-Metadata-Conso=
leApplication.html
> Tested-by: Petter Reinholdtsen <pere@hungry.com>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  org.kernel.software.network.ethtool.metainfo.xml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kerne=
l.software.network.ethtool.metainfo.xml
> index efe84c17e4cd..7cfacf223af7 100644
> --- a/org.kernel.software.network.ethtool.metainfo.xml
> +++ b/org.kernel.software.network.ethtool.metainfo.xml
> @@ -1,5 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> -<component type=3D"desktop">
> +<component type=3D"console-application">
>    <id>org.kernel.software.network.ethtool</id>
>    <metadata_license>MIT</metadata_license>
>    <name>ethtool</name>
> @@ -11,6 +11,7 @@
>    </description>
>    <url type=3D"homepage">https://www.kernel.org/pub/software/network/eth=
tool/</url>
>    <provides>
> +    <binary>ethtool</binary>
>      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
>    </provides>
>  </component>
> --=20
> 2.49.0

Applied now, thank you.

Michal

--lmaxqethifabh274
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmgROIwACgkQ538sG/LR
dpUmkggAlujU3CJ7UJDXSg7qGUpdwWjV4w8umADB+k2qWL8VYpZwcuDa+sl2BFLW
JXRo76QKMktSyJaC+1a2sRXoJeMu3hJYN/SUjQpi5ChEOOzu0bUH/6iGoDbMZPhM
YNR2uB9ifx4L7ZVfZYjOCI5zX3ImLu5nnvivcIuS9jVPtPmRQH0ykKrN6b7+gujS
LDu+BMp4CSgdadSV3yX2weKKBpcz839+8S3leUs50zL3HZ0o6QV25tQyuG/A/BaH
CxXUrMy5fB7oA1XbZ/WMCxqWh+xElmPhiesg7IHWK8nR4P57RI3HDPNxP6BigjQE
JpVAHGiV41LM/MTYx0dYI28b98yymg==
=hRJa
-----END PGP SIGNATURE-----

--lmaxqethifabh274--

