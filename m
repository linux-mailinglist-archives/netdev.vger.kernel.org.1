Return-Path: <netdev+bounces-178393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B616FA76D14
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C552D7A11A4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7972153E1;
	Mon, 31 Mar 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPHStNMh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A88635B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447447; cv=none; b=MAfreV4o6gIb50io1mii3k1bJarG0BRHIoDBAlmFHKze5YD+6JS53E7HLLkonDz9g/Xz2YxySRldQgT80xxxQT3wxfM2FKfpJFxrgXBD+bA8mvufBOcUKv2MYt44ReqeN4Y56Q5CrNQkitR/kHzI4IPcYlaozdMxdpaV6EsxxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447447; c=relaxed/simple;
	bh=YmflCkYghetjuTqEta5HLi3//mMy8HqvUxvXAbpe6nE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sbyZSCZLmVDchqkR39CDNtwQSfQYYgpv8Seu52tCkAQaEMy8c7UP6cyfxjo+ZzbFND1OtyRnVH3VGTsQid6XiIXe3D9tASgsf2e+77yIuM4c/qd+RRytomhRpIIHQ+P2vx2YSaOXKv02tBbM0MNYTFelJ/OjTfhoWCXNr8tSM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPHStNMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743447444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uxGqI8XHlSWUG0vUbjqkpMVF/NlTmqGXy4qbepua0s=;
	b=TPHStNMhhYuoTUzXUqEKhqVrCxZn27dFKvkMRZ4YStNKu+TVaQbRYCqqu49Ozomz4J5wdj
	MEaM4E6AYX+sskFFQQJ5c5f7HLa33WLv8reNYqr/qjYdifngz+HTFIrhCMP5/2SifgfsFH
	F6aNAccUGr1YJrXo/ifz+VDqo44bhR0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-iCw0y7r9OlKQLrvfwP3Shw-1; Mon, 31 Mar 2025 14:57:23 -0400
X-MC-Unique: iCw0y7r9OlKQLrvfwP3Shw-1
X-Mimecast-MFC-AGG-ID: iCw0y7r9OlKQLrvfwP3Shw_1743447443
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54a6b0c70so445771485a.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447443; x=1744052243;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uxGqI8XHlSWUG0vUbjqkpMVF/NlTmqGXy4qbepua0s=;
        b=ZhAytXDwpKHWBotsD+O9+PPYWz3i7pzC7wtOGbvf6iWKHYqj6qHUy/Ppy2ETVdrmuY
         dK7DLh0b+M5EIPXwJVu/F4jf+r5jemxrU4vBLfJ6Lnj/eUJjAq/td4Hk/xFRQvUfKJep
         W7E4pc4En5qXb89t7lEjq83EwNliMWnPU2KS21W5nDN74U+ewO/KZ6IwLrhC2mNrhRoa
         InvWXqUBubRDTv4H4nUjr+MxWnu78bP3bdLzEZYSqaZl3xLyfrVjsuJDWSUVuRbaEkYs
         xFBRoAGo28A1TrZLA7KVrXlZ21Yif7Xl0Dkm6+W1mZLfb8Gb5ApgHJ2f3XXxju73KTfK
         dCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7wV7iXP6EAlvHrUU+SxfxccQOV4Khk8dJvYXw0+YymK/Y8DbJECKHnClzXh3rRUvfVXibMO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn/jjOlo6Ihwl66RU7GvIVsYqzipd/RDtepYJHFnE5drfkF8L
	Y1jMf5U9qYEI2JBJDXDKweJQqxvxN06WpgUbNIQtolaPGJ+D5QdjQXbnBoyoDB9Ltaym+b6XybL
	VQF6Y/Q03pyeN6msDLFhBYyHJRRycsTqElDFiBYq4au8cmSiSOORBlw==
X-Gm-Gg: ASbGncs+03tHW3boNLE1U3JuXNPmpDNJcZaAIh8WEJZcks7gc1rLUvQ8t+ux0NKqE7M
	V46YawLXPO/SvgLtdqhwkJUmC+32q/Aqp+hPA9at26V8Po/67KcXUfecQY2fBYfK836AXVtbkQa
	tsS9T//sQxiyT0jhdLDlvZztM7W9fObAs4X1E8CBFmwzsR/Hga+gnaSvl/CGD6wDDmT4sBBjBEr
	UZd9SJ4p3uRO1R8WKj/0VZ5XZJaO3m0TSNKaZi2PGqXDIimVxx4py3VQEmsBe5AObpWt4hvf8Ca
	tl6X6h6cz5bYroT6O8R6s0ptz+LTuNJXy9ZugvuXeGYek4gTDqFQphYmehn78A==
X-Received: by 2002:a05:620a:2992:b0:7c5:4463:29aa with SMTP id af79cd13be357-7c69087def9mr1592719285a.40.1743447442663;
        Mon, 31 Mar 2025 11:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESQYDsfnezfjUkx7Y5slcu+4vSypZZz7O52dCEgLcLpGd4fd2d2RSisyzUxxCGuahqVd1Ibw==
X-Received: by 2002:a05:620a:2992:b0:7c5:4463:29aa with SMTP id af79cd13be357-7c69087def9mr1592715585a.40.1743447442363;
        Mon, 31 Mar 2025 11:57:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76838ccsm528423685a.40.2025.03.31.11.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 11:57:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <69592dc7-5c21-485b-b00e-1c34ffb4cee8@redhat.com>
Date: Mon, 31 Mar 2025 14:57:20 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: paulmck@kernel.org, Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>
References: <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <Z-rQNzYRMTinrDSl@boqun-archlinux>
 <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>
 <35039448-d8e8-4a7d-b59b-758d81330d4b@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <35039448-d8e8-4a7d-b59b-758d81330d4b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 2:33 PM, Paul E. McKenney wrote:
> On Mon, Mar 31, 2025 at 01:33:22PM -0400, Waiman Long wrote:
>> On 3/31/25 1:26 PM, Boqun Feng wrote:
>>> On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
>>> [...]
>>>>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>>>>> of an interrupt context on top of a task context. It is possible that the
>>>>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>>>>> interrupt happens when the task has set the hazard pointer and iterating the
>>>>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>>>>> we could have multiple slots for the hazard pointer, but that will make the
>>>>>> code more complicated. Or we could disable interrupt before setting the
>>>>>> hazard pointer.
>>>>> Or we can use lockdep_recursion:
>>>>>
>>>>> 	preempt_disable();
>>>>> 	lockdep_recursion_inc();
>>>>> 	barrier();
>>>>>
>>>>> 	WRITE_ONCE(*hazptr, ...);
>>>>>
>>>>> , it should prevent the re-entrant of lockdep in irq.
>>>> That will probably work. Or we can disable irq. I am fine with both.
>>> Disabling irq may not work in this case, because an NMI can also happen
>>> and call register_lock_class().
>> Right, disabling irq doesn't work with NMI. So incrementing the recursion
>> count is likely the way to go and I think it will work even in the NMI case.
>>
>>> I'm experimenting a new idea here, it might be better (for general
>>> cases), and this has the similar spirit that we could move the
>>> protection scope of a hazard pointer from a key to a hash_list: we can
>>> introduce a wildcard address, and whenever we do a synchronize_hazptr(),
>>> if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
>>> hence synchronize_hazptr() will still wait until it's zero'd. Not only
>>> this could help in the nesting case, it can also be used if the users
>>> want to protect multiple things with this simple hazard pointer
>>> implementation.
>> I think it is a good idea to add a wildcard for the general use case.
>> Setting the hazptr to the list head will be enough for this particular case.
> Careful!  If we enable use of wildcards outside of the special case
> of synchronize_hazptr(), we give up the small-memory-footprint advantages
> of hazard pointers.  You end up having to wait on all hazard-pointer
> readers, which was exactly why RCU was troublesome here.  ;-)

If the plan is to have one global set of hazard pointers for all the 
possible use cases, supporting wildcard may be a problem. If we allow 
different sets of hazard pointers for different use cases, it will be 
less an issue. Anyway, maybe we should skip wildcard for the current 
case so that we have more time to think through it first.

Cheers,
Longman


