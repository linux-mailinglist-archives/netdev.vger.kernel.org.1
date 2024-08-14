Return-Path: <netdev+bounces-118499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DA951CD4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73DE281F54
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894B1B1417;
	Wed, 14 Aug 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdBsTkPn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99C1DA23
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644984; cv=none; b=JPKPHP/vgbRYic4lPIeoEutwbx8ZZkhxfxlaYT9pK4AVAs0uFswWCq+3dmUiOY5xBJLmhqL1PoAZ+2khYXK2C54vLLd0JwKQ65Xx39aXIQg2BPXKVKjHKqHgBemitY9j97Lgytg/SIBoU/tlrn+r8wLlVjZweijFLF6WhGavc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644984; c=relaxed/simple;
	bh=ScIr/2jDgWXa0DQ2s0TFcTPt9sv57rnd1zJFP71OkZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHzvmHw7xpidiwg7UbFbRVDu1EhXZGGrQ/4r64B0JQpwOebvwZ+eIyMj+hx5AaTVPoLckj2M1seKJqur6/Q5bYvqmCohYkpmyRQ4Y/vQJR+kTTbn8cLSGVv7EYEXp96fuGJ2CnRMD29/Ehhbvl0XlTrk4mk68/jTRwmnFp+RhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdBsTkPn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723644981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGMoGxQdkdv0prG5S6t9aPLLDTF/vw4agGHv1qqrUb4=;
	b=XdBsTkPnAqoPTrksJ4awT9ynMNUpa4Lk5G/yXsjUs/oZV05HEE4UgpXhYDqVsY2OWyuVAd
	Bn+QlUmFhP09H4rODxwaEeTmBQH1+EvkniXJ7Dic3uE/20RqeBQk98w6UYs4ngsavUgWxC
	R3eoI4Bbv+Ihr0RIJT1tbVyN7yR4W+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-8MEgXJRMO2m6wN7F6D9vKQ-1; Wed, 14 Aug 2024 10:16:20 -0400
X-MC-Unique: 8MEgXJRMO2m6wN7F6D9vKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4267378f538so12504805e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644979; x=1724249779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGMoGxQdkdv0prG5S6t9aPLLDTF/vw4agGHv1qqrUb4=;
        b=siKkRVAWZLovvBo441IXpnyPkIThSCrZNQpgj8uRqOc9nkqnfqpGwnk+ww1lcAwkar
         QmuPpmuTCIweA6VKBI656DuPWl3P6fzpX0Q8bcsEWL/qg8uK6bTph7gMlxPPhtJFEzPK
         Q9sOGCv4S7HrYXTFs984jH2i8XlwQp0UNuT1hGHRZs76ui9J4f62azQro+5RlPshZooJ
         20RL8wiWqqgUIK5Y/OckH6TjxoAqCc7KbJP5Gy08iUQIOJoAeDQ9hOP9MvgSr8QSWdxO
         LXYKn8OTB0onSLSJ1uJ1asInG/zUrXf2XolXw25fS/WeXNb6yyxEKhaSkUiwP6DcFGJV
         HCQg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ozNGZ0dOcnmzwMr+oS2cfGRIGzNsDIJhyzolmzigTioxmqfYmnzPwr0xRRAhWCupUwP/KCZxsJWL38EwZ4o7kD1nqyCn
X-Gm-Message-State: AOJu0YzsoXn5c6rPvw8nxU4rB80ID/1hwFWK15QTGmpqXyq63mLRkp+5
	fSBeFH7l+eQWmVTRqit4QaiTo2/ZukIYzuAamXG5GCWFup3d1xqGq4HnUOrLHTASOA0Bw1KZrRd
	GM7mM0WtbcXHf8w1lcjEU3iHA0eUMkunoS4ki7fEyosq412Z/ideMOg==
X-Received: by 2002:a05:600c:3b03:b0:428:f1b4:3466 with SMTP id 5b1f17b1804b1-429dd268b83mr12347315e9.3.1723644978644;
        Wed, 14 Aug 2024 07:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUxplpwF7JovS8GivbXp0vgwEGPTWsrg1SjPC0jn6pOCDi3sZfdQjrMR3uWhXHR6BjUQA6vw==
X-Received: by 2002:a05:600c:3b03:b0:428:f1b4:3466 with SMTP id 5b1f17b1804b1-429dd268b83mr12347095e9.3.1723644978062;
        Wed, 14 Aug 2024 07:16:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010::f71? ([2a0d:3344:1711:4010::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3d4efsm20978385e9.28.2024.08.14.07.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:16:17 -0700 (PDT)
Message-ID: <4d226a9e-8231-4794-a5ac-d426fac03361@redhat.com>
Date: Wed, 14 Aug 2024 16:16:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next v2 1/2] net: refactor common skb header copy
 code for re-use
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Florian Westphal <fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>,
 Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>,
 Christian Hopps <chopps@labn.net>
References: <20240809083500.2822656-1-chopps@chopps.org>
 <20240809083500.2822656-2-chopps@chopps.org>
 <567fc2d7-63bf-4953-a4c0-e4aedfe6e917@redhat.com>
 <ZryJK8W1Acz0L/tU@gauss3.secunet.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZryJK8W1Acz0L/tU@gauss3.secunet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 12:38, Steffen Klassert wrote:
> On Wed, Aug 14, 2024 at 11:46:56AM +0200, Paolo Abeni wrote:
>> On 8/9/24 10:34, Christian Hopps wrote:
>>> From: Christian Hopps <chopps@labn.net>
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -1515,7 +1515,7 @@ EXPORT_SYMBOL(napi_consume_skb);
>>>    	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
>>>    		     offsetof(struct sk_buff, headers.field));	\
>>> -static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>> +void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>    {
>>>    	new->tstamp		= old->tstamp;
>>>    	/* We do not copy old->sk */
>>> @@ -1524,6 +1524,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>>    	skb_dst_copy(new, old);
>>>    	__skb_ext_copy(new, old);
>>>    	__nf_copy(new, old, false);
>>> +}
>>> +EXPORT_SYMBOL_GPL(___copy_skb_header);
>>> +
>>> +static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>> +{
>>> +	___copy_skb_header(new, old); >
>>>    	/* Note : this field could be in the headers group.
>>>    	 * It is not yet because we do not want to have a 16 bit hole
>>
>> Could you please point where/how are you going to use this helper? factoring
>> out this very core bits of skbuff copy looks quite bug prone - and exporting
>> the helper could introduce additional unneeded function calls in the core
>> code.
> 
> It is supposed to be used in the IPTFS pachset:
> 
> https://lore.kernel.org/netdev/20240807211331.1081038-12-chopps@chopps.org/
> 
> It was open coded before, but there were some concerns that
> IPTFS won't get updated if __copy_skb_header changes.

The code is copying a subset of the skb header from a 'template' skb to 
a newly allocated skbuff.
It's unclear to me why would be useful to copy only a subset of the skb 
header, excluding queue_mapping, priority, etc..
I think we need a good justification for that, otherwise we could end-up 
with a large amount of "almost copy" skb header slicing the skb in many 
different ways.

Cheers,

Paolo


