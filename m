Return-Path: <netdev+bounces-34846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199947A577B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6288D2816B7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3D8470;
	Tue, 19 Sep 2023 02:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBD1105
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BADC433C7;
	Tue, 19 Sep 2023 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695091708;
	bh=2755jxFkicCTn1c48CUYFE/Jy+ctGV/scn1ufTSgoSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eJk9Dm5XRqqK09RIwCsCDXeqTz7gty9GU76ALkzwS8FJ2hS0tNsnh/ZV+w4FOQpWD
	 kX0sNfDSCYK21iL/CFOwIpr3aFsolal0A2UuAoobM8EgYR9uoLo25lW4xi3BDKrag1
	 fL9LUt0+UjSqClHfInSUj7IhOEdhHhiJ/EVE+glogMjbG3dqATm6IiVAktrZ9sLcOR
	 TVIJPn0gVH9FcN9eIfmuzzMguFzdwz0n3v6l0r1RaItMY45sukNd45aiLSyRTVhOeL
	 vlsNRF9S+lq1h6k9lzqQMRbeMmtgkVwIvR0mGHf+GnIAcpUYYlp4OGMdAbTA2+46aU
	 l13OrlGuSTZXw==
Message-ID: <6196a7af-dd0f-a35f-df3f-56dce277b9bc@kernel.org>
Date: Mon, 18 Sep 2023 20:48:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] ipv6: lockless IPV6_ADDR_PREFERENCES
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230918142321.1794107-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230918142321.1794107-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/23 8:23 AM, Eric Dumazet wrote:
> We have data-races while reading np->srcprefs
> 
> Switch the field to a plain byte, add READ_ONCE()
> and WRITE_ONCE() annotations where needed,
> and IPV6_ADDR_PREFERENCES setsockopt() can now be lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h     |  2 +-
>  include/net/ip6_route.h  |  5 ++---
>  include/net/ipv6.h       | 20 +++++++-------------
>  net/ipv6/ip6_output.c    |  2 +-
>  net/ipv6/ipv6_sockglue.c | 19 ++++++++++---------
>  net/ipv6/route.c         |  2 +-
>  6 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 09253825c99c7a94c4c8a3f176f0ceecd0b166bc..e400ff757f136e72e81277d48063551e445b4970 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -243,7 +243,7 @@ struct ipv6_pinfo {
>  	} rxopt;
>  
>  	/* sockopt flags */
> -	__u8			srcprefs:3;	/* 001: prefer temporary address
> +	__u8			srcprefs;	/* 001: prefer temporary address
>  						 * 010: prefer public address
>  						 * 100: prefer care-of address
>  						 */
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index b1ea49900b4ae17cb3436f884e26f5ae3a7a761c..28b0657902615157c4cbd836cc70e0767cf49a4d 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -53,13 +53,12 @@ struct route_info {
>   */
>  static inline int rt6_srcprefs2flags(unsigned int srcprefs)
>  {
> -	/* No need to bitmask because srcprefs have only 3 bits. */
> -	return srcprefs << 3;
> +	return (srcprefs & IPV6_PREFER_SRC_MASK) << 3;
>  }
>  
>  static inline unsigned int rt6_flags2srcprefs(int flags)
>  {
> -	return (flags >> 3) & 7;
> +	return (flags >> 3) & IPV6_PREFER_SRC_MASK;
>  }
>  
>  static inline bool rt6_need_strict(const struct in6_addr *daddr)
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index bd115980809f386a7d38a5471d8d636f25ce1eba..b3444c8a6f744c17052a9fa1c85d54c6b08a1889 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1306,10 +1306,13 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
>  	inet6_set_bit(RECVERR6, sk);
>  }
>  
> -static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
> +#define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
> +			      IPV6_PREFER_SRC_COA)
> +
> +static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
>  {
> +	unsigned int prefmask = ~IPV6_PREFER_SRC_MASK;
>  	unsigned int pref = 0;
> -	unsigned int prefmask = ~0;
>  
>  	/* check PUBLIC/TMP/PUBTMP_DEFAULT conflicts */
>  	switch (val & (IPV6_PREFER_SRC_PUBLIC |

Unfortunate that address preference details are spread across 3 non-uapi
header files, but that is a change for a different patch.

Reviewed-by: David Ahern <dsahern@kernel.org>



