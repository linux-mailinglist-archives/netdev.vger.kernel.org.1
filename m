Return-Path: <netdev+bounces-204879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A126CAFC5A2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DCB1886C0F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7C2BDC0A;
	Tue,  8 Jul 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS6YB+4U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC702BDC3F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963318; cv=none; b=lN8VqqihR864WIJZc3GJQeD+XJfp0VRrezTgz3Vx8LnJQG1kDWBShwBQXjHOYiUYJRVpj77xETIvA8dLk0mEMh4n7RlOIT4s2XmMZd3OPleh57zFnUOqno9MrmsOfVbsiBEGvdi4ABdcyz1AZwaZEIMtWiv+jEOQ6paErHvbWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963318; c=relaxed/simple;
	bh=aTVqbBJCrpdA/23ncYm6csiwV9ujBFQ/Zovn7BQNI0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTx1nkA3PVkgxIrmdfvOTtI1fbmLUfs5xSUxuvtJaFg5GHxpzodAPU8qTJfSjAeZRqWk8EvUtEAuL6AwgKy2kLF4+6hoMsB4m3S8cT5t9BSkzpH4x5+TIcFFUA3ZcjFSdzsHJ/xGNfySMJgyf2BXRzJhsx5XygHsVONIg44gFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS6YB+4U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751963315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxPFV3tFLky59XA4g/lfynYxXJjgy/YJX1OKkvxJ+rI=;
	b=IS6YB+4UpoMq7RoZMgTNfKe/Uy4JyhJduCcP/nGeS71v1PSn3LIB9czQ/yg5oLBFAazN0b
	XdExzQzJCz9QRfAamlXcDOna+SgAmMJSL0HCd59Sr/KgdU1jXWQUAZhk72FZKVRr//GaB6
	ZeojFFPMewjfuqRU8eSiSNtGT8pcIMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TVIrjra7PgaOwBBEbBCdIg-1; Tue, 08 Jul 2025 04:28:34 -0400
X-MC-Unique: TVIrjra7PgaOwBBEbBCdIg-1
X-Mimecast-MFC-AGG-ID: TVIrjra7PgaOwBBEbBCdIg_1751963313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso29746655e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963313; x=1752568113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxPFV3tFLky59XA4g/lfynYxXJjgy/YJX1OKkvxJ+rI=;
        b=AGsH1ZUjeyEzIhIOytfehRTyQYj8OS7Vcs/9zzrs0mPRX/ae8DMyaAioDjYbv7BWL6
         8Bg/3EEjzWgc0TaSuj3citENM0sdGlz0Cw83TI1ETWTyC9Km+LEISgwRBY1xQgyTzMn5
         VeIeNNZJDcGKwF14ON5Xaw4EIjiWQB6EpGfxXgHlh0KX4CgRg/XGpV/0uicLS70okSYy
         iwy+vEwq2aF+Z1RK2WOdheEdh21vcs9QnTO6wIQvpXLXJbOqAjctuwfVfWiXxVSbvtkJ
         c3Y1mN3N/4aZoF4c7m/K9KbBNIq2X8rFzVyTqDiYAydVG/dWs1ZVgqsx4US3W2q7ikSS
         Ahtw==
X-Forwarded-Encrypted: i=1; AJvYcCWF3nYsiMdJaxSvN2L83zU9P0Wr10HoWU7TW8NNg6VvJqcOwiG10/RBi6tB378BTLPgRevGH7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYpsQMXArCkunGKRRPvGRveQH3WkLUF4tcP+eQowSW85JMUxf
	6mwniXc6LSNfw0Dc4BbxK0x+cxaOjyx5iVz+AzGKxUfe2BXdr0Yp4/2rEixmh5cgBz2lHwP/H41
	ifsEPdr9v9JNTHhiiTj/q8E3SWP8XGXO0jGUzmZKBzL4EdVXULLHuxyGCDA==
X-Gm-Gg: ASbGncu8PXoaW0FvlLZdf0NXXxyMcYgXCly17qTLj7ZQBi5kkmKGZs1n/eZGGAr1Dc0
	RZb8qh81/UpYVfLG6Q/cKt/NWZo/leO2JPTPWR2V0Ihqnd0KZ5hN8JsS++RW9VMdZOhfMIfVE2l
	0BNg0uNiEuaYIovS7Tckz59xCrKiYgCl6SzLNR2j6eXMy1Xsx9fg93IbvHlWVvz9h1M6F+XdE5+
	q24xIwEVnIdIWZEOac9SkUc8FBz7oAnoQpTIv9W3F4/2dMSt09BVth5vYYj6yO8deLwm9wqQ1hn
	sOua/jyTRYeVyh3g3wSK4JTzPHnh5HSRN00q9nCA4AeDLZXGnAD+i92md3S60RadKH3/Wg==
X-Received: by 2002:a05:600c:a087:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454b310d890mr135455805e9.26.1751963312712;
        Tue, 08 Jul 2025 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKeZmp4gshJPfdVZLft+U6QKBU434mwlK26v/9HLXxDoFpa/+j0LPJFeFl/k2mvKbg4sYKig==
X-Received: by 2002:a05:600c:a087:b0:454:ab1a:8c39 with SMTP id 5b1f17b1804b1-454b310d890mr135455575e9.26.1751963312271;
        Tue, 08 Jul 2025 01:28:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c90esm12502048f8f.91.2025.07.08.01.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:28:31 -0700 (PDT)
Message-ID: <1eb149e6-68e7-4932-8090-34ee568c5832@redhat.com>
Date: Tue, 8 Jul 2025 10:28:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: Replace per-CPU recursion counter with
 lock-owner field
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Williams <clrkwllms@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Gao Feng <gfree.wind@vip.163.com>, Guillaume Nault <g.nault@alphalink.fr>
References: <20250627105013.Qtv54bEk@linutronix.de>
 <9bffa021-2f33-4246-a8d4-cce0affe9efe@redhat.com>
 <20250704154806.twigjkbU@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704154806.twigjkbU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the latency, OoO here in between.

On 7/4/25 5:48 PM, Sebastian Andrzej Siewior wrote:
> On 2025-07-03 09:55:21 [+0200], Paolo Abeni wrote:
>> Is there any special reason to not use local_lock here? I find this
>> patch quite hard to read and follow, as opposed to the local_lock usage
>> pattern. Also the fact that the code change does not affect RT enabled
>> build only is IMHO a negative thing.
> 
> Adding a local_lock_t to "protect" the counter isn't that simple. I
> still have to check for the owner of the lock before the lock is
> acquired to avoid recursion on that local_lock_t. I need to acquire the
> lock before checking the counter because another task might have
> incremented the counter (so acquiring the lock would not deadlock). This
> is similar to the recursion detection in openvswitch. That means I would
> need to add the local_lock_t and an owner field next to the recursion
> counter.

IMHO using a similar approach to something already implemented is a
plus, and the OVS code did not look that scaring. Also it had the IMHO
significant advantage of keeping the changes constrained to the RT build.

> I've been looking at the counter and how it is used and it did not look
> right. The recursion, it should detect, was described in commit
> 55454a565836e ("ppp: avoid dealock on recursive xmit"). There are two
> locks that can be acquired due to recursion and that one counter is
> supposed to catch both cases based on current code flow.
> 
> It is also not obvious why ppp_channel_push() makes the difference
> depending on pch->ppp while ->start_xmit callback is invoked based on
> pch->chan.
> It looked more natural to avoid the per-CPU usage and detect the
> recursion based on the lock that might be acquired recursively. I hope
> this makes it easier to understand what is going on here.

Actually I'm a bit lost. According to 55454a565836e a single recursion
check in ppp_xmit_process() should be enough, and I think that keeping
the complexity constraint there be better.

> While looking through the code I wasn't sure if
> ppp_channel_bridge_input() requires the same kind of check for recursion
> but adding it based on the lock, that is about to be acquired, would be
> easier.

(still lost in PPP, but) The xmit -> input path transition should have
already break the recursion (via the backlog). Recursion check in tx
should be sufficient.

All in all I think it would be safer the local lock based approach.

Thanks,

Paolo


