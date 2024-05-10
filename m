Return-Path: <netdev+bounces-95463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091318C24F5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761341F22540
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFEB3FB87;
	Fri, 10 May 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bUFrTOGA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCB2BB13
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344384; cv=none; b=h9J9y/zGe50pQ6LbZm/76NQ/fFQ7InWcwtnLz/2TL8m0h6P21VRjWV1Vi4Irycz47BtctU1GKOD4UotQ5fwOcjIUOpmgKJMvPrpZu5saHIl//JHT5JfPc0WeOWeMlLBm9YRUxCAVavPJXlrT6My4mDrOKAlIj0l3mZSqYp2SodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344384; c=relaxed/simple;
	bh=kYUhRE8XXHIf1fS+J5+tawNPVJ+36Sqb+K0H2MOUl9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRhvOzs0+CQECEaKLTQJUp7FRScMcFj6tK3TacRt8zR8iwwBxFYMvsQxcjGkd8nNjQ7DesZzi1tdhESvr3ThHOcYQ7sAMPp0ERMqv5NJM6qfRtAxpMrXErEoHs1thkle15RBMMpaFsGNQNOQdCHKecN0t594ma00/rW5yv2u0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bUFrTOGA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b794510cdso14582225e9.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715344380; x=1715949180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ja4HMY/qH9q3evGPXzHQrZsAwAiVN0hINEGtpQhHx3w=;
        b=bUFrTOGAVIe6wMnB1hUR76juzeeCn4WD+SrLfX1GxmaopHgHsTMW5pDyXQRcVKrppk
         7P8CcRPuESARW9YOYN/tYmzd0ORB8p1h2ynkP0lpEgqsObPd53hE71IE+f9+nfCgrznA
         lO9TY2T058J0kzHYe2Owm5+uw4o+vPlir087GPWQmLiuVLZyyET2vz6oK3kZX5IzxBoR
         dj4Zrd+4HOl2VBiUJlNCm831lxKYGakqMr3uAF0v0OqOhXdI3RkMrXTA0gPzF0hZkAYV
         LFynh6dNno0bsL3Uwrun3jRfLeeZNKtyAoKDCqLWhEI702l+Dmqg3xQa6LAG1ghEyXHQ
         6GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715344380; x=1715949180;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja4HMY/qH9q3evGPXzHQrZsAwAiVN0hINEGtpQhHx3w=;
        b=eVr4YTgVw/4xcfiZ6ZKyALH7ldrA6RVIdeM6wPX2PuadQgxoCTHjfnubadNsOUR0/j
         cxlBSFyNZ5TtaAHz9TVfID7oZd6h/j5OXe5tao/a93AjdOTCO0ja6itvIy9yVqwaGE4N
         GXzyzXuYXqktf0Y+a0DOAmzIFFjF6lQP2HOVVpLF5AW6yFcAJ8A50xrIPl+NamcQ40gb
         USvJMmD9hLOxqP+2vO8cbkbxWQZZIkqPrgYOK1Xc4aQsgqfo2ao9YmVitvNq+4WjR7x4
         gCQQfhXVti/c522127nppaLjbW7g9HE3vQxSOy/jnF0nv8Xz+e9vSE6VZojDiKluihBF
         gUOQ==
X-Gm-Message-State: AOJu0YxDZGZPj6IUDQ+4tqbpJIZjTIOBNzf2mf27xfg8vNEEs1wM1nnm
	KF9MspW99+shEDogJzufva0owGrxO9WuAaxuyAIRJ79Y1ZdDlHgE0U2Y/AgWIuo=
X-Google-Smtp-Source: AGHT+IEmhcM37ic1rELGd9AXBLSCdPrbqWmTFQdycWtgDOzuU+J7LK2/yQOLYco/aXeaLoIzYPf/4A==
X-Received: by 2002:adf:e2d2:0:b0:34d:8ccf:2c10 with SMTP id ffacd0b85a97d-3504a62ff7dmr1726034f8f.10.1715344380498;
        Fri, 10 May 2024 05:33:00 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:d421:4f57:ac07:f400? ([2001:67c:2fbc:0:d421:4f57:ac07:f400])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm4441612f8f.68.2024.05.10.05.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 05:32:59 -0700 (PDT)
Message-ID: <ed0c69a4-37fb-4e3a-8286-ebb30061b548@openvpn.net>
Date: Fri, 10 May 2024 14:34:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net> <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net> <ZjzJ5Hm8hHnE7LR9@hog>
 <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net> <ZjzbDpEW5iVqW8oA@hog>
 <04558c43-6b7d-4076-a6eb-d60222a292fc@openvpn.net>
 <786914f6-325c-4452-8d71-292ffb59a298@openvpn.net> <Zj33TTI5081ejbfs@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zj33TTI5081ejbfs@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/05/2024 12:30, Sabrina Dubroca wrote:
> 2024-05-09, 16:53:42 +0200, Antonio Quartulli wrote:
>>
>>
>> On 09/05/2024 16:36, Antonio Quartulli wrote:
>>> On 09/05/2024 16:17, Sabrina Dubroca wrote:
>>>> 2024-05-09, 15:44:26 +0200, Antonio Quartulli wrote:
>>>>> On 09/05/2024 15:04, Sabrina Dubroca wrote:
>>>>>>>>> +void ovpn_peer_release(struct ovpn_peer *peer)
>>>>>>>>> +{
>>>>>>>>> +    call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>> + * ovpn_peer_delete_work - work scheduled to
>>>>>>>>> release peer in process context
>>>>>>>>> + * @work: the work object
>>>>>>>>> + */
>>>>>>>>> +static void ovpn_peer_delete_work(struct work_struct *work)
>>>>>>>>> +{
>>>>>>>>> +    struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>>>>>>>>> +                          delete_work);
>>>>>>>>> +    ovpn_peer_release(peer);
>>>>>>>>
>>>>>>>> Does call_rcu really need to run in process context?
>>>>>>>
>>>>>>> Reason for switching to process context is that we have to invoke
>>>>>>> ovpn_nl_notify_del_peer (that sends a netlink event to
>>>>>>> userspace) and the
>>>>>>> latter requires a reference to the peer.
>>>>>>
>>>>>> I'm confused. When you say "requires a reference to the peer", do you
>>>>>> mean accessing fields of the peer object? I don't see why this
>>>>>> requires ovpn_nl_notify_del_peer to to run from process context.
>>>>>
>>>>> ovpn_nl_notify_del_peer sends a netlink message to userspace and
>>>>> I was under
>>>>> the impression that it may block/sleep, no?
>>>>> For this reason I assumed it must be executed in process context.
>>>>
>>>> With s/GFP_KERNEL/GFP_ATOMIC/, it should be ok to run from whatever
>>>> context. Firing up a workqueue just to send a 100B netlink message
>>>> seems a bit overkill.
>>>
>>> Oh ok, I thought the send could be a problem too.
>>>
>>> Will test with GFP_ATOMIC then. Thanks for the hint.
>>
>> I am back and unfortunately we also have (added by a later patch):
>>
>>   294         napi_disable(&peer->napi);
>>   295         netif_napi_del(&peer->napi);
> 
> Do you need the napi instance to be per peer, or can it be per
> netdevice? If it's per netdevice you can clean it up in
> ->priv_destructor.

In an ideal world, at some point I could leverage on multiple CPUs 
handling traffic from multiple peers, therefore every queue in the 
driver is per peer, NAPI included.

Does it make sense?

Now, whether this is truly feasible from the core perspective is 
something I don't know yet.

For sure, for the time being I could shrink everything to one queue.
There is one workqueue only encrypting/decrypting packets right now, 
therefore multiple NAPI queues are not truly useful at this time.


> 
>> that need to be executed in process context.
>> So it seems I must fire up the worker anyway..
> 
> I hope with can simplify all that logic. There's some complexity
> that's unavoidable in this kind of driver, but maybe not as much as
> you've got here.
> 

I am all for simplification, and rest assured that the current version 
is already much simpler than what it originally was :-)


-- 
Antonio Quartulli
OpenVPN Inc.

