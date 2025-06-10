Return-Path: <netdev+bounces-196357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6ACAD45F8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE70189CBAC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E82285412;
	Tue, 10 Jun 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sU5iJmCF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZHotO4dB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pegl4D8B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wGOlQeC4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68791242D7D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594443; cv=none; b=CDvIBFbtEe3RiHD4okAgkwsF6eRtuz4Aq0SSt/F/1fk4Sef4QoXWMwIyDcqD7U/UiUCqtQER49dcUpU60ONwcdvdlSuhSvJZ3BT/VvQBH6zSYDLmmvsaobcH9TRsPwXoS4nVeXRwf7p0WAFQAaL/mlzbI1lai/izHQh7T9QV/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594443; c=relaxed/simple;
	bh=KSiSwDcBLV4/buiMXT8DIYQSJ6T3NhPFmlAh29dHlaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXdN6gwu1QVtyGqJ5zuqEuBGRUuvSWkTfP7dVYJddx2XxqdnHSnDE7bhqOJb/TyCj1Lp2Pm1T/BTG0pSgTvHa/qLsoc5+rgwu7UdWWm547GGex8tHplJvtVjI4v+VI3xoDGQFf2MMfaSGo28AF8HzprOO2noHrP8ZIA0fb1XU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sU5iJmCF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZHotO4dB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pegl4D8B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wGOlQeC4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB3921A0F;
	Tue, 10 Jun 2025 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749594439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69aLbGqEZievt9dMQWfUTRxvAIIDhaDlSTfLyYY33Pw=;
	b=sU5iJmCFGYijTVXzmbY/gDKpCYOkdzxh1LzA0QUAX9O8wCantnRW0mBoZPGr1aE/iIZMsn
	GDNJjvJDAq4QXFmm3xWV00VDVeVtk67pW4TTIGUYWAcF3OvnmhfVG7v3X+x0il6TdLR9fv
	9YfhQoFr1QbsI7P2YeuiDSetv1ovk+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749594439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69aLbGqEZievt9dMQWfUTRxvAIIDhaDlSTfLyYY33Pw=;
	b=ZHotO4dBhp7mK7zvEqg0LehC4ri3UZonRLdC+bAvCtukEeNpZdAN+FUsooG03J2DqBUQQ9
	IJVVUEUjh2iVVYCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749594438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69aLbGqEZievt9dMQWfUTRxvAIIDhaDlSTfLyYY33Pw=;
	b=pegl4D8B5QSwEV1OEkPZQwBzRxXpYv4ZzsGpoz1q0NWM7UIIDQhqtvGVMqB50PJiLqaWTl
	SEmMIjNOzOLpedWbqRcLPhBnpQBefRgcKn0yJdU1RI+sM6/IdfVbElbOTek263kgU+SAd2
	8LlyZ61hvmSlyuPVQlUFndnO4yXDMeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749594438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69aLbGqEZievt9dMQWfUTRxvAIIDhaDlSTfLyYY33Pw=;
	b=wGOlQeC456a95J7fIHmvwKc7csvMhXIfUhWnWYijfm2qSjLxpIwj6LjUCWklTwGhMkjpHh
	+cncCpO7xyrZ6OCg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 19BAA20057; Wed, 11 Jun 2025 00:27:18 +0200 (CEST)
Date: Wed, 11 Jun 2025 00:27:18 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: ant.v.moryakov@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] common: fix potential NULL dereference in
 print_rss_hkey()
Message-ID: <x27vanog6blm5ckllzbfe7lh4yevvernbjwwcotyq5rikpa6ac@p7akbzr4p23m>
References: <20250518130828.968381-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3egm3xotjuzckuu"
Content-Disposition: inline
In-Reply-To: <20250518130828.968381-1-ant.v.moryakov@gmail.com>
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.90


--t3egm3xotjuzckuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dne Sun, May 18, 2025 at 04:08:28PM GMT, ant.v.moryakov@gmail.com napsal:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
>=20
>=20
> Static analyzer (Svace) reported a possible null pointer dereference
> in print_rss_hkey(). Specifically, when the 'hkey' pointer is NULL,
> the function continues execution after printing an error message,
> leading to dereferencing hkey[i].
>=20
> This patch adds an early return after the NULL check to prevent
> execution from continuing in such cases.
>=20
> This resolves:
> DEREF_AFTER_NULL: common.c:209
>=20
> Found by Svace static analysis tool.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> ---

For the record, I believe the null pointer dereference is not actually
possible with current ethtool code. As far as I can see, in the ioctl
path hkey always points inside a block returned by calloc() so that it
cannot actually be null (we bail out immediately if that calloc() call
fails). In the netlink path hkey can only be null if ETHTOOL_A_RSS_HKEY
attribute is not present in the message in which case hkey_size will be
zero and the for cycle body is not executed at all.

That being said, I'll accept the patch as a safety precaution in case
the calling code changes later. But I wanted to point this out for
future reference as this kind of commits tends to come back later and
haunt us in the form of CVEs.

Michal

>  common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/common.c b/common.c
> index 1ba27e7..35ec36d 100644
> --- a/common.c
> +++ b/common.c
> @@ -233,8 +233,10 @@ void print_rss_hkey(u8 *hkey, u32 hkey_size)
>  	u32 i;
> =20
>  	printf("RSS hash key:\n");
> -	if (!hkey_size || !hkey)
> +	if (!hkey_size || !hkey) {
>  		printf("Operation not supported\n");
> +		return;
> +	}
> =20
>  	for (i =3D 0; i < hkey_size; i++) {
>  		if (i =3D=3D (hkey_size - 1))
> --=20
> 2.34.1
>=20

--t3egm3xotjuzckuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmhIsUIACgkQ538sG/LR
dpVN+AgAoJwtegybAaliP0VrCflDzXseWdDMDOLOK12rNQJMrip6ygcuWyug2Sah
O62bV0iqy7/Qi0r2z0tOrek+Rj2qDZiWRF/iXZLiEovnpNHHdDd73uyYbS7CkcvJ
OZhxCjNBiV0sWPwHG6FamK0HVfMga7OtUeEUxvlSgmqP3xkZ3a2GGwckypwGhrCV
WWSPXvJ8KcyidCWYqHtG/P4AWXVYFBkFJUmFIQs58PuJPJyt3THPszrO4KiJcWy+
jQUetXC/ZtIM5WmtARUo5GswJJkEdJJAYGByUSm6qJN82kJ4sqwlcWMwSbDBi0Vt
pLWxgyUDyF4WbChPdvxzKOsImFijVg==
=fe/1
-----END PGP SIGNATURE-----

--t3egm3xotjuzckuu--

