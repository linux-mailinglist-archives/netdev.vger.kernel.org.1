Return-Path: <netdev+bounces-128595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1686897A7D8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C927B281A0E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646112C54B;
	Mon, 16 Sep 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/rF+qyG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="maFmZiDg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/rF+qyG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="maFmZiDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB2A1B2
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515498; cv=none; b=iZ3kzW9AZbNCJMfrsRBUsaxBbSaEM8amOSdccgLvIA+uQrL3IHjEnl7iC/PF1KqoKv8cm1GsQCrU/NfrHkFO34NZIze5qN7Y+JcP5RA9B42OZf3cCj6Ab1BLy2zajI5/5taitai5XetDGWohUejnlqn5fJ4uNEVEEl2MiBl7f5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515498; c=relaxed/simple;
	bh=ldvdKVbPEKulkPcKnW7yRyMOEl2WKRTiHV3vC1qwln8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/zigRuehuXj5M5KGZJC1eD+i5kdKBlGY6e2iWmNBPEgzPwTDWRZKgjfPUYALWf2cgbeA5bT0ZHdvnvj9q0hNk7T3/HKBXinLOQJ0+iVVxNJmyXz2I7MZygj2SxUsmDlwlzIRvy7w2rNbOKEKULFurYrT2Poo6xzdtjO/Yh1EG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/rF+qyG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=maFmZiDg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/rF+qyG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=maFmZiDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D18B021A36;
	Mon, 16 Sep 2024 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726515494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldvdKVbPEKulkPcKnW7yRyMOEl2WKRTiHV3vC1qwln8=;
	b=d/rF+qyG7rcrzLKvbmITMn3NTJu7zzRK1UipX86zTWxU8do8Z2aijueXRj6np8t7ycMYg8
	Ryw9a0QSOvTFslrcn4uIpj/zyzg3k1pqPzmUEPDbr2CFyFJJgNeMUi01NQyrIfx5YfVtET
	9JzGmkKSeBivY6Rtd73Koe0vopGg2CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726515494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldvdKVbPEKulkPcKnW7yRyMOEl2WKRTiHV3vC1qwln8=;
	b=maFmZiDgZAu+ed6nn0j32hRVF69juhg5F46pHIARfO4KkZX1X4ZUQDDXw+SMZk1C7NNsbC
	q35RqmEboZMijBCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726515494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldvdKVbPEKulkPcKnW7yRyMOEl2WKRTiHV3vC1qwln8=;
	b=d/rF+qyG7rcrzLKvbmITMn3NTJu7zzRK1UipX86zTWxU8do8Z2aijueXRj6np8t7ycMYg8
	Ryw9a0QSOvTFslrcn4uIpj/zyzg3k1pqPzmUEPDbr2CFyFJJgNeMUi01NQyrIfx5YfVtET
	9JzGmkKSeBivY6Rtd73Koe0vopGg2CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726515494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldvdKVbPEKulkPcKnW7yRyMOEl2WKRTiHV3vC1qwln8=;
	b=maFmZiDgZAu+ed6nn0j32hRVF69juhg5F46pHIARfO4KkZX1X4ZUQDDXw+SMZk1C7NNsbC
	q35RqmEboZMijBCQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id BC63A2012C; Mon, 16 Sep 2024 21:38:14 +0200 (CEST)
Date: Mon, 16 Sep 2024 21:38:14 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <2fsnu2mhk4x5j3bh33pugjfs4e34ys72hmzahdlbctxolfagxj@obbdtitbnax3>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d5tfzsgu27wnqeca"
Content-Disposition: inline
In-Reply-To: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 


--d5tfzsgu27wnqeca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:38:28PM +0300, Vladimir Oltean wrote:
> Several drivers regressed when ethtool --show-rxfh was converted from
> ioctl to netlink. This is because ETHTOOL_GRXRINGS was converted to
> ETHTOOL_MSG_CHANNELS_GET, which is semantically equivalent to
> ETHTOOL_GCHANNELS but different from ETHTOOL_GRXRINGS. Drivers which
> implement ETHTOOL_GRXRINGS do not necessarily implement ETHTOOL_GCHANNELS
> or its netlink equivalent.
>=20
> According to the man page, "A channel is an IRQ and the set of queues
> that can trigger that IRQ.", which is different from the definition of
> a queue/ring. So we shouldn't be attempting to query the # of rings for
> the ioctl variant, but the # of channels for the netlink variant anyway.

I have asked this multiple times but I never got a direct answer: is
this only a formal terminology problem or is there an actual difference
between the two? In particular: is someone aware of an example of
a driver and device where these two counts differ? Or is there a reason
to expect such device either exists or will exist in the future?

(Actually, I seem to remember that the first time I asked, the general
consensus was that combined + rx is indeed the value we need here -
which is what current code does. But it has been few years so I would
have to look it up to be sure.)

If there is no real difference, it would be really unfortunate to have
the same count presented under two different names via two different
interfaces (->get_rxnfc() and ->get_channels() in ethtool_ops) with most
drivers providing both but some only one and some only the other. Which
seems to be the current state and the long term solution should be
cleaning this up.

If there is an actual difference, the long term solution would be
providing the necessary information as part of the
reply to ETHTOOL_MSG_RSS_GET requests - and the sooner we add it, the
better.

Short term, I'm afraid that however ugly this hack is, it's either it or
disabling the netlink handler until we can get the information reliably
=66rom kernel.

Michal

--d5tfzsgu27wnqeca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmboiSIACgkQ538sG/LR
dpXlAQgAlUgiEw6IHlG34yoa3E3TGw42Gfz6WY6xC8MNHQO/jyCQ2FC0ccZyJGlu
RzXJTRiPLHf34SjwcRnupe/cyWqV8ykGPk572s0xUPj1xTenfXUGiuvLWQkceMH6
oRpbIXEZtQane3VV8GFz54aKIt+qeWtAyYU1wQyOvyWykdJ8rCKaUqbhSgVRPt1h
ZJfSc99bSO/xSgwgh0rUh2cZ+fApWfHb7bUtRR3JSejcuRpfuKdjnsk4v2SGBLYH
AP0VbNbFq1j4moVVxzl7gmOme/oFfpPw0lJiBE5xoLr5E0NgADxVvItOzDp/R0WH
9KnJlXXLMtZ+ECaPhOy0cpsU23hXFQ==
=ref+
-----END PGP SIGNATURE-----

--d5tfzsgu27wnqeca--

