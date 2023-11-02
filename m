Return-Path: <netdev+bounces-45734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B27DF42E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C65FB211A6
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D7918E2C;
	Thu,  2 Nov 2023 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmRYxBfT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C012B87
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 13:44:36 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4905134
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:44:31 -0700 (PDT)
Message-ID: <4258aabd-5f7b-4b7f-ab43-408b69bfdc58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698932669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTwsvEmzpAhkFeS3ka+z/7oD+5A+b+o8OiW8/532NK8=;
	b=mmRYxBfTPMqUnOevJs2i2n/PQ2FSWXnoLZCAPkqb9GifUye+mw9JQnOpVepQ2pc1PZJpMG
	pfhMcilABjbX0HwQ7maZZoGrTWGQ9YvLfCD3LyflGCjlJ9/KoqG8XeBAwUs1f8xh16zQzf
	z3x7MMzpz6wTy02+tXcoku2JycRmiek=
Date: Thu, 2 Nov 2023 13:44:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>,
 "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
 <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 01/11/2023 23:41, Martin KaFai Lau wrote:
> On 11/1/23 3:50 PM, Vadim Fedorenko wrote:
>>>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
>>>> +{
>>>> +    enum bpf_dynptr_type type;
>>>> +
>>>> +    if (!ptr->data)
>>>> +        return NULL;
>>>> +
>>>> +    type = bpf_dynptr_get_type(ptr);
>>>> +
>>>> +    switch (type) {
>>>> +    case BPF_DYNPTR_TYPE_LOCAL:
>>>> +    case BPF_DYNPTR_TYPE_RINGBUF:
>>>> +        return ptr->data + ptr->offset;
>>>> +    case BPF_DYNPTR_TYPE_SKB:
>>>> +        return skb_pointer_if_linear(ptr->data, ptr->offset, 
>>>> __bpf_dynptr_size(ptr));
>>>> +    case BPF_DYNPTR_TYPE_XDP:
>>>> +    {
>>>> +        void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, 
>>>> __bpf_dynptr_size(ptr));
>>>
>>> I suspect what it is doing here (for skb and xdp in particular) is 
>>> very similar to bpf_dynptr_slice. Please check if 
>>> bpf_dynptr_slice(ptr, 0, NULL, sz) will work.
>>>
>>
>> Well, yes, it's simplified version of bpf_dynptr_slice. The problem is
>> that bpf_dynptr_slice bpf_kfunc which cannot be used in another
>> bpf_kfunc. Should I refactor the code to use it in both places? Like
> 
> Sorry, scrolled too fast in my earlier reply :(
> 
> I am not aware of this limitation. What error does it have?
> The bpf_dynptr_slice_rdwr kfunc() is also calling the bpf_dynptr_slice() 
> kfunc.
> 
>> create __bpf_dynptr_slice() which will be internal part of bpf_kfunc?

Apparently Song has a patch to expose these bpf_dynptr_slice* functions
ton in-kernel users.

https://lore.kernel.org/bpf/20231024235551.2769174-2-song@kernel.org/

Should I wait for it to be merged before sending next version?

