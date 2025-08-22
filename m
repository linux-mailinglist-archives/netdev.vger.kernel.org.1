Return-Path: <netdev+bounces-215954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A448B311DD
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E98272235A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EFD21256B;
	Fri, 22 Aug 2025 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WedoQPa7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997701428E7
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851484; cv=none; b=W5wjPDmCbdcWNKrFyocOf2qVM1Y64or6Z9COAsL3KvCeGxvggwtPCZGip26Wj8WMR+wHM2FCN2CI7ja5VKr0fnVAuPfgK1zVMX3Su0WjYI6UDtdkNx835yVuGGWaLctkLr+dEnfhYMkgkeywQ3TmQwKI6TFAaCV4Ov4fg3lV0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851484; c=relaxed/simple;
	bh=Cu8xo//SuFYNe/yq/cf/lP09igfl1ZhrHUxrSpyAdQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9WpORvFg8KFkZbGlOhVbkusOjyYiIxZPs8dMKXk7lzpFTI5Iaef+6+FlvzPXvNtmY1tXmEyMesOHkmspuowDL20600te49E8u8jihU8qd/NukI4+3UQrpRNi4eBWK5omL/pHKeIEhHD8P/NaFVyXX3qH1hPdt6ZD66LIw3r4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WedoQPa7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755851481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lT0Vt6aiyXs+DEMRvuBBLV7w2IbA5/N0O5+Xoi7IwY4=;
	b=WedoQPa7a3U0P6YgA2itaUUhhuL7cPdVnWAwj4myzZa7f6CJ52JEwXAKXsiQVdGOshx3ei
	E6gXoLbTc/d9Ofo4ydtxwIe3/mECJBLyZfP4+UtZOISE/9HW9KJHJ751Fadmmq4io3fjJe
	lRNYoSRpq1TuZNWp3v5WNNZ2W5OXT9c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-QzjDBZhrPbizvabzwSfGow-1; Fri, 22 Aug 2025 04:26:49 -0400
X-MC-Unique: QzjDBZhrPbizvabzwSfGow-1
X-Mimecast-MFC-AGG-ID: QzjDBZhrPbizvabzwSfGow_1755851209
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-709e7485b3eso57873896d6.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851209; x=1756456009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT0Vt6aiyXs+DEMRvuBBLV7w2IbA5/N0O5+Xoi7IwY4=;
        b=FW86g3dYkvg7DsCyt8mY0buw9xlEyqbBpRCYPfQBJu1yrXG9qMAIiW1HTAltdiQAIb
         14+JnXNb1xQNDPKOAzBPM18imZ/bABMXHJsR5AJN7GvqYBgZ43kTTIQtEduh2Klt6RiJ
         hOX4v+iXc4WGiiKq2SCmRfQmfFAKIYWvlFp2kVEzld00PmIRSvMPZWkS7KybLlOtsB37
         BKykU8Sy/oIjQwis5Lu+Mwz6I1L3CZB2FsseayYyL2PiaP5/InJozCFC55ANzL9WNTCG
         Zma+1VN4cvC7kb2jSOLwYS+oG7pD5mIKq3bwZhWvnicZx4Gc1lwN0tROIrHiKdkK24cG
         VZIA==
X-Forwarded-Encrypted: i=1; AJvYcCUxsCEaupwhR24X7+qRyRfa2rL97U47y7P8Vq1+plJRhfJ2Zj8E8g9+hoLAs8Fq3UExR7PAEsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JAu/a89jRbsuVYN4j/BGE7oJ4e9DfoFTYp2OAmaFhZDKtGqu
	7MgEOVlWWzcWjb6htB5wS/Om+yU/tcsoT8Z4O+Fe8lhQ11bXw6raxd+ur5U91TkuxyBLQdK8J08
	sE+sY1HNTkSw62TKXtS0CS+aCyaR3MdcPgKgd/sJab4Y8PqlmhhPi4JTTaw==
X-Gm-Gg: ASbGncvTSN6Rmg3FL4hll2UeamsqOOUH/WwlH6GdKKKUHQAPi4jsPeIEhVDoT3y/j9Y
	liW4ECKo+0/74l97aUZ0NtTt5+ToIp8NYZdH4bBiOrFOYTlb4P5U3kipjgNg07aHSYyFvRAWqYw
	RVtbX3rV88J85cN4QsPeHenf+e9dBtfDZOqS2DeGX+/8yUMzWhl1ZGCguYgxHlALMJyu/8/JWAC
	w7vqq6H6RMUgAtg2Cr3gAiT8BOk7kEu+Ei8CbClij43OwXuVzCkEUeUw7FhPExdhp6Q+aYfY8Wh
	EBSeJfgBbBymzvm94efy5cH0TU4Il2FC2DRksC7XQNOLwj5PURg6qLTEcf0/RWr48kBnGpQ3YhR
	zOnY317yEXk0=
X-Received: by 2002:a05:6214:dcf:b0:704:a1c6:fff3 with SMTP id 6a1803df08f44-70d893b7e8cmr65023856d6.15.1755851209042;
        Fri, 22 Aug 2025 01:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbuSV5M3uUv5uKHoyxUj5Lwj/G/7tQhGlA5XRvn/4WeYWUt+BF1kAeN6hrGRVpk3imrKmvZg==
X-Received: by 2002:a05:6214:dcf:b0:704:a1c6:fff3 with SMTP id 6a1803df08f44-70d893b7e8cmr65023666d6.15.1755851208545;
        Fri, 22 Aug 2025 01:26:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9086433sm121691916d6.24.2025.08.22.01.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:26:48 -0700 (PDT)
Message-ID: <d986135a-d0ee-4878-9fc2-958f35d569da@redhat.com>
Date: Fri, 22 Aug 2025 10:26:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250821073047.2091-3-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 9:30 AM, Richard Gobert wrote:
> @@ -442,29 +442,26 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
>  }
>  
>  static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
> -				 struct sk_buff *p, bool outer)
> +				 struct sk_buff *p, bool inner)
>  {
>  	const u32 id = ntohl(*(__be32 *)&iph->id);
>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>  	const u16 count = NAPI_GRO_CB(p)->count;
>  	const u32 df = id & IP_DF;
> -	int flush;
>  
>  	/* All fields must match except length and checksum. */
> -	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
> -
> -	if (flush | (outer && df))
> -		return flush;
> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
> +		return true;
>  
>  	/* When we receive our second frame we can make a decision on if we
>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>  	 * an incrementing ID.
>  	 */
>  	if (count == 1 && df && !ipid_offset)
> -		NAPI_GRO_CB(p)->ip_fixedid = true;
> +		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>  
> -	return ipid_offset ^ (count * !NAPI_GRO_CB(p)->ip_fixedid);
> +	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>  }
>  
>  static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
> @@ -478,28 +475,30 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>  }
>  
>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
> -					      struct sk_buff *p, const u16 diff,
> -					      bool outer)
> +					      struct sk_buff *p, bool inner)
>  {
> -	const void *nh = th - diff;
> -	const void *nh2 = th2 - diff;
> +	const void *nh, *nh2;
> +	int off, diff;
> +
> +	off = skb_transport_offset(p);
> +	diff = off - NAPI_GRO_CB(p)->network_offsets[inner];
> +	nh = th - diff;
> +	nh2 = th2 - diff;
>  
>  	if (((struct iphdr *)nh)->version == 6)
>  		return ipv6_gro_flush(nh, nh2);
>  	else
> -		return inet_gro_flush(nh, nh2, p, outer);
> +		return inet_gro_flush(nh, nh2, p, inner);
>  }
>  
>  static inline int gro_receive_network_flush(const void *th, const void *th2,
>  					    struct sk_buff *p)
>  {
> -	const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
> -	int off = skb_transport_offset(p);
>  	int flush;
>  
> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
> -	if (encap_mark)
> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
> +	flush = __gro_receive_network_flush(th, th2, p, false);
> +	if (NAPI_GRO_CB(p)->encap_mark)
> +		flush |= __gro_receive_network_flush(th, th2, p, true);

Minor nit: I'm under the (unverified) impression that the old syntax
could help the compiler generating better code. What about storing the
diff in a local variable:

	int diff;

	diff = skb_transport_offset(p) - NAPI_GRO_CB(p)->network_offset;
	flush = __gro_receive_network_flush(th, th2, diff, false);
	if (NAPI_GRO_CB(p)->encap_mark)
		flush |= __gro_receive_network_flush(th, th2, diff, true);

?

/P


