Return-Path: <netdev+bounces-210430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285CB13434
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690EE189606C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4121D00D;
	Mon, 28 Jul 2025 05:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817E1FCFFC;
	Mon, 28 Jul 2025 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680964; cv=none; b=oUyuFy33iVOjtciH2NP4oCTijBza4SoeKut5ncL9T1GUyVnz6xQ4vc+ps04HhW+F0FELbZ7Q9gjDLvWXmfY52DPzijcTOw6hi2jVUSNSUNH9IoASbO2TkfkTCzsP+cX56Zx1ku8aOXaUIoI3DAdFMzJKIBTY9G7n+3FsDgt9v5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680964; c=relaxed/simple;
	bh=pvVypBMo0PSVldr+3dPqiM+F3TwKs8w0jc7WfegAU8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r3ZroGTa4tccTqC0PmgLbbmgaA1a8A2oZezpRbJK02jBdlil74Gwl55m5Thn500x53ww765wzO/DCQew3szG3IB4WHEVjR1mlj1270Lj+Qc8Dn05Kz94VlplsF6ZZEXoetwPAqPPUN98WEhYwsyfA5Sy1wvOVeMRhQ+2izYF0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e2-68870c3d3748
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	almasrymina@google.com,
	hawk@kernel.org,
	toke@redhat.com,
	asml.silence@gmail.com
Subject: [RFC net-next] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
Date: Mon, 28 Jul 2025 14:35:46 +0900
Message-Id: <20250728053546.4829-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250728042050.24228-1-byungchul@sk.com>
References: <20250728042050.24228-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXC9ZZnoa4tT3uGwY0dvBarf1RYzFm1jdFi
	zvkWFounxx6xW+xp385s8aj/BJvFhW19rBaXd81hszi2QMzi2+k3jBaXDj9iceD22LLyJpPH
	zll32T0WbCr12LSqk83j/b6rbB6fN8kFsEVx2aSk5mSWpRbp2yVwZXQ8fcZU8FCn4uKUXSwN
	jM9Uuhg5OSQETCSunf3LAmO/W3IFzGYTUJe4ceMnM4gtImAl0bBxHZDNxcEscJ9R4smls2wg
	CWGBEInGg0/BGlgEVCWW31nCDmLzAg2afuATM8RQeYnVGw6A2ZwCZhKzr00GqxESMJX4sugD
	O8hQCYEZbBLHDu9ghGiQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECg29Z
	7Z/oHYyfLgQfYhTgYFTi4X1h3pYhxJpYVlyZe4hRgoNZSYS3YClQiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6NQv7L6nvO6DsU9SotXG6+QZW+6ve7h
	Om3ZKJuTDy6tU+Gp7b984sbCz/XXH9mm+AeaCk4zWePuIteUaKuXfi6YQ+WcQVXmr+1Jsoti
	tvxRz6mW0ly7YWeavgb/0a0LxMI/FvRGqO22q1hrPvk8s9wrz5JmFr5EpQxWC/O4FZXb2X6m
	3arNVmIpzkg01GIuKk4EAILhXAI6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42Lh8rNu1rXlac8wuLmV0WL1jwqLOau2MVrM
	Od/CYvH02CN2iz3t25ktHvWfYLM4PPckq8WFbX2sFpd3zWGzOLZAzOLb6TeMFpcOP2Jx4PHY
	svImk8fOWXfZPRZsKvXYtKqTzeP9vqtsHotffGDy+LxJLoA9issmJTUnsyy1SN8ugSuj4+kz
	poKHOhUXp+xiaWB8ptLFyMkhIWAi8W7JFRYQm01AXeLGjZ/MILaIgJVEw8Z1QDYXB7PAfUaJ
	J5fOsoEkhAVCJBoPPgVrYBFQlVh+Zwk7iM0LNGj6gU/MEEPlJVZvOABmcwqYScy+NhmsRkjA
	VOLLog/sExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgMpWW1fybuYPxy2f0QowAH
	oxIP7wvztgwh1sSy4srcQ4wSHMxKIrwFS4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOE
	BNITS1KzU1MLUotgskwcnFINjEuXrzy0q9psW6BO7EzlV1UJO6TYkv4wPs/b4vWKIf/UR4Xm
	nYnp1g9TN80M+3Zhb+rs2X+OT7/F9NNkSc3vd+X3teb/1zr5d1t3/C8X+0U8eybwOOQnTSqe
	9E/+y6m5C8I15WcJrV/Xwr78tUp76gOOKVL3uU7VdCld/VWUorF25oqe1YVcF6yUWIozEg21
	mIuKEwF/uNtyIQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
> 
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> 
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.

+cc kernel_team@skhynix.com

	Byungchul

> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/netmem.h   | 33 ++++++++++++++++-----------------
>  net/core/netmem_priv.h | 16 ++++++++--------
>  2 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f7dacc9e75fd..33ae444a9745 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -265,24 +265,23 @@ static inline struct netmem_desc *__netmem_to_nmdesc(netmem_ref netmem)
>  	return (__force struct netmem_desc *)netmem;
>  }
>  
> -/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
> - * common fields.
> - * @netmem: netmem reference to extract as net_iov.
> +/* netmem_to_nmdesc - convert netmem_ref to struct netmem_desc * for
> + * access to common fields.
> + * @netmem: netmem reference to get netmem_desc.
>   *
> - * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
> - * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
> - * these fields without a type check to make sure that the underlying mem is
> - * net_iov or page.
> + * All the sub types of netmem_ref (netmem_desc, net_iov) have the same
> + * pp, pp_magic, dma_addr, and pp_ref_count fields via netmem_desc.
>   *
> - * The resulting value of this function can only be used to access the fields
> - * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
> - * undefined behavior.
> - *
> - * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
> + * Return: the pointer to struct netmem_desc * regardless of its
> + * underlying type.
>   */
> -static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +static inline struct netmem_desc *netmem_to_nmdesc(netmem_ref netmem)
>  {
> -	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> +	if (netmem_is_net_iov(netmem))
> +		return &((struct net_iov *)((__force unsigned long)netmem &
> +					    ~NET_IOV))->desc;
> +
> +	return __netmem_to_nmdesc(netmem);
>  }
>  
>  /* XXX: How to extract netmem_desc from page must be changed, once
> @@ -320,12 +319,12 @@ static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
>  
>  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
>  {
> -	return __netmem_clear_lsb(netmem)->pp;
> +	return netmem_to_nmdesc(netmem)->pp;
>  }
>  
>  static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
>  {
> -	return &__netmem_clear_lsb(netmem)->pp_ref_count;
> +	return &netmem_to_nmdesc(netmem)->pp_ref_count;
>  }
>  
>  static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
> @@ -390,7 +389,7 @@ static inline bool netmem_is_pfmemalloc(netmem_ref netmem)
>  
>  static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
>  {
> -	return __netmem_clear_lsb(netmem)->dma_addr;
> +	return netmem_to_nmdesc(netmem)->dma_addr;
>  }
>  
>  void get_netmem(netmem_ref netmem);
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index cd95394399b4..23175cb2bd86 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -5,19 +5,19 @@
>  
>  static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
>  {
> -	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
> +	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>  
>  static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
>  {
> -	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
> +	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
>  }
>  
>  static inline void netmem_clear_pp_magic(netmem_ref netmem)
>  {
> -	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> +	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
>  
> -	__netmem_clear_lsb(netmem)->pp_magic = 0;
> +	netmem_to_nmdesc(netmem)->pp_magic = 0;
>  }
>  
>  static inline bool netmem_is_pp(netmem_ref netmem)
> @@ -27,13 +27,13 @@ static inline bool netmem_is_pp(netmem_ref netmem)
>  
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
>  {
> -	__netmem_clear_lsb(netmem)->pp = pool;
> +	netmem_to_nmdesc(netmem)->pp = pool;
>  }
>  
>  static inline void netmem_set_dma_addr(netmem_ref netmem,
>  				       unsigned long dma_addr)
>  {
> -	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
> +	netmem_to_nmdesc(netmem)->dma_addr = dma_addr;
>  }
>  
>  static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
> @@ -43,7 +43,7 @@ static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
>  	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
>  		return 0;
>  
> -	magic = __netmem_clear_lsb(netmem)->pp_magic;
> +	magic = netmem_to_nmdesc(netmem)->pp_magic;
>  
>  	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
>  }
> @@ -57,6 +57,6 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
>  		return;
>  
>  	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
> -	__netmem_clear_lsb(netmem)->pp_magic = magic;
> +	netmem_to_nmdesc(netmem)->pp_magic = magic;
>  }
>  #endif
> 
> base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
> -- 
> 2.17.1
> 

