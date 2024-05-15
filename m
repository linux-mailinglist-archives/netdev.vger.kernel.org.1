Return-Path: <netdev+bounces-96543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC518C6686
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A781C20EA8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269881736;
	Wed, 15 May 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="S4e2Xitr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1C84A46
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777612; cv=none; b=O9zw9r6aL6da7EL1v/0f7kxglksROD4pjLVnIklUjq50KZ3rQTXTnl4ldB0KgGNAaABn0dLYlh1QgEKGPX3xzKNYvQjj7z+H2X5uU+0N1Lt+tbBi+MRT001dzUPyyKx3dMBvhaDQo6dCuHPnKcxhPzacMmOEZN+W7e3Xx9vBMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777612; c=relaxed/simple;
	bh=ebrfLUmJa7BPXFIDiD8p6gSFo4rINyOoIZZDKBzVjwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI/fS2cIV8rBGoQsPC8VeyNhZysHcxSVateJrZSwtFR8n83Ns4iYgIXbGquhgVQ0EY0bZ7RvxQFFwNYQR2fJey1TSgiztqZMAcpXOFl1xQn2a/8BlomiQHCI0e2jLLl+X3ururAApHpxtMcI8BXnT8exJJ/+SQhDvWNQJAqesq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=S4e2Xitr; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so1743249a12.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715777609; x=1716382409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0H1F6DzOQdPqwfC+T7Ts/8jCBWptxIZx1xVD8Z+RTdg=;
        b=S4e2Xitre/qjBWZyNaMvC+nRxSa/zLcSFJDD+3qxkdnLE6gjAWOGKe7llvcpe3oqDk
         UKpWbkEOrNKSV5gyV6Ks/PvTnW+q01cbhzQKrZh4IWIBmvAovyYHyn84RreIkKqO8OBS
         Vvow5JJUS/CGWsBshctSIujABmIh4CnHZuJ2vtbEuDyj80pySf+HUyiTWz4/q9eisz2J
         ateHlxwVv7qI9I6Adb5rL3gMQUyNBzSxAf3n0v4ZOjWXcMHLtwhNCmf8RCCaFLs9Ikbk
         mqT2dSFTZ/ARfBR5BnAB9gTR0mc1g3mwBMQJ/zCzwG548k/X5WY4rNC2JpEuzzbeJIRA
         ssTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777609; x=1716382409;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H1F6DzOQdPqwfC+T7Ts/8jCBWptxIZx1xVD8Z+RTdg=;
        b=nzcBDiiciUnfRwbD5LiibzpnNO89NDOPRIdZpHC5Je6dNWm4HBq6r3hfC/V+pQpXkp
         KWaxphKHXYKFImNTNCayj5FisyRJz0oprO+HVKrgSCoLcaInr0TYL6Jhk8JhSCd3zxlK
         9CTzPHk2g25ZdrmPeT0+aExeSKZbp/J09Jz4sIj2OHCSDHuB8HvH5U7xiqdGSSvlApNm
         SXTkMv68Ds6v0oStl49L1TJJybvzoyUAxrlcDBFu0c23YnSepYgUhzGKNiom0hX351TQ
         ODMvDuKgOARA0l2KDmoV55M8FK9vUSMWDT1RP+XSzMn9LWrZ+Ya2wEjpFqPTdgljho27
         fCEQ==
X-Gm-Message-State: AOJu0YwIjzthvm1VrU7G9hI35FmJVo4Yi3X20vsU+0fE9RrfR69rGXvv
	Tklvam8CYzRvhlS78a/0+ZIWn0zssg6SBrKuwBtkZ34DowLlsv07NQ8COJXT6NM=
X-Google-Smtp-Source: AGHT+IHQA8nalxEHUea6n1xJCr3e535I0XItXlJo9ZwqzSCezm47cSbD4OOqCQcSTTYEk3eFQNoXOw==
X-Received: by 2002:aa7:d3c3:0:b0:573:5c4f:27a8 with SMTP id 4fb4d7f45d1cf-5735c4f27e2mr10459802a12.35.1715777608761;
        Wed, 15 May 2024 05:53:28 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2? ([2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f73a7ee0sm1074541a12.4.2024.05.15.05.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 05:53:28 -0700 (PDT)
Message-ID: <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net>
Date: Wed, 15 May 2024 14:54:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net> <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net> <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net> <ZkSMPeSSS4VZxHrf@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkSMPeSSS4VZxHrf@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2024 12:19, Sabrina Dubroca wrote:
> 2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
>> On 14/05/2024 10:58, Sabrina Dubroca wrote:
>>>>> The UDP code differentiates "socket already owned by this interface"
>>>>> from "already taken by other user". That doesn't apply to TCP?
>>>>
>>>> This makes me wonder: how safe it is to interpret the user data as an object
>>>> of type ovpn_socket?
>>>>
>>>> When we find the user data already assigned, we don't know what was really
>>>> stored in there, right?
>>>> Technically this socket could have gone through another module which
>>>> assigned its own state.
>>>>
>>>> Therefore I think that what UDP does [ dereferencing ((struct ovpn_socket
>>>> *)user_data)->ovpn ] is probably not safe. Would you agree?
>>>
>>> Hmmm, yeah, I think you're right. If you checked encap_type ==
>>> UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
>>> really your data. Basically call ovpn_from_udp_sock during attach if
>>> you want to check something beyond EBUSY.
>>
>> right. Maybe we can leave with simply reporting EBUSY and be done with it,
>> without adding extra checks and what not.
> 
> I don't know. What was the reason for the EALREADY handling in udp.c
> and the corresponding refcount increase in ovpn_socket_new?

it's just me that likes to be verbose when doing error reporting.
But eventually the exact error is ignored and we release the reference. 
 From netlink.c:

342                 peer->sock = ovpn_socket_new(sock, peer);
343                 if (IS_ERR(peer->sock)) {
344                         sockfd_put(sock);
345                         peer->sock = NULL;
346                         ret = -ENOTSOCK;

so no added value in distinguishing the two cases.

> 
> 
>>>>>> +int __init ovpn_tcp_init(void)
>>>>>> +{
>>>>>> +	/* We need to substitute the recvmsg and the sock_is_readable
>>>>>> +	 * callbacks in the sk_prot member of the sock object for TCP
>>>>>> +	 * sockets.
>>>>>> +	 *
>>>>>> +	 * However sock->sk_prot is a pointer to a static variable and
>>>>>> +	 * therefore we can't directly modify it, otherwise every socket
>>>>>> +	 * pointing to it will be affected.
>>>>>> +	 *
>>>>>> +	 * For this reason we create our own static copy and modify what
>>>>>> +	 * we need. Then we make sk_prot point to this copy
>>>>>> +	 * (in ovpn_tcp_socket_attach())
>>>>>> +	 */
>>>>>> +	ovpn_tcp_prot = tcp_prot;
>>>>>
>>>>> Don't you need a separate variant for IPv6, like TLS does?
>>>>
>>>> Never did so far.
>>>>
>>>> My wild wild wild guess: for the time this socket is owned by ovpn, we only
>>>> use callbacks that are IPvX agnostic, hence v4 vs v6 doesn't make any
>>>> difference.
>>>> When this socket is released, we reassigned the original prot.
>>>
>>> That seems a bit suspicious to me. For example, tcpv6_prot has a
>>> different backlog_rcv. And you don't control if the socket is detached
>>> before being closed, or which callbacks are needed. Your userspace
>>> client doesn't use them, but someone else's might.
>>>
>>>>>> +	ovpn_tcp_prot.recvmsg = ovpn_tcp_recvmsg;
>>>>>
>>>>> You don't need to replace ->sendmsg as well? The userspace client is
>>>>> not expected to send messages?
>>>>
>>>> It is, but my assumption is that those packets will just go through the
>>>> socket as usual. No need to be handled by ovpn (those packets are not
>>>> encrypted/decrypted, like data traffic is).
>>>> And this is how it has worked so far.
>>>>
>>>> Makes sense?
>>>
>>> Two things come to mind:
>>>
>>> - userspace is expected to prefix the messages it inserts on the
>>>     stream with the 2-byte length field? otherwise, the peer won't be
>>>     able to parse them out of the stream
>>
>> correct. userspace sends those packets as if ovpn is not running, therefore
>> this happens naturally.
> 
> ok.
> 
> 
>>> - I'm not convinced this would be safe wrt kernel writing partial
>>>     messages. if ovpn_tcp_send_one doesn't send the full message, you
>>>     could interleave two messages:
>>>
>>>     +------+-------------------+------+--------+----------------+
>>>     | len1 | (bytes from msg1) | len2 | (msg2) | (rest of msg1) |
>>>     +------+-------------------+------+--------+----------------+
>>>
>>>     and the RX side would parse that as:
>>>
>>>     +------+-----------------------------------+------+---------
>>>     | len1 | (bytes from msg1) | len2 | (msg2) | ???? | ...
>>>     +------+-------------------+---------------+------+---------
>>>
>>>     and try to interpret some random bytes out of either msg1 or msg2 as
>>>     a length prefix, resulting in a broken stream.
>>
>> hm you are correct. if multiple sendmsg can overlap, then we might be in
>> troubles, but are we sure this can truly happen?
> 
> What would prevent this? The kernel_sendmsg call in ovpn_tcp_send_one
> could send a partial message, and then what would stop userspace from
> sending its own message during the cond_resched from ovpn_tcp_tx_work?

I was under the impression that ovpn_tcp_send_one() would always send an 
entire packet, but this may not be the case. So you're definitely right.

We may end up having interleaving sendmsg from kernelspace and userspace.

> 
>>> The stream format looks identical to ESP in TCP [1] (2B length prefix
>>> followed by the actual message), so I think the espintcp code (both tx
>>> and rx, except for actual protocol parsing) should look very
>>> similar. The problems that need to be solved for both protocols are
>>> pretty much the same.
>>
>> ok, will have a look. maybe this will simplify the code even more and we
>> will get rid of some of the issues we were discussing above.
> 
> I doubt dealing with possible interleaving will make the code simpler,
> but I think it has to be done.

Yap.

Thanks a lot for pointing this out and for the pointers you gave me.

> 

-- 
Antonio Quartulli
OpenVPN Inc.

