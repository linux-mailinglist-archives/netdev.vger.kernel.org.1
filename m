Return-Path: <netdev+bounces-96051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D238C4208
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFCF2864A7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA41534F3;
	Mon, 13 May 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gJi6UW+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D21482F9
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607400; cv=none; b=o6sdXfy5chkKlVDTqdB8QOjrU5iSckxfuX3xR0YU1D4iSv32B0SMEfrSwskMyXenNo7LTQXsJYEkKhIw30JKehG+B3gJE6wiqPj3ltqwR+9ERcy9kxAGtDy9Oe6ZosAtk9QjWNQol/PPLpoI+75AS/5Kq3wCNk0xQ7BIwsoyTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607400; c=relaxed/simple;
	bh=LgnxAA002nW0xkdQLCfRbkhJScKtg3VtM6e+kCTnAPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZEWyOFdlf19N7leZfKR13BKjMkbsZHQ/nJgHt5jqoZbh2r6ZHIzga8i+TI6Q3W7HDahzqfXuc6DErMesjRdM3qn46HfbUC7LZ4aoE9iu3UGnd4OzLgwyxc33XvfUWtzffWcfFVLmAbUq8ZJ3EemJfyQ3PrHM6AveWQyxWly6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gJi6UW+Y; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6792ea67eso13659771fa.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715607396; x=1716212196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SMmBDsEmU2b3gT/jhJYaxxiVVypz55C7Wxbfk70Gkxc=;
        b=gJi6UW+YGvpWlQny+iIKhfVhsJvyzhxrUR3eFE/ubZwbJ8YOKvfTEkNxYXu/i3tJd/
         CrmGL05byoWzwqkxUYxfBZJ/kHjVY7n4HEZ98770ky4QoLwz2xzptk0YeA7PTb1aejR/
         jg/Uz3ZD6I49Z/VOQkzxQxqH86SKRj9zCKAkcIPzyXyvbyZdmt9GvNGwjK85k4Z5RBeD
         0L6axOKYp5fGfMkW8Ki2BMzhtjwhXurs4rfyLAFb+tL2C7qzPrwIf/C+bdvj9dpSJLs9
         /p/7wELM/cGfjPftH/cR6luMkCtPjxvrg2fXb4xwvGh7z9HSiSQj3Bzc+yAZVVofnwX6
         tJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607396; x=1716212196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMmBDsEmU2b3gT/jhJYaxxiVVypz55C7Wxbfk70Gkxc=;
        b=fElSPVj+aq0D5X0QLDBOJU/DPeBP6OQXUG0tEyrUQ8UrUVtBx2/UG8RJzPniy+Jfu9
         /egcb+mj8PhAjbg4YPw2FqGZOLWeSIVww8p6MKVVdXvrIq52WEoY3lfvPqfNBG+R3pk2
         A9JgoUk23G5KL0bG+VEzuNsfpQ+l5o57XwC9jmQAj7EIxCHMoBumI+jBWyMQ1BOC2m+9
         GvAyDP8V7c4yuMcHKzgkWhWLbwfuybKUMsz7YGchuaXmWEzmwKYM6YpZRwhxJTH6g8Te
         ijUU1AzvdilF9WXKPow0HlW1IiM4u17yfym2HpQmeWjRBxOJPr8Hfx6GPGR9slJ/Xib0
         cppA==
X-Forwarded-Encrypted: i=1; AJvYcCVUqlnRAJPVmH6SQsRd36b5be169+d0dQhWLE4tFZ6HSJGYu1sUQEL5oDVloELsdVtYtEZzvtztRzBovFOmCPmbaR42kPFs
X-Gm-Message-State: AOJu0Yyano/c58b7oY8vAHQiwTj4TkAjwBOnEaMAMVArIwYyGxWlGUrQ
	T+FnX6Jb/hi9Sndr08TAxSP065bz4wVaCTfvIy1w3/8Pbe7M2OaR+WA21bQU2H4HVsjCHvBC2xw
	q
X-Google-Smtp-Source: AGHT+IGG2rxP80fCdRQkqLaDgTkjltnWsYZGFJjgAVnunRyqpwE+T0PsFKrc06VJZ8I58ASA862Bsw==
X-Received: by 2002:a2e:bea5:0:b0:2e3:3b4e:43ee with SMTP id 38308e7fff4ca-2e51fe531f8mr80737951fa.19.1715607395616;
        Mon, 13 May 2024 06:36:35 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f881110f9sm194035145e9.37.2024.05.13.06.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 06:36:34 -0700 (PDT)
Message-ID: <4b42fa39-f204-481d-a097-7d41da53f7d6@openvpn.net>
Date: Mon, 13 May 2024 15:37:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
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
In-Reply-To: <20240506011637.27272-14-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

On 06/05/2024 03:16, Antonio Quartulli wrote:
[...]
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index b5ff59a4b40f..ac4907705d98 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -33,6 +33,16 @@
>    * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
>    * @napi: NAPI object
>    * @sock: the socket being used to talk to this peer
> + * @tcp.tx_ring: queue for packets to be forwarded to userspace (TCP only)
> + * @tcp.tx_work: work for processing outgoing socket data (TCP only)
> + * @tcp.rx_work: wok for processing incoming socket data (TCP only)
> + * @tcp.raw_len: next packet length as read from the stream (TCP only)

can you please help me with the following warning from kerneldoc?
As you can see below, raw_len is an array.

May that be the reason why the script isn't picking it up correctly?

drivers/net/ovpn/peer.h:101: warning: Function parameter or struct 
member 'raw_len' not described in 'ovpn_peer'
drivers/net/ovpn/peer.h:101: warning: Excess struct member 'tcp.raw_len' 
description in 'ovpn_peer'

(line number may differ as I am in the middle of a rebase)

Regards,


> + * @tcp.skb: next packet being filled with data from the stream (TCP only)
> + * @tcp.offset: position of the next byte to write in the skb (TCP only)
> + * @tcp.data_len: next packet length converted to host order (TCP only)
> + * @tcp.sk_cb.sk_data_ready: pointer to original cb
> + * @tcp.sk_cb.sk_write_space: pointer to original cb
> + * @tcp.sk_cb.prot: pointer to original prot object
>    * @crypto: the crypto configuration (ciphers, keys, etc..)
>    * @dst_cache: cache for dst_entry used to send to peer
>    * @bind: remote peer binding
> @@ -59,6 +69,25 @@ struct ovpn_peer {
>   	struct ptr_ring netif_rx_ring;
>   	struct napi_struct napi;
>   	struct ovpn_socket *sock;
> +	/* state of the TCP reading. Needed to keep track of how much of a
> +	 * single packet has already been read from the stream and how much is
> +	 * missing
> +	 */
> +	struct {
> +		struct ptr_ring tx_ring;
> +		struct work_struct tx_work;
> +		struct work_struct rx_work;
> +
> +		u8 raw_len[sizeof(u16)];
> +		struct sk_buff *skb;
> +		u16 offset;
> +		u16 data_len;
> +		struct {
> +			void (*sk_data_ready)(struct sock *sk);
> +			void (*sk_write_space)(struct sock *sk);
> +			struct proto *prot;
> +		} sk_cb;
> +	} tcp;
>   	struct ovpn_crypto_state crypto;
>   	struct dst_cache dst_cache;
>   	struct ovpn_bind __rcu *bind;
> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> new file mode 100644
> index 000000000000..ba92811e12ff
> --- /dev/null
> +++ b/drivers/net/ovpn/skb.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_SKB_H_
> +#define _NET_OVPN_SKB_H_
> +
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/ip.h>
> +#include <linux/skbuff.h>
> +#include <linux/socket.h>
> +#include <linux/types.h>
> +
> +#define OVPN_SKB_CB(skb) ((struct ovpn_skb_cb *)&((skb)->cb))
> +
> +struct ovpn_skb_cb {
> +	union {
> +		struct in_addr ipv4;
> +		struct in6_addr ipv6;
> +	} local;
> +	sa_family_t sa_fam;
> +};
> +
> +/* Return IP protocol version from skb header.
> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
> + */
> +static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
> +{
> +	__be16 proto = 0;
> +
> +	/* skb could be non-linear,
> +	 * make sure IP header is in non-fragmented part
> +	 */
> +	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> +		return 0;
> +
> +	if (ip_hdr(skb)->version == 4)
> +		proto = htons(ETH_P_IP);
> +	else if (ip_hdr(skb)->version == 6)
> +		proto = htons(ETH_P_IPV6);
> +
> +	return proto;
> +}
> +
> +#endif /* _NET_OVPN_SKB_H_ */
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index e099a61b03fa..004db5b13663 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -16,6 +16,7 @@
>   #include "packet.h"
>   #include "peer.h"
>   #include "socket.h"
> +#include "tcp.h"
>   #include "udp.h"
>   
>   /* Finalize release of socket, called after RCU grace period */
> @@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
>   
>   	if (sock->sk->sk_protocol == IPPROTO_UDP)
>   		ovpn_udp_socket_detach(sock);
> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
> +		ovpn_tcp_socket_detach(sock);
>   
>   	sockfd_put(sock);
>   }
> @@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>   
>   	if (sock->sk->sk_protocol == IPPROTO_UDP)
>   		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
> +		ret = ovpn_tcp_socket_attach(sock, peer);
>   
>   	return ret;
>   }
> @@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>   	ovpn_sock->sock = sock;
>   	kref_init(&ovpn_sock->refcount);
>   
> +	/* TCP sockets are per-peer, therefore they are linked to their unique
> +	 * peer
> +	 */
> +	if (sock->sk->sk_protocol == IPPROTO_TCP) {
> +		ovpn_sock->peer = peer;
> +		ret = ptr_ring_init(&ovpn_sock->recv_ring, OVPN_QUEUE_LEN,
> +				    GFP_KERNEL);
> +		if (ret < 0) {
> +			netdev_err(peer->ovpn->dev, "%s: cannot allocate TCP recv ring\n",
> +				   __func__);
> +			kfree(ovpn_sock);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
>   	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
>   
>   	return ovpn_sock;
> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> index 0d23de5a9344..88c6271ba5c7 100644
> --- a/drivers/net/ovpn/socket.h
> +++ b/drivers/net/ovpn/socket.h
> @@ -21,12 +21,25 @@ struct ovpn_peer;
>   /**
>    * struct ovpn_socket - a kernel socket referenced in the ovpn code
>    * @ovpn: ovpn instance owning this socket (UDP only)
> + * @peer: unique peer transmitting over this socket (TCP only)
> + * @recv_ring: queue where non-data packets directed to userspace are stored
>    * @sock: the low level sock object
>    * @refcount: amount of contexts currently referencing this object
>    * @rcu: member used to schedule RCU destructor callback
>    */
>   struct ovpn_socket {
> -	struct ovpn_struct *ovpn;
> +	union {
> +		/* the VPN session object owning this socket (UDP only) */
> +		struct ovpn_struct *ovpn;
> +
> +		/* TCP only */
> +		struct {
> +			/** @peer: unique peer transmitting over this socket */
> +			struct ovpn_peer *peer;
> +			struct ptr_ring recv_ring;
> +		};
> +	};
> +
>   	struct socket *sock;
>   	struct kref refcount;
>   	struct rcu_head rcu;
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> new file mode 100644
> index 000000000000..84ad7cd4fc4f
> --- /dev/null
> +++ b/drivers/net/ovpn/tcp.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/ptr_ring.h>
> +#include <linux/skbuff.h>
> +#include <net/tcp.h>
> +#include <net/route.h>
> +
> +#include "ovpnstruct.h"
> +#include "main.h"
> +#include "io.h"
> +#include "packet.h"
> +#include "peer.h"
> +#include "proto.h"
> +#include "skb.h"
> +#include "socket.h"
> +#include "tcp.h"
> +
> +static struct proto ovpn_tcp_prot;
> +
> +static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
> +			      unsigned int in_offset, size_t in_len)
> +{
> +	struct sock *sk = desc->arg.data;
> +	struct ovpn_socket *sock;
> +	struct ovpn_skb_cb *cb;
> +	struct ovpn_peer *peer;
> +	size_t chunk, copied = 0;
> +	void *data;
> +	u16 len;
> +	int st;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	rcu_read_unlock();
> +
> +	if (unlikely(!sock || !sock->peer)) {
> +		pr_err("ovpn: read_sock triggered for socket with no metadata\n");
> +		desc->error = -EINVAL;
> +		return 0;
> +	}
> +
> +	peer = sock->peer;
> +
> +	while (in_len > 0) {
> +		/* no skb allocated means that we have to read (or finish
> +		 * reading) the 2 bytes prefix containing the actual packet
> +		 * size.
> +		 */
> +		if (!peer->tcp.skb) {
> +			chunk = min_t(size_t, in_len,
> +				      sizeof(u16) - peer->tcp.offset);
> +			WARN_ON(skb_copy_bits(in_skb, in_offset,
> +					      peer->tcp.raw_len +
> +					      peer->tcp.offset, chunk) < 0);
> +			peer->tcp.offset += chunk;
> +
> +			/* keep on reading until we got the whole packet size */
> +			if (peer->tcp.offset != sizeof(u16))
> +				goto next_read;
> +
> +			len = ntohs(*(__be16 *)peer->tcp.raw_len);
> +			/* invalid packet length: this is a fatal TCP error */
> +			if (!len) {
> +				netdev_err(peer->ovpn->dev,
> +					   "%s: received invalid packet length: %d\n",
> +					   __func__, len);
> +				desc->error = -EINVAL;
> +				goto err;
> +			}
> +
> +			/* add 2 bytes to allocated space (and immediately
> +			 * reserve them) for packet length prepending, in case
> +			 * the skb has to be forwarded to userspace
> +			 */
> +			peer->tcp.skb =
> +				netdev_alloc_skb_ip_align(peer->ovpn->dev,
> +							  len + sizeof(u16));
> +			if (!peer->tcp.skb) {
> +				desc->error = -ENOMEM;
> +				goto err;
> +			}
> +			skb_reserve(peer->tcp.skb, sizeof(u16));
> +
> +			peer->tcp.offset = 0;
> +			peer->tcp.data_len = len;
> +		} else {
> +			chunk = min_t(size_t, in_len,
> +				      peer->tcp.data_len - peer->tcp.offset);
> +
> +			/* extend skb to accommodate the new chunk and copy it
> +			 * from the input skb
> +			 */
> +			data = skb_put(peer->tcp.skb, chunk);
> +			WARN_ON(skb_copy_bits(in_skb, in_offset, data,
> +					      chunk) < 0);
> +			peer->tcp.offset += chunk;
> +
> +			/* keep on reading until we get the full packet */
> +			if (peer->tcp.offset != peer->tcp.data_len)
> +				goto next_read;
> +
> +			/* do not perform IP caching for TCP connections */
> +			cb = OVPN_SKB_CB(peer->tcp.skb);
> +			cb->sa_fam = AF_UNSPEC;
> +
> +			/* At this point we know the packet is from a configured
> +			 * peer.
> +			 * DATA_V2 packets are handled in kernel space, the rest
> +			 * goes to user space.
> +			 *
> +			 * Queue skb for sending to userspace via recvmsg on the
> +			 * socket
> +			 */
> +			if (likely(ovpn_opcode_from_skb(peer->tcp.skb, 0) ==
> +				   OVPN_DATA_V2)) {
> +				/* hold reference to peer as required by
> +				 * ovpn_recv().
> +				 *
> +				 * NOTE: in this context we should already be
> +				 * holding a reference to this peer, therefore
> +				 * ovpn_peer_hold() is not expected to fail
> +				 */
> +				WARN_ON(!ovpn_peer_hold(peer));
> +				st = ovpn_recv(peer->ovpn, peer, peer->tcp.skb);
> +				if (unlikely(st < 0))
> +					ovpn_peer_put(peer);
> +
> +			} else {
> +				/* prepend skb with packet len. this way
> +				 * userspace can parse the packet as if it just
> +				 * arrived from the remote endpoint
> +				 */
> +				void *raw_len = __skb_push(peer->tcp.skb,
> +							   sizeof(u16));
> +
> +				memcpy(raw_len, peer->tcp.raw_len, sizeof(u16));
> +
> +				st = ptr_ring_produce_bh(&peer->sock->recv_ring,
> +							 peer->tcp.skb);
> +				if (likely(!st))
> +					peer->tcp.sk_cb.sk_data_ready(sk);
> +			}
> +
> +			/* skb not consumed - free it now */
> +			if (unlikely(st < 0))
> +				kfree_skb(peer->tcp.skb);
> +
> +			peer->tcp.skb = NULL;
> +			peer->tcp.offset = 0;
> +			peer->tcp.data_len = 0;
> +		}
> +next_read:
> +		in_len -= chunk;
> +		in_offset += chunk;
> +		copied += chunk;
> +	}
> +
> +	return copied;
> +err:
> +	netdev_err(peer->ovpn->dev, "cannot process incoming TCP data: %d\n",
> +		   desc->error);
> +	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +	return 0;
> +}
> +
> +static void ovpn_tcp_data_ready(struct sock *sk)
> +{
> +	struct socket *sock = sk->sk_socket;
> +	read_descriptor_t desc;
> +
> +	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
> +		return;
> +
> +	desc.arg.data = sk;
> +	desc.error = 0;
> +	desc.count = 1;
> +
> +	sock->ops->read_sock(sk, &desc, ovpn_tcp_read_sock);
> +}
> +
> +static void ovpn_tcp_write_space(struct sock *sk)
> +{
> +	struct ovpn_socket *sock;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	rcu_read_unlock();
> +
> +	if (!sock || !sock->peer)
> +		return;
> +
> +	queue_work(sock->peer->ovpn->events_wq, &sock->peer->tcp.tx_work);
> +}
> +
> +static bool ovpn_tcp_sock_is_readable(struct sock *sk)
> +
> +{
> +	struct ovpn_socket *sock;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	rcu_read_unlock();
> +
> +	if (!sock || !sock->peer)
> +		return false;
> +
> +	return !ptr_ring_empty_bh(&sock->recv_ring);
> +}
> +
> +static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> +			    int flags, int *addr_len)
> +{
> +	bool tmp = flags & MSG_DONTWAIT;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	int ret, chunk, copied = 0;
> +	struct ovpn_socket *sock;
> +	struct sk_buff *skb;
> +	long timeo;
> +
> +	if (unlikely(flags & MSG_ERRQUEUE))
> +		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
> +
> +	timeo = sock_rcvtimeo(sk, tmp);
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	rcu_read_unlock();
> +
> +	if (!sock || !sock->peer) {
> +		ret = -EBADF;
> +		goto unlock;
> +	}
> +
> +	while (ptr_ring_empty_bh(&sock->recv_ring)) {
> +		if (sk->sk_shutdown & RCV_SHUTDOWN)
> +			return 0;
> +
> +		if (sock_flag(sk, SOCK_DONE))
> +			return 0;
> +
> +		if (!timeo) {
> +			ret = -EAGAIN;
> +			goto unlock;
> +		}
> +
> +		add_wait_queue(sk_sleep(sk), &wait);
> +		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> +		sk_wait_event(sk, &timeo, !ptr_ring_empty_bh(&sock->recv_ring),
> +			      &wait);
> +		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> +		remove_wait_queue(sk_sleep(sk), &wait);
> +
> +		/* take care of signals */
> +		if (signal_pending(current)) {
> +			ret = sock_intr_errno(timeo);
> +			goto unlock;
> +		}
> +	}
> +
> +	while (len && (skb = __ptr_ring_peek(&sock->recv_ring))) {
> +		chunk = min_t(size_t, len, skb->len);
> +		ret = skb_copy_datagram_msg(skb, 0, msg, chunk);
> +		if (ret < 0) {
> +			pr_err("ovpn: cannot copy TCP data to userspace: %d\n",
> +			       ret);
> +			kfree_skb(skb);
> +			goto unlock;
> +		}
> +
> +		__skb_pull(skb, chunk);
> +
> +		if (!skb->len) {
> +			/* skb was entirely consumed and can now be removed from
> +			 * the ring
> +			 */
> +			__ptr_ring_discard_one(&sock->recv_ring);
> +			consume_skb(skb);
> +		}
> +
> +		len -= chunk;
> +		copied += chunk;
> +	}
> +	ret = copied;
> +
> +unlock:
> +	return ret ? : -EAGAIN;
> +}
> +
> +static void ovpn_destroy_skb(void *skb)
> +{
> +	consume_skb(skb);
> +}
> +
> +void ovpn_tcp_socket_detach(struct socket *sock)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	struct ovpn_peer *peer;
> +
> +	if (!sock)
> +		return;
> +
> +	rcu_read_lock();
> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> +	rcu_read_unlock();
> +
> +	if (!ovpn_sock->peer)
> +		return;
> +
> +	peer = ovpn_sock->peer;
> +
> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
> +	write_lock_bh(&sock->sk->sk_callback_lock);
> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
> +	rcu_assign_sk_user_data(sock->sk, NULL);
> +	write_unlock_bh(&sock->sk->sk_callback_lock);
> +
> +	/* cancel any ongoing work. Done after removing the CBs so that these
> +	 * workers cannot be re-armed
> +	 */
> +	cancel_work_sync(&peer->tcp.tx_work);
> +
> +	ptr_ring_cleanup(&ovpn_sock->recv_ring, ovpn_destroy_skb);
> +	ptr_ring_cleanup(&peer->tcp.tx_ring, ovpn_destroy_skb);
> +}
> +
> +/* Try to send one skb (or part of it) over the TCP stream.
> + *
> + * Return 0 on success or a negative error code otherwise.
> + *
> + * Note that the skb is modified by putting away the data being sent, therefore
> + * the caller should check if skb->len is zero to understand if the full skb was
> + * sent or not.
> + */
> +static int ovpn_tcp_send_one(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
> +	struct kvec iv = { 0 };
> +	int ret;
> +
> +	if (skb_linearize(skb) < 0) {
> +		net_err_ratelimited("%s: can't linearize packet\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	/* initialize iv structure now as skb_linearize() may have changed
> +	 * skb->data
> +	 */
> +	iv.iov_base = skb->data;
> +	iv.iov_len = skb->len;
> +
> +	ret = kernel_sendmsg(peer->sock->sock, &msg, &iv, 1, iv.iov_len);
> +	if (ret > 0) {
> +		__skb_pull(skb, ret);
> +
> +		/* since we update per-cpu stats in process context,
> +		 * we need to disable softirqs
> +		 */
> +		local_bh_disable();
> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, ret);
> +		local_bh_enable();
> +
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Process packets in TCP TX queue */
> +static void ovpn_tcp_tx_work(struct work_struct *work)
> +{
> +	struct ovpn_peer *peer;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
> +	while ((skb = __ptr_ring_peek(&peer->tcp.tx_ring))) {
> +		ret = ovpn_tcp_send_one(peer, skb);
> +		if (ret < 0 && ret != -EAGAIN) {
> +			net_warn_ratelimited("%s: cannot send TCP packet to peer %u: %d\n",
> +					     __func__, peer->id, ret);
> +			/* in case of TCP error stop sending loop and delete
> +			 * peer
> +			 */
> +			ovpn_peer_del(peer,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +			break;
> +		} else if (!skb->len) {
> +			/* skb was entirely consumed and can now be removed from
> +			 * the ring
> +			 */
> +			__ptr_ring_discard_one(&peer->tcp.tx_ring);
> +			consume_skb(skb);
> +		}
> +
> +		/* give a chance to be rescheduled if needed */
> +		cond_resched();
> +	}
> +}
> +
> +/* Put packet into TCP TX queue and schedule a consumer */
> +void ovpn_queue_tcp_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	int ret;
> +
> +	ret = ptr_ring_produce_bh(&peer->tcp.tx_ring, skb);
> +	if (ret < 0) {
> +		kfree_skb_list(skb);
> +		return;
> +	}
> +
> +	queue_work(peer->ovpn->events_wq, &peer->tcp.tx_work);
> +}
> +
> +/* Set TCP encapsulation callbacks */
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	void *old_data;
> +	int ret;
> +
> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
> +
> +	ret = ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
> +	if (ret < 0) {
> +		netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
> +		return ret;
> +	}
> +
> +	peer->tcp.skb = NULL;
> +	peer->tcp.offset = 0;
> +	peer->tcp.data_len = 0;
> +
> +	write_lock_bh(&sock->sk->sk_callback_lock);
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	rcu_read_lock();
> +	old_data = rcu_dereference_sk_user_data(sock->sk);
> +	rcu_read_unlock();
> +	if (old_data) {
> +		netdev_err(peer->ovpn->dev,
> +			   "provided socket already taken by other user\n");
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	/* sanity check */
> +	if (sock->sk->sk_protocol != IPPROTO_TCP) {
> +		netdev_err(peer->ovpn->dev,
> +			   "provided socket is UDP but expected TCP\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* only a fully connected socket are expected. Connection should be
> +	 * handled in userspace
> +	 */
> +	if (sock->sk->sk_state != TCP_ESTABLISHED) {
> +		netdev_err(peer->ovpn->dev,
> +			   "provided TCP socket is not in ESTABLISHED state: %d\n",
> +			   sock->sk->sk_state);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* save current CBs so that they can be restored upon socket release */
> +	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
> +	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
> +	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
> +
> +	/* assign our static CBs */
> +	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
> +	sock->sk->sk_write_space = ovpn_tcp_write_space;
> +	sock->sk->sk_prot = &ovpn_tcp_prot;
> +
> +	write_unlock_bh(&sock->sk->sk_callback_lock);
> +
> +	return 0;
> +err:
> +	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	ptr_ring_cleanup(&peer->tcp.tx_ring, NULL);
> +
> +	return ret;
> +}
> +
> +int __init ovpn_tcp_init(void)
> +{
> +	/* We need to substitute the recvmsg and the sock_is_readable
> +	 * callbacks in the sk_prot member of the sock object for TCP
> +	 * sockets.
> +	 *
> +	 * However sock->sk_prot is a pointer to a static variable and
> +	 * therefore we can't directly modify it, otherwise every socket
> +	 * pointing to it will be affected.
> +	 *
> +	 * For this reason we create our own static copy and modify what
> +	 * we need. Then we make sk_prot point to this copy
> +	 * (in ovpn_tcp_socket_attach())
> +	 */
> +	ovpn_tcp_prot = tcp_prot;
> +	ovpn_tcp_prot.recvmsg = ovpn_tcp_recvmsg;
> +	ovpn_tcp_prot.sock_is_readable = ovpn_tcp_sock_is_readable;
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ovpn/tcp.h b/drivers/net/ovpn/tcp.h
> new file mode 100644
> index 000000000000..7e73f6e76e6c
> --- /dev/null
> +++ b/drivers/net/ovpn/tcp.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_TCP_H_
> +#define _NET_OVPN_TCP_H_
> +
> +#include <linux/net.h>
> +#include <linux/skbuff.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#include "peer.h"
> +
> +/* Initialize TCP static objects */
> +int __init ovpn_tcp_init(void);
> +
> +void ovpn_queue_tcp_skb(struct ovpn_peer *peer, struct sk_buff *skb);
> +
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer);
> +void ovpn_tcp_socket_detach(struct socket *sock);
> +
> +/* Prepare skb and enqueue it for sending to peer.
> + *
> + * Preparation consist in prepending the skb payload with its size.
> + * Required by the OpenVPN protocol in order to extract packets from
> + * the TCP stream on the receiver side.
> + */
> +static inline void ovpn_tcp_send_skb(struct ovpn_peer *peer,
> +				     struct sk_buff *skb)
> +{
> +	u16 len = skb->len;
> +
> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> +	ovpn_queue_tcp_skb(peer, skb);
> +}
> +
> +#endif /* _NET_OVPN_TCP_H_ */

-- 
Antonio Quartulli
OpenVPN Inc.

