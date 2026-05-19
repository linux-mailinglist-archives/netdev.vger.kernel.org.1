Return-Path: <netdev+bounces-289507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIOvIz6HDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9F581C57
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300813021B6C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDB26FA60;
	Tue, 19 May 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS3RaeaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B83408034
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205209; cv=none; b=Bm2w4kmukZZzFf8vI2BAlnCT6UStffHvpxMJkitkCJm1jh0zzLC+EtAFdQsQFSuXXGrAcIxS13rF6ra9+pDWL2SgCdiS1x5LPKhx5qZai7Eb8MzNzGlMbdQMkNWh1+GmNTjyTv2yGHq9qEuY7kg/HFecVvhUV1VAy2YLmXKsP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205209; c=relaxed/simple;
	bh=VqfmuRUR4pAPAKkVX1wGFRDSX6LNkgAlJ8owEszBkhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foRkIGoPrtVGIG2jlUn/RH8QGBZbZQKjuMeAUbAzACRKIwXzmkvswuwsIJhliS29UDWgA+ZOTOTMDOYstGwn1o2wuX+l/MxzlLyZ2en9cHz/BgE8+wW866jdKbjAqQmNvxAy2oQ2qNKJ0ny0M7Mv3GXiAp0iiVlMIHusVTcfGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS3RaeaV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so955326f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205206; x=1779810006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC/v3xAD64Yo45QN+MWzqi0ETrD4fk0lPn5eRRtf9TA=;
        b=PS3RaeaVmH2GgVnKKOTdgYN5Rp59I9oHC3KjEKNqzhfvn/twZ78HbxggIxzsPbcZwo
         +1usVMXJuNXSWUHfd5N1Cx8x2XaUeOWVBww6UjDNwg6OgRLcnhTuj8GafrZA8clc7XGN
         xN0LS/ZKiI1BX+KDftX3zGaFCPpqoO5f0eEA5DnBzVFCrUelNufgT+/dtuCIIeb13kkr
         jkAYbuAp4cR0nY++Go4Yp9Nn3rMepthok8YPnf6WyD2hVd4Qab3WgcOot1+4H8kPVz5m
         hCSgKyDffJ4oABp/S+6AQ5t95wftPVCsJ82HXuaJi6nMfmutiofk1DwBcI0MG7rI3586
         bJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205206; x=1779810006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC/v3xAD64Yo45QN+MWzqi0ETrD4fk0lPn5eRRtf9TA=;
        b=o6bD0CF+0ny+mF95sEXjIzO729nSe7XoIa5tPWPa9K39lkC1LKo8omuqsoyx2GC7+7
         9iFtJ9IsVwDTTYRgXoSItHNhNKLxFzBwxziL6D2Gkn3PpPJac31nenkmzg2OlbcA4Sx/
         33xyq0egTZETEIlu8TRU2owJBZyXXnr8F909gxK4diAJqqD9RlmCc+Gu6G00z+OWDoS5
         EtX6uRbT/m8HAXOlTYSG8R2X4T4rZToUToFSIhLrDEjky9Y9pWEroXahXdypA5Vm2jjN
         9ceeB0MbTdKcK5xgVMNwaWGstc0ql4jpHNsq8Gb3UATDTjlB1ghxkjfnLEPui0OaCScd
         AUlw==
X-Gm-Message-State: AOJu0Yw3vSrz9oQmnuXLdre7ETcnCya7Ry6VyaTb/AjEI1e+jFgOxT0v
	0fMradU6Zf7qoeZpFeDzg37Tx0KKzGkaO4dURuJdIJscwJJTesXz6CaTn9LvFg==
X-Gm-Gg: Acq92OEW6CWS80AYVvsCwrdzXiIMWLAzGD9PCmHnA8YgAVceqc79lH4QyCi5oWJZ1OF
	xzCb7sN7nbSZkEMJQloveU79vkGk1ZXpuw4wnX/+KY5RqbUGS++UGi83Yf+wTMy/rTFoELW2G8Q
	72vmgOUokMwWolKSPbsH1wwDCKBE8BW7lPueEyQKB62zCmrkeJUPGmr45bffORlO65gufpDdQ7x
	UyDbXJbiJS+YJLfF0hXKAnOh2dcpYyWxmTnw1QeXQKLls8JS7cN9yJTMbZFewGVA+hRqKVGLvhp
	TjVp0yKIX3kbx3Tf7AtgB33WuYzb99ZHLVH8kw8vDlzz6XQ9DpQC/hRsD0lmWDKVOXBMB1Lhs3P
	3wnzcklKPiHs7XrCkorc6f8/3JuxJYXiXkf4G+1ikhzHZ9j1r+dYWQ2RxSOHOVyV2+h1UWuGwcU
	MkKy8gGidys1H3jZkxn/NEqKFbTfRpM8q/pLf94jgIAof37G8y7c8ERjIhwOcozxHb0EPwf4sIo
	7aTDIOGY8+AzeLFxNAKbB2FZRqKqv838lpe0OpxLi2hfXRQ94mED5G3HQXA9fNjz2LnGbcX4xZa
	iH2jMz0C/VSa
X-Received: by 2002:a05:6000:1ac7:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-45e5c35e285mr32942526f8f.9.1779205205779;
        Tue, 19 May 2026 08:40:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm49414987f8f.25.2026.05.19.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:40:05 -0700 (PDT)
Message-ID: <c8a21efc-1443-4ff2-ac53-7846533a26bb@gmail.com>
Date: Tue, 19 May 2026 16:40:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1779189667.git.asml.silence@gmail.com>
 <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
 <7bfd707b-1e21-413e-a2e7-71e8df3e43d7@kernel.dk>
 <6d1187c8-ba4f-41ad-b692-351d8b072038@gmail.com>
 <a2a92049-0974-478a-9297-76af96b455d8@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a2a92049-0974-478a-9297-76af96b455d8@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289507-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8CA9F581C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 16:37, Jens Axboe wrote:
> On 5/19/26 9:30 AM, Pavel Begunkov wrote:
>> On 5/19/26 16:26, Jens Axboe wrote:
>>> On 5/19/26 5:44 AM, Pavel Begunkov wrote:
>>>> @@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
>>>>        return allocated;
>>>>    }
>>>>    +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
>>>> +{
>>>> +    struct io_kiocb *req = tw_req.req;
>>>> +    struct io_ring_ctx *ctx = req->ctx;
>>>> +
>>>> +    io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
>>>> +    percpu_ref_put(&ctx->refs);
>>>> +    io_poison_req(req);
>>>> +    kmem_cache_free(req_cachep, req);
>>>> +}
>>>> +
>>>> +static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
>>>> +{
>>>> +    gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
>>>> +    u32 type_mask = 1 << type;
>>>> +    struct io_kiocb *req;
>>>> +
>>>> +    if (!(type_mask & ifq->allowed_notif_mask))
>>>> +        return;
>>>> +
>>>> +    guard(spinlock_bh)(&ifq->ctx_lock);
>>>> +    if (!ifq->master_ctx)
>>>> +        return;
>>>> +    if (type_mask & ifq->fired_notifs)
>>>> +        return;
>>>> +
>>>> +    req = kmem_cache_alloc(req_cachep, gfp);
>>>> +    if (unlikely(!req))
>>>> +        return;
>>>
>>> It'd be nice to avoid an allocation here inside ctx_lock and with bh's
>>> disabled, which looks like is also the only reason why GFP_ATOMIC is
>>> being used here.
>>
>> I thought about it, but it's already bh, it'd need to do pre
>> allocations + caching to be reliable, but that's left out for now.
> 
> Not sure I follow - GFP_KERNEL would be more reliable than GFP_ATOMIC.
> What's the contract in terms of the notification? If we fail the alloc,
> then userspace can't rely on the notification on the refill failure.
> 
> Are we under bh save already here, before doing it ourselves? If so,
> then how does the guard work?

In 99% of cases it's called from softirq, not sure what you mean
by how it works.

-- 
Pavel Begunkov


