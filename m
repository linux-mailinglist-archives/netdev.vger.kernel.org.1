Return-Path: <netdev+bounces-76173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B096186CAC3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7491CB23B44
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9958128820;
	Thu, 29 Feb 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MQz9382P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF5127B5B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214931; cv=none; b=hscluJLqP1TI5UfvWdOk6FqDT5AegI5noSfe/w3FutF0mqhQkOVLPZR/aQwQuX1YpiHFGwyj9sIbVWccf5yVPMNiV3r3LwRNe/Hfg/o0mV1lnypuCJFXmwL1aGMfPngfpt6XFTxo6huq4hs51+d0UlKtxhv103oYd3RZnhfBKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214931; c=relaxed/simple;
	bh=KQeyGpbqfxD9cU86r+ot8BLxb6AyuM2tPGS1Jx4XDGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpsEpHgNylcRQHzry86K1urPn4mvFDgvVipjhfYz1I2VMhceIW82UEVq6273v5cbbdFc+tTLSt/TKxYYVKWRhWlWgj7e02yb6ZQjWehgo0urA8fbYyEQihDe7+rZmWfYsedCV1meAwoPvFD7VIvovSksURIGlsJWZy80wQR2oKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MQz9382P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412c23551e2so1862865e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709214927; x=1709819727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNaz4KIzD4AoDKK9ZGUM1dzXLUmDvqJw6xoJsMdwsNU=;
        b=MQz9382PcKUvdot8L+S0qxBNAFLOitJXjFJYIQvbHHEJFg+UexQuutuTaJa1W5jO1C
         +z3PEptMpArUwkVV+hWyHoXfUxPFq5tHYKksPZ6kP/LcO5CZCMYnWbv6IEAE1zdhesLD
         azO9URv4xxFN6PxqFOYLvOQLiXlHEI0BSZxzSs+Hpif47iEyZv5JKEu6Vxiet7XAHTBm
         wFrhakNooD9EvfShmeAH1y+b+Y0AKnPd/HKRLJWqJAmayjrw2aRZVKXhS1E+Q/LgJkro
         EbC09IFUVQ7a4WIohM+pmfXllh5fh+Klwe8RqyBsF+46sHPDnJ9EHQE1hecyafWiXvhu
         H6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214927; x=1709819727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNaz4KIzD4AoDKK9ZGUM1dzXLUmDvqJw6xoJsMdwsNU=;
        b=Bk18Al3pdqhyWeMSZnsdTgyrhrUOlXCT1bD1XZOAQPlz24q0lphFC+Q8m9W2qi+bNN
         R1YwDCTWeZWntsy4+Ux9T3vYXXHLgSb8NRuTl1K948cyzslnc5MVukTeX1OchnKMjJNS
         OTjVi3WuYhyfd1stnbNUtD/fUtd7yVdtx99EObvAMyv92mACn56Q9lEP2tkfEnPAPrAC
         0vm3cy1jeLSvKVWItX05qoQPkPb+DeI92B1p5aLEbwjqjm4Nwal1sXtSO9Sb/XrvR7Zq
         UYR7JgLyvFXSbQ0rtf58D3tP8vnO6rDorfWlcIHv247FaeKWrI8xCZkjPKN7rNLG8WJK
         Zmjg==
X-Forwarded-Encrypted: i=1; AJvYcCWvcAxfUlzZur0iGz8q6D8us564q3tKcJTqDoXcyV09BxkGO6VFspG1/pwYpBIa2rSjr+KvZjhdkTl70GB1HEuQi4XNqje6
X-Gm-Message-State: AOJu0Ywj4/LpKAPfHwDMVPJEf6rUGuXrj+8KwgQWLHVKZf7oqlvW5unN
	i1AZasrRCT3hRIbgDnLGzpzrwcWQxnRQQH1OzqEuylf1tBONsc7TKIvhHhSHXWI=
X-Google-Smtp-Source: AGHT+IHnR7jt9WODI0/SAPElC2Sf34UvDseXzGAtdrqbQVkJ+gjaI5NLU6GpwSSBGkC+14wtnjR4TQ==
X-Received: by 2002:a05:600c:4f56:b0:412:c1d4:dd0b with SMTP id m22-20020a05600c4f5600b00412c1d4dd0bmr1014611wmq.4.1709214927038;
        Thu, 29 Feb 2024 05:55:27 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b004129f87a2c6sm2989048wma.1.2024.02.29.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:55:26 -0800 (PST)
Date: Thu, 29 Feb 2024 14:55:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com,
	syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
Subject: Re: [PATCH net] geneve: make sure to pull inner header in geneve_rx()
Message-ID: <ZeCMygAPmudDnqbS@nanopsycho>
References: <20240229131152.3159794-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229131152.3159794-1-edumazet@google.com>

Thu, Feb 29, 2024 at 02:11:52PM CET, edumazet@google.com wrote:
>syzbot triggered a bug in geneve_rx() [1]
>
>Issue is similar to the one I fixed in commit 8d975c15c0cd
>("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
>
>We have to save skb->network_header in a temporary variable
>in order to be able to recompute the network_header pointer
>after a pskb_inet_may_pull() call.
>
>pskb_inet_may_pull() makes sure the needed headers are in skb->head.
>
>[1]
>BUG: KMSAN: uninit-value in IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
> BUG: KMSAN: uninit-value in geneve_rx drivers/net/geneve.c:279 [inline]
> BUG: KMSAN: uninit-value in geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
>  IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
>  geneve_rx drivers/net/geneve.c:279 [inline]
>  geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
>  udp_queue_rcv_one_skb+0x1d39/0x1f20 net/ipv4/udp.c:2108
>  udp_queue_rcv_skb+0x6ae/0x6e0 net/ipv4/udp.c:2186
>  udp_unicast_rcv_skb+0x184/0x4b0 net/ipv4/udp.c:2346
>  __udp4_lib_rcv+0x1c6b/0x3010 net/ipv4/udp.c:2422
>  udp_rcv+0x7d/0xa0 net/ipv4/udp.c:2604
>  ip_protocol_deliver_rcu+0x264/0x1300 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x2b8/0x440 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:461 [inline]
>  ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_rcv+0x46f/0x760 net/ipv4/ip_input.c:569
>  __netif_receive_skb_one_core net/core/dev.c:5534 [inline]
>  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5648
>  process_backlog+0x480/0x8b0 net/core/dev.c:5976
>  __napi_poll+0xe3/0x980 net/core/dev.c:6576
>  napi_poll net/core/dev.c:6645 [inline]
>  net_rx_action+0x8b8/0x1870 net/core/dev.c:6778
>  __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
>  do_softirq+0x9a/0xf0 kernel/softirq.c:454
>  __local_bh_enable_ip+0x9b/0xa0 kernel/softirq.c:381
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
>  __dev_queue_xmit+0x2768/0x51c0 net/core/dev.c:4378
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3819 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1296 [inline]
>  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
>  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
>  packet_alloc_skb net/packet/af_packet.c:2930 [inline]
>  packet_snd net/packet/af_packet.c:3024 [inline]
>  packet_sendmsg+0x70c2/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>Fixes: 2d07dc79fe04 ("John W. Linville <linville@tuxdriver.com>")

Odd commit name :)
Fixes: 2d07dc79fe04 ("geneve: add initial netdev driver for GENEVE tunnels")


>Reported-and-tested-by: syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

