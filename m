Return-Path: <netdev+bounces-246534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB547CED6A2
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 23:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219963005BAA
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A364242D9B;
	Thu,  1 Jan 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrixNxZc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="phSXlvmb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DC241103
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767306279; cv=none; b=BKD7KabrYgTmHF5gV4EGOM8Q9LovFdXbligSQPoY+3Ixevd/Vupf9kMIxrJjgHa/cOZxN5DYc3DXLkQFjbvoufOiQkhycv5jDa6IcFfXjWg8uQyn4R/4FpuS+L4VfJp3+ZeSzb53Iqzh0JrZVs6/fJggR4xD5yAikGA3quXSocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767306279; c=relaxed/simple;
	bh=1pkQHzjBRrINJT3k2r/bXsOnOt2jIUzUPya3b74nQWM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GqMv5UdId4+ZIPwiE/Chp7dskFVpaqUYTe2PLfDrf3XbuoZBxOYPF27OJVxtWyFSaKYN2rgkSko9KJBJ7h5FCHMDpnMHjhjjtBr5IRuFUWe3I0Z5Vq7ovw8qlIXeb0t5HqTgtu+Ow1gBURq0XKpxVjZi0LEpT/0Q3gW9HOOsBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrixNxZc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=phSXlvmb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767306276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW+8Zg1UcXlU+k++FZVC8Nur1miuNmN5tcR2y6encAQ=;
	b=OrixNxZcqzh4cY2fV4iC9FM8EBHcOkwlMDdVJXJOQ0RUYW9YwYTKhV7yi3ocrtIxtrv3l6
	jfOaK+Vz5LxX3Rp9YVTZCB7BMfXQiAcWHsaOFt3mWm3ncLhoIRTGjz2dTPWx0GCxl2pR7j
	sSfWcRXrOH5VGveeHKSpmIUJyCHLFcE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381--D0FjtEuM8eMDCXyBAkJVA-1; Thu, 01 Jan 2026 17:24:32 -0500
X-MC-Unique: -D0FjtEuM8eMDCXyBAkJVA-1
X-Mimecast-MFC-AGG-ID: -D0FjtEuM8eMDCXyBAkJVA_1767306272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so36417365e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767306271; x=1767911071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sW+8Zg1UcXlU+k++FZVC8Nur1miuNmN5tcR2y6encAQ=;
        b=phSXlvmb6IyUpXs07GXdW3AKS6fEVRAbqKldyAgKmyGAsjEY1PFHCKfdGLf34dd4m2
         UAulaXU18VjlkzmsyllY1RDthmsisZFs2Du9ESeH1L5uXYaiGk4hylWlkg0qrJl6LbFU
         B2iZ0FnEm01ANOJnxpMzFqM5xBD+PJ8rh7ylxhfMtRmUyDd46hfS2EIS96Ye+XdvgUOn
         68JBj8SqER/CHdBWxyGm/glGqcvWBK8x7CNvHIY4OfHS26hgoP8nKWv//cEtjdUTi5ou
         jAvU/oO61qaUDRCK2IpIggcr+w/ONb1rfdeSMZ2un5NN507Fl1VbrzcPeultuy4RsLFE
         DV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767306271; x=1767911071;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW+8Zg1UcXlU+k++FZVC8Nur1miuNmN5tcR2y6encAQ=;
        b=HJ4jcVBldWSGru1YpkITZMGZUljbwsyj6n+wggxb8s+RhB5c9OdW3OYdvWRnPpJrqp
         LqJZY5TussACMioxzfbHt+21v3C1y2lHI6SUkOcQDlZOggPHrqmY32OT/jBevaCl3GGh
         AlUyjWfDE4kDumOkQrpkkMVNX8gMjolddD0vz+lF9SoDfdiuZQJxmsDHJ0wWSIrj1v7I
         DHdhzOcagetRVI347jo0jDNWmucqmsPtEGJR17ghM7e3C+CQ2UnqnM2nffE9VKbozvj7
         bZbyxhuFerNXkEhZYMCa+LDy68p1uEPdDvG8lrSsFtbdp5G+zX+jBRbbQ7q1s463d2cJ
         OrCw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEK55yeE4if81bqHJW36XdvHM+UXbQqp0N1Z0ia74PDcCYRhmnfe2MU7sZtSkABWLUhHQy24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Yhz0WV2sqUWFu4vty/NHapSDRsvyvk4n9FsN+T+lNPCgVrFX
	sMIJc7We+vXdoWZSqGcutJqnYG5ypSyTX0C0y+hwYvqLcagNOPWB6zhWVFXHPfPUP7n7AfacERj
	BN65XfuuIZszK6+gZq9PEcPQmMUGfEcvx8rUk0llIXVTbJTs5P4DcWshBsEXB/orRNA==
X-Gm-Gg: AY/fxX4OAAbN2cVRtU+pEAiqSrLs/Q3pafFeoqqvVioA/AHJp4VaTexkkysU88OEYNa
	W76yvyVOKDSrBzSev6ZoPNLQg/SvAbQlwRARKMKggpQszazKa1dcK2EqkbEm/+m08x6vHSYzyht
	v2gz9CARnUk1M21wV2mIcx0SRRecv7SQ7lRAV8gWef+/CW1fz12JZrS9GugwYnA31lU2teCc/NA
	faU+8YhOhp+yyxJ6YTrZ2pOShVdBComPqHt7/TujaaLI2owXH8w5PRA+WH8nhgnbahs+7FtYpxz
	a1STUffGwnk/EBZZJSUL76AZgup78feuxkJ2bJfajecIP03JdVbb0E52trwfAJsXwRFIoX2TGUb
	0QHBAw76EhubdCqzyAdr2a9ofG3M4xOXpqAWQRgyRRAmUFOzaNaWRIKhp
X-Received: by 2002:a05:600c:45cf:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-47d19533403mr454588855e9.4.1767306271362;
        Thu, 01 Jan 2026 14:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdF4WchNCUJs7qbbpbfqE4eHtdF5DenkCgfGvSeYDHN25vpUhY9tQelLrlz7P/oN3WRTMYWg==
X-Received: by 2002:a05:600c:45cf:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-47d19533403mr454588735e9.4.1767306270904;
        Thu, 01 Jan 2026 14:24:30 -0800 (PST)
Received: from ?IPV6:2a02:6680:110a:4061:a163:6f2b:1ac3:6747? ([2a02:6680:110a:4061:a163:6f2b:1ac3:6747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a0fb5bsm314290285e9.1.2026.01.01.14.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 14:24:30 -0800 (PST)
Message-ID: <0684bf0a-c6eb-4d06-a054-dc9b4f97dbfa@redhat.com>
Date: Fri, 2 Jan 2026 00:24:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: mohammad heib <mheib@redhat.com>
Subject: Re: [PATCH net v2] net: skbuff: fix truesize and head state
 corruption in skb_segment_list
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kernelxing@tencent.com,
 kuniyu@google.com, atenart@kernel.org, aleksander.lobakin@intel.com
References: <20251231025414.149005-1-mheib@redhat.com>
 <willemdebruijn.kernel.14a62f33c80f0@gmail.com>
Content-Language: en-US
In-Reply-To: <willemdebruijn.kernel.14a62f33c80f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Willem,

You're right. I did a deeper dive into the callers and where the 
SKB_GSO_FRAGLIST bit actually originates.

It turns out it is exclusively set in the GRO complete paths (tcp4, 
udp4, tcp6, udp6). Since these packets are built by the GRO engine for 
forwarding, the fragments are guaranteed to be orphans without socket 
ownership or head state.

i will simply removed the truesize accumulation, as they are 
inapplicable to this GSO type.


One thing that’s confusing me is whether I should remove the call to 
skb_release_head_state().
This function updates reference counts for some fields in the skb, even 
when no socket is attached to it.

So I’m wondering should I remove this call, or keep it as is?
What do you think?

On 12/31/25 6:58 PM, Willem de Bruijn wrote:
> mheib@ wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> When skb_segment_list is called during packet forwarding through
>> a bridge or VXLAN, it assumes that every fragment in a frag_list
>> carries its own socket ownership and head state. While this is true for
>> GSO packets created by the transmit path (via __ip_append_data), it is
>> not true for packets built by the GRO receive path.
>>
>> In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
>> never charged to a socket. However, the current logic in
>> skb_segment_list unconditionally adds every fragment's truesize to
>> delta_truesize and subsequently subtracts this from the parent SKB.
>>
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
>>
>> Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> ---
>>   net/core/skbuff.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index a00808f7be6a..63d3d76162ef 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -4656,7 +4656,14 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>>   		list_skb = list_skb->next;
>>   
>>   		err = 0;
>> -		delta_truesize += nskb->truesize;
>> +
>> +		/* Only track truesize delta and release head state for fragments
>> +		 * that own a socket. GRO-forwarded fragments (sk == NULL) rely on
>> +		 * the parent SKB for memory accounting.
>> +		 */
>> +		if (nskb->sk)
>> +			delta_truesize += nskb->truesize;
>> +
> 
> Similar to the previous point: if all paths that generate GSO packets
> with SKB_GSO_FRAGLIST are generated from skb_gro_receive_list and that
> function always sets skb->sk = NULL, is there even a need for this
> brancy (and comment)?
> 
>>   		if (skb_shared(nskb)) {
>>   			tmp = skb_clone(nskb, GFP_ATOMIC);
>>   			if (tmp) {
>> @@ -4684,7 +4691,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>>   
>>   		skb_push(nskb, -skb_network_offset(nskb) + offset);
>>   
>> -		skb_release_head_state(nskb);
>> +		/* For GRO-forwarded packets, fragments have no head state
>> +		 * (no sk/destructor) to release. Skip this.
>> +		 */
>> +		if (nskb->sk)
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


