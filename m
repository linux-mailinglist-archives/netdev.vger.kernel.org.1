Return-Path: <netdev+bounces-234067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C0C1C1ED
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDED75A2286
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA31434F48F;
	Wed, 29 Oct 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkXzEQdj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHe+rW7N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkXzEQdj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHe+rW7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3D82F12C4
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755209; cv=none; b=OCaR8aQzGh07lxvzTZh6Kaadfxl/hk/j+1avjl6OdunXQcqZhuMyEJZdadXlEzd1zp6YDEk7KKqvLC8W2hUHT1oeollQJYmofuCeKkTUaNEkFxLgUSMCYJvpi/gAkxtYRJP2lF8jThb39QUpMQ26grI4sf6Qf4CMoe3LyVmcbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755209; c=relaxed/simple;
	bh=09FHmRmCfeToATejC2S742AbIILO9GLbTMLFt9N5i9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfXWO5vPQAocnD9fe/+SJY49m8EisNqyMowt0OjIuSyGR+yefvMzovdmY1ile+Rz6rOaCgizPf7zMgKy/erca0Lm17D1BGEjuyo8xkyNqKIaeVR9hzTeRwT+ZRUX7xY4MRzekez53JMmV4FgtY3/tQZnqAkG6rIJb1bJ2LQpSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkXzEQdj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHe+rW7N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkXzEQdj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHe+rW7N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EC4E33F4E;
	Wed, 29 Oct 2025 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761755206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09FHmRmCfeToATejC2S742AbIILO9GLbTMLFt9N5i9Y=;
	b=GkXzEQdjkH4v6SZUADT9HmZWdzn7e1fLd4YUB6syb5OsGz8CDvua76ZHZ7n4bqWt0wtspt
	ln/I6heD7fhDlPtQKFPJ18nvJojSnbv+DXyBgsN1wUzH0E+gCJrKAYVz3hzBiNZSlZeG56
	NtJrAkXrYcqYkG2gy5t4PzkuufqIMwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761755206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09FHmRmCfeToATejC2S742AbIILO9GLbTMLFt9N5i9Y=;
	b=vHe+rW7Nc5r+mtBZr0kbEs9uYeF6qawtab48B44Di44s1guhbPzW/iAtrFRtlEIpRYshog
	58g1Aymp88D2rmDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761755206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09FHmRmCfeToATejC2S742AbIILO9GLbTMLFt9N5i9Y=;
	b=GkXzEQdjkH4v6SZUADT9HmZWdzn7e1fLd4YUB6syb5OsGz8CDvua76ZHZ7n4bqWt0wtspt
	ln/I6heD7fhDlPtQKFPJ18nvJojSnbv+DXyBgsN1wUzH0E+gCJrKAYVz3hzBiNZSlZeG56
	NtJrAkXrYcqYkG2gy5t4PzkuufqIMwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761755206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09FHmRmCfeToATejC2S742AbIILO9GLbTMLFt9N5i9Y=;
	b=vHe+rW7Nc5r+mtBZr0kbEs9uYeF6qawtab48B44Di44s1guhbPzW/iAtrFRtlEIpRYshog
	58g1Aymp88D2rmDA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 0C21620057; Wed, 29 Oct 2025 17:26:46 +0100 (CET)
Date: Wed, 29 Oct 2025 17:26:46 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
 <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
 <ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ej23m7sr4l2p6tsq"
Content-Disposition: inline
In-Reply-To: <ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.89 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.19)[-0.959];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -5.89


--ej23m7sr4l2p6tsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 09:48:00PM GMT, Vadim Fedorenko wrote:
> On 26/10/2025 16:57, Michal Kubecek wrote:
> > On Sat, Oct 04, 2025 at 08:27:15PM GMT, Vadim Fedorenko wrote:
> > > The kernel supports configuring HW time stamping modes via netlink
> > > messages, but previous implementation added support for HW time stamp=
ing
> > > source configuration. Add support to configure TX/RX time stamping.
> > >=20
> > > Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >=20
> > As far as I can see, you only allow one bit to be set in each of
> > ETHTOOL_A_TSCONFIG_TX_TYPES and ETHTOOL_A_TSCONFIG_RX_FILTERS. If only
> > one bit is supposed to be set, why are they passed as bitmaps?
> > (The netlink interface only mirrors what (read-only) ioctl interface
> > did.)
>=20
> Well, yes, it's only 1 bit is supposed to be set. Unfortunately, netlink
> interface was added this way almost a year ago, we cannot change it
> anymore without breaking user-space API.

The netlink interface only mirrors what we already had in struct
ethtool_ts_info (i.e. the ioctl interface). Therefore my question was
not really about this part of kernel API (which is fixed already) but
rather about the ethtool command line syntax.

In other words, what I really want to ask is: Can we be absolutely sure
that it can never possibly happen in the future that we might need to
set more than one bit in a set message?

If the answer is positive, I'm OK with the patch but perhaps we should
document it explicitly in the TSCONFIG_SET description in kernel file
Documentation/networking/ethtool-netlink.rst

Michal

--ej23m7sr4l2p6tsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmkCQD4ACgkQ538sG/LR
dpWP1Af4m3Djr5Uw2iawcvyHhkBCGyeXcFpJRUK9BJ26/45NfgQN3eyHkGs9f/ZU
xhqiV+dskhpj0dDwY+3e0Ow+O2xW34qHHER1pS9BeKT/A8yOqmnoRdO+obug7lcz
4diaeewFTOk5I63iMfw+UqczUKEkvvk3BsGyaNoakiSNwt1Sp1+tJmWE3QaQVp3A
S9OLjza65p5AvMTVgg/TCL4CDdMRje7423LGz2wz/Gty+snbYYBgkt/EBRYvQrTm
Jys9PAdKlGdRQGrLslWaf0/ziMc0WqPlZW7JZlB2ULZHuOmmy6aPDWtgHUQqydhM
BaOfPFWF90Qa36Bdf/fNn6aarXOC
=uVB/
-----END PGP SIGNATURE-----

--ej23m7sr4l2p6tsq--

