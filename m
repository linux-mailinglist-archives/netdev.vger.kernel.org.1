Return-Path: <netdev+bounces-28829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F39780EC0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41BB28240A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165218C22;
	Fri, 18 Aug 2023 15:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD818AF0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:13:24 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569F3A99
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:13:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 963E81F8AE;
	Fri, 18 Aug 2023 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692371601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxdYcr1vnJw+b1odbztSYmbKBmTxptS12hgcw0XnFlk=;
	b=bLgw2AXFMjajtWdgM7cPDAd2k3jLV8+fi7vj53wEpLBiey45fKuGKYSodENP4arseU87S7
	ruumuuxlXrwsaDIUDPZ3Z9AJjLheRmsTUoicbYvsEJKWgxHx9mKydyYfpA0XEt5E9nsN5U
	b547n8xF8eERR7OWCcLSwos0sWWaUKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692371601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxdYcr1vnJw+b1odbztSYmbKBmTxptS12hgcw0XnFlk=;
	b=BbjDnshtBpNGRaXM1PV3iJEPBfNJuc0QFyVAm/m3gXf+iDTDMFEKNz6hZv/fgQttBrdEmZ
	E7U+xhpg52/GEhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC656138F0;
	Fri, 18 Aug 2023 15:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id N24kM5CK32SRWAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 18 Aug 2023 15:13:20 +0000
Message-ID: <0154b070-8741-5d72-8a45-ea62356991d2@suse.cz>
Date: Fri, 18 Aug 2023 17:15:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Christoph Lameter <cl@linux.com>,
 roman.gushchin@linux.dev, dsterba@suse.com
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <169211265663.1491038.8580163757548985946.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 17:17, Jesper Dangaard Brouer wrote:
> Since v6.5-rc1 MM-tree is merged and contains a new flag SLAB_NO_MERGE
> in commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag SLAB_NO_MERGE")
> now is the time to use this flag for networking as proposed
> earlier see link.
> 
> The SKB (sk_buff) kmem_cache slab is critical for network performance.
> Network stack uses kmem_cache_{alloc,free}_bulk APIs to gain
> performance by amortising the alloc/free cost.
> 
> For the bulk API to perform efficiently the slub fragmentation need to
> be low. Especially for the SLUB allocator, the efficiency of bulk free
> API depend on objects belonging to the same slab (page).
> 
> When running different network performance microbenchmarks, I started
> to notice that performance was reduced (slightly) when machines had
> longer uptimes. I believe the cause was 'skbuff_head_cache' got
> aliased/merged into the general slub for 256 bytes sized objects (with
> my kernel config, without CONFIG_HARDENED_USERCOPY).
> 
> For SKB kmem_cache network stack have other various reasons for
> not merging, but it varies depending on kernel config (e.g.
> CONFIG_HARDENED_USERCOPY). We want to explicitly set SLAB_NO_MERGE
> for this kmem_cache to get most out of kmem_cache_{alloc,free}_bulk APIs.
> 
> When CONFIG_SLUB_TINY is configured the bulk APIs are essentially
> disabled. Thus, for this case drop the SLAB_NO_MERGE flag.
> 
> Link: https://lore.kernel.org/all/167396280045.539803.7540459812377220500.stgit@firesoul/
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  net/core/skbuff.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6..92aee3e0376a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4750,12 +4750,23 @@ static void skb_extensions_init(void)
>  static void skb_extensions_init(void) {}
>  #endif
>  
> +/* The SKB kmem_cache slab is critical for network performance.  Never
> + * merge/alias the slab with similar sized objects.  This avoids fragmentation
> + * that hurts performance of kmem_cache_{alloc,free}_bulk APIs.
> + */
> +#ifndef CONFIG_SLUB_TINY
> +#define FLAG_SKB_NO_MERGE	SLAB_NO_MERGE
> +#else /* CONFIG_SLUB_TINY - simple loop in kmem_cache_alloc_bulk */
> +#define FLAG_SKB_NO_MERGE	0
> +#endif
> +
>  void __init skb_init(void)
>  {
>  	skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
>  					      sizeof(struct sk_buff),
>  					      0,
> -					      SLAB_HWCACHE_ALIGN|SLAB_PANIC,
> +					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
> +						FLAG_SKB_NO_MERGE,
>  					      offsetof(struct sk_buff, cb),
>  					      sizeof_field(struct sk_buff, cb),
>  					      NULL);
> 
> 

