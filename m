Return-Path: <netdev+bounces-137771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B2C9A9B6E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DD283847
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C7147C96;
	Tue, 22 Oct 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBOzerfe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6536124
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583245; cv=none; b=gB3hF6JptcWlEKkTSWXVV3/J6Alm+nQCf74CIipGfYE9K5q8Vn8hP5fzmN2x8dvYztFcmYwR0vKZX42cJqTCBSvGo3Q9fxaS2bVzvi2wuaW5pgD7cnFfMCi8MiHyPfVfKG/ahzSu2l9m3FCyaJuoGNK+Kndd9PhKl9hBKfdnhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583245; c=relaxed/simple;
	bh=OVRJxv9x90A9DJ03++ep8+DddHsSsCDKbvaSIuXn/iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqYRxsI15c23FHrGSSHt5Ae9ggdExZ8NKiCCrIkTWO1agQVKrjaYrgiBj+CqT6irjgJ9xnDed0iiVqOeIbKN7bgwEiz9CMr+V+nDF9YRw88TFeWQJF8fd9Z6lO23t/MtKpXYSsGO92FinV7uVLrydajhv+y6CUdDCVxFvH0/Alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBOzerfe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729583242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OegxXw1Vw+pKDNjPxCG8pY0AoURUBOt/R207Qvp4Efw=;
	b=XBOzerfemPIwgCEQeZorMWZqEKn3wbLvDSyeiM2nSLz01ftX778gHwyieZqmHw7gbFyll4
	Nka70ossWzEE3ROso/LlnZ4QHJS8NVSnZyNDDbBQjhuiKynaPX2RQVv0IqZI/R3Fn+dwzZ
	1HdTbPIlXuqjSk8dB1GuVP8c9/ftmn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-mrhJwNyKOZKKOKyZcOQrCQ-1; Tue, 22 Oct 2024 03:47:20 -0400
X-MC-Unique: mrhJwNyKOZKKOKyZcOQrCQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431673032e6so24793985e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583239; x=1730188039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OegxXw1Vw+pKDNjPxCG8pY0AoURUBOt/R207Qvp4Efw=;
        b=D5MHQM93SIy4bSkdbenBakFREXNNzIdxlhZowqM1V3Np1++q6h3x7J6bkPm5PsUoJI
         02mGFBXc7fmZdyjk0/vFs3s+Hp7GmWB+FSlATdIlrMTU2KqRj+TxgwP0eaOtjdVZBIdN
         UEcMVo6LZlA4/yZl5kSHAlde/gvwc8U5OSiQI/nA3dkMk685zPOR3BB1VpGqY1l2LuwV
         HF6oAFvXKx4eq72n8LJkySSwI8h/iP0lcuy6VAPuHIoC4ov9jqZjFI4Qjd6P5/x5Gq7c
         keHIyhmsnsNuiLKhf2ePYZ1yG0uuZ/UTwVGSQUtSDIF4EwuWn9IstJMgsUDhdZKwstk4
         0STg==
X-Forwarded-Encrypted: i=1; AJvYcCX5HfiSHTV3o9UirqIdSJgv5VMUa0MB102+di6pSyeGfFmnY+rZUIuSdukG3MDSZDP/ZJzhsEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YximmlkREH74QWz1dTewC4mbAteKCZn2XepOz8ct/ikFEGVVXKN
	CCDSbEatRaydLsSb+M2lB0F5Yewcr47i/eLjMR9zPjByXAvWgkmyGVxb3koMhRK+ii6W8mPRM1E
	VMY3CV9NDR3xiv97LkQ11QFdrx+d93myJfyarDbdADKKh3MZAz/otnA==
X-Received: by 2002:a05:600c:1e16:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-4317b8df1f6mr21182235e9.8.1729583239498;
        Tue, 22 Oct 2024 00:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXTXlisHjpV11RLP2z4bI0q7tAfIEYGag76YGytSTvWWKiZMTHumdO1S9rlWOXaO0I0LI7Uw==
X-Received: by 2002:a05:600c:1e16:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-4317b8df1f6mr21182085e9.8.1729583239124;
        Tue, 22 Oct 2024 00:47:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm80659805e9.45.2024.10.22.00.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:47:18 -0700 (PDT)
Message-ID: <be07ab23-6bc6-4c2c-8544-0a76c457bf08@redhat.com>
Date: Tue, 22 Oct 2024 09:47:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/15] net: add helper executing custom callback from
 napi
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-9-dw@davidwei.uk>
 <cd9c2290-f874-49e6-bc99-5336a096cffb@redhat.com>
 <9d2c123d-9e1e-4365-a047-e4fe84444ab9@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9d2c123d-9e1e-4365-a047-e4fe84444ab9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/21/24 19:16, Pavel Begunkov wrote:
> On 10/21/24 15:25, Paolo Abeni wrote:
>> On 10/16/24 20:52, David Wei wrote:

[...]
>>> +	napi = napi_by_id(napi_id);
>>> +	if (!napi)
>>> +		return;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>> +		preempt_disable();
>>> +
>>> +	for (;;) {
>>> +		local_bh_disable();
>>> +
>>> +		if (napi_state_start_busy_polling(napi, 0)) {
>>> +			have_poll_lock = netpoll_poll_lock(napi);
>>> +			cb(cb_arg);
>>> +			local_bh_enable();
>>> +			busy_poll_stop(napi, have_poll_lock, 0, 1);
>>> +			break;
>>> +		}
>>> +
>>> +		local_bh_enable();
>>> +		if (unlikely(need_resched()))
>>> +			break;
>>> +		cpu_relax();
>>
>> Don't you need a 'loop_end' condition here?
> 
> As you mentioned in 14/15, it can indeed spin for long and is bound only
> by need_resched(). Do you think it's reasonable to wait for it without a
> time limit with NAPI_STATE_PREFER_BUSY_POLL? softirq should yield napi
> after it exhausts the budget, it should limit it well enough, what do
> you think?
> 
> The only ugly part is that I don't want it to mess with the
> NAPI_F_PREFER_BUSY_POLL in busy_poll_stop()
> 
> busy_poll_stop() {
> 	...
> 	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
> 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
> 		napi->defer_hard_irqs_count = READ_ONCE(napi->dev->napi_defer_hard_irqs);
> 		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
> 		if (napi->defer_hard_irqs_count && timeout) {
> 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
> 			skip_schedule = true;
> 		}
> 	}
> }

Why do you want to avoid such branch? It will do any action only when
the user-space explicitly want to leverage the hrtimer to check for
incoming packets. In such case, I think the kernel should try to respect
the user configuration.

> Is it fine to set PREFER_BUSY_POLL but do the stop call without? E.g.
> 
> set_bit(NAPI_STATE_PREFER_BUSY_POLL, &napi->state);
> ...
> busy_poll_stop(napi, flags=0);

My preference is for using NAPI_STATE_PREFER_BUSY_POLL consistently. It
should ensure a reasonably low latency for napi_execute() and consistent
infra behavior. Unless I'm missing some dangerous side effect ;)

Thanks,

Paolo


