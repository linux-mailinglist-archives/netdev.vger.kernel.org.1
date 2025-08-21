Return-Path: <netdev+bounces-215646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC728B2FC91
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AE71D00302
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3935267B02;
	Thu, 21 Aug 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ei7OMPF3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985C2367AE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785930; cv=none; b=LBl4PuCprIqN0q7LBxTSTsfIhqisPEHALfTQvDoH5Uesv7YGBG0vlpE+msLWzNnPX60xAgJvIm7lTJHbzVkh9oXWBTVLqic7SORlPE1QBa/BN/46Z0C9/JTsL2YOqP9uIMswAhyqk74cVsuMsmlS58zpYrkW7dtuOpMWjB09dKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785930; c=relaxed/simple;
	bh=6fYOKYDWtJXk/nb3SNwoXg8QDC7pMUsBU5vYe0/EFT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5GlyrNJYGOIO2uXr/95zEvrR4HcgFikpdDUCBb1jtBvxSjvgzP27zEmULT3LunUaEhofVWQ6THT2MroGyfdOEeRmhbMSYIlwH3DtP+6O9FwOaGIv4tZPLsZ/hXbTq8w1XWAjd/iHC026h4KHkmKIgr6lziqJIZqzL47DApTJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ei7OMPF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755785928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2W2WJn9o2ImqIVXfkc9IKgb9T6LWDj6xaBh01W7LZY=;
	b=ei7OMPF3c2W3FWndLAyUcqBlQHnJxDjPuIzZchleiBxyFaaCOSypZXZJ8jvf10J9QTM+yU
	UDaxeG4s5SwBT+VSchGs3FcErnk7bxP/AfMm8GOMXxgAbKMg/tfOvLth+gM6TfrWUKjDhw
	2500MkRQs4KvtEQPfaW+0veOazqK/pY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-yF1h1VluM22SU2N0jW85UQ-1; Thu, 21 Aug 2025 10:18:47 -0400
X-MC-Unique: yF1h1VluM22SU2N0jW85UQ-1
X-Mimecast-MFC-AGG-ID: yF1h1VluM22SU2N0jW85UQ_1755785926
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b4ab71653so7377965e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785926; x=1756390726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2W2WJn9o2ImqIVXfkc9IKgb9T6LWDj6xaBh01W7LZY=;
        b=PFDtvVciMVRj8kAhn4MCN1WapeQbDO7Shhh/kxc6cM/pccFEobo6zVlHed2Tnrr/+4
         7MiHw3wkEE1y7bq0k8pNlJW4r6hE8SpIwIAyyWyFjkepjGKjy+/C0Xo0UwJgnDJ8oniq
         0Q0B5fSNT/cV4roOu2aJTRAaQRAWV3kmcu4uZ2NFAp+eurVSOnt+20QFnC185SgPB7EP
         D8CS1yX5k6pxC22WalCPaktPg5dWw4NHJ0S07mJRs/9cI5jBotJYo+vZP0hI5Tcv5LYB
         PCq65fwdkYOCM5nUuijtcCJIpdlKR73mMRL48+zgzNiz7FC2q5REZIwbc2Gs0rIk81hC
         sU8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoo12jea2z+B5xSSpudEWYwr49ZSI8nNzLPrjs0Gv+3NhSKQ3MSlr//6tko0uq0S8ZNHDZLTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/xLIABRELctupUcNKj5UcmZMB1IitA3eyTM79As3oB3x0FAz
	ECBE0NH2JxwsUlmq0Uk99vQBJC2tspO6cTtbGn9xY8McXoSlgAE8iPf19TW+4wCTXunPUwQA7UR
	MU84b8u6PV9zaAsPmiwXCFYnlX2Zd0Ow4oddkvsTQPdygktocl3j7mBwGzA==
X-Gm-Gg: ASbGncvmOpE3ZDAr+tGUNrrWx7G7OiiqIV9xEEzmK0K47EbHJNpolh0mIkzu7+kxv7g
	US+hp0/jQCujgdHVN8N+3DsUnWkWO6e2ondFgn7TrY1EpE4KztzEpa/hQ0asaaQzdsYtVklQRKB
	7A/zeSOGXP2moCzI08QlOuy2zELnT4H5j/FmaFF7TpBMifaVxXpFzJO0JtcVowzwxopmjKjJj6c
	1nVYLwasiG3dR9IvsZvsNUzMmGMJu1OQ/ekKuokns8UwQXbU1KakEAaX/vx7ohI6WBokRZT8f8D
	MLJEknUugnxIRVHwVetcVcoTLo+8H5OR2faOBw6nC9mnjknpMTz5ShulNMdTpbNHvPyNbnoRGCQ
	7xIfKbCuzvTM=
X-Received: by 2002:a05:600c:3147:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-45b4d7ea0e6mr21934775e9.13.1755785925647;
        Thu, 21 Aug 2025 07:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLwKJXKyCXn0Ep8Pg/fTs01OWaVxGdAUn91+tk/jR7dvj0U5zOA0d/juE648QGc7ZwVXZL8Q==
X-Received: by 2002:a05:600c:3147:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-45b4d7ea0e6mr21934385e9.13.1755785925123;
        Thu, 21 Aug 2025 07:18:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788b39sm11839502f8f.47.2025.08.21.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:18:44 -0700 (PDT)
Message-ID: <a45ba272-685f-41dd-8582-6bbc5bc086bb@redhat.com>
Date: Thu, 21 Aug 2025 16:18:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/15] quic: add path management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1755525878.git.lucien.xin@gmail.com>
 <507c85525538f0dc64e536f7ccdd7862b542a227.1755525878.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <507c85525538f0dc64e536f7ccdd7862b542a227.1755525878.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 4:04 PM, Xin Long wrote:
> +/* Lookup a quic_udp_sock in the global hash table. If not found, creates and returns a new one
> + * associated with the given kernel socket.
> + */
> +static struct quic_udp_sock *quic_udp_sock_lookup(struct sock *sk, union quic_addr *a, u16 port)
> +{
> +	struct net *net = sock_net(sk);
> +	struct quic_hash_head *head;
> +	struct quic_udp_sock *us;
> +
> +	head = quic_udp_sock_head(net, port);
> +	hlist_for_each_entry(us, &head->head, node) {
> +		if (net != sock_net(us->sk))
> +			continue;
> +		if (a) {
> +			if (quic_cmp_sk_addr(us->sk, &us->addr, a) &&
> +			    (!us->bind_ifindex || !sk->sk_bound_dev_if ||
> +			     us->bind_ifindex == sk->sk_bound_dev_if))
> +				return us;
> +			continue;
> +		}
> +		if (ntohs(us->addr.v4.sin_port) == port)
> +			return us;
> +	}
> +	return NULL;
> +}

The function description does not match the actual function implementation.

> +
> +/* Binds a QUIC path to a local port and sets up a UDP socket. */
> +int quic_path_bind(struct sock *sk, struct quic_path_group *paths, u8 path)
> +{
> +	union quic_addr *a = quic_path_saddr(paths, path);
> +	int rover, low, high, remaining;
> +	struct net *net = sock_net(sk);
> +	struct quic_hash_head *head;
> +	struct quic_udp_sock *us;
> +	u16 port;
> +
> +	port = ntohs(a->v4.sin_port);
> +	if (port) {
> +		head = quic_udp_sock_head(net, port);
> +		mutex_lock(&head->m_lock);
> +		us = quic_udp_sock_lookup(sk, a, port);
> +		if (!quic_udp_sock_get(us)) {
> +			us = quic_udp_sock_create(sk, a);
> +			if (!us) {
> +				mutex_unlock(&head->m_lock);
> +				return -EINVAL;
> +			}
> +		}
> +		mutex_unlock(&head->m_lock);
> +
> +		quic_udp_sock_put(paths->path[path].udp_sk);
> +		paths->path[path].udp_sk = us;
> +		return 0;
> +	}
> +
> +	inet_get_local_port_range(net, &low, &high);

you could/should use inet_sk_get_local_port_range().

/P


