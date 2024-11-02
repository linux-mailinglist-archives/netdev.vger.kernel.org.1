Return-Path: <netdev+bounces-141223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C79BA14C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F34B1F2189E
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE31A0BE0;
	Sat,  2 Nov 2024 15:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6D19E975
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563056; cv=none; b=V4k1bN1IeWKzOXwpkiCaukuFbXPPtZ1gLdW5rMGM41YyIBbSeiGjyEhIPIAOarv4WCQhxP54YI8BPFpTA4uWqbcdnm5gpEKKTH+gra8JkErvVbes7TSpn7EAjuqfX23fkk6L6mJBM6Ij0mkKirNS8yy+vXyqlBpOuJzw4XdhrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563056; c=relaxed/simple;
	bh=rOt6Atx4uMxk92fI4fSrsYuC30NDLTciz6AfR6mvTM8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=tAKbem5g+mmcvAbAw2jMGi7VSgiE3+Nz8Q8/SkHW9SQQ+KkFhq1m70dcCcBsLvQXE1su7ngUgs5GdKzJVbsv45YPpVJIGIOVXTJdlIMVRxGPVoyLUk0C6SID5GACS2+LZoDWn+oWUOk9phPEphWIcwe63rPU3ZovA3DK/8D/sqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [185.122.134.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id ECC867D08A;
	Sat,  2 Nov 2024 15:49:35 +0000 (UTC)
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-9-chopps@chopps.org>
 <ZxYfLMIahzR9cpMw@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
 <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 08/16] xfrm: iptfs: add user packet
 (tunnel ingress) handling
Date: Sat, 02 Nov 2024 15:44:25 +0000
In-reply-to: <ZxYfLMIahzR9cpMw@gauss3.secunet.de>
Message-ID: <m2zfmhiqk2.fsf@chopps.org>
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


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Mon, Oct 07, 2024 at 09:59:20AM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>> @@ -77,8 +609,11 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
>>  {
>>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>>  	struct xfrm_iptfs_config *xc;
>> +	u64 q;
>>
>>  	xc = &xtfs->cfg;
>> +	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
>> +	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
>>
>>  	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
>>  		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
>> @@ -92,6 +627,17 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
>>  			return -EINVAL;
>>  		}
>>  	}
>> +	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
>> +		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
>> +	if (attrs[XFRMA_IPTFS_INIT_DELAY])
>> +		xtfs->init_delay_ns =
>> +			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
>> +			NSECS_IN_USEC;
>> +
>> +	q = (u64)xc->max_queue_size * 95;
>> +	(void)do_div(q, 100);
>
> This cast is not need.

Removed.

FWIW, the cast was to document the ignoring of the returned remainder value; however, this is outside the normal linux kernel coding style.

>> +	xtfs->ecn_queue_size = (u32)q;
>> +
>>  	return 0;
>>  }
>>
>> @@ -101,8 +647,11 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
>>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>>  	unsigned int l = 0;
>>
>> -	if (x->dir == XFRM_SA_DIR_OUT)
>> +	if (x->dir == XFRM_SA_DIR_OUT) {
>> +		l += nla_total_size(sizeof(u32)); /* init delay usec */
>> +		l += nla_total_size(sizeof(xc->max_queue_size));
>>  		l += nla_total_size(sizeof(xc->pkt_size));
>> +	}
>>
>>  	return l;
>>  }
>> @@ -112,9 +661,22 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>>  	int ret = 0;
>> +	u64 q;
>> +
>> +	if (x->dir == XFRM_SA_DIR_OUT) {
>> +		q = xtfs->init_delay_ns;
>> +		(void)do_div(q, NSECS_IN_USEC);
>
> Same here.

Removed.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmcmSg0SHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl11MP/0Nd5Jlbu7JE4cj5rAWr30giJw/HdDgc
qKvZbqjq5rnAlFncoNl+3EF6jUwz4owzV9WcKNdz/6FTCNz1S8gUfnMvxiu2eTFG
yHskj8ZsVCHvpHhOJbkZ9RrFga/MoKIXDEOJlRPhc5cve7nnpdjkA9zQOaUFhEQg
Znw5rJ2zjLapi1OUQLgOPl8fdxI3fpZPK2+Lu74QMbPdfp+qF1A1x74dF3j6w6kw
tIeXHRYD3+EHNCAM1n/jyRRNnrbotAH/AY2x9lqG9mK6rluXSDdmedcMVcryZ55B
XsJKaVkkWRAYHNTXAdxj48fLC0fMRBPaOEIuPivD2er5sqBUNVYPzTlDDEDCEBlf
QEpv8VFGR/wtKR8wStZ1SB8AG2/zn7rDlkSAlx4JXU9HiTGalQOmOhXgcYba1STn
ueagFxHNZGGBgq6GNKbLJo4a+hLRXTBwUskw/wumcorQTw781fAU2SJCdr0oC3CR
+akmVgpV9OiINWRq491i1JFMaong0YDWzPd2dD7Nri6At4DwR3nCN6xjHzlvhhi3
qT65yciom6SK8beeOFWOruOa2PrQnxEK4OPeK4s3eBMayW9Af4fpFDeh5PkxsyLp
m0FvHzRt0R02C3p1tFm2hco/3+Y3gdUzfHN9ki/zin39BWjq5YVBjudzRpBcPoOo
lvNWg/316wP7
=vTFN
-----END PGP SIGNATURE-----
--=-=-=--

