Return-Path: <netdev+bounces-97753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C628CD06F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF36281378
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8E13D521;
	Thu, 23 May 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYK+LW3Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7/k1CL2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYK+LW3Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7/k1CL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486113D286
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460652; cv=none; b=RtYwraEgUS2zmn8R+v5NFztmVbmwpvMxNKhN7OocPv1jHIebeJuDkbNWbIwRLpa3UVgq6B7aNeORFlCJfXY1lJypGU+hAadCtTRlFgzmxx0/td7zqsbKmyUqHOyMNeBiQLDGYECKFSK7Xdjpj0RsH9HkW5gZqkRY4X2VnIpfmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460652; c=relaxed/simple;
	bh=/1KBVwjzgcWkBaQvXJzCXdCnX2ss4+FGZS/CNUAbWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWT47JtPeuJ1E4y9XkTUakahmW0n9QoTFeNCEQIOs8s1KlO7dv/uKeaw30MwZc8Xs6eG1JU+fycLQmfSt0ca6+VGoBazgZnzE6z9i1qNx5oo18NsQOKZuT+E4ZhVJJyb3VSem6KHBtqhDhoxDevFg7vXxrJ2qKLCd1VV9Mbjq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYK+LW3Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7/k1CL2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYK+LW3Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7/k1CL2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EB9622529;
	Thu, 23 May 2024 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716460648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1KBVwjzgcWkBaQvXJzCXdCnX2ss4+FGZS/CNUAbWBg=;
	b=CYK+LW3YJgfJohiINUGL6ajc51etK5X7uIhHx3cvdRgagDL3BMG6yzmx91tGTBnU90FQLG
	4DWt2HlzZQOTWeAD7F81WLF8iOiXf/iWZTjiuEtyg7rvbkrWdvzS4X76hvm/svGGBEYNFq
	iBi8kyH5Mi3WDws+5BbGGe35gjaAqTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716460648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1KBVwjzgcWkBaQvXJzCXdCnX2ss4+FGZS/CNUAbWBg=;
	b=H7/k1CL2VLy+q1NjKICKSoU03WbBESTvrD0W5/4U89TbHCEmtVzCvblK8BnQpJlXIqhXGe
	IgGjwd2KyD6P//Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716460648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1KBVwjzgcWkBaQvXJzCXdCnX2ss4+FGZS/CNUAbWBg=;
	b=CYK+LW3YJgfJohiINUGL6ajc51etK5X7uIhHx3cvdRgagDL3BMG6yzmx91tGTBnU90FQLG
	4DWt2HlzZQOTWeAD7F81WLF8iOiXf/iWZTjiuEtyg7rvbkrWdvzS4X76hvm/svGGBEYNFq
	iBi8kyH5Mi3WDws+5BbGGe35gjaAqTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716460648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1KBVwjzgcWkBaQvXJzCXdCnX2ss4+FGZS/CNUAbWBg=;
	b=H7/k1CL2VLy+q1NjKICKSoU03WbBESTvrD0W5/4U89TbHCEmtVzCvblK8BnQpJlXIqhXGe
	IgGjwd2KyD6P//Aw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 7C68D20131; Thu, 23 May 2024 12:37:28 +0200 (CEST)
Date: Thu, 23 May 2024 12:37:28 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Ido Schimmel <idosch@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	tariqt@nvidia.com
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <2pg2m5byszc7qbzxii3ag2v5kzptny2vv4nssatfwrixy4gdd6@fvvnwy2gccsb>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tomvusl3scdpzy6f"
Content-Disposition: inline
In-Reply-To: <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
X-Spam-Flag: NO
X-Spam-Score: -3.34
X-Spam-Level: 
X-Spamd-Result: default: False [-3.34 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	LONG_SUBJ(1.56)[208];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]


--tomvusl3scdpzy6f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:29:43PM -0700, Krzysztof Ol=EAdzki wrote:
> Do you think it would make sense to print a warning in such situation,
> or just handle this silently?

Unless part of the data not being available is something that should be
expected to happen even if there is nothing wrong (which doesn't seem to
be the case), there should IMHO be a warning that the information shown
is incomplete.

I would also consider a short comment in the code explaining that
returning 0 after request failure is intentional.

Michal

--tomvusl3scdpzy6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZPHGMACgkQ538sG/LR
dpWrMwf+PTsWEjYH1ihuSvdPPQ3ulvU+GFV8WMicy7NZ/f3deb8BsaWsNkmqlok/
HpWceGBVm/f/vN9rHmBT2urPRaq2mx94NzERsvVLxDbePtCRPo5Vjm7Ce7PlUcNF
pOlkjMfAbMWhckuOKRUx+4IyNU2nW7/bHiPGNXWQV5BsZSwoUJ/0QxfJxDTFA93c
23YFLQ4DdVxIeKX8eumxDiHe/y3Knfl047+02ps+TW0MUqedoovCKFEk2izQpXQ5
i/Xnj1Sml6yGsBIjtGYUo+sCRMKVlv4YxkclPNSgF/O1vyb8Y/cwj8l25+7L2Ai1
pTYT+yjYxV24uStwuwlov0ZlJAbBBw==
=xDnj
-----END PGP SIGNATURE-----

--tomvusl3scdpzy6f--

