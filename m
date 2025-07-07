Return-Path: <netdev+bounces-204666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB1AFBAAC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D58D7A9360
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46F21C9EA;
	Mon,  7 Jul 2025 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zeF/cp7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyHDB5Y+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zeF/cp7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyHDB5Y+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D42264C6
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913104; cv=none; b=gdqaVqoI2qvX98kGFKEw/2E78l/dj8WuGANd3fHItrUNuMd4QKE0wqFiOTlFQXpOF+1mGB3rr8Y0/oBF/+sHzJSIQMv/GSVkAaCH9XMfCIAzCcghgklXlpuX3xvjUBaeb9Y1HEhLPYQ9+XDI3lcRFtj2E3h25tyOSAYN/n1Ula0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913104; c=relaxed/simple;
	bh=tJ3W2FGEgUNZAQ+g4pK8UqDdKq8uofcqVO4QGbsrejY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGHyadRS1MA2kW+8mCOHXnt9WdDqfXR1FWLh/3aFbsXHwWq4GaT0R+9M3+v47KrkA1CSOvmWnEiWXjMm8Ewy2RVesbmufrrb6SZeGXf5DN45RMUPkzmeHyEz5NKgrBEL4nXP5mGDVHR8dB3ahlUsMOfzm/sqkRYwv8RvbeW6oFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zeF/cp7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyHDB5Y+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zeF/cp7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyHDB5Y+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 434B62115F;
	Mon,  7 Jul 2025 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751913101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ3W2FGEgUNZAQ+g4pK8UqDdKq8uofcqVO4QGbsrejY=;
	b=zeF/cp7ZoF2nr3kicRO9AzTugHnxQKuTqQQEmUG+0cT/khe9z5OgEPKatOyUWzQ1KZM4LE
	V1u8DoC1jkAoDlLUnOA5MnkBHfioc0t+5q0l1tBANsn3zb4Rc5E1xKxQVOnUQh+bkhvj10
	EXTZi/ZX/imk/cMg0D7HYbzg50MJZ7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751913101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ3W2FGEgUNZAQ+g4pK8UqDdKq8uofcqVO4QGbsrejY=;
	b=CyHDB5Y+VEp8N+R2EfDs+4Icp5tuBWu9Sj4Xn6eN53dAzomuAKO6glbRZH7rig/Q7AQetT
	ca4oxcxsnxI5dEBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751913101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ3W2FGEgUNZAQ+g4pK8UqDdKq8uofcqVO4QGbsrejY=;
	b=zeF/cp7ZoF2nr3kicRO9AzTugHnxQKuTqQQEmUG+0cT/khe9z5OgEPKatOyUWzQ1KZM4LE
	V1u8DoC1jkAoDlLUnOA5MnkBHfioc0t+5q0l1tBANsn3zb4Rc5E1xKxQVOnUQh+bkhvj10
	EXTZi/ZX/imk/cMg0D7HYbzg50MJZ7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751913101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ3W2FGEgUNZAQ+g4pK8UqDdKq8uofcqVO4QGbsrejY=;
	b=CyHDB5Y+VEp8N+R2EfDs+4Icp5tuBWu9Sj4Xn6eN53dAzomuAKO6glbRZH7rig/Q7AQetT
	ca4oxcxsnxI5dEBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 186DD20057; Mon, 07 Jul 2025 20:31:41 +0200 (CEST)
Date: Mon, 7 Jul 2025 20:31:41 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Kyle Swenson <kyle.swenson@est.tech>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool-next 2/2] ethtool: pse-pd: Add PSE priority and
 event monitoring support
Message-ID: <4bwqn7klcstlyiaig7ceonzl6om3mtn454q3tyauyjjusyt6xh@dlcz64sbxdvl>
References: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
 <20250620-b4-feature_poe_pw_budget-v1-2-0bdb7d2b9c8f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jisrgrp2ty56pzqo"
Content-Disposition: inline
In-Reply-To: <20250620-b4-feature_poe_pw_budget-v1-2-0bdb7d2b9c8f@bootlin.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.90


--jisrgrp2ty56pzqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 02:33:07PM GMT, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Add support for PSE (Power Sourcing Equipment) priority management and
> event monitoring capabilities:
>=20
> - Add priority configuration parameter (prio) for port priority management
> - Display power domain index, maximum priority, and current priority
> - Add PSE event monitoring support in ethtool monitor command
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

This patch adds two different features which do not seem to be related
so closely that they would have to be added in one patch. Could you
please split it into two separate patches?

Michal=20

--jisrgrp2ty56pzqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhsEokACgkQ538sG/LR
dpWCGwf8CkTtL2nv5F64hNcocItrYSmh9XvU+YuiYUQslvDkRZ2q5rXVEdn3od49
RaTj+AHiDWUo18N8gyHUAX84ZUxkJW47F/WFRnMv0dryYPFYLeEKxmgKuJqN6qmt
u48UEONzdcqFbUL2vUn5BjhXcwRqAONnQCwjKU4hEeDR3aTlRJwCfrCLcLX2uTSU
rr5jVgf+8+bZvMLbGnTz1lXiugA1M55xgHIXRQSBmc1aeoB4OVOehBEKBEDmfipm
y6Fyo0M4aYA4i2G1WN/qe+QFsy65hvEA4xdhQpmf+avB5wISew2MjKnAV5IPcYtK
nUXDtRy8bdwH/AtZHGxkkbww90Kdpw==
=FZLI
-----END PGP SIGNATURE-----

--jisrgrp2ty56pzqo--

