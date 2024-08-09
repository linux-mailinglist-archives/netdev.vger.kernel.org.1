Return-Path: <netdev+bounces-117315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530794D90A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED101F21B8A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2316CD33;
	Fri,  9 Aug 2024 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSxbGuI1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLAZqqZr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSxbGuI1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLAZqqZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C9168490
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245265; cv=none; b=WRRXCeKwdyXSlznpZ6cfDlo7qVHE13Ssc8bgPt/qed8OtSaBYfX5zkOk3pWtRAfb9hAUOD2+1LPDqFFk37DLotmocyBKONhfjD5zqV/8ak4xdwMRjHmdeymQIkv5m6S+YuD/fR2Mdult/xiB7dQORDz4l1aYR8h1jGUdnqRMlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245265; c=relaxed/simple;
	bh=LrjG9reQp3HclaMoPJpFXKdIfMfc7DjCQFofpsuoJqE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NY85L6VQRbtGE111rGyAvPBE15CntREUJB4prrwm0iV0/M21+6Q2u1bUYxJ1IKeguLXnlB2irgHi069d0gg5gYi18/rjdfrMB/GzQHhKF6AeAs7tQ6jMPtQ7Or5BVZmWwehUtMOGpWIVa7Q8EoBwRXRLTC7KXar0BsIx3HPyMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSxbGuI1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLAZqqZr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSxbGuI1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLAZqqZr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB8122206A
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723245261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XzLfRnKlsDXfYjpJSNFKIyyIjUKJidA2RNRClC6xTL4=;
	b=WSxbGuI1p8sQed5FLjtWG17cKulbDta1WBJWfA14j9PazGFgVsPGYvmmzoz9QHR003fNWO
	WuhkdI78sj2Blqf/+KoDWNTICY8FDfEMXXwbGJxBEFm0gcqROsQPTfW7x2VGEed0ASfubO
	4PksPqK0+SDD1NyCdLW7t7lTJSsE1z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723245261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XzLfRnKlsDXfYjpJSNFKIyyIjUKJidA2RNRClC6xTL4=;
	b=cLAZqqZrg9792zfqobj1XsdO/gohwPl5qNyhBRbOcIrQiKieoY92xYimUifoaqceO+Y4Rm
	OGiGgFMpMR/oJXAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723245261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XzLfRnKlsDXfYjpJSNFKIyyIjUKJidA2RNRClC6xTL4=;
	b=WSxbGuI1p8sQed5FLjtWG17cKulbDta1WBJWfA14j9PazGFgVsPGYvmmzoz9QHR003fNWO
	WuhkdI78sj2Blqf/+KoDWNTICY8FDfEMXXwbGJxBEFm0gcqROsQPTfW7x2VGEed0ASfubO
	4PksPqK0+SDD1NyCdLW7t7lTJSsE1z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723245261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=XzLfRnKlsDXfYjpJSNFKIyyIjUKJidA2RNRClC6xTL4=;
	b=cLAZqqZrg9792zfqobj1XsdO/gohwPl5qNyhBRbOcIrQiKieoY92xYimUifoaqceO+Y4Rm
	OGiGgFMpMR/oJXAA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 8FF012012C; Sat, 10 Aug 2024 01:14:21 +0200 (CEST)
Date: Sat, 10 Aug 2024 01:14:21 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.10 released
Message-ID: <ssn37ocuhjyx3k5xoq53uvb3voo2qxnwvuwgephb4cc5lbw5ei@5fkqwsfdzlcu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6dfhsvx2cnjvlfxj"
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-2.90 / 50.00];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.90


--6dfhsvx2cnjvlfxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.10 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.10.tar.xz

Release notes:
	* Feature: suport for PoE in PSE (--show-pse and --set-pse)
	* Feature: add statistics support to tsinfo (-T)
	* Feature: add JSON output to base command (no option)
	* Feature: add JSON output to EEE info (--show-eee)
	* Fix: qsfp: better handling on page 03h read failure (-m)
	* Fix: handle zero arguments for module eeprom dump (-m)
	* Fix: check for missing arguments in do_srxfh() (-X)
	* Misc: compiler warnings in "make check"
	* Misc: more descriptive error when JSON output is not available

Michal

--6dfhsvx2cnjvlfxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAma2osgACgkQ538sG/LR
dpWFzgf8COZQgjHaJXW0m4ciX1FsUuRB0twFrzl75zALO0vb6WfbHTuxuhFDSdHc
77qaf31deF91qaL4bIQ6051MzfY1XLuoMe03tThL1srr4eFN9z6TX+JNSupmVCsP
keisq02LTUrfkG42zgMAzo9Pq4WE6T9K/Y7OD0qYGX1Qugc14XllQ7AQaBzE66p1
EgD6PN68DNy3p7NYM+5TAimbSUStUF3aM6hw3t3oCHFXUun5WpLGJi7FVDeUgvDH
Jy+K3a42pikYQGnTzZ/vMvvN94+2RHy3+pBvX1WcI9e7xejBfXqxATzntH3IPPZm
KHAa2kU7ZlQypQxb0yDZVMAfao+X9Q==
=iG4h
-----END PGP SIGNATURE-----

--6dfhsvx2cnjvlfxj--

