Return-Path: <netdev+bounces-148559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFA9E2266
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A624167EB4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A381F7554;
	Tue,  3 Dec 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAmdzjr6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E01F4709
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239194; cv=none; b=TMjpP89QOIaYMWkbX/emZRi9befkcqgYQmjdNtZLPNzpfn6e/7+WsGl1LYReI7thtYHkf5PVCp6fz3N834lbs0XwQOHN44+8nBgGwf6tkrS5PzjLSL+SR7Ei6un749ZawKL54bRo7FgTdUtMVg6/cHW2JJMrqxl6r1XaL8eeyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239194; c=relaxed/simple;
	bh=W8qGrXe3bRj1Y5AJQrHiF87Sh1brFktXiqV8GbPDha0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrG3C9zrQsIicQPPbT0mObAoMgO5LKDVBnUUEnAKHAQZV65+Bff/zDckXK+mGUIXW1V+vCt01tgKbeoNNJkKO9RWHEHdccBM6n3TpZqpESkUc8KS2cNuy+Ocy6tBozCLMR2jahoG06rna0PEqpV8oycRKVy782umOJTvC8lDSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAmdzjr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733239191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66p4s8wP06Z+ogr+u1zv8IffffNMECDmCGEmHoHtmxU=;
	b=cAmdzjr6uWYk7jIpublioV5/U7NmEhi82q2DY7Z8Y6fkn/5Fm72ASZ/XJqWJECoF8kbJC3
	Zyk1lVncdmmnlvajnjK9c+OW6furDw9RTFvB2VDHwdp5rVLaVrmnDjbuHd/AU4UGewgkIC
	v3Gb1iF0g6WsI25Fud4GIYUlZxSsoqM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-6sOf3GOmOjCLtVDXXvHF2w-1; Tue, 03 Dec 2024 10:19:50 -0500
X-MC-Unique: 6sOf3GOmOjCLtVDXXvHF2w-1
X-Mimecast-MFC-AGG-ID: 6sOf3GOmOjCLtVDXXvHF2w
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b66f8fb697so621733485a.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 07:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239190; x=1733843990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66p4s8wP06Z+ogr+u1zv8IffffNMECDmCGEmHoHtmxU=;
        b=MdTDba/Kv7Xo8YiA/2FQcud+FQkmzpDDH5Jfd8sHYwkz90CV9B5QYRBtbzXH4XgZWU
         IQgT6C/Qflk1CNI2jKqwQA6YLum74xPeiZn5iqspUNdQyVeMQrnTlBDOwYPEYXnM8txc
         g9o5aJyS8sVEO/+tLdSDvCvaqTJO4K/z/SEcLNchxmleZXuD6ghNLfOy50+PKkVlykFi
         8BGJmwrF9LFhHxhcjq6yWPw4U4AY3l/j5bgFse8WWVs5XkXqL3Jfn5M8auRgQQ98SMK8
         hDYKSMmjhgLUVBa8xAtcX3fsVKyCsnehy6wbhbu85kgw+X7mmEY4Rg+1oTqWgJw+Gi5g
         Ehqw==
X-Forwarded-Encrypted: i=1; AJvYcCVfOsnKdnjl0++MKu0zXCW5yX6n5+4MIy3et5eOK1hmecwwh/VQl4kuUzMFkVR50PkyaYUtz7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwou6iyTShlzb9hj2nU6XekayupsvJNxJ6ScPVXCATvwoobhg
	+cvy6ywybvEsm6hX/NY+1Nf7437R0QVmQmMcXsCEU2GE5iKBJua6RKWYGfQ1CNEe5aem6pHM+8Z
	jE2HHA9gNw1xmnJBHF2yXTKOF19gd5OXQgsWBnTc8ERqwlredK1xoAA==
X-Gm-Gg: ASbGncvr7mkXVwzgfZGZORhdLw+vsDml/bMzS5pVRKQahzKXr5vkcj/mAkq2cBOml/4
	BmX64Dk0nNRUjuEvHPLSeXS9modiIKBww7etljhlWRrXJNRF3b/5QB1R/murywI8qUaBVhdGp/q
	vWqbqeA18bsScjeaX6zIq4ToCObeqMQkZulRH+s+pPpfAjxKAg+KtPxMjeP+04FdBUGRQ0EaSGv
	8OJ80RunSWiJA/Hk+4b3lCMQ/9SO2vBfyIVkGlTlYjMnUOsXISSALqXuM63Iw1X1rqpdGj5S6bb
X-Received: by 2002:a05:620a:4898:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b6a5d43dc9mr330905085a.13.1733239189731;
        Tue, 03 Dec 2024 07:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUd+tgeqmGfFLGSGU9BwPAgdjbHK6XPidUMe3MK0uD8X6Akeg8tfjhHGyj6L7JiVZaV5sTgQ==
X-Received: by 2002:a05:620a:4898:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b6a5d43dc9mr330900685a.13.1733239189325;
        Tue, 03 Dec 2024 07:19:49 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492f180sm517904385a.44.2024.12.03.07.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:19:48 -0800 (PST)
Message-ID: <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
Date: Tue, 3 Dec 2024 16:19:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
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
> +
> +	if (!ovpn_sock->peer) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	peer = ovpn_sock->peer;
> +	strp_stop(&peer->tcp.strp);
> +
> +	skb_queue_purge(&peer->tcp.user_queue);
> +
> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
> +	/* drop reference to peer */
> +	rcu_assign_sk_user_data(sock->sk, NULL);
> +
> +	rcu_read_unlock();
> +
> +	barrier();

It's unclear to me the role of the above barrier. A comment would help

> +	/* cancel any ongoing work. Done after removing the CBs so that these
> +	 * workers cannot be re-armed
> +	 */
> +	cancel_work_sync(&peer->tcp.tx_work);
> +	strp_done(&peer->tcp.strp);
> +	skb_queue_purge(&peer->tcp.out_queue);
> +
> +	ovpn_peer_put(peer);
> +}
> +
> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
> +{
> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
> +
> +	if (!skb)
> +		return;
> +
> +	if (peer->tcp.tx_in_progress)
> +		return;
> +
> +	peer->tcp.tx_in_progress = true;
> +
> +	do {
> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
> +					       peer->tcp.out_msg.offset,
> +					       peer->tcp.out_msg.len);
> +		if (unlikely(ret < 0)) {
> +			if (ret == -EAGAIN)
> +				goto out;
> +
> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id, ret);
> +
> +			/* in case of TCP error we can't recover the VPN
> +			 * stream therefore we abort the connection
> +			 */
> +			ovpn_peer_del(peer,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +			break;
> +		}
> +
> +		peer->tcp.out_msg.len -= ret;
> +		peer->tcp.out_msg.offset += ret;
> +	} while (peer->tcp.out_msg.len > 0);
> +
> +	if (!peer->tcp.out_msg.len)
> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
> +
> +	kfree_skb(peer->tcp.out_msg.skb);
> +	peer->tcp.out_msg.skb = NULL;
> +	peer->tcp.out_msg.len = 0;
> +	peer->tcp.out_msg.offset = 0;
> +
> +out:
> +	peer->tcp.tx_in_progress = false;
> +}
> +
> +static void ovpn_tcp_tx_work(struct work_struct *work)
> +{
> +	struct ovpn_peer *peer;
> +
> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
> +
> +	lock_sock(peer->sock->sock->sk);
> +	ovpn_tcp_send_sock(peer);
> +	release_sock(peer->sock->sock->sk);
> +}
> +
> +static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	if (peer->tcp.out_msg.skb)
> +		ovpn_tcp_send_sock(peer);
> +
> +	if (peer->tcp.out_msg.skb) {
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	peer->tcp.out_msg.skb = skb;
> +	peer->tcp.out_msg.len = skb->len;
> +	peer->tcp.out_msg.offset = 0;
> +	ovpn_tcp_send_sock(peer);
> +}
> +
> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	u16 len = skb->len;
> +
> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> +
> +	bh_lock_sock(peer->sock->sock->sk);

Are you sure this runs in BH context? AFAICS we reach here from an AEAD
callback.



> +	if (sock_owned_by_user(peer->sock->sock->sk)) {
> +		if (skb_queue_len(&peer->tcp.out_queue) >=
> +		    READ_ONCE(net_hotdata.max_backlog)) {
> +			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +			kfree_skb(skb);
> +			goto unlock;
> +		}
> +		__skb_queue_tail(&peer->tcp.out_queue, skb);
> +	} else {
> +		ovpn_tcp_send_sock_skb(peer, skb);
> +	}
> +unlock:
> +	bh_unlock_sock(peer->sock->sock->sk);
> +}

[...]

> +static void ovpn_tcp_build_protos(struct proto *new_prot,
> +				  struct proto_ops *new_ops,
> +				  const struct proto *orig_prot,
> +				  const struct proto_ops *orig_ops);
> +
> +/* Set TCP encapsulation callbacks */
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct strp_callbacks cb = {
> +		.rcv_msg = ovpn_tcp_rcv,
> +		.parse_msg = ovpn_tcp_parse,
> +	};
> +	int ret;
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	if (sock->sk->sk_user_data)
> +		return -EBUSY;
> +
> +	/* sanity check */
> +	if (sock->sk->sk_protocol != IPPROTO_TCP) {
> +		net_err_ratelimited("%s: provided socket is not TCP as expected\n",
> +				    netdev_name(peer->ovpn->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* only a fully connected socket are expected. Connection should be
> +	 * handled in userspace
> +	 */
> +	if (sock->sk->sk_state != TCP_ESTABLISHED) {
> +		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
> +				    netdev_name(peer->ovpn->dev),
> +				    sock->sk->sk_state);
> +		return -EINVAL;
> +	}
> +
> +	lock_sock(sock->sk);
> +
> +	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
> +	if (ret < 0) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		release_sock(sock->sk);
> +		return ret;
> +	}
> +
> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
> +	__sk_dst_reset(sock->sk);
> +	skb_queue_head_init(&peer->tcp.user_queue);
> +	skb_queue_head_init(&peer->tcp.out_queue);
> +
> +	/* save current CBs so that they can be restored upon socket release */
> +	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
> +	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
> +	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
> +	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
> +
> +	/* assign our static CBs and prot/ops */
> +	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
> +	sock->sk->sk_write_space = ovpn_tcp_write_space;
> +
> +	if (sock->sk->sk_family == AF_INET) {
> +		sock->sk->sk_prot = &ovpn_tcp_prot;
> +		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
> +	} else {
> +		mutex_lock(&tcp6_prot_mutex);
> +		if (!ovpn_tcp6_prot.recvmsg)
> +			ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
> +					      sock->sk->sk_prot,
> +					      sock->sk->sk_socket->ops);
> +		mutex_unlock(&tcp6_prot_mutex);

This looks like an hack to avoid a build dependency on IPV6, I think the
explicit

#if IS_ENABLED(CONFIG_IPV6)

at init time should be preferable

> +
> +		sock->sk->sk_prot = &ovpn_tcp6_prot;
> +		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
> +	}

[...]

> +static void ovpn_tcp_close(struct sock *sk, long timeout)
> +{
> +	struct ovpn_socket *sock;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +
> +	strp_stop(&sock->peer->tcp.strp);
> +	barrier();

Again, is not clear to me the role of the above barrier, please document it.

Thanks,

Paolo


