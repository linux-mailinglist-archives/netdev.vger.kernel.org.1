Return-Path: <netdev+bounces-224788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E4B8A0FD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD07ACC31
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6240235360;
	Fri, 19 Sep 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4nXpIPa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CA273F9
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293218; cv=none; b=t1mfJntAqHLD2h+2uCMbntVfLpHwlaRMoJaMeAfJbo8uYORt3db79wbpUWISyiWQ8cuY6uUsBfmZtdWY+TLtZdXgdt9ZWQBy1J2x/ijxMeGVv0ddKGgFjlQItx+IfRQ1TuB8RZppxSu9Q4RwVEspWKJML4bj9pEEQsfqnCcdABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293218; c=relaxed/simple;
	bh=rMzpqLEOEhteINqvc5dyan4rtMP3A9UTuyesjbI13LA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eDVzfG76JkwdyNC5IFGj+vlJjzRlsdweKg9m3arbTYm8p63wXZP2P0HnBoaYxbsfc/xvPu70Yh12lLHv5E9O3OTrlq6A+BNIB1ppcEnxp0e3uat8zqXHxHyRR7DP8B8IY4U4RqlWUqzrCZo5ztTI3+UX5V8wuqdRs6uhBoLkrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4nXpIPa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b79773a389so22771501cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293216; x=1758898016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTCj+e/VtZ/D02X1h15E6NfB/hO2pboJylbEQXWpz8E=;
        b=A4nXpIPa+2BhjVsulZSLhLIPr3E+ZFHQUuJRXnK3toMeDpl/tIJlbRWgTKMiRShSu2
         wcSH2+RapQp3ncIktiuybEZ9Nd99ZyBKhUaqw9wrt8zq/woRd5GRzwkukmR7t0Lz3e02
         eItFjH3S0UmGQltEJH4/lg14WuxXQMfzicM/FysACFU1VzYzcGy4Tvy81wv7XbqcGen/
         OQKgF9Yyrfvdl9YhVTub/urvZM12PjLLND/k1napHlkkLWnjYuYFlGyeMXKxnmooxdro
         KYxQFg36h3oqwaABM4TdY73aYeSXG1qARFfVZDZHymcn5P90PYs3bB7cJ91MWjahe0nb
         ykBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293216; x=1758898016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BTCj+e/VtZ/D02X1h15E6NfB/hO2pboJylbEQXWpz8E=;
        b=F9yKcvuvM/WbIyQC7iyurXdF1FeMxT/fFvwwPcr8SIoGqmow+MP1HGMJVfvXTgkGeQ
         k4qwIcwrGow0HplWirqk/DHqQzSicAL6X/SKBNsZKTrSILllkIPSq/fja71YzTUD6MJP
         cTGCm+QpLRy3sJTEPYfzYVgRSfUVbYq3D4RqzYDjZUUC/vmjd1RZlGX3uGAqDHtyKj+S
         /3xUp4SrOEZsZAxOFLt/sNWeTU13g4kmahJsy/NS5HtNlWf2+6M41X8/I9VxOCMTsQHe
         8bu3yozPtRkz5ytt8kuUGAyXj1ieqLl76ZpUcc7hO9gblxW5GqAF+hZRsGMAFZldiWOp
         95Og==
X-Forwarded-Encrypted: i=1; AJvYcCVuWKuo20FaIOWNdLiMNLGz28LZFzySVFZM+9tRee18E9iNWHQ88L5eCkMtsitb0Bl0+AmJRfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTNzeBeT9YMu9p2HXR6PUfaUgjJVjDAlSghBC9FPRs9N07MXi
	Q0vNZ4Uk5UiaEWM1GKwdyvScs5zbpsz71dPM1UAM+cDa5iHkymMu4Gze
X-Gm-Gg: ASbGncs2cZJHufTvNOeKfi9Rm9Jpyi/rKZRhbAVuBvRfHGKBoSAULRO9DsQWmtSw1ao
	Tp8MqSH6+fI0bgSteol8UAtVOWkheROt/kX6P4lEtM7K7cXn7rWIIGQwGumpcY02NFH2q807zSX
	cxk0LyGXGkR3/Rnj9pGYZAQy0tEwfESBs/7rZKwWAWOihIOwW4zzWutQU2aJhLq8vcpXEXG+fdR
	IyiuMQI4gqAzlCN7GMAq+Nq19amXA/X8RmhLX9e1WFk7zgVKUeIsn+nPaAVIEmBDmrfskuAsPl6
	8Ax4KWQWUg9AJrk/PeoXpbGwyKyPpcFhpAqkqkvo8/u8gd8bz9gev9Gso/6xrLPupu2Xbb7Mtg/
	sab+vHejU/1YwfgGs9TbT4ToMgQSZ5KXGeOV5TImBliy6FAdcTwU0rn78QwNIs0PVr6V3sPuzmD
	6WpQ==
X-Google-Smtp-Source: AGHT+IEFvwYYDWYJDrNKDVvsS0tm4PJF42EUcN3g1p4ngNtR8j2nRJk0TdRdJI0JYwklpBYJ2GKC1A==
X-Received: by 2002:a05:622a:5444:b0:4c0:cab7:978 with SMTP id d75a77b69052e-4c0cab70addmr15501021cf.29.1758293215746;
        Fri, 19 Sep 2025 07:46:55 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4bda279ad7esm30915921cf.19.2025.09.19.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:46:55 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:46:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 lorenzo@kernel.org, 
 toke@redhat.com
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 wangliang74@huawei.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ecd010c7b725@gmail.com>
In-Reply-To: <20250917113919.3991267-1-wangliang74@huawei.com>
References: <20250917113919.3991267-1-wangliang74@huawei.com>
Subject: Re: [PATCH net] net: tun: Update napi->skb after XDP process
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
> The syzbot report a UAF issue:
> 
>   BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>   BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
>   BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>   Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
>   CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:378 [inline]
>    print_report+0xca/0x240 mm/kasan/report.c:482
>    kasan_report+0x118/0x150 mm/kasan/report.c:595
>    skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>    napi_frags_skb net/core/gro.c:723 [inline]
>    napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>    tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
>   Allocated by task 6079:
>    kasan_save_stack mm/kasan/common.c:47 [inline]
>    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>    unpoison_slab_object mm/kasan/common.c:330 [inline]
>    __kasan_mempool_unpoison_object+0xa0/0x170 mm/kasan/common.c:558
>    kasan_mempool_unpoison_object include/linux/kasan.h:388 [inline]
>    napi_skb_cache_get+0x37b/0x6d0 net/core/skbuff.c:295
>    __alloc_skb+0x11e/0x2d0 net/core/skbuff.c:657
>    napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:811
>    napi_get_frags+0x69/0x140 net/core/gro.c:673
>    tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
>    tun_get_user+0x77c/0x3e20 drivers/net/tun.c:1784
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   Freed by task 6079:
>    kasan_save_stack mm/kasan/common.c:47 [inline]
>    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>    kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>    poison_slab_object mm/kasan/common.c:243 [inline]
>    __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
>    kasan_slab_free include/linux/kasan.h:233 [inline]
>    slab_free_hook mm/slub.c:2422 [inline]
>    slab_free mm/slub.c:4695 [inline]
>    kmem_cache_free+0x18f/0x400 mm/slub.c:4797
>    skb_pp_cow_data+0xdd8/0x13e0 net/core/skbuff.c:969
>    netif_skb_check_for_xdp net/core/dev.c:5390 [inline]
>    netif_receive_generic_xdp net/core/dev.c:5431 [inline]
>    do_xdp_generic+0x699/0x11a0 net/core/dev.c:5499
>    tun_get_user+0x2523/0x3e20 drivers/net/tun.c:1872
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> After commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in
> generic mode"), the original skb may be freed in skb_pp_cow_data() when
> XDP program was attached, which was allocated in tun_napi_alloc_frags().
> However, the napi->skb still point to the original skb, update it after
> XDP process.
> 
> Reported-by: syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

