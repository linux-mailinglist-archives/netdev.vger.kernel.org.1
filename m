Return-Path: <netdev+bounces-77564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E6872312
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43749B20E87
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B61272DC;
	Tue,  5 Mar 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Orf1j3Vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692E8595F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653612; cv=none; b=M8qIDlBVz7UchTKJ1+DUKJ5Ft65C/PJ7pVSy9vBYHo8m4qSJW20vq3QhEU00ZXqKjmb9ZU2AUPsR+PpIuNKMwP3lwpyd2911glcNo605w3wTDzIDjUe730Oh6c4lUhu2n9sPzw50zti2Jzx5Jjc2ON7VRKCygkXC2oGHk1mNmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653612; c=relaxed/simple;
	bh=QxWb2UAPgjCHAYTGXe6Lpj4UV5UgEnVvtQObX9u8xVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWLr5aWbhGzSNNut9gYeWxYH1/GS4gTZsTeH/MXsHSaE0+4h6FSYo8KTdHT4wIvUZAO6jaQnQUPJ20NvUzUAF3j/ol7MxrEeJ3VbayRgrATe44uBNNsGUby3G6QxFhVlS/sUzdhtz7qItaKpxLW8Sm+EA2YT/oThfvrCUBjPm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Orf1j3Vv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so8153579a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709653608; x=1710258408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KTgpvNV1g+DhCYFo1yp9gYxMdPtAeq0mhK4Rj1a7IWU=;
        b=Orf1j3Vvy6Hn+rvumotcJa/qq0Lg3QMThuB6T0iAleVQA1nh5bipRHqTy3XWlALcnl
         EBbo3QI6dpYNt9iOEGmiZ/VBRz3f9KhgpKOlA7Z63bYSEgDzPqjlmFktQbW0txYp7Z1+
         djPRm39z8eSHv8V0DXeBeDCU2BO6vrddICihZW+S9xLyYsVwgsH5EaGZ/POy3UUqgBTj
         BAQCA7JO89F+DK2A7yf3WIn3R2LEBycpa5/CzUwmfuvBfdMEJUB5OnjyDha3a+raUpi0
         EkybJ8gG6/Asl9jv8jBJxN0ryelxqfHqMaY12QfEcZlS7n7vnk4Ds97q5ugHFshQzIOJ
         ZrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653608; x=1710258408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTgpvNV1g+DhCYFo1yp9gYxMdPtAeq0mhK4Rj1a7IWU=;
        b=ZU2AyUluXeC22khz8NrtbHtK83WpHGAgotAosPlIRVm8jxgc871f6sxTUdg2z+U6NZ
         QzkAuDChg3JO/lEbeq48HOcEQH5Ui9ad7SyDmMDVyWJHcFKiGPL7rsLlW+l/JzGNHVjf
         LETjAOpUlqn9HupsRM8Mjm1zMnPJgSbYaP0y6613PW6LZnZxm7bI5uezxa7DRUpK8opF
         1Os0Bkdg0eJYlwMYf5jJqObig/LQ00EkfJJ2H/dsUABWdhCoGl/18XYM/0CT8Tc0Q5Kw
         IQvW3lpj5keys12R0kpK38BTfNEVihaLWwq5vpsK/4AGbZh52Fef7AEWWc+MXbmMHD6Z
         ZHrA==
X-Gm-Message-State: AOJu0Yy7Z7LeRU/h5+8iMN7ujFBLR7HDjIJmVkUlKQ2cVkmqZPnf8gon
	3VQ3BeK9TrRxXVXJnW0Rv5QWcaQWlswsHAXjEYNfWAASZnBWi6vlD0mvuGlhQRO4iXFlOFFYJMQ
	a
X-Google-Smtp-Source: AGHT+IG6ipOFG6O/NT3V7nUY/hpGbN2qlxUyIGLzlt9S6yALUBxMc5vD9U4cw1r/K0WUAb94bhUyoQ==
X-Received: by 2002:a17:906:e084:b0:a44:5589:1183 with SMTP id gh4-20020a170906e08400b00a4455891183mr8014072ejb.34.1709653608506;
        Tue, 05 Mar 2024 07:46:48 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:f33:beb3:62e8:b7a? ([2001:67c:2fbc:0:f33:beb3:62e8:b7a])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a449cb924dbsm4827392ejb.124.2024.03.05.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:46:46 -0800 (PST)
Message-ID: <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
Date: Tue, 5 Mar 2024 16:47:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
 <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2024 22:20, Andrew Lunn wrote:
> On Mon, Mar 04, 2024 at 04:08:54PM +0100, Antonio Quartulli wrote:
>> This commit introduces basic netlink support with
>> registration/unregistration functionalities and stub pre/post-doit.
>>
>> More importantly it introduces the UAPI header file that contains
>> the attributes that are inteded to be used by the netlink API
> 
> intended.
> 
>> implementation.
>>
>> For convience, packet.h is also added containing some macros about
>> the OpenVPN packet format.
>>
>> +/** KEYDIR policy. Can be used for configuring an encryption and a decryption key */
>> +static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
>> +	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
> 
> I don't know netlink that well. Is this saying keys are limited to 256
> bytes? How future proof is that? I'm not a crypto person, but
> symmetric algorithms, e.g. AES, seem to have reasonably short keys, 32
> bytes, so this seems O.K, to me.

256 bytes should be reasonably large. I don't see anything beyond this 
size appearing anytime soon or at all.

> 
>> +	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(NONCE_TAIL_SIZE),
>> +};
>> +
>> +/** KEYCONF policy */
>> +static const struct nla_policy ovpn_nl_policy_keyconf[NUM_OVPN_A_KEYCONF] = {
>> +	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_RANGE(NLA_U8, __OVPN_KEY_SLOT_FIRST,
>> +						 NUM_OVPN_KEY_SLOT - 1),
>> +	[OVPN_A_KEYCONF_KEY_ID] = { .type = NLA_U8 },
> 
> Is that 256 keys globally, or just associated to one session?

This is specific to one peer, however, the OpenVPN protocol uses IDs up 
7, therefore U8 is just the smallest unit I could use to fit those few 
values.

> 
>> +	[OVPN_A_KEYCONF_CIPHER_ALG] = { .type = NLA_U16 },
>> +	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
>> +	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
>> +};
>> +
> 
>> +/** Generic message container policy */
>> +static const struct nla_policy ovpn_nl_policy[NUM_OVPN_A] = {
>> +	[OVPN_A_IFINDEX] = { .type = NLA_U32 },
>> +	[OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),
> 
> Generally, ifnames are not passed around, only ifindex. An interface
> can have multiple names:
> 
> 12: enlr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq master br0 state DOWN group default qlen 1000
>      link/ether 3c:ec:ef:7e:0a:90 brd ff:ff:ff:ff:ff:ff
>      altname enp183s0f2
>      altname eno7
> 
> It is better to let userspace figure out the name from the index,
> since the name is mostly a user space concept.

This is strictly related to your next question.
Please see my answer below.

> 
>> +	[OVPN_A_MODE] = NLA_POLICY_RANGE(NLA_U8, __OVPN_MODE_FIRST,
>> +					 NUM_OVPN_MODE - 1),
>> +	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_nl_policy_peer),
>> +};
> 
>> +static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>> +			 struct genl_info *info)
>> +{
>> +	struct net *net = genl_info_net(info);
>> +	struct net_device *dev;
>> +
>> +	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
>> +	 * just expects an IFNAME, while all the others expect an IFINDEX
>> +	 */
> 
> Could you explain that some more. In general, the name should not
> matter to the kernel, udev/systemd might rename it soon after creation
> etc. If it gets moved into a network namespace it might need renaming
> etc.

In a previous discussion it was agreed that we should create ovpn 
interfaces via GENL and not via RTNL.

For this reason ovpn needs userspace to send the name to give the 
interface upon creation. This name is just passed to the networking 
stack upon creation/registration, but it is not stored anywhere else.

Subsequent netlink calls are then all performed by passing an ifindex.

Hence, OVPN_CMD_NEW_IFACE is the only GENL command that required the 
IFNAME to be specified.

Does it make sense?


> 
>> +enum ovpn_nl_peer_attrs {
>> +	OVPN_A_PEER_UNSPEC = 0,
>> +	OVPN_A_PEER_ID,
>> +	OVPN_A_PEER_RX_STATS,
>> +	OVPN_A_PEER_TX_STATS,
> 
> Probably answered later in the patch series: What sort of statistics
> do you expect here. Don't overlap any of the normal network statistics
> with this here, please use the existing kAPIs for those. Anything you
> return here need to be very specific to ovpn.

Actually you found a leftover from an old approach.
OVPN_A_PEER_RX_STATS and OVPN_A_PEER_TX_STATS shall be removed.

The actual stats we store are those below:

> 
>> +	OVPN_A_PEER_VPN_RX_BYTES,
>> +	OVPN_A_PEER_VPN_TX_BYTES,
>> +	OVPN_A_PEER_VPN_RX_PACKETS,
>> +	OVPN_A_PEER_VPN_TX_PACKETS,
>> +	OVPN_A_PEER_LINK_RX_BYTES,
>> +	OVPN_A_PEER_LINK_TX_BYTES,
>> +	OVPN_A_PEER_LINK_RX_PACKETS,
>> +	OVPN_A_PEER_LINK_TX_PACKETS,
> 
> How do these differ to standard network statistics? e.g. what is in
> /sys/class/net/*/statistics/ ?

The first difference is that these stats are per-peer and not 
per-device. Behind each device there might be multiple peers connected.

This way ovpn is able to tell how much data was sent/received by every 
single connected peer.

LINK and VPN store different values.
LINK stats are recorded at the transport layer (before decapsulation or 
after encapsulation), while VPN stats are recorded at the tunnel layer 
(after decapsulation or before encapsulation).

I didn't see how to convey the same information using the standard 
statistics.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

