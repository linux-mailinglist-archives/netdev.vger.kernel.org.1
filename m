Return-Path: <netdev+bounces-94957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28808C1184
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A16C1F21C59
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58F1332A7;
	Thu,  9 May 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KoumUFGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B503A8CB
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266351; cv=none; b=dSJcpOWUiXIw4jSfMIPrQLsM6dvyMpSGu6fcxpFY51Zt7hu4EniktEEIBf3NH7w4XC2Eii8CWQsGvuNIAXs5uUpiIEpyK9iwSMqcxpmb265bZbVB2vRvP+aY3STuRN25ZdnBI+c9ARPFs1bYo9bFsvGms2DVsVT3JDS6zbhKrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266351; c=relaxed/simple;
	bh=Rlf8F6e0UNR/GLlLYh8MskiRanQiEQI7rraWFJ7XqKI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aVcrYnilXmX5qLuIwywwwEYvQNi20jvMteDxmE7Ht8TDrBtXrfEjuPKA3EKAnKCnLeYx3XsY3pj8O48PK4YaEGY6vfsI19ml9RGnHk4YZpsLClAR3F89kOksl0YPazdL9uf0cHWoZi5yuJXS13lv4V4GqGZE+DbRq9lSgKya8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KoumUFGg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so11800081fa.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715266347; x=1715871147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhHJBtn6NgRwxgKgbmvhK7CNwsu28rLn4L+T6nRtjFo=;
        b=KoumUFGg3950y/rZK9uIVIdLUFLSBY6Z3FRPECG8TVtZ47rj1vM9Hb0IpGvoWdGU8/
         PSqqdO8tl0LLlywt5NkRXUXJpyY0m1QY2UiPb4jdrFxim5IKUrTG5GWf5r1u0pPBEgrl
         HW4gdqLQe5uVLemiZVxiV7hRqA3V4n+r4UMuEqc5QB4XyvVhedBnk30mXrZc22EFcbfR
         BFn12OG1+UxIpYPX7c1eoowUwsTt8mT++7sVay3EGhqPo/qjkrE2TLWuWqhu2d9/67S+
         EEqmJNLGpwJcV4ikLr1W4AQCrOhg0t7D88JOrNvu0cR9wRUFC+W7nmV9znLJUcNT12QR
         ct9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715266347; x=1715871147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZhHJBtn6NgRwxgKgbmvhK7CNwsu28rLn4L+T6nRtjFo=;
        b=cuhIO1UM6Px58O5E+cjXLHnbYfQfkLo0paAFzdWey2WRkiAgCUsCoG1Qi7Faznx/yi
         JjdHO/FZRi5NovApzOaq2Iaevy86Y1qyrFRDlrL/wfMc9d540UYfbIZZvi9HLYIoVs0E
         OmMibCRtLE3SPjGr95BFrsgsyiAUAYGngzpErnoJfTGxA8kFWlTrZ+EYLjoSGpth9A5c
         mWhoBppKT6kfPzuCOhIxejO7vdcW038fpoVSFRMOJJk/PVMQffzE6c+0gb/VSluXqLZW
         gUcZjIxEQ+7ahUWix+qVHRhSGAThoUKK4kyYaGy8UP5aEiK+gNFsBkxK2DtGzLAnkvjG
         1UoQ==
X-Gm-Message-State: AOJu0YwNQ4aWe+AnXLvZZ/Qi/S6pdh+uokarTxQaLldVpYYyucibHjCW
	avuSRfpiysDR8aNfPTEgbR7MgMgaKttJN2ndpbS3j53akhVu42CUaOSNblGKVPA=
X-Google-Smtp-Source: AGHT+IHlBhQIYG0fD0OSppC7dXux8rTS6Uiumxj+YeaIfRIsT2rvFOjqefIFyeKmy3KkkOTFN7/G+g==
X-Received: by 2002:a05:651c:502:b0:2e2:5fd:7030 with SMTP id 38308e7fff4ca-2e446d89f84mr51855231fa.13.1715266347336;
        Thu, 09 May 2024 07:52:27 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78e8sm1916146f8f.61.2024.05.09.07.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 07:52:26 -0700 (PDT)
Message-ID: <786914f6-325c-4452-8d71-292ffb59a298@openvpn.net>
Date: Thu, 9 May 2024 16:53:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
From: Antonio Quartulli <antonio@openvpn.net>
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
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <04558c43-6b7d-4076-a6eb-d60222a292fc@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/05/2024 16:36, Antonio Quartulli wrote:
> On 09/05/2024 16:17, Sabrina Dubroca wrote:
>> 2024-05-09, 15:44:26 +0200, Antonio Quartulli wrote:
>>> On 09/05/2024 15:04, Sabrina Dubroca wrote:
>>>>>>> +void ovpn_peer_release(struct ovpn_peer *peer)
>>>>>>> +{
>>>>>>> +    call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * ovpn_peer_delete_work - work scheduled to release peer in 
>>>>>>> process context
>>>>>>> + * @work: the work object
>>>>>>> + */
>>>>>>> +static void ovpn_peer_delete_work(struct work_struct *work)
>>>>>>> +{
>>>>>>> +    struct ovpn_peer *peer = container_of(work, struct ovpn_peer,
>>>>>>> +                          delete_work);
>>>>>>> +    ovpn_peer_release(peer);
>>>>>>
>>>>>> Does call_rcu really need to run in process context?
>>>>>
>>>>> Reason for switching to process context is that we have to invoke
>>>>> ovpn_nl_notify_del_peer (that sends a netlink event to userspace) 
>>>>> and the
>>>>> latter requires a reference to the peer.
>>>>
>>>> I'm confused. When you say "requires a reference to the peer", do you
>>>> mean accessing fields of the peer object? I don't see why this
>>>> requires ovpn_nl_notify_del_peer to to run from process context.
>>>
>>> ovpn_nl_notify_del_peer sends a netlink message to userspace and I 
>>> was under
>>> the impression that it may block/sleep, no?
>>> For this reason I assumed it must be executed in process context.
>>
>> With s/GFP_KERNEL/GFP_ATOMIC/, it should be ok to run from whatever
>> context. Firing up a workqueue just to send a 100B netlink message
>> seems a bit overkill.
> 
> Oh ok, I thought the send could be a problem too.
> 
> Will test with GFP_ATOMIC then. Thanks for the hint.

I am back and unfortunately we also have (added by a later patch):

  294         napi_disable(&peer->napi);
  295         netif_napi_del(&peer->napi);

that need to be executed in process context.
So it seems I must fire up the worker anyway..


-- 
Antonio Quartulli
OpenVPN Inc.

