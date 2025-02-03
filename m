Return-Path: <netdev+bounces-162021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464C5A25598
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4242B1884386
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0491FAC3D;
	Mon,  3 Feb 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT79c94W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E245016
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574258; cv=none; b=CyQbn5pkoUcRMNH+3PJDq0iL8LaWFEAoDNsmNndpf1DVcvsC4D3we7KA1hDjgujhLN/hlFqYj5mTcnkM5zIMzBe3odSNF7msBmG3bGoO0IHJTg9IbXZAzQ9beOOPRjDZGmoi8VbAtwR/PvgNsoCTIjVWwzQHpjmR05s/4sxdYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574258; c=relaxed/simple;
	bh=Q6WM9dyhofkBoVa+ZjYVee5tNttAayB023b0b7nSrT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsTONDsCdNnjXrbXky+dgkBlQtNxT3RlSfa9Gq79LEOQgbtNDaGT2BpoRv5YHqZmOgb38aN/wFRQMO8K7c9xvXLLJNo9EQj/t07/aZ937m1znlSO7qkiqsETrLf0kd87g4gdFihRprTZ1gQh9zxmULbAVFKfuPOqg+g4qf1agbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT79c94W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738574255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnppZd8pEry01iPJLVf/WOGk/OLH3G7jVAumR8PxtIg=;
	b=XT79c94Wa3QSjz+QlKjEPOw39nmqYVA6xq4Z+j5cJrNZ8VWLf3dR7t2lSkT7/QzJ2yuR0J
	s0dDC/n+CSzDCQQBCeApU0dQIOJWYHDONAGvYmyY2tAzl//JGTWo7a6Ndnmsbvr522yFP/
	MNgMzZTauVYPHDK9DT1LHG3hgQKK5Vg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-fxW_2kbRNiW7QHFqhBcf5w-1; Mon, 03 Feb 2025 04:17:33 -0500
X-MC-Unique: fxW_2kbRNiW7QHFqhBcf5w-1
X-Mimecast-MFC-AGG-ID: fxW_2kbRNiW7QHFqhBcf5w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so2702665f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 01:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738574252; x=1739179052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnppZd8pEry01iPJLVf/WOGk/OLH3G7jVAumR8PxtIg=;
        b=ulCxcpX9ddb5K9+hlnsSiC86PoHHByET8vkHjWqKg5wzm3sp65XQfc0kOZ4vDU24JA
         XNSrLrpAcWrhhX21wi4IyKzqAziEFSvuyGa+0Ow0S1h3unFYJP5vWYSToK6UjclmbPr3
         UZp+KKptcQPldLC3lISSOZ+TgEFu8tSVLZDjjggdPt6SxC0+kFgY9GFhQYnPjYtbL4ZU
         A5g7/CLyg3yG1vrH6hi3ks/zW21whr3EhZOLxy+RkBCozn8PRLk7VJqQwJ8Xo4GwZcRF
         z3zmt4WR54isjlzFR0RNHLio+qxHT0IK2b0sf1GPYSKiiUwZX0YFckQFISGfoVn2S/da
         ZDPA==
X-Gm-Message-State: AOJu0Yzd2CgoL7ZIl5zh7WuVRIkyvtDqC2yvlSE5eUG9JABQnmvP0kBm
	puJV1IZwiwxRkAkUdfai0Cz9FkMZUsDYERMuAL9bTK3wvwFCVzqXWyuzQl2/GnazYXILhNEUzU1
	meCrvOgVFW4pqIu5tVSmaO7hUHTEe6caVWpZDn0GiCsAVM1XgRca4137ib4nN2Q==
X-Gm-Gg: ASbGncv3gAcfyUtuIMwrcXHDmp9+l6KnT1Rpcz04UYfqiTdQ9C8fsVOeacaK77nATOU
	EcOF78Hi9L0/wK8wN87KDg60ZM8hjpEnkJWHVnQddmNpL4jsvPR3SlrwvNDthGg9zyp/+vAIqKN
	w2kQP0mK/adi5yDUlUHo9YgQGNe9qgR4dvL2kDfECBzj4gg8bkmNkdhZRGXnoELE9pfRvSWG3x8
	vwvYbLhDAWorjFCwGhwDw9j9VESgH+grjBb+ZTebN/xiJkRjvk9mh4kjMT+TVWNNN1Pi6ULq5R+
	gARjh59YpXx34QSPGh8bA5geKP6PAN1eaXU=
X-Received: by 2002:a05:6000:1542:b0:38c:5c1d:2844 with SMTP id ffacd0b85a97d-38c5c1d2b13mr12572884f8f.11.1738574252136;
        Mon, 03 Feb 2025 01:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcP88HgORUEV50MLq3mIWN0m8jZzQLOc/3KyPwvpXbsZchfwxjoaT9QN00mFvakAuvkNnNdw==
X-Received: by 2002:a05:6000:1542:b0:38c:5c1d:2844 with SMTP id ffacd0b85a97d-38c5c1d2b13mr12572859f8f.11.1738574251749;
        Mon, 03 Feb 2025 01:17:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec35asm12397314f8f.15.2025.02.03.01.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 01:17:31 -0800 (PST)
Message-ID: <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com>
Date: Mon, 3 Feb 2025 10:17:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
 <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
 <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/31/25 11:35 PM, John Ousterhout wrote:
> On Thu, Jan 30, 2025 at 1:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 1/30/25 1:48 AM, John Ousterhout wrote:
>>> On Mon, Jan 27, 2025 at 2:19 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> On 1/15/25 7:59 PM, John Ousterhout wrote:
>>>>> +     /* Each iteration through the following loop processes one
>> packet. */
>>>>> +     for (; skb; skb = next) {
>>>>> +             h = (struct homa_data_hdr *)skb->data;
>>>>> +             next = skb->next;
>>>>> +
>>>>> +             /* Relinquish the RPC lock temporarily if it's needed
>>>>> +              * elsewhere.
>>>>> +              */
>>>>> +             if (rpc) {
>>>>> +                     int flags = atomic_read(&rpc->flags);
>>>>> +
>>>>> +                     if (flags & APP_NEEDS_LOCK) {
>>>>> +                             homa_rpc_unlock(rpc);
>>>>> +                             homa_spin(200);
>>>>
>>>> Why spinning on the current CPU here? This is completely unexpected, and
>>>> usually tolerated only to deal with H/W imposed delay while programming
>>>> some device registers.
>>>
>>> This is done to pass the RPC lock off to another thread (the
>>> application); the spin is there to allow the other thread to acquire
>>> the lock before this thread tries to acquire it again (almost
>>> immediately). There's no performance impact from the spin because this
>>> thread is going to turn around and try to acquire the RPC lock again
>>> (at which point it will spin until the other thread releases the
>>> lock). Thus it's either spin here or spin there. I've added a comment
>>> to explain this.
>>
>> What if another process is spinning on the RPC lock without setting
>> APP_NEEDS_LOCK? AFAICS incoming packets targeting the same RPC could
>> land on different RX queues.
>>
> 
> If that happens then it could grab the lock instead of the desired
> application, which would defeat the performance optimization and delay the
> application a bit. This would be no worse than if the APP_NEEDS_LOCK
> mechanism were not present.

Then I suggest using plain unlock/lock() with no additional spinning in
between.

/P


