Return-Path: <netdev+bounces-211052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B9B164F9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C230C188E11A
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEF279DAE;
	Wed, 30 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d69V/dzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442F1A4F0A;
	Wed, 30 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894038; cv=none; b=rqFBpVrnyEfeLr0eJ39RbezjrL/5PJ5U9xUMarCdlYEfIJr17HlS10v+7yyTw6laaIXmRYl8swotXIO4QYHtgklHVoMKd+KvhUvKVi8juqoXqyAYu3vIu0PIWrPlhVYdFCRq/QjBdWkpOU4esPCEEhiONz4mdN7nek+Z1mDWOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894038; c=relaxed/simple;
	bh=u5JLbKMa4Mzuu0WBqXDwBoLi3/fHor3zyRRpEP2LW8M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l7dbvbvaqLRCMn/tZN4p8TJ3kCmlXVUkLqJtyMwZobLWfubEqDcFhlk9n0Iyl7IH4Pz4W+bEwgIy5yV95KikvA0BqOibl8cS8Kcc5fvgj5OLbTLFRnbn5U2162YYhWX8/w8nyhuLlybft4gwAheVuh1644IaUw8fwL5oIW99jtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d69V/dzn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71a455096e0so270907b3.0;
        Wed, 30 Jul 2025 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894034; x=1754498834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsaaAb4et8gGNaqaBH6jJtE7btiTy+4sUxZfzw3D3fw=;
        b=d69V/dznKD7bbYgxvufbhq6FMS/+jml2JXJnecwfd9r35oKvp37tMW+5nLOY8i5h7m
         9Hi2nhywN+wYvafJhet52/0oKogTVdLB9PdbgHcsle0ViIvbG14GL7yerRfvBf3jCwN2
         ELBZmWFGnlkpyYBC/Hq9vLmfa/4ZHVTNIDADJ8HxMr+iOf95zbvBbPVGSYddZ3PDCE9O
         JPiMNX4gI5e7KtuhZUeTryTs5o8cFt0TIHxNlgyIE5hfPc52hbXCWSCqBPQ6T3WYsA6p
         QsEeffoe0NEX83bgDKyjziP6YotrNaprI3psal0tlztlLmE059LaZqL6SRWflQxMRQ7r
         RHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894034; x=1754498834;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hsaaAb4et8gGNaqaBH6jJtE7btiTy+4sUxZfzw3D3fw=;
        b=tEbMnedLapmFutHlyaHjKx8jpNHyA8AT+2u4t/xgkm8BuO6jOFBA+JUb6i4B5t5ZSW
         MylDHNHjaNDc9DiO9bbn6ZSOGrbIBO9n5Sy4FDQdo1Cv0wiI9e8S+H+Qo1JsrOzoYrAU
         0VbWyHa7cAtRcNaM0lULlnqganHxAI7wFebH6PxQwuuaLVkm0ZBzcaoEdzBDQX+kbvHi
         kv2eSX67mgl/MScZuv8WWGmnOF6cpl0vifbLiG1ky+iPzXqs/aaAQs3eHPeB2uGoFTG6
         bL6jvXbG11oEkyoP0/tyyGIGBBNpGSyi4IvNRvZvilhp2A0E2ZwNbzubYMZJ8cEqWmBa
         SkWA==
X-Forwarded-Encrypted: i=1; AJvYcCVopawjzLthpc+99VpvwcebGibvUneJknUPogGOxZmuXcWDVragUKw6rt4HY8N75BneEfBnMIUwRBQ1oqw=@vger.kernel.org, AJvYcCXd78O/i1HcmNZEG8JGxPabwW2SCwGomFv2ntu+nnGaVb6mwQoEbGCDJZFAIPqN8PDOM01P43OX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqd3/KOb8sk63XGxL8x3BpZDBm/VZ0iYZILgRGdYUQl6zBDknV
	IYzciPOL2D4qlhga8ghnP37HzRUiGd3VVdTtPe24BcdOgS8oUfAlJpVS
X-Gm-Gg: ASbGncv4LuBFNZEldTFg3O5EFka12LQpPuWnNIFYJbO4b8c3sTT+LAxIWAVJtKHKhM4
	w+T36wg+AcfsedMDfftMw5xyl5WnQq6g/J5iWGvqvRUPgcmQJVxwDOrG1RfjLhsCGonbc/Gjrku
	hU/RWZ2DglR5aNYa0lfIKKcGwblodB12+9paKVNTa2VekZlJg1ShTMgwJLa0SdIRoj2gXi1h3dt
	8BZ2SgZhg54OSEDQK8HT46COvKaqetwoudexJMOGTiuQqCOlWlI23fsEeIswMOgoNVinj9/vkQV
	lwmUnZlT0bxz1IgLFtI7NoffMTvRSy90T5/HEON/vsg/6aljpuqbm0I5B9R+bqzhrHF5UzZdy16
	FW34gkiVcqkifVBR+vcnlvXMwRA0Z1N3tnBdQwgUQ5fcuZnnBLGHCRP3TxJmLl4y0IRQkCJPfig
	jdGJWj
X-Google-Smtp-Source: AGHT+IFQPnS9b0lZWH4xANLsmnDxMGif0mETMnc43nGvRcQDq7RykCdSVIvQkpxT22rx5vBTVN9cIg==
X-Received: by 2002:a05:690c:9985:b0:710:f55f:7922 with SMTP id 00721157ae682-71a466d5090mr61070237b3.34.1753894034400;
        Wed, 30 Jul 2025 09:47:14 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8df85d7b27sm3713172276.18.2025.07.30.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:47:13 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:47:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 wangliang74@huawei.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <688a4c91159bc_1cb795294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250730101458.3470788-1-wangliang74@huawei.com>
References: <20250730101458.3470788-1-wangliang74@huawei.com>
Subject: Re: [PATCH net v3] net: drop UFO packets in udp_rcv_segment()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Liang wrote:
> When sending a packet with virtio_net_hdr to tun device, if the gso_type
> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
> size, below crash may happen.
> 
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:4572!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   RIP: 0010:skb_pull_rcsum+0x8e/0xa0
>   Code: 00 00 5b c3 cc cc cc cc 8b 93 88 00 00 00 f7 da e8 37 44 38 00 f7 d8 89 83 88 00 00 00 48 8b 83 c8 00 00 00 5b c3 cc cc cc cc <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 000
>   RSP: 0018:ffffc900001fba38 EFLAGS: 00000297
>   RAX: 0000000000000004 RBX: ffff8880040c1000 RCX: ffffc900001fb948
>   RDX: ffff888003e6d700 RSI: 0000000000000008 RDI: ffff88800411a062
>   RBP: ffff8880040c1000 R08: 0000000000000000 R09: 0000000000000001
>   R10: ffff888003606c00 R11: 0000000000000001 R12: 0000000000000000
>   R13: ffff888004060900 R14: ffff888004050000 R15: ffff888004060900
>   FS:  000000002406d3c0(0000) GS:ffff888084a19000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000040 CR3: 0000000004007000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    udp_queue_rcv_one_skb+0x176/0x4b0 net/ipv4/udp.c:2445
>    udp_queue_rcv_skb+0x155/0x1f0 net/ipv4/udp.c:2475
>    udp_unicast_rcv_skb+0x71/0x90 net/ipv4/udp.c:2626
>    __udp4_lib_rcv+0x433/0xb00 net/ipv4/udp.c:2690
>    ip_protocol_deliver_rcu+0xa6/0x160 net/ipv4/ip_input.c:205
>    ip_local_deliver_finish+0x72/0x90 net/ipv4/ip_input.c:233
>    ip_sublist_rcv_finish+0x5f/0x70 net/ipv4/ip_input.c:579
>    ip_sublist_rcv+0x122/0x1b0 net/ipv4/ip_input.c:636
>    ip_list_rcv+0xf7/0x130 net/ipv4/ip_input.c:670
>    __netif_receive_skb_list_core+0x21d/0x240 net/core/dev.c:6067
>    netif_receive_skb_list_internal+0x186/0x2b0 net/core/dev.c:6210
>    napi_complete_done+0x78/0x180 net/core/dev.c:6580
>    tun_get_user+0xa63/0x1120 drivers/net/tun.c:1909
>    tun_chr_write_iter+0x65/0xb0 drivers/net/tun.c:1984
>    vfs_write+0x300/0x420 fs/read_write.c:593
>    ksys_write+0x60/0xd0 fs/read_write.c:686
>    do_syscall_64+0x50/0x1c0 arch/x86/entry/syscall_64.c:63
>    </TASK>
> 
> To trigger gso segment in udp_queue_rcv_skb(), we should also set option
> UDP_ENCAP_ESPINUDP to enable udp_sk(sk)->encap_rcv. When the encap_rcv
> hook return 1 in udp_queue_rcv_one_skb(), udp_csum_pull_header() will try
> to pull udphdr, but the skb size has been segmented to gso size, which
> leads to this crash.
> 
> Previous commit cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> introduces segmentation in UDP receive path only for GRO, which was never
> intended to be used for UFO, so drop UFO packets in udp_rcv_segment().
> 
> Link: https://lore.kernel.org/netdev/20250724083005.3918375-1-wangliang74@huawei.com/
> Link: https://lore.kernel.org/netdev/20250729123907.3318425-1-wangliang74@huawei.com/
> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


