Return-Path: <netdev+bounces-77954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7D8739A4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1493928B8E5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AD1339B1;
	Wed,  6 Mar 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ANYLTNZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97E5DF1D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736377; cv=none; b=mssK/tqAzqnO+vb0B7JVvDc/kwEcG26duVAue/WOqGJY+njod6/6X8izzKGGJOXJ4QA/0nB/TK2yCnnQKZuRpZb1AiFFPw4r5Oa1gkWexF7zsr4/fr0dFnywC8tFffCdmsOrjaouQuazA5HT21bATSwEQM+slC+zsk8XjHLRq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736377; c=relaxed/simple;
	bh=x1g8CRg5ZP2oPYuh6l6iaPk785Bx8PyvlE4j0F6BIEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQv3Ol2YA7uQEUx/q4l8B7QolrHKgEhSPdLlxkOsH5opCQXK/6dYtipxk7LfHABOPKd0o+n7YHeMNCzZgEuPEQqzFPBb6uDWqRbkOhwnnT8m+Supx1RaBiRwIC9akk5heW/PknMXmN7F2NPU/v3F6YuijL5RoFEJRnWd1KpsikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ANYLTNZA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so626738766b.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709736374; x=1710341174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ3d7mMxfWIzmAZbNNa07Jib2v/50l4cdmqja+fJORo=;
        b=ANYLTNZAOY5WgkAwaRaSCNImuy14g0RRUop34d/VJ9Ji5oB1llZmnKupEJr9JKTjeY
         7HAYEUQcjRjKbwbJg4pjRDUVVv5LWUQsKl94jLFSMnC5RYVBHhhSZdHs5yNvF/bNsi+Z
         OKZntutVCei5bTHzj4tFQSP4Nqr+4jQBdSVTp75tpCjWpb+vU9ccFBpFN1zN8kqfjByc
         P6ruNOejsk5tJkyiEn7EOFuCPPulFF8ds8pblph5wXBLBK81jOFqmZU2fxZVq9n6kHz+
         eeXU2fnvUIR8RDv5Au+Z3k90QJaRzYWaF8bevR8RNh16JSikmf1krnf/tzhaGjOm0C8J
         zucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736374; x=1710341174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ3d7mMxfWIzmAZbNNa07Jib2v/50l4cdmqja+fJORo=;
        b=ipczecRN2P9MsDuqyXqNEeJPNS/szfzw+8fBZ9mBcdtg7VDEm0t7kAOAwTt31DKyZ+
         wB75Aa2cAWk5jhwRJmGuRalGWwKH/2OfnjuRdDUQQsiNpxqpCtA/3pZ9tEWkawd8Eogi
         Guhax4GCiQCSLoR4A1N9EuLSCns0P0tojLqZ+AkKzKSBnl8FH/hSjL1pMFGO39zw+7Id
         FyQutdUps03u5Ip3dMocXSDWKbPIBGxjE5dI5wE7ZqQEIh+B4OM5YBEp9pIrjGuWtx0H
         52yFRWE9ZjgdQe6yY4J94ODUg4goIg8j6psnVM6kf0BY/BliHYuSUkSJgynah6JnevyG
         k/0Q==
X-Gm-Message-State: AOJu0Yy7e2SPQAZAmft952jZ6HWYUK6u19b9kuTEzwGWqZ5vvmEJQaIf
	3RaQJO+2d7uCkDCH3op31u2IepXkN/7RQofT9KBai9R0CqQTSFSYey3G5d+VaL4=
X-Google-Smtp-Source: AGHT+IEtge1SXO9kf51veA2+IwvN/OcKtfGj6cLvWExSXgYyIjbelYAw0hMfjzlvQORBvNwTCglQdQ==
X-Received: by 2002:a17:906:c7c3:b0:a3f:1b49:c92b with SMTP id dc3-20020a170906c7c300b00a3f1b49c92bmr11307041ejb.48.1709736373372;
        Wed, 06 Mar 2024 06:46:13 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906841600b00a449026672esm6011922ejx.81.2024.03.06.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 06:46:12 -0800 (PST)
Message-ID: <5f7f088c-426a-493b-9840-02f3003a7381@openvpn.net>
Date: Wed, 6 Mar 2024 15:46:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
 <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
 <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
 <d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
 <20240305113900.5ed37041@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240305113900.5ed37041@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 20:39, Jakub Kicinski wrote:
> On Tue, 5 Mar 2024 17:23:25 +0100 Andrew Lunn wrote:
>>>>> +static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>>>>> +			 struct genl_info *info)
>>>>> +{
>>>>> +	struct net *net = genl_info_net(info);
>>>>> +	struct net_device *dev;
>>>>> +
>>>>> +	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
>>>>> +	 * just expects an IFNAME, while all the others expect an IFINDEX
>>>>> +	 */
>>>>
>>>> Could you explain that some more. In general, the name should not
>>>> matter to the kernel, udev/systemd might rename it soon after creation
>>>> etc. If it gets moved into a network namespace it might need renaming
>>>> etc.
>>>
>>> In a previous discussion it was agreed that we should create ovpn interfaces
>>> via GENL and not via RTNL.
>>>
>>> For this reason ovpn needs userspace to send the name to give the interface
>>> upon creation. This name is just passed to the networking stack upon
>>> creation/registration, but it is not stored anywhere else.
>>>
>>> Subsequent netlink calls are then all performed by passing an ifindex.
>>>
>>> Hence, OVPN_CMD_NEW_IFACE is the only GENL command that required the IFNAME
>>> to be specified.
>>
>> I don't really see why GENL vs RTNL makes a difference. The reply to
>> the request can contain the ifindex of the newly created interface. If
>> you set the name to "ovpn%d" before calling register_netdevice() the
>> kernel will find the next free unique ovpn interface name, race
>> free. So you could have multiple openvpn daemon running, and not have
>> to worry about races when creating interfaces.
>>
>> Jakub has been raising questions about this recently for another
>> patchset. He might comment on this.
> 
> FWIW using ifindex for most ops sounds like the right way to go.
> Passing the name to create sounds fine, but as Andrew said, we
> should default to "ovpn%d" instead of forcing the user to specify
> the name (and you can echo back the allocated name in the reply
> to OVPN_CMD_NEW_IFACE).
> 

Ok, it definitely makes sense and actually makes userspace code simpler.


> Somewhat related - if you require an attr - GENL_REQ_ATTR_CHECK(),
> it does the extact setting for you.

ok, will check it out!

> 
>>>>> +	OVPN_A_PEER_VPN_RX_BYTES,
>>>>> +	OVPN_A_PEER_VPN_TX_BYTES,
>>>>> +	OVPN_A_PEER_VPN_RX_PACKETS,
>>>>> +	OVPN_A_PEER_VPN_TX_PACKETS,
>>>>> +	OVPN_A_PEER_LINK_RX_BYTES,
>>>>> +	OVPN_A_PEER_LINK_TX_BYTES,
>>>>> +	OVPN_A_PEER_LINK_RX_PACKETS,
>>>>> +	OVPN_A_PEER_LINK_TX_PACKETS,
>>>>
>>>> How do these differ to standard network statistics? e.g. what is in
>>>> /sys/class/net/*/statistics/ ?
>>>
>>> The first difference is that these stats are per-peer and not per-device.
>>> Behind each device there might be multiple peers connected.
>>>
>>> This way ovpn is able to tell how much data was sent/received by every
>>> single connected peer.
>>>
>>> LINK and VPN store different values.
>>> LINK stats are recorded at the transport layer (before decapsulation or
>>> after encapsulation), while VPN stats are recorded at the tunnel layer
>>> (after decapsulation or before encapsulation).
>>>
>>> I didn't see how to convey the same information using the standard
>>> statistics.
>>
>> Right, so this in general makes sense. The only question i have now
>> is, should you be using rtnl_link_stats64. That is the standard
>> structure for interface statistics.

@Andrew: do you see how I could return/send this object per-peer to 
userspace?
I think the whole interface stats logic is based on the 
one-stats-per-device concept. Hence, I thought it was meaningful to just 
send my own stats via netlink.

>>
>> Again, Jakub likes to comment about statistics...
>>
>> And in general, maybe add more comments. This is the UAPI, it needs to
>> be clear and unambiguous. Documentation/networking/ethtool-netlink.rst.
> 
> Or put enough docs in the YAML spec as those comments get rendered in
> the uAPI header and in HTML docs :)

Or I'll do both. In any case, I will add more documentation!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

