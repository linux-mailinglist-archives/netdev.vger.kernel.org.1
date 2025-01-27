Return-Path: <netdev+bounces-161193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0219A1DD65
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1954A3A5333
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCD19307F;
	Mon, 27 Jan 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fpEBBoUT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256EA13C809;
	Mon, 27 Jan 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010012; cv=none; b=LJbWHZAkixtLLPzNAaVfsBBIMX9uHjCzIaqGi27Ni6nOMHOf56LY9cI5eJ5v3RjJDd/w+wC20ZJmw+4K/5J6Leb6TdA4NPI5CiAlR+/q1+TWCK7eqciaF85nvvgzVLW+sfiesiab1FpKyCSjYe7ZT6uglJaN32Pre1dyGWWBzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010012; c=relaxed/simple;
	bh=h5Mfsha6RV+ok/4hvmCjqY8+H9ez4iqhw01bRmTvaR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeHrlzE1jJOjNbfmTrDrRIWtFkFBTpxjz4Fd8WhmFLLPPKCJMK4IUtMhC5D7Krk62x7EhAZaY/pTRftkyFqnNtQ/xxoFFQL3MWOlDU3Ksu8kkXmkiEbaOFKZIoJ3svqZTzZIXC21lLeAX0qzae4u6C+z0RS0IbuuYyUxG9024xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fpEBBoUT; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738010012; x=1769546012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJRB2fkV3Ec9keIRywRwl3GBJToYZR9Gl8b7LZe4mUE=;
  b=fpEBBoUTjTnN7LvfMq/XTPzyVPhbbulXQKpUNtTwKe5jzeoG8tKGr3Ry
   0mvUyDJ3cJ+nK+JQp1KkIzIlPOdOOsIvsAseEjaskkWWSHjTQZOBywEcm
   yB+KBPyvzgpoxmTcbgQpKvdb0BvfZyDY/jYW/eb0Q2LZYYaGD/ZlKug52
   o=;
X-IronPort-AV: E=Sophos;i="6.13,239,1732579200"; 
   d="scan'208";a="713971303"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 20:33:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:5901]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.79:2525] with esmtp (Farcaster)
 id ccd31726-a0db-401c-95be-cf1a69b8b518; Mon, 27 Jan 2025 20:33:26 +0000 (UTC)
X-Farcaster-Flow-ID: ccd31726-a0db-401c-95be-cf1a69b8b518
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 20:33:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 20:33:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <david.laight.linux@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <krisman@suse.de>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <lmb@isovalent.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <tom@herbertland.com>
Subject: Re: [PATCH net 1/2] udp4: Rescan udp hash chains if cross-linked.
Date: Mon, 27 Jan 2025 12:33:04 -0800
Message-ID: <20250127203304.65501-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250127194024.3647-2-david.laight.linux@gmail.com>
References: <20250127194024.3647-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: David Laight <david.laight.linux@gmail.com>
Date: Mon, 27 Jan 2025 19:40:23 +0000
> udp_lib_rehash() can get called at any time and will move a
> socket to a different hash2 chain.
> This can cause udp4_lib_lookup2() (processing incoming UDP) to
> fail to find a socket and an ICMP port unreachable be sent.
> 
> Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
> that the 'end if list' marker was on the correct list.

I think we should use hlist_nulls for hash2 as hash4.

---8<---
commit dab78a1745ab3c6001e1e4d50a9d09efef8e260d
Author: Philo Lu <lulie@linux.alibaba.com>
Date:   Thu Nov 14 18:52:05 2024 +0800

    net/udp: Add 4-tuple hash list basis
...
    hash4 uses hlist_nulls to avoid moving wrongly onto another hlist due to
    concurrent rehash, because rehash() can happen with lookup().
---8<---


Also, Fixes: tag is missing in both patches.

> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  net/ipv4/udp.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 86d282618515..a8e2b431d348 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -425,16 +425,21 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
>  				     __be32 saddr, __be16 sport,
>  				     __be32 daddr, unsigned int hnum,
>  				     int dif, int sdif,
> +				     unsigned int hash2, unsigned int mask,
>  				     struct udp_hslot *hslot2,
>  				     struct sk_buff *skb)
>  {
> +	unsigned int hash2_rescan;
>  	struct sock *sk, *result;
>  	int score, badness;
>  	bool need_rescore;
>  
> +rescan:
> +	hash2_rescan = hash2;
>  	result = NULL;
>  	badness = 0;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +		hash2_rescan = udp_sk(sk)->udp_portaddr_hash;
>  		need_rescore = false;
>  rescore:
>  		score = compute_score(need_rescore ? result : sk, net, saddr,
> @@ -475,6 +480,16 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
>  			goto rescore;
>  		}
>  	}
> +
> +	/* udp sockets can get moved to a different hash chain.
> +	 * If the chains have got crossed then rescan.
> +	 */                       

nit: trailing spaces here ^^^^^^^^


> +	if ((hash2_rescan ^ hash2) & mask) {
> +		/* Ensure hslot2->head is reread */
> +		barrier();
> +		goto rescan;
> +	}
> +
>  	return result;
>  }
>  
> @@ -654,7 +669,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
>  	/* Lookup connected or non-wildcard socket */
>  	result = udp4_lib_lookup2(net, saddr, sport,
>  				  daddr, hnum, dif, sdif,
> -				  hslot2, skb);
> +				  hash2, udptable->mask, hslot2, skb);
>  	if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
>  		goto done;
>  
> @@ -680,7 +695,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
>  
>  	result = udp4_lib_lookup2(net, saddr, sport,
>  				  htonl(INADDR_ANY), hnum, dif, sdif,
> -				  hslot2, skb);
> +				  hash2, udptable->mask, hslot2, skb);
>  done:
>  	if (IS_ERR(result))
>  		return NULL;
> -- 
> 2.39.5
> 

