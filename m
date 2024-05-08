Return-Path: <netdev+bounces-94721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD68C05C6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F18B237F7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268A130E26;
	Wed,  8 May 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K4aX1RTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEC130AE6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200667; cv=none; b=qbmFNq72N4omTCfz3y9oFZkf4TVJvXOWMbIKrQcQGB+4qCEK62wCeP1rz7+1WTL7Wu/3pl/f2wXi7Vcvw+iHdNLUQK4mcOeEgCtsQBZTzihhQ10BxjpFg7qyJQ/sqS+HPOO1n7GMDFlV/Z6oyTSy7YO6KMNYDv5ZkDf21NOfjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200667; c=relaxed/simple;
	bh=ARGo5B6mYR0vPyVPzD8aCmMiohucz5IdP6S52yB07eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7LpkL+kG0P6dVbcHtVjE2L8mB7fuQw9DC/BKrtfpzjIU6YDSnBGDfyUuutOe4H6+escLeEUHRujrfeOiTh1CTYP95++GSzSIpTctmLr1PhI0ife4aW1hKc3t0KJ4dO5/0Tio/0OhQ8TUzyUt8UNU/j41ljOKskSOG0QRyUSR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K4aX1RTR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so1419005e9.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715200663; x=1715805463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=erKmHJws6QFwOQMaAykU3noRCvSnAm9zneakrCCgE+w=;
        b=K4aX1RTRqjnq8MkepF40ccKypW0ztyVemT+tTo6thY/jMyXnAD1FT4Urr7slV8MTtW
         XQXWcNy477oKFOf0NqyEiq6sdNAoCgZkiGbpkdzUp0nAYV9u6PBcqByi5q2kAKh21f+8
         7/ez5hD5b7Ss2noZCMuafAs0grrKzhorGcb+aZ+JegmxWGuEMa1qEeaS0HnBxcW3+naB
         axDj2MSHDbs4+7fZR1OahO6Yn6zYshSBb17A1BsxlfS1pQaJQYqSeXDUIT7+aXHqQN2q
         YHcP8Cre/Jl2yj1dT6xT7UU4mc6bYY7Mcw/RzywvxVZUbOErIc0knpEVq+obTFkp5/4W
         7S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715200663; x=1715805463;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erKmHJws6QFwOQMaAykU3noRCvSnAm9zneakrCCgE+w=;
        b=rdJ76tgd9nMh5TwB47zwq5vHxNa/Ex+j5NH2bM8keV1bePO8kO/NE/7kU6rDd4//fY
         gEjz3ygm17PMwKsvwWL8aGuld7Y0a5rxZIfjcpkhVT0BfhMJxBSt6KyLR7QvEz5/9Cs0
         W328WnMlMGczvht/NzHJoeUpJRAXB31L6g2pcutncScVNEPbZj+KSJonV9jmDkVicJex
         AeaVwyQ5grx/uYgQ+Ak6rueAp1GkQJ78KZQFt31CrOjquDlEm6iHFiyQUiPybCpA+N8W
         NS9Y3GgZjbcsU1+BdPmF/n+xW9lO0bhA1i6v6CkAYOa5fB0SFgQnEfwCDP0oRWOeq5P8
         kGNQ==
X-Gm-Message-State: AOJu0YxDb+ao6u1IsjplYGFdAI5cI/PE3SJ6Qyq65dVcpMBhbSf8XcFT
	4HrsK9y04QBUkuizmL8Usb5DRXYF3lIZGxSSwWmvirCcQNI50ycTPKCs03atPL8=
X-Google-Smtp-Source: AGHT+IHzCM+9L0dFHg8qbqaZiJRrUJeFyWC8eI1vkHFpqKiAw1OBF1WsNqbR2GgPyCYGqbPO+LWFHw==
X-Received: by 2002:a05:600c:1396:b0:419:d841:d318 with SMTP id 5b1f17b1804b1-41f719d61f0mr30605395e9.29.1715200663317;
        Wed, 08 May 2024 13:37:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:bde3:ac66:2f53:6468? ([2001:67c:2fbc:0:bde3:ac66:2f53:6468])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b0041892857924sm3422519wmq.36.2024.05.08.13.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 13:37:42 -0700 (PDT)
Message-ID: <53dc5388-630f-47e1-a6c1-6c3bb91ee2ac@openvpn.net>
Date: Wed, 8 May 2024 22:38:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/24] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-9-antonio@openvpn.net> <ZjuyIOK6BY3r9YCI@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EY5uLRwEIAME8xlSi3VYmrBJBcWB1ALDxcOqo+IQFcRR+hLVHGH/f4u9a8yUd
 BtlgZicNthCMA0keGtSYGSxJha80LakG3zyKc2uvD3rLRGnZCXfmFK+WPHZ67x2Uk0MZY/fO
 FsaMeLqi6OE9X3VL9o9rwlZuet/fA5BP7G7v0XUwc3C7Qg1yjOvcMYl1Kpf5/qD4ZTDWZoDT
 cwJ7OTcHVrFwi05BX90WNdoXuKqLKPGw+foy/XhNT/iYyuGuv5a7a1am+28KVa+Ls97yLmrq
 Zx+Zb444FCf3eTotsawnFUNwm8Vj4mGUcb+wjs7K4sfhae4WTTFKXi481/C4CwsTvKpaMq+D
 VosAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJjm4tHAhsMBQkCx+oA
 AAoJEEjwzLaPWdFMv4AP/2aoAQUOnGR8prCPTt6AYdPO2tsOlCJx/2xzalEb4O6s3kKgVgjK
 WInWSeuUXJxZigmg4mum4RTjZuAimDqEeG87xRX9wFQKALzzmi3KHlTJaVmcPJ1pZOFisPS3
 iB2JMhQZ+VXOb8cJ1hFaO3CfH129dn/SLbkHKL9reH5HKu03LQ2Fo7d1bdzjmnfvfFQptXZx
 DIszv/KHIhu32tjSfCYbGciH9NoQc18m9sCdTLuZoViL3vDSk7reDPuOdLVqD89kdc4YNJz6
 tpaYf/KEeG7i1l8EqrZeP2uKs4riuxi7ZtxskPtVfgOlgFKaeoXt/budjNLdG7tWyJJFejC4
 NlvX/BTsH72DT4sagU4roDGGF9pDvZbyKC/TpmIFHDvbqe+S+aQ/NmzVRPsi6uW4WGfFdwMj
 5QeJr3mzFACBLKfisPg/sl748TRXKuqyC5lM4/zVNNDqgn+DtN5DdiU1y/1Rmh7VQOBQKzY8
 6OiQNQ95j13w2k+N+aQh4wRKyo11+9zwsEtZ8Rkp9C06yvPpkFUcU2WuqhmrTxD9xXXszhUI
 ify06RjcfKmutBiS7jNrNWDK7nOpAP4zMYxYTD9DP03i1MqmJjR9hD+RhBiB63Rsh/UqZ8iN
 VL3XJZMQ2E9SfVWyWYLTfb0Q8c4zhhtKwyOr6wvpEpkCH6uevqKx4YC5
Organization: OpenVPN Inc.
In-Reply-To: <ZjuyIOK6BY3r9YCI@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 19:10, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:21 +0200, Antonio Quartulli wrote:
>> This specific structure is used in the ovpn kernel module
>> to wrap and carry around a standard kernel socket.
>>
>> ovpn takes ownership of passed sockets and therefore an ovpn
>> specific objects is attathced to them for status tracking
> 
> typos:      object    attached

thanks

> 
> 
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> new file mode 100644
>> index 000000000000..a4a4d69162f0
>> --- /dev/null
>> +++ b/drivers/net/ovpn/socket.c
> [...]
>> +
>> +/* Finalize release of socket, called after RCU grace period */
> 
> kref_put seems to call ovpn_socket_release_kref without waiting, and
> then that calls ovpn_socket_detach immediately as well. Am I missing
> something?

hmm what do we need to wait for exactly? (Maybe I am missing something)
The ovpn_socket will survive a bit longer thanks to kfree_rcu.

> 
>> +static void ovpn_socket_detach(struct socket *sock)
>> +{
>> +	if (!sock)
>> +		return;
>> +
>> +	sockfd_put(sock);
>> +}
> 
> [...]
>> +
>> +/* Finalize release of socket, called after RCU grace period */
> 
> Did that comment get misplaced? It doesn't match the code.

yeah it did. wiping it.

> 
>> +static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>> +{
>> +	int ret = -EOPNOTSUPP;
>> +
>> +	if (!sock || !peer)
>> +		return -EINVAL;
>> +
>> +	if (sock->sk->sk_protocol == IPPROTO_UDP)
>> +		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
>> +
>> +	return ret;
>> +}
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> new file mode 100644
>> index 000000000000..4b7d96a13df0
>> --- /dev/null
>> +++ b/drivers/net/ovpn/udp.c
> [...]
>> +
>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>> +{
>> +	struct ovpn_socket *old_data;
>> +
>> +	/* sanity check */
>> +	if (sock->sk->sk_protocol != IPPROTO_UDP) {
>> +		netdev_err(ovpn->dev, "%s: expected UDP socket\n", __func__);
> 
> Maybe use DEBUG_NET_WARN_ON_ONCE here since it's never expected to
> actually happen? That would help track down (in test/debug setups) how
> we ended up here.

will do, thanks for the suggestion

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* make sure no pre-existing encapsulation handler exists */
>> +	rcu_read_lock();
>> +	old_data = rcu_dereference_sk_user_data(sock->sk);
>> +	rcu_read_unlock();
>> +	if (old_data) {
>> +		if (old_data->ovpn == ovpn) {
> 
> You should stay under rcu_read_unlock if you access old_data's fields.

My assumption was: if we have an ovpn object in the user data, it means 
that its reference counter was increased to account for this usage.

But I presume we have no guarantee that it won't be decreased while 
outside of the rcu read lock area.

Will move the check inside.

> 
>> +			netdev_dbg(ovpn->dev,
>> +				   "%s: provided socket already owned by this interface\n",
>> +				   __func__);
>> +			return -EALREADY;
>> +		}
>> +
>> +		netdev_err(ovpn->dev, "%s: provided socket already taken by other user\n",
>> +			   __func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
> 

Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

