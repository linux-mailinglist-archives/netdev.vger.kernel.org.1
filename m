Return-Path: <netdev+bounces-147777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5A9DBBCF
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 18:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69005281A35
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02A1C07EE;
	Thu, 28 Nov 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14ndno9S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCF8oIJw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14ndno9S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCF8oIJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF3537F8
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815391; cv=none; b=s3oU7ivsEWLBuzgAVgxcvWAcpAf+dWnjFBBn+KAN+f+RhLlSIdPwI0lmiDy/vII4zoJPvS034USF0dVDYS3fz7xD9ivgdl+Mygvu66TYlcfNx4NCtr9yk0W072zIblGh3IJzSj1skRlop6XyX/3G+0P8VXD8lOy6HMQi7WCQCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815391; c=relaxed/simple;
	bh=F7jd7nDH3zTMt1/v9gqD7XlB/0DzGEd2q0jhMaDZRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJw1WhnklVbzyBNZkkP9X+3wCFL7eRJeGkyqqX8/x6umKpLHWfHdgu+bpx1QwSK/AhrY2EHGwQaskS4QadSBT17f6F4uv3ZXriLw0oUf9mGdfO+KFmoHwvqeqbB9SS8IbXpJB+ipVEhY3eA6YMakwiydZHhoLNXTwwcr5jpv+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=14ndno9S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCF8oIJw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=14ndno9S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCF8oIJw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B711C21190;
	Thu, 28 Nov 2024 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732815387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV+Blc1npQEDRV5S/DXP5Mldnkh1LoSBUVDyLOfybWc=;
	b=14ndno9SL9CD8H6M/27qupOAKHpa3YEGGVFMgWAw9endcC2DOzaw5qG91rW9HZEWxFd4Ko
	mDwiqB7JI/EXGAm4/recT/Ztt6YRSC3uNuKo4dKPYsyTPcUwjhNYZ0K+AmK9ezHscYW9Lq
	6w1TgX4+hjazPqgtRfeDs0ImTcdA2oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732815387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV+Blc1npQEDRV5S/DXP5Mldnkh1LoSBUVDyLOfybWc=;
	b=PCF8oIJwsj90JdHAXkF9kCldkLB79fLVeNmffmI6Gis1HvD0jBz+0j7Wlo7rK4GxZHR8at
	8n8ugFXJJbyUCCBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732815387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV+Blc1npQEDRV5S/DXP5Mldnkh1LoSBUVDyLOfybWc=;
	b=14ndno9SL9CD8H6M/27qupOAKHpa3YEGGVFMgWAw9endcC2DOzaw5qG91rW9HZEWxFd4Ko
	mDwiqB7JI/EXGAm4/recT/Ztt6YRSC3uNuKo4dKPYsyTPcUwjhNYZ0K+AmK9ezHscYW9Lq
	6w1TgX4+hjazPqgtRfeDs0ImTcdA2oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732815387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MV+Blc1npQEDRV5S/DXP5Mldnkh1LoSBUVDyLOfybWc=;
	b=PCF8oIJwsj90JdHAXkF9kCldkLB79fLVeNmffmI6Gis1HvD0jBz+0j7Wlo7rK4GxZHR8at
	8n8ugFXJJbyUCCBg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 8600F2012C; Thu, 28 Nov 2024 18:36:27 +0100 (CET)
Date: Thu, 28 Nov 2024 18:36:27 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <eajj4mhvqkwrl7lmsrmjy32sncanymqefhxkv4cpnjvxnf2v7o@o6vtfpu7pyym>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
 <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="prhtkawvkibaprk2"
Content-Disposition: inline
In-Reply-To: <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lion.mk-sys.cz:helo]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--prhtkawvkibaprk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 05:58:09PM +0100, Andrew Lunn wrote:
> On Thu, Nov 28, 2024 at 10:01:11AM +0100, Oleksij Rempel wrote:
> > Extend cable test output to include source information, supporting
> > diagnostic technologies like TDR (Time Domain Reflectometry) and ALCD
> > (Active Link Cable Diagnostic). The source is displayed optionally at
> > the end of each result or fault length line.
> >=20
> > TDR requires interrupting the active link to measure parameters like
> > fault location, while ALCD can operate on an active link to provide
> > details like cable length without disruption.
> >=20
> > Example output:
> > Pair B code Open Circuit, source: TDR
> > Pair B, fault length: 8.00m, source: TDR
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v2:
> > - s/NLATTR_DESC_U8/NLATTR_DESC_U32
> > ---
> >  netlink/cable_test.c   | 39 +++++++++++++++++++++++++++++++++------
> >  netlink/desc-ethtool.c |  2 ++
> >  2 files changed, 35 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/netlink/cable_test.c b/netlink/cable_test.c
> > index ba21c6cd31e4..0a1c42010114 100644
> > --- a/netlink/cable_test.c
> > +++ b/netlink/cable_test.c
> > @@ -18,7 +18,7 @@ struct cable_test_context {
> >  };
> > =20
> >  static int nl_get_cable_test_result(const struct nlattr *nest, uint8_t=
 *pair,
> > -				    uint16_t *code)
> > +				    uint16_t *code, uint32_t *src)
> >  {
> >  	const struct nlattr *tb[ETHTOOL_A_CABLE_RESULT_MAX+1] =3D {};
> >  	DECLARE_ATTR_TB_INFO(tb);
> > @@ -32,12 +32,15 @@ static int nl_get_cable_test_result(const struct nl=
attr *nest, uint8_t *pair,
> > =20
> >  	*pair =3D mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_PAIR]);
> >  	*code =3D mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_CODE]);
> > +	if (tb[ETHTOOL_A_CABLE_RESULT_CODE])
> > +		*src =3D mnl_attr_get_u32(tb[ETHTOOL_A_CABLE_RESULT_SRC]);
>=20
> ETHTOOL_A_CABLE_RESULT_SRC is a new property, so only newer kernels
> will report it. I think you need an
> if (tb[ETHTOOL_A_CABLE_RESULT_SRC]) here, and anywhere else you look for
> this property?

Looks like a forgotten edit of copy&pasted text as the
!tb[ETHTOOL_A_CABLE_RESULT_CODE] case is already handled by a bail out
few lines before. (And the same for ETHTOOL_A_CABLE_FAULT_LENGTH_CM in
nl_get_cable_test_fault_length().)

Michal

--prhtkawvkibaprk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmdIqhUACgkQ538sG/LR
dpWWSggAkUwEuOl+ImSQRxmMLLvTMGC+y8LllqNDEGK6qCvebNrBRfT9+BlQ0n/1
beNEPb3sCt4HsJhSpLD0hI/LMqOnmB+8R2/GKOFeornW7SSUwC98mFhRXMC81gai
Ed5Zxwps6+6fZulbcj2cHVOg+IC93iBvqeleR8GtCngqHSDbSqY7IX8ZRRL5BcGu
pT+58KYpXeuYE9gKiSXS1q8HDfYBdjlcUo3udqiUE5n69ufxywRjxO95cJ5JRInU
KLlUiQADsD8bp8Q7G8OGviIrK9U3awXuXv8Q7OaH9ghMlbU4GAX0vXPQpwkw7/r/
vwoW7pLGXWeqwG/rDdk+8Ki01V+rPg==
=rOtl
-----END PGP SIGNATURE-----

--prhtkawvkibaprk2--

