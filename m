Return-Path: <netdev+bounces-118697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC6952820
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CC1F21D4E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B91D52B;
	Thu, 15 Aug 2024 03:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9F1D545;
	Thu, 15 Aug 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691142; cv=none; b=JqfHTk61WQq0KOyP+dZZ1c6uIMX9a8J61tW5GXbn6Gos5E6bUNZ9EAZw7dG4BAr9aRPGaiQrJsXYMLHm/KC3d+eIqjGyWX+NDNMCTlHEv2c4VX7pQb9WAuDMEQC0xJzHTgS4DgaaxD3GbUh1GUYPgvliKdSaAM8yF0P75GRA+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691142; c=relaxed/simple;
	bh=aQ4j38eYHOR0FHNlDKeYxDDuotuVfW781ra6sK95+KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SXHIqaaJo3utiu2L3uxpiyXepYQbQYaaKJj45a8l33NxRmtB37B08u1WBZ9Iulr3SsDyWQR/63Vx7/7FXD0nno4p40bCFqeAobZtI8iKO5abe6suWPZMB58y/zPAQY9BV3OR7Y0tc5UXMuulhGhIdZx1Eg8tig+4T7TXJwjsyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkqcW1B0Dz20ljT;
	Thu, 15 Aug 2024 11:00:27 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DA3D61A0188;
	Thu, 15 Aug 2024 11:05:01 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Aug 2024 11:05:01 +0800
Message-ID: <7f06fa30-fa7c-4cf2-bd8e-52ea1c78f8aa@huawei.com>
Date: Thu, 15 Aug 2024 11:05:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-12-linyunsheng@huawei.com>
 <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 5:00, Alexander H Duyck wrote:

...

>
>> +static inline struct page *page_frag_alloc_probe(struct page_frag_cache *nc,
>> +						 unsigned int *offset,
>> +						 unsigned int *fragsz,
>> +						 void **va)
>> +{
>> +	unsigned long encoded_va = nc->encoded_va;
>> +	struct page *page;
>> +
>> +	VM_BUG_ON(!*fragsz);
>> +	if (unlikely(nc->remaining < *fragsz))
>> +		return NULL;
>> +
>> +	*va = encoded_page_address(encoded_va);
>> +	page = virt_to_page(*va);
>> +	*fragsz = nc->remaining;
>> +	*offset = page_frag_cache_page_size(encoded_va) - *fragsz;
>> +	*va += *offset;
>> +
>> +	return page;
>> +}
>> +
> 
> I still think this should be populating a bio_vec instead of passing
> multiple arguments by pointer. With that you would be able to get all
> the fields without as many arguments having to be passed.

As I was already arguing in [1]:
If most of the page_frag API callers doesn't access 'struct bio_vec'
directly and use something like bvec_iter_* API to do the accessing,
then I am agreed with the above argument.

But right now, most of the page_frag API callers are accessing 'va'
directly to do the memcpy'ing, and accessing 'page & off & len' directly
to do skb frag filling, so I am not really sure what's the point of
indirection using the 'struct bio_vec' here.

And adding 'struct bio_vec' for page_frag and accessing the value of it
directly may be against of the design choice of 'struct bio_vec', as
there seems to be no inline helper defined to access the value of
'struct bio_vec' directly in bvec.h

1. https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.com/

> 
>> +static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
>> +					  unsigned int fragsz)
>> +{
>> +	VM_BUG_ON(fragsz > nc->remaining || !nc->pagecnt_bias);
>> +	nc->pagecnt_bias--;
>> +	nc->remaining -= fragsz;
>> +}
>> +
> 

> 
>> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
>> +					 unsigned int fragsz)
>> +{
>> +	nc->pagecnt_bias++;
>> +	nc->remaining += fragsz;
>> +}
>> +
> 
> This doesn't add up. Why would you need abort if you have commit? Isn't
> this more of a revert? I wouldn't think that would be valid as it is
> possible you took some sort of action that might have resulted in this
> memory already being shared. We shouldn't allow rewinding the offset
> pointer without knowing that there are no other entities sharing the
> page.

This is used for __tun_build_skb() in drivers/net/tun.c as below, mainly
used to avoid performance penalty for XDP drop case:

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1598,21 +1598,19 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 }

 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
-				       struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad)
+				       char *buf, int buflen, int len, int pad)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);

-	if (!skb)
+	if (!skb) {
+		page_frag_free_va(buf);
 		return ERR_PTR(-ENOMEM);
+	}

 	skb_reserve(skb, pad);
 	skb_put(skb, len);
 	skb_set_owner_w(skb, tfile->socket.sk);

-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
-
 	return skb;
 }

@@ -1660,7 +1658,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct virtio_net_hdr *hdr,
 				     int len, int *skb_xdp)
 {
-	struct page_frag *alloc_frag = &current->task_frag;
+	struct page_frag_cache *alloc_frag = &current->task_frag;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -1676,16 +1674,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();

-	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	buf = page_frag_alloc_va_align(alloc_frag, buflen, GFP_KERNEL,
+				       SMP_CACHE_BYTES);
+	if (unlikely(!buf))
 		return ERR_PTR(-ENOMEM);

-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset + pad,
-				     len, from);
-	if (copied != len)
+	copied = copy_from_iter(buf + pad, len, from);
+	if (copied != len) {
+		page_frag_alloc_abort(alloc_frag, buflen);
 		return ERR_PTR(-EFAULT);
+	}

 	/* There's a small window that XDP may be set after the check
 	 * of xdp_prog above, this should be rare and for simplicity
@@ -1693,8 +1691,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 */
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+		return __tun_build_skb(tfile, buf, buflen, len, pad);
 	}

 	*skb_xdp = 0;
@@ -1711,21 +1708,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_prepare_buff(&xdp, buf, pad, len, false);

 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		if (act == XDP_REDIRECT || act == XDP_TX) {
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
-		}
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
-		if (err < 0) {
-			if (act == XDP_REDIRECT || act == XDP_TX)
-				put_page(alloc_frag->page);
-			goto out;
-		}
-
 		if (err == XDP_REDIRECT)
 			xdp_do_flush();
-		if (err != XDP_PASS)
+
+		if (err == XDP_REDIRECT || err == XDP_TX) {
+			goto out;
+		} else if (err < 0 || err != XDP_PASS) {
+			page_frag_alloc_abort(alloc_frag, buflen);
 			goto out;
+		}

 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
@@ -1734,7 +1726,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	local_bh_enable();

-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
+	return __tun_build_skb(tfile, buf, buflen, len, pad);

 out:
 	bpf_net_ctx_clear(bpf_net_ctx);


> 
>>  void page_frag_free_va(void *addr);
>>  
>>  #endif
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c

...

>> +static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
>> +					     gfp_t gfp_mask)
>>  {
>> +	struct page *page;
>> +
>>  	if (likely(nc->encoded_va)) {
>> -		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
>> +		page = __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
>> +		if (page)
>>  			goto out;
>>  	}
>>  
>> -	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>> -		return false;
>> +	page = __page_frag_cache_refill(nc, gfp_mask);
>> +	if (unlikely(!page))
>> +		return NULL;
>>  
>>  out:
>>  	/* reset page count bias and remaining to start of new frag */
>>  	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>  	nc->remaining = page_frag_cache_page_size(nc->encoded_va);
>> -	return true;
>> +	return page;
>> +}
>> +
> 
> None of the functions above need to be returning page.

Are you still suggesting to always use virt_to_page() even when it is
not really necessary? why not return the page here to avoid the
virt_to_page()?

> 
>> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
>> +				 unsigned int *fragsz, gfp_t gfp)
>> +{
>> +	unsigned int remaining = nc->remaining;
>> +
>> +	VM_BUG_ON(!*fragsz);
>> +	if (likely(remaining >= *fragsz)) {
>> +		unsigned long encoded_va = nc->encoded_va;
>> +
>> +		*fragsz = remaining;
>> +
>> +		return encoded_page_address(encoded_va) +
>> +			(page_frag_cache_page_size(encoded_va) - remaining);
>> +	}
>> +
>> +	if (unlikely(*fragsz > PAGE_SIZE))
>> +		return NULL;
>> +
>> +	/* When reload fails, nc->encoded_va and nc->remaining are both reset
>> +	 * to zero, so there is no need to check the return value here.
>> +	 */
>> +	__page_frag_cache_reload(nc, gfp);
>> +
>> +	*fragsz = nc->remaining;
>> +	return encoded_page_address(nc->encoded_va);
>> +}
>> +EXPORT_SYMBOL(page_frag_alloc_va_prepare);

...

>> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>> +				unsigned int *offset, unsigned int fragsz,
>> +				gfp_t gfp)
>> +{
>> +	unsigned int remaining = nc->remaining;
>> +	struct page *page;
>> +
>> +	VM_BUG_ON(!fragsz);
>> +	if (likely(remaining >= fragsz)) {
>> +		unsigned long encoded_va = nc->encoded_va;
>> +
>> +		*offset = page_frag_cache_page_size(encoded_va) -
>> +				remaining;
>> +
>> +		return virt_to_page((void *)encoded_va);
>> +	}
>> +
>> +	if (unlikely(fragsz > PAGE_SIZE))
>> +		return NULL;
>> +
>> +	page = __page_frag_cache_reload(nc, gfp);
>> +	if (unlikely(!page))
>> +		return NULL;
>> +
>> +	*offset = 0;
>> +	nc->remaining = remaining - fragsz;
>> +	nc->pagecnt_bias--;
>> +
>> +	return page;
>>  }
>> +EXPORT_SYMBOL(page_frag_alloc_pg);
> 
> Again, this isn't returning a page. It is essentially returning a
> bio_vec without calling it as such. You might as well pass the bio_vec
> pointer as an argument and just have it populate it directly.

I really don't think your bio_vec suggestion make much sense  for now as
the reason mentioned in below:

"Through a quick look, there seems to be at least three structs which have
similar values: struct bio_vec & struct skb_frag & struct page_frag.

As your above agrument about using bio_vec, it seems it is ok to use any
one of them as each one of them seems to have almost all the values we
are using?

Personally, my preference over them: 'struct page_frag' > 'struct skb_frag'
> 'struct bio_vec', as the naming of 'struct page_frag' seems to best match
the page_frag API, 'struct skb_frag' is the second preference because we
mostly need to fill skb frag anyway, and 'struct bio_vec' is the last
preference because it just happen to have almost all the values needed.

Is there any specific reason other than the above "almost all the values you
are using are exposed by that structure already " that you prefer bio_vec?"

1. https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.com/

> 

