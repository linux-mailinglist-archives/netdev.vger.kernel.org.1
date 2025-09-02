Return-Path: <netdev+bounces-219255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C0B40CCF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F5C2040E4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8D34574D;
	Tue,  2 Sep 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5oYE7px"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E942147E6;
	Tue,  2 Sep 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836518; cv=none; b=mTqXnRbHTDl/FRRJRYZe97gBV9oZbldOpVPjZHlFrcb0pmtVxZUZXXVM7uZDUX4LpdLudL+ibN7QO7esDEkpj1pM5D+IUunK3+ex0beOXUg3Oh1aNWL1n3qKvOhRw8Bj2kwfaWz50REJZqwWupT3dRLNMNuozXy2UXuS3gszIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836518; c=relaxed/simple;
	bh=G/hFyjsUgH4GWNf5QnwrK4OywncU7EgVeBEHnvSYw4A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hBjpXET5NAb2Rlg1HYypwqjeSK6ss0vU9KDzVj0nk2Vo76yz/n5i7+DPDGzeOk+31Mg9ppjtBB/pfJYPCYx9t1AlDUIPoghSXYIUp55GHeeGpt1Erfht9EBeFc33em9t1wbm62JfuwOb9IqkoxGGpZjQw4XB3X0vzGvtlaFvlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5oYE7px; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1460282241.2;
        Tue, 02 Sep 2025 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836516; x=1757441316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIUgGAPPy62crHHZnIopACR+mf4bG1ceEUjwPX9P9u8=;
        b=W5oYE7pxx87KWaH5mh4oLXV7lnCkjrMO0DB7G6vZSIAaW+YdyCSDxqP+uvaayGB3KU
         h0JRXcAeF86H1dSd9HlBk2rZKw+PxX0jiZphXaq8YagsunAHzWEe+ZDDVtOq/LISl7eM
         OfX3cQukKjw0lccNGmT5vlEy/iGDG4zMJaRQ+3K73pfjWjSJaAs485zMk8Qpd5WywuUn
         YZZJK+0KMPwU/3eMYUL3Zjp8HPO7CI4sDQLO1EbaAtY0iV+ckK0ZYNCwwSJUrXcUV27m
         lAV2ssOunYCjMWYhTdogN7LGGGVYCuWAT1jcKlU7EOHnh/Ivxez+AD/y7KvALnRWuWfB
         ULQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836516; x=1757441316;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YIUgGAPPy62crHHZnIopACR+mf4bG1ceEUjwPX9P9u8=;
        b=kfVOqFmnllt4H/j/Nlw5cZhaNi1juGyFaCLmTVKUNpwNS94x/qR+fMhv/paV0xiERF
         i1gvOSrFdNm6liJ0ianz95Fc4vjJckdFm2N0uwJQxcvTkqw4y+06h3KcfUw8+f5Ha2LJ
         DEG+HW76TzdySGmB/aLUy/lzD1mFqzq5XhA3b2n40j9+Ygk+5wFwRxVYCjbEuCQ9yXY0
         f41k86vI+lSsLUGrNZG00vKu5qFvBYwDhuj/6xg1M+zE0lAr2YoXYkpGSRe+7/uQe4X6
         Bnm1T1a+QaaPz+EiqiqwcQsdcFidBYG4J+d18CLy2D9qPxw1vepWpwHMxff6TWy+mc/e
         kkWA==
X-Forwarded-Encrypted: i=1; AJvYcCVJxStB6NO5J8cmkfZG9IAUT7DH+lo7Lf10bbkpz1oc5680/b05N06ne1qUQd+W7GZPib5Gq/z0@vger.kernel.org, AJvYcCXYCmyURIm4bEwE5/U9AK/c2FvoheN6od5kp//K+2yrrMwM+9rZNnnurXiptbfKPl4LSpml+4gIUznb34E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHRRgQ16KoN+kCmCQqTt3Xq9mVtsLXvv/XVbTkMy7pjD/nuBL
	OSQN7EFObVGg7ey5lTW8GEkMPSwn/1EYK6B4UznBjDlT3mPXRzcCoh3Z
X-Gm-Gg: ASbGncvdR78YVWjoPv4KYzn0cd88QY3rPrWaE7jdKHkwnVlYi+rSHDj8wpkHsdyW1Yu
	krM6BE2Tm2SU3uMIkwanVk+oc+LQItdNEVb8CTBAebt9n5hjfR5FcQTtg7FtSvWTddHb7cu5dnV
	W6zyoVaQpeNTbdQtiLGLBqnhaHuGDp/VRorNgK3aBS6/QgxzNV1aWrz52L+6YIqz0Qf9Fk10NsG
	HJr6lGkZSpriO1Zg+Qgeicipr59Pu/YnYsWm5kSfUSlTgUWnnmF87Fgo31Q0eMRxD8FGUfbaJot
	LTyW0FJfVYueC58trqYnPDUF8cV529yW1HPgVaj8KuIuQSANEwgg4dSHq9/I5nqMydITj+t4j6/
	ysKwYggJl7w6hEuYq9ykVYgbtJhS2AFgPtgFrtURhiqSn5ugubz9PuxQEekkQWY7SXkUJQOPyD6
	qUoQ==
X-Google-Smtp-Source: AGHT+IHlxmCIyi502ZXSH23GDG5w7QBI0A6f4+Z+3RwlNQEBsCbf3//rYt0qRbGfsm1RpARHOsyHxQ==
X-Received: by 2002:a05:6102:449a:b0:518:9c6a:2c04 with SMTP id ada2fe7eead31-52b1c45098dmr3510266137.31.1756836515631;
        Tue, 02 Sep 2025 11:08:35 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-894e1d08c79sm4723676241.6.2025.09.02.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:08:35 -0700 (PDT)
Date: Tue, 02 Sep 2025 14:08:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 corbet@lwn.net, 
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
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.277f254610c6e@gmail.com>
In-Reply-To: <20250901113826.6508-3-richardbgobert@gmail.com>
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net: gro: only merge packets with
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
>  include/net/gro.h      | 30 +++++++++++++++---------------
>  net/ipv4/tcp_offload.c |  5 ++++-
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 87c68007f949..322c5517f508 100644
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
> @@ -487,19 +484,22 @@ static inline int __gro_receive_network_flush(const void *th, const void *th2,
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
> +	int diff;
>  
> -	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
> -	if (encap_mark)
> -		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
> +	diff = off - NAPI_GRO_CB(p)->network_offset;
> +	flush = __gro_receive_network_flush(th, th2, p, diff, false);
> +	if (NAPI_GRO_CB(p)->encap_mark) {
> +		diff = off - NAPI_GRO_CB(p)->inner_network_offset;
> +		flush |= __gro_receive_network_flush(th, th2, p, diff, true);
> +	}

nit: this diff introduction is not needed. The patch is easier to
parse without the change. Even if line length will (still) be longer.

>  
>  	return flush;
>  }
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index e6612bd84d09..1949eede9ec9 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -471,6 +471,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct tcphdr *th = tcp_hdr(skb);
> +	bool is_fixedid;
>  
>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
> @@ -484,8 +485,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> +	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
> +
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
> -			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
> +			(is_fixedid * SKB_GSO_TCP_FIXEDID);

Similar to how gro_receive_network_flush is called from both transport
layers, TCP and UDP, this is needed in udp_gro_complete_segment too?

Existing equivalent block is entirely missing there.

The deeper issue is that this is named TCP_FIXEDID, but in reality it
is IPV4_FIXEDID and applies to all transport layer protocols on top.

Perhaps not to fix in this series. But a limitation of USO in the
meantime.

>  
>  	tcp_gro_complete(skb);
>  	return 0;
> -- 
> 2.36.1
> 



