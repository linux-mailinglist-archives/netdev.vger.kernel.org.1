Return-Path: <netdev+bounces-160531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811BA1A14A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59F27A1C05
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDC20D4E8;
	Thu, 23 Jan 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSPk1U78"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B320D519
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626220; cv=none; b=J5HVpwMwu1f3zA4PYYxe2tP7uLkQ4Vss/vWvi9U1ZJuxkOmride8y95wCoUPvM5atO3lsHgQMBZJ6FkTnEOP0TNWY1sTFvEPT3Sk/iFZ2bMKpyPRjTfDiTZCStKq6j2vasKmTfNtsTCV0PTZqZuVlqKQg/+G82QWjAkbhEPqWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626220; c=relaxed/simple;
	bh=ERAIMIKIu9APFSuO9Cn/T3m12u7EZAmVoz09ki9CqGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNU2In7/vEPqvEeo0E80jypqlxZNKXO2Xd3eaq4D29Iq3sgsITfiiudkL9NAArMDYASp60QyE6lgD63XNoOEnGqrKdmUO5sdlgYf9nOBwJEjv1cVEROt7d3axMgVu2Z/2zYrURJLgOsBW4y+b1G04W8859JDvTYLw4JTnVyCbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSPk1U78; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737626214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YN5ISUI76bMnss/OXDHrGsjku/c5kM4P7iAQCZfcmpU=;
	b=QSPk1U78lMQQGdGvoA6kUzDcBYMQz0vAMp3il5jTbRRHYwU9AiOW0Yre5KSDfykCDB6J6o
	uXt6oamIu9PsKUqBTAl6OrtUwbfYkV2sDKo0aKviOOtLEJweorNdH35a6wh/01U8G5sTBm
	5fODlKtpMtPM/29s7Gx2D//ncCTUeTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-KgqapWGlPi-MhaxkVJxzYw-1; Thu, 23 Jan 2025 04:56:49 -0500
X-MC-Unique: KgqapWGlPi-MhaxkVJxzYw-1
X-Mimecast-MFC-AGG-ID: KgqapWGlPi-MhaxkVJxzYw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso5817525e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 01:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626207; x=1738231007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN5ISUI76bMnss/OXDHrGsjku/c5kM4P7iAQCZfcmpU=;
        b=uOLfVv0ChW7qIZIwAXyJJbziqn8iIZ5R0QFxPPrfonXdkJ4PoepqcjVjLRqjC5fMYI
         3vBy+lO5IhGN9hBxc/SHHgNww9dSMU5aMvb3Tk7FZGAWDDRLedDDUInEY1gI9THzGoID
         4V5zmIuE+gO3Kh/FqMuoN0lvI5DgH0/JRQriInzlvukr4t/Q5+mFNzfFBpdsUEZy8tvp
         2krZXfRUx9f5reqOBdQTpDrlHAjHg1yZJoJ9CrRvL7jLIH+Y7BrmqdxZuaKSI00EzRLI
         xyZkmtwxziiHMvzIeaSjwBtBqjhY0DUnobVkEXVH2qrnPhT9JDtR7Y8gL/2/a2kNUN8e
         jhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL6F1TcACky8KJjs481N+EAjHfKaBf652oUgYC2cV7nQjLocXeqWtnn0tmbFUqahxX6fqdVuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhUnwSW8FOPRslXGEyUF8PSfp6dhT17+HBhgTkPonjzrz3Sdn
	P+NMHPq2ClzMelMctx5/PEPislDvZaVw+2YB/PH7YrelriptrpAhSOaGADUXeLpm53B5QAsVAN4
	GjHOidKqj3HWOrB2h8iFeRRrCI8E57P2YGe8lmWQiKNG4beW3lKUmtlDfopcmOw==
X-Gm-Gg: ASbGncu/9uLQaz/D6W/7POo55guehSmUwXnCNSMUkm7CGFMbkK75qAdDWaWi6hl0V59
	1PUSSlhmcKHj28wI9Lh4xYUiU/JLDVgxJmQmlc+P8xLWbN/gq0xoH6EvUCB05uhxXqh+2xuI/8c
	FQGwlF7AJJkhrwYUnDxjUKUx+G4N7J3vPkisA/ALo3EJyR/wR6DMsHSrJRLtd49f55iIGXzETKk
	wMXytUVrpcP7yathyb/cSbmp+QKpsZWURd7B3WGQfBncslSH2ag1TpATG65ZPqAl+/Jl+R7XS9P
	ZQ6OGs86RfU7HPDLySRsd0z8
X-Received: by 2002:a05:600c:34c9:b0:436:f975:29d with SMTP id 5b1f17b1804b1-438913bffd9mr231650205e9.6.1737626206988;
        Thu, 23 Jan 2025 01:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJHnewSJlPxFP9qi7fJLgC8bjjyroK4Qc6r15kcanAlYURNuOkB1/AfBOP9ckT3pjhn9NCug==
X-Received: by 2002:a05:600c:34c9:b0:436:f975:29d with SMTP id 5b1f17b1804b1-438913bffd9mr231649985e9.6.1737626206652;
        Thu, 23 Jan 2025 01:56:46 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31c7c6asm55250225e9.35.2025.01.23.01.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 01:56:46 -0800 (PST)
Message-ID: <84c82380-4210-4efe-a269-6a40c3e39e61@redhat.com>
Date: Thu, 23 Jan 2025 10:56:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
To: Chenyuan Yang <chenyuan0y@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, paul@crapouillou.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zijie98@gmail.com
References: <20250120222557.833100-1-chenyuan0y@gmail.com>
 <xttnvcmu3dep2genvce3r7spreliecx3dc3rynups25q6xilk6@tf4wxe6bdxia>
 <CALGdzuqsjddPKgpCdOtDyAAJcJcfd1UUyK7o4YzL8a1E5EsNKw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALGdzuqsjddPKgpCdOtDyAAJcJcfd1UUyK7o4YzL8a1E5EsNKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/21/25 9:04 PM, Chenyuan Yang wrote:
> On Mon, Jan 20, 2025 at 11:33 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>> On Mon, Jan 20, 2025 at 04:25:57PM -0600, Chenyuan Yang wrote:
>>> dm is netdev private data and it cannot be
>>> used after free_netdev() call. Using adpt after free_netdev()
>>
>> What is adpt?
> 
> This should be "dm".
> 
>>> can cause UAF bug. Fix it by moving free_netdev() at the end of the
>>> function.
>>
>> "can cause"? Doesn't that trigger reliable?
>>
>> How did you find that issue? Did this actually trigger for you, or is it
>> a static checker that found it? Please mention that in the commit log.
> 
> This is detected by our static checker. Thus, we don't have a
> test-case to trigger it stably.
> Basically, it has the buggy pattern as the commit mentioned below.
> 
>>> This is similar to the issue fixed in commit
>>> ad297cd2db8953e2202970e9504cab247b6c7cb4 ("net: qcom/emac: fix UAF in emac_remove").
>>
>> Please shorten the commit id, typically to 12 chars as you did in the
>> Fixes line below.
> 
> Sure! Should I send a Patch v2 for this commit?

Please do! while at it, please also include the target tree ('net') in
the subj prefix.

Thanks,

Paolo


