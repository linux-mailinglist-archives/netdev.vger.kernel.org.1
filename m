Return-Path: <netdev+bounces-140745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546119B7CC7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E521C20845
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14919C579;
	Thu, 31 Oct 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFGoVvpO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40F42AA5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384683; cv=none; b=a5Ne+dyIX4pZUXKdUdWwBKghO2/Locak2RulWls2U6xNoGIJUpRtQquq75yUq7Tg95jfnGWUDXu3VSfrGZvqBEmx3tSREhuiwjLNMLKJ3KZSJXgOFCHnDKPIVTiaLtI4IuevDfsxk0SSkCMjwVLd9nt+s4P/w5icCswTY1J7X4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384683; c=relaxed/simple;
	bh=xEM3T0XMPcr6Wk0WoiMzFaKu/bdmgV9OabL+SMlKpN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITsXxRyBQtaA7f4hAGapd4ixr8mIiIl+9ZG1PnhJ6vjfZvOXfGgkVoejfEh0dfV1cmwMnaxqW72RjdRHwIcDNIqjnv3lsKdgdQgYYs5u1azVZyUgxKIWJSF52ysNMb9bcIQ//NqT3vftMaB76S0F0i7tBhyr7BdDszn939vole8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFGoVvpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730384680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGWTvM74hqsKAzfTKg2C8mTAqfIeqWkNrbq4VJgs8Bc=;
	b=WFGoVvpOfhIFKi2a+FAiXYuS4vUH3W3MuFuvFb+O5CzQ/tYwhK4tUxkJlEbPm/aQTCaMKS
	rlQwpg2Y84XTNIqk+pYUGO2kglOKjjD2e07BlfO2C4R0wADwVNxQTvAa1aGNjoQGE083QA
	Ehmn5zR9fsVsoSsw2a8B4xqVH6HzOBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-5QcY95tfMNKfOwIZT7HXfQ-1; Thu, 31 Oct 2024 10:23:39 -0400
X-MC-Unique: 5QcY95tfMNKfOwIZT7HXfQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43159c07193so8395365e9.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384617; x=1730989417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGWTvM74hqsKAzfTKg2C8mTAqfIeqWkNrbq4VJgs8Bc=;
        b=h98fZpl6wLV187xGovt8dZjvPW14+YwbFQZyVdzjSQdYyz3dgml5o/25HKOCzqwSmZ
         HfjQ+gYPa2tBxQLcL5cr2tOe91zaKqIJ6APxtH+pBU0QnQGrqsanSERFBng+hkclXn9/
         YP7iu0AJPjvPWha9LloW8MQbrk5wBLO7PxI5lX3ZXWf4qaCGbI2fKDS3l6o7oXDkUwOT
         3q0LhsBdlaX3kogrIc6B2s7NjBQ6EL+e09j7k8IuZFSLcdPLjLsKZKDqNQ/KgjtLeBml
         HBIXdYDWUvLvyntvu0/+HIX/IgmXXoMuCme6SIkw5F+0PEglC1jIkV9qtWUCMBnyO8fQ
         0Dog==
X-Forwarded-Encrypted: i=1; AJvYcCW8dPGHj566olQtqIhaxCaajPXHNUG2LGm6VZeS+tKnNImUyzh7LrovYnWZulnQ7JNI5b6dGB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywef4/lHpKWLbCz4ACBZmM4XJTrXS9fCoywCQ4Z3D9xkILxaxel
	eG59ezaou/EQDi0z92DiSNvhIzvqqbcSlJskxP4Z2ZX18A7w1VmEBzQIMgymmhhSKINGhzECJL9
	6i+Vebsn3RTam+5Iz+xpvZPswt5yhLTXnC4sCLvo6fMt7It4ulkXF2A==
X-Received: by 2002:a05:600c:354f:b0:431:518a:6826 with SMTP id 5b1f17b1804b1-43283255a71mr386875e9.19.1730384617568;
        Thu, 31 Oct 2024 07:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf0IEeCl05c6HKBEvXKUoXNq+nVbIYE6QV7CJKxvAMhlhjASwpS8nOAvuk660vnJkAdFWVqA==
X-Received: by 2002:a05:600c:354f:b0:431:518a:6826 with SMTP id 5b1f17b1804b1-43283255a71mr386675e9.19.1730384617203;
        Thu, 31 Oct 2024 07:23:37 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd917f0bsm56486545e9.17.2024.10.31.07.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:23:36 -0700 (PDT)
Message-ID: <6162222b-0a2e-4fb7-b605-c57fa8420bc9@redhat.com>
Date: Thu, 31 Oct 2024 15:23:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for
 tcp_drop_reason()
To: Yafang Shao <laoar.shao@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 dsahern@kernel.org, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
References: <20241024093742.87681-1-laoar.shao@gmail.com>
 <20241024093742.87681-3-laoar.shao@gmail.com>
 <a4797bfc-73c3-44ca-bda2-8ad232d63d7e@app.fastmail.com>
 <CALOAHbDgfcc9XPmsw=2KkBQs4EUOQHH4dFVC=zGMfxfFDAEa-Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALOAHbDgfcc9XPmsw=2KkBQs4EUOQHH4dFVC=zGMfxfFDAEa-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/25/24 07:58, Yafang Shao wrote:
> On Fri, Oct 25, 2024 at 4:57 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
>> On Thu, Oct 24, 2024, at 2:37 AM, Yafang Shao wrote:
>>> We previously hooked the tcp_drop_reason() function using BPF to monitor
>>> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
>>> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
>>> To address this, it would be beneficial to make noinline explicitly for
>>> tracing.
>>
>> It looks like kfree_skb() tracepoint has rx_sk field now. Added in
>> c53795d48ee8 ("net: add rx_sk to trace_kfree_skb").
> 
> This commit is helpful. Thank you for providing the information. I
> plan to backport it to our local kernel.
> 
>>
>> Between sk and skb, is there enough information to monitor TCP drops?
>> Or do you need something particular about tcp_drop_reason()?
> 
> There's nothing else specific to mention. The @rx_sk introduced in the
> commit you referred to will be beneficial to us.

The implications of the above statement are not clear to me. Do you mean
this patchset is not needed anymore?

Thanks!

Paolo


