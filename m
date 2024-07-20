Return-Path: <netdev+bounces-112272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74F937E6E
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2622820CF
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D61C27;
	Sat, 20 Jul 2024 00:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B51C14
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434230; cv=none; b=rHQenRlVH3ZQLJL/TUxyUY56K4yxdYS/vSW+fbzwUJLVlsTWwi3YVJzfbUCIfZqI3+sFXnR7g76Pl/FLGmev2ZB9Iloj2kEBcX6l79B415tSXEweiaOe+jS75fii1h3esTK6TOen0ZN/9xucACYzpAAaW/5m87WWHbkZwfs4dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434230; c=relaxed/simple;
	bh=k9hJu3XBZPVlQwdlAGWtbeEt/kiPPCJWHXsxd0avHNE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=fRidZHWZdS07z/0NHb4RmbpgkrLoB0wiMvlTe8t4ma8NuWAmjZIdpQhEiGijG5V95Pu/VHvBUNMazK/cbbA+qGJ9EWdaVk6hXdqYPPd9B28vrOyy4Jt+pvO49qXSKT5PJZFCrMKL+mDiB9qPPVUPUi3lYs1YDnsN1ZDkuoUAqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [75.104.68.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 61B487D018;
	Sat, 20 Jul 2024 00:10:15 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-7-chopps@chopps.org>
 <20240719061413.GA29401@breakpoint.cc>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Florian Westphal <fw@strlen.de>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 06/17] xfrm: add mode_cbs
 module functionality
Date: Fri, 19 Jul 2024 17:06:41 -0700
In-reply-to: <20240719061413.GA29401@breakpoint.cc>
Message-ID: <m2jzhgx6sg.fsf@chopps.org>
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
>> +static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
>
> Why not
> static struct xfrm_mode_cbs *xfrm_mode_cbs_map[XFRM_MODE_MAX];
> i.e., why does
>
>> +int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
>> +{
>> +	if (mode >= XFRM_MODE_MAX)
>> +		return -EINVAL;
>> +
>> +	xfrm_mode_cbs_map[mode] = *mode_cbs;
>
> do a deep copy here rather than
> 	xfrm_mode_cbs_map[mode] = mode_cbs;
>
> ?
>
>> +	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
>> +		request_module("xfrm-iptfs");
>> +	return &xfrm_mode_cbs_map[mode];
>
> Sabrina noticed that this looks weird, and I agree.
>
> This can, afaics, return a partially initialised structure or an
> all-zero structure.
>
> request_module() might load the module, it can fail to load the
> module, and, most importantly, there is no guarantee that the
> module is removed right after.
>
> Is there any locking scheme in place that prevents this from
> happening? If so, a comment should be added that explains this.

I've switched it to the more obvious array of pointers and storing the module provided pointer.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmabAF8SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlmN8P+wY2S9L+x3KANpEDiZdPj167zWst5T6e
qE3PcmbA+2GoK0yM4vYRTU9ZCr8ZBDoIPzciq7ksukCwUrrgBZ7UHwHRnYV/z8WS
lc8L8yCpwfiEVlNj4SbvkPvto03W757J+fDYA9WyE9uIgmxeI5ZFjUwwIqiey2f2
1SAjtDTnUFOG1sQ5Sq0NvXOFwne2OB5Xlalxm7TSSu8thkleUglPr/DWlPMJwvMl
ZgB8ObfOtBQShkgYBQB9Z/0rG9rM2u1qdIzhFbcJ/fwZ29/albrSGKoXuSaa97nR
3FJDK0gyJxm84TlnwZ0lBNoOb30GKXehVumooOWm03XyS/fImz1EanwFfWDRVefQ
1LyrzAo5LhnWWWRD2djLEboTOmO7xnfQ04PVhEY4VBFXmjplYyUvZD60+zDrvWmL
VyRwX5A+3M88AtdAoPvE5oUJqpfID3bKWRQRzotgy6ZTiR6+HAELGZzVOK7ifoiA
FqopshJelNJuoZ+krTa2F8YM7jb5dNpJKM2m23+QS78wh4Yz2vnOVCGj17e7zv/Z
YyYf2qlg22QsudsjRZ7m/t8FLoV8yf9A3RknkiTes5ZiNvFIqjjCQkhAF/rOvuZd
RSHepcyx1FqYnMcBfF5/47okjuzpBmZ0yKjkLMvEnxer39cfWt3b5WdIurC3HM79
aRY0jWEW8R3c
=3rju
-----END PGP SIGNATURE-----
--=-=-=--

