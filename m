Return-Path: <netdev+bounces-95475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814338C25E6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100F31F22F40
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD712C544;
	Fri, 10 May 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bm+ISU+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15B5472A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348302; cv=none; b=sY5NvBZx7meAR6Zr7x1eeQj0Ho7dcO0LfHYzTeb2OyH19BC1eR0gDhNZjT9CcCqg46mTSv4FnWiHWE4DvDy1Dipjz+4xGXHqJ9qJuaFoscG1lde7e06vV7foeFr/CW0MnmVMByQGn2FqcTIrQS86KLGludZbD44ThxUoY4mWTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348302; c=relaxed/simple;
	bh=X5FSj3fI600aifOj1cjv69HPpuxMetnTLLBdHWeRiBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXIyPzKCzhlXOOIK+jang5mw9i2aAg7CUajIi9KqJzw4iL4TxMXAXU9MMSgRvoLpO85vyRRh7zfagBI7/anNUeEQRwXrFfpjzY8Mebeds5MVeCO+hhIKL0pHcBdS6Xqk6HhRtgPgam0p7ju3DzFxYxLyk0rh/pDTihs4nt7jBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bm+ISU+s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59e4136010so509302466b.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715348299; x=1715953099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GH0lwSiKtOenoRetd/6hk9S/DLmR2MTzcdj9yxKp/no=;
        b=bm+ISU+sY0Gh8AQKkmxEhTrS1cc997jShWW8qdcahBaaLhfOMlbztnUKCo3DzZkEf0
         3vigbLQ+0iXY4dCq8pmwgWwOUO7b1qedi2f8CY8w9JTL1j0saExo4laGHIELYYY99dr/
         97lpsw3K/W+L1LOwBVFXHJ6enih3IRT9dr3yCmBbyXIsRutrCnFw7ZRkVogQQyp01U27
         QYjEpFHrtVH3pOqQW9T6HjiQW+EUZXU3kDwuDt71eCCPB3N/gaFID8dhTsmEYDxajFcm
         3lItI2CwrecPYF5xCctcL+12DItL4jhSlGHIoG+l9xKmqNnMt3vP9B/ARQSxoNoWSEdN
         FQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348299; x=1715953099;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH0lwSiKtOenoRetd/6hk9S/DLmR2MTzcdj9yxKp/no=;
        b=r9y40KVFiH+8+yWxOQ11JpN3ze693bJrC7Fo8mi1QDkBn4JRJAevcw1JdJbYNnegws
         mWDeVofxK1OX/rQxvMwVD0Ub0/uMjjQ6/EBzZnVZpa1rZT1NhXTbvurOWHbJVD6kBZ8G
         UWDyY/7Qb5s1mWndhzVH5zI6BajrbPOmqoJajXmq58+y2+syc49B2k13hU/6puel9yi0
         FJMe9MKIY4vz4KQhMrs2HejGl5+I+p4JqhfqXEjst+q+xPwALUkXjwPXF+OUhnzuH13D
         uRfL2V0faSdhvFQVIALmtJLoCrphWUuhmiv7rY4KakJmtT/z37VfPQ0gXd21oP7xIWCC
         whHg==
X-Gm-Message-State: AOJu0Yw/OxYpAUkBxLKCXEa57p7m6H+K5/7wm4B9sOtCK6heJzht68My
	Y3dKb/uGhupn2e9+BOQGQWNVfASMuNwPxu0I0OW9+71QOxRnlXelH/sKpkIFOYs=
X-Google-Smtp-Source: AGHT+IEPGkt+PIraUmtTnDm0UevTDhqKyxtlnicxT8tReWs2AFlZlyVomSe1nOiInmhnyZHSAKSWXQ==
X-Received: by 2002:a17:906:2dd5:b0:a59:c728:5430 with SMTP id a640c23a62f3a-a5a2d677dc0mr176536266b.76.1715348298892;
        Fri, 10 May 2024 06:38:18 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:d421:4f57:ac07:f400? ([2001:67c:2fbc:0:d421:4f57:ac07:f400])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d68sm185044366b.80.2024.05.10.06.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:38:18 -0700 (PDT)
Message-ID: <fdc23343-a85c-41d3-ab24-51c3d4e78854@openvpn.net>
Date: Fri, 10 May 2024 15:39:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-10-antonio@openvpn.net> <Zj4avXMEhJ_7OIAf@hog>
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
In-Reply-To: <Zj4avXMEhJ_7OIAf@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2024 15:01, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index a420bb45f25f..36cfb95edbf4 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -28,6 +30,12 @@ int ovpn_struct_init(struct net_device *dev)
>>   
>>   	spin_lock_init(&ovpn->lock);
>>   
>> +	ovpn->crypto_wq = alloc_workqueue("ovpn-crypto-wq-%s",
>> +					  WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0,
>> +					  dev->name);
>> +	if (!ovpn->crypto_wq)
>> +		return -ENOMEM;
>> +
>>   	ovpn->events_wq = alloc_workqueue("ovpn-events-wq-%s", WQ_MEM_RECLAIM,
>>   					  0, dev->name);
>>   	if (!ovpn->events_wq)
>>   		return -ENOMEM;
> 
> This will leak crypto_wq on failure. You need to roll back all
> previous changes when something fails (also if you move all this stuff
> into ndo_init).

ouch, good catch! thanks.

> 
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index 659df320525c..f915afa260c3 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -22,9 +23,12 @@
>>    * @id: unique identifier
>>    * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
>>    * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
>> + * @encrypt_work: work used to process outgoing packets
>> + * @decrypt_work: work used to process incoming packets
> 
> nit: Only encrypt_work is used in this patch, decrypt_work is for RX

Right, same for tx_ring actually. will move both to the next patch

> 
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index 4b7d96a13df0..f434da76dc0a 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> +/**
>> + * ovpn_udp4_output - send IPv4 packet over udp socket
>> + * @ovpn: the openvpn instance
>> + * @bind: the binding related to the destination peer
>> + * @cache: dst cache
>> + * @sk: the socket to send the packet over
>> + * @skb: the packet to send
>> + *
>> + * Return: 0 on success or a negative error code otherwise
>> + */
>> +static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
>> +			    struct dst_cache *cache, struct sock *sk,
>> +			    struct sk_buff *skb)
>> +{
>> +	struct rtable *rt;
>> +	struct flowi4 fl = {
>> +		.saddr = bind->local.ipv4.s_addr,
>> +		.daddr = bind->sa.in4.sin_addr.s_addr,
>> +		.fl4_sport = inet_sk(sk)->inet_sport,
>> +		.fl4_dport = bind->sa.in4.sin_port,
>> +		.flowi4_proto = sk->sk_protocol,
>> +		.flowi4_mark = sk->sk_mark,
>> +	};
>> +	int ret;
>> +
>> +	local_bh_disable();
>> +	rt = dst_cache_get_ip4(cache, &fl.saddr);
>> +	if (rt)
>> +		goto transmit;
>> +
>> +	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
>> +					RT_SCOPE_HOST))) {
>> +		/* we may end up here when the cached address is not usable
>> +		 * anymore. In this case we reset address/cache and perform a
>> +		 * new look up
> 
> What exactly are you trying to guard against here? The ipv4 address
> used for the last packet being removed from the device/host? I don't
> see other tunnels using dst_cache doing this kind of thing (except
> wireguard).

yes, that's the scenario being checked (which hopefully is what the 
comment conveys).

> 
>> +		 */
>> +		fl.saddr = 0;
>> +		bind->local.ipv4.s_addr = 0;
>> +		dst_cache_reset(cache);
>> +	}
>> +
>> +	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
>> +	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
>> +		fl.saddr = 0;
>> +		bind->local.ipv4.s_addr = 0;
>> +		dst_cache_reset(cache);
>> +
>> +		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
> 
> Why do you need to repeat the lookup? And why only for ipv4, but not
> for ipv6?

We are repeating the lookup without the saddr.

The first lookup may have failed because the destination is not 
reachable anymore from that specific source address, but it may be 
reachable from another one (i.e. routing table change in a multi-homed 
setup).

Why not for v6..that's a good question..I wonder if I should just do the 
same and repeat the lookup with ip6addr_any as source..I think it would 
make sense as we could end up in the same scenario as described for IPv4.

What do you think?

> 
>> +	}
>> +
>> +	if (IS_ERR(rt)) {
>> +		ret = PTR_ERR(rt);
>> +		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
>> +				    ovpn->dev->name, &bind->sa.in4, ret);
>> +		goto err;
>> +	}
>> +	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
> 
> Overall this looks a whole lot like udp_tunnel_dst_lookup, except for:
>   - 2nd lookup
>   - inet_confirm_addr/dst_cache_reset

but why doesn't udp_tunnel_dst_lookup account for cases where the source 
address is not usable anymore? I think they are reasonable, no?

Maybe I could still use udp_tunnel_dst_lookup, but call it a second time 
without saddr in case of failure?

> 
> (and there's udp_tunnel6_dst_lookup for ipv6)
> 

-- 
Antonio Quartulli
OpenVPN Inc.

