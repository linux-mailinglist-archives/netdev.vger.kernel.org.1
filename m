Return-Path: <netdev+bounces-224625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98156B873AD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235D57E0FF8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E222FD7A0;
	Thu, 18 Sep 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgOCNshM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44452FB625
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234466; cv=none; b=V5L5Xj1iGwTVMZo2fw/+NEqgSw0oN35L26NPJDZL/UMo/GyUhsYdqvjCmMKRTQ4XaUS271AYcgG74kh5OqExFZsZ685Z/nY//MEBqbqa7dR3q+e4TRP1/ztfIhtxXU52yioI8hMI4vP2Gll8WctaI1SDKy/Df219CNgg88ja2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234466; c=relaxed/simple;
	bh=iQzxw2nr1UXF/2GaTZxJcYVt0zlFp+HsQqELsno4nu4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RUsXpS5yKwBxV5Ls1evOp384ciromhTvaKpnLsNj3NEsP8L9mVXW+R93o4VoyMUr0IGMOCQCVo+yBOsoRrIEYV8FZnjX+dnM+uiuGJFYZQSWLA+SlJmu8d0/11fA1SriUCtezMdilrxVMq8le1m6siM5x95k8Oqii3ffm462mqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgOCNshM; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-580a1f1f187so398763137.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234463; x=1758839263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22BCh/EGgWrorFUesyhrdAs73eyMH4/x+XC3Efyz2og=;
        b=TgOCNshMhKgGrFBaZ9RsqYzoJ0sEQREwoEfIpKEVlW04XcOMMu04PWwbdoHY32zZ2j
         aw3ysq0OaIQONniwrRk79LHxMH7aOY0WzvXvRxJuE/j0yjf5aNLTRixRr1+5xS0L2cJh
         LjRbRUv8QPyF4NqjvjP71l2CZ8iqzgbc86li6LJwpZggR9ZMe3+p6vmvgn9nh/ggl7XI
         2XOYUdk7MbG5gVCOC1D2pTSG29sU2kSIaQ3ApRImPWTVCgtBIjMMQqelXn9Nvhq7/0Sa
         W86w02GWUKAOqLqR9WJy6Fi1lyXsSWLUT0CeXuPXiu7L/qjjnrfy+6WhA8ka9ZfTvTo/
         +VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234463; x=1758839263;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=22BCh/EGgWrorFUesyhrdAs73eyMH4/x+XC3Efyz2og=;
        b=hP/FfsFG/cYcbfrZ1ZV+VmMsE7qXLPQjEO6SZh/3liT1rzO5irIj/KFj8jG2JTlzVI
         UxUN3Qn8j8SFY5ue6u7ZHw1NkoqBRK5jUvUCqd3iLkeUMzbdx0xBmmMdSLU9ejRqk+i5
         w3yfxYeACsdmdd/4xDfJhW9Mg8UcjBPR630jiKG1ucoQO++sRBJfLiX5cGzis4ldOo3N
         alJFyx8oRxyyvarVWUv7+/1GCiroMEQ0uGdRg3N1F/tSIdiuS8D30GWlwIQT2sdBQcmj
         69yRFHgjC9nExKzbrWNSoBWUt7YSJuge9jM5NerazVTKKhhipzmxaPxUsRkRBTxmhvlz
         YxeA==
X-Forwarded-Encrypted: i=1; AJvYcCVoZ1h8wRZwl1f5vzLF0ZPBKCNda1QSs9PvM80erGkmkf74G31LcdBq1YV2GX1vt4SOX8yHr8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKvD426vaPNi/3mj7Cst+jn7eP60MwBpgSFymc7avoMNG/svl
	oTB1m5N4MeDtuthKDL48SWiGyWl/4DiN9JIfU7yGfmQDfrra4vwmH++B
X-Gm-Gg: ASbGncsRY/AOGl3NDEvTKp8J+jadMH5uC7Vwz/T2QQ/Mm6GhheJurMkdUw97MdrB7u0
	FzSxeZ2AKfthjxzyVZd5beg5dMZs2CDQJMBJN3BMXfjtvehhhIXom7SbzO92aMWP5SeqZoCJM9I
	UQ8MCZ0cUFHRVDEkU/OE7YkvkUSezIFiAlMj9gXbM/3jJUqNuT67Bt2kzJqHc+XmWT5KYbPhD4K
	6L4vHaLHVGvsDdFuEyG3yNY7ldVwJ4GkMG8iFGcQAGqBEwsbt35LZ2kNlkwbosKmZB9Fop+Vpvj
	H8zJ9LqjDvj9Be+XpxNLERnXWzovCrcSD5j4n+5s8X3Cuw6ReYr6FpRUT517W5Vs6kYdqjaeP8+
	FcXjr03vRcLGitSmX0Dp4UZKCoW7Bl+qpuOwFO69onED7SR8G1PUR2rp+8o2a9RfB5kXdEERgby
	xBOJ0fQVgT3UcUFg2VBcFs
X-Google-Smtp-Source: AGHT+IHnNttxmPrN/xXEoA585RIs678A0lvbhqBhfmmK6kfMIXME8Hx9mmul0SzShpzzAyskByNGBw==
X-Received: by 2002:a05:6102:1627:b0:4ec:c548:e10e with SMTP id ada2fe7eead31-588d76ebbc2mr417749137.3.1758234463399;
        Thu, 18 Sep 2025 15:27:43 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-8e3e5dc22cdsm620977241.6.2025.09.18.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:27:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:27:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Wang Liang <wangliang74@huawei.com>, 
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
Message-ID: <willemdebruijn.kernel.548f5be689dc@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1aca4aa96eb20@gmail.com>
References: <20250917113919.3991267-1-wangliang74@huawei.com>
 <willemdebruijn.kernel.1aca4aa96eb20@gmail.com>
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

Willem de Bruijn wrote:
> Wang Liang wrote:
> > The syzbot report a UAF issue:
> > 
> >   BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
> >   BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
> >   BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
> >   Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
> >   CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >    print_address_description mm/kasan/report.c:378 [inline]
> >    print_report+0xca/0x240 mm/kasan/report.c:482
> >    kasan_report+0x118/0x150 mm/kasan/report.c:595
> >    skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
> >    napi_frags_skb net/core/gro.c:723 [inline]
> >    napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
> >    tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
> >    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
> >    new_sync_write fs/read_write.c:593 [inline]
> >    vfs_write+0x5c9/0xb30 fs/read_write.c:686
> >    ksys_write+0x145/0x250 fs/read_write.c:738
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> > 
> >   Allocated by task 6079:
> >    kasan_save_stack mm/kasan/common.c:47 [inline]
> >    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >    unpoison_slab_object mm/kasan/common.c:330 [inline]
> >    __kasan_mempool_unpoison_object+0xa0/0x170 mm/kasan/common.c:558
> >    kasan_mempool_unpoison_object include/linux/kasan.h:388 [inline]
> >    napi_skb_cache_get+0x37b/0x6d0 net/core/skbuff.c:295
> >    __alloc_skb+0x11e/0x2d0 net/core/skbuff.c:657
> >    napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:811
> >    napi_get_frags+0x69/0x140 net/core/gro.c:673
> >    tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
> >    tun_get_user+0x77c/0x3e20 drivers/net/tun.c:1784
> >    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
> >    new_sync_write fs/read_write.c:593 [inline]
> >    vfs_write+0x5c9/0xb30 fs/read_write.c:686
> >    ksys_write+0x145/0x250 fs/read_write.c:738
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> >   Freed by task 6079:
> >    kasan_save_stack mm/kasan/common.c:47 [inline]
> >    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >    kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >    poison_slab_object mm/kasan/common.c:243 [inline]
> >    __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
> >    kasan_slab_free include/linux/kasan.h:233 [inline]
> >    slab_free_hook mm/slub.c:2422 [inline]
> >    slab_free mm/slub.c:4695 [inline]
> >    kmem_cache_free+0x18f/0x400 mm/slub.c:4797
> >    skb_pp_cow_data+0xdd8/0x13e0 net/core/skbuff.c:969
> >    netif_skb_check_for_xdp net/core/dev.c:5390 [inline]
> >    netif_receive_generic_xdp net/core/dev.c:5431 [inline]
> >    do_xdp_generic+0x699/0x11a0 net/core/dev.c:5499
> >    tun_get_user+0x2523/0x3e20 drivers/net/tun.c:1872
> >    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
> >    new_sync_write fs/read_write.c:593 [inline]
> >    vfs_write+0x5c9/0xb30 fs/read_write.c:686
> >    ksys_write+0x145/0x250 fs/read_write.c:738
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > After commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in
> > generic mode"), the original skb may be freed in skb_pp_cow_data() when
> > XDP program was attached, which was allocated in tun_napi_alloc_frags().
> > However, the napi->skb still point to the original skb, update it after
> > XDP process.
> > 
> > Reported-by: syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  drivers/net/tun.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index cc6c50180663..47ddcb4b9a78 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1875,6 +1875,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >  				local_bh_enable();
> >  				goto unlock_frags;
> >  			}
> > +
> > +			if (frags && skb != tfile->napi.skb)
> > +				tfile->napi.skb = skb;
> 
> This is observed with tun because syzkaller can fuzz napi with that.
> That unfortunately added fuzz test coverage to a combination that is
> not intended for real use: XDP generic before napi frags.
> 
> Tun is the only driver that calls do_xdp_generic on a napi.skb and
> later passes this napi to napi_gro_frags.
> 
> But this is no longer a napi frags skb on which napi_gro_frags
> (and napi_frags_skb and gro_pull_from_frag0) should be called? As the
> skb now has a linear part. Not sure that the frag0 is still correct.

Never mind this. napi_alloc_skb may also fall back to a regular
__skb_alloc and pass that a napi.skb to napi_gro_frags. Which
reinitializes the NAPI_GRO_CB and with that frag0 accordingly.




