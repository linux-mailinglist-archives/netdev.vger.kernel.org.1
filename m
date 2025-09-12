Return-Path: <netdev+bounces-222736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F7B55917
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815FBAC78A9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F045270568;
	Fri, 12 Sep 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3icHVmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58842239E81
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715794; cv=none; b=CAL3dNDc6TuGX1BH629FD2064s6kMYm4Au23aYb1LmX+2owJh0Nnf0vV6MERs9bkNFk4Qin5PyNEjM1PZ+Bm5ooPKO8GYrlatf9CbHjTpRNR9ewD1yrUtkJi58POGRcHuBaLgQkG8O9WK1NRy6oiH/zHu9wWlYpMfZymnCKulP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715794; c=relaxed/simple;
	bh=975rLZ/crgWlCXiEG4lcMWnfUSP2uBBlhbiQ/lUTN/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkzuXKXgFKoJdAqMDkKX2DVEwaMeMRtgCx5imX7Baa9tqi8hRJDQbgqqPOx+Qz9RVnpm8m+7HuksmhQsBaSlVe4O382o3Xzbh44sX7J6amfL3DJVMkzBuNh13xkEr32xvgyZhp4KAIw5+iTntMiGHHl9fzY5uksD33cgPqVp42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3icHVmn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4e84a61055so1630485a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715793; x=1758320593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNNz2LKIxZ4gQ2Jb08OrP2M90WgN4MOeVyOVAJNK1qY=;
        b=h3icHVmn/JrRJh0k8V4ygFIywjheSrFmqDh7rnMFZ1W09jedMLYZ1JD9gcJwMHpb9v
         vIvFDFJmDQWEgpvyJlRgi5iaAoJkrdRTBdN/pfk+X4OE7xie3Hetqo9XWT5KKaTY1AUC
         +OtoHtXlUyufQbayo8X3kNxHXE1QYuU0rkmUuAiqAr2Up06D+wkWUZE2OLFHIi2/yoAu
         Os4OJ342ZV0Xd0GYSbygM2obc+IMhCMW0AG20He9LcZW7EjSgiX7n/nYLcKGNhO5oZaF
         G6LHFfpca570wUqW6nqA6KL3FbWLalQr/gaLxWwUE36B3qXqygNzFU1z/JOPl97NP6Qb
         ODyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715793; x=1758320593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNNz2LKIxZ4gQ2Jb08OrP2M90WgN4MOeVyOVAJNK1qY=;
        b=AX1IT3hh6oe9YdQ1XJoOLZKmCP7oe4BbOfoAx7UY6Ln5I9cOqMIvI+RJlApuhq4X5z
         pbMueawNecPc8zydlsrYxK+Rufg1iYG3KomBhbJkcnxEq5dAAyXkGik4QBlklQiSiDFt
         xwwI/N4nL+IvmqSKypCuKltIFBtn6heMBkZrsoerWn03dx//p7Gvz9bzkpQpFf9IC2UG
         CTHv4VexP+z+FuD8UCq6WwwlyF+VkJsolLvOguoKOOcMUE6nsi95zTSuLO+W/rJ7csnn
         z6qIXBPIr90YyUvwKRvQJXVrTXd6oJRtKrIO/cCKDcrJcQx9TWtiVHQ+NqGRb7IWjsyc
         5elA==
X-Forwarded-Encrypted: i=1; AJvYcCWPo4aMWbR2MEQnCh31tVsAyzxIxVxXcJM/ATiyAe5BPyu31qAPxxlngoDnv66EFGLriUKW+QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB9bqUxOKd0mz1/lme7dvgNbbHOaYBd+Xh8bNEb9ZCFykiiCs
	YS3+gttDPgeKvZclUXffUMPtqCgsUuzEAQDYkiQxPO2y+SBKwzHjQBY=
X-Gm-Gg: ASbGnctb/R7uwoBB5QTGvMQdWmup1G4L3duYkTM7/glpn79ydWScZphkI9zXTwNsKhi
	6+ZsuTFSb/IuopBhmUzsppNauVevmdaEBxIA+qe0VO/mK4XIeg9Pyokp9BqZWHchQI4koy0l1fZ
	LsJ2JDT5pH6LovcvD7aLg9alx3bBDo8VqM7FRpHshanw40yNx3sqvoz7ay5CMdskiMP7rrbaAs6
	syLwU7YNbCu5EmE2W+D8snlX+5e9hISS+nLKrkeLBQud92ygC3k0Lcqf5fUhIwDcsHHswQX35Ee
	qBp1H/2wsK49H/kNgDB7zvepNkmXuAbotapVNJGs9rLpHz8v9RbZs62j/pnALiiMVLebTb0ipm5
	PBpaX7dJtX4G37yuNUEfsZps/9k7vMkehh3RXIRt36Vdz2g9iPBlgWm6+1R9Isd7E2LWMbUX9MS
	SN0BnOW0GgBa/APBV5boDG9tNU5r8FMswWaE+wOshzwVp35Oh9yOF/6W5W16GE07JBn6ubttUwi
	LN03VJ+kzTAbgFwVrF2D5u1cQ==
X-Google-Smtp-Source: AGHT+IHjj4OcXZCby1eBKHFLR+sqWj7uD9adskfcLEg8FrukuNMZQMOs22KWMCIzEOzROeKLlPJ0Ow==
X-Received: by 2002:a17:902:ebc2:b0:249:2c76:54fc with SMTP id d9443c01a7336-25d2665fbc1mr55841325ad.39.1757715792473;
        Fri, 12 Sep 2025 15:23:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25d49093074sm34148285ad.149.2025.09.12.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:23:12 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:23:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 3/3] net: ethtool: prevent user from breaking
 devmem single-binding rule
Message-ID: <aMSdT7lQDvLNEvsv@mini-arch>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
 <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>

On 09/11, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Prevent the user from breaking devmem's single-binding rule by rejecting
> ethtool TCP/IP requests to modify or delete rules that will redirect a
> devmem socket to a queue with a different dmabuf binding. This is done
> in a "best effort" approach because not all steering rule types are
> validated.
> 
> If an ethtool_rxnfc flow steering rule evaluates true for:
> 
> 1) matching a devmem socket's ip addr
> 2) selecting a queue with a different dmabuf binding
> 3) is TCP/IP (v4 or v6)
> 
> ... then reject the ethtool_rxnfc request with -EBUSY to indicate a
> devmem socket is using the current rules that steer it to its dmabuf
> binding.
> 
> Non-TCP/IP rules are completely ignored, and if they do match a devmem
> flow then they can still break devmem sockets. For example, bytes 0 and
> 1 of L2 headers, etc... it is still unknown to me if these are possible
> to evaluate at the time of the ethtool call, and so are left to future
> work (or never, if not possible).
> 
> FLOW_RSS rules which guide flows to an RSS context are also not
> evaluated yet. This seems feasible, but the correct path towards
> retrieving the RSS context and scanning the queues for dmabuf bindings
> seems unclear and maybe overkill (re-use parts of ethtool_get_rxnfc?).
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  include/net/sock.h  |   1 +
>  net/ethtool/ioctl.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp.c      |   9 ++++
>  net/ipv4/tcp_ipv4.c |   6 +++
>  4 files changed, 160 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 304aad494764..73a1ff59dcde 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -579,6 +579,7 @@ struct sock {
>  		struct net_devmem_dmabuf_binding	*binding;
>  		atomic_t				*urefs;
>  	} sk_user_frags;
> +	struct list_head	sk_devmem_list;
>  
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  	struct module		*sk_owner;
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b2a4d0573b3..99676ac9bbaa 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -29,11 +29,16 @@
>  #include <linux/utsname.h>
>  #include <net/devlink.h>
>  #include <net/ipv6.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/flow_offload.h>
>  #include <net/netdev_lock.h>
>  #include <linux/ethtool_netlink.h>
>  #include "common.h"
> +#include "../core/devmem.h"
> +
> +extern struct list_head devmem_sockets_list;
> +extern spinlock_t devmem_sockets_lock;
>  
>  /* State held across locks and calls for commands which have devlink fallback */
>  struct ethtool_devlink_compat {
> @@ -1169,6 +1174,142 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
>  	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
>  }
>  
> +static bool
> +__ethtool_rx_flow_spec_breaks_devmem_sk(struct ethtool_rx_flow_spec *fs,
> +					struct net_device *dev,
> +					struct sock *sk)
> +{
> +	struct in6_addr saddr6, smask6, daddr6, dmask6;
> +	struct sockaddr_storage saddr, daddr;
> +	struct sockaddr_in6 *src6, *dst6;
> +	struct sockaddr_in *src4, *dst4;
> +	struct netdev_rx_queue *rxq;
> +	__u32 flow_type;
> +
> +	if (dev != __sk_dst_get(sk)->dev)
> +		return false;
> +
> +	src6 = (struct sockaddr_in6 *)&saddr;
> +	dst6 = (struct sockaddr_in6 *)&daddr;
> +	src4 = (struct sockaddr_in *)&saddr;
> +	dst4 = (struct sockaddr_in *)&daddr;
> +
> +	if (sk->sk_family == AF_INET6) {
> +		src6->sin6_port = inet_sk(sk)->inet_sport;
> +		src6->sin6_addr = inet6_sk(sk)->saddr;
> +		dst6->sin6_port = inet_sk(sk)->inet_dport;
> +		dst6->sin6_addr = sk->sk_v6_daddr;
> +	} else {
> +		src4->sin_port = inet_sk(sk)->inet_sport;
> +		src4->sin_addr.s_addr = inet_sk(sk)->inet_saddr;
> +		dst4->sin_port = inet_sk(sk)->inet_dport;
> +		dst4->sin_addr.s_addr = inet_sk(sk)->inet_daddr;
> +	}
> +
> +	flow_type = fs->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
> +
> +	rxq = __netif_get_rx_queue(dev, fs->ring_cookie);
> +	if (!rxq)
> +		return false;
> +
> +	/* If the requested binding and the sk binding is equal then we know
> +	 * this rule can't redirect to a different binding.
> +	 */
> +	if (rxq->mp_params.mp_priv == sk->sk_user_frags.binding)
> +		return false;
> +
> +	/* Reject rules that redirect RX devmem sockets to a queue with a
> +	 * different dmabuf binding. Because these sockets are on the RX side
> +	 * (registered in the recvmsg() path), we compare the opposite
> +	 * endpoints: the socket source with the rule destination, and the
> +	 * socket destination with the rule source.
> +	 *
> +	 * Only perform checks on the simplest rules to check, that is, IP/TCP
> +	 * rules. Flow hash options are not verified, so may still break TCP
> +	 * devmem flows in theory (VLAN tag, bytes 0 and 1 of L4 header,
> +	 * etc...). The author of this function was simply not sure how
> +	 * to validate these at the time of the ethtool call.
> +	 */
> +	switch (flow_type) {
> +	case IPV4_USER_FLOW: {
> +		const struct ethtool_usrip4_spec *v4_usr_spec, *v4_usr_m_spec;
> +
> +		v4_usr_spec = &fs->h_u.usr_ip4_spec;
> +		v4_usr_m_spec = &fs->m_u.usr_ip4_spec;
> +
> +		if (((v4_usr_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_usr_m_spec->ip4src) ||
> +		    (v4_usr_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_usr_m_spec->ip4dst) {
> +			return true;
> +		}
> +
> +		return false;
> +	}
> +	case TCP_V4_FLOW: {
> +		const struct ethtool_tcpip4_spec *v4_spec, *v4_m_spec;
> +
> +		v4_spec = &fs->h_u.tcp_ip4_spec;
> +		v4_m_spec = &fs->m_u.tcp_ip4_spec;
> +
> +		if (((v4_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_m_spec->ip4src) ||
> +		    ((v4_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_m_spec->ip4dst))
> +			return true;
> +

The ports need to be checked as well? But my preference overall would
be to go back to checking this condition during recvmsg. We can pick
some new obscure errno number to clearly explain to the user what
happened. EPIPE or something similar, to mean that the socket is cooked.
But let's see if Mina has a different opinion..

