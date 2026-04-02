Return-Path: <netdev+bounces-274361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMS4DnTvzWkzjQYAu9opvQ
	(envelope-from <netdev+bounces-274361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7B3838AA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0EB3043D36
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E033E347;
	Thu,  2 Apr 2026 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZcgswfq"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A272314B62;
	Thu,  2 Apr 2026 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103348; cv=none; b=OYH90j6ED0aCcQBn/suhkNm1++4f69fKL13jVDSzEsNDEWPpZ++ofJ3BbKgVnP4/H8WfT7xdFJfxPt5Cruz2xIErGWi3UBcmEmaVeJh/lNGnZDITRV3J8RTnXH4VKGxWSaHq5j8e5jzKZf8LoHRD9/ur8TDPKriSAcL72RHW4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103348; c=relaxed/simple;
	bh=XQJE4Gn0KfowgirQDluRqeuQqW/CPd193d46pEtgYBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2st7jxyNk1NIL3KWqlHvtFIbytSN/7RQmb5NTjKWohCZVfgG4vH9Y3d+tsB/r3vq/wZAsREwg6HRFkVjPJ8jr8CZSHNOjloKDAcUrv/BUG3c6+rw0qCYKKXo5Yq8TTlP3qLYEHm0qcefAZz3NZA/dRUh7OBpz+fN4cinrwBUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZcgswfq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ad90b2a9-0f67-4796-94bc-9dbb76a575af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775103344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5Io74XLqo3KNsgBYSXiYBVqhjr7FhR8/0nd+R5bTLU=;
	b=MZcgswfqZ9iL6o+Q+tfn1Vy+DIC+L/Qt4TDqmK7oPt076dp+HIdN7SLrM7LbqA25ah72Up
	V4hukdmWKqxWaJoaFvzri0feMqM+GVPcmQV5yBfPRTrJKGoaErOEcR2tEU8ikxr0cGDmSY
	rvSkIXyEVEDsNKWWVlIO1raFA3OA8aY=
Date: Thu, 2 Apr 2026 12:15:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>,
 Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Soheil Hassas Yeganeh <soheil@google.com>,
 Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260402033138.388574-1-jiayuan.chen@linux.dev>
 <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLdRZd-qO4tRpSGamHpggh=r5vM4xes5npYCnkwcNG89A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co,fb.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 88B7B3838AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/2/26 12:01 PM, Eric Dumazet wrote:
> On Wed, Apr 1, 2026 at 8:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
>> value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
>> bucket sizes. This ensures that skb_kfree_head() can reliably use
>> skb_end_offset to distinguish skb heads allocated from
>> skb_small_head_cache vs. generic kmalloc caches.
>>
>> However, when KFENCE is enabled, kfence_ksize() returns the exact
>> requested allocation size instead of the slab bucket size. If a caller
>> (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
>> requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
>> slab_build_skb() → ksize() returns that exact value. After subtracting
>> skb_shared_info overhead, skb_end_offset ends up matching
>> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
>> the object to skb_small_head_cache instead of back to the original
>> kmalloc cache, resulting in a slab cross-cache free:
>>
>>    kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
>>    skbuff_small_head but got kmalloc-1k
>>
>> Fix this by adding an is_kfence_address() check in skb_kfree_head().
>> When the head is a KFENCE object, we skip the kmem_cache_free() path
>> and fall through to kfree(), which correctly handles KFENCE objects
>> via kfence_free(). The check compiles away when CONFIG_KFENCE is
>> disabled.
>>
>> Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb->head")
>> Reported-by: Antonius <antonius@bluedragonsec.com>
>> Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoiDazzsBk4TGgT1r4-A@mail.gmail.com/
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   net/core/skbuff.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 0e217041958a..87cecd40381b 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -91,6 +91,7 @@
>>   #include <linux/user_namespace.h>
>>   #include <linux/indirect_call_wrapper.h>
>>   #include <linux/textsearch.h>
>> +#include <linux/kfence.h>
>>
>>   #include "dev.h"
>>   #include "devmem.h"
>> @@ -1083,7 +1084,8 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>>
>>   static void skb_kfree_head(void *head, unsigned int end_offset)
>>   {
>> -       if (end_offset == SKB_SMALL_HEAD_HEADROOM)
>> +       if (end_offset == SKB_SMALL_HEAD_HEADROOM &&
>> +           !is_kfence_address(head))
>>                  kmem_cache_free(net_hotdata.skb_small_head_cache, head);
>>          else
>>                  kfree(head);
> Oh well, time to simply call kfree(head) ?
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 3d6978dd0aa83f63984b994359d0c914c6427a00..6b35aed23b8936409f6b0d4ee8d378f726c569c6
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1072,10 +1072,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>
>   static void skb_kfree_head(void *head, unsigned int end_offset)
>   {
> -       if (end_offset == SKB_SMALL_HEAD_HEADROOM)
> -               kmem_cache_free(net_hotdata.skb_small_head_cache, head);
> -       else
> -               kfree(head);
> +       kfree(head);
>   }
>
>   static void skb_free_head(struct sk_buff *skb)


If we no longer care about the cost of accessing a struct page in the
free path, which the original commit was trying to avoid, this is
indeed the simplest fix — kfree() correctly handles objects via 
virt_to_slab.


