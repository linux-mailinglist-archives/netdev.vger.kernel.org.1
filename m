Return-Path: <netdev+bounces-213401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D226B24DFF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A92582BB5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF8270559;
	Wed, 13 Aug 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnKfMmQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0011EA7DD;
	Wed, 13 Aug 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099686; cv=none; b=n46Mp/BfwDsp407QbDDg/gu9PpyObLv5jTUEa9Kc1mJfNoQr85bhIH85Rcm1ybgufdUkYbWgN6e55utW+qz+HP+Y3KN15xChVkblmAL2QdceAMypJTnKuVj0sU/G1Hoh7bAMx9EJb9ERqfS3jdov+fARNmio6TvjmmiREUKvv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099686; c=relaxed/simple;
	bh=5L3HUl5jWlA9jXWrXP75Y2jtyaRYJvTyplJKft2UY9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oy4y5LOWemA/oYtj8uYnA27fw9kIklCkzaCE3JjuTAtAxbq/r7aH74GWsup5jy3r3grCGvvX25n530UYRbG+Ih7H4DxT7csKyIG0AsNomQ30C08RvSJhh9+gO2c8TiH7PedIQxhpZ2uit4iEuySAurOwz6+albzgQIs7cg/RnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnKfMmQl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78315ff04so5700884f8f.0;
        Wed, 13 Aug 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099683; x=1755704483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeHikV3xnaGeBSGEAJ7yjU6cmw7l+465rsoJw5mZMcw=;
        b=bnKfMmQl8BKF1p/wAAkGtmNsvPBmVsJiHv0UyMvcTTxfJNOAXrP1mTK6pNH8gCw/1X
         CurVOJNbc0Ww/zZTrqc6mWjjaTRckpy2k6AZIV2emyYoVoCHKEz/Sg2v5zaRWTjpHS87
         TAUdbKtQJI0ezz6pFGPjiNCuLjzJbqLiFpaeh6tjYtVtVugKek0ENHS2ToVlLd/6xIGH
         elMzsdzfRQbhl+Of7a+4E5q9wos2PSBUzfRc0tw88mUNSBGXUFKEnquBIRXujB1h/0a6
         EvAXR7GLhoWH7EMdVoJQdFltPG+d/+0laQunTJv27qCFFwYh8CAsoaw0Ky89Idn+yXa5
         +qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099683; x=1755704483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AeHikV3xnaGeBSGEAJ7yjU6cmw7l+465rsoJw5mZMcw=;
        b=pyKi+9UMhd7jTGAAv81wwJKZhUm5Je0PsW7sY+SUEAtXm8AmrcdsGfpY6GJDhysVGs
         9ROEizcMOIHAqDXqlbtGjOtX4Ff8hiLNxheePUZqxf42PqoNb+duJ5tglvn5B1wPMofm
         I9hDDqc575rUJ/yodf/sbsW9KtiNYp/7JPYJaq9czMBu6uYFSmUZPKcLbvkDRrOlXLaB
         3rLTHwfpJxb/4srg3G4KtxyWjn2xv4bcLjWykTaWl7XOaL+ucC6Qsa0V1WWgBkATTKY+
         Jeb674BxQ368m/n+3yGqdIhZfGwFGA4+L687Reyw+MjcmLBws/cLyqXjZEdZhPItshaa
         hdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+LvSrpt55ByhE9HVx+fFOC+HWktjfpd43eRxgFE54W8jnllTosBdiEZFcpRhf+T6Y1phAMG8LEz/BNNI=@vger.kernel.org, AJvYcCVno/X0eayw8LGDue9kgM38Qn9HhjtD7iGJCmA/PJccZeNXYAxjr94DeJdH5CFoRHtCRw7qIBoE@vger.kernel.org
X-Gm-Message-State: AOJu0YynXPSb7H9ZPusoZFuk5b65IzcHTJ+xZHZwj2rg0sDmd2ctWCLK
	xgS4sQ2GzNy9GDXFMEeZpfZWTri68gh9rpthIs/+z3uhMLF2x7hvMEq0
X-Gm-Gg: ASbGnctwBHBswBfEn9IjhywXMpLmO5SKMK5VJtCWnKjUKkk2+d1mwrSd/cxXcxVCb1M
	mfRwlw/Jy8mZQymjcERHB7c6Jk+55YpirnyPYIM+4Hje29mIyvPey3HMYKFLgc/pIlItZ84AYv6
	I0j8gNhZhc8KsrklJsod2+XYb76VvFZsIesDzJ/C+xLN8dzkGRzVkaHIMeK4UhWJoYfftEbKIww
	STe49t16OX2CZWxsY9zvx6Z7+EfUFktlyKjKtTr11+R7wwSgorjCoH6rQ2o8Zja94USfa+thDhQ
	truEeQIfoQW8b5zfWxD5fPbko1ZpGuNFeJfJUKzUrHzLgIQWe0FI2t4e0KGCkShvgNg5MkOrGx5
	cSrQpAvclxHCPgH5oYXFBhD3RFuZb+D27G2tZbnIv2lLB
X-Google-Smtp-Source: AGHT+IFedQ8PjY1AQq6CUkCUUTRzFyA8UhME98EKLM8zsrbPu1PpzLpFXzjTCZpugRK6sb8UoFTnUw==
X-Received: by 2002:a5d:584b:0:b0:3b9:1108:8e99 with SMTP id ffacd0b85a97d-3b917ec377dmr2990512f8f.41.1755099683074;
        Wed, 13 Aug 2025 08:41:23 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c470102sm47691782f8f.53.2025.08.13.08.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:41:22 -0700 (PDT)
Message-ID: <088b9c26-482d-49af-bd22-bc870aaae851@gmail.com>
Date: Wed, 13 Aug 2025 17:41:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 3/5] net: vxlan: bind vxlan sockets to their
 local address if configured
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, daniel@iogearbox.net, davem@davemloft.net,
 donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
References: <20250812125155.3808-4-richardbgobert@gmail.com>
 <20250813070758.120210-1-kuniyu@google.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250813070758.120210-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Richard Gobert <richardbgobert@gmail.com>
> Date: Tue, 12 Aug 2025 14:51:53 +0200
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index 15fe9d83c724..12da9595436e 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -78,18 +78,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
>>  }
>>  
>>  /* Find VXLAN socket based on network namespace, address family, UDP port,
>> - * enabled unshareable flags and socket device binding (see l3mdev with
>> - * non-default VRF).
>> + * bound address, enabled unshareable flags and socket device binding
>> + * (see l3mdev with non-default VRF).
>>   */
>>  static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
>> -					  __be16 port, u32 flags, int ifindex)
>> +					  __be16 port, u32 flags, int ifindex,
>> +					  union vxlan_addr *saddr)
>>  {
>>  	struct vxlan_sock *vs;
>>  
>>  	flags &= VXLAN_F_RCV_FLAGS;
> 
> VXLAN_F_LOCALBIND seems to be cleared ?
> 
>>  
>>  	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
>> -		if (inet_sk(vs->sock->sk)->inet_sport == port &&
>> +		struct sock *sk = vs->sock->sk;
>> +		struct inet_sock *inet = inet_sk(sk);
>> +
>> +		if (flags & VXLAN_F_LOCALBIND) {
> 
> Does selftest exercise this path ?
> 
> 
>> +			if (family == AF_INET &&
>> +			    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
>> +				continue;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +			else if (family == AF_INET6 &&
>> +				 ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
>> +					       &saddr->sin6.sin6_addr) != 0)
>> +				continue;
>> +#endif
>> +		}
>> +
>> +		if (inet->inet_sport == port &&
>>  		    vxlan_get_sk_family(vs) == family &&
>>  		    vs->flags == flags &&
>>  		    vs->sock->sk->sk_bound_dev_if == ifindex)

Nice catch. I don't think the new selftest exercises this path, but I'm
running the other vxlan selftests with the localbind option enabled by default
and ensuring that they pass.

