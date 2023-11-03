Return-Path: <netdev+bounces-45942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC697E0779
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5A1C21096
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED28208A1;
	Fri,  3 Nov 2023 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp/RzDfP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BE22310
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E71C433C8;
	Fri,  3 Nov 2023 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699032887;
	bh=CMue2i/Fy6Nwr+UxGDuvfPY8RcDwjFD6UI3d9B5k1Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jp/RzDfPeqIXWPgFzT1E2ZNLHFrzg1echue9Jh7ltYiUh3f29WoRdtHrM6bSP3GXg
	 3qHFkW08DzTpnRVsgXlR6CKHUCOxF46ZnMS0618CKq4pj6FvxV7/hoBMSaFMHmLeZ+
	 hhXVIDg7mUMBXDP1SwvF32nXeT8wxwuReR/suSnhQ1P8Ds8AT3FSDhNH4DYbBFB/L4
	 CKoVXqQ0QEtlA9B9RkzLoIMJPAgpSFcvcltnKUQbaIkTNOqr9mKOGH67CxAeOTWBX4
	 zFp5JT+Vzu2Xa3JooHNiZvbLawqxrIWab1mCPpQqiJR1+yQ6+ycs3XcI6wBOpLEZ2X
	 Pog7C1e1W7kLQ==
Date: Fri, 3 Nov 2023 17:34:42 +0000
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 02/19] netfilter: nft_set_rbtree: prefer sync gc
 to async worker
Message-ID: <20231103173442.GB768996@kernel.org>
References: <20231025212555.132775-1-pablo@netfilter.org>
 <20231025212555.132775-3-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025212555.132775-3-pablo@netfilter.org>

On Wed, Oct 25, 2023 at 11:25:38PM +0200, Pablo Neira Ayuso wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> There is no need for asynchronous garbage collection, rbtree inserts
> can only happen from the netlink control plane.
> 
> We already perform on-demand gc on insertion, in the area of the
> tree where the insertion takes place, but we don't do a full tree
> walk there for performance reasons.
> 
> Do a full gc walk at the end of the transaction instead and
> remove the async worker.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

...

> @@ -515,11 +523,7 @@ static void nft_rbtree_remove(const struct net *net,
>  	struct nft_rbtree *priv = nft_set_priv(set);
>  	struct nft_rbtree_elem *rbe = elem->priv;
>  
> -	write_lock_bh(&priv->lock);
> -	write_seqcount_begin(&priv->count);
> -	rb_erase(&rbe->node, &priv->root);
> -	write_seqcount_end(&priv->count);
> -	write_unlock_bh(&priv->lock);
> +	nft_rbtree_erase(priv, rbe);
>  }
>  
>  static void nft_rbtree_activate(const struct net *net,
> @@ -613,45 +617,40 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
>  	read_unlock_bh(&priv->lock);
>  }
>  
> -static void nft_rbtree_gc(struct work_struct *work)
> +static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
> +				 struct nft_rbtree *priv,
> +				 struct nft_rbtree_elem *rbe)
>  {
> +	struct nft_set_elem elem = {
> +		.priv	= rbe,
> +	};
> +
> +	nft_setelem_data_deactivate(net, set, &elem);
> +	nft_rbtree_erase(priv, rbe);
> +}
> +
> +static void nft_rbtree_gc(struct nft_set *set)
> +{
> +	struct nft_rbtree *priv = nft_set_priv(set);
>  	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
>  	struct nftables_pernet *nft_net;

Hi Florian and Pablo,

I understand that this patch has been accepted upstream,
and that by implication this feedback is rather slow,
but I noticed that with this patch nft_net is now
set but otherwise unused in this function.

As flagged by clang-16 and gcc-13 W=1 builds.

> -	struct nft_rbtree *priv;
> +	struct rb_node *node, *next;
>  	struct nft_trans_gc *gc;
> -	struct rb_node *node;
> -	struct nft_set *set;
> -	unsigned int gc_seq;
>  	struct net *net;
>  
> -	priv = container_of(work, struct nft_rbtree, gc_work.work);
>  	set  = nft_set_container_of(priv);
>  	net  = read_pnet(&set->net);
>  	nft_net = nft_pernet(net);
> -	gc_seq  = READ_ONCE(nft_net->gc_seq);
>  
> -	if (nft_set_gc_is_pending(set))
> -		goto done;
> -
> -	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
> +	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
>  	if (!gc)
> -		goto done;
> -
> -	read_lock_bh(&priv->lock);
> -	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
> +		return;
>  
> -		/* Ruleset has been updated, try later. */
> -		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
> -			nft_trans_gc_destroy(gc);
> -			gc = NULL;
> -			goto try_later;
> -		}
> +	for (node = rb_first(&priv->root); node ; node = next) {
> +		next = rb_next(node);
>  
>  		rbe = rb_entry(node, struct nft_rbtree_elem, node);
>  
> -		if (nft_set_elem_is_dead(&rbe->ext))
> -			goto dead_elem;
> -
>  		/* elements are reversed in the rbtree for historical reasons,
>  		 * from highest to lowest value, that is why end element is
>  		 * always visited before the start element.

...

