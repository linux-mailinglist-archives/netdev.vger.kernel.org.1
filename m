Return-Path: <netdev+bounces-135910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4699FC71
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0070281E53
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E262B1D9A69;
	Tue, 15 Oct 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jx2L2j42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6B1B0F1F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034743; cv=none; b=AsGHvXigailfTeApVnMmVB3u8crT4U8kc3v5lT/i0Ile+A1x3TI64aeA9cxdRKm2RgxbkHGnPBFxDQXkgbkh2oNeIULkMGJ7R+4YTOsSmtZG3FgqoCgzhGkiJPvb6R5zRJgfk5zAahhJMhHa660oQPovBR1qbSJjCUg3mQxGRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034743; c=relaxed/simple;
	bh=4ZecKPSbSYl3zv8hsAIyVCzTKhoHTyMc30JK18ESCPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCWXn7i3f9zKLfaPoBEm0Fkqs/DEcsXOxBfq6ssvFpbiNQLl7inYu72oNsAp6VKnwsoWsKXuCNRJ6m/Eoumll+dxw9S6zouAp366pndtEpyHSn2+gDnpfsGnrKtQkaG8zvfqJ7nqmpBh5XZoBBTevlawZm8Ue2/vYXdoPIpWzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jx2L2j42; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729034742; x=1760570742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tB0ISUu2OMnwIjSWC/cR4ftu4vdX+Ul2SKgiPsfc3jE=;
  b=jx2L2j428H3s0+Kj/OD/y3cBCVHlvomBPN9YdwKCT6/cTdTnwVX3feXC
   Zz8JDc7Z1GZfApw2md6VDk1qv2lzg0b8FJKWohb1mADKWkFmhv7GQPCzK
   sTtlZIdgrnSb11aspPP9qazlxYLRvjJN3IzZvkzI+bk1yKFXjCsrZHLS7
   U=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="766891757"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:25:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:21926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 6bb65c20-b3ad-4bcf-95e6-76e029caaad6; Tue, 15 Oct 2024 23:25:36 +0000 (UTC)
X-Farcaster-Flow-ID: 6bb65c20-b3ad-4bcf-95e6-76e029caaad6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 23:25:35 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 23:25:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 3/6] Convert neigh_* seq_file functions to use hlist
Date: Tue, 15 Oct 2024 16:25:29 -0700
Message-ID: <20241015232529.67605-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015165929.3203216-4-gnaaman@drivenets.com>
References: <20241015165929.3203216-4-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue, 15 Oct 2024 16:59:23 +0000
> Convert seq_file-related neighbour functionality to use neighbour::hash
> and the related for_each macro.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  include/net/neighbour.h |  4 ++++
>  net/core/neighbour.c    | 26 ++++++++++----------------
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 2f4cb9e51364..7dc0d4d6a4a8 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -279,6 +279,10 @@ static inline void *neighbour_priv(const struct neighbour *n)
>  extern const struct nla_policy nda_policy[];
>  
>  #define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
> +#define neigh_hlist_entry(n) hlist_entry_safe(n, struct neighbour, hash)
> +#define neigh_first_rcu(bucket) \
> +	neigh_hlist_entry(rcu_dereference(hlist_first_rcu(bucket)))

No RCU helpers are needed, seq file is under RCU & tbl->lock

#define neigh_first_entry(bucket)				\
	hlist_entry_safe((bucket)->first, struct neighbour, hash)

> +

nit: unnecessary newline.


>  
>  static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
>  {
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index e91105a4c5ee..4bdf7649ca57 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3207,25 +3207,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
>  
>  	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
>  	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
> -		n = rcu_dereference(nht->hash_buckets[bucket]);
> -
> -		while (n) {
> +		neigh_for_each(n, &nht->hash_heads[bucket]) {
>  			if (!net_eq(dev_net(n->dev), net))
> -				goto next;
> +				continue;
>  			if (state->neigh_sub_iter) {
>  				loff_t fakep = 0;
>  				void *v;
>  
>  				v = state->neigh_sub_iter(state, n, &fakep);
>  				if (!v)
> -					goto next;
> +					continue;
>  			}
>  			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
>  				break;

Let's avoid double-break and use goto just before setting bucket like:

out:
	state->bucket = bucket


>  			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
>  				break;

Same here.


> -next:
> -			n = rcu_dereference(n->next);
>  		}
>  
>  		if (n)

Then, this null check & break will be unnecessary.


> @@ -3249,34 +3245,32 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
>  		if (v)
>  			return n;
>  	}
> -	n = rcu_dereference(n->next);
>  
>  	while (1) {
> -		while (n) {
> +		hlist_for_each_entry_continue_rcu(n, hash) {
>  			if (!net_eq(dev_net(n->dev), net))
> -				goto next;
> +				continue;
>  			if (state->neigh_sub_iter) {
>  				void *v = state->neigh_sub_iter(state, n, pos);
>  				if (v)
>  					return n;
> -				goto next;
> +				continue;
>  			}
>  			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
>  				break;
>  
>  			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
>  				break;

Same remark here.


> -next:
> -			n = rcu_dereference(n->next);
>  		}
>  
>  		if (n)
>  			break;

and here.

>  
> -		if (++state->bucket >= (1 << nht->hash_shift))
> -			break;

Let's keep this,


> +		while (!n && ++state->bucket < (1 << nht->hash_shift))
> +			n = neigh_first_rcu(&nht->hash_heads[state->bucket]);
>  
> -		n = rcu_dereference(nht->hash_buckets[state->bucket]);

and simply fetch neigh_first_entry().

Then, we can let the next loop handle the termination condition
and keep the code simple.


> +		if (!n)
> +			break;
>  	}
>  
>  	if (n && pos)
> -- 
> 2.46.0

