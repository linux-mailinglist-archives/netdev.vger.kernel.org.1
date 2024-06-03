Return-Path: <netdev+bounces-100309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811E8D879E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A91D1C22014
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433C1369A7;
	Mon,  3 Jun 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VFAWX+oa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Bm1TWAB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGuH3Th/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q7g3X6iK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FD137C20;
	Mon,  3 Jun 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434381; cv=none; b=kzlTvlqCo/kf3AmBwKhV5rAZ0bE+e9KXEgOgHIE4MjoDhLA9AAs28TLn8PZvruo0G41/eYOmuWm0jbiN6FRBgkp/jFoZXZL5hzd1Yc9btqjrOF2fs5cEw2XrABYksTfDDyFn1YZaTHlTn40Yp+LUD88QleuuLfqX6yytOGWbQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434381; c=relaxed/simple;
	bh=IUBCEICUyhwcICO0LM0dlov6BuMUOPZDhUGcBA1nDQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhLSnNWd4vz9p4V8p7KlnRDBY0CMLH9r8/IAWA05HLVjxuFUDdT+/GT32Kv4LtwI0mTK+vhKzSDVOAyQc9JB0CSWsPltrg1sXnlYBNWeMXtB/aqHx/9CARJJguhhYR1LgVzn7HXZP0YluxDbbggZNNwKg43+oBZ+BdAa3GLw8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VFAWX+oa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Bm1TWAB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGuH3Th/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q7g3X6iK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D58DC1F381;
	Mon,  3 Jun 2024 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717434376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/FTZPd1cZ3bUSIu2pf129jevvswA0mEkhduMTvacaw=;
	b=VFAWX+oaKNn9M4yCwS1jrIQWPKc0mwKuQt31slrpN6RfJ7uYz/txQZ6UWFAKdCq7Gcpx7+
	NMGwYppT2K+R90gL3H+SKwrKAvXayht0/woF7tai3qszCcvY8kaJh7EIUR43j1bY+p65If
	41swwId5q6zzecpGaUAn0rPzl4bS//M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717434376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/FTZPd1cZ3bUSIu2pf129jevvswA0mEkhduMTvacaw=;
	b=2Bm1TWAB8hH3ulRFB/K0S+O9Qww3xwaqFmKEuCKNrs96XTEP98peWbFhX6ecd7myz6tM1x
	RokScJDQMouPegAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jGuH3Th/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q7g3X6iK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717434375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/FTZPd1cZ3bUSIu2pf129jevvswA0mEkhduMTvacaw=;
	b=jGuH3Th/D2ewU7HTzivwZfdr5SKlYA778oQldl44AoH0cQn6Ai7Q1NmaNt3f0emp/GMGrr
	f1b1krBlYwU5aCm9YvIDfYKG3gDcx89gEent1W2KHXqTcD+PkOc98mrn4ht7KR9rHNS1UN
	3IQ62pr8C6FDG1nYI03dzpzLLpHlNx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717434375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/FTZPd1cZ3bUSIu2pf129jevvswA0mEkhduMTvacaw=;
	b=Q7g3X6iKTw9lkbIlyPe8rgG8vSPebQA8X4XX2YTmuAEk/R/PYtXEPnwjFE1htec2mqs2H0
	65dv0RIz7mjYmGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6F8713A93;
	Mon,  3 Jun 2024 17:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MBUUKAf4XWbFGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Jun 2024 17:06:15 +0000
Message-ID: <8c0c4af3-4782-4dbc-b413-e2f3b79c0246@suse.cz>
Date: Mon, 3 Jun 2024 19:06:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
To: Kees Cook <kees@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 jvoisin <julien.voisin@dustri.org>, Andrew Morton
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan
 <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
 Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-2-kees@kernel.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240531191458.987345-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,dustri.org,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,huaweicloud.com,huawei.com,suug.ch,gondor.apana.org.au];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux-foundation.org:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D58DC1F381
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 5/31/24 9:14 PM, Kees Cook wrote:
> Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
> support separated kmalloc buckets (in the follow kmem_buckets_create()
> patches and future codetag-based separation). Since this will provide
> a mitigation for a very common case of exploits, enable it by default.

Are you sure? I thought there was a policy that nobody is special enough
to have stuff enabled by default. Is it worth risking Linus shouting? :)
 
> To be able to choose which buckets to allocate from, make the buckets
> available to the internal kmalloc interfaces by adding them as the
> first argument, rather than depending on the buckets being chosen from
> the fixed set of global buckets. Where the bucket is not available,
> pass NULL, which means "use the default system kmalloc bucket set"
> (the prior existing behavior), as implemented in kmalloc_slab().
> 
> To avoid adding the extra argument when !CONFIG_SLAB_BUCKETS, only the
> top-level macros and static inlines use the buckets argument (where
> they are stripped out and compiled out respectively). The actual extern
> functions can then been built without the argument, and the internals
> fall back to the global kmalloc buckets unconditionally.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: jvoisin <julien.voisin@dustri.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/slab.h | 34 ++++++++++++++++++++++++++--------
>  mm/Kconfig           | 15 +++++++++++++++
>  mm/slab.h            |  6 ++++--
>  mm/slab_common.c     |  4 ++--
>  mm/slub.c            | 34 ++++++++++++++++++++++++----------
>  mm/util.c            |  2 +-
>  6 files changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index de2b7209cd05..b1165b22cc6f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -569,8 +569,17 @@ static __always_inline void kfree_bulk(size_t size, void **p)
>  	kmem_cache_free_bulk(NULL, size, p);
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
> -							 __alloc_size(1);
> +#ifdef CONFIG_SLAB_BUCKETS
> +void *__kmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
> +				__assume_kmalloc_alignment __alloc_size(2);
> +# define __kmalloc_node_noprof(b, size, flags, node)	\
> +	__kmalloc_buckets_node_noprof(b, size, flags, node)
> +#else
> +void *__kmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
> +				__assume_kmalloc_alignment __alloc_size(1);
> +# define __kmalloc_node_noprof(b, size, flags, node)	\
> +	__kmalloc_buckets_node_noprof(size, flags, node)
> +#endif
>  #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))

I found this too verbose and tried a different approach, in the end rewrote
everything to verify the idea works. So I'll just link to the result in git:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-buckets-v4-rewrite

It's also rebased on slab.git:slab/for-6.11/cleanups with some alloc_hooks()
cleanups that would cause conflicts otherwkse.

But the crux of that approach is:

/*
 * These macros allow declaring a kmem_buckets * parameter alongside size, which
 * can be compiled out with CONFIG_SLAB_BUCKETS=n so that a large number of call
 * sites don't have to pass NULL.
 */
#ifdef CONFIG_SLAB_BUCKETS
#define DECL_BUCKET_PARAMS(_size, _b)   size_t (_size), kmem_buckets *(_b)
#define PASS_BUCKET_PARAMS(_size, _b)   (_size), (_b)
#define PASS_BUCKET_PARAM(_b)           (_b)
#else
#define DECL_BUCKET_PARAMS(_size, _b)   size_t (_size)
#define PASS_BUCKET_PARAMS(_size, _b)   (_size)
#define PASS_BUCKET_PARAM(_b)           NULL
#endif

Then we have declaration e.g.

void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
                                __assume_kmalloc_alignment __alloc_size(1);

and the function is called like (from code not using buckets)
return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node);

or (from code using buckets)
#define kmem_buckets_alloc(_b, _size, _flags)   \
        alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))

And implementation looks like:

void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
{
        return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node, _RET_IP_);
}

The size param is always the first, so the __alloc_size(1) doesn't need tweaking.
size is also used in the macros even if it's never mangled, because it's easy
to pass one param instead of two, but not zero params instead of one, if we want
the ending comma not be part of the macro (which would look awkward).

Does it look ok to you? Of course names of the macros could be tweaked. Anyway feel
free to use the branch for the followup. Hopefully this way is also compatible with
the planned codetag based followup.

>  
>  void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
> @@ -679,7 +688,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
>  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
> -	return __kmalloc_node_noprof(size, flags, node);
> +	return __kmalloc_node_noprof(NULL, size, flags, node);
>  }
>  #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
>  
> @@ -730,10 +739,19 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
>   */
>  #define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
>  
> -void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
> -				  unsigned long caller) __alloc_size(1);
> +#ifdef CONFIG_SLAB_BUCKETS
> +void *__kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node,
> +					 unsigned long caller) __alloc_size(2);
> +# define kmalloc_node_track_caller_noprof(b, size, flags, node, caller)	\
> +	__kmalloc_node_track_caller_noprof(b, size, flags, node, caller)
> +#else
> +void *__kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
> +					 unsigned long caller) __alloc_size(1);
> +# define kmalloc_node_track_caller_noprof(b, size, flags, node, caller)	\
> +	__kmalloc_node_track_caller_noprof(size, flags, node, caller)
> +#endif
>  #define kmalloc_node_track_caller(...)		\
> -	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
> +	alloc_hooks(kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, _RET_IP_))
>  
>  /*
>   * kmalloc_track_caller is a special version of kmalloc that records the
> @@ -746,7 +764,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
>  #define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
>  
>  #define kmalloc_track_caller_noprof(...)	\
> -		kmalloc_node_track_caller_noprof(__VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
> +		kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
>  
>  static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
>  							  int node)
> @@ -757,7 +775,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
>  		return NULL;
>  	if (__builtin_constant_p(n) && __builtin_constant_p(size))
>  		return kmalloc_node_noprof(bytes, flags, node);
> -	return __kmalloc_node_noprof(bytes, flags, node);
> +	return __kmalloc_node_noprof(NULL, bytes, flags, node);
>  }
>  #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b4cb45255a54..8c29af7835cc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -273,6 +273,21 @@ config SLAB_FREELIST_HARDENED
>  	  sacrifices to harden the kernel slab allocator against common
>  	  freelist exploit methods.
>  
> +config SLAB_BUCKETS
> +	bool "Support allocation from separate kmalloc buckets"
> +	default y
> +	depends on !SLUB_TINY
> +	help
> +	  Kernel heap attacks frequently depend on being able to create
> +	  specifically-sized allocations with user-controlled contents
> +	  that will be allocated into the same kmalloc bucket as a
> +	  target object. To avoid sharing these allocation buckets,
> +	  provide an explicitly separated set of buckets to be used for
> +	  user-controlled allocations. This may very slightly increase
> +	  memory fragmentation, though in practice it's only a handful
> +	  of extra pages since the bulk of user-controlled allocations
> +	  are relatively long-lived.
> +
>  config SLUB_STATS
>  	default n
>  	bool "Enable performance statistics"
> diff --git a/mm/slab.h b/mm/slab.h
> index 5f8f47c5bee0..f459cd338852 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -403,16 +403,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
>   * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
>   */
>  static inline struct kmem_cache *
> -kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
> +kmalloc_slab(kmem_buckets *b, size_t size, gfp_t flags, unsigned long caller)
>  {
>  	unsigned int index;
>  
> +	if (!b)
> +		b = &kmalloc_caches[kmalloc_type(flags, caller)];
>  	if (size <= 192)
>  		index = kmalloc_size_index[size_index_elem(size)];
>  	else
>  		index = fls(size - 1);
>  
> -	return kmalloc_caches[kmalloc_type(flags, caller)][index];
> +	return (*b)[index];
>  }
>  
>  gfp_t kmalloc_fix_flags(gfp_t flags);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e0b1c109bed2..b5c879fa66bc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -702,7 +702,7 @@ size_t kmalloc_size_roundup(size_t size)
>  		 * The flags don't matter since size_index is common to all.
>  		 * Neither does the caller for just getting ->object_size.
>  		 */
> -		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
> +		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
>  	}
>  
>  	/* Above the smaller buckets, size is a multiple of page size. */
> @@ -1179,7 +1179,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  		return (void *)p;
>  	}
>  
> -	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> +	ret = kmalloc_node_track_caller_noprof(NULL, new_size, flags, NUMA_NO_NODE, _RET_IP_);
>  	if (ret && p) {
>  		/* Disable KASAN checks as the object's redzone is accessed. */
>  		kasan_disable_current();
> diff --git a/mm/slub.c b/mm/slub.c
> index 0809760cf789..ec682a325abe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4099,7 +4099,7 @@ void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
>  EXPORT_SYMBOL(kmalloc_large_node_noprof);
>  
>  static __always_inline
> -void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
> +void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
>  			unsigned long caller)
>  {
>  	struct kmem_cache *s;
> @@ -4115,7 +4115,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
>  	if (unlikely(!size))
>  		return ZERO_SIZE_PTR;
>  
> -	s = kmalloc_slab(size, flags, caller);
> +	s = kmalloc_slab(b, size, flags, caller);
>  
>  	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
>  	ret = kasan_kmalloc(s, ret, size, flags);
> @@ -4123,24 +4123,38 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
>  	return ret;
>  }
>  
> -void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
> +#ifdef CONFIG_SLAB_BUCKETS
> +# define __do_kmalloc_buckets_node(b, size, flags, node, caller)	\
> +	__do_kmalloc_node(b, size, flags, node, caller)
> +void *__kmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
> +#else
> +# define __do_kmalloc_buckets_node(b, size, flags, node, caller)	\
> +	__do_kmalloc_node(NULL, size, flags, node, caller)
> +void *__kmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
> +#endif
>  {
> -	return __do_kmalloc_node(size, flags, node, _RET_IP_);
> +	return __do_kmalloc_buckets_node(b, size, flags, node, _RET_IP_);
>  }
> -EXPORT_SYMBOL(__kmalloc_node_noprof);
> +EXPORT_SYMBOL(__kmalloc_buckets_node_noprof);
>  
>  void *__kmalloc_noprof(size_t size, gfp_t flags)
>  {
> -	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
> +	return __do_kmalloc_buckets_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>  
> -void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
> -				       int node, unsigned long caller)
> +#ifdef CONFIG_SLAB_BUCKETS
> +void *__kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags,
> +					 int node, unsigned long caller)
> +#else
> +void *__kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
> +					 int node, unsigned long caller)
> +#endif
>  {
> -	return __do_kmalloc_node(size, flags, node, caller);
> +	return __do_kmalloc_buckets_node(b, size, flags, node, caller);
> +
>  }
> -EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
> +EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
>  
>  void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
>  {
> diff --git a/mm/util.c b/mm/util.c
> index c9e519e6811f..80430e5ba981 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -128,7 +128,7 @@ void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
>  {
>  	void *p;
>  
> -	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
> +	p = kmalloc_node_track_caller_noprof(NULL, len, gfp, NUMA_NO_NODE, _RET_IP_);
>  	if (p)
>  		memcpy(p, src, len);
>  	return p;


