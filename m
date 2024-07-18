Return-Path: <netdev+bounces-112081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03E934DE4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A972843F8
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48E13AA26;
	Thu, 18 Jul 2024 13:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C413B2BC
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308618; cv=none; b=Rzj2zrEJ7JXqKV1tiFzW5+fGiUyX0/nK5MVvfxpvL3cKeRCgadv7GSsGuoBjvIIzO3qVlW7xcLRciy4oORXLry3DvFO7Wbg0/mNvsP9t0JbGgQr1w3Ut5+qysbqh9E82pysH3/6yz9HYU3PYzkgeiqdC0/0bymOKSn2wUEgU6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308618; c=relaxed/simple;
	bh=pZ0kSeO3oPTtSA4E/l2Oj0ikqZ9GRkDCnTG2si+UXDw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lFLgqgUL5rTTg0uvV/o6OW6y3VF0+pijfy6Ll+eiNaX/T6SRV14kX4/wtfe3a3LK6QWJZuV8IiwhbKEMgPIjK1CaavnWIb2unjjT/A9zf1acUQIfWgNHQgallLd0RTDXASe8ssaW73YM4vF5Z/zR2UcZ5BkwrtdRa8xbkHvHHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id DF5BD7D115;
	Thu, 18 Jul 2024 13:16:52 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-5-chopps@chopps.org> <ZpkVBpKC-WdVOge6@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 04/17] xfrm: sysctl: allow configuration
 of global default values
Date: Thu, 18 Jul 2024 06:15:07 -0700
In-reply-to: <ZpkVBpKC-WdVOge6@hog>
Message-ID: <m2ikx2dem4.fsf@chopps.org>
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


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2024-07-14, 16:22:32 -0400, Christian Hopps wrote:
>> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
>> index ca003e8a0376..b70bb91d6984 100644
>> --- a/net/xfrm/xfrm_sysctl.c
>> +++ b/net/xfrm/xfrm_sysctl.c
>> @@ -10,34 +10,50 @@ static void __net_init __xfrm_sysctl_init(struct net *net)
>>  	net->xfrm.sysctl_aevent_rseqth = XFRM_AE_SEQT_SIZE;
>>  	net->xfrm.sysctl_larval_drop = 1;
>>  	net->xfrm.sysctl_acq_expires = 30;
>> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
>> +	net->xfrm.sysctl_iptfs_max_qsize = 1024 * 1024; /* 1M */
>> +	net->xfrm.sysctl_iptfs_drop_time = 1000000; /* 1s */
>> +	net->xfrm.sysctl_iptfs_init_delay = 0; /* no initial delay */
>> +	net->xfrm.sysctl_iptfs_reorder_window = 3; /* tcp folks suggested */
>> +#endif
>>  }
>>
>>  #ifdef CONFIG_SYSCTL
>>  static struct ctl_table xfrm_table[] = {
>> -	{
>> -		.procname	= "xfrm_aevent_etime",
>> -		.maxlen		= sizeof(u32),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_douintvec
>> -	},
>> -	{
>> -		.procname	= "xfrm_aevent_rseqth",
>> -		.maxlen		= sizeof(u32),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_douintvec
>> -	},
>> -	{
>> -		.procname	= "xfrm_larval_drop",
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec
>> -	},
>> -	{
>> -		.procname	= "xfrm_acq_expires",
>> -		.maxlen		= sizeof(int),
>> -		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec
>> -	},
>> +	{ .procname = "xfrm_aevent_etime",
>> +	  .maxlen = sizeof(u32),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +	{ .procname = "xfrm_aevent_rseqth",
>> +	  .maxlen = sizeof(u32),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +	{ .procname = "xfrm_larval_drop",
>> +	  .maxlen = sizeof(int),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_dointvec },
>> +	{ .procname = "xfrm_acq_expires",
>> +	  .maxlen = sizeof(int),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_dointvec },
>> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
>> +	{ .procname = "xfrm_iptfs_drop_time",
>> +	  .maxlen = sizeof(uint),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +	{ .procname = "xfrm_iptfs_init_delay",
>> +	  .maxlen = sizeof(uint),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +	{ .procname = "xfrm_iptfs_max_qsize",
>> +	  .maxlen = sizeof(uint),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +	{ .procname = "xfrm_iptfs_reorder_window",
>> +	  .maxlen = sizeof(uint),
>> +	  .mode = 0644,
>> +	  .proc_handler = proc_douintvec },
>> +#endif
>
> What happened here?

Sigh, overly aggressive clang-format happened here, and I missed it. Will fix.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaZFcMSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlIZcP/2/cxGqpyLTMNXrLoCKIYVzll7+BZFyy
FWwCY7+jX3HQv3iBgoGNYvTbhkTSXqXi1gxexQy6BZQVF54b5yrq/0b5INcIuTiB
zCD3OYVyUyZInsu5F8E0UZ2CB8Oj4tqGj/6gOdE1+Of8Qg8F9WPuCXcbbqIhCPk3
tyR7reNiJCJYLfnLrjjXbKSwcZ8ijcIn0mQudbA8Yf1GGOWIKijLeV+wk6rBjsOw
TG2Wh1+qoG3mzn18ZQqjYEoCfq7uTRwf+WbLoPfmKn+dh5ERrOhH9oSLDG1xl/HN
BLa5XnsvYN3BMXxMcGuaJTUsP+vp5QG2whYioD659RA6sbdUKTLV5ht4V/d2kVjP
pmHq+qxdaSHZq2k9qCROaIWGKhur1muLqeDQG2L/OPufhMwY1R9a426PxnWewM8R
DVbMiceyqB2UAMHntY5tIXUN2ssNWtSlwG2M/37nabE4cux2Mrj+ByBZ3jUKabRb
8e/3Erv6nxdONcVHEY6eepGU4f4pxOepVP8OaPlF53pSJB8BJ0fjR34FoXLgxHZp
+tP/vUgkv2L8cg9aomrZu9vH2Oq0c02W2e8+I/nX3BJsTX/9R9XPK7QEOgEUkM2g
9TzQNodN49/bZ1oPNfdyftdzxvEmQggrsibWEWMt3TuqCsIFZ+NKb8ScRGhOTgJV
eoecMEY0uJwb
=UVgx
-----END PGP SIGNATURE-----
--=-=-=--

