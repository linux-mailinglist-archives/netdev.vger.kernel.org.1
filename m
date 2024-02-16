Return-Path: <netdev+bounces-72370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B172857C33
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAE1C20E0B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4859169;
	Fri, 16 Feb 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2opTShBd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKgh3/lu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2opTShBd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKgh3/lu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAE54F9F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084765; cv=none; b=JdJ4HrxOWshnqI7Kx3qYglgdV18Z5jwhyzV30LI4hQp2YMxASpi2CIdGj5tJjaj1rEpt595DeuiGQ4fz/LlrST0cjdKht6PXajGv0tqLoCc+3FVw6YalpryBXIh8T2Bw+7QDmJjDK2Df9f/ehQshsFa+9Cp2klhGMa/AkAyjMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084765; c=relaxed/simple;
	bh=GP9sL2QY97HnexsvD0a+MYkcwox3XX3dlxHzzhGXi+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eko/iRpX71TRMbc0xE/F9avwlRAKQXm7UT+zlhl7JRpJVd4FsM4Z3jaRAD8A1vuaaKk39+IRpntQdSA7jPSekhTep65RL+WrkICjHPFKiQk8dEEwrt31zDDbd9h3PSk9SdLjYL7bmsK4s0UTnumWyIHWbBpANB9qxmH0rTi7SjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2opTShBd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKgh3/lu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2opTShBd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bKgh3/lu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8916422265;
	Fri, 16 Feb 2024 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708084761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6gVisu1Un75wrWyYqgkRyhwWHcWoQJZogJFmcssMTU=;
	b=2opTShBd8NV950rHHawrDauId7XxYDdbLfptu0xx05Qdo0DTuZ9wwUT1SDh5T22niA5o4L
	snu3nY146lar3xLdks2wCEP4/8aaC26Ka5RRbXCmTU9LuXLc9wNrkjdctPh+EWC79McKeA
	IVW5qsTKeynubrNeqmok7XFJHNfAj88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708084761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6gVisu1Un75wrWyYqgkRyhwWHcWoQJZogJFmcssMTU=;
	b=bKgh3/luVlcPlatE/6OP4w7rrrRpP8Iu7HqFyWOF4+dEj4fUDchQ751P+ORwVw0FHhO9Ws
	vxoux85SZXH2B4Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708084761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6gVisu1Un75wrWyYqgkRyhwWHcWoQJZogJFmcssMTU=;
	b=2opTShBd8NV950rHHawrDauId7XxYDdbLfptu0xx05Qdo0DTuZ9wwUT1SDh5T22niA5o4L
	snu3nY146lar3xLdks2wCEP4/8aaC26Ka5RRbXCmTU9LuXLc9wNrkjdctPh+EWC79McKeA
	IVW5qsTKeynubrNeqmok7XFJHNfAj88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708084761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6gVisu1Un75wrWyYqgkRyhwWHcWoQJZogJFmcssMTU=;
	b=bKgh3/luVlcPlatE/6OP4w7rrrRpP8Iu7HqFyWOF4+dEj4fUDchQ751P+ORwVw0FHhO9Ws
	vxoux85SZXH2B4Aw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 76F5F20147; Fri, 16 Feb 2024 12:59:21 +0100 (CET)
Date: Fri, 16 Feb 2024 12:59:21 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Question on ethtool strategy wrt legacy ioctl
Message-ID: <20240216115921.incijidup6rpeyre@lion.mk-sys.cz>
References: <77a48e2f-ddb1-44d8-8e3f-5bc5cb015e9f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c63bvxbpyjduzlml"
Content-Disposition: inline
In-Reply-To: <77a48e2f-ddb1-44d8-8e3f-5bc5cb015e9f@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.40
X-Spamd-Result: default: False [-6.40 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 SIGNED_PGP(-2.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO


--c63bvxbpyjduzlml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:53:26AM +0100, Heiner Kallweit wrote:
> When working on ethtool functionality on both sides, userspace and
> kernel, the following questions came to my mind:
>=20
> - Is there any good reason why somebody would set CONFIG_ETHTOOL_NETLINK =
=3D n ?
>   Or can this config option be removed?

I can imagine systems where there is no use for ethtool interface as
such so it IMHO makes sense to make the whole interface optional.
Originally I wanted to do this when the netlink interface was introduced
but it would require some changes outside the netlink code (there are
some hardwired calls into ethtool code in parts of kernel where you
wouldn't exactly expect them) so it fell into the "one day" category.
It would be nice to make the ioctl part optional but until netlink
supports all features provided by ioctl, it would make little practical
sense.

> - If for a certain ethtool functionality ioctl and netlink is
> supported, can the ioctl part be removed more sooner than later? Or is
> there any scenario where netlink can't be used?
>=20
> - Do we have to support the case that a user wants to use an old
> ethtool w/o netlink support with a new kernel? Or is it acceptable to
> urge such users to upgrade their userspace ethtool?

We probably could if ethtool were the only userspace utility using the
interface which is not the case. There are other pieces of software
using it, some known (I'm sure wicked does and I assume so does
NetworkManager) but also some unknown and perhaps some which are not
public at all.

One of the reasons why I believe there are privately developed utilities
used only within certain environments is that while inspecting the
interface, I realized that for some parts of the ioctl interface, there
were few years between introducing the kernel side and the ethtool side
- which only makes sense if those who introduced it needed the interface
for their own software and didn't actually care about ethtool support.
And IIRC there is already a feature in the netlink interface which still
lacks the ethtool counterpart.

So I'm afraid removing ioctl support for parts of the interface that are
fully supported via netlink would be seen as "breaking the userspace".

>   Remark: I see there's certain functionality which is supported via
>   netlink only and doesn't have an ioctl fallback.

Yes, the general policy is that no new features should be added to the
ioctl interface, with the exception of trivial extensions like support
for new link modes.

Michal

--c63bvxbpyjduzlml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXPThMACgkQ538sG/LR
dpWYgggAo6AL4eoQF6qgt762cz1JuhPRQeg2cgj1KkI8znW9pmYwK5cMtsc94QVH
D7NmYYRVosGZ2m10UFVNN0QIyBwtXdqDt8Q+X7uCYpIJkbCL69EpVN0AaKK94UK4
MFT5ksKzZa0rs6gRy95x8sGLhxOva43PGBAnu+XnkoN1hCF2aILIXjqtbUcrMAkD
Dgt0LdwOWKSMa5dW+bgMY8VtPC/lvby/C3dY5lfgFQHASbRJLvsXUh7vugKJGVrI
eziNte0x4QwoWq4/YzhjZNnPwxND/Vei8LeJDSgnz4PSDdO6zJLxm1DThGDSqfG1
T2ktwMQfsNQOKKvGpH2znY1W5Tt7oQ==
=1E/s
-----END PGP SIGNATURE-----

--c63bvxbpyjduzlml--

