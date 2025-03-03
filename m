Return-Path: <netdev+bounces-171284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC4A4C59C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF443A6C4E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3F214A6C;
	Mon,  3 Mar 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="anCV8BAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449272135BB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016912; cv=none; b=NSjZpHLln8gSMH3n4X/LzLhgeU3m5r9oA8BWyoQG6slc8s4J8Dk1NbI03USmImWPSPW/cipuhCO8UMeUHWjftyI1lRpdsu6p+jplZkpAv/ztWHU0EiHy5EMX3NzfqLneLK+MwTtAOaqP4FmTadlHjT3kN8cCYNaVfzxBAnDCFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016912; c=relaxed/simple;
	bh=GvBQXDAExHhIoaeNDYf7g2nDwnhSBt0QXSTd6c1GJxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHRJYROtp1wgoRposVHyhLmQw4IWjyIkMiChuYqVTKElS/LrENxwVwZAKJRFxzTEtCf3rI/DNDLZlEcBXoIafi5VfRJ3Tr2zjZMoVMjGH1AVmPdgVFFkZ6wLDIKjYky7nIajlxXWvJCXLnjPJFwy2/ib7zXInl/lcwNREuB8CEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=anCV8BAS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf518748cbso375988866b.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741016907; x=1741621707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOMakgKQx0eH+GJzwtnG1x0Qnn1CoGhsn97/jTx5QWQ=;
        b=anCV8BASAUopfYD4nTXTC6gmnSyFVZEg08ELqLg+p1CI2r1zZEFROqw40eB9LswwCK
         ZiY5aJ9SQEG8jaN0a4zMi1YdbNDFKVDC5CzakH5mZ+apSMrThvPv51PQDG+FP6k50K7R
         ogaQeyysmB7rLUZt54TZU3NKi/b2QOHKdjt940LHEX7jCnC68YmlWwcPE9MYH9AwJBEJ
         Uab+3jFraQviOXnLKmbQqeAjI+znrt1FFJYEHWqJXhEHrBQSQKJcikTnU1NDjmBe0TVP
         JqSxUauppnJe14EuwBk8L3L8Pz/GaS7E6Roqy2o36KjALChGGJ3ZCMiB5ZAkI7quNNmF
         IVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016907; x=1741621707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOMakgKQx0eH+GJzwtnG1x0Qnn1CoGhsn97/jTx5QWQ=;
        b=hTW9zndxFIBw/d14EW2uM75tlbtYweZkGv2Xi9KW94e1HtnW8JcSThkbcxwySBW03k
         Y1mpZZUt1gZrOKwhrQpqxEJcjqq7DHv5tMjf36cL4Roa35wW6qOyIAynZ5JRBIhC4DY9
         oOFEHEL3WZcx5O+AdjcjX11bhT0hg7om0O/kBrYA8sCpNpFN21bn4bQ0G7toImHVXrSQ
         /4orkfrOG1U++oLCkaMLnTMttAoQjC4mdiv8STDGcFzhFLzk6TKMOdhQMAUsZdb5xy2M
         08tYeCxGghLAILowEC2Oze+wAa2PybmB0G/P2uJ2K555ksF/hPcoKtXg0Nrsx4y4oVAD
         OfgQ==
X-Gm-Message-State: AOJu0YxrgweWUaZWwmeYB0yDQ1+CC+35kLj8Ne5X9ZHtKkSur31SmoSn
	Qj5y9q6Vj8RJdsTn5/dumk5sXCp4oYKqFF39BQs6dz9mI9ET76u2OFOH0FStahMgQ8jX//HzVh8
	m
X-Gm-Gg: ASbGncsW+rAQIFmHdD6lOdNRYm89HEC9sIijR91blVt/y4oOMu/a/qmcuL9bmOP/d70
	bqyAWaDDysNHummc8PJbmtqN7YPfZfFyhDRJnlQmlN9oJeYSujYi479xLdsKXy4iSYiUQlXxqqv
	L9SoRBz9Q9Baoe1Tini6kbFvOqWqCoG/Fgx4PS1IDJOfJo02tGrvLDeaB8WvT67Pz4rdMH6lGK0
	sEHies6E3n6WuLcmV1QYtmEhtoDZjJqUoW1KfF2D5BB2q1oG48SjxrI2UoV1Ohq5/vvY6UJaH4F
	BghRlhJ7eXn8MgplU6XcpS7Zb64Lz/flvrP6emdZA31Iaj+RcLcLbbSPng3cjVq76bufatT27Og
	1VveIJDg=
X-Google-Smtp-Source: AGHT+IFh+oc/+WAkYigvqvS40UJ1I+acg+Km1DM/dYuXAp2oKan5OP1S1MtzddnzXF/eE3J9sAa74w==
X-Received: by 2002:a17:907:3f9a:b0:abe:dc99:7086 with SMTP id a640c23a62f3a-abf26824d36mr1816293566b.55.1741016907491;
        Mon, 03 Mar 2025 07:48:27 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d41:ca07:21a5:f110? ([2001:67c:2fbc:1:4d41:ca07:21a5:f110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm205268766b.131.2025.03.03.07.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 07:48:27 -0800 (PST)
Message-ID: <c5c4e113-e86c-42ef-861b-3a6bc9d8ad19@openvpn.net>
Date: Mon, 3 Mar 2025 16:48:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 12/25] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 David Ahern <dsahern@kernel.org>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net> <Z8XF06vDCNreOL4E@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8XF06vDCNreOL4E@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 16:08, Sabrina Dubroca wrote:
> 2025-02-27, 02:21:37 +0100, Antonio Quartulli wrote:
>> @@ -94,11 +96,23 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>>   	 * detached before it can be picked by a concurrent reader.
>>   	 */
>>   	lock_sock(sock->sock->sk);
>> -	ovpn_socket_put(peer, sock);
>> +	released = ovpn_socket_put(peer, sock);
>>   	release_sock(sock->sock->sk);
>>   
>>   	/* align all readers with sk_user_data being NULL */
>>   	synchronize_rcu();
>> +
>> +	/* following cleanup should happen with lock released */
>> +	if (released) {
>> +		if (sock->sock->sk->sk_protocol == IPPROTO_UDP) {
>> +			netdev_put(sock->ovpn->dev, &sock->dev_tracker);
>> +		} else if (sock->sock->sk->sk_protocol == IPPROTO_TCP) {
>> +			/* wait for TCP jobs to terminate */
>> +			ovpn_tcp_socket_wait_finish(sock);
>> +			ovpn_peer_put(sock->peer);
>> +		}
>> +		kfree_rcu(sock, rcu);
> 
> kfree_rcu after synchronize_rcu is a bit unexpected. Do we still need
> to wait before we free sock, now that we have synchronize_rcu before?

Ah good point. Waiting one RCU period is what kfree_rcu() is there for, 
hence we could just call kfree() at this point.

> 
>> +	}
>>   }
>>   
> 
> 
> 
>> +static int ovpn_tcp_parse(struct strparser *strp, struct sk_buff *skb)
>> +{
>> +	struct strp_msg *rxm = strp_msg(skb);
>> +	__be16 blen;
>> +	u16 len;
>> +	int err;
>> +
>> +	/* when packets are written to the TCP stream, they are prepended with
>> +	 * two bytes indicating the actual packet size.
>> +	 * Here we read those two bytes and move the skb data pointer to the
>> +	 * beginning of the packet
> 
> There's no update to skb->data being done in ovpn_tcp_parse AFAICT.

I concur :)

> 
> [...]
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = container_of(strp, struct ovpn_peer, tcp.strp);
>> +	struct strp_msg *msg = strp_msg(skb);
>> +	size_t pkt_len = msg->full_len - 2;
>> +	size_t off = msg->offset + 2;
>> +	u8 opcode;
>> +
>> +	/* ensure skb->data points to the beginning of the openvpn packet */
>> +	if (!pskb_pull(skb, off)) {
> 
> Is that the one you mean in the previous comment?

Yes. The comment was probably placed there in a previous 
version/prototype and never moved.

I'll fix that.

> 
>> +		net_warn_ratelimited("%s: packet too small for peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		goto err;
>> +	}
> [some checks]
>> +	/* DATA_V2 packets are handled in kernel, the rest goes to user space */
>> +	opcode = ovpn_opcode_from_skb(skb, 0);
>> +	if (unlikely(opcode != OVPN_DATA_V2)) {
>> +		if (opcode == OVPN_DATA_V1) {
>> +			net_warn_ratelimited("%s: DATA_V1 detected on the TCP stream\n",
>> +					     netdev_name(peer->ovpn->dev));
>> +			goto err;
> 
> In TCP encap, receiving OVPN_DATA_V1 packets is going to kill the peer:
> 
>> +err:
>> +	dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +	kfree_skb(skb);
>> +	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +}
>> +
> 
> but that's not the case with the UDP encap (ovpn_udp_encap_recv simply
> drops those packets). Should the TCP/UDP behavior be consistent?

Ideally a UDP DATA_V1 could be just a replayed/spoofed packet, so 
killing the peer doesn't sound good. It'd be a very easy attack.

Doing the same in TCP is much much harder (if practical at all) and in 
that case it'd be impossible to understand what's happening on the 
stream, so we just abort.

I think any TCP connection (without TCP-MD5) that gets messed up this 
way will abort.


> 
> 
> 
> 
>> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct socket *sock,
>> +		       struct sk_buff *skb)
>> +{
>> +	u16 len = skb->len;
>> +
>> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
>> +
>> +	spin_lock_nested(&sock->sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
> 
> With this, lockdep is still going to complain in the unlikely case
> that ovpn-TCP traffic is carried over another ovpn-TCP socket, right?
> (probably fine to leave it like that)

Yeah.
I am not sure how much complexity we'd need to workaround that.
I also assume it's fine to keep it this way (this is also what L2TP does).

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
>> +	lock_sock(sk);
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
>> +		rcu_read_unlock();
>> +		release_sock(sk);
>> +		return -EIO;
>> +	}
>> +	rcu_read_unlock();
>> +	peer = sock->peer;
> 
> This used to be done under RCU in previous versions of the series. Why
> is it after rcu_read_unlock now? (likely safe since we're under
> lock_sock so detach can't happen)

Yeah, while restructuring I assumed it could be taken out of the RCU 
read section and so I kept it out.

> 
>> +
>> +	if (msg->msg_flags & ~MSG_DONTWAIT) {
>> +		ret = -EOPNOTSUPP;
>> +		goto peer_free;
>> +	}
> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


