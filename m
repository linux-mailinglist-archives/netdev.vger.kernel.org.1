Return-Path: <netdev+bounces-270940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFmbF5ZSwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB13052FD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09EA23034DF9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4983AEF37;
	Tue, 24 Mar 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGe0pJR1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="baSvWBmp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678236C9CB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342526; cv=none; b=mHmA/W7XKgtwugj/N+R2M/3Rg2nipd9pImQt6qN+3ozEcdeCAijBBUJZldH9k6pnGHGxN9LPydUBBHB3v6aoWtn8o86LhtwigMDydy29CZe2sdl6ZlpVFMy3WBQf4+PJhK/cZP4epI6KS/Qxvq/yRM8mdNOZEGFo3L1gIvsYu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342526; c=relaxed/simple;
	bh=nnwLfeX8Xj31jdUQAow/f6SrRJgezZGWNE5WWcyyXeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcyScwCEdtFK2HWcjEoFSwYkXNpzru15o69rxl/WahVKXhtmjEfPqrUuEtMXEozBFd+0bNKkmrsaXkD9g+bXqnJvBnBbOmkRIWdlTKnKqO0wA6GcE9W/pJecyCHK0QXaQk/qZVam7TeHL/0unPPkRHRS0uUJPs3E0nSkwC4ULz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGe0pJR1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=baSvWBmp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774342523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDbn4vfWWcZxsdXUlqagJpqSOsEI/45/fEadaMDENpk=;
	b=FGe0pJR1E7sjRtTKSLfCbHc1zW6e05fjLBqlyUFStmMH2fwLYzROp4qRdiQfBuuH3AoNAv
	pv8Wik0j9J171mfDIjVBKmpcx01p4j+338OiAG8ZIsR6yBgEjK4he5tprFIHWABlEkkuru
	7Ih2qL1D5jaXChFqN3AM/2tBOtkjcb4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-uUIyzQPVPyqaqdJJ27tu2w-1; Tue, 24 Mar 2026 04:55:21 -0400
X-MC-Unique: uUIyzQPVPyqaqdJJ27tu2w-1
X-Mimecast-MFC-AGG-ID: uUIyzQPVPyqaqdJJ27tu2w_1774342521
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852ccff333so13173435e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774342520; x=1774947320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDbn4vfWWcZxsdXUlqagJpqSOsEI/45/fEadaMDENpk=;
        b=baSvWBmpJ8dt5kszkOwVJfidvVC9CS1E+q0J3347tW0kPOmg/h6+eCULRvZ4x92tHG
         h3m6Y4RMVfpw4C9MfjKpb1mxSyGgkww9evIouCDGAFCeo1Bdd0vsGPbPu4VLD/n3o1jh
         o6a0w+FUL8ZtY1qulGQe4BZRjnLApNTxbiOgr9lvpOzXU+J/3RXjZNB49LFeegCyJ6lZ
         cjFg44FuoAxgsdqWxhBXijp4i2ghXtRoIkTU1ETHJI64AcuRK2VSTbcTquGxJzcijm1p
         Umx3k2IzPf/HhzVB5eP/42VLpb8dKAdyTjFNAQHJS/iC3tkxmiovXZ9MoKeRFE0TwZHM
         l4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342520; x=1774947320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDbn4vfWWcZxsdXUlqagJpqSOsEI/45/fEadaMDENpk=;
        b=kAvq6R2CabTe2j5/EmWR6a1EQjB1idaYA3RFvQSxcBNmlQnReVCcu+Tw8Z3upoH1zJ
         knvF3WFfUixo1cAwfecnLVSBzdjmJfk5udCRWkkcAhZyKn05FkcA8iNe6ynTxLon15uk
         68cWVnrgp25t5cuMVsHjNS8eY5/nWTSBYaFmrqDiciBAwfD6NDrpOIhtRmwBHofojfd2
         qFFviQPXN02g3ZIL5/o0ijCbpikCgAjmfckzaETMEdG4z/N9A+IxCSfaYmCoUseDCySg
         ky6tseSn7xkztSzbjowVXRrxdFRxsvNjjTJ0uCWRlrlL8XN2izrpxMCgpMdvydW7F3+Z
         w1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUZp8QP/Tc2N7jJWL8yr9t6jtZ/LSyy7K9BG5NqUGJKD6Pp0lPNyFu0RL2+cvL0BhUIy0Kx9Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgLuPUlzg8Y/oWwb3MUrqtN1PFzh2Bhjt7CYIJclo8SpD4Lv2
	pYo4qzeqYHrQpVrSgLtiU55LN/U79pOn44/nLkeCKjzAXsIpCDG49exVOIopKXyYr+MIJX+/Xer
	QnunhYGQNFQeKJLqL+Z/OvQ+ILeMd/X8mj0bsOj638z/TepA8gc0ISprtoQ==
X-Gm-Gg: ATEYQzy6NTakiH0AxyIMDKOQfraFfr91Iz0uQcbSKrLh+Hm+n5++kqt40sVXFUHzaC2
	VVm98Zzotczg4jecg64qt5Z7jSCGp9xjuAzI/EFyvY0G1cJqsNBZUyWE5FNC739iqjLHGHcvZ/X
	MJs3ZKGbmKC08/Vx+eYpKl8TQT7QuFb3NEF9y4iPEknBFwDIoOY2Vl4HjrkU19/YHgbUPljqZnl
	H8DGQ/1ZfWFIc40FwEjYuTu9VOt32KNQp0MBvdrO5PpF1lghgQqKbGy04VEp4irFabIXtLdpulw
	o2Au/Lry5BJCLRWjiAW/1KNvNpONcI1IBARRsEirY8J/MqV5lQ96NAHZL861JAhuupnqVYIgG6p
	HNwTa8i8l10WIx7AyiSK5N3Udsmv49bFHFKAhqyn7LJLEoP4WTa3d2GUU
X-Received: by 2002:a05:600c:4e49:b0:486:f9a4:d487 with SMTP id 5b1f17b1804b1-486feb6253dmr201425995e9.0.1774342520525;
        Tue, 24 Mar 2026 01:55:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e49:b0:486:f9a4:d487 with SMTP id 5b1f17b1804b1-486feb6253dmr201425545e9.0.1774342519940;
        Tue, 24 Mar 2026 01:55:19 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f7f5682sm20328145e9.3.2026.03.24.01.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 01:55:19 -0700 (PDT)
Message-ID: <6fb603dd-7bc2-4b60-bf93-7247d05f3250@redhat.com>
Date: Tue, 24 Mar 2026 09:55:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v17,08/14] net: homa: create homa_rpc.h and homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com
References: <20260316223228.2611-9-ouster@cs.stanford.edu>
 <20260318072131.268946-1-pabeni@redhat.com>
 <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmy7=A+Jc+iJ6jwddWs6x0z4pOudRs31Q41m9HMZ4yTWnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-270940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0DDB13052FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 11:43 PM, John Ousterhout wrote:
> On Wed, Mar 18, 2026 at 12:21 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> This approach would allow lockless RCU lookups and faster reclamation. Paolo
>> referenced tcp established socket lookup as an example:
>>
>>   "Have a look at tcp established socket lookup and the SLAB_TYPESAFE_BY_RCU
>>    flag usage for slab-based allocations. A combo of such flag for RPC
>>    allocation (using a dedicated kmem_cache) and RCU lookup should improve
>>    consistently the performances, with a consolidate code layout and no
>>    unmanageable problems with large number of objects waiting for the grace
>>    period."
>>
>> The current code still uses plain kzalloc/kfree without a dedicated cache.
>> Would it make sense to implement this optimization?
>>
>> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com/
> 
> I tried using a kmem_cache, but it made performance slightly worse:
> average allocation time for a struct homa_rpc increased from about 380
> cycles to about 400 cycles in my benchmarks. Since there is no
> performance advantage to using kmem_cache I removed it.

So kzalloc/kfree is faster than kmem_cache?!? That is quite unexpected,
possibly the kmem_cache pointer ends up on a contended cacheline?!? I
guess it would be useful to understand the extra overhead, as kmalloc is
basically another layer on top of kmem_cache.

> I'm surprised how long allocation takes: 400 cycles seems like a *lot*
> if there are per-cpu caches of the right size. Presumably no
> synchronization is needed and all the function has to do in the normal
> case is pull the top entry off a list.
> 
>>
>>> +     if (!srpc) {
>>> +             err = -ENOMEM;
>>> +             goto error;
>>> +     }
>>
>> [ ... ]
>>
>>> +error:
>>> +     homa_bucket_unlock(bucket, id);
>>> +     if (srpc && srpc->peer)
>>> +             homa_peer_release(srpc->peer);
>>> +     kfree(srpc);
>>> +     return ERR_PTR(err);
>>> +}
>>
>> [ ... ]
>>
>> In the v6 review thread, Paolo and Eric raised concerns about SKB freeing
>> costs and suggested optimizations. Eric noted that proper software GRO
>> significantly reduces SKB count using napi_get_frags() and napi_reuse_skb().
> 
> Unfortunately napi_reuse_skb is not currently exported. My
> understanding is that I need to wait until Homa GRO is upstreamed
> before I can request that it be exported. Once that happens I'll be
> happy to use napi_reuse_skb.

Ok

>> Paolo also suggested using deferred SKB freeing (skb_attempt_defer_free) to
>> reduce the cost. While you mentioned that GRO is implemented in the full
>> Homa but was left out of the initial patch series, would it be beneficial to
>> include at least some of these optimizations in this initial submission?
>>
>> Reference: https://lore.kernel.org/netdev/9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com/
> 
> When I asked ChatGPT about homa_attempt_defer_free it said that it
> only works if the skb has no dst, no destructor, and no skb_nfct. I'm
> a bit unsure how to proceed. Is homa_attempt_defer_free only intended
> for incoming packets? If so, then presumably there is no dst? But what
> about the other fields? Do I need to do something to clean them up
> before calling homa_attempt_defer_free?
skb_attempt_defer_free() usage is intended for the RX path only.

Incoming packets get state (dst, extensions, ct...) attached in the rx
path before reaching the socket. You should free/release the state, if
possible, before inserting the skb into the receive queue, so that you
could defer free them after read.

/P


