Return-Path: <netdev+bounces-95505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE008C270E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1121C28115D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A41708A9;
	Fri, 10 May 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K1u1fWJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A61708AA
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352032; cv=none; b=eKLpRp7pDhd0crxyIs50d0qLSPX0vA0N4ZjwuCn1Prn0h5pYIM87CpFcourD7DhIIDnNpiGLMwLxPxgtQYSJnQagPfnldihcUomHMWkLjIdP7G8noq3pHULSCTNoS7xcfDmcJhrL4iPbnqPTh0vjBtwLoLrbN0oZoHjSaPFDsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352032; c=relaxed/simple;
	bh=ZsmmfL53MWxH/5czldfd9pBbt4hwtY/5Jlz0B6f7Pqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0QjXq24/rcWptPB7S9CIt/diOwZyU6qpvVpOdkp8egGAYFwAd+9lyDQiHCFxJrIS5s2tniBbuJq8mGgs1/9r+83o8TqhQhOMp3aIpceVWrg0ZUMki5eFV5gti9bfXJ37tLjVIFo0dsHURNoXfKMoPyTv0cKECnJWQc7hL27Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K1u1fWJv; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so24027091fa.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715352028; x=1715956828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rfeAK+eLpTvygC2DeY4CYM1Suzg7DyzkYIn2ZcZlCYk=;
        b=K1u1fWJveSEl7FxnFSCVOCcKHwU39cntyTVERElofVlP28G8t09qUehxO3OWrEpo2n
         v/QIVdYFzZs1rZKWu+RVURQ9ZbkHziiyxDOjKEleHNb4t5YSeDPgPRFRbuvmY/y67ScA
         eZdkr/cIV9hx/FdmfO2HkIhxqWyOXaGMu9krYkPamEFV4yclzNmzLcRNz7uQVwmAhTDi
         BlEVHDCSciRzjeTo5DoOVZBSM5KFSNoW2HdCHQI6KZvwdcuqRDadn9+U8seeP7TbKchD
         TRyVT2vDNXVRLujHijA7O8TCfrEfkFzowjTCaBxlc2QVQqYRD/E3L6aF2U97eSVO5Vhx
         j1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715352028; x=1715956828;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfeAK+eLpTvygC2DeY4CYM1Suzg7DyzkYIn2ZcZlCYk=;
        b=OdmH5c0ctZ0zm1VQmzOxqsLeWGzMWxV90ztmwlxDp9cERFm6A69EKUosgwRIFhkhKq
         s/zDPcWcx5id4kYyET79zgFyj4C5nw9TmxtvfZq20zjRG+w/FFknSuWlJtPWykrGC6xt
         e500XfC/QDPOvK1hK158KCNA6cJBg3izVIxLeFtDKaoaRfxdjE4KTtTsNyWbun3GrtYu
         yK23eRqe1z5a6JubT7B6STVs4CWJ6OsxVqVjVhRweADWZFQWeb8qWViH9XURG6gDw+6A
         tIRU5V5VoMJywnn9EWALMSSGIli3K69ejTkznqGAYPOcQhLS6D0t1e0+Xsuj3Kp3LRl/
         5J5g==
X-Gm-Message-State: AOJu0YzhZIkzULUk6U4A8Frc2DR+jusjawuu+kxjvjkLcxmxx3v9yIvc
	dKL9DzYhJ0Jp/g/wma8TSLa8iTdKVNDitm6W5ODQ4W+l/yxUXMpI3R5HmMeYVX4=
X-Google-Smtp-Source: AGHT+IEQahjQPPWa2xB40VLu/srZEtnpf1fANkgFCX6Px5nEkWl7P5VmoXAQQS171+BwGcV/Ls0FdQ==
X-Received: by 2002:a2e:a683:0:b0:2d4:2b05:a671 with SMTP id 38308e7fff4ca-2e52038a94cmr15844691fa.32.1715352028319;
        Fri, 10 May 2024 07:40:28 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:d421:4f57:ac07:f400? ([2001:67c:2fbc:0:d421:4f57:ac07:f400])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad1f0sm4783519f8f.89.2024.05.10.07.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 07:40:27 -0700 (PDT)
Message-ID: <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net>
Date: Fri, 10 May 2024 16:41:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net> <Zj4k9g1hV1eHQ4Ox@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zj4k9g1hV1eHQ4Ox@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2024 15:45, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:23 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index 36cfb95edbf4..9935a863bffe 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> +/* Called after decrypt to write the IP packet to the device.
>> + * This method is expected to manage/free the skb.
>> + */
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	/* packet integrity was verified on the VPN layer - no need to perform
>> +	 * any additional check along the stack
> 
> But it could have been corrupted before it got into the VPN?

It could, but I believe a VPN should only take care of integrity along 
its tunnel (and this is guaranteed by the OpenVPN protocol).
If something corrupted enters the tunnel, we will just deliver it as is 
to the other end. Upper layers (where the corruption actually happened) 
have to deal with that.

> 
>> +	 */
>> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +	skb->csum_level = ~0;
>> +
> 
> [...]
>> +int ovpn_napi_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct ovpn_peer *peer = container_of(napi, struct ovpn_peer, napi);
>> +	struct sk_buff *skb;
>> +	int work_done = 0;
>> +
>> +	if (unlikely(budget <= 0))
>> +		return 0;
>> +	/* this function should schedule at most 'budget' number of
>> +	 * packets for delivery to the interface.
>> +	 * If in the queue we have more packets than what allowed by the
>> +	 * budget, the next polling will take care of those
>> +	 */
>> +	while ((work_done < budget) &&
>> +	       (skb = ptr_ring_consume_bh(&peer->netif_rx_ring))) {
>> +		ovpn_netdev_write(peer, skb);
>> +		work_done++;
>> +	}
>> +
>> +	if (work_done < budget)
>> +		napi_complete_done(napi, work_done);
>> +
>> +	return work_done;
>> +}
> 
> Why not use gro_cells?

First because I did not know they existed :-)

> It would avoid all that napi polling and
> netif_rx_ring code (and it's per-cpu, going back to our other
> discussion around napi).

This sounds truly appealing. And if we can make this per-cpu by design, 
I believe we can definitely drop the per-peer NAPI logic.

> 
> 
>> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
>> new file mode 100644
>> index 000000000000..0a51104ed931
>> --- /dev/null
>> +++ b/drivers/net/ovpn/proto.h
> [...]
>> +/**
>> + * ovpn_key_id_from_skb - extract key ID from the skb head
>> + * @skb: the packet to extract the key ID code from
>> + *
>> + * Note: this function assumes that the skb head was pulled enough
>> + * to access the first byte.
>> + *
>> + * Return: the key ID
>> + */
>> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
> 
>> +static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
> 
> (tiny nit: those aren't used yet in this patch. probably not worth
> moving them into the right patch.)

ouch. I am already going at a speed of 20-25rph (Rebases Per Hour).
It shouldn't be a problem to clean this up too.

> 
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index f434da76dc0a..07182703e598 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -20,9 +20,117 @@
>>   #include "bind.h"
>>   #include "io.h"
>>   #include "peer.h"
>> +#include "proto.h"
>>   #include "socket.h"
>>   #include "udp.h"
>>   
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user space.
>> + *
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = NULL;
>> +	struct ovpn_struct *ovpn;
>> +	u32 peer_id;
>> +	u8 opcode;
>> +	int ret;
>> +
>> +	ovpn = ovpn_from_udp_sock(sk);
>> +	if (unlikely(!ovpn)) {
>> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
>> +				    __func__);
>> +		goto drop;
>> +	}
>> +
>> +	/* Make sure the first 4 bytes of the skb data buffer after the UDP
>> +	 * header are accessible.
>> +	 * They are required to fetch the OP code, the key ID and the peer ID.
>> +	 */
>> +	if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) + 4))) {
> 
> Is this OVPN_OP_SIZE_V2?

It is! I will use that define. thanks

> 
>> +		net_dbg_ratelimited("%s: packet too small\n", __func__);
>> +		goto drop;
>> +	}
>> +
>> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
>> +		/* DATA_V1 is not supported */
>> +		if (opcode == OVPN_DATA_V1)
>> +			goto drop;
>> +
>> +		/* unknown or control packet: let it bubble up to userspace */
>> +		return 1;
>> +	}
>> +
>> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>> +	/* some OpenVPN server implementations send data packets with the
>> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
>> +	 * and we try with the transport address
>> +	 */
>> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
>> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +		if (!peer) {
>> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
>> +					    __func__, peer_id);
>> +			goto drop;
>> +		}
>> +	}
>> +
>> +	if (!peer) {
>> +		/* data packet with undef peer-id */
>> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
>> +		if (unlikely(!peer)) {
>> +			netdev_dbg(ovpn->dev,
>> +				   "%s: received data with undef peer-id from unknown source\n",
>> +				   __func__);
> 
> _ratelimited?

makes sense. will use net_dbg_ratelimited

> 
>> +			goto drop;
>> +		}
>> +	}
>> +
>> +	/* At this point we know the packet is from a configured peer.
>> +	 * DATA_V2 packets are handled in kernel space, the rest goes to user
>> +	 * space.
>> +	 *
>> +	 * Return 1 to instruct the stack to let the packet bubble up to
>> +	 * userspace
>> +	 */
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> 
> You already handled those earlier, before getting the peer.

ouch..you're right. This can just go.

> 
> 
> [...]
>> @@ -255,10 +368,20 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>>   			return -EALREADY;
>>   		}
>>   
>> -		netdev_err(ovpn->dev, "%s: provided socket already taken by other user\n",
>> +		netdev_err(ovpn->dev,
>> +			   "%s: provided socket already taken by other user\n",
> 
> I guess you meant to break that line in the patch that introduced it,
> rather than here? :)

indeed.

> 
> 
>> +void ovpn_udp_socket_detach(struct socket *sock)
>> +{
>> +	struct udp_tunnel_sock_cfg cfg = { };
>> +
>> +	setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
> 
> I can't find anything in the kernel currently using
> setup_udp_tunnel_sock the way you're using it here.
> 
> Does this provide any benefit compared to just letting the kernel
> disable encap when the socket goes away? Are you planning to detach
> and then re-attach the same socket?

Technically, we don't know what happens to this socket after we detach.
We have no guarantee that it will be closed.

Right now we detach when the instance is closed, so it's likely that the 
socket will go, but I don't want to make hard assumptions about what 
userspace may decide to do with this socket in the future.

If it doesn't hurt, why not doing this easy cleanup?


Thanks!

> 

-- 
Antonio Quartulli
OpenVPN Inc.

