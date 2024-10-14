Return-Path: <netdev+bounces-135063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8D99C0E0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6771F22AED
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7748D1465B3;
	Mon, 14 Oct 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Xe54NCsc"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284714601C;
	Mon, 14 Oct 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890007; cv=none; b=bGZTiFmrEllWazbOK099mTNwClKGLhhe9EAy3g32EbJjq05wq51c87yZpXcN9i00YzYlD+GEK8WCqsLkY3tNkvd+OhTJOMZQekUf8VcAV3hedYsN2olsPyJkt6f+2OAb+Vk3WtJSDWC2893UAejctO0/jQjwCsHlSlJZ5hGwf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890007; c=relaxed/simple;
	bh=zgxvLRR3w3kjqFDgWGHDCjUaqXkNWkNYk3LGPt7EkZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXlZ52MIsYQGOfWBCkOLIqh9/VJqLoLXg6jEV3fyUbMlt9c4WSJ3tYDMJdZGHH81yR0a3l8SuPOlKK/gWtxPtFH3qHBBS2sEQylh6J9jS66V3Ok7IxYT64qs1Oxqaju96njo54uqywuI3CF90DTc4uMkmA71Gz7XzZlGWKBVMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Xe54NCsc; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1728889420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=httTAT48fu+3mO0g6dqX16B/PSb/AZaAB5kFQ49ZHpw=;
	b=Xe54NCscJgu36LAoRk5nICKys82aNg3+GsjFGnInFdAafoHCnhLMlKiQlH9O9rDNupMsmm
	/gCyhwOm/RbFmKrvS8PEkAkjJHf6xiJMhZO9BSLdAZ/l8T36cBzyTFNdE+PqZhdfV+RWWB
	5M1lZzm3KwY8vIO/cfRIt4BhpcJeJdI=
From: Sven Eckelmann <sven@narfation.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, vbabka@suse.cz,
 linus.luessing@c0d3.blue
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 kernel-janitors@vger.kernel.org, paulmck@kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Date: Mon, 14 Oct 2024 09:03:30 +0200
Message-ID: <6091264.lOV4Wx5bFT@ripper>
In-Reply-To: <20241013201704.49576-7-Julia.Lawall@inria.fr>
References:
 <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-7-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4957463.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4957463.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Oct 2024 09:03:30 +0200
Message-ID: <6091264.lOV4Wx5bFT@ripper>
In-Reply-To: <20241013201704.49576-7-Julia.Lawall@inria.fr>
MIME-Version: 1.0

On Sunday, 13 October 2024 22:16:53 CEST Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  net/batman-adv/translation-table.c |   47 ++-----------------------------------
>  1 file changed, 3 insertions(+), 44 deletions(-)


This was tried and we noticed that it is not safe [1]. So, I would get 
confirmation that commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() 
from kmem_cache_destroy()") is fixing the problem which we had at that time. 
The commit message sounds like it but I just want to be sure.

Kind regards,
	Sven

[1] https://lore.kernel.org/r/20240612133357.2596-1-linus.luessing@c0d3.blue

> 
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 2243cec18ecc..b21ff3c36b07 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
>  	return tt_global_entry;
>  }
>  
> -/**
> - * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
> - * @rcu: rcu pointer of the tt_local_entry
> - */
> -static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_local_entry *tt_local_entry;
> -
> -	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
> -				      common.rcu);
> -
> -	kmem_cache_free(batadv_tl_cache, tt_local_entry);
> -}
> -
>  /**
>   * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
>   *  for free after rcu grace period
> @@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
>  
>  	batadv_softif_vlan_put(tt_local_entry->vlan);
>  
> -	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
> +	kfree_rcu(tt_local_entry, common.rcu);
>  }
>  
>  /**
> @@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
>  		 batadv_tt_local_entry_release);
>  }
>  
> -/**
> - * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
> - * @rcu: rcu pointer of the tt_global_entry
> - */
> -static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_global_entry *tt_global_entry;
> -
> -	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
> -				       common.rcu);
> -
> -	kmem_cache_free(batadv_tg_cache, tt_global_entry);
> -}
> -
>  /**
>   * batadv_tt_global_entry_release() - release tt_global_entry from lists and
>   *  queue for free after rcu grace period
> @@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
>  
>  	batadv_tt_global_del_orig_list(tt_global_entry);
>  
> -	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
> +	kfree_rcu(tt_global_entry, common.rcu);
>  }
>  
>  /**
> @@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
>  	batadv_tt_global_size_mod(orig_node, vid, -1);
>  }
>  
> -/**
> - * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
> - * @rcu: rcu pointer of the orig_entry
> - */
> -static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
> -{
> -	struct batadv_tt_orig_list_entry *orig_entry;
> -
> -	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
> -
> -	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
> -}
> -
>  /**
>   * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
>   *  queue for free after rcu grace period
> @@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
>  				  refcount);
>  
>  	batadv_orig_node_put(orig_entry->orig_node);
> -	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> +	kfree_rcu(orig_entry, rcu);
>  }
>  
>  /**
> 
> 


--nextPart4957463.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZwzCQwAKCRBND3cr0xT1
y7i+AQDVLdYz744YITcGjxNtokduQbc/TMXye8cDpvnUIRqeswEA3w/Kg7zDNvz2
rI43KEYfCJOuJv0+vY4mZmhJob37RQw=
=/WZq
-----END PGP SIGNATURE-----

--nextPart4957463.31r3eYUQgx--




