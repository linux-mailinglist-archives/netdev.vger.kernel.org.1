Return-Path: <netdev+bounces-246396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FFCEB293
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD2A30A5806
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187B248F68;
	Wed, 31 Dec 2025 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiTaOS++";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ndpIOmbK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA82030A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150082; cv=none; b=Sjrg3aqtCVedV04k8yQc4BzXHspFKYos4jduadoBIH3ykYp+s9JHWSeg0GP6toEvYWBWb79nPWn/0XY4gBWG55INvWrU361LADQugxPh1JEo97v6lQXskVI0TpTopSfkzab83mXk4qezzOJlV+cmlDgVsyqLLq7JuA23ksU7xqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150082; c=relaxed/simple;
	bh=j5/56dq5y4sPvWklnmoTSKv22DVSxN+8ZpCCp60ULkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyhkJq/XQw45Nl8jis41rA2OkTq4uW5LEGL00KvJPPwOdlABOpF6/TZtzsp68Uqy+1oKo0di+iwQoVUTedDUfnmfrPLDvJSV/fAiCfWfkYv/f+Lnr+hQ08buNN66eQ3/lF6FzsMPtMQJOJrgGq1lB05Lh2sQq7W4CoFhNUTfnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiTaOS++; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ndpIOmbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767150080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpuAXZR2DZN6xDgwvA3qUFkhx4ZaOl5/wr5F83Fq9x4=;
	b=IiTaOS++HhAs7XdzFOp0N3QZMC3OO2ZLP00Kz6ZijIpyREeRkahyYIi7l/q4VRITqLmoDi
	Btq6FM2lhWv5TY21Zto+bwKF7R3VIyUTArjxBbN5xO99jPEHtMUPIG7L02IZ8EyRxtvoKo
	UC7XiRYfr6CVHSZGOONbevgXFmZGLzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-waUMeHAMO6SwpI8t2puxuQ-1; Tue, 30 Dec 2025 22:01:18 -0500
X-MC-Unique: waUMeHAMO6SwpI8t2puxuQ-1
X-Mimecast-MFC-AGG-ID: waUMeHAMO6SwpI8t2puxuQ_1767150077
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so82716035e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767150077; x=1767754877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpuAXZR2DZN6xDgwvA3qUFkhx4ZaOl5/wr5F83Fq9x4=;
        b=ndpIOmbKiHCoRUHUM5JUcEC5eqUhqqdnfNGzL2/EQwCx/3m8wMvdYJUbQaVPafUX8C
         bdZ1TQBcj51GzcDlnQICT89goNfHIVshA2e98H3MjXxB3JR/BKhS09Qxdxd7U/nyBUwk
         dlQb1DMggiO7wTnRWJtSaYQrinIlnnSf4jNtI+FZNBg0GqDOQKntLcg6eM6pSBC9THuk
         W/mmQFRz+MC0jW3G52zwpccdklyyTOkP1HJzpFoYivVvXWDOxVfKCgZop6tpDeyzYd9k
         8RzkE279yTmm7PEY0rqgLEraE/bFib8cFebac2CFFgz2KCzzSeSRIa1nJikn4v94u/RT
         17VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767150077; x=1767754877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpuAXZR2DZN6xDgwvA3qUFkhx4ZaOl5/wr5F83Fq9x4=;
        b=Zh0d70Xg6rBRYlMjJ1JJOqTSYVf9zG+4eg8SAV+OL+aJNXABMj22wcawM4oYp8SEgp
         bXbxc4ihgVfy/dU+4E8OhunX0rd85LR6Y23z0gKz1ef6ObY9CCN2mQ1meFbIBXfyRxH+
         ftqs9IHFeho4nTmMRl/hfcAqGJCtlGV+xkkgeyUKGr54jbvhx2qYdf8rI2LQn5ci5pNI
         SCNfdIkHiLd9XVh2Q7TfdiQa86zZY/4hW8gGrN93OM7itYl8DUa2DYgshFru+OkfoyV8
         w2n+SKQ5t7jqoIVYSiRXeE20qEtqJafGMo89SLWtew4Voiw56hoBrRB79laXg/Zyk2L3
         HSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBi2ZXLFoTFVu83g6tpZlfKMpzRYR4A5RnTfZm5PBOsSEluOQ/4hbZidk0wKC63KJfetHmr38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjR0f+wyuD9gBlmjxCO3OskL7Wu9UMV+3GZxlKKmcz5luWMNQ
	IRxBoIyabdmz1/wD8E/uzCp2LHB7hSVRctlx4GzW2bnYpi58yD2rKlynFqeWOxgt5Y9ZcSvOW1j
	HN+J5sO0M3mNYQhoV89mFjQOU5PEgz71gEb4g0bO4vqkcVT9DSsmyXi53JA==
X-Gm-Gg: AY/fxX6f7jFskXCgiPY1OStJWKD+ppoPurTzp0hSqsCRZjrVXNqUAckpZ8QXx5FTe3P
	FWMiqrviMtWmJj0ZUvzXPFaxDlABwkh3Y+uA1inyxdzSFkRv6cTi3+eVRmfbp19KnfJcMY4lRe7
	sYsOOF3YFl/iRcQIaJFWCHxkg+GiLARuBn8dTMZiHgCG/9vg2koYgDS/QTJyy7JUiOItxqj3nwc
	DOZcUMuL/4fE3oG94jeUHeexkU7OLmDJ5mP/+iYska3nPD6JQ18twuyKQ8A4/6rECreunJOAybs
	zmfJ5onnzfIkrkWYKfD/SGLAYEf6q1v2p2KWSZVtZMVA0wdGdPq/QEq1gpcl8OEoY5lxFc7yUVJ
	8ePtUex3Si5hWOcKjH5IO3Q==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr511340235e9.16.1767150077007;
        Tue, 30 Dec 2025 19:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4iIsJsXzzJ/VbxBA1KTnd+CYHFN82zG4QtFhi7Dx1Sa6BzziDbaT6xP6GaiD4yzxcD/l6Mw==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr511339935e9.16.1767150076617;
        Tue, 30 Dec 2025 19:01:16 -0800 (PST)
Received: from [192.168.68.125] ([216.128.14.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346dfcsm752640775e9.1.2025.12.30.19.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 19:01:15 -0800 (PST)
Message-ID: <218c929c-b2a2-4965-861b-5733a265acfa@redhat.com>
Date: Wed, 31 Dec 2025 05:01:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: skbuff: fix truesize and head state corruption
 in skb_segment_list
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kernelxing@tencent.com,
 kuniyu@google.com, steffen.klassert@secunet.com, atenart@kernel.org
References: <20251230091107.120038-1-mheib@redhat.com>
 <willemdebruijn.kernel.2dac63d32f3d9@gmail.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <willemdebruijn.kernel.2dac63d32f3d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Willem,

Thank you for the review and for tracing the history of the accounting 
logic.


On 12/30/25 6:31 PM, Willem de Bruijn wrote:
> mheib@ wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> When skb_segment_list is called during packet forwarding through
>> a bridge or VXLAN, it assumes that every fragment in a frag_list
>> carries its own socket ownership and head state. While this is true for
>> GSO packets created by the transmit path (via __ip_append_data), it is
>> not true for packets built by the GRO receive path.
> 
> We have to separate packets that use frag_list, a broader category,
> from those that use fraglist gso chaining. This code path is only
> exercised by the latter.
That makes perfect sense. I will remove the redundant is_flist check 
since this path is only reached for fraglist GSO, and I'll update the 
Fixes tag to ed4cccef64c1 in v2.
> 
>> In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
>> never charged to a socket. However, the current logic in
>> skb_segment_list unconditionally adds every fragment's truesize to
>> delta_truesize and subsequently subtracts this from the parent SKB.
> 
> This was not present in the original fraglist chaining patch cited in
> the Fixes tag. It was added in commit ed4cccef64c1 ("gro: fix
> ownership transfer"). Which was a follow-on to commit 5e10da5385d2
> ("skbuff: allow 'slow_gro' for skb carring sock reference") removing
> the skb->destructor reference.
>   
>> This results a memory accounting leak, Since GRO fragments were never
>> charged to the socket in the first place, the "refund" results in the
>> parent SKB returning less memory than originally charged when it is
>> finally freed. This leads to a permanent leak in sk_wmem_alloc, which
>> prevents the socket from being destroyed, resulting in a persistent memory
>> leak of the socket object and its related metadata.
>>
>> The leak can be observed via KMEMLEAK when tearing down the networking
>> environment:
>>
>> unreferenced object 0xffff8881e6eb9100 (size 2048):
>>    comm "ping", pid 6720, jiffies 4295492526
>>    backtrace:
>>      kmem_cache_alloc_noprof+0x5c6/0x800
>>      sk_prot_alloc+0x5b/0x220
>>      sk_alloc+0x35/0xa00
>>      inet6_create.part.0+0x303/0x10d0
>>      __sock_create+0x248/0x640
>>      __sys_socket+0x11b/0x1d0
>>
>> This patch modifies skb_segment_list to only perform head state release
>> and truesize subtraction if the fragment explicitly owns a socket
>> reference. For GRO-forwarded packets where fragments are not owners,
>> the parent maintains the full truesize and acts as the single anchor for
>> the memory refund upon destruction.
> 
> Thanks for the report and fix. It can probably be simplified a bit
> based on knowledge that only fraglist chaining skbs reach this path.
> And the Fixes tag should reflect the patch that changed this
> accounting in the GRO patch. Matching that in the GSO path makes
> sense.
> 
>> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> ---
>>   net/core/skbuff.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index a00808f7be6a..aee9be42409b 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -4641,6 +4641,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>>   	struct sk_buff *tail = NULL;
>>   	struct sk_buff *nskb, *tmp;
>>   	int len_diff, err;
>> +	bool is_flist = !!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
> 
> This is guaranteed when entering skb_segment_list.
> 
>>   
>>   	skb_push(skb, -skb_network_offset(skb) + offset);
>>   
>> @@ -4656,7 +4657,15 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>>   		list_skb = list_skb->next;
>>   
>>   		err = 0;
>> -		delta_truesize += nskb->truesize;
>> +
>> +		/* Only track truesize delta if the fragment is being orphaned.
>> +		 * In the GRO path, fragments don't have a socket owner (sk=NULL),
>> +		 * so the parent must maintain the total truesize to prevent
>> +		 * memory accounting leaks.
>> +		 */
>> +		if (!is_flist || nskb->sk)
>> +			delta_truesize += nskb->truesize;
>> +
I considered combining the two if (nskb->sk) blocks into one to simplify 
the code further, but I decided against it to avoid reordering the 
skb_clone and skb_push logic, which felt too risky for this path.
>>   		if (skb_shared(nskb)) {
>>   			tmp = skb_clone(nskb, GFP_ATOMIC);
>>   			if (tmp) {
>> @@ -4684,7 +4693,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>>   
>>   		skb_push(nskb, -skb_network_offset(nskb) + offset);
>>   
>> -		skb_release_head_state(nskb);
>> +		/* For GRO-forwarded packets, fragments have no head state
>> +		 * (no sk/destructor) to release. Skip this.
>> +		 */
>> +		if (!is_flist || nskb->sk)
>> +			skb_release_head_state(nskb);
>> +
>>   		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
>>   		__copy_skb_header(nskb, skb);
>>   
>> -- 
>> 2.52.0
>>
> 
> 
Thanks


