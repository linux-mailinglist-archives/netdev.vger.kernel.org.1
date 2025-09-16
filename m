Return-Path: <netdev+bounces-223269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A4B588D3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D287A588D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC564A00;
	Tue, 16 Sep 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS9B/Hao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534C7483
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981136; cv=none; b=WUy7uTkXNWcXX1SENRt+hGv1cvXKeQl50xgFfGSHhuZU5yPjJdYFiRHDJV65r/ZdWIRv8eNzHw/c4CHv7FGLSylBmzsrlmnmdiFmFJM5EaUXvujA7PwcO1WyHBuinPcdQn2ldhTRpvQk239/OfeEjI9x2hot4yVPHCkW10wP41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981136; c=relaxed/simple;
	bh=9yH2uNEjnGESaIoEDbL9qZv+r/pcqzy8mvD2CAZm0c0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Oe90LeFlDdvJEDErjyUtd2CLwb5Oucov5rIacdxqeiuS5bWCeiv924oMVub3OBtPfWasfmEpvhd4kuhyIvjG6WMZqypGtjitspC3iCGWwxD+kHS56AZFh57GMq4p+M0J4YEofeQ8mzpoYYy0iI2g1QC5lt4BagDqgdmeQUm/xHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS9B/Hao; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-81076e81aabso403579085a.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757981134; x=1758585934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWKvspHTMAjCfrshiX0ZVh1oMuz0siiPdr7nj0Utat0=;
        b=OS9B/HaohauvYgeKIlyIuyznEWt/cEeyXxN7Voc8P1/Pck3b8q1RIJJPLz/YdjC2Pr
         pQ8sqFh98qvZY+Q8rSz8TcNuV/9PY1HjoF+uUsT1tIJ96lQONreQqDVz54sx++hrsumK
         1CzuPXNNe+0BrxXfrA4IE3bD4y5BNzRKDuIn4Eju90cOTUp0g7K+67MI87yCmZGQWGC7
         m5YLc2Ds51u/pLFqBUKT43+kcX1n4Og8gcG3Nn0knFcaCctwqWzhkF0NgXsNwqRk1yPU
         foAgHBcX9zA5hghTKjx0NEA3m4R/rqWvaTSpL4+7CaNoHDGstpzvP2VDwWLX+wSDUn2V
         yP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757981134; x=1758585934;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWKvspHTMAjCfrshiX0ZVh1oMuz0siiPdr7nj0Utat0=;
        b=BqqS1CkBU7gJ3a4w3p2MHDOKZn/gDLAgH2l1sBlJpTrQDCN2nDzF6X6+Nr0L0JbizW
         5JwrWhgngAtzr+BE9Z6UOVo3GVkSJruTeqBUPEbTH378hzvZO6not3gW6zSjco8V73jf
         N+XngJ8R69wnkSrQTHWwex2IbB0sKQcdwUI17vxlBke4c0kPjXtkZeqYFqbjuxbfY5fq
         BBc0asTVJO1d/g1H0tvhUOZXXNQLF8h26l/7D374vvehr4i3hFiU0CeRFxOumBPYtTUf
         2EW/3usmcOvkyeMm9Ws2D/vE6yADHW6wggXS5gJ6WglEv45eSjJLPUwZFlnCUfwNKD9c
         ETbw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Mofycs/Ev3IXG12HOMzpdeuVU4gBlLIZaSfC2Qsozd6PDRDSbODT3eWieD93uE1qzLF5gFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1m2H4/biqrGAhU0XIvhcpDJqnCQePbvDzgoaJ7KG9kHdm6X8
	6A/ttSfZUxuSo1+WqMYywSOyzHYREpMTrtgBCO2uB1IG4c1XC9UiHuY5Ny9iHg==
X-Gm-Gg: ASbGncuJHB3eHKM5JISXcDNe8BhkKt7FQBJlv42jkS0FT7pDPrqRfEyQ7v2RF8bm5W8
	FdaDlfjPO0Nb7JA3CpqYW0l6BLSnsdvw4ycgu/eY8lLVH6LuleqLG2YOU/D4K18GgIHD5swJrqD
	If6zrwizuwPnGPffInk0MK5NJLUpqsjzhLkUD2Ewr7/OzoytGKcJN/w+/H4yuGmIYfTiHsosJCy
	/TJ8N0AADDidgV71ORE71HkfjZ0/S8PCXMzykwTOfSQCNz0JTNKqNIbezXB1cox5KigJa8ip335
	sTuW2BD+Mfv2/7NtxtiQj5jkXrcZfxKSmBzdN7NGWt1IMFc3wEmboo2p6a2WK3E1kORZZfi4JNP
	nDqL6OXH7rzhD2iXTnqxSFdT++3vDEwqCEFHFCi8X6oGkwTm7hAnqMNlxMfCFF70jShWHYGQqnE
	JhpHq2xyFQScQwI7knlxwidVk=
X-Google-Smtp-Source: AGHT+IFlFy7rbANpfUpBYc5/IOq9FxfPcJ4dwrFc8aFxov3YfX0/Ma0uiqhA5Err+G22UYNEMFzW0Q==
X-Received: by 2002:a05:620a:103b:b0:810:731f:32ff with SMTP id af79cd13be357-823ffcb21cemr1838280785a.50.1757981133502;
        Mon, 15 Sep 2025 17:05:33 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dad799sm76753501cf.28.2025.09.15.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:05:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:05:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2939899cac935@gmail.com>
In-Reply-To: <20250915113933.3293-3-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Only merge encapsulated packets if their outer IDs are either
> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
> packets.
> 
> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
> for unencapsulated packets) and one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      | 27 ++++++++++++---------------
>  net/ipv4/tcp_offload.c |  5 ++++-
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 87c68007f949..6aa563eec3d0 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -75,7 +75,7 @@ struct napi_gro_cb {
>  		u8	is_fou:1;
>  
>  		/* Used to determine if ipid_offset can be ignored */
> -		u8	ip_fixedid:1;
> +		u8	ip_fixedid:2;
>  
>  		/* Number of gro_receive callbacks this packet already went through */
>  		u8 recursion_counter:4;
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
> @@ -479,7 +476,7 @@ static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr
>  
>  static inline int __gro_receive_network_flush(const void *th, const void *th2,
>  					      struct sk_buff *p, const u16 diff,
> -					      bool outer)
> +					      bool inner)
>  {
>  	const void *nh = th - diff;
>  	const void *nh2 = th2 - diff;
> @@ -487,19 +484,19 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
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
>  	int off = skb_transport_offset(p);
>  	int flush;
>  
> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
> -	if (encap_mark)
> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
> +	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, false);
> +	if (NAPI_GRO_CB(p)->encap_mark) {
> +		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);
> +	}

no parentheses around single line statements.

