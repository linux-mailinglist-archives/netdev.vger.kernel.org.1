Return-Path: <netdev+bounces-107594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46591BA3B
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC651F21166
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CCD1487EB;
	Fri, 28 Jun 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPIsx+oM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMYv8r8A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPIsx+oM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMYv8r8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76E14F98;
	Fri, 28 Jun 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564014; cv=none; b=PDiAAUfhj+zlk+yIj/+p/uZvatwd+idn+RZFRvFM7KQ8yWc39WUdrnGV/i7DAPA6U/t5QFkS6IBNeI4/qkYfSl6LDEzaK/dollufN6sp4kRHnxlnRwyTXxr+IhmcfvfLDy8GbGHHJFOHbOOURLpd02iEDAARgMHbpp/pL7u3QNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564014; c=relaxed/simple;
	bh=oD2TUcIQ5qkCHK0l1VWrBaoyqsFf9pVwQjTQh3qp+PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQz0Ucq3aBWeSQrwNftQW+Mxqu65Uh2B52CEGG5iTHTWzLgfSUxhFfYAdJN+lE5es2odJ1AAPIXgVQ41f/jDQ3T1T/0aoF3RQhwVCBb+d1nXo1VdU+YUW5bokuDBxQnu5tRixz4/ieQ8mi5J94/XKZD8fxeZlvd9mg+g6HO4Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPIsx+oM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMYv8r8A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPIsx+oM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMYv8r8A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27B461F747;
	Fri, 28 Jun 2024 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719564010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9qpm7trLYBBpBHSkVBmWJQl68Vu8zybpSC4P6Dcg0Mg=;
	b=dPIsx+oMObbOuS/AH3Ykciepy5Bkxc8nw0XqAG+vA+6XkVHxr7/sy1Y/IHMAwIYaAPR9ND
	MBFj6NyjGWAiL4vo+mPJ75XRNPiAqN7Ouu/2YzXMLzPifT5dKEPn6WI2VRjKDgpnx74N64
	2dEhEQ4UGlei0xRzDDanpUg5rQf5q2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719564010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9qpm7trLYBBpBHSkVBmWJQl68Vu8zybpSC4P6Dcg0Mg=;
	b=hMYv8r8AhICyXXWVwuk9+cXayKQgvDisIhldBF71YiIp986veSMWQTvOFEDFuuiI7a94Li
	CGPU0lCTkIIF8PCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dPIsx+oM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hMYv8r8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719564010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9qpm7trLYBBpBHSkVBmWJQl68Vu8zybpSC4P6Dcg0Mg=;
	b=dPIsx+oMObbOuS/AH3Ykciepy5Bkxc8nw0XqAG+vA+6XkVHxr7/sy1Y/IHMAwIYaAPR9ND
	MBFj6NyjGWAiL4vo+mPJ75XRNPiAqN7Ouu/2YzXMLzPifT5dKEPn6WI2VRjKDgpnx74N64
	2dEhEQ4UGlei0xRzDDanpUg5rQf5q2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719564010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9qpm7trLYBBpBHSkVBmWJQl68Vu8zybpSC4P6Dcg0Mg=;
	b=hMYv8r8AhICyXXWVwuk9+cXayKQgvDisIhldBF71YiIp986veSMWQTvOFEDFuuiI7a94Li
	CGPU0lCTkIIF8PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E87C31373E;
	Fri, 28 Jun 2024 08:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDIrOOl2fmY3JQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 28 Jun 2024 08:40:09 +0000
Message-ID: <c5934f76-3ce8-466e-80d1-c56ebb5a158e@suse.cz>
Date: Fri, 28 Jun 2024 10:40:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 jvoisin <julien.voisin@dustri.org>, Andrew Morton
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, Thomas Graf <tgraf@suug.ch>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz>
 <202406201147.8152CECFF@keescook>
 <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz>
 <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 27B461F747
X-Spam-Score: -3.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,linux.com,google.com,lge.com,dustri.org,linux-foundation.org,linux.dev,gmail.com,huawei.com,suug.ch,gondor.apana.org.au,vger.kernel.org,kvack.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/28/24 7:35 AM, Boqun Feng wrote:
> On Thu, Jun 20, 2024 at 10:43:39PM +0200, Vlastimil Babka wrote:
>> On 6/20/24 8:54 PM, Kees Cook wrote:
>> > On Thu, Jun 20, 2024 at 03:56:27PM +0200, Vlastimil Babka wrote:
>> >> > @@ -549,6 +549,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
>> >> >  
>> >> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
>> >> >  
>> >> > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
>> >> > +				  slab_flags_t flags,
>> >> > +				  unsigned int useroffset, unsigned int usersize,
>> >> > +				  void (*ctor)(void *));
>> >> 
>> >> I'd drop the ctor, I can't imagine how it would be used with variable-sized
>> >> allocations.
>> > 
>> > I've kept it because for "kmalloc wrapper" APIs, e.g. devm_kmalloc(),
>> > there is some "housekeeping" that gets done explicitly right now that I
>> > think would be better served by using a ctor in the future. These APIs
>> > are variable-sized, but have a fixed size header, so they have a
>> > "minimum size" that the ctor can still operate on, etc.
>> > 
>> >> Probably also "align" doesn't make much sense since we're just
>> >> copying the kmalloc cache sizes and its implicit alignment of any
>> >> power-of-two allocations.
>> > 
>> > Yeah, that's probably true. I kept it since I wanted to mirror
>> > kmem_cache_create() to make this API more familiar looking.
>> 
>> Rust people were asking about kmalloc alignment (but I forgot the details)
> 
> It was me! The ask is whether we can specify the alignment for the
> allocation API, for example, requesting a size=96 and align=32 memory,
> or the allocation API could do a "best alignment", for example,
> allocating a size=96 will give a align=32 memory. As far as I
> understand, kmalloc() doesn't support this.

Hm yeah we only have guarantees for power-or-2 allocations.

>> so maybe this could be useful for them? CC rust-for-linux.
>> 
> 
> I took a quick look as what kmem_buckets is, and seems to me that align
> doesn't make sense here (and probably not useful in Rust as well)
> because a kmem_buckets is a set of kmem_caches, each has its own object
> size, making them share the same alignment is probably not what you
> want. But I could be missing something.

How flexible do you need those alignments to be? Besides the power-of-two
guarantees, we currently have only two odd sizes with 96 and 192. If those
were guaranteed to be aligned 32 bytes, would that be sufficient? Also do
you ever allocate anything smaller than 32 bytes then?

To summarize, if Rust's requirements can be summarized by some rules and
it's not completely ad-hoc per-allocation alignment requirement (or if it
is, does it have an upper bound?) we could perhaps figure out the creation
of rust-specific kmem_buckets to give it what's needed?

> Regards,
> Boqun
> 
>> >> I don't think any current kmalloc user would
>> >> suddenly need either of those as you convert it to buckets, and definitely
>> >> not any user converted automatically by the code tagging.
>> > 
>> > Right, it's not needed for either the explicit users nor the future
>> > automatic users. But since these arguments are available internally,
>> > there seems to be future utility,  it's not fast path, and it made things
>> > feel like the existing API, I'd kind of like to keep it.
>> > 
>> > But all that said, if you really don't want it, then sure I can drop
>> > those arguments. Adding them back in the future shouldn't be too
>> > much churn.
>> 
>> I guess we can keep it then.
>> 


