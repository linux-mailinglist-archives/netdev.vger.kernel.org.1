Return-Path: <netdev+bounces-207053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63776B05773
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837693A8BFC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D9231A30;
	Tue, 15 Jul 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow/mOCu+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC82BA42
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573960; cv=none; b=ir4Omesjh+9HRvuSF4jwGdLPIo70v4GyC5lyJ7XNw+7qEkJAADOa8wNjRVVFYh3nSnS3vRVTrQIEMvVMNupSQFdpIdJFLgAZJxW7ygIZN3Pi+8d2P5T0DnLqHp3U4a7uCpzr7A08GWl/sYQtyL9EmwnLrsarTVTMdamYFJi/EXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573960; c=relaxed/simple;
	bh=BKM3c2HN52dkYzElpIbNy+rlv/PBta3lyZTzXdkClcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+5D3xpp2TtwF/l7QgXiViW1XkD5ZiWSu9nzWXYueY5492+5k+VHb6wOj3c4FwuseSiYBrl+TidtgoR9ElFHacF5iu4lM3ZV2g4DNZAGFwEuo5JfdMOq7VbxGa1uQivBcXIbZu25PhqTMEOohAuUFi6iTxy+sggoQJdjDyiKHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ow/mOCu+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNEezTBowS9yRXOKkgc/JNGKfKHDVruijS88iSDpTcc=;
	b=Ow/mOCu+JKBwiboQSIbmvKYiWevHFkTsS7+9SXejJo+ekx8H1tLi/WqMM77ymBAy5mDFHi
	XIyW3YxUYkjnFKXq7c4o7IqjudRBQxos48csEGsAtBZbOGHjH6p7JvG/m0ul9mS8qopJxn
	xHLAatnj8qBHsBmnYeBhtfOKRnx7AMI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-W-f_4nBGMhyqmr4TLVYpig-1; Tue, 15 Jul 2025 06:05:56 -0400
X-MC-Unique: W-f_4nBGMhyqmr4TLVYpig-1
X-Mimecast-MFC-AGG-ID: W-f_4nBGMhyqmr4TLVYpig_1752573955
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso33900445e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 03:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573955; x=1753178755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNEezTBowS9yRXOKkgc/JNGKfKHDVruijS88iSDpTcc=;
        b=H22u2hMQIs/9X4gXrp1p5WsVmYKXUy9cggVHNaCAH4duSImcyY/sYr7lXOa45ZkyT5
         RjhfOOwzOYptNsP+cxU3hW0ERxss0FAzqEUHAeZMRpvBKFm5Zn63a1FLid3ZBilXz7xt
         fcCIP0imUoiCYIzVlW0rFZ1NBDUpONKdLxwUtPLfhFnRWx8zqRcoTcVrPBprMNVeZqOt
         OS4+25hUoTOjVw/InFOWaqRF4kVlpmcMrvOhm39ZfAQ6YV+LBN2sHOt+H0p+2SH14xhG
         4J/YaLhHamiIVenfwLV+Je21GBCC/FaDLRmVSCMghMiuZgVfCk9ysKt4w9KT+2InPM+8
         5nvg==
X-Gm-Message-State: AOJu0YxF0v/GYeQsGwpNMXSFKc/xb1gqMWi+LNaXZoUJE3HDzMlyteaD
	y9duhU7AKLc3r67t0+boJPmJG48VHjFrLsMsXce7BZsi+T6Ry9SjtG9MMfIM8GD0Ru3c83kGudr
	dXgRynlT7JR99dv386LSUS1HcJ/vsX5fllnvOvrMCULfvgWdrZT1KC9EJeg==
X-Gm-Gg: ASbGncviuWlbOeFmdCK59twCwW2PPEN/9O7C0diUP5P5CKmTptIc9UyNk3CgvvRtzq/
	K+Nfr/Y5RhaowrMN3LFuI+xNLHJmI38YJtwpqRgyLKOoU/Q6nVNkK0JrBwHbuOjweB89D3O7d9l
	ophEf8INYiMHhqVSjrbt2BX8JVA03X4yFYBWjDg1ze5VkUsaQQz4iTES4z5jaV6prlogXxql4xS
	VyHCTPO8vTm8t15HWBTNTDOOmBoZ2K+R21rZhWoCS5O4e6A3hop9nNEGH6JvsWS3Ava+DeNp7pl
	l2r5Thr4XyLHguib44Xd23cxGbV09c/7NsUyKoEtjPC4sH8vSmIgXJANgKqZDx4fGSGUiAgz2ar
	+x4gjTWAXK6w=
X-Received: by 2002:a05:600c:1c14:b0:456:28f4:a576 with SMTP id 5b1f17b1804b1-45628f4a959mr12009635e9.27.1752573955107;
        Tue, 15 Jul 2025 03:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmyuB/ZfovPAaLTvxhqsmz3BK7RhvZRbgnWKTdPcf/VszsyoEiXJ5k/f5bxr/8KH4UZ9S7JA==
X-Received: by 2002:a05:600c:1c14:b0:456:28f4:a576 with SMTP id 5b1f17b1804b1-45628f4a959mr12009295e9.27.1752573954617;
        Tue, 15 Jul 2025 03:05:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm195814555e9.7.2025.07.15.03.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:05:54 -0700 (PDT)
Message-ID: <151b85fe-72a2-4eb4-9aef-4e3b13b1c8ff@redhat.com>
Date: Tue, 15 Jul 2025 12:05:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] net: mctp: Use hashtable for binds
To: Matt Johnston <matt@codeconstruct.com.au>,
 Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
 <20250710-mctp-bind-v4-5-8ec2f6460c56@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710-mctp-bind-v4-5-8ec2f6460c56@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 10:55 AM, Matt Johnston wrote:
> Ensure that a specific EID (remote or local) bind will match in
> preference to a MCTP_ADDR_ANY bind.
> 
> This adds infrastructure for binding a socket to receive messages from a
> specific remote peer address, a future commit will expose an API for
> this.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> 
> ---
> v2:
> - Use DECLARE_HASHTABLE
> - Fix long lines
> ---
>  include/net/netns/mctp.h | 20 +++++++++---
>  net/mctp/af_mctp.c       | 11 ++++---
>  net/mctp/route.c         | 81 ++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 87 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/netns/mctp.h b/include/net/netns/mctp.h
> index 1db8f9aaddb4b96f4803df9f30a762f5f88d7f7f..89555f90b97b297e50a571b26c5232b824909da7 100644
> --- a/include/net/netns/mctp.h
> +++ b/include/net/netns/mctp.h
> @@ -6,19 +6,25 @@
>  #ifndef __NETNS_MCTP_H__
>  #define __NETNS_MCTP_H__
>  
> +#include <linux/hash.h>
> +#include <linux/hashtable.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>  
> +#define MCTP_BINDS_BITS 7
> +
>  struct netns_mctp {
>  	/* Only updated under RTNL, entries freed via RCU */
>  	struct list_head routes;
>  
> -	/* Bound sockets: list of sockets bound by type.
> -	 * This list is updated from non-atomic contexts (under bind_lock),
> -	 * and read (under rcu) in packet rx
> +	/* Bound sockets: hash table of sockets, keyed by
> +	 * (type, src_eid, dest_eid).
> +	 * Specific src_eid/dest_eid entries also have an entry for
> +	 * MCTP_ADDR_ANY. This list is updated from non-atomic contexts
> +	 * (under bind_lock), and read (under rcu) in packet rx.
>  	 */
>  	struct mutex bind_lock;
> -	struct hlist_head binds;
> +	DECLARE_HASHTABLE(binds, MCTP_BINDS_BITS);

Note that I comment on patch 2/8 before actually looking at this patch.

As a possible follow-up I suggest a dynamically allocating the hash
table at first bind time.

>  
>  	/* tag allocations. This list is read and updated from atomic contexts,
>  	 * but elements are free()ed after a RCU grace-period
> @@ -34,4 +40,10 @@ struct netns_mctp {
>  	struct list_head neighbours;
>  };
>  
> +static inline u32 mctp_bind_hash(u8 type, u8 local_addr, u8 peer_addr)
> +{
> +	return hash_32(type | (u32)local_addr << 8 | (u32)peer_addr << 16,
> +		       MCTP_BINDS_BITS);
> +}
> +
>  #endif /* __NETNS_MCTP_H__ */
> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> index 20edaf840a607700c04b740708763fbd02a2df47..16341de5cf2893bbc04a8c05a038c30be6570296 100644
> --- a/net/mctp/af_mctp.c
> +++ b/net/mctp/af_mctp.c
> @@ -626,17 +626,17 @@ static int mctp_sk_hash(struct sock *sk)
>  	struct net *net = sock_net(sk);
>  	struct sock *existing;
>  	struct mctp_sock *msk;
> +	u32 hash;
>  	int rc;
>  
>  	msk = container_of(sk, struct mctp_sock, sk);
>  
> -	/* Bind lookup runs under RCU, remain live during that. */
> -	sock_set_flag(sk, SOCK_RCU_FREE);
> +	hash = mctp_bind_hash(msk->bind_type, msk->bind_addr, MCTP_ADDR_ANY);
>  
>  	mutex_lock(&net->mctp.bind_lock);
>  
>  	/* Prevent duplicate binds. */
> -	sk_for_each(existing, &net->mctp.binds) {
> +	sk_for_each(existing, &net->mctp.binds[hash]) {
>  		struct mctp_sock *mex =
>  			container_of(existing, struct mctp_sock, sk);
>  
> @@ -648,7 +648,10 @@ static int mctp_sk_hash(struct sock *sk)
>  		}
>  	}
>  
> -	sk_add_node_rcu(sk, &net->mctp.binds);
> +	/* Bind lookup runs under RCU, remain live during that. */
> +	sock_set_flag(sk, SOCK_RCU_FREE);
> +
> +	sk_add_node_rcu(sk, &net->mctp.binds[hash]);
>  	rc = 0;
>  
>  out:
> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index a20d6b11d4186b55cab9d76e367169ea712553c7..69cfb0e6c545c2b44e5defdfac4e602c4f0265b1 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -40,14 +40,45 @@ static int mctp_dst_discard(struct mctp_dst *dst, struct sk_buff *skb)
>  	return 0;
>  }
>  
> -static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
> +static struct mctp_sock *mctp_lookup_bind_details(struct net *net,
> +						  struct sk_buff *skb,
> +						  u8 type, u8 dest,
> +						  u8 src, bool allow_net_any)
>  {
>  	struct mctp_skb_cb *cb = mctp_cb(skb);
> -	struct mctp_hdr *mh;
>  	struct sock *sk;
> -	u8 type;
> +	u8 hash;
>  
> -	WARN_ON(!rcu_read_lock_held());
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	hash = mctp_bind_hash(type, dest, src);
> +
> +	sk_for_each_rcu(sk, &net->mctp.binds[hash]) {
> +		struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
> +
> +		if (!allow_net_any && msk->bind_net == MCTP_NET_ANY)
> +			continue;
> +
> +		if (msk->bind_net != MCTP_NET_ANY && msk->bind_net != cb->net)
> +			continue;
> +
> +		if (msk->bind_type != type)
> +			continue;
> +
> +		if (!mctp_address_matches(msk->bind_addr, dest))
> +			continue;
> +
> +		return msk;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
> +{
> +	struct mctp_sock *msk;
> +	struct mctp_hdr *mh;
> +	u8 type;
>  
>  	/* TODO: look up in skb->cb? */
>  	mh = mctp_hdr(skb);
> @@ -57,20 +88,36 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
>  
>  	type = (*(u8 *)skb->data) & 0x7f;
>  
> -	sk_for_each_rcu(sk, &net->mctp.binds) {
> -		struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
> -
> -		if (msk->bind_net != MCTP_NET_ANY && msk->bind_net != cb->net)
> -			continue;
> -
> -		if (msk->bind_type != type)
> -			continue;
> -
> -		if (!mctp_address_matches(msk->bind_addr, mh->dest))
> -			continue;
> +	/* Look for binds in order of widening scope. A given destination or
> +	 * source address also implies matching on a particular network.
> +	 *
> +	 * - Matching destination and source
> +	 * - Matching destination
> +	 * - Matching source
> +	 * - Matching network, any address
> +	 * - Any network or address
> +	 */

Note for a possible follow-up: a more idiomatic approach uses a
compute_score() function that respect the above priority and require a
single hash traversal, see, i.e. net/ipv4/udp.c

/P


