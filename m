Return-Path: <netdev+bounces-243229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F82C9BF3A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 970B14E4725
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C66266568;
	Tue,  2 Dec 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/DrpocK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BD264A92
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689383; cv=none; b=cLvpwwIqAIa6gEwj43KO5Miga6x7n+w+3/cu23eW5U0bjq/aqaDIzBO07BVZ5kyMVxUWcRfsf8+BPGNo+HyiETJLbOT+2EHCvm9k0+80p/5U1vis3AmInJTPm7am8ZpExUIQnu9uEVGTW24f70ZDk/LnVmRhzceqL7jpDEXvjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689383; c=relaxed/simple;
	bh=BZtIuSYzo4X0vi8zHGDRh1sL+AQ42TCB+JFZn40EQnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTwhnU7IxvV0VW+75XVuYUDuk07Owyo4tYVMCw4lZviRpL/HiVdUAyMpKHybu5ouwdU/TNCI3fYZ+z0Qe0rhaE/Rpj3JWsXFoqUD3KOqQ13anLVouqo7lLSJuok2J3eNVQx0u+eCCYEUps/+7WVnqDOZqwJxlA8EAA4qoSx4+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/DrpocK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2981f9ce15cso64712775ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764689381; x=1765294181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm04M8J4HumgMBH0ZuXZAiRY8Gdv9LOi293f7C71dv8=;
        b=D/DrpocKM7R3+UI5XzGY+e7wsnIjOBh41K6MGTdDpZuqjUQY52jAWsybQO/XVerCgz
         fd7lTDHFLLwKvkS0Sg1QUVjiG5wt1XqnF52idr/taYJhPTN2mpzE5V9UMTUh15f5dZJe
         r4g90Sk8ke+YbfBljPn1WOXi5Cs99c51T/flI6/JcTUBaFJP45zcxkcsQw8LJYkZAq1P
         djgloHzXZ/U4mqggjKzzUXft7z26Vm89WlcjjG6rHNmYusR7IW6AXcmYIT2AvrEVeabp
         g/lAF+X9BrsPoSOIRMRrP+DBja/eFZBEBUW0tXuQzLF40fiJ7M/hOvvI8P1RzNOSoFuA
         Dt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689381; x=1765294181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm04M8J4HumgMBH0ZuXZAiRY8Gdv9LOi293f7C71dv8=;
        b=W0QptEqYe2vDhqvPg4Tva+6g/1XUWGnwrIylXB/yJrpIljYxMwBSQNBhlW4mETrQ2W
         eEgtZgSCSSdS9tIv/zPcgd6L4Y1b/rv7UKBsAg28XEjqVMXrVhRYx345bFV+H9pUXHWS
         3yYwuYiHdG304gIt/PXajF7vZLlf0gbfnteMdGe35nX665yoiztdwf39zzgj6yJje6Q7
         E1eRxiy5VRHDixqFHSK7dtIcEQlM/Nc67cTra4HeLIBm5tzaKka8wurBJJZy7OKJVoP/
         0RnE8BvkHaU0n8reGmRLyMG7aylqJ4cksgGoId3/h+pocaBnWS/ai058EWzf5BmC3bOV
         lNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCViiW6dCveHNNjBpXedrnwdoUU9YBBt7kLnT+AvkQxqB9VLQ/ewWYl9KgKanCXOvobXvmgfQK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4P1jvBhcynM+qRzMp8nnRy8UITf4nZmXj3xOghUivf1O/YN7
	JB6K1bw25wGhzgD7nbHqwk2mtkX6QbQH/7Du8wueNSS8HTu690R9ASqa
X-Gm-Gg: ASbGncv/2Sc4MUfUCX23KrcnrugA355J8NkPxYmUB74pxYwESPLTeMrHse2g1XPVCoC
	i93cA+bG2/2CCkX2qUjHbqSIdBd19HxD6j2kg3i1m0GxXQfCWqJUS22R2IRfiR6fY//GfMZPeVZ
	c93P0xuGSUMxlhm+4//Wm7tBe/LfBSnLv0k3dCicU0L3nN/7DunQ/r/WwNKQs/zsM+gacKlyMSS
	vi4UBPY4RxRXrFywplD3hoknEbGPbPcdOkdzVYEYYPvW1SSp3DKxcYujUtsUaQTeWaQKPOLuczh
	Xlvu2g36KQHHpjbZ3DQ5bfyhfBAoC/uih6DJJwioyJ2eSoVpxGLbfYRy1LeRsxuYGXc3flCUsqf
	L62Ct0zXWannuOLRbIvHvFWmVUi0DItOkp89ZHMdO/8ua57RMlW29WmnNeQtmwLzVPUhJzhu8PV
	+CPEmSevhKNWdmymKgboVvqOtghwfGtpQ7MHIzML6Guz6Dc57zEnNyUHxJR6E=
X-Google-Smtp-Source: AGHT+IFXvcfWnNHx250mT23ggaMtDNXUs/Vb5yUhRUZMPaS6sYLlPPubZ17O0Xp1IrUFreHe7V613g==
X-Received: by 2002:a17:903:320a:b0:29a:5ce:b467 with SMTP id d9443c01a7336-29b6bf9e98amr470449935ad.54.1764689380670;
        Tue, 02 Dec 2025 07:29:40 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:48c5:4372:8d4:ac0b? ([2001:ee0:4f4c:210:48c5:4372:8d4:ac0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab6bsm157212555ad.21.2025.12.02.07.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 07:29:40 -0800 (PST)
Message-ID: <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
Date: Tue, 2 Dec 2025 22:29:32 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
 <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/25 13:03, Jason Wang wrote:
> On Mon, Dec 1, 2025 at 11:04 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 11/28/25 09:20, Jason Wang wrote:
>>> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> I think the the requeue in refill_work is not the problem here. In
>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>>>> will disable work -> flush work -> enable again. So if the work requeue
>>>> itself in flush work, the requeue will fail because the work is already
>>>> disabled.
>>> Right.
>>>
>>>> I think what triggers the deadlock here is a bug in
>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>>>> refill. It schedules the refill work right after napi_enable the first
>>>> receive queue. The correct way must be napi_enable all receive queues
>>>> before scheduling refill work.
>>> So what you meant is that the napi_disable() is called for a queue
>>> whose NAPI has been disabled?
>>>
>>> cpu0] enable_delayed_refill()
>>> cpu0] napi_enable(queue0)
>>> cpu0] schedule_delayed_work(&vi->refill)
>>> cpu1] napi_disable(queue0)
>>> cpu1] napi_enable(queue0)
>>> cpu1] napi_disable(queue1)
>>>
>>> In this case cpu1 waits forever while holding the netdev lock. This
>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
>>> NAPI enablement with netdev_lock()")?
>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
>> refill when pausing rx"), but it has flaws.
> I wonder if a simplified version is just restoring the behaviour
> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> something.

As far as I understand, before 413f0271f3966 ("net: protect NAPI 
enablement with netdev_lock()"), the napi is protected by the 
rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(), 
so it seems like we will have race condition before 413f0271f3966 ("net: 
protect NAPI enablement with netdev_lock()").

Thanks,
Quang Minh.

