Return-Path: <netdev+bounces-96441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9378C5D80
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664081C20D96
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7949181CF0;
	Tue, 14 May 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YEBkRy0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E38181CE9
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724612; cv=none; b=PCxje3HYtt2zt03z6D9UfJMw2guoxLGwlS2mNr0yTN896/cpw0pHLq8R/1Dw9Ccqd6x/Yp+LBfbSWB3+cNcnhj68MEP90gy9+44lHGmuBcRYWa/xpWfUc03+B146CqR7WfR9aYaNLZ0WoKJbZQzZ2N3U3Q9Nln7DqxOvtiI0Pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724612; c=relaxed/simple;
	bh=7cq+qVAlRi7ViBj2+nLzhn6r8y+G3rlXM/FDcFYuzB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fya0XC6e3DzMf8ct2P21Nfueimf2Ene1R953/El+0xPUBCI4fHVmhbHNtdywFQniBN4/a7cvEfOdAijRpP5Vh8ZZF0+aikLL6Iuu82F6Jfu8stTcNs5phqoyDQiWjMcU0YgS7K58fOfidM7+bXdzY3lwmVc25wrW5vUhDFDI+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YEBkRy0S; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso31432491fa.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715724608; x=1716329408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DJVLynSYUH98kHIvdHi/JQzy1VW0Jf4WiYGR7sz1VDU=;
        b=YEBkRy0SXLULC9mFik0+lSCzCHDbG8Idvw6T3eSZZbApKkuqmPMG5cpTuGBmNrOtlR
         9azjOvFvkSSQTcm/0/xHmOD1Wt/rCyOZxzBMbgJe2LQzS1rHfFuCF8/kLOM13exC0lDj
         ARRSyJiI2jYrdTmq+vV9zV7iCoMfohb4kpbPXVLGKgRKdm8LoIXS10QeheJTU21773lU
         D02HX+n2v2AcqR2hyWf3Pr2TPXAzi0trB2nV8qciPnhITmUyMvkUmod3FivUyAXRHQvE
         HrmckL5CgcJU6vo20ctC5tuzQJDIbVFf92CiN2+hmnCcMb5u74cBWY0f0+PKUgTVE0fl
         h1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715724608; x=1716329408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJVLynSYUH98kHIvdHi/JQzy1VW0Jf4WiYGR7sz1VDU=;
        b=t0LS3NCLm27x3p1XQHm/RuvkTPu5RuY/DAr2h6neW5UtvFRVOkARoZCQcCxrt6mR/+
         HeRxlf7OS3+WdZTiKStwewA8A0AJGpEiAU5468QNIJIBJKLSvg2kJMGS3vQIfWnrJqAi
         pBVlEIHzWbr5G/X4SWZnpne+PVEbblQ1UmS+kKZ/62JpC0xf1O3g7r8Q3Gm5/FnYXc5Z
         8YvO3wZx+e5rGmtCNQud5ShnWmdiB+wzQnVK6NekAtG0H+RAVLXpFxccECHmKKHxIHOD
         OoJgiTTs4djzKjzOAk8RKYN6NIP05R3lmwkMOHTtIDJ50GH4Fg6HF/SrwIGGu6wJPaXj
         li8g==
X-Gm-Message-State: AOJu0Yy3OFyVxUmgwiPHbrn0tcyncsLl3DHChsFy8fITKEgX7hW3zNYe
	zjoafbVlEvn6shAxSSqeA+C69qP117zqAlYpgy09khqYYs/bjzO7zDIQiweftCI=
X-Google-Smtp-Source: AGHT+IFcESKW8o+2z92Dsi8QSrmQ7QaeYtErgbVQc5/RqD3mQb89/NRxXGgKKiDzfRUXR4sGvrCoTA==
X-Received: by 2002:a2e:619:0:b0:2e5:6add:e863 with SMTP id 38308e7fff4ca-2e6da17c4e4mr15484951fa.53.1715724607765;
        Tue, 14 May 2024 15:10:07 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:808d:e76d:a8e1:425b? ([2001:67c:2fbc:0:808d:e76d:a8e1:425b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad1f0sm14828683f8f.89.2024.05.14.15.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:10:07 -0700 (PDT)
Message-ID: <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net>
Date: Wed, 15 May 2024 00:11:28 +0200
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkMnpy3_T8YO3eHD@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2024 10:58, Sabrina Dubroca wrote:
>>>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>>>> index b5ff59a4b40f..ac4907705d98 100644
>>>> --- a/drivers/net/ovpn/peer.h
>>>> +++ b/drivers/net/ovpn/peer.h
>>>> + * @tcp.raw_len: next packet length as read from the stream (TCP only)
>>>> + * @tcp.skb: next packet being filled with data from the stream (TCP only)
>>>> + * @tcp.offset: position of the next byte to write in the skb (TCP only)
>>>> + * @tcp.data_len: next packet length converted to host order (TCP only)
>>>
>>> It would be nice to add information about whether they're used for TX or RX.
>>
>> they are all about "from the stream" and "to the skb", meaning that we are
>> doing RX.
>> Will make it more explicit.
> 
> Maybe group them in a struct rx?

yap, makes sense.

> 
>>>> + * @tcp.sk_cb.sk_data_ready: pointer to original cb
>>>> + * @tcp.sk_cb.sk_write_space: pointer to original cb
>>>> + * @tcp.sk_cb.prot: pointer to original prot object
>>>>     * @crypto: the crypto configuration (ciphers, keys, etc..)
>>>>     * @dst_cache: cache for dst_entry used to send to peer
>>>>     * @bind: remote peer binding
>>>> @@ -59,6 +69,25 @@ struct ovpn_peer {
>>>>    	struct ptr_ring netif_rx_ring;
>>>>    	struct napi_struct napi;
>>>>    	struct ovpn_socket *sock;
>>>> +	/* state of the TCP reading. Needed to keep track of how much of a
>>>> +	 * single packet has already been read from the stream and how much is
>>>> +	 * missing
>>>> +	 */
>>>> +	struct {
>>>> +		struct ptr_ring tx_ring;
>>>> +		struct work_struct tx_work;
>>>> +		struct work_struct rx_work;
>>>> +
>>>> +		u8 raw_len[sizeof(u16)];
>>>
>>> Why not u16 or __be16 for this one?
>>
>> because in this array we are putting the bytes as we get them from the
>> stream.
>> We may be at the point where one out of two bytes is available on the
>> stream. For this reason I use an array to store this u16 byte by byte.
>>
>> Once thw two bytes are ready, we convert the content in an actual int and
>> store it in "data_len" (a few lines below).
> 
> Ok, I see. Hopefully you can switch to strparser and make this one go
> away.
> 
> 
>>>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>>>> index e099a61b03fa..004db5b13663 100644
>>>> --- a/drivers/net/ovpn/socket.c
>>>> +++ b/drivers/net/ovpn/socket.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include "packet.h"
>>>>    #include "peer.h"
>>>>    #include "socket.h"
>>>> +#include "tcp.h"
>>>>    #include "udp.h"
>>>>    /* Finalize release of socket, called after RCU grace period */
>>>> @@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
>>>>    	if (sock->sk->sk_protocol == IPPROTO_UDP)
>>>>    		ovpn_udp_socket_detach(sock);
>>>> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
>>>> +		ovpn_tcp_socket_detach(sock);
>>>>    	sockfd_put(sock);
>>>>    }
>>>> @@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>>>>    	if (sock->sk->sk_protocol == IPPROTO_UDP)
>>>>    		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
>>>> +	else if (sock->sk->sk_protocol == IPPROTO_TCP)
>>>> +		ret = ovpn_tcp_socket_attach(sock, peer);
>>>>    	return ret;
>>>>    }
>>>> @@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>>>>    	ovpn_sock->sock = sock;
>>>
>>> The line above this is:
>>>
>>>       ovpn_sock->ovpn = peer->ovpn;
>>>
>>> It's technically fine since you then overwrite this with peer in case
>>> we're on TCP, but ovpn_sock->ovpn only exists on UDP since you moved
>>> it into a union in this patch.
>>
>> Yeah, I did not want to make another branch, but having a UDP specific case
>> will make code easier to read.
> 
> Either that, or drop the union.

ACK

> 
> 
>>>> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
>>>> new file mode 100644
>>>> index 000000000000..84ad7cd4fc4f
>>>> --- /dev/null
>>>> +++ b/drivers/net/ovpn/tcp.c
>>>> @@ -0,0 +1,511 @@
>>>> +static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
>>>> +			      unsigned int in_offset, size_t in_len)
>>>> +{
>>>> +	struct sock *sk = desc->arg.data;
>>>> +	struct ovpn_socket *sock;
>>>> +	struct ovpn_skb_cb *cb;
>>>> +	struct ovpn_peer *peer;
>>>> +	size_t chunk, copied = 0;
>>>> +	void *data;
>>>> +	u16 len;
>>>> +	int st;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	sock = rcu_dereference_sk_user_data(sk);
>>>> +	rcu_read_unlock();
>>>
>>> You can't just release rcu_read_lock and keep using sock (here and in
>>> the rest of this file). Either you keep rcu_read_lock, or you can take
>>> a reference on the ovpn_socket.
>>
>> I was just staring at this today, after having worked on the
>> rcu_read_lock/unlock for the peer get()s..
>>
>> I thinkt the assumption was: if we are in this read_sock callback, it's
>> impossible that the ovpn_socket was invalidated, because it gets invalidated
>> upon detach, which also prevents any further calling of this callback. But
>> this sounds racy, and I guess we should somewhat hold a reference..
> 
> ovpn_tcp_read_sock starts
> 
> detach
> kfree_rcu(ovpn_socket)
> ...
> ovpn_socket actually freed
> ...
> ovpn_tcp_read_sock continues with freed ovpn_socket
> 
> 
> I don't think anything in the current code prevents this.

mh yeah, if something like this happens right after having started the 
read_sock we are doomed.
Will fix this.


> 
> 
>>>> +/* Set TCP encapsulation callbacks */
>>>> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>>>> +{
>>>> +	void *old_data;
>>>> +	int ret;
>>>> +
>>>> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
>>>> +
>>>> +	ret = ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
>>>> +	if (ret < 0) {
>>>> +		netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	peer->tcp.skb = NULL;
>>>> +	peer->tcp.offset = 0;
>>>> +	peer->tcp.data_len = 0;
>>>> +
>>>> +	write_lock_bh(&sock->sk->sk_callback_lock);
>>>> +
>>>> +	/* make sure no pre-existing encapsulation handler exists */
>>>> +	rcu_read_lock();
>>>> +	old_data = rcu_dereference_sk_user_data(sock->sk);
>>>> +	rcu_read_unlock();
>>>> +	if (old_data) {
>>>> +		netdev_err(peer->ovpn->dev,
>>>> +			   "provided socket already taken by other user\n");
>>>> +		ret = -EBUSY;
>>>> +		goto err;
>>>
>>> The UDP code differentiates "socket already owned by this interface"
>>> from "already taken by other user". That doesn't apply to TCP?
>>
>> This makes me wonder: how safe it is to interpret the user data as an object
>> of type ovpn_socket?
>>
>> When we find the user data already assigned, we don't know what was really
>> stored in there, right?
>> Technically this socket could have gone through another module which
>> assigned its own state.
>>
>> Therefore I think that what UDP does [ dereferencing ((struct ovpn_socket
>> *)user_data)->ovpn ] is probably not safe. Would you agree?
> 
> Hmmm, yeah, I think you're right. If you checked encap_type ==
> UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
> really your data. Basically call ovpn_from_udp_sock during attach if
> you want to check something beyond EBUSY.

right. Maybe we can leave with simply reporting EBUSY and be done with 
it, without adding extra checks and what not.

> 
> Once you're in your own callbacks, it should be safe. If some other
> code sends packet with a non-ovpn socket to ovpn's ->encap_rcv,
> something is really broken.

yup

> 
>>>> +int __init ovpn_tcp_init(void)
>>>> +{
>>>> +	/* We need to substitute the recvmsg and the sock_is_readable
>>>> +	 * callbacks in the sk_prot member of the sock object for TCP
>>>> +	 * sockets.
>>>> +	 *
>>>> +	 * However sock->sk_prot is a pointer to a static variable and
>>>> +	 * therefore we can't directly modify it, otherwise every socket
>>>> +	 * pointing to it will be affected.
>>>> +	 *
>>>> +	 * For this reason we create our own static copy and modify what
>>>> +	 * we need. Then we make sk_prot point to this copy
>>>> +	 * (in ovpn_tcp_socket_attach())
>>>> +	 */
>>>> +	ovpn_tcp_prot = tcp_prot;
>>>
>>> Don't you need a separate variant for IPv6, like TLS does?
>>
>> Never did so far.
>>
>> My wild wild wild guess: for the time this socket is owned by ovpn, we only
>> use callbacks that are IPvX agnostic, hence v4 vs v6 doesn't make any
>> difference.
>> When this socket is released, we reassigned the original prot.
> 
> That seems a bit suspicious to me. For example, tcpv6_prot has a
> different backlog_rcv. And you don't control if the socket is detached
> before being closed, or which callbacks are needed. Your userspace
> client doesn't use them, but someone else's might.
> 
>>>> +	ovpn_tcp_prot.recvmsg = ovpn_tcp_recvmsg;
>>>
>>> You don't need to replace ->sendmsg as well? The userspace client is
>>> not expected to send messages?
>>
>> It is, but my assumption is that those packets will just go through the
>> socket as usual. No need to be handled by ovpn (those packets are not
>> encrypted/decrypted, like data traffic is).
>> And this is how it has worked so far.
>>
>> Makes sense?
> 
> Two things come to mind:
> 
> - userspace is expected to prefix the messages it inserts on the
>    stream with the 2-byte length field? otherwise, the peer won't be
>    able to parse them out of the stream

correct. userspace sends those packets as if ovpn is not running, 
therefore this happens naturally.

> 
> - I'm not convinced this would be safe wrt kernel writing partial
>    messages. if ovpn_tcp_send_one doesn't send the full message, you
>    could interleave two messages:
> 
>    +------+-------------------+------+--------+----------------+
>    | len1 | (bytes from msg1) | len2 | (msg2) | (rest of msg1) |
>    +------+-------------------+------+--------+----------------+
> 
>    and the RX side would parse that as:
> 
>    +------+-----------------------------------+------+---------
>    | len1 | (bytes from msg1) | len2 | (msg2) | ???? | ...
>    +------+-------------------+---------------+------+---------
> 
>    and try to interpret some random bytes out of either msg1 or msg2 as
>    a length prefix, resulting in a broken stream.

hm you are correct. if multiple sendmsg can overlap, then we might be in 
troubles, but are we sure this can truly happen?

> 
> 
> The stream format looks identical to ESP in TCP [1] (2B length prefix
> followed by the actual message), so I think the espintcp code (both tx
> and rx, except for actual protocol parsing) should look very
> similar. The problems that need to be solved for both protocols are
> pretty much the same.

ok, will have a look. maybe this will simplify the code even more and we 
will get rid of some of the issues we were discussing above.

Thanks!

> 
> [1] https://www.rfc-editor.org/rfc/rfc8229#section-3
> 

-- 
Antonio Quartulli
OpenVPN Inc.

