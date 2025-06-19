Return-Path: <netdev+bounces-199378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C816AADFFB2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F7D161E83
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6472C25B69F;
	Thu, 19 Jun 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhVYijrR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE02417E0
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321367; cv=none; b=ikIKv8hXvrFQzH6IEGmFIQ7f1nuI6RQW5/NmwnznRfD2OeVawDfOOr+l3XvH0XajwiQ9o/JLa/vQKJF/IdplW0NpzHbaaXT5NKLgH+LBtYj9cMipKVl4WAACYZrGuvWn/u8ucGBHE8pcm6IgqZTubPNHj0uM5bx0PCd5P7XTq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321367; c=relaxed/simple;
	bh=QQPn5brLXeGgRXdgdwN3CLvotufHT9a51CMFYMcHLBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhCHoNVAxjeko4QP7TSnOaiuAS8IySM6Ps2l2NAGTZZc1HdV9p689Bdo6eFQICgjwUqozRcPaYPr0bNhymKNma1Lf5sxoSPqdmDrmtNw4DajGFpEL6lF2VdqlLzuuv2f6JLdwLidbzjp0FNZXx666iPLt+by4VhLUsClX26B8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhVYijrR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750321364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3u5UrbIFcsT6z27Fr6GpbRCpPwg+7g2ZbmuUBpBpiQY=;
	b=UhVYijrRyd5x9zyqiSZm+fylP7UuSpkso6f568L1YbWgAcemX/y7lmObypyJrbHbofi90l
	5Gc46pWfJ2zjVEOCOrw2Nb0lu6MoZPKdyMcKmtLIeTKzP2jKguOsrail6fpCIK/xaQq9S0
	6U4ctiHUvocFOVr8MpYckSl69v8WlJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-K7eTBhv2O7inK1tlr1yHxA-1; Thu, 19 Jun 2025 04:22:42 -0400
X-MC-Unique: K7eTBhv2O7inK1tlr1yHxA-1
X-Mimecast-MFC-AGG-ID: K7eTBhv2O7inK1tlr1yHxA_1750321361
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso199841f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321361; x=1750926161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3u5UrbIFcsT6z27Fr6GpbRCpPwg+7g2ZbmuUBpBpiQY=;
        b=U4yYlRTaHYlqeDDySdzNb34GDizhXMAAEXp/r++VYFDbMYpmub2t6FZiQaTCG4Rgk5
         OPL2Y/bCgssiZfTUeo08MbPq2CK4pac6x9hUdmnH2fYDYl2da4NtpS2XdWz4+z0MPKFw
         cExJDwu5Q4ZLmGNCjkyDL+XLxTGRR7tkB9obxIiQkoCl9yY5nudrraaTh43RT39Rz+6D
         tzmdtRXcfY1gY4TcWhQf7//b7957Rb1Zt3MknC0vTkIXKuqWzC3frFEWtulWa2ZwPQYr
         GI5k6+htCf1unSggbDJO+NeLwES3/JlJvomtylbyWbTx/63mkprXgi3ojhKeWLnLrSPN
         qqMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7MfZyxKfTIDaey2/Ovn4069ao8r7TCYScStNkE21/lPC7TIIwbgflWKdVS43jualZA3R5FR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYP/mSQDLzUzROJUM1vceS8VuvCAQ4c12wj2vTHDVqfvuaIUYW
	GgYIgkG9OEa9XcLdetQXgsJboYb36imhTH6k2gTYiOhteAD4y39OniswchZ+/ktjduBF+qWkfHq
	BD1tZtv+GwP+8G7FwrV/0lzIdHTfi//x1ykMmoRfHO5VzIyWCnWTdBJTsoA==
X-Gm-Gg: ASbGncuEvse6p/cJRQR/hEU0vzxv9zxpWyik0OGczqbkwxomBHnxRW4BZbkIKsKrEJZ
	D+EenZZ5UIv4I4JxO7Q38wZp7MvI7gJKaWs4nSjIf31AjZ4QMkUHwfVmuHiGxxeIfiRtn7YsZw+
	T9ek7V+ZnUHQzEAx6DpXn0qU/ykQ/97scXyyMmRhGXY6JL50cXzuHqWNq6FARJjYSwWHGqirm/1
	3j6psGokA6KskXQyJlWNZqHuUQ4h1V9JCE1NivfZ1a+wvtTP1WDHuZ8aFB+QYcSwDYbPca+NqIZ
	sAY3zw8a8j6r3M+Ie8EagSldk71BD192/3hO/838hwCVz94aAAQ/VBv2SvvoZilPkxeA6w==
X-Received: by 2002:a05:6000:290c:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a572367b8cmr15459222f8f.12.1750321360974;
        Thu, 19 Jun 2025 01:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsOdd0l9YaAvmzLQkt7CerKsMYQhEqusgDN65H96bS9PmclWT9LmYHKBzNBEHcDUr17wFnYQ==
X-Received: by 2002:a05:6000:290c:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a572367b8cmr15459191f8f.12.1750321360551;
        Thu, 19 Jun 2025 01:22:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7f8f9sm18758020f8f.42.2025.06.19.01.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 01:22:38 -0700 (PDT)
Message-ID: <10fe50a5-2829-40a2-8741-c67c33898fa6@redhat.com>
Date: Thu, 19 Jun 2025 10:22:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] tcp_metrics: set maximum cwnd from the dst entry
To: Petr Tesarik <ptesarik@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250613102012.724405-1-ptesarik@suse.com>
 <20250613102012.724405-2-ptesarik@suse.com>
 <da990565-b8ec-4d34-9739-cf13a2a7d2b3@redhat.com>
 <20250617133935.60f621db@mordecai.tesarici.cz>
 <20250618190124.04b7a2c3@mordecai.tesarici.cz>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250618190124.04b7a2c3@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 7:01 PM, Petr Tesarik wrote:
> On Tue, 17 Jun 2025 13:39:35 +0200 Petr Tesarik <ptesarik@suse.com> wrote:
>> On Tue, 17 Jun 2025 13:00:53 +0200 Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 6/13/25 12:20 PM, Petr Tesarik wrote:  
>>>> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
>>>> index 4251670e328c8..dd8f3457bd72e 100644
>>>> --- a/net/ipv4/tcp_metrics.c
>>>> +++ b/net/ipv4/tcp_metrics.c
>>>> @@ -477,6 +477,9 @@ void tcp_init_metrics(struct sock *sk)
>>>>  	if (!dst)
>>>>  		goto reset;
>>>>  
>>>> +	if (dst_metric_locked(dst, RTAX_CWND))
>>>> +		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
>>>> +
>>>>  	rcu_read_lock();
>>>>  	tm = tcp_get_metrics(sk, dst, false);
>>>>  	if (!tm) {
>>>> @@ -484,9 +487,6 @@ void tcp_init_metrics(struct sock *sk)
>>>>  		goto reset;
>>>>  	}
>>>>  
>>>> -	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
>>>> -		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
>>>> -
>>>>  	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
>>>>  	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
>>>>  	if (val) {    
>>>
>>> It's unclear to me why you drop the tcp_metric_get() here. It looks like
>>> the above will cause a functional regression, with unlocked cached
>>> metrics no longer taking effects?  
>>
>> Unlocked cached TCP_METRIC_CWND has never taken effects. As you can
>> see, tcp_metric_get() was executed only if the metric was locked. 

Uhm... the locking propagation from dst to tcp storage was not so
straight forward to me, I missed it. Please be a little more verbose
about this part in the commit message.

Thanks,

Paolo


