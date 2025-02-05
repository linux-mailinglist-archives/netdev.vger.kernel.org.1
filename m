Return-Path: <netdev+bounces-163219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A1A299AB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BEF3A7B01
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87C1FCFDA;
	Wed,  5 Feb 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwYeZ5po"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8509944F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782242; cv=none; b=V+eGsu6uBSbZYBh2TAAnu8MUTPGFmN9xB0AEFql1Az0V3K2vLoF3hV5VhiapjjMnlA8DGuL6FmJN0jG1tdQ+/CdbuogTi3MlKuxAwoQF4yCasWVPNAgHbG4261cTYgzIZ9T0ogJACqDc0iTOgREo9ZDZJxHQuNaPRrc7kXb9ql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782242; c=relaxed/simple;
	bh=tHqW9k0HN16gSK1mBbfJ6bSvAd2A3JDgncQsbOQFJDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3V8D4oFAAou0bH5WLHCY4awHqo2wTLdRoLaw7I4VVWQFj747OQsb1AHEe6rVK2FFZDSv/8a7i7Ag8xYVmTSCT7XpFHF01cay3fweXN8kx7CUKlfKU94+f7x1de98nNyW0iGBXSYYJbV8Snh2AU2KZws1zzvAuc0WJj2ZC0os4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwYeZ5po; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso1239525e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738782239; x=1739387039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvhhUh7Ci18MKX6LrPQGedGn/obrrdH0PLQeGUPiTL4=;
        b=VwYeZ5pokymaF0jOUR7xarUlTMpHDakfDVgWAT9lLaqMn57fp0zLRm+D6kO+TxR30A
         ZGfJBl7TKmoclGegnjNlEj6KY2Xjul6L4787/Z6qpZgK8gyLzHJ+MK+7Fi+3umr2ROkD
         aCnY5h/D4wF2rBXhrrM7onYz1QoVla1TPn4Feq5eO9IDZRGxcMEgDX9Ew+1MxzyTcJIq
         Fi2MLxxCZtghLxrDFf+CpCjtgw9lsjnoCNzL1Ug8cE2Rt6PmRANr8PadsquNHwT98jhu
         h3qsS+dk4cxYOkMl0Tol+0C2A+lpLVQ2MsBrEghI8UUQZVCEyHA8Pq5o5TFhua476iOt
         Aqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782239; x=1739387039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvhhUh7Ci18MKX6LrPQGedGn/obrrdH0PLQeGUPiTL4=;
        b=X4aky2tDF0btVSI3JIZnEojX3y9LcK4ZHIDj9d67XjNTrVBPukCLLSNFE6FZQlkqo3
         nS/4WVHhc6DB+CxLisR1aq1IVEqPJjRpaeLNZU5Iz8Np0GH/SjjWF6cZcFC2Ys0nHjqy
         Oyke7of8XFyCt1V6ZBe3mHH9Zl2DScVejXmKOKzeAxp+ktJjw7p2Ut1COu+cxeEIU1zj
         7Y2yBYxO5hEpg8n9J7mJMjjRcs7qShaOpMHnQHKMIcEqstyAzbYNCqNB/pbesUHcgnc7
         /dozw6ZX92gnOyreKAcuTwEtHI7PVyjWeNWXaaVV9GP8Et0c4lIjIlf76zSVUFORr7i7
         yyyA==
X-Forwarded-Encrypted: i=1; AJvYcCVoxg8vueSY/LnJ8hSQiC5Qdi30rTDEaxmNcW+manSSaa9/HjAKNHLP8zrzC/Mtx3vgPUS8eJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxtLw/MYIg1guPwy68EzsF0SuceeMOeG4v9bPwZj6GKKKl+0J
	V2kUbG8VDdbKohSzDU3KUInvUaN2uLY4c1QOYXBvezIXJwgquFc+
X-Gm-Gg: ASbGncseMlF4VwmI9oDy47sgFhdU5C6S2r0tstGg00Z+op2WqT+6xeETpHFABW4ybky
	iHvHlh3Anq8zDKTxbCXaoz3DwoLOxnMlDSqt6QqKWnVH8BIPOHPMyhXRD+NGHS3AX3k7nkZJNgV
	Q0EUD7OmbJ5z+fhbomRTbJ/fUbKokLXSlVZuuMn/jBy7nFjfwjkAGM0lVnDczOuIA/Db9uKKeWa
	ossWjNn0r8jQ7RKschaAY2UQQ6z1/fcJ4aI7rnGMSYlqyYFcW+bgaHiQSCKbm6zB7UaVNZOlkjY
	/GUq3E053Vw6WpuKrbOnTKc=
X-Google-Smtp-Source: AGHT+IG4G0GQJlkEfsMIsRg4jfgycE+6J8dZbSAf6zR+hOF//SQoau3kNS+YfWPtbNei4GkAh5nbFQ==
X-Received: by 2002:a05:600c:1f83:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-4390d55fda2mr28684875e9.19.1738782238640;
        Wed, 05 Feb 2025 11:03:58 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dab853236sm5664979f8f.54.2025.02.05.11.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 11:03:57 -0800 (PST)
Message-ID: <7cdf38e2-640d-4399-974f-fb27183ebe47@gmail.com>
Date: Wed, 5 Feb 2025 19:04:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
To: David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250204215622.695511-1-dw@davidwei.uk>
 <aa3f85be-a7d9-4f41-9fe3-d7d711697079@kernel.org>
 <da6b478a-065a-4f02-acd2-03c6d6dea9fa@davidwei.uk>
 <807a8915-6c3b-495b-8b6b-529e696dff00@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <807a8915-6c3b-495b-8b6b-529e696dff00@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 18:43, David Ahern wrote:
> On 2/5/25 11:00 AM, David Wei wrote:
>> On 2025-02-05 09:44, David Ahern wrote:
>>> On 2/4/25 2:56 PM, David Wei wrote:
>>>> We share netdev core infra with devmem TCP. The main difference is that
>>>> io_uring is used for the uAPI and the lifetime of all objects are bound
>>>> to an io_uring instance. Data is 'read' using a new io_uring request
>>>> type. When done, data is returned via a new shared refill queue. A zero
>>>> copy page pool refills a hw rx queue from this refill queue directly. Of
>>>> course, the lifetime of these data buffers are managed by io_uring
>>>> rather than the networking stack, with different refcounting rules.
>>>
>>> just to make sure I understand, working with GPU memory as well as host
>>> memory is not a goal of this patch set?
>>
>> Yes, this patchset is only for host memory.
> 
> And is GPU memory on the near term to-do list?

Not a priority, but yes, and it's fairly easy to add as it'd
only need changes in setup disregard the fallback path.

-- 
Pavel Begunkov


