Return-Path: <netdev+bounces-282093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIslB3Uv8WleeQEAu9opvQ
	(envelope-from <netdev+bounces-282093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883648C762
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C2B1304B806
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FE33F39C;
	Tue, 28 Apr 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hm9VUuL3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FG99vhsy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZ/PSiOV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlG2aHde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DF4A35
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414001; cv=none; b=oorQcSyumBj73YtRFcIEoCAGdQR9SIUWSt6CrfgtxZZKfcSn3Xu2Ebl5vxPwLDnKbRzsYXJvRbr9JNj2ICVcWP7tluMfGLMvW4YWr2puD2P8f2mOf5hrwrZ0K4YbhvKgKzn/O/Q7X7ZuHuohYg6K1toZnAxH0NawpA1nmsR508s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414001; c=relaxed/simple;
	bh=2IuxcY+vIUAgA0fLg0WsjBf/X5PxJDg6dUj8cjsPDBk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQIc9MBCLCCH3dTQsfKpEtQ+tU2fRY/KpwlvOZ9lp7QMWrh7yLIMKedgY74LpGKraTAAtwcjCXWa8Jx2YCgrjOMQptVT+F/n1r4qPI0PhPjDKgiYiXEEdCdVyF8yTIiz/XzSzyhCmPthVFFu5j8WBn4oshYXC5Sk4qZxBE1xauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hm9VUuL3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FG99vhsy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZ/PSiOV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hlG2aHde; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.149.248.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE5586A880
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777413998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KJBZW8I5qwRVAw2ZkQOLgBZd4X10fgfHvd6AShHq1XU=;
	b=Hm9VUuL3J3VUtJjuoR5xtSn1CC/RBqOcHcS7t+2GGBbFB7/ygXsHTa0rJUV0xRpr9iRTLc
	qBpK58a8OTjur+xDT8H4an9Ys2btCt8V9msH525nPjuNRtpl+4SZgSt8NrUgrJNMl+ZMZC
	ATNmsHl81CW5eWwG+HOV7IzuNQ8dujU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777413998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KJBZW8I5qwRVAw2ZkQOLgBZd4X10fgfHvd6AShHq1XU=;
	b=FG99vhsy2d4FBaqr92Bj9k0XkLjIli2S7rj3eB2o9QnpQ0q3VyglVEx4vwcO5x4msYjrBc
	9vdT+6cfroOEsMAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777413997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KJBZW8I5qwRVAw2ZkQOLgBZd4X10fgfHvd6AShHq1XU=;
	b=oZ/PSiOV8ExokKYxZqV+2MxAvBOMYLVjNClw8caftgyg/kpN7pgbEZyWz+HX/9psUxa95y
	BTBKuIygi+9CnO8FCUrLBTV+0UESBMHwr7NrxiGMRv4Nbu/LADjll+taTP6JehvvWLsguJ
	FFver3TOvtFGSkcWLqgrdHnK2j70x5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777413997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=KJBZW8I5qwRVAw2ZkQOLgBZd4X10fgfHvd6AShHq1XU=;
	b=hlG2aHdeWZ7TlKntlxm1wFo9DRfevlE7qbNqFJt7n2K/XA5E/FyGjAE1WaH0S5XqE2mrK8
	/Yk35VC2po3ovgBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id CE1F12009B; Wed, 29 Apr 2026 00:06:37 +0200 (CEST)
Date: Wed, 29 Apr 2026 00:06:37 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 7.0 released
Message-ID: <7nbmsgjoc5evwbjwiaec4uv3xo4y3itwnuxijk3aprfflidk7z@ilo6gbbypalj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyemvsxhbmlo4xko"
Content-Disposition: inline
X-Spam-Score: -5.72
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7883648C762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-282093-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--oyemvsxhbmlo4xko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 7.0 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-7.0.tar.xz

Release notes:
	* Feature: support MSE display (--show-mse)
	* Feature: add 2 new link_ext_state names
	* Fix: fix index calculation in ixgbe register dump (-d)
	* Fix: cmis wavelength tolerance output (-m)
	* Fix: duplicate sfpid Active Cu compliance output (-m)

Michal

--oyemvsxhbmlo4xko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmnxL2gACgkQ538sG/LR
dpUHqAf8Cb1x6ugN7exgHOr8gPNeBAaNgaCYJLK1GHehBj+MJG4fwGyh69+fNQFV
lf/I5s7VhdZbCopNHXL/9x6R29uTP9oR0jiHHxOQzgxxylx5BwIa3gvA6almtIcs
S+QVbx5pGrJ4L+V1RUgRN3QYwBvmXBxmXMYoU5qx0DkVF5MFBrxtImwYgb9Y0zoe
BPxEnC5e0kgGhfjr/pniOA1XU6zyDhW0wOmw93fq83lEzpiaEYxNukppAY/U41ga
eUavJZtLjhhzXQQu+vLXwGEkxgrtgzXshED0vlD86NoTVjiLi21/eaN0++U5z78s
J9wvAbt0mwCt4DOUfo5zwIdVN7R0MA==
=OEL3
-----END PGP SIGNATURE-----

--oyemvsxhbmlo4xko--

