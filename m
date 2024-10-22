Return-Path: <netdev+bounces-137772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3649A9B71
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8736B20D98
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148C146D68;
	Tue, 22 Oct 2024 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUGe7Z1+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD836124
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583341; cv=none; b=V/Du4xAyVPbwssHYAeA5Zx9W75j75OTgQvD81jPZO13m7UlWO+zUoSRCHq+tAG5wdKjWTUv7DpjuPrNYFqVATGKplPI+s81MG0DlF9GqjaayWBsE2gkZmKmC44I7tGDYoSpMjk5b9rCZdLIeWIqLxzEDWGDNRMQSm3h0O7JgK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583341; c=relaxed/simple;
	bh=z0TFOz8qnWQgiFjOHpeyHIhiXC3wimd3qkk292JZeyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYmrAVN1hHIaFooiBrdqb/bQPserY91QhoyqnISwDAPH00K16liLL6DSvXUhCA6wi9ZYOJl0W/LG7WWdhgrysUK7d13m4R2ZrgvaV0D5gpwTFRlGs4K8cUnZt6QwnNszmk+9gmVdyZ2BFDfWCMbjmIZXjEUwpC2OJ+yyXvST2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUGe7Z1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729583338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftccds8EH7SC5Jyy8+I+ZK7tzNnlLXQBxvCZJjQtOYQ=;
	b=CUGe7Z1+6XbLy/V4imE+cNy5rjxWLhsjU+1bqrHOXx5YAq0kPvab+S95tgTCIRtpQQFk3P
	JlAMZTC03m0D/+utN6ulrRztilmSZRYPyQ7DmDWxFAsQAVou15osQFCXW67wMENymqgojc
	56t+oFfo16vbGWnFqdjJRHmJ+bLkIFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-gku4UL90NO-u6UzZrZmRhg-1; Tue, 22 Oct 2024 03:48:56 -0400
X-MC-Unique: gku4UL90NO-u6UzZrZmRhg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157e3521dso38391465e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583335; x=1730188135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftccds8EH7SC5Jyy8+I+ZK7tzNnlLXQBxvCZJjQtOYQ=;
        b=vo181q026aYJ4P0zU6XDzG6OTVtPEY57uQ9faqKAPC6BIlFrdmmsG6vhZj1GmIfS5Z
         ikhD6aoUhFM6AdIXKF+5N3JIMFmfswzpmWFmfiqD13lX8iOdmQY/WIrDSYeOFyxyDEXf
         rtl/xEIzTzNu9+8uXXWBcuu1cxGlgyoHGS7TTxdsI8VOd5EPAHzz7hbxWT0r6qYkUeWk
         uP/XU5Vy+CZ/uHktcWe8w5Of20TV6Ww3iWxwbr2oKebeF0JPYppcg8G6SxG47fXYivaE
         OKwjf5IlIWrF/EmFUZZn0Nc6fEFy3xkpekIoEluU5mAsGYY89glQndyYEWVB7bXmeTfO
         BeFA==
X-Forwarded-Encrypted: i=1; AJvYcCWC5Xg216j51yDC53TUjmKws3yZG6jHJCEQ5V713q3NveXfNxjrGF2eFepv37MhKIQXeP91hJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nwm3/6YDgMfQSnmCXll/tQq1ZoIaPGO+ue85I00hvs4w7wZY
	oW8pYZa5se/afeR/UrJmoKfAGMs4jXOq1x+IAoRVMK+qRT/mHgOlLkWSgObwCcqTDaoZwL7le7I
	wwPS5QTHW7zNgaNuBpAHLVGCWxjA0P1Hx9xsQYkVKWKJ8epJ4oHX36w==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr110087715e9.25.1729583335321;
        Tue, 22 Oct 2024 00:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuqlrJZe3z1cluxDCBu1kG7921j0DmfinfCppBqVQKzt/5Bfu3Vfr+sP95jBZDLtg0j2Ax7w==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr110087415e9.25.1729583334818;
        Tue, 22 Oct 2024 00:48:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fbe8sm79095755e9.18.2024.10.22.00.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:48:54 -0700 (PDT)
Message-ID: <6c1e7d85-cfd3-4525-9f0b-5a88c3538286@redhat.com>
Date: Tue, 22 Oct 2024 09:48:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] io_uring/zcrx: add copy fallback
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-15-dw@davidwei.uk>
 <4f61bdef-69d0-46df-abd7-581a62142986@redhat.com>
 <32ca8ddf-2116-43b9-b434-d8393cdbdde1@davidwei.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <32ca8ddf-2116-43b9-b434-d8393cdbdde1@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 20:31, David Wei wrote:
> On 2024-10-21 07:40, Paolo Abeni wrote:
>> On 10/16/24 20:52, David Wei wrote:
>>> @@ -540,6 +562,34 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
>>>  	.scrub			= io_pp_zc_scrub,
>>>  };
>>>  
>>> +static void io_napi_refill(void *data)
>>> +{
>>> +	struct io_zc_refill_data *rd = data;
>>> +	struct io_zcrx_ifq *ifq = rd->ifq;
>>> +	netmem_ref netmem;
>>> +
>>> +	if (WARN_ON_ONCE(!ifq->pp))
>>> +		return;
>>> +
>>> +	netmem = page_pool_alloc_netmem(ifq->pp, GFP_ATOMIC | __GFP_NOWARN);
>>> +	if (!netmem)
>>> +		return;
>>> +	if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
>>> +		return;
>>> +
>>> +	rd->niov = netmem_to_net_iov(netmem);
>>> +}
>>> +
>>> +static struct net_iov *io_zc_get_buf_task_safe(struct io_zcrx_ifq *ifq)
>>> +{
>>> +	struct io_zc_refill_data rd = {
>>> +		.ifq = ifq,
>>> +	};
>>> +
>>> +	napi_execute(ifq->napi_id, io_napi_refill, &rd);
>>
>> Under UDP flood the above has unbounded/unlimited execution time, unless
>> you set NAPI_STATE_PREFER_BUSY_POLL. Is the allocation schema here
>> somehow preventing such unlimited wait?
> 
> Hi Paolo. Do you mean that under UDP flood, napi_execute() will have
> unbounded execution time because napi_state_start_busy_polling() and
> need_resched() will always return false? My understanding is that
> need_resched() will eventually kick the caller task out of
> napi_execute().

Sorry for the short reply. Let's try to consolidate this discussion on
patch 8, which is strictly related had has the relevant code more handy.

Thanks,

Paolo


