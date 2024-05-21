Return-Path: <netdev+bounces-97292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CE8CA900
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D81C282368
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1D50A75;
	Tue, 21 May 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/Sh7kKk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUX4KBuy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/Sh7kKk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUX4KBuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA54F5FE
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276886; cv=none; b=XOm65LyrDMPOR6mC2USTGuHiVfCar8q/j3nd7/o1lJe8QAyBHHat6VaoUpkbJhJzWnVzIXlgLuk5oyLtvTPTbNXf73wU+aDOe/6o2djELRxZmDIKFjkVWgJkgBUjQnYreiPxKw4owG3VQk9iDqkndXQK9jWDjJNbBqwJzlfOJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276886; c=relaxed/simple;
	bh=L/FHNnC4gijZUaqKQIUp9M5ESip42784NINWVVrAcsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU2FoVEgKeakzJmomAJxvdX5i5qB2M6FXVBhnG54bbTP9O8KhY3S0DSCpeX+aY0OB2erY6Rdl2uYl0CjjW9LAwKZ3vvR06gsYFqiNqsPmEf3mmA2JXorEgsjpUClyCT2JS6g6UeA6zFRwAVrCeWEytzw6DMqkpcjvlcTZfa+QKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/Sh7kKk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FUX4KBuy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/Sh7kKk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FUX4KBuy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E479A34599;
	Tue, 21 May 2024 07:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716276882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m1uQFJVMaYLH3NnqWlp5hAisJoP7dugO5mR2Bi13tk=;
	b=2/Sh7kKkMVQor4F+Wj/yoYIYutFVb/2HbH1rYX9cMTkAtwYrmHJe2004Inf9Er9a9h7vWF
	0UJKdfk1EEjzgIk31qimYn3iuADqPx/HIj9Jq7oT1hNbPXcZZq+dfncWHbWNYJ6G/QMLxx
	LnQ9494YiL2CnxtoC0VWcCbBcjZyiTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716276882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m1uQFJVMaYLH3NnqWlp5hAisJoP7dugO5mR2Bi13tk=;
	b=FUX4KBuym1aOmJN1OSZIGy9orh8xM5PRxarNlZkTyrfQPbFDrhh3eXkiEa2hVBfey6dHqL
	aapST2ojtdtWJpBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716276882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m1uQFJVMaYLH3NnqWlp5hAisJoP7dugO5mR2Bi13tk=;
	b=2/Sh7kKkMVQor4F+Wj/yoYIYutFVb/2HbH1rYX9cMTkAtwYrmHJe2004Inf9Er9a9h7vWF
	0UJKdfk1EEjzgIk31qimYn3iuADqPx/HIj9Jq7oT1hNbPXcZZq+dfncWHbWNYJ6G/QMLxx
	LnQ9494YiL2CnxtoC0VWcCbBcjZyiTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716276882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m1uQFJVMaYLH3NnqWlp5hAisJoP7dugO5mR2Bi13tk=;
	b=FUX4KBuym1aOmJN1OSZIGy9orh8xM5PRxarNlZkTyrfQPbFDrhh3eXkiEa2hVBfey6dHqL
	aapST2ojtdtWJpBg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id C9F8720131; Tue, 21 May 2024 09:34:42 +0200 (CEST)
Date: Tue, 21 May 2024 09:34:42 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Moshe Shemesh <moshe@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ipmpfv42kj4e7pvb"
Content-Disposition: inline
In-Reply-To: <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.34 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	LONG_SUBJ(1.56)[208];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.34
X-Spam-Flag: NO


--ipmpfv42kj4e7pvb
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 12:02:47AM -0700, Krzysztof Ol=EAdzki wrote:
> # ./ethtool  --version
> ethtool version 6.7
>=20
> # ./ethtool --debug 3 -m eth3
[...]
> sending genetlink packet (76 bytes):
>     msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
> received genetlink packet (96 bytes):
>     msg length 96 error errno=3D-22
> netlink error: Invalid argument

Can you do it with "--debug 0x12" or "--debug 0x1e"? It would tell us
which request failed and that might give some hint where does this
EINVAL come from.

Michal


--ipmpfv42kj4e7pvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmZMTo4ACgkQ538sG/LR
dpWCZAgAo4S9Kyg909yU4mzWC3hiJj+qAnQN83X6UJLhV6R7uLfiWKqqz5xZ6ZtT
9uaPHy6UXhgUywAJ7Rf76eYFcENy/+xtPEEcbGLJROl6eyRpmjmMd+SSoeWRfMnC
RnUp9Eg4m6AV6LiEqcC0RScIJoOQsQfg6Evwh8VdTae1J3yhh5M36k/ngje3l1Yc
YUNq8fjTBXzO+OIylVlyrRt3+9t3vCjmc76KvaM1azwHI6XYcSNcLKosG3cY4crE
8rddLIevwFTdlq6uiAZTzQrhJOsiiIGiogWm/wZhkhxN/rj+IsJmIQJtS3J0ij7P
uND/yefF5MtpGR8Qb5nnMaM0UVgK8A==
=Thbn
-----END PGP SIGNATURE-----

--ipmpfv42kj4e7pvb--

