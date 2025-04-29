Return-Path: <netdev+bounces-186857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E833AA1C49
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18674A864B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D925F78C;
	Tue, 29 Apr 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqqiZc0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUPsCEdj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqqiZc0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUPsCEdj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1226ACD
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959095; cv=none; b=ASZAR90sm+zgNQ2egUv11sn8ykb7mT4yU8eNUZ6D/weXBbiCfLYWtke43mmPeBSgQTkjNYj4ojbvrV2Vx44FEztGJ0i300pQP4wgDhcdD1b7tnB6cREcdPKdxgAt624dJxbtOwvEoSF4UPV/FbqneN405NOGR82kQ1ZS64ITJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959095; c=relaxed/simple;
	bh=9eb9+rz2hmmZKsnkZfIGaprzttw+iwUdoFkRCI0XYCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t29cQOU2JrP6lxl3yQLny7zW0HYEjzx6oaGWul5sMILQf+j8eMgEu/CXl06x++4Hj/8WxDhk5Y7C8oqjPeawX9M/KhJthKwTpOb3/ISWIzdunWeuoFcGT/kE9xo3yLOzdhb2fdymK4aT5MRULkk5zUJN33r1lvesiqT5as6FQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqqiZc0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUPsCEdj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqqiZc0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUPsCEdj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6702621902;
	Tue, 29 Apr 2025 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745959092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eb9+rz2hmmZKsnkZfIGaprzttw+iwUdoFkRCI0XYCQ=;
	b=AqqiZc0q+TprIrWXJL71wGBrlw0cssciDNwVJKjRqpbFzlJQQ6j+pu1tSNQLH2vAZ/nozU
	4S6xajPpnkuy7BqbimHR79RTkcsMxDr0g6WzHlUBP/YlSm7s/jwglNlzxx+HttTWfi6oI+
	3g/sFxNTcrLmuAEELn3icgq0dLyZAPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745959092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eb9+rz2hmmZKsnkZfIGaprzttw+iwUdoFkRCI0XYCQ=;
	b=eUPsCEdjL4DAHb+UpP6tlVZ3urY26EeCUcgQFO2/oVWtsS5U9EzoUL81zhX0H2kAarT/d/
	eERYCiEqIFbbb5Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745959092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eb9+rz2hmmZKsnkZfIGaprzttw+iwUdoFkRCI0XYCQ=;
	b=AqqiZc0q+TprIrWXJL71wGBrlw0cssciDNwVJKjRqpbFzlJQQ6j+pu1tSNQLH2vAZ/nozU
	4S6xajPpnkuy7BqbimHR79RTkcsMxDr0g6WzHlUBP/YlSm7s/jwglNlzxx+HttTWfi6oI+
	3g/sFxNTcrLmuAEELn3icgq0dLyZAPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745959092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eb9+rz2hmmZKsnkZfIGaprzttw+iwUdoFkRCI0XYCQ=;
	b=eUPsCEdjL4DAHb+UpP6tlVZ3urY26EeCUcgQFO2/oVWtsS5U9EzoUL81zhX0H2kAarT/d/
	eERYCiEqIFbbb5Bg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 4F57920057; Tue, 29 Apr 2025 22:38:12 +0200 (CEST)
Date: Tue, 29 Apr 2025 22:38:12 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] ethtool: Add support for configuring
 hds-thresh
Message-ID: <ztricyoyiyn4gvuhqlgxfxycq7nxljht7zmiavvsvxgxna4mk4@w45ileelwjc7>
References: <20250408060625.2180330-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k4g75xkxmveabck7"
Content-Disposition: inline
In-Reply-To: <20250408060625.2180330-1-ap420073@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo]
X-Spam-Score: -4.40
X-Spam-Flag: NO


--k4g75xkxmveabck7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 06:06:25AM +0000, Taehee Yoo wrote:
> HDS(Header Data Split) threshold value is used by header-data-split.
> If received packet's length is larger than hds-thresh value,
> header/data of packet will be splited.
>=20
> ethtool -g|--get-ring <interface name> hds-thresh
> ethtool -G|--set-ring <interface name> hds-thresh <0 - MAX>
>=20
> The minimum value is 0, which indicates header/data will be splited
> for all receive packets.
> The maximum value is up to hardware limitation.
>=20
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---

Applied now, thank you.

Michal

--k4g75xkxmveabck7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmgROLAACgkQ538sG/LR
dpUwUgf5AZcqsWNG/7pozgV1RKQL4K5lm8V8WPIoTNgRH6NAiq9Ac/p8lvKZ5Mzg
ejkPE8476FYlQ9/LYU+yCLxxtWHMvkxchCIW/xnR7PuX279ok3RcPzLEdxMrXk32
+a3misz+jP5R9ysTefsph1IpQ7EMOVbrc5dtinJBZIkVhNxWo19rDGHX+uzhhpD+
+hlHo0VYZxNxK1Zn02bjvLGvPMIDRz829VvOFypUbsK0BGW9dQd820BXKFxCTixN
lXMXVQBHKHMFD50qnJqTbLFRr+19cexuQhuJCu6a+WruBAtCEAGAOji16nmg09O9
M8hcYec0RV5NOpjgNra1sleXy/JI8A==
=MCpF
-----END PGP SIGNATURE-----

--k4g75xkxmveabck7--

