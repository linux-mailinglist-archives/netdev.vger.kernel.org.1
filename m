Return-Path: <netdev+bounces-159793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B8A16ECE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDDC1883DBA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2301E492D;
	Mon, 20 Jan 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q5YCBI5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72F1E3791
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384680; cv=none; b=U7b1CJxjdW593m25viIc5orxZU9gYJIcO1mwxMnqAg1ZViAC0BhTb+sP6lV12LlIgqA2hLI+aaUOpjB20FwKNfuKPAVENtcU/rcf2aZ90eLLvgEvmDIfcKM0QLzmXHNYh+7CRzXdVHS9PqLS6UVXVr1roMdFTLOn8hEfyTbPC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384680; c=relaxed/simple;
	bh=D8i5nwAyjVBoAjM4z8/kPO2HqaQsLF74DuIRUfHBInM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO2IEAaLe0mmC7lVhZhtnLr3RM7A2jCH+E5LwkyjKUdrUr9HD+o5ZI0ORMOTWVE1EPJfcRkmJ/ifZKgIPxbo5z0Q5zBmB6mBegcKLAvmB2aVR37260xSePBKf3Pgzm79gv/S0YSANfIxs/lxVMAPnyvAA8B8Ih/kwCIBAhbpzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q5YCBI5Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so6682160a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 06:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737384676; x=1737989476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lMrSPwQldVyn+q8PmfMFwmvU7UuLKvm7RFkwyCDfFOU=;
        b=Q5YCBI5YKO2xjQl8NBGZ9p/gcMo9vP4fxn4X8tzMv+mixmPH6TnU6y1Ge9JgNLiWRW
         BsaLSzQkX08SAZmSFrIihQzLQZzJFFwoU8NTunRVF5WlI8ubO+7VxPS03YP9vFfYJ08a
         Np7aPBhYUDtcHczY5L+jW8LS2b/VXW/q4QMghiUVJI+XHStSpeAKH727GSUznpY7ScbM
         NmwGZqVLqtMFLHAPed4HMffy30FnArRkXlbYpZrVnEY0ZJmK+kaRNDeMCs1WVyHentWm
         l8Jh7PO4Kqzg0tJ9cUF+HPaXaDAbXrhF48BX7qRCV5+1UTiM1DfWVQ1zm5Q7zcga76O1
         9YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737384676; x=1737989476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMrSPwQldVyn+q8PmfMFwmvU7UuLKvm7RFkwyCDfFOU=;
        b=i8JSaxChXpwgbcu1etZiya2ANj86t+VBY6Kz5gLDbLD3sAEJEUMj07z6vk0ny85dxL
         IKqVrek3cQ19G+RMSuhAqHxX8792zUoLVa/qrJuknmR8Y1GqZHueiR2EXkd6K0C1zwjC
         qUl6AXS3z9D+XXd9EB0HnCciXaN1kk+9j9KrP2xH+1lsINgCKD+KdlQcSrnxgwMBBrqD
         qtgiIUvmaqpwXwyaDmrE4Km8ewqyFKi6lUbrGI6NQaXbc83eLlRSjcpy1+1ILaijXtTr
         cbjjjx7c3V+ByX8h0nnPZRnoJvjKsXuGTnwoEOyqWtRjHZp3f6GVjqSS3t304QEfJr7l
         4pkA==
X-Gm-Message-State: AOJu0Yy6CQSDG43UiFWeLpzBndkGwEFQrYBLATPGKU1RvqnvJsXSwoc7
	AXwrLdViUsN+LnGCVXaKWfX39uCnYQmcLyezptfpHpzfhQMETfcpW6qLB2vYfAs=
X-Gm-Gg: ASbGnctHHBBnfJAgypIlsvr1DIZLmQeQU8pSUbwbrlVloc8/zWvzuI5dDv5vhzCsoTu
	xjMoteBVxt3nH1Qez2nPTIw0WcOxkbEFh0yzykY7fX01EO9SSGOWWNNPRjE9TlWeSzRG2GMoYrn
	4SKQiV8HUxVaRGwvQpwnEVsmYCn3ho4sEV6/XQPWgQyab1FyUe6Vzp5k2Jv8gmfuH2wawXJNZ6/
	bnHeq+vV25wuExWwz6PIhyNiA/n1Vnco9n+dKwdu3OML+i3Xk1Kgw6Jh2B99uV/YBRHRClN73u7
	d+h4vY6JE8YTx9T6rdTrfjSaB6hUBFC4
X-Google-Smtp-Source: AGHT+IG5fELimbcCmVaQyg90Mhyt2bCzOBq5fMLC0fBA1TuttVRo9kuv6TdQMbmg0ZtKxAma10CzoQ==
X-Received: by 2002:a05:6402:524b:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5db7db07787mr30236463a12.21.1737384675758;
        Mon, 20 Jan 2025 06:51:15 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:113d:ece6:3d2f:3a40? ([2001:67c:2fbc:1:113d:ece6:3d2f:3a40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb5966sm5866972a12.56.2025.01.20.06.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 06:51:15 -0800 (PST)
Message-ID: <30c50783-096b-4114-aa55-c3edbeb38d49@openvpn.net>
Date: Mon, 20 Jan 2025 15:52:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4pDpqN2hCc-7DGt@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 12:48, Sabrina Dubroca wrote:
[...]
> -------- 8< --------
> 
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 72357bb5f30b..19aa4ee6d468 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -733,6 +733,9 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
>   	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> +	if (ret >= 0 && peer->sock)
> +		wait_for_completion(&peer->sock_detach);
> +
>   	ovpn_peer_put(peer);
>   
>   	return ret;
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index b032390047fe..6120521d0c32 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -92,6 +92,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
>   	ovpn_peer_stats_init(&peer->vpn_stats);
>   	ovpn_peer_stats_init(&peer->link_stats);
>   	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
> +	init_completion(&peer->sock_detach);
>   
>   	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
>   	if (ret < 0) {
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 7a062cc5a5a4..8c54bf5709ef 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -112,6 +112,7 @@ struct ovpn_peer {
>   	struct rcu_head rcu;
>   	struct work_struct remove_work;
>   	struct work_struct keepalive_work;
> +	struct completion sock_detach;
>   };
>   
>   /**
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index a5c3bc834a35..7cefac42c3be 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -31,6 +31,8 @@ static void ovpn_socket_release_kref(struct kref *kref)
>   
>   	sockfd_put(sock->sock);
>   	kfree_rcu(sock, rcu);
> +
> +	complete(&sock->peer->sock_detach);
>   }
>   
>   /**
> @@ -181,12 +183,12 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>   
>   	ovpn_sock->sock = sock;
>   	kref_init(&ovpn_sock->refcount);
> +	ovpn_sock->peer = peer;

Unfortunately this won't work for UDP, because we are taking a reference 
only to the *first* peer using this specific socket (= the peer 
allocating the ovpn_socket object).
All other peers won't get to this line.

Instead, we should somewhat only take the reference to the "last" peer 
using this socket: the peer which will truly ignite the socket detachment.
That's the peer that has to wait upon peer_del for full socket detachment.

Trying to get something smart out of my brains right now ...

Cheers,

>   
>   	/* TCP sockets are per-peer, therefore they are linked to their unique
>   	 * peer
>   	 */
>   	if (sock->sk->sk_protocol == IPPROTO_TCP) {
> -		ovpn_sock->peer = peer;
>   		ovpn_peer_hold(peer);
>   	} else if (sock->sk->sk_protocol == IPPROTO_UDP) {
>   		/* in UDP we only link the ovpn instance since the socket is
> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> index 15827e347f53..3f5a35fd9048 100644
> --- a/drivers/net/ovpn/socket.h
> +++ b/drivers/net/ovpn/socket.h
> @@ -28,12 +28,12 @@ struct ovpn_peer;
>    * @rcu: member used to schedule RCU destructor callback
>    */
>   struct ovpn_socket {
> +	struct ovpn_peer *peer;
>   	union {
>   		struct {
>   			struct ovpn_priv *ovpn;
>   			netdevice_tracker dev_tracker;
>   		};
> -		struct ovpn_peer *peer;
>   	};
>   
>   	struct socket *sock;
> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


