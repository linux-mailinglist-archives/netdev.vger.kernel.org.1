Return-Path: <netdev+bounces-77975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB2873AB8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B071F24C83
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79E1353E4;
	Wed,  6 Mar 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Jx3BPlfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBD1353F2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739196; cv=none; b=SgT4wdW/pLWbg90h6Ae4dhkGqMKBfGzHmXFRF5qQFARpqjXEquJyYvesB9pZmFHVHN3fDiNSOwBFw+HqpTOr/YKmkMnjXq5EkibcBpsqizdL9Ej8zHlDw+Bh27x+7W6MdMGPwHZ9P+zB0/UlVnHZNjcbBrUH+Yz7lXW1da4S2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739196; c=relaxed/simple;
	bh=imtkX9gBmdppgELF/cGN76NWkfppQ2dMry/8J2dVZRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWYo/+iqGb0CDw3Bqvi77Bk3wINZDfCDLXQTXvXqXeHpAkI1GHiwEs13AJxbunSKIjYyHwf3mL8n7PwRO3hV88/VgYslu1MmaioX9DgjHjJY3dQacw8AjUz4MAmCe7LmnesmbCnPUG7l+N6WCC6dKUOWiSDJk233OZ9zzNBxnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Jx3BPlfq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1854103a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709739192; x=1710343992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hFchKHynSlo3WjEfCn/qwGa2rnv1jG5UZW8Bbqxs7X8=;
        b=Jx3BPlfqzI9rV1GM7reUlH8VJzoCGxqNjNQ10HL5cSq08SpFaNTkB68SChdH2BXhds
         GqqsRsPasPWbo/Nnpr80qrjsokrEGQ3t+SfUuR1nItaCRhvmwc3x+arpJgP65EDBMPsh
         NjUecGAQwM0ROth2BJt5aZC30UzzaO3Vqfw47fEL301tLzzcRxnlsNDLQymDTk4R2lu9
         QyvAubO5t0pklHFx1D2ul2aAOgXQFu7NCCmZ+QGv54mLQBXK34f6GNaHxPsBx8CfckRl
         UfIBRuZvliij/GPfR/mVgGND2CqYUfgJHStG++4tEPiZnApEBfX2iE41LgwIRpZ/0wuO
         px/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739192; x=1710343992;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFchKHynSlo3WjEfCn/qwGa2rnv1jG5UZW8Bbqxs7X8=;
        b=WeaJObxsLgaaacevzcY7cRlNfEknHcuALDwp09pMjse1er5PlZADlME7h1wsHVxDZn
         +c2Zq/0FU/MB/WTChjjJbitGM0hmLqZjULkV2+Xn35Pr0YcJ7OU85fGvouY51GzPWAJi
         FEwfpUdm4XjjzubK0s0PRGXtCtSDzFfpUlY66tlP87zUUiPiWlZGxcIzOztQF/oBJotG
         y8fWY08vKJmWE7XZHtDs72XfwbRxDqo7qJ5A9KEQuKboDG9BnpFX69q+IDYS/v5q4hQv
         RGTzI4b6saodrS+rAE1izZIMmXob0kosKPNpMrTEypvzsh9QPqPfwrL/k478SwEIZK7B
         /KOA==
X-Gm-Message-State: AOJu0Yzn4NFYC2W/NDxEBa6ft7gWeOWdFSV/XC5UkwGCjdPjGWCHMYIQ
	YL4zIk/w3GRXUOvVS/LNaxAP2T4INgrVVuieGIf5RodiGu/1uFQoTw5oiD6DvUk=
X-Google-Smtp-Source: AGHT+IH1DvdOGRAkbECfCdsfVFIX0+ptC3/JFcuNvRfK10gMOl8eL5nH5Xc0Q+ZO+2VcFG82E2QV0A==
X-Received: by 2002:a17:906:482:b0:a43:ffe1:7d1 with SMTP id f2-20020a170906048200b00a43ffe107d1mr5304445eja.17.1709739192351;
        Wed, 06 Mar 2024 07:33:12 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id br25-20020a170906d15900b00a44fcdf20d1sm4651519ejb.189.2024.03.06.07.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:33:12 -0800 (PST)
Message-ID: <e607c3d1-c096-4ccc-a6d6-40c33840b3df@openvpn.net>
Date: Wed, 6 Mar 2024 16:33:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-15-antonio@openvpn.net>
 <20240305151626.GM2357@kernel.org>
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
In-Reply-To: <20240305151626.GM2357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 16:16, Simon Horman wrote:
> On Mon, Mar 04, 2024 at 04:09:05PM +0100, Antonio Quartulli wrote:
>> In a multi-peer scenario there are a number of situations when a
>> specific peer needs to be looked up.
>>
>> We may want to lookup a peer by:
>> 1. its ID
>> 2. its VPN destination IP
>> 3. its tranport IP/port couple
> 
> nit: transport
> 
>       checkpatch.pl --codespell is your friend here.

Thanks for this hint too!

> 
>> For each of the above, there is a specific routing table referencing all
>> peers for fast look up.
>>
>> Case 2. is a bit special in the sense that an outgoing packet may not be
>> sent to the peer VPN IP directly, but rather to a network behind it. For
>> this reason we first perform a nexthop lookup in the system routing
>> table and then we use the retrieved nexthop as peer search key.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> +/**
>> + * ovpn_nexthop_lookup4() - looks up the IP of the nexthop for the given destination
>> + *
>> + * Looks up in the IPv4 system routing table the IP of the nexthop to be used
>> + * to reach the destination passed as argument. If no nexthop can be found, the
>> + * destination itself is returned as it probably has to be used as nexthop.
>> + *
>> + * @ovpn: the private data representing the current VPN session
>> + * @dst: the destination to be looked up
> 
> I think you need to document @src instead of @dst here.

Right

> 
>> + *
>> + * Return the IP of the next hop if found or the dst itself otherwise
>> + */
>> +static __be32 ovpn_nexthop_lookup4(struct ovpn_struct *ovpn, __be32 src)
>> +{
>> +	struct rtable *rt;
>> +	struct flowi4 fl = {
>> +		.daddr = src
>> +	};
>> +
>> +	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
>> +	if (IS_ERR(rt)) {
>> +		net_dbg_ratelimited("%s: no nexthop found for %pI4\n", ovpn->dev->name, &src);
>> +		/* if we end up here this packet is probably going to be
>> +		 * thrown away later
>> +		 */
>> +		return src;
>> +	}
>> +
>> +	if (!rt->rt_uses_gateway)
>> +		goto out;
>> +
>> +	src = rt->rt_gw4;
>> +out:
>> +	return src;
>> +}
>> +
>> +/**
>> + * ovpn_nexthop_lookup6() - looks up the IPv6 of the nexthop for the given destination
>> + *
>> + * Looks up in the IPv6 system routing table the IP of the nexthop to be used
>> + * to reach the destination passed as argument. If no nexthop can be found, the
>> + * destination itself is returned as it probably has to be used as nexthop.
>> + *
>> + * @ovpn: the private data representing the current VPN session
>> + * @dst: the destination to be looked up
> 
> And here.

Right.


> 
>> + *
>> + * Return the IP of the next hop if found or the dst itself otherwise
>> + */
>> +static struct in6_addr ovpn_nexthop_lookup6(struct ovpn_struct *ovpn, struct in6_addr addr)
>> +{
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	struct rt6_info *rt;
>> +	struct flowi6 fl = {
>> +		.daddr = addr,
>> +	};
>> +
>> +	rt = (struct rt6_info *)ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
>> +								NULL);
>> +	if (IS_ERR(rt)) {
>> +		net_dbg_ratelimited("%s: no nexthop found for %pI6\n", ovpn->dev->name, &addr);
>> +		/* if we end up here this packet is probably going to be thrown away later */
>> +		return addr;
>> +	}
>> +
>> +	if (rt->rt6i_flags & RTF_GATEWAY)
>> +		addr = rt->rt6i_gateway;
>> +
>> +	dst_release((struct dst_entry *)rt);
>> +#endif
>> +	return addr;
>> +}
> 
> ...

Thanks a lot.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

