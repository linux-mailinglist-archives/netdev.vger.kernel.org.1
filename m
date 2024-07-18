Return-Path: <netdev+bounces-112044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F38934B80
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0362428362C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF381720;
	Thu, 18 Jul 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IP+UVJ6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B918C06
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721297502; cv=none; b=CUfib1GafPG+Strauakca3LorzZDuhHNZpk33fwYOwsEikl2lJPrhYS8zVpx9x5NpJkyM+etxpbpz84OWSgewHI00JaTW0rg4kNkvGK0VTq/S8lGNr0RXHqOdGaWCxED+jOJuIDU2m5ICiwxMebCf7q1mRmZmex3kIoqY+Er4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721297502; c=relaxed/simple;
	bh=qSQoh2sbPEQRz2m4VpHoQFcyPQkea1pPhHbyvxJnDos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6PgTBAt6eKuRpgYQbfdCtUD/X7Q/GBimDaht3QVxfDHgntQ1u3gIjMwvcn8BwtrVgw/b31xHSQbqlhhZ12+bno+6aA7zUA1ICemNPmVdME7sUDkMbLrgSA2A7JSp1P8dhaVFPWdPk127lKPS2PTd+R27aNOtiFU0Ym/vqkOIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IP+UVJ6p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so1081095e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721297499; x=1721902299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zSBkHmNnBYgRR+3IDJsLbc40jCdTKvMPx7DVu2kSa6Y=;
        b=IP+UVJ6pF4UW2sEPBqYi72ZgeFmJRovnV6/RC9Tnu2sPUniSd5jALTsTNaihdCjgtW
         XBZ5tcq4Tcoq/NWKB8IDf7l5M0FEgySsDIfysD5sUTpYvvXGq+THUTOXmjJ2f7nVU2aq
         a0mjsisPz+qVNggVgLNlhAge7kWJisDk9uUA0NeLyCVDW0zpu1/DgI9WWJpRXeHMMseX
         7fGlcplSHjSRSSBlgOK2azGbPxV+7SEtPYoGEOl6urhQroVosQ1+7cg5AyZ2douuuTnH
         56Kx/1apHRVe1V184HwJWCe9pdxuVgExDmZt7VBOAaWh40/pTxjrjesIeeMcZkMwZR+o
         RLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721297499; x=1721902299;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSBkHmNnBYgRR+3IDJsLbc40jCdTKvMPx7DVu2kSa6Y=;
        b=Vt86fX5V7MKUizae2GaQF0yGzeJiVo73o/H0gAiVhgo1RBVjVM6EN10VhEELd/Ip36
         UnXkdxk3a8bipCo1dCYXfs2J4jnH0wcx1FjxmsCWwYngcYv8IMEnmgJXJsnZ9tQKW9HR
         OBsjHLFScbSvSyA0nOmTWCGDnz9lXK7WCefz4OQjE7q+5e9wjzzxHsbhuA43tL8ppa2x
         xQxnvc8wvkbeSvZO5FWA+M9tDQrHh4haZXCgok23UUu7LQO16xpyvzMAEIQy9VF/IqLB
         51bjabYeArW52P7EQwpgb0yt7YDgZmoO1vE3EmworJVkZK67UiHG7O7vxgLHBR8mDJCB
         jX5g==
X-Gm-Message-State: AOJu0YwMP3xLPtnCU9dbPoy3z/VCFzvLcReAWa7NQ53HdxwqcRxu96uu
	L0ykR6tfBylhLZF4hZCkXQ5/gtYvRATyaVfqyFspgslO8FwXyv5wmnjB9UGem9s=
X-Google-Smtp-Source: AGHT+IH8j5af49TjTr+kgOQEeFb93tKXWmhHrqnx8QNKPGY71ZdUlkpELZm+o2oeiXmPs8EN64WF5g==
X-Received: by 2002:a05:600c:3501:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-427c2cc3774mr29309295e9.11.1721297498610;
        Thu, 18 Jul 2024 03:11:38 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1e67esm5220305e9.28.2024.07.18.03.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 03:11:38 -0700 (PDT)
Message-ID: <8c6d237f-dde7-4922-b92d-6a638fc7376e@openvpn.net>
Date: Thu, 18 Jul 2024 12:13:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 14/25] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-15-antonio@openvpn.net> <ZpTy860ss-JwT_2W@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpTy860ss-JwT_2W@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/07/2024 11:59, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:32 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index 0475440642dd..764b3df996bc 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -21,6 +21,7 @@
>>   #include "netlink.h"
>>   #include "proto.h"
>>   #include "socket.h"
>> +#include "tcp.h"
>>   #include "udp.h"
>>   #include "skb.h"
>>   
>> @@ -84,8 +85,11 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>>   	/* PID sits after the op */
>>   	pid = (__force __be32 *)(skb->data + OVPN_OP_SIZE_V2);
>>   	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
>> -	if (unlikely(ret < 0))
>> +	if (unlikely(ret < 0)) {
>> +		net_err_ratelimited("%s: PKT ID RX error: %d\n",
>> +				    peer->ovpn->dev->name, ret);
> 
> nit: this should be part of the "packet processing" patch?

Yap, makes sense.

> 
> 
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index dd4d91dfabb5..86d4696b1529 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -10,8 +10,8 @@
>>   #ifndef _NET_OVPN_OVPNPEER_H_
>>   #define _NET_OVPN_OVPNPEER_H_
>>   
>> -#include <linux/ptr_ring.h>
> 
> nit: I think you don't need it at all in this version and forgot to
> drop it in a previous patch? (I didn't notice when it was introduced)

Ouch, you are correct

> 
> 
> 
>> +static int ovpn_tcp_to_userspace(struct ovpn_socket *sock, struct sk_buff *skb)
>> +{
>> +	struct sock *sk = sock->sock->sk;
>> +
>> +	skb_set_owner_r(skb, sk);
>> +	memset(skb->cb, 0, sizeof(skb->cb));
> 
> nit: this was just done in ovpn_tcp_rcv

right!

> 
>> +	skb_queue_tail(&sock->peer->tcp.user_queue, skb);
>> +	sock->peer->tcp.sk_cb.sk_data_ready(sk);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
> [...]
>> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>> +	if (likely(ovpn_opcode_from_skb(skb, 0) == OVPN_DATA_V2)) {
>> +		/* hold reference to peer as required by ovpn_recv().
>> +		 *
>> +		 * NOTE: in this context we should already be holding a
>> +		 * reference to this peer, therefore ovpn_peer_hold() is
>> +		 * not expected to fail
>> +		 */
>> +		WARN_ON(!ovpn_peer_hold(peer));
> 
> drop the packet if this fails? otherwise I suspect we'll crash later on.

yeah, jumping to "err" and dropping everything makes sense.

> 
>> +		ovpn_recv(peer, skb);
>> +	} else {
>> +		/* The packet size header must be there when sending the packet
>> +		 * to userspace, therefore we put it back
>> +		 */
>> +		skb_push(skb, 2);
>> +		memset(skb->cb, 0, sizeof(skb->cb));
>> +		if (ovpn_tcp_to_userspace(peer->sock, skb) < 0) {
>> +			net_warn_ratelimited("%s: cannot send skb to userspace\n",
>> +					     peer->ovpn->dev->name);
>> +			goto err;
>> +		}
>> +	}
> [...]
> 
> 
>> +void ovpn_tcp_socket_detach(struct socket *sock)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +	struct ovpn_peer *peer;
>> +
>> +	if (!sock)
>> +		return;
>> +
>> +	rcu_read_lock();
>> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>> +
> [...]
>> +	/* cancel any ongoing work. Done after removing the CBs so that these
>> +	 * workers cannot be re-armed
>> +	 */
>> +	cancel_work_sync(&peer->tcp.tx_work);
> 
> I don't think that's ok to call under rcu_read_lock, it seems it can
> sleep.
> 
>> +	strp_done(&peer->tcp.strp);
> 
> And same here, since strp_done also calls cancel_work_sync.

hm you're right. I'll see how to re-arrange this part..I expect this to 
be tricky.


> 
>> +	rcu_read_unlock();
>> +}
>> +
>> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
>> +{
>> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
>> +
>> +	if (!skb)
>> +		return;
>> +
>> +	if (peer->tcp.tx_in_progress)
>> +		return;
>> +
>> +	peer->tcp.tx_in_progress = true;
> 
> I'm not convinced this is safe. ovpn_tcp_send_sock could run
> concurrently for the same peer (lock_sock doesn't exclude bh_lock_sock
> after the short "grab ownership" phase), so I think both sides could
> see tx_in_progress = false and then proceed.

I may be missing something here.
I was under the impression that ovpn_tcp_send_sock() is always invoked 
with lock_sock() held. Shouldn't that be enough to prevent concurrent 
executions for the same peer/sock?

> 
> 
>> +	do {
>> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
>> +					       peer->tcp.out_msg.offset,
>> +					       peer->tcp.out_msg.len);
>> +		if (unlikely(ret < 0)) {
>> +			if (ret == -EAGAIN)
>> +				goto out;
> 
> This will silently drop the message? And then in case of a userspace
> message, ovpn_tcp_sendmsg will lie to the user (the openvpn client),
> claiming that the control message was sent (ret = size just above the
> unlock)?

why do you think the message will be dropped?

By jumping to 'out' we are keeping the skb in peer->tcp.out_msg.skb, 
with peer->tcp.out_msg.offset and peer->tcp.out_msg.len left untouched 
and ready for the next attempt triggered by ovpn_tcp_write_space().

> 
>> +
>> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
>> +					     peer->ovpn->dev->name, peer->id,
>> +					     ret);
>> +
>> +			/* in case of TCP error we can't recover the VPN
>> +			 * stream therefore we abort the connection
>> +			 */
>> +			ovpn_peer_del(peer,
>> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +			break;
>> +		}
>> +
>> +		peer->tcp.out_msg.len -= ret;
>> +		peer->tcp.out_msg.offset += ret;
>> +	} while (peer->tcp.out_msg.len > 0);
> 
> Another thing that worries me: assume the receiver is a bit slow, the
> underlying TCP socket gets stuck. skb_send_sock_locked manages to push
> some data down the TCP socket, but not everything. We advance by that
> amount, and restart this loop. The socket is still stuck, so
> skb_send_sock_locked returns -EAGAIN. We have only pushed a partial
> message down to the TCP socket, but we drop the rest? Now the stream
> is broken, and the next call to ovpn_tcp_send_sock will happily send
> its message.

I think this is answered above, where I say that we are actually keeping 
the skb (not dropping it) ready for the next sending attempt.

> 
> ovpn_tcp_send_sock with msg_len = 1000
> iteration 1
>    skb_send_sock_locked returns 100
>    advance
> iteration 2
>    skb_send_sock_locked returns -EAGAIN
>    goto out
> 
> 
> So you'd have to keep that partially-sent message around until you can
> finish pushing it out on the socket.

yap, see above.

> 
> 
> [...]
>> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>> +{
>> +	struct ovpn_socket *sock;
>> +	int ret, linear = PAGE_SIZE;
>> +	struct ovpn_peer *peer;
>> +	struct sk_buff *skb;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	peer = sock->peer;
>> +	rcu_read_unlock();
> 
> What's stopping the peer being freed here?

I assumed that while we are in our own sk_cb it should not be possible 
for a peer to have refcnt reaching 0.

But after double checking I don't think there is any protection about 
this. I Will add a call to ovpn_peer_hold() and abort if that call fails.

-- 
Antonio Quartulli
OpenVPN Inc.

