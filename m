Return-Path: <netdev+bounces-135062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60E99C0C6
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D8E1F21C8F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0945145B26;
	Mon, 14 Oct 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="cX9EIuEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E42B2DA;
	Mon, 14 Oct 2024 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889786; cv=none; b=IwNaoAZQDgkT730LaHcIDotgrISnZRYRharP4i2doRtajfpQoEo1q9kSK500J2kVOpyAAgwHt7rERrdLq+D15GMEg2ZLY0bgY517UPWAq+tWmqhFzWyricZE5XT1re3qUEytMWQ0aoFR4noFLrAep/x0AXcsIWy/oGQKRMZO7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889786; c=relaxed/simple;
	bh=0WkLB0EmFGeC3bqomW57TfB9c8cQ/8SyMc8XjatQhUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ftoqmftgKhXz5kHqpQq9EFEBk77K1I/tIhZouFyw1fLOp8e8ZaLxISWudVdeHuKHGV0i+FUOuq6SLYLrAtNiurHmbASDCDdnQU3vG+ZsLjYgtcuC/Dj1nHx60kQrUWF0puXr+C1FnpRy8086tjOfSS5LrIXUdVrlPQlGt+oWb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=cX9EIuEy; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H29/uZYFImOCL15YMDLKrJt+SdKdMFtmd5jkG29BNgg=;
  b=cX9EIuEyDMi+CHBxADYDHfM2+/1wX3FVb1/+L8MshIVOb86jvWVFagVR
   94jAncDEoguSuWgxf2KGzvFnsfUivSBMlaxG7kRes6zypVg2aRED2yf7S
   YH0/Y/OY0yIXudU8I4Gxj8u4WV3zbQZHwrw9AwugjsA9cc5CaFShyoy1y
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,202,1725314400"; 
   d="scan'208";a="188585391"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:08:31 +0200
Date: Mon, 14 Oct 2024 09:08:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Sven Eckelmann <sven@narfation.org>
cc: Julia Lawall <Julia.Lawall@inria.fr>, vbabka@suse.cz, 
    linus.luessing@c0d3.blue, Marek Lindner <mareklindner@neomailbox.ch>, 
    kernel-janitors@vger.kernel.org, paulmck@kernel.org, 
    Simon Wunderlich <sw@simonwunderlich.de>, 
    Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, b.a.t.m.a.n@lists.open-mesh.org, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
In-Reply-To: <6091264.lOV4Wx5bFT@ripper>
Message-ID: <f343355b-eda9-8527-ee2c-60f1e44e6e0@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-7-Julia.Lawall@inria.fr> <6091264.lOV4Wx5bFT@ripper>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 14 Oct 2024, Sven Eckelmann wrote:

> On Sunday, 13 October 2024 22:16:53 CEST Julia Lawall wrote:
> > Since SLOB was removed and since
> > commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> > it is not necessary to use call_rcu when the callback only performs
> > kmem_cache_free. Use kfree_rcu() directly.
> >
> > The changes were made using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  net/batman-adv/translation-table.c |   47 ++-----------------------------------
> >  1 file changed, 3 insertions(+), 44 deletions(-)
>
>
> This was tried and we noticed that it is not safe [1]. So, I would get
> confirmation that commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier()
> from kmem_cache_destroy()") is fixing the problem which we had at that time.
> The commit message sounds like it but I just want to be sure.

Thanks for the feedback. I think that Vlastimil Babka can help with that.

julia

>
> Kind regards,
> 	Sven
>
> [1] https://lore.kernel.org/r/20240612133357.2596-1-linus.luessing@c0d3.blue
>
> >
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 2243cec18ecc..b21ff3c36b07 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
> >  	return tt_global_entry;
> >  }
> >
> > -/**
> > - * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
> > - * @rcu: rcu pointer of the tt_local_entry
> > - */
> > -static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_local_entry *tt_local_entry;
> > -
> > -	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
> > -				      common.rcu);
> > -
> > -	kmem_cache_free(batadv_tl_cache, tt_local_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
> >   *  for free after rcu grace period
> > @@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
> >
> >  	batadv_softif_vlan_put(tt_local_entry->vlan);
> >
> > -	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
> > +	kfree_rcu(tt_local_entry, common.rcu);
> >  }
> >
> >  /**
> > @@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
> >  		 batadv_tt_local_entry_release);
> >  }
> >
> > -/**
> > - * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
> > - * @rcu: rcu pointer of the tt_global_entry
> > - */
> > -static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_global_entry *tt_global_entry;
> > -
> > -	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
> > -				       common.rcu);
> > -
> > -	kmem_cache_free(batadv_tg_cache, tt_global_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_global_entry_release() - release tt_global_entry from lists and
> >   *  queue for free after rcu grace period
> > @@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
> >
> >  	batadv_tt_global_del_orig_list(tt_global_entry);
> >
> > -	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
> > +	kfree_rcu(tt_global_entry, common.rcu);
> >  }
> >
> >  /**
> > @@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
> >  	batadv_tt_global_size_mod(orig_node, vid, -1);
> >  }
> >
> > -/**
> > - * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
> > - * @rcu: rcu pointer of the orig_entry
> > - */
> > -static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
> > -{
> > -	struct batadv_tt_orig_list_entry *orig_entry;
> > -
> > -	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
> > -
> > -	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
> > -}
> > -
> >  /**
> >   * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
> >   *  queue for free after rcu grace period
> > @@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
> >  				  refcount);
> >
> >  	batadv_orig_node_put(orig_entry->orig_node);
> > -	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
> > +	kfree_rcu(orig_entry, rcu);
> >  }
> >
> >  /**
> >
> >
>
>

