Return-Path: <netdev+bounces-63314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A070A82C3D8
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288CBB20BC9
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F377623;
	Fri, 12 Jan 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD95eoXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096C7691B
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78324e302d4so388477985a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705077717; x=1705682517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiO3QHtICc8rQOepY/J0jpFEIhp5U2+0I4zBaa+nzaw=;
        b=mD95eoXhKzxI+aSQELHEhP62f2BZOfqgYj752i8YV2NM+zJNnKYMAjSkdsVSmytahf
         N72VaQJTWmL8f5KiJsBi7UCeYnL/NObsrEEFvFXvZfFi36Mjy2Ic/s09bNo33OV4biuf
         NSp6Dh47hGrULioDQmQV1eZVQ2MnC1jBjID4BXq+ssZKTnc/ytL1MZuE6BooKKlAExux
         GwVCe9xZRkoF5pMrTP9hPEEfsgWJXA981c6Dyz4j9xR/EX3EWuseihf4u6npJQmbb9Ia
         jCycx80gv6mL1as4kprB9tVGn0Zq98UuADZwCbOXC20pMt9WziCSzha3JU/7xGWc8M4F
         adpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705077717; x=1705682517;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PiO3QHtICc8rQOepY/J0jpFEIhp5U2+0I4zBaa+nzaw=;
        b=POYxKwyA1FVHmicjff9C8mFPby0/tgIgVvNdm6CoG2vI+HLuVzehbiLtqor2IASo6W
         YSdmlp/eQQY4AFQst8jHezrpPvVh9OTV3il4epamN8Gm4d8+GYSSUW8zd7BWfsdJflEB
         mq3nPHH/vygk7Pu2WAUYpJ0cvRvYKNSCCw1DZCDAThd6Dlxv7CSUcLF1lm2CMZdmIomA
         ESxAjlchYI7y+FUWix2c2bayUKBbJQUTtwlEeVWvf4o00RqCjRy//v6wGB0OlsKZswTs
         XkLvT2+LlSducIOovz5O//XgeHeCL+IePS3t0IptJXHXcy45ekhIBewtxH0u6HUjI3ox
         iJsA==
X-Gm-Message-State: AOJu0Yz/u74hPxF9rGy5LXckjH7NMWh3b5cnRzBMVgBiGkQ1T5C8p5eX
	ekf0bNM7KxJHir7WDN319OY=
X-Google-Smtp-Source: AGHT+IHg66p9UBSEV0hqo60vV2sbw13ix1o54vVAyFf2M4foLNAhB2CO1v428TbgL3SIqHmpN1u/GQ==
X-Received: by 2002:a05:622a:178d:b0:429:c87a:ffc8 with SMTP id s13-20020a05622a178d00b00429c87affc8mr1967229qtk.99.1705077716939;
        Fri, 12 Jan 2024 08:41:56 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bx3-20020a05622a090300b004299d262017sm1489623qtb.66.2024.01.12.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:41:56 -0800 (PST)
Date: Fri, 12 Jan 2024 11:41:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Message-ID: <65a16bd458ece_18f8a2294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240112122816.450197-1-edumazet@google.com>
References: <20240112122816.450197-1-edumazet@google.com>
Subject: Re: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]
> 
> The repro use af_packet, injecting a gso packet and hdrlen == 0.
> 
> We could fix the issue making gso_features_check() more careful
> while dealing with NETIF_F_TSO_MANGLEID in fast path.
> 
> Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
> transport headers as intended.
> 
> Note that for GSO packets coming from untrusted sources, SKB_GSO_DODGY
> bit forces a proper header validation (and pull) before the packet can
> hit any device ndo_start_xmit(), thus we do not need a precise disection
> at virtio_net_hdr_to_skb() stage.
> 
> [1]
> BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline]
> BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
>  skb_gso_segment include/net/gso.h:83 [inline]
>  validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
>  __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
>  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
>  packet_alloc_skb net/packet/af_packet.c:2936 [inline]
>  packet_snd net/packet/af_packet.c:3030 [inline]
>  packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> 
> Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/netdev/0000000000005abd7b060eb160cd@google.com/
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

