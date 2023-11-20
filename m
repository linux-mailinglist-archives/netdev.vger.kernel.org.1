Return-Path: <netdev+bounces-49387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05797F1DFB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCF282332
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C1374C9;
	Mon, 20 Nov 2023 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2B0C7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 12:24:51 -0800 (PST)
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id B2BE67D089;
	Mon, 20 Nov 2023 20:24:50 +0000 (UTC)
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-3-chopps@chopps.org> <ZVt7Nud5U5FbUJ3f@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 2/8] iptfs: uapi: ip: add ip_tfs_*_hdr
 packet formats
Date: Mon, 20 Nov 2023 15:18:49 -0500
In-reply-to: <ZVt7Nud5U5FbUJ3f@hog>
Message-ID: <m2sf50yxym.fsf@ja.int.chopps.org>
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

> 2023-11-12, 22:52:13 -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add the on-wire basic and congestion-control IP-TFS packet headers.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  include/uapi/linux/ip.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
>> index 283dec7e3645..cc83878ecf08 100644
>> --- a/include/uapi/linux/ip.h
>> +++ b/include/uapi/linux/ip.h
>> @@ -137,6 +137,23 @@ struct ip_beet_phdr {
>>  	__u8 reserved;
>>  };
>>
>> +struct ip_iptfs_hdr {
>> +	__u8 subtype;		/* 0*: basic, 1: CC */
>> +	__u8 flags;
>> +	__be16 block_offset;
>> +};
>> +
>> +struct ip_iptfs_cc_hdr {
>> +	__u8 subtype;		/* 0: basic, 1*: CC */
>> +	__u8 flags;
>> +	__be16 block_offset;
>> +	__be32 loss_rate;
>> +	__u8 rtt_and_adelay1[4];
>> +	__u8 adelay2_and_xdelay[4];
>
> Given how the fields are split, wouldn't it be more convenient to have
> a single __be64, rather than reading some bits from multiple __u8?

This is a good point, I carried this over from an earlier implementation, let me give it some though but probably change it.

>> +	__be32 tval;
>> +	__be32 techo;
>> +};

> I don't think these need to be part of uapi. Can we move them to
> include/net/iptfs.h (or possibly net/xfrm/xfrm_iptfs.c)? It would also
> make more sense to have them near the definitions for
> IPTFS_SUBTYPE_*. And it would be easier to change how we split and
> name fields for kernel consumption if we're not stuck with whatever we
> put in uapi.

The other ipsec modes headers were added here, so I was simply following along. I don't mind moving things but would like to understand why iptfs would be different from the other modes, for example, `struct ip_comp_hdr` and `struct ip_beet_phdr` appears in this file.

Thanks!
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmVbwJESHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlIpIQAJHP4iUvej8P+usQhVYT9MIgKJbV3gLN
5h+9iT3Z8cNgMiWZqcLQE3qwqkk1TGHUAlZpOZcec1nyK331fMrYdMBwZimGrXPq
ZhqStD4wfQWX4n+qUhVikV9cfA8NkgLKsyvH1t9kws8doQ0cqnUuATNyfP4hEJBR
tByZUeSgbcxdDNsXInTWqKMAjmnvom9dnzDAmKZM/MD0CZE1kzWUjom1744vjUid
tcR8nVqrBPosB/JHjp9TRzAxpZCWjDPKI0vJ20lLNvZUqFw4TktrQu/So74NurUI
uVQnJslyzFh5+cpIdqvUjjSfCydAl5TNMdD2V+c0ohqJ8lpnAK01vD74oWYYmhNs
dPYF8yrwjXWa46NnUNSoGpua595dMNGGuxn31Bbptyxr4qrcv0xGwCY5oJkvNuRl
uLdx0CavtrGQUuM6GrH4rQ07ewNKhyJKHnmFm5+yywH5KSU0nvzYkcrcgcCw/VMT
el5papYPD5BErslXvQgoOmoRr64wbzUd4+w7YC7STjZi2zhj5Om+9KXtBHszglPL
sdiaOcw1koa9lzzugydqopb5le/KENuy904S1c5nKmL5y84bUUE2KxrJt2ubAQzz
QF2izH3MbPLXj0bM0t72vhqhKkKYF4zTVJ5DLF50akkU08JTC49tvG6yaXv/y6pV
/ZgpKFupWk8W
=YcD1
-----END PGP SIGNATURE-----
--=-=-=--

