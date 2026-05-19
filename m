Return-Path: <netdev+bounces-289516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gONAEEqQDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97436582681
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD1C4319DCAB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858BF2E7657;
	Tue, 19 May 2026 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg74Crdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115D2E8DE3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206671; cv=none; b=u3t4Zt1pWIc783J2WSzVPbn4aISXzPaTvdjrnMIr2RG9krXHPp9XbBwQphcDuNAKJFBv8RXjodxImTytDrEpkiPF2kJXqP131bInrQ+MUMAfloDxqYU3o2fs5x+YFfUNvbsZZoV2HfWoMjygmLJWL4ZyIyzmOiAtJ68mPVoI43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206671; c=relaxed/simple;
	bh=2tjWB4WUQQSaJNP4H/chO839vCPnJWUadjgVObpCiKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVz6zS/XlCtNmUWGn0sWajHMoGv5P1pXQgY255jYumwlT8Q1Ni2XRysdn0zzwKhHB2iy6A802DVQndWe1gVOpwqVFJgAS67PDDubU0XDXA2xAluGDOJm8PL3v1OFTBZlDqHpIiTZ7DuUi+swbjOQ2okXW9I4/q1VhXKOPL+ITdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg74Crdt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so41232185e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206668; x=1779811468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKpR0xmeanMEpxqOiWggE8obfMM9EdqhCBPTTtEFV9I=;
        b=kg74Crdtz3jf/JJtHhf+jrCoyCfor+1DIZDOm3W26dYJL9sBEcbkCbeqvD3q+lvR4x
         l71Si9gwcnpjBBOCHdK3o/Vk0IK6zncLBYfvQKeJK3gNzrwEiJUGJlLsJ2ls6ECgv47r
         89c3sxNV9iuMpKfEwkYGhRpYtC9yEyRoOvVcNnS/UadKBhhF4UArTzzFvwxNjr74Pksp
         tHGqKUeMdp+0+K1MD2n8a3CGkmw/1tsDWy5V8cVzaBRwAvom7/mCBlcnT7ULkvE0whnL
         wufKro9tSaQVjH0JRp3pb2IMoBQSipGify23USt+bdwsK36QbB/8rh9wghsduRYM0WOS
         kPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206668; x=1779811468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKpR0xmeanMEpxqOiWggE8obfMM9EdqhCBPTTtEFV9I=;
        b=O5wCcRz8NN2kZEiLOrZnx2lXDZBVqB+tu8o2wNN5eiX/0phOCsOvfPc92CZ74H/0+0
         5aofjYcQbcdjN2mGKhxgbmxX0AhhYZhKRurVLevgH6uJtN7t1XwBLSCYvTlGudTe/G7X
         Xq0qc3J3xqggCUW5dij4zz6anbt16Ugs8g09umM9GIRvJpE1aSUN0PP54UKaPyg6E+Rx
         18sjsGsNTM9NfX3S9MIyoSfWsxEg3ZGYUSnh2F/0HsdYyNPfQqRxYHRz8tlxQJ+XLVYX
         D6HBb+k/k0CDwF5JdmYHD/KjZ+ZYypreGYFPquUVOYJ0JshOFCxJb6PWvdxrX++rv5Y4
         CgdA==
X-Gm-Message-State: AOJu0YzT+9QmL4+H1KKUAdtoQfuaOJIfeh12y9w4Qei3IlRS7pI4578Q
	WO2Wx/Jb7SgzcKeAPIndZl7Nl2BLMjCIt5e+kHhNFBN+g3QsHCE4D3Rc
X-Gm-Gg: Acq92OEt4hQmE/ZOgTVA1PckyxVDcJtbK08h9SabaGkJevtv6UH4HF9c/vi7QexbJMy
	MVLQvVROIzNANE4fIXdyfArBeDHrXF+0jXI9DoxlbvhPH4Gh2PySkj7EFnMYb7OOJBmVy9BWFv5
	MA7OCAGmRheS3DIYHOTe25Hjfmw+UiuwlNhjZa0fOpOqZ+DscLOSBJNqQFl6ed+vvpyPpsblrLz
	dxmblq/eCnIxwhd11Y0ohJtjjrIS2aOLKQ5JYyQAvUDDEn0wNT3bLHV7tDIO/ZgZ4osLCQPwwde
	a9iYxKqdubkLhoJ+TZ7uJ4BU+LxGXG9cRf0phOczOWahGR2Q6tL+3lp4buGRvQCao8UnzQkEHOm
	1XGb48slXQ697iUOHBfISNN1PtxuLq51i8TVzKnWVhgbT4taxK21h9uG8K2MC9yRbBG44fO5pgG
	p74ThFVJMEXd5D1SOhx+O4gXPWILr9L53erli0kQ8aT0q4kJRk4kkpcFbDSqNRpCHZpKKFva5Lu
	6ITTm6H30RDBz+BzAbRK3VbEIeVAWNmByvyw7Uv8zrgg0Q0mtWg9PsLu5sKZpz9HOhbtccY5ZsL
	Ng==
X-Received: by 2002:a05:600c:46cf:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-48fe66267eemr303236615e9.28.1779206668014;
        Tue, 19 May 2026 09:04:28 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767ee0sm43798869f8f.1.2026.05.19.09.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 09:04:27 -0700 (PDT)
Message-ID: <7db0d602-bbbd-4554-996c-1dcefd69e2bf@gmail.com>
Date: Tue, 19 May 2026 17:04:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@meta.com>, Vishwanath Seshagiri <vishs@meta.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
 <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
 <7bfd707b-1e21-413e-a2e7-71e8df3e43d7@kernel.dk>
 <6d1187c8-ba4f-41ad-b692-351d8b072038@gmail.com>
 <a2a92049-0974-478a-9297-76af96b455d8@kernel.dk>
 <c8a21efc-1443-4ff2-ac53-7846533a26bb@gmail.com>
 <2305e4d6-55cf-421c-94b0-ad8aae8db99c@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2305e4d6-55cf-421c-94b0-ad8aae8db99c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97436582681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 16:43, Jens Axboe wrote:
> On 5/19/26 9:40 AM, Pavel Begunkov wrote:
>> On 5/19/26 16:37, Jens Axboe wrote:
>>> On 5/19/26 9:30 AM, Pavel Begunkov wrote:
>>>> On 5/19/26 16:26, Jens Axboe wrote:
>>>>> On 5/19/26 5:44 AM, Pavel Begunkov wrote:
>>>>>> @@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
>>>>>>         return allocated;
>>>>>>     }
>>>>>>     +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
>>>>>> +{
>>>>>> +    struct io_kiocb *req = tw_req.req;
>>>>>> +    struct io_ring_ctx *ctx = req->ctx;
>>>>>> +
>>>>>> +    io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
>>>>>> +    percpu_ref_put(&ctx->refs);
>>>>>> +    io_poison_req(req);
>>>>>> +    kmem_cache_free(req_cachep, req);
>>>>>> +}
>>>>>> +
>>>>>> +static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
>>>>>> +{
>>>>>> +    gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
>>>>>> +    u32 type_mask = 1 << type;
>>>>>> +    struct io_kiocb *req;
>>>>>> +
>>>>>> +    if (!(type_mask & ifq->allowed_notif_mask))
>>>>>> +        return;
>>>>>> +
>>>>>> +    guard(spinlock_bh)(&ifq->ctx_lock);
>>>>>> +    if (!ifq->master_ctx)
>>>>>> +        return;
>>>>>> +    if (type_mask & ifq->fired_notifs)
>>>>>> +        return;
>>>>>> +
>>>>>> +    req = kmem_cache_alloc(req_cachep, gfp);
>>>>>> +    if (unlikely(!req))
>>>>>> +        return;
>>>>>
>>>>> It'd be nice to avoid an allocation here inside ctx_lock and with bh's
>>>>> disabled, which looks like is also the only reason why GFP_ATOMIC is
>>>>> being used here.
>>>>
>>>> I thought about it, but it's already bh, it'd need to do pre
>>>> allocations + caching to be reliable, but that's left out for now.
>>>
>>> Not sure I follow - GFP_KERNEL would be more reliable than GFP_ATOMIC.
>>> What's the contract in terms of the notification? If we fail the alloc,
>>> then userspace can't rely on the notification on the refill failure.
>>>
>>> Are we under bh save already here, before doing it ourselves? If so,
>>> then how does the guard work?
>>
>> In 99% of cases it's called from softirq, not sure what you mean
>> by how it works.
> 
> Ah ok, I thought you meant it was already called with softirqs disabled.
> In which case the guard would seem broken, as we'd enable softirqs when
> exiting. But if we're just inside softirq yeah it's fine, and there's no
> point shuffling the allocation either.

Softirqs are run with bh disabled, but bh_disable()/enable() are
reenterable.

> Question on the contract still stands, in terms of missing a
> notification. I guess since it's a hint basically it doesn't really
> matter, just something that should be documented on the userspace side.

Should rather be improved than documented, I'd say, but it's still
better than not getting anything at all. And it's the only place
where it can in theory be dropped, e.g. CQE overflow handling,
though different GFP.

> Do you have test cases for these?

Clement needs to resend them. Actually, seems I forgot to CC Vish
and Clement here, my bad.

-- 
Pavel Begunkov


