Return-Path: <netdev+bounces-112274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D949937E8A
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 02:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0879228182E
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27236163;
	Sat, 20 Jul 2024 00:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296979DF
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435583; cv=none; b=nu/Y9zMbnNBS8EwpFOR/Jd2gMQ6wel68MH5IegDiIYqzyGgtA+dPJlTZRsXLWBsejOBvuny/3YGltc3ueklg0uAp5S8JX+NjzgNbBRV2IuGOheOsw7AQ9/cuU1DK0yCbXvWHsdk3YDhjSnlfv2GTzk5cVpkpVbHE1eszhUPDdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435583; c=relaxed/simple;
	bh=bOf0uaOnZfQ7qrXKBFMeyTIOJP7Ps8jTkXecHZmInI8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Dxzjx+dwbNh0LTuBHIo1vQC3F41gl6EFiW+XNlHnEwTSv+RWqmk4Ynf9fD0L1A6Xb1qiyklcsqDw/P+Eo8jtP8oflOZ8Pj5YCs2Sk5fnMK59apWqiKwLuhQK0UeZYtpH31tRp8NLUGYaJtNsr62ubS2DlSwpy9TTEG0iJZEtNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [75.104.68.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id F14747D018;
	Sat, 20 Jul 2024 00:32:55 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org>
 <20240719061655.GB29401@breakpoint.cc>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Florian Westphal <fw@strlen.de>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new
 iptfs xfrm mode impl
Date: Fri, 19 Jul 2024 17:30:31 -0700
In-reply-to: <20240719061655.GB29401@breakpoint.cc>
Message-ID: <m2frs4x5qn.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Florian Westphal <fw@strlen.de> writes:

> Christian Hopps via Devel <devel@linux-ipsec.org> wrote:
>> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
>> +{
>> +	struct xfrm_iptfs_data *xtfs;
>> +	int err;
>> +
>> +	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
>> +	if (!xtfs)
>> +		return -ENOMEM;
>> +
>> +	err = __iptfs_init_state(x, xtfs);
>> +	if (err)
>> +		return err;
>
> Missing kfree on err?
>
>> +	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
>> +	if (!xtfs)
>> +		return -ENOMEM;
>> +
>> +	err = __iptfs_init_state(x, xtfs);
>> +	if (err)
>> +		return err;
>
> Likewise.

These originally counted on the fact that the xfrm state is cleaned up on error; however, a later code change did indeed allow for the leak -- added kfree's as suggested.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmabBbASHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAldYwP/jw0Cn2Nxaun8dHsBW/Mibf6hfbIzSK+
RTeETpREZQOiXzBNF1r8n+XXmp21QPjXDxLFJFA3bsK7SpocHD9DpYArKwdYysPo
1JX03DsREK07RfXuOzqfwMUmWbXhQLy5F/te/Htma6kXDAliFQgY7nCav7fkAVi6
bjox7Svefh/9TNVl/1JXsmzV6vtpmMNJ7oVE3XKV5BlFWLsoOko3lik6FSgyZuvV
T8z9UaTFbHGbu6rDEoi6YZ+x0T6kT9AKEvRRVtl+YU3rBpU99ixaMHyDVLkav269
5h0XHLXujBwkU0n+w3TC7gxR8qZ01NnYBK3e4vPw905b+Yzq851a5+ge0AOAXHZ8
uoOZQeFZ9MXTvzG0ZPriDXuX96TteCzNCDn6k6DQYjuZ3ylXCvenq/zJvHC63Kkp
UnJzgKMWY/ogKXObm6+gQazBXOt71GMTMLzsjmnvsLwoUM3ZUDkspvdWdS8As6gU
kMJ8IrTUvjxJNyhqf6VAeKPZ/sGggIkCf7/gobbwUb9X1N3e4lWjLhoO2K5ONlyS
7iKU4xLMpnfJ918gwcjOE9PQypYCgjhNHnwhnQUI03rMAJwO0Cx2cPLYdUaV01Sb
APVSBDhS/wb/2CTa0Ow0tJgkKAt6byBzZiezWzwO3dmr+EQ5pKkM0gH7WtD28Pl+
S5C0nPyDAQL2
=2ySj
-----END PGP SIGNATURE-----
--=-=-=--

