Return-Path: <netdev+bounces-96180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE48C4991
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62A828761F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C884A56;
	Mon, 13 May 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="euqB1Dje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04212AF09
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638749; cv=none; b=fnIloanMR7XxZgWO17vpr0DG/cIk9bpgQZDUdPKdvYa/+hUz0j37+TpiCjJkHf1yIr0IXI2K6Ftmxrcigyb4pjNfRinh0lbAC6ixx+KuMeJeAjN7dfogzjs8Z3BO4jxcAM4Ty7e7hggE9HrunPl7h6SLraDaP7Nd0Nh28ApVpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638749; c=relaxed/simple;
	bh=CErxJpT3S4s+XUmMUrUqGdJFLexP1E9h6pN9v8BWeM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeiAhwZyZcyPDNJOtc8HHdQ2EtiUfRz7M2CBL3PK71r43MMlmDsMOFIZPPcwqAY4NJGrBVTG1d0PXxLVWPUui1Zqc6D1yHFX0txSUC/Dg4vmGEeLyuoK2yB5LIPvPx3aWrMjHC270bMAbFTbpzyhD699TkhTJno/f+D2wmEv1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=euqB1Dje; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a64db066so1233395966b.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715638745; x=1716243545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fzQz2Uxy4YMDlChP+YqYnkx6Mm6LLsnjOIrVYkhCftk=;
        b=euqB1DjeYkD1FoQ6ZSI62pCrjNE+lBtVYTU24s/Ss5NYRiWEPpnsGbru8hBMwX1RNv
         tclPZW1ZtKTkf/dYgwZD1qBpz2xJNJxAocP2P0DCDCXLBzTuQKpnnQYsAuB22Jg6vigu
         2BSEF/F7bSxPFufSZF+D4ad5wNG0XY2vb6oImrltGQGndJ+zIqFcp4Isp49DHF+DzGJA
         pEZsP3OsiVOR0LMp7PRhzyx2WF7ckuXZIS1xMO43ZsM6f0SksuVqVQylUXrks/PqN+QX
         Xqi99xPn6IjZMRcckUWjRcYUL6y8hsyc3leqZCPvcpDsfYds0TXse94cGNhkqmjVzMRl
         9xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638745; x=1716243545;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzQz2Uxy4YMDlChP+YqYnkx6Mm6LLsnjOIrVYkhCftk=;
        b=hsKuBbzf7IUvdJ7rJQnZDvuHuv2JL4WbbAOLGEH9XEw/bn7Tblqiq2m6tixvWJ4v0v
         cjZ4ppLIgeK05VLfX1i0xYkBVky8v9jWsG616pNEHfERjZztRN3l7GmbJG4yE41Lx83o
         fdzuKN5ndZTnMXFwLJRFAmo0mX3WdzFWDynDBGYigbdcymImEBB+xgQnAe9dfNka54xi
         IF8hBqeS1Av/+PLIGxkLKbEkMl0iJS0IFgyZHvamGgpTNyQq20NSQxr+eukLnz8mCT6H
         cqiziteHnUuZwL91w2XD8EfMvuUAY0qQ7Pb98oxqOeDLjhb/G8YBKFKRm0jfnaY2t55g
         K8ZA==
X-Gm-Message-State: AOJu0Yz+whNTOcOgIG8XSWk724iO2xpuj1yikagdoOkKd2aptKNPdJD1
	DZl21U/CefLLvIgXQafGmKVGCbSfing2Rdgxgs8ZuXDV0kFjQhPAXkGoN+89lU0=
X-Google-Smtp-Source: AGHT+IEznIHYvgvvqfHVMkcss2doZy8gEPIHYAVhdVRqYueZYcgyvD7+xHflB/rRNPCQsRR7VJBNmg==
X-Received: by 2002:a50:8d07:0:b0:571:e272:296 with SMTP id 4fb4d7f45d1cf-5734d67ee8emr7604545a12.27.1715638744897;
        Mon, 13 May 2024 15:19:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:1fb0:19c4:bb06:99b1? ([2001:67c:2fbc:0:1fb0:19c4:bb06:99b1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm6718426a12.57.2024.05.13.15.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 15:19:04 -0700 (PDT)
Message-ID: <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
Date: Tue, 14 May 2024 00:20:24 +0200
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkIosadLULByXFKc@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 16:50, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:26 +0200, Antonio Quartulli wrote:
>> @@ -307,6 +308,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>>   /* Process packets in TX queue in a transport-specific way.
>>    *
>>    * UDP transport - encrypt and send across the tunnel.
>> + * TCP transport - encrypt and put into TCP TX queue.
>>    */
>>   void ovpn_encrypt_work(struct work_struct *work)
>>   {
>> @@ -340,6 +342,9 @@ void ovpn_encrypt_work(struct work_struct *work)
>>   					ovpn_udp_send_skb(peer->ovpn, peer,
>>   							  curr);
>>   					break;
>> +				case IPPROTO_TCP:
>> +					ovpn_tcp_send_skb(peer, curr);
>> +					break;
>>   				default:
>>   					/* no transport configured yet */
>>   					consume_skb(skb);
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 9ae9844dd281..a04d6e55a473 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -23,6 +23,7 @@
>>   #include "io.h"
>>   #include "packet.h"
>>   #include "peer.h"
>> +#include "tcp.h"
>>   
>>   /* Driver info */
>>   #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>> @@ -247,8 +248,14 @@ static struct pernet_operations ovpn_pernet_ops = {
>>   
>>   static int __init ovpn_init(void)
>>   {
>> -	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
>> +	int err = ovpn_tcp_init();
>>   
>> +	if (err) {
> 
> ovpn_tcp_init cannot fail (and if it could, you'd need to clean up
> when register_netdevice_notifier fails). I'd make ovpn_tcp_init void
> and kill this check.

I like to have all init functions returning int by design, even though 
they may not fail.

But I can undersand this is not necessarily good practice (somebody will 
always ask "when does it fail?" and there will will be no answer, which 
is confusing)

> 
>> +		pr_err("ovpn: cannot initialize TCP component: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = register_netdevice_notifier(&ovpn_netdev_notifier);
>>   	if (err) {
>>   		pr_err("ovpn: can't register netdevice notifier: %d\n", err);
>>   		return err;
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index b5ff59a4b40f..ac4907705d98 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -33,6 +33,16 @@
>>    * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
>>    * @napi: NAPI object
>>    * @sock: the socket being used to talk to this peer
>> + * @tcp.tx_ring: queue for packets to be forwarded to userspace (TCP only)
>> + * @tcp.tx_work: work for processing outgoing socket data (TCP only)
>> + * @tcp.rx_work: wok for processing incoming socket data (TCP only)
> 
> Never actually used.
> If you keep it: s/wok/work/

Indeed, I think this is another leftover.

> 
>> + * @tcp.raw_len: next packet length as read from the stream (TCP only)
>> + * @tcp.skb: next packet being filled with data from the stream (TCP only)
>> + * @tcp.offset: position of the next byte to write in the skb (TCP only)
>> + * @tcp.data_len: next packet length converted to host order (TCP only)
> 
> It would be nice to add information about whether they're used for TX or RX.

they are all about "from the stream" and "to the skb", meaning that we 
are doing RX.
Will make it more explicit.

> 
>> + * @tcp.sk_cb.sk_data_ready: pointer to original cb
>> + * @tcp.sk_cb.sk_write_space: pointer to original cb
>> + * @tcp.sk_cb.prot: pointer to original prot object
>>    * @crypto: the crypto configuration (ciphers, keys, etc..)
>>    * @dst_cache: cache for dst_entry used to send to peer
>>    * @bind: remote peer binding
>> @@ -59,6 +69,25 @@ struct ovpn_peer {
>>   	struct ptr_ring netif_rx_ring;
>>   	struct napi_struct napi;
>>   	struct ovpn_socket *sock;
>> +	/* state of the TCP reading. Needed to keep track of how much of a
>> +	 * single packet has already been read from the stream and how much is
>> +	 * missing
>> +	 */
>> +	struct {
>> +		struct ptr_ring tx_ring;
>> +		struct work_struct tx_work;
>> +		struct work_struct rx_work;
>> +
>> +		u8 raw_len[sizeof(u16)];
> 
> Why not u16 or __be16 for this one?

because in this array we are putting the bytes as we get them from the 
stream.
We may be at the point where one out of two bytes is available on the 
stream. For this reason I use an array to store this u16 byte by byte.

Once thw two bytes are ready, we convert the content in an actual int 
and store it in "data_len" (a few lines below).

> 
>> +		struct sk_buff *skb;
>> +		u16 offset;
>> +		u16 data_len;
>> +		struct {
>> +			void (*sk_data_ready)(struct sock *sk);
>> +			void (*sk_write_space)(struct sock *sk);
>> +			struct proto *prot;
>> +		} sk_cb;
>> +	} tcp;
>>   	struct ovpn_crypto_state crypto;
>>   	struct dst_cache dst_cache;
>>   	struct ovpn_bind __rcu *bind;
>> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
>> new file mode 100644
>> index 000000000000..ba92811e12ff
>> --- /dev/null
>> +++ b/drivers/net/ovpn/skb.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
>> + *		James Yonan <james@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_SKB_H_
>> +#define _NET_OVPN_SKB_H_
>> +
>> +#include <linux/in.h>
>> +#include <linux/in6.h>
>> +#include <linux/ip.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/socket.h>
>> +#include <linux/types.h>
>> +
>> +#define OVPN_SKB_CB(skb) ((struct ovpn_skb_cb *)&((skb)->cb))
>> +
>> +struct ovpn_skb_cb {
>> +	union {
>> +		struct in_addr ipv4;
>> +		struct in6_addr ipv6;
>> +	} local;
>> +	sa_family_t sa_fam;
>> +};
>> +
>> +/* Return IP protocol version from skb header.
>> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
>> + */
>> +static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
> 
> A dupe of this function exists in drivers/net/ovpn/io.c. I guess you
> can just introduce skb.h from the start (with only
> ovpn_ip_check_protocol at first).

thanks. I think that was the idea, but something went horribly wrong.

> 
>> +{
>> +	__be16 proto = 0;
>> +
>> +	/* skb could be non-linear,
>> +	 * make sure IP header is in non-fragmented part
>> +	 */
>> +	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
>> +		return 0;
>> +
>> +	if (ip_hdr(skb)->version == 4)
>> +		proto = htons(ETH_P_IP);
>> +	else if (ip_hdr(skb)->version == 6)
>> +		proto = htons(ETH_P_IPV6);
>> +
>> +	return proto;
>> +}
>> +
>> +#endif /* _NET_OVPN_SKB_H_ */
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> index e099a61b03fa..004db5b13663 100644
>> --- a/drivers/net/ovpn/socket.c
>> +++ b/drivers/net/ovpn/socket.c
>> @@ -16,6 +16,7 @@
>>   #include "packet.h"
>>   #include "peer.h"
>>   #include "socket.h"
>> +#include "tcp.h"
>>   #include "udp.h"
>>   
>>   /* Finalize release of socket, called after RCU grace period */
>> @@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
>>   
>>   	if (sock->sk->sk_protocol == IPPROTO_UDP)
>>   		ovpn_udp_socket_detach(sock);
>> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
>> +		ovpn_tcp_socket_detach(sock);
>>   
>>   	sockfd_put(sock);
>>   }
>> @@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>>   
>>   	if (sock->sk->sk_protocol == IPPROTO_UDP)
>>   		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
>> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
>> +		ret = ovpn_tcp_socket_attach(sock, peer);
>>   
>>   	return ret;
>>   }
>> @@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>>   	ovpn_sock->sock = sock;
> 
> The line above this is:
> 
>      ovpn_sock->ovpn = peer->ovpn;
> 
> It's technically fine since you then overwrite this with peer in case
> we're on TCP, but ovpn_sock->ovpn only exists on UDP since you moved
> it into a union in this patch.

Yeah, I did not want to make another branch, but having a UDP specific 
case will make code easier to read.

> 
>>   	kref_init(&ovpn_sock->refcount);
>>   
>> +	/* TCP sockets are per-peer, therefore they are linked to their unique
>> +	 * peer
>> +	 */
>> +	if (sock->sk->sk_protocol == IPPROTO_TCP) {
>> +		ovpn_sock->peer = peer;
>> +		ret = ptr_ring_init(&ovpn_sock->recv_ring, OVPN_QUEUE_LEN,
>> +				    GFP_KERNEL);
>> +		if (ret < 0) {
>> +			netdev_err(peer->ovpn->dev, "%s: cannot allocate TCP recv ring\n",
>> +				   __func__);
> 
> Should you also call ovpn_socket_detach here? (as well when the
> kzalloc for ovpn_sock fails a bit earlier)

mh, the attach is performed as first thing when we enter this function 
therefore you are right. we must undo the attach in case of failure.

> 
>> +			kfree(ovpn_sock);
>> +			return ERR_PTR(ret);
>> +		}
>> +	}
>> +
>>   	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
>>   
>>   	return ovpn_sock;
>> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
>> index 0d23de5a9344..88c6271ba5c7 100644
>> --- a/drivers/net/ovpn/socket.h
>> +++ b/drivers/net/ovpn/socket.h
>> @@ -21,12 +21,25 @@ struct ovpn_peer;
>>   /**
>>    * struct ovpn_socket - a kernel socket referenced in the ovpn code
>>    * @ovpn: ovpn instance owning this socket (UDP only)
>> + * @peer: unique peer transmitting over this socket (TCP only)
>> + * @recv_ring: queue where non-data packets directed to userspace are stored
>>    * @sock: the low level sock object
>>    * @refcount: amount of contexts currently referencing this object
>>    * @rcu: member used to schedule RCU destructor callback
>>    */
>>   struct ovpn_socket {
>> -	struct ovpn_struct *ovpn;
>> +	union {
>> +		/* the VPN session object owning this socket (UDP only) */
> 
> nit: Probably not needed
> 
>> +		struct ovpn_struct *ovpn;
>> +
>> +		/* TCP only */
>> +		struct {
>> +			/** @peer: unique peer transmitting over this socket */
> 
> Is kdoc upset about peer but not recv_ring?

leftovers from before having the kdoc. I am removing them.

> 
>> +			struct ovpn_peer *peer;
>> +			struct ptr_ring recv_ring;
>> +		};
>> +	};
>> +
>>   	struct socket *sock;
>>   	struct kref refcount;
>>   	struct rcu_head rcu;
>> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
>> new file mode 100644
>> index 000000000000..84ad7cd4fc4f
>> --- /dev/null
>> +++ b/drivers/net/ovpn/tcp.c
>> @@ -0,0 +1,511 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#include <linux/ptr_ring.h>
>> +#include <linux/skbuff.h>
>> +#include <net/tcp.h>
>> +#include <net/route.h>
>> +
>> +#include "ovpnstruct.h"
>> +#include "main.h"
>> +#include "io.h"
>> +#include "packet.h"
>> +#include "peer.h"
>> +#include "proto.h"
>> +#include "skb.h"
>> +#include "socket.h"
>> +#include "tcp.h"
>> +
>> +static struct proto ovpn_tcp_prot;
>> +
>> +static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
>> +			      unsigned int in_offset, size_t in_len)
>> +{
>> +	struct sock *sk = desc->arg.data;
>> +	struct ovpn_socket *sock;
>> +	struct ovpn_skb_cb *cb;
>> +	struct ovpn_peer *peer;
>> +	size_t chunk, copied = 0;
>> +	void *data;
>> +	u16 len;
>> +	int st;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	rcu_read_unlock();
> 
> You can't just release rcu_read_lock and keep using sock (here and in
> the rest of this file). Either you keep rcu_read_lock, or you can take
> a reference on the ovpn_socket.

I was just staring at this today, after having worked on the 
rcu_read_lock/unlock for the peer get()s..

I thinkt the assumption was: if we are in this read_sock callback, it's 
impossible that the ovpn_socket was invalidated, because it gets 
invalidated upon detach, which also prevents any further calling of this 
callback. But this sounds racy, and I guess we should somewhat hold a 
reference..

> 
> 
> Anyway, this looks like you're reinventing strparser. Overall this is
> very similar to net/xfrm/espintcp.c, but the receive side of espintcp
> uses strp and is much shorter (recv_ring looks equivalent to
> ike_queue, both sending a few messages to userspace -- look for
> strp_init, espintcp_rcv, espintcp_parse in that file).

I think I did have a look at strparser once, but I wasn't sure to be 
grasping all details.

Will have another look and see what I can re-use.

> 
>> +/* Set TCP encapsulation callbacks */
>> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>> +{
>> +	void *old_data;
>> +	int ret;
>> +
>> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
>> +
>> +	ret = ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
>> +		return ret;
>> +	}
>> +
>> +	peer->tcp.skb = NULL;
>> +	peer->tcp.offset = 0;
>> +	peer->tcp.data_len = 0;
>> +
>> +	write_lock_bh(&sock->sk->sk_callback_lock);
>> +
>> +	/* make sure no pre-existing encapsulation handler exists */
>> +	rcu_read_lock();
>> +	old_data = rcu_dereference_sk_user_data(sock->sk);
>> +	rcu_read_unlock();
>> +	if (old_data) {
>> +		netdev_err(peer->ovpn->dev,
>> +			   "provided socket already taken by other user\n");
>> +		ret = -EBUSY;
>> +		goto err;
> 
> The UDP code differentiates "socket already owned by this interface"
> from "already taken by other user". That doesn't apply to TCP?

This makes me wonder: how safe it is to interpret the user data as an 
object of type ovpn_socket?

When we find the user data already assigned, we don't know what was 
really stored in there, right?
Technically this socket could have gone through another module which 
assigned its own state.

Therefore I think that what UDP does [ dereferencing ((struct 
ovpn_socket *)user_data)->ovpn ] is probably not safe. Would you agree?

> 
> 
> 
>> +int __init ovpn_tcp_init(void)
>> +{
>> +	/* We need to substitute the recvmsg and the sock_is_readable
>> +	 * callbacks in the sk_prot member of the sock object for TCP
>> +	 * sockets.
>> +	 *
>> +	 * However sock->sk_prot is a pointer to a static variable and
>> +	 * therefore we can't directly modify it, otherwise every socket
>> +	 * pointing to it will be affected.
>> +	 *
>> +	 * For this reason we create our own static copy and modify what
>> +	 * we need. Then we make sk_prot point to this copy
>> +	 * (in ovpn_tcp_socket_attach())
>> +	 */
>> +	ovpn_tcp_prot = tcp_prot;
> 
> Don't you need a separate variant for IPv6, like TLS does?

Never did so far.

My wild wild wild guess: for the time this socket is owned by ovpn, we 
only use callbacks that are IPvX agnostic, hence v4 vs v6 doesn't make 
any difference.
When this socket is released, we reassigned the original prot.

> 
>> +	ovpn_tcp_prot.recvmsg = ovpn_tcp_recvmsg;
> 
> You don't need to replace ->sendmsg as well? The userspace client is
> not expected to send messages?

It is, but my assumption is that those packets will just go through the 
socket as usual. No need to be handled by ovpn (those packets are not 
encrypted/decrypted, like data traffic is).
And this is how it has worked so far.

Makes sense?

Thanks a lot!



-- 
Antonio Quartulli
OpenVPN Inc.

