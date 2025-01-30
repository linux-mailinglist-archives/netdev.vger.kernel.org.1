Return-Path: <netdev+bounces-161609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4EA22B04
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DC43A5C0F
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB51B6D0F;
	Thu, 30 Jan 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijgiZz8W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDFB183098
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231058; cv=none; b=VU/puSs3wi8/byOkIzOxa8lig0kgN3axl7AKR/NwDVDvhLV6N8wKQFJq/I/DTELZ3LEJmOz3uC2AhqTuA0PKSeHMaYAXOlfqAGLnnYIP0RHO/fiIxBeBZcJHmlqr9F8BbxaMnPdlZGi5UcIFQhogfLhuaCjj0zsvAJ3nG7QtX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231058; c=relaxed/simple;
	bh=5JRSropCo22FJxz/20O3KHDYywagAzFau8cpXYyVhEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG7yPTlc2fisQ9VgjaWui+AL3XxxbQZ2p7ZWIPXhpl60JPeoCyoDrB9ND66pj63WncWyLRRlwDz3RAaearLLNpzJoyScqtZBXFkNzcQy6ehzjvfckDjfQg2vxYn6ZckvFD1gUYEOIoegmNNMi2z+Iq836K2AjERg2409u8RWz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijgiZz8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738231055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3UsS/EyvoSw46BJtQFwLW26Flj42eSQpHQKqBsQFEs=;
	b=ijgiZz8W4T9KjGJaR1A1+dbyuPsCHCAWuhtmlhdF5EjHZsen8lR13jAhLoNR0v5OmmxDTO
	wmG5PTXhnr1PUrV8JqJ23KXNLEx2kjEorhpjixe+CLEmCImP8lGLHo1aGSYy9dz4MJ8kWA
	VU41TRMuQCEFPoRV1q+/wAf/cnV22ls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-cfRfGdlPM0CCnh9_0edtGg-1; Thu, 30 Jan 2025 04:57:33 -0500
X-MC-Unique: cfRfGdlPM0CCnh9_0edtGg-1
X-Mimecast-MFC-AGG-ID: cfRfGdlPM0CCnh9_0edtGg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so2520595e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 01:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738231052; x=1738835852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3UsS/EyvoSw46BJtQFwLW26Flj42eSQpHQKqBsQFEs=;
        b=HCFKST27IjSrC6Q5ldwi5rlHLJCYKV7i9CQIuD4Ch8w+vws6luXOio43DYdwpKX8EL
         IUqQMe/PkpbnIa4CoYysRI8Gy7Y7/5iHd6MaaNXTVc1aHDDgCciquVQ0IXfRMZv810zF
         aiNODnugwx3qIXq13P1bVp6qAHhA4VSlrKvWNdqiUXlg6R4LJqAv8I/Bi3IJNfxOeMGZ
         oynzYoG+qfWk/MZhcZx76f6J7ewYDo0rAewnq2Os0Yu9Mru3wtv7lQ+TDrY8gdz/6tRK
         wl9aJjos0RyLgquAgeNSUKCCWlkzKUK78xxRNgdc4EQxafVnItdHHlJs3ywrXz5DM9wX
         bGQA==
X-Gm-Message-State: AOJu0YxenGcgt/oOAQYrXLNjaqFaT0jtPO5k0K5Twzg6Hn5WBaXkZMvJ
	Dlwt0LlRGcd7UCb5W9iyygZLbqRQrC0HoxuDyPC3tBkMYjEyReyAX7iVe+PjRuPi21eRHwETrLI
	ZJZ0IhC7VJU48oSuixnBu2rq7T88ezcF+R5HLVHeVGunsfqXx9b9wFA==
X-Gm-Gg: ASbGncuvwq89ubp/W1XIjenZjntgWwzJnQY6JNL6bfV8Jj5ynAIMrltNEEdaCUUDoM6
	pkrslYooTeGy9qNaG2jx6K+F5fT/wtpAUbTYbeD9sDhfbbxINoJME868f/RGiFgnKG60kWzkIZ3
	qkNmOLY0vhvcgOKOsOUZBArXTNpMsUqXIwo2VmBzG37eZ9Bh5t3EHqyyKHhNcOx1XaL99cc7yUL
	0ELa13nF3ncNUGSpcmWMI1oDQ3aOWwSaKE8keABf8mQD+PySNrA5GbnMVkuFLkpdTQ/77RPfVOk
	otJVd7v1i2HHF15K3WGhl+XSHWtxcVZHC7c=
X-Received: by 2002:a05:600c:1c1e:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-438dc40be31mr55374965e9.24.1738231052640;
        Thu, 30 Jan 2025 01:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe1ecQSpaa2hVLs2Y1pYNKxULDO87Z2+cbpfDxKikfWMqMjGI9Kf1AxOaDsrY/QI89jyz3tg==
X-Received: by 2002:a05:600c:1c1e:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-438dc40be31mr55374655e9.24.1738231052223;
        Thu, 30 Jan 2025 01:57:32 -0800 (PST)
Received: from [192.168.88.253] (146-241-12-107.dyn.eolo.it. [146.241.12.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f17dsm52822205e9.23.2025.01.30.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 01:57:31 -0800 (PST)
Message-ID: <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
Date: Thu, 30 Jan 2025 10:57:30 +0100
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/30/25 1:48 AM, John Ousterhout wrote:
> On Mon, Jan 27, 2025 at 2:19 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 1/15/25 7:59 PM, John Ousterhout wrote:
>>> +     /* Each iteration through the following loop processes one packet. */
>>> +     for (; skb; skb = next) {
>>> +             h = (struct homa_data_hdr *)skb->data;
>>> +             next = skb->next;
>>> +
>>> +             /* Relinquish the RPC lock temporarily if it's needed
>>> +              * elsewhere.
>>> +              */
>>> +             if (rpc) {
>>> +                     int flags = atomic_read(&rpc->flags);
>>> +
>>> +                     if (flags & APP_NEEDS_LOCK) {
>>> +                             homa_rpc_unlock(rpc);
>>> +                             homa_spin(200);
>>
>> Why spinning on the current CPU here? This is completely unexpected, and
>> usually tolerated only to deal with H/W imposed delay while programming
>> some device registers.
> 
> This is done to pass the RPC lock off to another thread (the
> application); the spin is there to allow the other thread to acquire
> the lock before this thread tries to acquire it again (almost
> immediately). There's no performance impact from the spin because this
> thread is going to turn around and try to acquire the RPC lock again
> (at which point it will spin until the other thread releases the
> lock). Thus it's either spin here or spin there. I've added a comment
> to explain this.

What if another process is spinning on the RPC lock without setting
APP_NEEDS_LOCK? AFAICS incoming packets targeting the same RPC could
land on different RX queues.

If the spin is not functionally needed, just drop it. If it's needed, it
would be better to find some functional replacement, possibly explicit
notification via waitqueue or completion.

/P


