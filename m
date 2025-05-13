Return-Path: <netdev+bounces-190018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96320AB4F8B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975B41B43D80
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A381DD873;
	Tue, 13 May 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J3NhAnbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978A202C49
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127977; cv=none; b=oyOf8O3I8q4xNwMKHrSMEOPJiTYgvwcxiARblmMsa79ugxsdT+zd6qYxHvS3A+MY1b1S/EsddoVcQ6D3ZgFlZSDpIkT6Wg6c2rPSArvULNCbm8vz0+BCzwTyxjjXNzkWBtrHhlHSYgIE3U2UdPCLHu1CU1nnmuTaL9NNYFoJC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127977; c=relaxed/simple;
	bh=m9MHo5UCZphRSUTKeA4/Y6oDRM+5UIaT8FDg8TnsRNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7b2WrNlINQ/sngB4gSbZYwRx4SMTpEnx3RaMWp6fKLDgqcmI/JtnuH8x9D9UQId2GfEC6rDeOvhS97GtXJiMi/ZN3jv6NzX+PvEYInfdhIdP66gRiJNvpf4h56EzXfDuD0EQ4uHSoT0LSEQq2jW8q3RwnpxkmjlHnAJonNLoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J3NhAnbW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so7123413a12.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747127971; x=1747732771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EPEYZwkTfxyjaMy2CKQIkyd5TrNpWWm2D55UjglHgWk=;
        b=J3NhAnbWwwQvgkeY9VmmeJ+SHOBmkoOagH/kEXhjXlqSKsZB5blyccOSQ364hzkbQK
         0nUqQNNhDGOK8D3UZpxKzR3x3ESAiY4ecy77PcHjBaLs+cR3R22WidX843IKcTEsIu+P
         ZqkjAuE7ljA18YizJoFVg1w9DYly4s6IFofL8AV6NdLcOaQXnIArHizhs7aoO8O5uueS
         BN1vvKyKrUuPTWGTValhVtj59WkAxwqULQaBHOnZQ+7OplcrqBppOqtro4IV7EN19Kia
         RPRIH4R4hIpkLqDcpGZB5+XS35cX8xDEKP4CQB7VKo9SOYBHVWf3jWLe8JAbXjT7HSol
         M/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127971; x=1747732771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPEYZwkTfxyjaMy2CKQIkyd5TrNpWWm2D55UjglHgWk=;
        b=eIXQLpM/EjeaFQQjGkD7x3GkdAqRjbeIplDF9WkuANm/ddIlRxpVvaQt8tVD060LYS
         NFTuK2mfv8yBZrFL//4g1u6G3cy23Avem7PN7Rg+FKMT11Zd8JqDnZbGdISsTU/uQrfv
         BiYvdTRbjSe7Ihpl8Me14wHhinCYvTaUcE2qm15KHCwXGr1uWRQU2VwKS4s8kMZYNFvN
         PTu5ngE1eJWYWTCvgzmcyRjyfkrEmHPIeQM8L8SD3u/87M5nOnHn/rgRh7ygeAnkJiFl
         735XileqWCcxky8PNZ8jg6yAXCkdZq6ijM1BCXc9RYpdYT3fEH45nmUAYrTJGZCn7Hp+
         iiLg==
X-Gm-Message-State: AOJu0YwNgXr91QGUisrqP0pfSMxhthncV4Dj/2Ca1F7FaC18vrStXB5M
	7BkGPZtKrJLxp+hQ1ohTcpWdCVnwzLvvatFS3YOMJ5zkEsY1pU9Z5Jyb4PRv+/PBWpuRUR+Il4p
	gdI6Rnlq5ceWXGXMR+eORrCVzkMtvSJo5q25ZFO0UKdE2dko=
X-Gm-Gg: ASbGncs/rUKZCdSI3XQFLpl5eF05EwcWED21vAQy4ghyT7R3zoFfQUIlJsc25iNQYKM
	5eLHv1th+Dz9aH/kKybmgOhzQcpxRuUIxzEJ+4J0BENv5K/+Mx9qe4qb8KcultartKmgicsevOB
	i72pyxZT9jzopHzct2MuTWfCa6/6ny0kXpsnn9XXsDH2VDuLIFrL15JUd3uvkKxFwn8cX/dhiyx
	oGLkqcYWnm5bDd7oW61+hq5xHuLDKLOLMGQf2vV8D7+LHspLY4F9IbtddPOr9NreaQxzsqk9UjS
	bcKQ3ifxkgzke+wSlFLfme4Tu9OaOdRO+WBE8qE+MdpXHCesuDvuSSExK37rOg1cQ+x2MFuoC9g
	PU16ahMExnk5WiQ==
X-Google-Smtp-Source: AGHT+IGT/iy6ZgZMq8go3g7odZx4CUA6zREZ/s7B6/Y+Jr6oaa4LFyhu76VNV5LykjZ1KjFse+zU8Q==
X-Received: by 2002:a05:6402:4404:b0:5fa:abfb:1bfd with SMTP id 4fb4d7f45d1cf-5fca0742844mr14082946a12.1.1747127971422;
        Tue, 13 May 2025 02:19:31 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700590sm7159387a12.59.2025.05.13.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:19:30 -0700 (PDT)
Message-ID: <f0d7cbd7-6bc2-4034-b912-17c3a1959021@openvpn.net>
Date: Tue, 13 May 2025 11:19:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] ovpn: ensure sk is still valid during
 cleanup
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Al Viro <viro@zeniv.linux.org.uk>,
 Qingfang Deng <dqfext@gmail.com>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-11-antonio@openvpn.net>
 <20250512183742.28fad543@kernel.org>
 <1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 10:21, Paolo Abeni wrote:
> 
> 
> On 5/13/25 3:37 AM, Jakub Kicinski wrote:
>> On Fri,  9 May 2025 16:26:20 +0200 Antonio Quartulli wrote:
>>> In case of UDP peer timeout, an openvpn client (userspace)
>>> performs the following actions:
>>> 1. receives the peer deletion notification (reason=timeout)
>>> 2. closes the socket
>>>
>>> Upon 1. we have the following:
>>> - ovpn_peer_keepalive_work()
>>>   - ovpn_socket_release()
>>>    - synchronize_rcu()
>>> At this point, 2. gets a chance to complete and ovpn_sock->sock->sk
>>> becomes NULL. ovpn_socket_release() will then attempt dereferencing it,
>>> resulting in the following crash log:
>>
>> What runs where is a bit unclear to me. Specifically I'm not sure what
>> runs the code under the "if (released)" branch of ovpn_socket_release()
>> if the user closes the socket. Because you now return without a WARN().
>>
>>> @@ -75,13 +76,14 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>>>   	if (!sock)
>>>   		return;
>>>   
>>> -	/* sanity check: we should not end up here if the socket
>>> -	 * was already closed
>>> +	/* sock->sk may be released concurrently, therefore we
>>> +	 * first attempt grabbing a reference.
>>> +	 * if sock->sk is NULL it means it is already being
>>> +	 * destroyed and we don't need any further cleanup
>>>   	 */
>>> -	if (!sock->sock->sk) {
>>> -		DEBUG_NET_WARN_ON_ONCE(1);
>>> +	sk = sock->sock->sk;
>>> +	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
>>
>> How is sk protected from getting reused here?
>> refcount_inc_not_zero() still needs the underlying object to be allocated.
>> I don't see any locking here, and code says this function may sleep so
>> it can't be called under RCU, either.
> 
> I agree this still looks racy. When the socket close runs, nobody else
> should have access/reference to the 'struct socket'. I'm under the
> impression that ovpn_socket should acquire references to the underlying
> fd instead of keeping its own refcount.

This is what we were originally doing, but since the socket is not a 
"kernel socket", increasing the refcount was preventing us from 
understanding when the socket was supposed to be destroyed (because ovpn 
itself was still holding a ref).
Hence we switched to this model where we get notified about the socket 
going away via close()/destroy() call.


I think ovpn_socket should coordinate access to its sock member and 
nullify it during destroy (which is invoked by sk_common_release()).
At that point no other part of the code will have a chance to access it.

I am gonna play with this idea right now.


> 
> Side note: the ovpn_socket refcount release/detach path looks wrong, at
> least in case of an UDP socket, as ovpn_udp_socket_detach() calls
> setup_udp_tunnel_sock() which in turns will try to _increment_ various
> core counters, instead of decreasing them (i.e. udp_encap_enable should
> be wrongly accounted after that call).

You're right.
I had the impression I needed to "undo" the setup.
I see now that the encap key is decremented in the UDP sock destroy, 
right after having called my implementation of .destroy().

I'll drop the call to setup_udp_tunnel_sock() with empty config then.

Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


