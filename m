Return-Path: <netdev+bounces-214986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E87B2C773
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3343517350C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22327B33A;
	Tue, 19 Aug 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS+1Tugx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916171FF7D7;
	Tue, 19 Aug 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614765; cv=none; b=P+rjtf9CUk3wnF/9wI8uBCisQrZWm7nvwjSfBbgPXjpf555Y1DrfSuEBnLTHgJzSN8eRYigMWJ8ffU4NzR4UwNYWbDWzIZDAG4zhwymgcKIhuerj4UnJarFVKwbTNYRM+QJKV2Y/+UVdzt7II5BJft2tfjIzqicCUfVr577EPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614765; c=relaxed/simple;
	bh=DCZiF8kq04YIUMZs8I7NejSG0j963jBDxvlnKIltYV8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kcmpa3W14XqAR8k9d0/TEZOmvqi6Ks9j5jet9jkRCNTFW3TKxhp7aAb5yAUp0Qq4+wauvolagrdGny1pbQ9jQM5HjXk6/tB4919Al/zs51cJ4TZ1xq0OWsMxl0jSM8jg7hYUdd4wXnSOax+lhGfeLPvPo6+6ws9vLkbIwjox8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS+1Tugx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b121dc259cso27553901cf.1;
        Tue, 19 Aug 2025 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755614762; x=1756219562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBJBj4QZForHlCQsBm5N3P/Zz1khxIZow/yhMUT1I9Q=;
        b=dS+1Tugx96WyNetZ6zVmAhYFCy4Oj0jh4KIi1zsyzd9I6NR1ErokH/+lApSlxNPECW
         yWdHEJQSUMtyOexcvLbm8qcn5vadM/4vFZ4oUB9BrMmpkYjmc7W3lki2Dg0Jz5/shabT
         xlV539s1WsyfnC3ivpcFYpOA1q8iZUhqNkFjKD4KF0ftOQtSjbT735IermK43LeKvorz
         QcGygQNtfGaxsTIWEm+rAk9V5q16Yni8619p6leQx4P4QM19RTnGKDCQ988MbgNA/px9
         jTCTztqlgOz7ot6PBiHghMjx4aDBSWwwSyoa1v5ou6aBRP0aTRGwPdV092ZF5w5oEwsl
         5UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614762; x=1756219562;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBJBj4QZForHlCQsBm5N3P/Zz1khxIZow/yhMUT1I9Q=;
        b=kbx/++2G071ABdXnv/vF5xecS85D5kr65yesjmIR6pfq2uQzw+Hjy51m66xPqixAxN
         OlhZMPHHi+priiJU+GeedWxsDiyfOwb6494WUAdgsnRbFEL52SlbhK0Z/a1erCIZeLrs
         6Vhhg9c23ogpUB3D5Obxcz2fWU1J9f9RB8PNxTOhO7spS9/ls+KHZH+cYWvHr3MQE/0t
         VZLODZWq5AWHKQasrdOy+5XAkv2+1tOLFKJSKQ+yvnnnHy1JPZy3ceqQX2e9Jto8YHTX
         xNVqGbDxbdUuABWCxMXHtgHWtE5qU6mMTf65opDq5Kx+9cFeAVMPv4+BZvThlPOzb6uD
         AXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVFq1YJpvstujWL4xGuAwuPgX5W/Awv66kSKPbyyeJE5zsE9cGyvyXoesBl7IKPSNjl9F6LzylU@vger.kernel.org, AJvYcCX87wF2E7P01RTtBkEDbbd90zn8MooL7zoHWlUdhXynwYtNdc4K4w+EtE3P377iFDlUDLE0CoxFn2TZNto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XeBQexrTBo9d+k/BJ3nDFd0axNbh1BzPh2qw9VrewQAwb16N
	NcbM35pC+jRZFET/nQ1AtSIU9n/VHlCmZSPzrgYkyJqcsBUaxnsWj/0A
X-Gm-Gg: ASbGncvDWyhHc5BrCopTuOiIm198wZFtBBUsYxzMw1ia2RBEfPpeXnBNynvY7BDw3qY
	BwSVblcq5b+yFS8bugB9FQqaliHq2hSuQkxdpsf/EINbI0PnfqjZUAnXbzwZLj+/+M6Ab4eIvxM
	9zINGCP7k2ONybt9ovqqx9umUjPz8/8owvPUq4LA02g0kRrHH/M52hKI5fATAtFoBX6cUrjmcph
	c8/GZcH0Fpx4d7ZlXR53jc3PaJuaqFr6RiXBSgYX32ipPSXodEaCJNnbSE87Aq9emSJCwCvzHaN
	l6XZL5o6Y3iPEFe/ccVu+FGw7YDAngGpxOA5MnrJIEo73ZgQO6GTYXVBTAULsX0P+kfeBqoZYTL
	mIpM8M/QDR15teNXhRg+2gTAlBOqp2n+9Aq68FAwfSIhk8LdWDzCl4M9zFgeADCdCokldAg==
X-Google-Smtp-Source: AGHT+IGc81qdxCSR+PaPZepmyKxyryjgwFGzxpyj5AsgK7mQfH+yLPXu4BapDT/RrPKygy62G8x3Jg==
X-Received: by 2002:a05:622a:1493:b0:4b0:8ac3:a388 with SMTP id d75a77b69052e-4b286c6cb24mr29976311cf.19.1755614762234;
        Tue, 19 Aug 2025 07:46:02 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87dee34f8sm792390485a.0.2025.08.19.07.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:46:01 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:46:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
 shenjian15@huawei.com, 
 salil.mehta@huawei.com, 
 shaojijie@huawei.com, 
 andrew+netdev@lunn.ch, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 ecree.xilinx@gmail.com, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.a8507becb441@gmail.com>
In-Reply-To: <20250819063223.5239-3-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
 <20250819063223.5239-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net: gro: only merge packets with
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
> Add another ip_fixedid bit for a total of two bits: one for outer IDs and
> one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      | 26 +++++++++++---------------
>  net/ipv4/tcp_offload.c |  4 +++-
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 87c68007f949..e7997a9fb30b 100644
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
> @@ -487,19 +484,18 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
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
> +	if (NAPI_GRO_CB(p)->encap_mark)
> +		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);

It's a bit unclear what the meaning of inner and outer are in the
unencapsulated (i.e., normal) case. In my intuition outer only exists
if encapsulated, but it seems you reason the other way around: inner
is absent unless encapsulated. I guess they're equivalent, but please
explicitly comment this choice somewhere.

>  
>  	return flush;
>  }
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index be5c2294610e..74f46663eeae 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -485,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> +	bool is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> +

Variable definition at top of function (or basic block)

>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> -			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
> +			(is_fixedid * SKB_GSO_TCP_FIXEDID);
>  
>  	tcp_gro_complete(skb);
>  	return 0;
> -- 
> 2.36.1
> 



