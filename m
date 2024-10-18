Return-Path: <netdev+bounces-136979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C79A3D6E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AE61F21F7D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF071D95A9;
	Fri, 18 Oct 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EddVbyJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C21878
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251724; cv=none; b=GINXG2MEbD1fVk5CFtkG8dxnoBIR9/7KUFUXIFuIUXC1vgaodj69PXqHN4qFclpB9a8+XDKiSxJXtGhktSb1DGiDOdhHG8xNgr47upFYpcFANaq5fxVeoqSvIrxnrF4TxxuOZX4e9daPyXX4qeh+ds7xmyffUVYvuPAB73kxDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251724; c=relaxed/simple;
	bh=h3mpHQGXYLOw59jx2grQ+UznjabAxoR4kMHnngWxNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg9mlBm+AK6BFMZe0MvPg/fMrO2TCjTcuGXlzW+sfq0PgS7yguEzx0K5+z2RLSxe7KYoRJl+fJjqxGcKTbN1DF1thURutJzWW2SOCpQNFA9z+ynce7OMSiVMAnw0Jw+AvxC0tb1/4qD+uJ+bwAKiiELH0XZF4V7ortVN7W5hwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EddVbyJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D2CC4CEC3;
	Fri, 18 Oct 2024 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729251723;
	bh=h3mpHQGXYLOw59jx2grQ+UznjabAxoR4kMHnngWxNTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EddVbyJubFSjIO44hjyYnlW51MU8T/2ZXSQaCMia1AGD1EznbYZhSKqWFR6vG7QIX
	 u8oOsRe8nyETIE56fuJWsIR2iACpXpkv3R8uzvREssQIvsUn0uRMUJ3Yau45Iy3MqN
	 J+BS2KmMX3VdVNHFn9IJ+zSjZyezDfJQDUVqSnrbfIZESPeSFPFtHeu4iYQ8z1OCKM
	 FFIjp6Hp5dSIWEsp8LMYKis3PJMK7GAPu/bYrKEX8GroK68rGmdbSyNohlKWtXqjdT
	 v+oH75A6mQuxLMzcWDe/pfvneO4+UtjgG6cjFyMcQ9z+epnoOR17TSJbvb0sVscEFt
	 vwQ3p0BmTqYcw==
Date: Fri, 18 Oct 2024 12:42:00 +0100
From: Simon Horman <horms@kernel.org>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 4/6] Convert neighbour iteration to use
 hlist+macro
Message-ID: <20241018114200.GG1697@kernel.org>
References: <20241017070445.4013745-1-gnaaman@drivenets.com>
 <20241017070445.4013745-5-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017070445.4013745-5-gnaaman@drivenets.com>

On Thu, Oct 17, 2024 at 07:04:39AM +0000, Gilad Naaman wrote:
> Remove all usage of the bare neighbour::next pointer,
> replacing them with neighbour::hash and its for_each macro.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

...

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c

...

> @@ -621,11 +620,9 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
>  
>  	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
>  		struct neighbour *n, *next;
> +		struct hlist_node *tmp;
>  
> -		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
> -						   lockdep_is_held(&tbl->lock));
> -		     n != NULL;
> -		     n = next) {
> +		neigh_for_each_safe(n, tmp, &old_nht->hash_heads[i]) {
>  			hash = tbl->hash(n->primary_key, n->dev,
>  					 new_nht->hash_rnd);
>  

Hi Gilad,

With this change next is now set but otherwise unused in this function.
Probably it can be removed.

Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.

...

