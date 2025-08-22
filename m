Return-Path: <netdev+bounces-215955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F1B311E0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13AA1888487
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C092D7DC3;
	Fri, 22 Aug 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkVYBeB8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73888221577
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851510; cv=none; b=Vvjm65PmNGPxLTymcU6Chnf8q/7qxMYjWnbbKcHG1B3tJk5b/YeRnHrBnmRj1IaWESiZU4dMRK2y9Q23CqHufX1WlL5iv2UirOdlNJHRtu34ht7PgRpNUEfaCQt0ve+DElFTcJKt2Bze3d49tp+EYNcUobQU46eiDMMxOAGGJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851510; c=relaxed/simple;
	bh=hqLtAJ9wABRlEYOn9xK6DZ0YTbB/5G/61j0q4mx2/lg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LRTZFw/vyK59sp2cG0ux5la+6VpHxhbeDrbHKTc7qWgAs/zodZWRhCTAkMl9rvn2+Q5RaNLk995VQErU33VpULwXzo29Nm/lsfQLUvMVArdvRCUPpJy4deI0FMwzszXNNfAeHSc5P8B8N0cgvRZaJrpcfoLbZsqoTrbowX2znhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkVYBeB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755851507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBfUDrzwH2ngC4BBoj5LBB/d7iuKHS4QfXfLqrPHiM8=;
	b=IkVYBeB8JJeqI6GUad/g8nICaY6g0zy740TQ/bKLK3auVi6H1J/3hmMi4J0IgTLwrBi5r5
	FAJoX5Cp9I2L+sIyVStOjVOAksEmA1WKGUXT+A62xCFKzZ2sdidEAZj690xUyvugVipGAq
	kj8QTP8Du31aMdy0t+0oJODin26plPs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-O6bHDRCHMSW1Hv0DeHJD0A-1; Fri, 22 Aug 2025 04:31:46 -0400
X-MC-Unique: O6bHDRCHMSW1Hv0DeHJD0A-1
X-Mimecast-MFC-AGG-ID: O6bHDRCHMSW1Hv0DeHJD0A_1755851505
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bf1f37so41538291cf.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851505; x=1756456305;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBfUDrzwH2ngC4BBoj5LBB/d7iuKHS4QfXfLqrPHiM8=;
        b=XvItd/Fhqztt6V8lZKWjQu7yHgvzP4bJ9jr/qtdK6fdGaDx8CEqbmRZKOWGsFJKh9P
         l/ENsnXwMIaqWQt+0pQHzniCcG5HnN2LYjbNPQCFUAUonlOrPAHcDQeuLw/TX0bvaip9
         f7wkRmDGwqtW76wbwNrBD5sDoLXaPRhpEpZe8WPPu0l1Wa7RJh6MN56ycFAcnSNocgFs
         rM20Hgd0wFY8YD4EFmZMuyKDBEiio5P97AFACs0JCvvimbIbFbGYknzUgHnKwFTRIfdC
         01bdz/oDARW6qXA4miYgIksB2hDWkYRcytjghVpVRFP/5neem0F/Cp8CC7AuU1JwjqgB
         /uCA==
X-Forwarded-Encrypted: i=1; AJvYcCXP4/24XwqjrvSLPxI2ibu5q3lhr5h1f8A47QUKyFHENVHKqLCeQR5KID9/+gt5i40zIMT8TUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pj93/0yX1sAn5OTWiWW+NZPgH+m3KWRT2j3KF5VuduZrtGR/
	eoKU3tXrZLKjx3X6NwCWlS8doKFNLxMHJNHSptPlUy0aF5Pnp5XunNUVT5PaLF6xUy3vD5drBPI
	pPczOmyblB5mkBS1Px5JsKZGBjtGFuIOyE6x8EVVXwk2xMIEN9vlLxMIhGQ==
X-Gm-Gg: ASbGnctkmc94Y5giow92V21oc6Jz0pDyUcQ7ULtKIxGoj9U8X/B0+tFV81o1/IYlcg7
	2ojSt4EY7JjQ8YJwFO5ORjmbuQHmZolR/0IcaUvihtkC1riafV3Wt08IlIxnv0YYHVU5Kl+unCw
	yOOtYBICkjTVNjlpwHacPZqoq6KMC9Qc8ZZfPDegPac2L6IirBXqiUdC9qfJMpwyOVvR/yY563z
	Q/Zj5uGjJasG1UnbBuWbALjDjnbqR5BivKTctRcRziKdnv3VJK0lsjvBNq8Kpa5LHF9nAxXnazH
	VyOB2BDm3ZKP3ihXTbbHBMiLh2uh6X8yTcCrRtvh05XTU87jgmszAr3rIb/tLQpph2FI79R0m35
	8tGosYUszhL8=
X-Received: by 2002:a05:622a:50f:b0:4b2:9b6b:2e87 with SMTP id d75a77b69052e-4b2aaa5659dmr26798491cf.37.1755851505351;
        Fri, 22 Aug 2025 01:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgcD8gwiIxzXXKRCMowVi2ZH5iMzFmtaYO9GHaU6rujY/dSEy2icuZXX41HvTRFjjT1QARHA==
X-Received: by 2002:a05:622a:50f:b0:4b2:9b6b:2e87 with SMTP id d75a77b69052e-4b2aaa5659dmr26798031cf.37.1755851504761;
        Fri, 22 Aug 2025 01:31:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1ddd9fsm1306550985a.71.2025.08.22.01.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:31:44 -0700 (PDT)
Message-ID: <f3084a47-6c63-4ef4-948d-52835fa4c722@redhat.com>
Date: Fri, 22 Aug 2025 10:31:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ecree.xilinx@gmail.com,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-3-richardbgobert@gmail.com>
 <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Content-Language: en-US
In-Reply-To: <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 10:26 AM, Paolo Abeni wrote:
> On 8/21/25 9:30 AM, Richard Gobert wrote:
>> @@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
>>  }
>>  
>>  static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
>> -				 struct sk_buff *p, bool outer)
>> +				 struct sk_buff *p, bool inner)
>>  {
>>  	const u32 id = ntohl(*(__be32 *)&iph->id);
>>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>>  	const u16 count = NAPI_GRO_CB(p)->count;
>>  	const u32 df = id & IP_DF;
>> -	int flush;
>>  
>>  	/* All fields must match except length and checksum. */
>> -	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
>> -
>> -	if (flush | (outer && df))
>> -		return flush;
>> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
>> +		return true;
>>  
>>  	/* When we receive our second frame we can make a decision on if we
>>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>>  	 * an incrementing ID.
>>  	 */
>>  	if (count == 1 && df && !ipid_offset)
>> -		NAPI_GRO_CB(p)->ip_fixedid = true;
>> +		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>>  
>> -	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
>> +	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>>  }
>>  
>>  static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
>> @@ -478,28 +475,30 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>>  }
>>  
>>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
>> -					      struct sk_buff *p, const u16 diff,
>> -					      bool outer)
>> +					      struct sk_buff *p, bool inner)
>>  {
>> -	const void *nh = th - diff;
>> -	const void *nh2 = th2 - diff;
>> +	const void *nh, *nh2;
>> +	int off, diff;
>> +
>> +	off = skb_transport_offset(p);
>> +	diff = off - NAPI_GRO_CB(p)->network_offsets[inner];
>> +	nh = th - diff;
>> +	nh2 = th2 - diff;
>>  
>>  	if (((struct iphdr *)nh)->version == 6)
>>  		return ipv6_gro_flush(nh, nh2);
>>  	else
>> -		return inet_gro_flush(nh, nh2, p, outer);
>> +		return inet_gro_flush(nh, nh2, p, inner);
>>  }
>>  
>>  static inline int gro_receive_network_flush(const void *th, const void *th2,
>>  					    struct sk_buff *p)
>>  {
>> -	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
>> -	int off = skb_transport_offset(p);
>>  	int flush;
>>  
>> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
>> -	if (encap_mark)
>> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
>> +	flush = __gro_receive_network_flush(th, th2, p, false);
>> +	if (NAPI_GRO_CB(p)->encap_mark)
>> +		flush |= __gro_receive_network_flush(th, th2, p, true);
> 
> Minor nit: I'm under the (unverified) impression that the old syntax
> could help the compiler generating better code. What about storing the
> diff in a local variable:
> 
> 	int diff;
> 
> 	diff = skb_transport_offset(p) - NAPI_GRO_CB(p)->network_offset;
> 	flush = __gro_receive_network_flush(th, th2, diff, false);
> 	if (NAPI_GRO_CB(p)->encap_mark)
> 		flush |= __gro_receive_network_flush(th, th2, diff, true);

whoops, I rushed the above. I mean:

	diff = off - NAPI_GRO_CB(p)->network_offset;
	flush = __gro_receive_network_flush(th, th2, p, diff, false);
 	if (NAPI_GRO_CB(p)->encap_mark) {
		diff = off - NAPI_GRO_CB(p)->inner network_offset;
 		flush |= __gro_receive_network_flush(th, th2, diff, true);
	}

/P


