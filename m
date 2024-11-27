Return-Path: <netdev+bounces-147595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666399DA776
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2649C281167
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B51FBC89;
	Wed, 27 Nov 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFbS8Dqc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9681E0DCD
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709472; cv=none; b=nto5ZPevuiWFxjG+ysupL2aFh4BVSdxB/7bHPe40LOWTyMHm98cTjV7POOUr5AjUWijTYOQDWZrC9cRmYNL3Pe4NDDcn/aNMJbRgTEu7ak3qXkAhUCZfCkH7nHR61rUQL/nvdFSCMWIKORU1PQf2SxdXle9fNjj+9ABOv0SR5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709472; c=relaxed/simple;
	bh=F5eOtfppEc+IoodKU/rNNKsKD6NOPU6CRFuchJeSG84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blp/gDXUlh81JtDGz5DPi6pDX1i1zEIr5cetlZ8mz1279b/O16RVaVgvQQiDzg4NOJXyzjqcRQaVuEi6HuAHv6wLNvkF3T+A6qkmolXoS7p90kvvQfJ4dfIxw3RVw/0uBqUNE6XfIM6n/6GUqioMBzOGduLQ1jkho3nYjEwr4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFbS8Dqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732709470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6JOBTkXOEhLaQ1n7b3llX+BM31La79H/YhyA4I23K8=;
	b=MFbS8DqcBkdaRmuP7VUQOHZEjp7pBcv1tBD8yiQYTowJ+g2kfiyjMVU+8yMi1OP9HI0PYK
	qTOVdwqbljxAHjAo7nuzHnHR7zKqUUVGCU6oUOlzS+TY2BKBgOKOlZ1oCMtL7VUrB05EH+
	ET9sQFLs73WCRKnDsXN84BqJ2rDXgNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-vvZZ6N_yMoi2CyVFoeH9MA-1; Wed, 27 Nov 2024 07:11:08 -0500
X-MC-Unique: vvZZ6N_yMoi2CyVFoeH9MA-1
X-Mimecast-MFC-AGG-ID: vvZZ6N_yMoi2CyVFoeH9MA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a104896cso22427755e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 04:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709468; x=1733314268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6JOBTkXOEhLaQ1n7b3llX+BM31La79H/YhyA4I23K8=;
        b=kYhw2Z81UsOkRFoB6XAMEGjtmdFrbGOiwJCAAdsdvmzvVqUayACYip5zT4CFcPLT4S
         PEdbR0tfpfGc87qlyr3eZWt+Z8ovCg2vsKvQR7Kk4Db7ydUPDEnRZblEEXin1IUYiY48
         bOL9GK6Jjd3Bji8O2GPYwJQhyzJXrMtyKIgMX1JdliK6+mmRTCV5SaKd4dCFg4I5Enzi
         vNkSKT0P/2lLPmFjlhLgpJVd6IOUOk1R5OwZIZWM9yIf/IUCZ9FOMXjHwp9WmA7N6Luc
         uFT6QVaDieMQp+CXXQCAur66Mr9l8gnAJPEWgJwbfQBP1nM8yUqDE2S2QMB/dtsb6ubA
         OrSA==
X-Gm-Message-State: AOJu0Yx9gQeWmP4IS3+4S7b/vnjH/o3tpUT9Ox+fT9mVgdHwUmdEcgEO
	l2DmNqnDOx+J3wghfve5e7zzvZufVLvPMIkhU+x7Br0If70rE2zhst5VzWaUF4v1zle2T8VTn8E
	4DvM7R0tDC7lghPPEsu+qqPq9kZN42A0UVxjy8wron9cSUwWA0iDC2g==
X-Gm-Gg: ASbGncuXFeNo6xxGUhle8RbDFcG9dqZBXAU0crUDh36EF0e0xGJ32vw3fi3V/k1OcFE
	XUXqntaImgOgDFfmhaNiY4z3kEN7O2PM5BYqozoYs24blCEV0CZ6E3MFzD3g9gKkbDfbu93FQjC
	I40pxCTzJmozf5UuQYJ05To7J4l8T7Fu+xi3MqqRIRe82HED5l3mTCh76Gra9xKmLl92JtiArft
	a/lTfLmYGLLaLExSxRo4GOKckOZx6DjbpOfrbPI7dFnsfopQMMXF6CqHe9flkqRgP1TY2mN4cZu
X-Received: by 2002:a05:600c:19cc:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-434a9dbaee2mr22037055e9.1.1732709467639;
        Wed, 27 Nov 2024 04:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5S7X4BAK6Tw9UTBAoY3UvWdn/j85UYNxieDiSkT4Elsqw0mXyIcfPgWHb8aQubHgLtUvoWQ==
X-Received: by 2002:a05:600c:19cc:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-434a9dbaee2mr22036925e9.1.1732709467289;
        Wed, 27 Nov 2024 04:11:07 -0800 (PST)
Received: from [192.168.88.24] (146-241-60-32.dyn.eolo.it. [146.241.60.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385c89fe5dbsm1187093f8f.102.2024.11.27.04.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 04:11:06 -0800 (PST)
Message-ID: <7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
Date: Wed, 27 Nov 2024 13:11:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
To: Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
 <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
 <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 11:49, Parthiban.Veerasooran@microchip.com wrote:
> On 26/11/24 4:11 pm, Paolo Abeni wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 11/22/24 11:21, Parthiban Veerasooran wrote:
>>> There are two skb pointers to manage tx skb's enqueued from n/w stack.
>>> waiting_tx_skb pointer points to the tx skb which needs to be processed
>>> and ongoing_tx_skb pointer points to the tx skb which is being processed.
>>>
>>> SPI thread prepares the tx data chunks from the tx skb pointed by the
>>> ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
>>> processed, the tx skb pointed by the waiting_tx_skb is assigned to
>>> ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
>>> Whenever there is a new tx skb from n/w stack, it will be assigned to
>>> waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
>>> handled in two different threads.
>>>
>>> Consider a scenario where the SPI thread processed an ongoing_tx_skb and
>>> it moves next tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer
>>> without doing any NULL check. At this time, if the waiting_tx_skb pointer
>>> is NULL then ongoing_tx_skb pointer is also assigned with NULL. After
>>> that, if a new tx skb is assigned to waiting_tx_skb pointer by the n/w
>>> stack and there is a chance to overwrite the tx skb pointer with NULL in
>>> the SPI thread. Finally one of the tx skb will be left as unhandled,
>>> resulting packet missing and memory leak.
>>> To overcome the above issue, protect the moving of tx skb reference from
>>> waiting_tx_skb pointer to ongoing_tx_skb pointer so that the other thread
>>> can't access the waiting_tx_skb pointer until the current thread completes
>>> moving the tx skb reference safely.
>>
>> A mutex looks overkill. Why don't you use a spinlock? why locking only
>> one side (the writer) would be enough?
> Ah my bad, missed to protect tc6->waiting_tx_skb = skb. So that it will 
> become like below,
> 
> mutex_lock(&tc6->tx_skb_lock);
> tc6->waiting_tx_skb = skb;
> mutex_unlock(&tc6->tx_skb_lock);
> 
> As both are not called from atomic context and they are allowed to 
> sleep, I used mutex rather than spinlock.
>>
>> Could you please report the exact sequence of events in a time diagram
>> leading to the bug, something alike the following?
>>
>> CPU0                                    CPU1
>> oa_tc6_start_xmit
>>   ...
>>                                          oa_tc6_spi_thread_handler
>>                                           ...
> Good case:
> ----------
> Consider waiting_tx_skb is NULL.
> 
> Thread1 (oa_tc6_start_xmit)	Thread2 (oa_tc6_spi_thread_handler)
> ---------------------------	-----------------------------------
> - if waiting_tx_skb is NULL
> - waiting_tx_skb = skb
> 				- if ongoing_tx_skb is NULL
> 				- ongoing_tx_skb = waiting_tx_skb
> 				- waiting_tx_skb = NULL
> 				...
> 				- ongoing_tx_skb = NULL
> - if waiting_tx_skb is NULL
> - waiting_tx_skb = skb
> 				- if ongoing_tx_skb is NULL
> 				- ongoing_tx_skb = waiting_tx_skb
> 				- waiting_tx_skb = NULL
> 				...
> 				- ongoing_tx_skb = NULL
> ....
> 
> Bad case:
> ---------
> Consider waiting_tx_skb is NULL.
> 
> Thread1 (oa_tc6_start_xmit)	Thread2 (oa_tc6_spi_thread_handler)
> ---------------------------	-----------------------------------
> - if waiting_tx_skb is NULL
> - waiting_tx_skb = skb
> 				- if ongoing_tx_skb is NULL

AFAICS, if 'waiting_tx_skb == NULL and Thread2 is in
oa_tc6_spi_thread_handler()/oa_tc6_prepare_spi_tx_buf_for_tx_skbs()
then ongoing_tx_skb can not be NULL, due to the previous check in:

https://elixir.bootlin.com/linux/v6.12/source/drivers/net/ethernet/oa_tc6.c#L1064

This looks like a single reader/single write scenarios that does not
need any lock to ensure consistency.

Do you observe any memory leak in real life scenarios?

BTW it looks like both oa_tc6_start_xmit and oa_tc6_spi_thread_handler
are possibly lacking memory barriers to avoid missing wake-ups.

Cheers,

Paolo


