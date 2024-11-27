Return-Path: <netdev+bounces-147532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB89DA06B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 02:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C727284C3C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70CF1803A;
	Wed, 27 Nov 2024 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="epoOx5uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD71946B
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671574; cv=none; b=M49kA+aefcMZ4WyMfmuJ+25VwWYUlzmbsccwBv5cQUvtwzN29p7aoxJ7ESI6DH1X8YnuBwpaks8piGBAfXVMvLEp8G5S16tp5L+HiNHPMdADJ3lmXAItWXgoLaiT/7lCRFLFNVqSHrlWYJ6sZ7MjAFIwsdqYLdPABEd6XvqBooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671574; c=relaxed/simple;
	bh=KL4zWxXZDEXFjC3sH1lz3oJ6QUVZvpY0E5T/drnan/Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BwGVBMjP6EaZmeWmrhcE8nlpJbv7HbpY9oGZSR0m3V2m0AD89ft24sAROrak3LLQjgCxKyuA4+aut6kA3dAhWNa0mtlYKWL1+m3I2dqgJhXQRWtwTwS5oUo91IHghwcZy2MidZVWHdp83nPO+otI6I7ko6oEiCJIomQYBe+SLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=epoOx5uq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa52bb7beceso511872566b.3
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732671570; x=1733276370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXHRTnhBH7f1ASTCrHAWhVSUa0aFbmTXAI7eBbisBbk=;
        b=epoOx5uq4jJnUgufqRPo6Qyx+FqH5WGDsTGNMEgYnpYyrYuXXcN3gs/dAYrXwRJtgk
         6jaAarCZ+QQfeqhz18NA1pTIBCYfBDCXdtgLr/PZEKYE8aI0KKY9vLDxgVGRhkdbPKKP
         Q8GrkASNR5Pj8YoYcToqBidehFlFUcYIGKXCrrOSFqKa66UKsYDOu7ayLe2rUfVEV6gA
         cxqOjb0/c6nH6TjYh6B3b1GMrje9MeJA12sik4tYE73v1T+PW/rbrw+x4KfDv9YROhnL
         KYRNiJu7ERzvIxb+6GeNyU3xV4Eejuo7oMc7bFBW3QA2nlxZRmT0+yG/AYSuWMC9Jbm3
         piFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732671570; x=1733276370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXHRTnhBH7f1ASTCrHAWhVSUa0aFbmTXAI7eBbisBbk=;
        b=O0lzWyQ9myq4yx4Ww4E5Q+oZw4NXKrZHLix+6n+yxRFalQt1W2NEXAV9CPcOa8+tIr
         Mo/j/MNDG8oa9F0WcjKws86L7ROr0x3jsIZl/Bz/4VHGo9XNZx+5vVtVPm+f8gQuoY2B
         7tkwefJ3VT90PaXRTbPYJ6pOr1teZRIMj3WarqL2xfdWO/2Tg4/i9LxoZnfZnKnHdxTp
         uV9JPnDKq8M4aMrIAFhkNVExEoPphp/u3JVcaOJNJx0TcF3LHyJB6P8C/rLTIOaELgek
         CgnDxOeIQuPWBPuMVFqrleMphG59oPZ0cnkECvAVjaVOpsjfb7pYnWeyCI7B9sNf06hW
         WurQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtN0jQIf8jY6YpBPpDCJcSob8057PXHoLlMnkIcUSsGUgJsitb9X5+EUUlow4lLUNYJXAJ7ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUO/kqbjuXn6cNZga4f60iYvKfRj5eJDBO8RXaijZMdZJ5BgH
	60bzssG115zpWWIuUcfcKsit+cKFhZIx0Gu+ZYbt/0XnpNpVrsRxMX4Ze/zgAq0=
X-Gm-Gg: ASbGnctHdTI78vqrpfaW020SLlc3uCnTqle8biD/7S71L95uDDBsOdAyUtUFGt9YVSj
	JbpiyJiHkIicXI4hxs3s87LyJS636ph3K0dFkM6UX+nIe0BeowEWHBYt9Cc11ejqG41LWsehLmx
	9N0fC8/xqxPQJc/eVry6KwYA6Z+5hrCvJSzloTvQaCqy5hJBPAGBfWOL5TXbYKrNRpC2bgmbBc9
	54413EmCITlfM89QQxvRjlAePQSS2uPFBPZ/fvn4+jp5pngYFSTR4u73Go0UTi4Wo7/NVc5Htmp
	keH8/FWuMQ==
X-Google-Smtp-Source: AGHT+IE+ZD3OX1m4rkHq8FBHMwGAiAanB01jl/KaBasyk1+49gvjqbB1yUMCPbsxce6E0Dc+SKpD4A==
X-Received: by 2002:a17:906:3145:b0:aa5:1d08:dad7 with SMTP id a640c23a62f3a-aa580ed0a63mr61701566b.9.1732671569682;
        Tue, 26 Nov 2024 17:39:29 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:da11:5b16:7b45:f72? ([2001:67c:2fbc:1:da11:5b16:7b45:f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57d4d5sm649155866b.163.2024.11.26.17.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 17:39:29 -0800 (PST)
Message-ID: <a4a537df-900b-43e6-bcc2-5049036b1ca2@openvpn.net>
Date: Wed, 27 Nov 2024 02:40:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
From: Antonio Quartulli <antonio@openvpn.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
 <4c24d8ba-35d0-4aff-b207-9eca6eeda1fc@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <4c24d8ba-35d0-4aff-b207-9eca6eeda1fc@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2024 09:49, Antonio Quartulli wrote:
[...]
>>
>> The potential issue is tricky since we create it patch-by-patch.
>>
>> Up to this patch the socket releasing procedure looks solid and 
>> reliable. E.g. the P2P netdev destroying:
>>
>>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>      ovpn_peer_release_p2p
>>        ovpn_peer_del_p2p
>>          ovpn_peer_put
>>            ovpn_peer_release_kref
>>              ovpn_peer_release
>>                ovpn_socket_put
>>                  ovpn_socket_release_kref
>>                    ovpn_socket_detach
>>                      ovpn_udp_socket_detach
>>                        setup_udp_tunnel_sock
>>    netdev_run_todo
>>      rcu_barrier  <- no running ovpn_udp_encap_recv after this point
>>      free_netdev
>>
>> After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv() 
>> will be spawned. And after the rcu_barrier() all running 
>> ovpn_udp_encap_recv() will be done. All good.
>>
> 
> ok
> 
>> Then, the following patch 'ovpn: implement TCP transport' disjoin 
>> ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling the 
>> socket detach function call:
>>
>>    ovpn_socket_release_kref
>>      ovpn_socket_schedule_release
>>        schedule_work(&sock->work)
>>
>> And long time after the socket will be actually detached:
>>
>>    ovpn_socket_release_work
>>      ovpn_socket_detach
>>        ovpn_udp_socket_detach
>>          setup_udp_tunnel_sock
>>
>> And until this detaching will take a place, UDP handler can call 
>> ovpn_udp_encap_recv() whatever number of times.
>>
>> So, we can end up with this scenario:
>>
>>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>>      ovpn_peer_release_p2p
>>        ovpn_peer_del_p2p
>>          ovpn_peer_put
>>            ovpn_peer_release_kref
>>              ovpn_peer_release
>>                ovpn_socket_put
>>                  ovpn_socket_release_kref
>>                    ovpn_socket_schedule_release
>>                      schedule_work(&sock->work)
>>    netdev_run_todo
>>      rcu_barrier
>>      free_netdev
>>
>>    ovpn_udp_encap_recv  <- called for an incoming UDP packet
>>      ovpn_from_udp_sock <- returns pointer to freed memory
>>      // Any access to ovpn pointer is the use-after-free
>>
>>    ovpn_socket_release_work  <- kernel finally ivoke the work
>>      ovpn_socket_detach
>>        ovpn_udp_socket_detach
>>          setup_udp_tunnel_sock
>>
>> To address the issue, I see two possible solutions:
>> 1. flush the workqueue somewhere before the netdev release
> 
> yes! This is what I was missing. This will also solve the "how can the 
> module wait for all workers to be done before unloading?"
> 

Actually there might be even a simpler solution: each ovpn_socket will 
hold a reference to an ovpn_peer (TCP) or to an ovpn_priv (UDP).
I can simply increase the refcounter those objects while they are 
referenced by the socket and decrease it when the socket is fully 
released (in the detach() function called by the worker).

This way the netdev cannot be released until all socket (and all peers) 
are gone.

This approach doesn't require any local workqueue or any other special 
coordination as we'll just force the whole cleanup to happen in a 
specific order.

Does it make sense?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


