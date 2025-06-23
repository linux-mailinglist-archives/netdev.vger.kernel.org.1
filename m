Return-Path: <netdev+bounces-200411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B7AE4E3E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC9716F923
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD92D4B68;
	Mon, 23 Jun 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXagPcDh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0vdI0TFH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rurNs5Ir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+lNGULlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790F1AF0C8
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711334; cv=none; b=MCby5tkBbajmCeBBjpOHO0JdxvqZ/siYVqCHjscyqKIh7Equ99zs91w/8LUapWyRK4orAHCZSijy+ske+CRnuwslqFYgxm63WKBkCtyWbDhRQ96wLeAq74uTQ4kI/qLrO/DO7sTbDaDF8yVJ8+Dpns93Q4m2KHyDKxmp0pmT2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711334; c=relaxed/simple;
	bh=DUhuJX457SlDCZfbJTQDvsk+ugu1GqD7aSe/uczWkco=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lTtvTNAUiVViRgvc6q3wFXe7MbeTdYa3Sq47QkT4b4/PhyAucy9BqennoiPF0B73mbJYu6Brk16YdMf/QRZK/5BzJGktKmJH7GKgF4hPmTe/hd8xj4BiiafT3mn/IjyPmtxIMOwp9KtJQ7lCWWb9Yxm0bQP/m93d/DyYtsiax/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXagPcDh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0vdI0TFH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rurNs5Ir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+lNGULlY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8968521193
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750711330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AVyVU8THF0q2R4VtYxq3FCNYX5F7MxUaMvjbxaYD4qo=;
	b=qXagPcDhGS+tRwf71ORmo/J1m39KmtmFektQFJQjUcECXV/Yf1i2sEd47l3mP/VSFWAnT0
	RaFAJEIl5J9bFY/UOdaaecMb9F2b5rBpYhzMnZy1PMX14lgnJY1fAbtulL2D5zD9uwcCxr
	Kfg24Y7gmOHowqrHkwjcP4c1jAIEHvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750711330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AVyVU8THF0q2R4VtYxq3FCNYX5F7MxUaMvjbxaYD4qo=;
	b=0vdI0TFHDe2zUBVDuhMuzzNVIyWcoQDz1UD8BCmbjPk3gWmZGkU/ia7Hyv/QSwEToLtsPl
	wJQeH0g88M7yVQAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750711329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AVyVU8THF0q2R4VtYxq3FCNYX5F7MxUaMvjbxaYD4qo=;
	b=rurNs5IrKK8P4JzInmBcEXz1hucIlTFMHvP/juVpjEAdCm36ReVD4MfB4zpjE3iI3Xq0Rz
	v077bpeX5Iqx+wX2m3bMmyjq9QnqPQ0a8zpGPOeKFvDnS+QNW00Qmnnw/tJTEfhkL+ghrE
	Uv0UzNVtOVEt5USexTZPRaNxBHquaiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750711329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=AVyVU8THF0q2R4VtYxq3FCNYX5F7MxUaMvjbxaYD4qo=;
	b=+lNGULlY3tC0kENiUbGbyNuWsk2xvh/0ikeN1W7E2XuM1d5F4UkuaWoSkxxNNUScq2sBBi
	eCJgKSp2fcrCiEBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 56FB620057; Mon, 23 Jun 2025 22:42:09 +0200 (CEST)
Date: Mon, 23 Jun 2025 22:42:09 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.15 and 6.14.1 released
Message-ID: <53ar6jo4o3aqufvceluca5gog7ivyksmkufctbjdl44vxg6nrt@5amixo26fjg6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s74bu5lxx5ncbrj7"
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -5.71
X-Spamd-Result: default: False [-5.71 / 50.00];
	BAYES_HAM(-2.81)[99.16%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo]
X-Spam-Level: 


--s74bu5lxx5ncbrj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.15 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.15.tar.xz

Release notes:
	* Feature: support OR-XOR symmetric RSS hash type (-x/-X)
	* Feature: dump registers for hibmcge driver (-d)
	* Feature: configure header-data split threshold (-g/-G)
	* Feature: dump registers for fbnic driver (-d)
	* Feature: JSON output for channels info (-l)
	* Fix: incorrect data in appstream metainfo XML
	* Fix: prevent potential null pointer dereferences
	* Fix: more consistent and better parseable per lane signal info (-d)

A fix only 6.14.1 release is also available. The primary reason is that
6.15 changes part of JSON output of "ethtool -d" introduced in 6.14 in
a backward incompatible way. As it was done for good reasons, 6.14.1 was
released to make it easier for distributions based on 6.14 to adopt this
change as well. This release also adds few minor fixes.

Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.14.1.tar.xz

Release notes:
	* Fix: incorrect data in appstream metainfo XML
	* Fix: prevent potential null pointer dereferences
	* Fix: more consistent and better parseable per lane signal info (-d)

Michal


--s74bu5lxx5ncbrj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhZvBwACgkQ538sG/LR
dpX16AgAgzPg510Dqftb7I8l41+KPHeh3F8KojnLbat7tKBxMc5eUyFEPBI/KYdj
6doee57Q8+dwl8yatrvUl0bVn038IXMpbw4d3NV9HeRFLmLcvZdJT12nujFPIVgt
L4KYAb9rHgT0AoDOAV/tGh1VJP2y36cIfU8mQPIstdV3TexVYC7w/pqkNOxl6vbW
5/qHiTioKZmcoyGIc6xUtQy5cEogGjBrwxhy6qKdv0ARc9768ihlKNNsyxoFNJCB
iGp/bue/m4kdLX31ByHE446SD3giXeyAxFjWS0CJmb84AZNSnXgoUwWea6yDtOGo
Ui/XbzQly973Klwgp+jXH95uAHKkCA==
=ttEF
-----END PGP SIGNATURE-----

--s74bu5lxx5ncbrj7--

