Return-Path: <netdev+bounces-289518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHBaM4+PDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01A58259C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4BFF3302A30
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F23FB042;
	Tue, 19 May 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv2H5Lab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD12DCBF8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206890; cv=none; b=lxTxYTnD5r51wwm9YLdDKCTy0s3Hus1x0xm3bsTLHkALFUnQyrPldi1ymI9FfGq18M9zch4yLXt7G4KgB2OuXF8QgcHVON+2T0jXWUNrVfrxgRSt/FQLHSivL4lJrpE18B3uix8u+2fSNb0/t2H12iec8RpABR8dp7BR7ag3XvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206890; c=relaxed/simple;
	bh=UuyF9HSNLo2vfD4Gvn/2sLT/MUfk98mNlM17lhTaJNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJqkedkTIz8t2nP3f/UaQKF5bv2LQUGV7004lKcmPBjocEwEcrCfOM7Fxgd86EXkOYk03uGoJUnbTOT0r9Ygpcd8S2QE+0ZvPXay5ksQdSOERS6bk+5Y0+LZ+Ap/qgVeDemXqBzCuNZKToB9Mvkgz5aq4COGYEwG8ZL+/OAUDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv2H5Lab; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45d96d21e82so2235806f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779206886; x=1779811686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ubhMnVbQfORgfno1r5ieAcypoEGZy/A2m77VzqQGjb8=;
        b=iv2H5Lab86i7Gdw0bqr7rsEeGeLjZ8HBemJOByB1mIpVPTXLR9Bi773Y2lAKc+LLZ8
         7BESIL54l0fAlIlJCVAPCH7qLqjCvy6zErIhlQjlRq5MkyDJbhzn3bHd76kTdIS5+Fk0
         XNNu+/u2y2+n2ITeD80H051y8DIUqnjXWYa2M7MaGHQmHjdBV4g/bynqXdqX3G6EWfT5
         Woq/Im4/0l0N0Le/9v2DTbmQc5pE8k8+vMjsQ92Th18s66XE/i72qDp8o5pVWZkWKTFw
         d052IkPo/mlYBSj+G1p4CWs3Tg6aLwQb2+zR20+Hn2LUAKBvwsDD3g+qcu1KlUz4s/BM
         KJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206886; x=1779811686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubhMnVbQfORgfno1r5ieAcypoEGZy/A2m77VzqQGjb8=;
        b=sUypGXFSdc8sIsClD0WKcqh0PLTtnMuzpEOEZ/LGCr4EIRDLdr3G8IfIfFOFfleP9Z
         FIwjfks99l4pYaxm4oDWvFTgotHeYyX/yP7t23fyxWJkBamQ33pnDFwO3Q0faOfAC9sh
         v8D9JFuW0ypQzY9Aj+CKvEw0VrvlRWGo3MfQUtwMqu4gOZRhbuLhqassrIEyGHVU7C9K
         wk5dfmvZKxjdgOQOQ86Ob6CDZ5KIZQqCKdw6onhnIRf1YmVctQLhBB0hJMZ7p0GXd+Ij
         +iO77MuI6yK4VJUVWL7IWI8TWKl8bIrJfRlRecZ42Y1+ishhfITYivqXc7S4CW+KzI4q
         vMgQ==
X-Gm-Message-State: AOJu0Yxe/V9S/X+nYIDJgua350iNhpkK2xoNokm4twmXN+vcpohiv5UJ
	wQAM+d3EKTlFgSAYKV4QdH8R31LoeAz/Lu3Nkay0VBkGarf8MtQr/5Hk
X-Gm-Gg: Acq92OEaEU2YgrexYP6dqketQkWl33Gyl+DW3zBwXLnGRN18/+INoODp2fZS5a6ScJh
	RmLjPdcw+9eklnCE8GaJki87pgsxtkb7Opro/oqw6l3SgiECDrDaVAw/BT3TKGZfSHp6cjKd/rd
	sfdSGb+2dTQ741O0NDus8iuV91pe0dOLKTihsAXGMSmOESR4pZ7y8DPXSAtl3Qz0JC9Wy9DSa3Z
	OaXvJjxexhY36BlQM8Yjkvo+LNQpMkDNP1sgkQDSBkQHKsex/DOKRBIv8jip6dTEKeunB/jTDfz
	9z1KfGWVW4ng0ZxJbdgBBaNMZl/B47S8KIQncDRpP4XF+m4UfeN/bw5i3n9DyMP3dKpwc6vReTD
	B7RLImkyv6dnFXfmU6z4f46QFl0GtYRuk9nl/wiY54isRui8ZDi8IpCO1NNMha7+eMPxrGEw1AB
	SESJYbbOXQOfe4TDQ7MB6eRfitIyx4GB4TAe+7LPbtkr2C3CW6MVyvRMUtYVYzoF+ieewril+jf
	U2VlL0OLzv0o/pX+/J1AwTt0sqIlkwXBEDyHnMdwy9AOFDsY4K8XVXjnPFS/uMLJJHKVk9KnYrF
	DQ==
X-Received: by 2002:a05:6000:2584:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-45e5c5e6d3dmr33130978f8f.43.1779206885595;
        Tue, 19 May 2026 09:08:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm43195577f8f.11.2026.05.19.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 09:08:04 -0700 (PDT)
Message-ID: <57122bd8-034a-4f12-b1f7-641798252044@gmail.com>
Date: Tue, 19 May 2026 17:08:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <7db0d602-bbbd-4554-996c-1dcefd69e2bf@gmail.com>
Content-Language: en-US
In-Reply-To: <7db0d602-bbbd-4554-996c-1dcefd69e2bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3B01A58259C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 17:04, Pavel Begunkov wrote:
> On 5/19/26 16:43, Jens Axboe wrote:
>> On 5/19/26 9:40 AM, Pavel Begunkov wrote:
>>> On 5/19/26 16:37, Jens Axboe wrote:
>>>> On 5/19/26 9:30 AM, Pavel Begunkov wrote:
>>>>> On 5/19/26 16:26, Jens Axboe wrote:
>>>>>> On 5/19/26 5:44 AM, Pavel Begunkov wrote:
>>>>>>> @@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
>>>>>>>         return allocated;
>>>>>>>     }
>>>>>>>     +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
>>>>>>> +{
>>>>>>> +    struct io_kiocb *req = tw_req.req;
>>>>>>> +    struct io_ring_ctx *ctx = req->ctx;
>>>>>>> +
>>>>>>> +    io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
>>>>>>> +    percpu_ref_put(&ctx->refs);
>>>>>>> +    io_poison_req(req);
>>>>>>> +    kmem_cache_free(req_cachep, req);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
>>>>>>> +{
>>>>>>> +    gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
>>>>>>> +    u32 type_mask = 1 << type;
>>>>>>> +    struct io_kiocb *req;
>>>>>>> +
>>>>>>> +    if (!(type_mask & ifq->allowed_notif_mask))
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    guard(spinlock_bh)(&ifq->ctx_lock);
>>>>>>> +    if (!ifq->master_ctx)
>>>>>>> +        return;
>>>>>>> +    if (type_mask & ifq->fired_notifs)
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    req = kmem_cache_alloc(req_cachep, gfp);
>>>>>>> +    if (unlikely(!req))
>>>>>>> +        return;
>>>>>>
>>>>>> It'd be nice to avoid an allocation here inside ctx_lock and with bh's
>>>>>> disabled, which looks like is also the only reason why GFP_ATOMIC is
>>>>>> being used here.
>>>>>
>>>>> I thought about it, but it's already bh, it'd need to do pre
>>>>> allocations + caching to be reliable, but that's left out for now.
>>>>
>>>> Not sure I follow - GFP_KERNEL would be more reliable than GFP_ATOMIC.
>>>> What's the contract in terms of the notification? If we fail the alloc,
>>>> then userspace can't rely on the notification on the refill failure.
>>>>
>>>> Are we under bh save already here, before doing it ourselves? If so,
>>>> then how does the guard work?
>>>
>>> In 99% of cases it's called from softirq, not sure what you mean
>>> by how it works.
>>
>> Ah ok, I thought you meant it was already called with softirqs disabled.
>> In which case the guard would seem broken, as we'd enable softirqs when
>> exiting. But if we're just inside softirq yeah it's fine, and there's no
>> point shuffling the allocation either.
> 
> Softirqs are run with bh disabled, but bh_disable()/enable() are
> reenterable.

Better to say they're counting nesting

>> Question on the contract still stands, in terms of missing a
>> notification. I guess since it's a hint basically it doesn't really
>> matter, just something that should be documented on the userspace side.
> 
> Should rather be improved than documented, I'd say, but it's still
> better than not getting anything at all. And it's the only place
> where it can in theory be dropped, e.g. CQE overflow handling,
> though different GFP.
> 
>> Do you have test cases for these?
> 
> Clement needs to resend them. Actually, seems I forgot to CC Vish
> and Clement here, my bad.
> 

-- 
Pavel Begunkov


