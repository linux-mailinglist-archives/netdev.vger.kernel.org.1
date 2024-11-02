Return-Path: <netdev+bounces-141229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86089BA166
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230901C20AAC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DF19D07C;
	Sat,  2 Nov 2024 16:26:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79067155336
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730564812; cv=none; b=aaoohVEDqU+047Uwc8BJnmQy/CUB2AinKX1wRswNMKmB/Uw+sJOUJqkbVKdpGU8xhTsEWyPkCHoPXc9mftr+UuuXgTp2lKed+W+TKvZD1s2ijo4Br0DGfxFX6T8Cw1h+qknCNUkXCIig1eMyHRtVoP59bZqS/nE3ECi3xI/JInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730564812; c=relaxed/simple;
	bh=AiNreFk6Y4Zo/uFJGvxRLQe67Sk6v6yoOTHnTIfQNlo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=AEDqhIWq/e948esrexU9nOVMTythIvo9rrhnm7AIrd5Fc34nhQBCHIjHUxqAM1n2jLP2aDIKo6J3ADt3Y4L/MnoEpkxsljw+YW+0vRi/cCQKraI1cqJ/l9RuliRV0TJ1Z0Hkt+Xhhbue20Bj4B+hqRFGcuG6WU/ALzfosHoQDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [185.122.134.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 494D47D08A;
	Sat,  2 Nov 2024 16:26:49 +0000 (UTC)
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-15-chopps@chopps.org>
 <ZxYvWDFrdSMn8iVF@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
 <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 14/16] xfrm: iptfs: add skb-fragment
 sharing code
Date: Sat, 02 Nov 2024 16:26:35 +0000
In-reply-to: <ZxYvWDFrdSMn8iVF@gauss3.secunet.de>
Message-ID: <m2msihiou0.fsf@chopps.org>
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

> On Mon, Oct 07, 2024 at 09:59:26AM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Avoid copying the inner packet data by sharing the skb data fragments
>> from the output packet skb into new inner packet skb.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 312 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 304 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> index 4c95656d7492..ef4c23159471 100644
>> --- a/net/xfrm/xfrm_iptfs.c
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -81,6 +81,9 @@
>>  #define XFRM_IPTFS_MIN_L3HEADROOM 128
>>  #define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
>>
>> +/* Min to try to share outer iptfs skb data vs copying into new skb */
>> +#define IPTFS_PKT_SHARE_MIN 129
>> +
>>  #define NSECS_IN_USEC 1000
>>
>>  #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
>> @@ -236,10 +239,261 @@ static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
>>  	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
>>  }
>>
>> +/**
>> + * struct iptfs_skb_frag_walk - use to track a walk through fragments
>> + * @fragi: current fragment index
>> + * @past: length of data in fragments before @fragi
>> + * @total: length of data in all fragments
>> + * @nr_frags: number of fragments present in array
>> + * @initial_offset: the value passed in to skb_prepare_frag_walk()
>> + * @pp_recycle: copy of skb->pp_recycle
>> + * @frags: the page fragments inc. room for head page
>> + */
>> +struct iptfs_skb_frag_walk {
>> +	u32 fragi;
>> +	u32 past;
>> +	u32 total;
>> +	u32 nr_frags;
>> +	u32 initial_offset;
>> +	bool pp_recycle;
>
> This boll creates a 3 byte hole. Better to put it to the end.

Moved.

Thanks,
Chris.

>> +	skb_frag_t frags[MAX_SKB_FRAGS + 1];
>> +};

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmcmUscSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlJKIP/1vU/8xCG2m0XkSg5NwxCyncG+1pJQSF
kac+1AG/lr6VfSLOYzpyOe7Rm63sxzozJ4rY0Ivu+wXT832YzMYPi2bUbfKe1qkn
d1MTWVYY4UlEdWZ/XjoEg2oLSpGK1bj1wZP5ac6wI6M17kxZjPnxGRSjoN9Z7POG
xV1Z8ZF9Vk4z0D9002qm2k2REsUbYu4QdNPTOWpc3O0VuN+OS/nunVgtrSNqZj5b
wgC6smgcr8m4zIQctp3kqy+GoiOXISNQ9iPu+Vze8TqIBKSR6BGMVwvcXsaWYBTN
hrXHl9dMiByJ/D9yvPgXdX5JjS5szfgsc3/8ASK5guRBvSBHJYoqzd29eGCX9fEW
piCw/NNRoBskbU+mDqgoMjQT4BncPl/C8dnlHADrrA3AP5A7OhFASA6jSBvaEslK
YUM9Y0VU2nYKbgPETSwJRIMao2FJzr+bUq2K2KlBtY2Q6Lu4hUqoqpjFBKGkkCM3
Qa/EDauV6zhfOM/89zvachNgbhFAyzh9joKiVWcl39b/a82xz45Tb8Tq9j+9QIx+
nnZqD0UsWD/eXlACtZUblb6rNl4Ovq/v5GbR3lB6PAdii1H/cZppoNSjaHsZxxqk
o0YX5v3APFPpcLxxlv56CJJCxZbfwwxdhkYcp5CjtgNt9c02DnqpJVTgQbyWKkXK
LW8IY9L46fiW
=cniL
-----END PGP SIGNATURE-----
--=-=-=--

