Return-Path: <netdev+bounces-133310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E5995941
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FE8286D09
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C82139A8;
	Tue,  8 Oct 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRnU61Fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8iHOS80F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRnU61Fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8iHOS80F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2217C7BE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422624; cv=none; b=p5wrVFHVe0UysULNNVyCsecHA6wnv4Br7SYPSyANGsgz96GIu1GALOAtJSMjMU1Porz3DTuudAhnmwI+C8zp8hxGNMckcIeJQqQGhqwFNbQSu1Q6RaDalPgcMJ3eNB0NMSOGLcXeOx/y0eoOMpmqQ0GaGlMQ2s7NO3eWUZldWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422624; c=relaxed/simple;
	bh=I3jaGqUedkB0ZRsshh9vT5HSHLZzERcs4Qlx3F6UkA8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b2S5gMkDLinjqP0UVS9hkE2xB0VpeDkuc3WFXbqaQn5eMfaPBrxaTvC0GqmBSpl0UPANVHbhyqqi4Z8I5ny+0QegI0+fIHOdSIaqLeP4ymvBaC1UpluPh19LmqU45tvkqakEWCHQ6I/dVnnvVOQMlapi4RGld+CE/H9yzSetJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRnU61Fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8iHOS80F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRnU61Fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8iHOS80F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B68721DD6
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728422621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FI04j7ELUrYHWzezTal0BC2GouZN6kvb5HihhiOc8cs=;
	b=oRnU61FoZ9e4ZO5BcD38duHqJeP3xXG11ooBZcpbRawumOzta8IorC8tTXSLlcXOBnYcB5
	/7gFjOLJvK7vnv/70/79H+uV3OoRndfQw8rKgtwTee+L8XxFVg3AKcJCaxxASl6yVnEtzb
	HLQ4wVFvkaDZWn0niRBB/OQV57M5gpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728422621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FI04j7ELUrYHWzezTal0BC2GouZN6kvb5HihhiOc8cs=;
	b=8iHOS80FwXLYPtKomi2YcYp88PoMHvJ89A8LcX5c4rFI2qPqMC+frOf3uNd8XOxKlvElt8
	qnBHvW3UQFa00VCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728422621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FI04j7ELUrYHWzezTal0BC2GouZN6kvb5HihhiOc8cs=;
	b=oRnU61FoZ9e4ZO5BcD38duHqJeP3xXG11ooBZcpbRawumOzta8IorC8tTXSLlcXOBnYcB5
	/7gFjOLJvK7vnv/70/79H+uV3OoRndfQw8rKgtwTee+L8XxFVg3AKcJCaxxASl6yVnEtzb
	HLQ4wVFvkaDZWn0niRBB/OQV57M5gpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728422621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=FI04j7ELUrYHWzezTal0BC2GouZN6kvb5HihhiOc8cs=;
	b=8iHOS80FwXLYPtKomi2YcYp88PoMHvJ89A8LcX5c4rFI2qPqMC+frOf3uNd8XOxKlvElt8
	qnBHvW3UQFa00VCg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id E9A9D2012C; Tue,  8 Oct 2024 23:23:40 +0200 (CEST)
Date: Tue, 8 Oct 2024 23:23:40 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: netdev@vger.kernel.org
Subject: ethtool 6.11 released
Message-ID: <zos7ckvywjdfqbfgfrpxsugesttcp3drvko7wd644v2aglcd6q@qlv3vxhl3cd5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="stzx6jovq4os43es"
Content-Disposition: inline
X-Spam-Score: -5.83
X-Spamd-Result: default: False [-5.83 / 50.00];
	BAYES_HAM(-2.97)[99.89%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.16)[-0.778];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~]
X-Spam-Flag: NO
X-Spam-Level: 


--stzx6jovq4os43es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

ethtool 6.11 has been released.

Home page: https://www.kernel.org/pub/software/network/ethtool/
Download link:
https://www.kernel.org/pub/software/network/ethtool/ethtool-6.11.tar.xz

Release notes:
	* Feature: cmis: print active and inactive firmware versions
	* Feature: flash transceiver module firmware (--flash-module-firmware)
	* Feature: add T1BRR 10Mb/s mode to link mode tables
	* Feature: support for disabling netlink from command line
	* Fix: fix lanes parameter format specifier
	* Fix: add missing clause 33 PSE manual description
	* Fix: qsf: Better handling of Page A2h netlink read failure
	* Fix: rss: retrieve ring count using ETHTOOL_GRXRINGS ioctl (-x)
	* Misc: man page formatting fix

Michal

--stzx6jovq4os43es
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmcFotcACgkQ538sG/LR
dpVeJwf9G7MdAKePNqsAyXzmEQBAgIpkMp1KBg304SBAWHGxrM2UQ1lQw6qbFYd2
/vzhncKQU3KRF1PIHzKJLMa4wtpOstZUERJgp1HUq4qqxNwTHSUHyst3W0hi811+
FMRK2tHdLvuqOhRDKJ1Z80VAzqX32ClHsV+/hJe+WDuyfdH9XVAXMdoqDhn9/7eh
Rlf7kExBDtI2UMYZ+uR1dLNoIqx7ug2r2F4ltFqrjdqFRji2K1kwxYKCcIj7T4ji
94p+Z3C3TBwsEr+V0S/qige2XtbXufEfiuzdkYMnE/CVp353Bi8NA+GuTkM3hE3J
WWQD3FGjKH3bS0xJGeXQ0uHsWuZt4Q==
=d4Ll
-----END PGP SIGNATURE-----

--stzx6jovq4os43es--

