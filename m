Return-Path: <netdev+bounces-84224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5D8961A0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BF81F21702
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF0D27D;
	Wed,  3 Apr 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DcBqJ7oG"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46A5C96
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105386; cv=none; b=PItmB8lERzhjUKEtgJKRB5de2ZQHWvEj8jpDFB3ay3821NsGrBba7E/gdiDue0UIXzG5zyEYifgWwHoWEXbh0ePQzJ7ylfagscA66kx3TTHfUQhlKvQ4v95a/UavNnS2iI3OI2BLomf54r0AU3xxQcsbvBzsevGkkAhmnC15klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105386; c=relaxed/simple;
	bh=4dK7C/kJTg/Koy+Ep9OVvmuPGFqFUCucC4exXTmjsvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdQ8cqQwJwtSHBDXk7vn8EcmQqc9wMwRjWbJvfZKoeSqRckUbg810Bs41fyOVAVcy236DDY3N7jTdbbK90fV0ssNBze2n63ufCnaChNpGqVgF3oUqOKaWmeP77B984YzYbJJ3l/jshNeXg9MvjYSdN40iPDP1zDM3Qzsf2+PyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DcBqJ7oG; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id reqCrGB47HXmArooxrvcB1; Wed, 03 Apr 2024 00:49:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id roowroEklnNCOroowrw6Ep; Wed, 03 Apr 2024 00:49:43 +0000
X-Authority-Analysis: v=2.4 cv=DKCJ4TNb c=1 sm=1 tr=0 ts=660ca7a7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=g72bLlCj1y9NqcwAG1Fglw==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=WFhDUUEJ9-S_0BG-ZiwA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VqSzRgQgO9eTxbwoLbmir62oY7qQGk+N1QEYVP7K5rY=; b=DcBqJ7oGhUHVJmv1gPsIUQNAl7
	TGhTZ2d1xTlXKI8l3Mm2gs3S/F5o+kIMdeV6abMB7a7Yx/uKDpG9HAPmPA3K9oN0m43/BxV7GidmZ
	Mw+F8REthGPeIG4NMLZfwyY7T9bJTCdh2uLGEB6aFqWtk3v7JwaKAhvMWu5g7X5tr8ND1zZ24N0bI
	qqxAN3Spy41t6YxDI8VpccTFlvYmBbao3C5+GRqB5d1hRdC+VKm6vjvWOQFna/i4qN62mXPSSlCbs
	Xp0tjswCddJsaWsbR1n2L733wO1wh/AuSHxuV5S1gmZgr6g0txUzbUj+E8lDLz/vjtbfOPowrOJeB
	FINiheUw==;
Received: from [201.162.240.213] (port=29677 helo=[192.168.166.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rroov-00178Y-2X;
	Tue, 02 Apr 2024 19:49:42 -0500
Message-ID: <d572be26-0217-4522-8cc4-b9c6a62e6f7c@embeddedor.com>
Date: Tue, 2 Apr 2024 18:49:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nfp: Avoid -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgYWlkxdrrieDYIu@neat> <20240401212424.34a9a9cd@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240401212424.34a9a9cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.240.213
X-Source-L: No
X-Exim-ID: 1rroov-00178Y-2X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.166.44]) [201.162.240.213]:29677
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAvuBDFLQCKAxy0Bf/RR821z+xi1gZj+FT5nJd6pmA0EoriIUNuRIeWzJd8ThLbGXqOTngbIDyh6LCxkPi5Z38/sHDVsXYWvtkcQzzIZ85D2gTMi/mv9
 ViW3FW+T1C+4P0l/i6JD3umMpMSnlQGbDDoNxNXV2AZN00kRl66SXEdjup/LCxj9o5bekt8MpuoDE9k4YW8JMZWh3aj78YlrMPg=



On 01/04/24 22:24, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 19:17:10 -0600 Gustavo A. R. Silva wrote:
>> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
>> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
>> @@ -34,8 +34,11 @@ enum nfp_dumpspec_type {
>>   
>>   /* generic type plus length */
>>   struct nfp_dump_tl {
>> -	__be32 type;
>> -	__be32 length;	/* chunk length to follow, aligned to 8 bytes */
>> +	/* New members must be added within the struct_group() macro below. */
>> +	struct_group_tagged(nfp_dump_tl_hdr, hdr,
>> +		__be32 type;
>> +		__be32 length;	/* chunk length to follow, aligned to 8 bytes */
>> +	);
>>   	char data[];
>>   };
> 
> I counted 9 references to nfp_dump_tl->data.
> Better to add:
> 
> static void *nfp_dump_tl_data(struct nfp_dump_tl *spec)
> {
> 	return &spec[1];
> }

Unfortunately, that's out-of-bounds for the compiler, and well, basically
the reason why flex-array members were created in the first place.

I was looking into implementing two separate structs:

struct nfp_dump_tl_hdr {
         __be32 type;
         __be32 length;  /* chunk length to follow, aligned to 8 bytes */
};

struct nfp_dump_tl {
         __be32 type;
         __be32 length;  /* chunk length to follow, aligned to 8 bytes */
	char data[];
};

and at least for structs nfp_dumpspec_csr, nfp_dumpspec_rtsym, nfp_dump_csr, and
nfp_dump_rtsym it'd be a clean change (no need for container_of()), but not for
structs nfp_dumpspec_csr and nfp_dumpspec_rtsym because of some casts from
the flex struct:

nfp_add_tlv_size():
         case NFP_DUMPSPEC_TYPE_ME_CSR:
                 spec_csr = (struct nfp_dumpspec_csr *)tl;
                 if (!nfp_csr_spec_valid(spec_csr))
		...

         case NFP_DUMPSPEC_TYPE_INDIRECT_ME_CSR:
                 spec_csr = (struct nfp_dumpspec_csr *)tl;
                 if (!nfp_csr_spec_valid(spec_csr))
		...

	case NFP_DUMPSPEC_TYPE_RTSYM:
                 spec_rtsym = (struct nfp_dumpspec_rtsym *)tl;
                 err = nfp_dump_single_rtsym(pf, spec_rtsym, dump);

nfp_calc_rtsym_dump_sz():
         spec_rtsym = (struct nfp_dumpspec_rtsym *)spec;


At least for those two structs, it's probably more straightforward to use
struct_group_tagged() and container_of().

--
Gustavo

