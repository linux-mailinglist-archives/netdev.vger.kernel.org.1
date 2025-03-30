Return-Path: <netdev+bounces-178238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AECA75D62
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 01:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CAE3A78C7
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309EF3594D;
	Sun, 30 Mar 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFau/j7q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGdRpqSG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFau/j7q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGdRpqSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0B1876
	for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743378896; cv=none; b=KjeIxgn00Zu7JBx3fSyjMO+t+mYSJdsZf3SybiWOhgrPI4OU2BOpTECq9aBJDjJIy0lVuWKvNttbtc2ECrAmpi+QjbwC3HjPVwf/s7vBwZdg+lqB5AMSudrSjQJBCebOteq2TbgNoOE48UoasyfTmrSUWthTA40b8mxOXxbJEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743378896; c=relaxed/simple;
	bh=i1+xPRxAJ1BBBrpanmduv/HFvh1oRiHZLwNfxylFKPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqIdrGBbmjS3veW3NCiRLtroTf9mfmGR0lDIJwNeatcMi/kS0l84T6XJFBqnMMuT2pBNKLAUihoS8p9g0clUOBMXg055smtSOVc/C6l06mi8OvPTS8tmZW9ku+Si40J6UD+7mHGGDPNR//a8Wy4+cYFeU2Uk/t1jFlsZBd/hqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFau/j7q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGdRpqSG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFau/j7q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGdRpqSG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA7D9211AC;
	Sun, 30 Mar 2025 23:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743378886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41cCpVUX5d8CgpSHk8s1MuzENruoIy/BzA0hsudaFvc=;
	b=JFau/j7qVyWIBh1WcnmaxKHQq2JvKdFWMNrq5uhp7aCzBZmF0pHmBq9hj4aqPu1c6NciiP
	2ZUI2swWdPl2X8sC4jIce7fAmkaspPfHBzLx5ba5GwpwhJ02qy0lK0cOgsVBWTlRJ0lcnh
	6+Fm/5uluBHDfFNgldLH5K6AHt1evEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743378886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41cCpVUX5d8CgpSHk8s1MuzENruoIy/BzA0hsudaFvc=;
	b=TGdRpqSGE+BIOXqxpTeuG4PT+bNkwJM+gq+/rdakbxuJ2IMeQ+frN49oaLliaea84IUQXh
	la08S61YxfumlwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743378886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41cCpVUX5d8CgpSHk8s1MuzENruoIy/BzA0hsudaFvc=;
	b=JFau/j7qVyWIBh1WcnmaxKHQq2JvKdFWMNrq5uhp7aCzBZmF0pHmBq9hj4aqPu1c6NciiP
	2ZUI2swWdPl2X8sC4jIce7fAmkaspPfHBzLx5ba5GwpwhJ02qy0lK0cOgsVBWTlRJ0lcnh
	6+Fm/5uluBHDfFNgldLH5K6AHt1evEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743378886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41cCpVUX5d8CgpSHk8s1MuzENruoIy/BzA0hsudaFvc=;
	b=TGdRpqSGE+BIOXqxpTeuG4PT+bNkwJM+gq+/rdakbxuJ2IMeQ+frN49oaLliaea84IUQXh
	la08S61YxfumlwDg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id C972220057; Mon, 31 Mar 2025 01:54:46 +0200 (CEST)
Date: Mon, 31 Mar 2025 01:54:46 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next 0/6] Symmetric OR-XOR RSS hash
Message-ID: <phc6jxcn3icu5irjl56kvsvsmikjxjec5smmr23bgjrgltw62x@ycr65pfjoiql>
References: <20250303121941.105747-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ysl6jvmfziiljgzv"
Content-Disposition: inline
In-Reply-To: <20250303121941.105747-1-gal@nvidia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.89 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.19)[-0.944];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -5.89
X-Spam-Flag: NO


--ysl6jvmfziiljgzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 02:19:35PM +0200, Gal Pressman wrote:
> Add support for a new type of input_xfrm: Symmetric OR-XOR.
> Symmetric OR-XOR performs hash as follows:
> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PO=
RT)
>=20
> Configuration is done through ethtool -x/X command.
> Also performed some misc cleanups for things I've noticed while touching
> the area, see individual patches for information.
>=20
> Kernel submission was merged:
> https://lore.kernel.org/netdev/20250224174416.499070-1-gal@nvidia.com/
>=20
> Thanks,
> Gal
>=20
> Gal Pressman (6):
>   update UAPI header copies
>   Print unknown RSS hash function value when encountered
>   Use RXH_XFRM_NO_CHANGE instead of hard-coded value
>   Move input_xfrm outside of hfunc loop
>   Print unknown input_xfrm values when encountered
>   Symmetric OR-XOR RSS hash

Hello,

I applied patches 2-5 to master (they do not depend on anything not
present in kernel 6.14) and 1 and 6 to next (to be merged after 6.14
release of ethtool).

Michal

--ysl6jvmfziiljgzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmfp2cEACgkQ538sG/LR
dpUYFgf9GvJTN4BxLuuJfWZ4atxJQa8V3IKNVvdqzKPAsiW0KCODibDBxZblXZbG
6C6qr2tw0ST/6AgkbdBLj4fRbfo4wWmYwvgLg5O9Z1HeabG1txCdAwDp5nqPHS1S
cOoY1RnYTn2GHrPAOFR6svjTvK+J2pDtlNAqIruhVR6RH8CCW30+Lkw4Xok66b+L
rxsBhqiyuIH4IkADyfreO/O6aKAewsx77vHiMF1NOfsNqHk7Q/NVBrAoQpqPqbcH
oXCKVD7L6N6eQ+Zvguvv4PF4WxEDnx05Wf5JFD5fc84jxuKzZR8Al67ME5B3JE4y
Mtwr9eZ5/leDS5GRvw6GS192PqKx2Q==
=eycs
-----END PGP SIGNATURE-----

--ysl6jvmfziiljgzv--

