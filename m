Return-Path: <netdev+bounces-78777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FD876692
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4AB214AA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103591865;
	Fri,  8 Mar 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBK8D5YL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfdlGUZg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBK8D5YL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfdlGUZg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF136F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909226; cv=none; b=jXDKHz5oalRGh0HfjhG2lEVaWr1ydsg5HjPbWteIxmH/0SRM8Yr7qlDGf/09/gc4B8T2p21SqVy++cpmy4hhoe1CVd3rVQ1WyhpZcquqGwyapU7jXeIcsY3/FqNPZKUAYD4TzeuAdnmE8r+xOxpSzkzb4usCLmIkShv8V7WysSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909226; c=relaxed/simple;
	bh=yJ/Zy+QbB9gMonJnsDCWFHlKBt+n3vPWOrXmFq6Y760=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXv/ler31C6WTvM1CSLUIPmjn9DdvmIVIclVYSKS9w2peffHNJ+m+edpgjnz9ohdPxTAHHzARF63fmQgbLxpmXPD+X60GPSHT4QRFl2Ps0NeojtKbTsrXn9V0cPseS/UC5XnqsRYPQj+5wIFI76NhhMLeULzbfe1zARV9rJkKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBK8D5YL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfdlGUZg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBK8D5YL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfdlGUZg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F30822D79;
	Fri,  8 Mar 2024 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709907384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/Zy+QbB9gMonJnsDCWFHlKBt+n3vPWOrXmFq6Y760=;
	b=wBK8D5YL6hpCrgakCx/5UjmgngO5DpE1jNhHVTPY8404doyLcQ5n9kvne1kDQxwMuSrrsN
	1tz1qw1UkwrUSv8ucm0cOfQHFam85HYIRBfweIuuuMTj0YNIHxUNZV/nVOiqQQ5YrTuzUk
	p+VQJXxmo4CzBsIGNi7gpRC/PWB9uLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709907384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/Zy+QbB9gMonJnsDCWFHlKBt+n3vPWOrXmFq6Y760=;
	b=MfdlGUZgk3FyR0+QBZFOTE5xOzwskCHLvelIMXxmZqb/cj7BgIzltFfl0yo8oQjCtHSqQF
	qtyRGW3F0Rkj88BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709907384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/Zy+QbB9gMonJnsDCWFHlKBt+n3vPWOrXmFq6Y760=;
	b=wBK8D5YL6hpCrgakCx/5UjmgngO5DpE1jNhHVTPY8404doyLcQ5n9kvne1kDQxwMuSrrsN
	1tz1qw1UkwrUSv8ucm0cOfQHFam85HYIRBfweIuuuMTj0YNIHxUNZV/nVOiqQQ5YrTuzUk
	p+VQJXxmo4CzBsIGNi7gpRC/PWB9uLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709907384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ/Zy+QbB9gMonJnsDCWFHlKBt+n3vPWOrXmFq6Y760=;
	b=MfdlGUZgk3FyR0+QBZFOTE5xOzwskCHLvelIMXxmZqb/cj7BgIzltFfl0yo8oQjCtHSqQF
	qtyRGW3F0Rkj88BQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 2E4932013C; Fri,  8 Mar 2024 15:16:24 +0100 (CET)
Date: Fri, 8 Mar 2024 15:16:24 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
	"Priya Tripathi (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Message-ID: <20240308141624.sj3m7imkcaeq2vjy@lion.mk-sys.cz>
References: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
 <fb8b2333-cde2-4ec4-9382-f3a563954d06@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6xnpzmvxbttd2enc"
Content-Disposition: inline
In-Reply-To: <fb8b2333-cde2-4ec4-9382-f3a563954d06@lunn.ch>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.25 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.05)[60.51%]
X-Spam-Score: -2.25
X-Spam-Flag: NO


--6xnpzmvxbttd2enc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 02:56:30PM +0100, Andrew Lunn wrote:
> On Fri, Mar 08, 2024 at 06:33:00AM +0000, Sagar Dhoot (QUIC) wrote:
> > Hi Andrew,
> >=20
> > Thanks for the quick response. Maybe I have put up a confusing scenario.
> >=20
> > Let me rephrase with autoneg on.
> >=20
> > 1. "ethtool eth_interface"
> > 2. "ethtool -s eth_interface speed 25000 autoneg on"
>=20
> phylib will ignore speed if autoneg is on

It is not passed there. With "autoneg on", speed, duplex and lanes are
interpreted as conditions for modes to be advertised, i.e. they are
translated to the same request as "advertise ..." with list of supported
modes matching the parameters that were used.

In the ioctl code path, this logic is handled in userspace ethtool (but
only in a limited scope), for netlink API the logic is implemented in
kernel function ethnl_auto_linkmodes() in net/ethtool/linkmodes.c.

Michal

--6xnpzmvxbttd2enc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXrHbQACgkQ538sG/LR
dpVOlggAgAWecvRTizgOBp92UuKDwcrGGHsrpYeI3Ge9laRneE4nZlE09L+eBK98
Q9+dBjQJRqIzDJaR8HwmQlyb79c/swLCO0FN05YaPI29iocr2R4sKkY6wr8MksLz
vcrTU5oFgSB3D6F0tb4oqMlW9adqNBhJ+2nd/bAV7OlpHD+rRjDq+tl99eXWk4+1
OyuK0U0MDPI8jP4kXGgvGid38w+ZIwhTuRl3rWajY0n6Az8EqjUyaPzo+9SDekvC
P08ooLrlPnw0gX1Ukfjp7g+VW9A1fQFqKKTv9k98gmrUrVtb13cZ0mANgeKiN726
tCHv5xGTFAYL1jTOWg0zhYtd7OF29w==
=4C+Z
-----END PGP SIGNATURE-----

--6xnpzmvxbttd2enc--

