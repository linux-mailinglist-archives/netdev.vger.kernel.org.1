Return-Path: <netdev+bounces-186050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0BA9CEA7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B76A01374
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D01C84B8;
	Fri, 25 Apr 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dhovad+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5cIHjDj/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dhovad+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5cIHjDj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68161B4156
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599595; cv=none; b=oQ28XoXT5n8mz3nKqZ4lx4TyM7X3DBvlXMGhWmh1mTfl0Ct2KvF1qZp4Yeby3rb2adnQH295iq4lpOn3E88U8cWR/d2AipAUgUZ/uvJ3yt2MpQFTdsrtyhsnhm9vl9W5y4hxUTnZf6YmaVLxB6jbgin1BHWyhyA2HQGMB+5/z9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599595; c=relaxed/simple;
	bh=HOrf+jmb4ws1bkU6N7LsjOZgRuMfhlAlBXbmWvZfsXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr1tZUDtVERy0kvAEAKO/lW4lV6gFE6FgcIubxHh49+hwhLOwbcsu2OPwvDe9jkC3XH1Tpk4ypN1w7heoUvx6QFR2kd2PUdtS3vK96TyUeYv1GVIPERYcMEEtr+KPvRTy2Dr0+446wJ+Ozw+fzF358P0+m+hVRYa8VKAO7hUDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dhovad+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5cIHjDj/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dhovad+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5cIHjDj/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF9821170;
	Fri, 25 Apr 2025 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745599591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TsJoaUKg82MLLjLxK0pL7tlpbVY2aOP6RplXCGf28A=;
	b=Dhovad+EjMCf9ri/QW61ZvWa52vqSXO9tLsyMP5gVAMZup7wnoTY1iL36hG7F6O4+CJH1W
	Rk0VBwKanaqKCXSp5ayWAgOdfajhG8z4/vk/VbCGOxA16SSZp12PgBPqx5Nh+GQJks6c/Y
	coURK6elCiX2c6QUhYgOe0L5eLJEL+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745599591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TsJoaUKg82MLLjLxK0pL7tlpbVY2aOP6RplXCGf28A=;
	b=5cIHjDj/eUHKbMXElk641h6VBIkBJZG3qGU2w4ryC0sIpNOwNaziOzEOTtOBGAyZD+d/jL
	diZGatnLuuQY93Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745599591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TsJoaUKg82MLLjLxK0pL7tlpbVY2aOP6RplXCGf28A=;
	b=Dhovad+EjMCf9ri/QW61ZvWa52vqSXO9tLsyMP5gVAMZup7wnoTY1iL36hG7F6O4+CJH1W
	Rk0VBwKanaqKCXSp5ayWAgOdfajhG8z4/vk/VbCGOxA16SSZp12PgBPqx5Nh+GQJks6c/Y
	coURK6elCiX2c6QUhYgOe0L5eLJEL+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745599591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TsJoaUKg82MLLjLxK0pL7tlpbVY2aOP6RplXCGf28A=;
	b=5cIHjDj/eUHKbMXElk641h6VBIkBJZG3qGU2w4ryC0sIpNOwNaziOzEOTtOBGAyZD+d/jL
	diZGatnLuuQY93Dw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 7984A20057; Fri, 25 Apr 2025 18:46:31 +0200 (CEST)
Date: Fri, 25 Apr 2025 18:46:31 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org, 
	Robert Scheck <fedora@robert-scheck.de>, AsciiWolf <mail@asciiwolf.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
 <aAo8q1X882NYUHmk@eldamar.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lzydqdswpg7citn6"
Content-Disposition: inline
In-Reply-To: <aAo8q1X882NYUHmk@eldamar.lan>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--lzydqdswpg7citn6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 03:29:15PM +0200, Salvatore Bonaccorso wrote:
> Hi Michal,
>=20
> On Fri, Apr 11, 2025 at 10:48:44PM +0200, AsciiWolf wrote:
> > Please note that as pointed out in my previous emails, the binary
> > provides seems to be required for console-application component type.
> >=20
> > Daniel
> >=20
> > p=E1 11. 4. 2025 v 22:18 odes=EDlatel AsciiWolf <mail@asciiwolf.com> na=
psal:
> >=20
> > >
> > > Here is the proposed fix. It is validated using appstreamcli validate
> > > and should work without issues.
> > >
> > > --- org.kernel.software.network.ethtool.metainfo.xml_orig
> > > 2025-03-31 00:46:03.000000000 +0200
> > > +++ org.kernel.software.network.ethtool.metainfo.xml    2025-04-11
> > > 22:14:11.634355310 +0200
> > > @@ -1,5 +1,5 @@
> > >  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > > -<component type=3D"desktop">
> > > +<component type=3D"console-application">
> > >    <id>org.kernel.software.network.ethtool</id>
> > >    <metadata_license>MIT</metadata_license>
> > >    <name>ethtool</name>
> > > @@ -11,6 +11,7 @@
> > >    </description>
> > >    <url type=3D"homepage">https://www.kernel.org/pub/software/network=
/ethtool/</url>
> > >    <provides>
> > > +    <binary>ethtool</binary>
> > >      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
> > >    </provides>
> > >  </component>
> > >
> > > Regards,
> > > Daniel Rusek
>=20
> Is there anything else you need from us here? Or are you waiting for
> us for a git am'able patch? If Daniel Rusek prefers to not submit one,
> I can re-iterate with the required changes my proposal=20
> https://lore.kernel.org/netdev/20250411141023.14356-2-carnil@debian.org/
> with the needed changes.

Yes, please. I'll need a formally submitted patch.

Michal

--lzydqdswpg7citn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmgLvGIACgkQ538sG/LR
dpV55Qf9G3xUdIfR8Ch4XKmIflscxYhVafL9nRBVIJahowpFeq3j74fn7oWGt9RK
RrK8OoOs9en5wsGqmrLk7sabQ9zPGJo3fXhoEircP7awl2X3g8BU0AcKEZ1bFThc
EHu4M9s2ZPvRMwigz6Zj8gUgZhBNGoJe6NT7YxqAGpxGdrXGdhi/3+enAi4b6fGJ
lvodZMbwi6I5o/SKphDu83lvHXpmibwhyTVSfRdWaKzxOiEon0qVL0AWa4hEYp2s
y2jIx9Lkd+BaSRyT58iDiQVd5UgoMmBAhGhuceDoMuGozW04JtndO9q94uCBRn77
6pz1ysKvxo15Lg8kQ7aUosVTzFSXLw==
=XS8G
-----END PGP SIGNATURE-----

--lzydqdswpg7citn6--

