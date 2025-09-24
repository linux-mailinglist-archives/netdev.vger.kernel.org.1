Return-Path: <netdev+bounces-225828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A15FAB98B03
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A444E2667
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D928153C;
	Wed, 24 Sep 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVndi3mW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6A27E060
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700071; cv=none; b=hbF5TGCDqEGwAvgcig2j6verlikneJR+x2Wxe++KT5SsGvTxGgWrpGNxe4ItTgNOIaXw/mw6AEhSDpV9p2DJMktRA1O7xLRKWmJ12bSBrsa01ODYnwOL/Z3c3iCBb2mRvCT2Xf7g50qT/uJoYZbIzJyXjJa29JCDAFI51wrPOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700071; c=relaxed/simple;
	bh=Z+vCoNdBMvuFeQgv/9edk+YvTT+7IoVHX3zaZJkyQk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlXFSBsRMntz5qubaZnvPAnuZ9sZ8ePqaKge2WZbz7TB9V9BIFZl2d2pWCu2kVCqsF6ZI8VoObS4JlINZVfCK5DjoapxpunxJw0ZBOCgsGpDS8OKYOJdpXoJf4Qs6mMenNqM+6ZCIk5+MenbUj0z1Dv/Ks0jnl5AhzS/dWTN4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVndi3mW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so11917371fa.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700067; x=1759304867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCAbY5J9TVOpKMtUVutIq51AeK08EZi5hcnzWE/qk4k=;
        b=WVndi3mWEu7D8tFMlRPKJ5HnltmiMDvoW6L5Q86pv+CRnUnUl2qGwMV2GkjtPDfotW
         o/Z1o9s1uIYD8gqhcfxXmMVZYmGgmmGQvTE5+nHMj8ARMQchKhbfap1XxvFqGMgiRvm1
         /HaJ2l+91WNcngNxmNAsNmV5cmsdGC4+hBBL2Wm0RobzX9QrdLKkHJ7fS2rTTcyYr/qC
         1MlzpbF64HjwbVNxmVpV8eydKVGJePpNVkrGGIMoFkCd7fG+4qwdyyWhxBPnHucnhO9O
         BaxakSKs/ZYpTfrlv+cgeljc63QkCf7JImrAWRrvYcF42QxB6PRXiLkjIRq1dd6P9dSp
         NEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700067; x=1759304867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCAbY5J9TVOpKMtUVutIq51AeK08EZi5hcnzWE/qk4k=;
        b=TSW7O+kwZmdWUUKHTd8lan7Cj3DxVpvoL5rGMNPTxjlA8g2x6zilFDEpJpIxazkXhG
         3PCt5oyVS2obSrVkAH4exMRPzPhazq9hPsTe3JOAhijeT5nLRKdXPSm2Kq56k4eQGFDl
         w12+jQnzIPuA8E6vmdQfDChVvOyIAQohcmrQySaZ1DtTYCyCdJ0m2CdNpFd4x+auy87E
         x+JI/G6VZWSVofq6b0lck9wOcu2vMkdCJ+ElrjfqMFfYcEhZg1xZZQ4FI2lVx+SGEPTK
         Xh8emQgPic0mQNBgEnOzWL3yo7oslrUWc1pTKWgfSNOon5/MKk3VujLv6Vt4PQ9/0gJT
         bjsg==
X-Forwarded-Encrypted: i=1; AJvYcCWYgyonx6h1XxauxuJzQlidNnkDng1O6vql4x0MbSt/wk6Hulq7X4am1hAdfOze3tKqcpK6M0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVJoKV7hALwZ31/IHbMgST950+5e4iB4lWWkx1NPyKK+DxFUV
	GDorgkVrKh/VvCuRm03+2D6F3L0GiN8SWt+SgYRNaZgKLgIB39puK0++
X-Gm-Gg: ASbGncsB0M6oytPgEBzX1rsNvygNsycsJSQ00bbb05NaujmoYygeLUm0IAgBg1UFeRo
	xm5HuOeeVFbTgkPNI73268PSK/9D6Mz4mgS9qmkdFFmDxsvX1dammppQcQMoaUyegp/7Jiafde7
	GUZcpCkOp/8L8BxaXX7CcUr4KvRkQyOa8glh1maiCUMZSu/3ZZ7iKOufJeWSN8kbjThNfAqhsf0
	5LFmhT7KzRaMggPerx5IWOGKeaL5USRwJ5jTMByL98SHLRCwmseJ1Xw3iU/Zru04UxRIRcynKH/
	YIgl+gNSMwL2LoUW0Rs9vtVE51nD65QMuScP0jmZsp9W+2HkASNo4y8igUKLrGImT2g1yslDR1O
	beumDI0zVoKI0HXufB4FljrGJR1F+K21kAkM=
X-Google-Smtp-Source: AGHT+IEbgdfhaSVwYw/hXIWU4C46EY3Pxhpiy1aKwy2RIdIiClgIYWPgTKxgS7oHeI7zJZkGYI3r6Q==
X-Received: by 2002:a2e:be27:0:b0:36d:3113:63ac with SMTP id 38308e7fff4ca-36d311365c5mr18771751fa.7.1758700066521;
        Wed, 24 Sep 2025 00:47:46 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36a13c0d94dsm24008991fa.49.2025.09.24.00.47.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 00:47:46 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:47:41 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petkan@nucleusys.com, skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924094741.65e12028.michal.pecio@gmail.com>
In-Reply-To: <20250920181852.18164-1-viswanathiyyappan@gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 23:48:52 +0530, I Viswanath wrote:
> syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> This is the sequence of events that leads to the Warning:
> 
>     CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
>     netif_stop_queue();
>                                                                     netif_stop_queue();
>     usb_submit_urb();
>                                                                     netif_wake_queue();  <-- Wakes up TX queue before it's ready
>                                     netif_stop_queue();
>                                     usb_submit_urb();                                    <-- Warning
> 	freeing urb

It's not freeing which matters but URB completion in USB subsystem.
I think this description is needlessly complex, the essence is:

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);
}

rtl8150_set_multicast() {
	netif_stop_queue();
	netif_wake_queue();  <-- wakes up TX queue before URB is done
}

rtl8150_start_xmit() {
	netif_stop_queue();
	usb_submit_urb(dev->tx_urb);	<-- double submission
}


> rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
> should not be calling netif_stop_queue and notif_start_queue as these handle 
> TX queue synchronization.
> 
> The net core function dev_set_rx_mode handles the synchronization
> for rtl8150_set_multicast making it safe to remove these locks.
> 
> Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Tested-by: Michal Pecio <michal.pecio@gmail.com>

This is instantly triggered on HW simply by running:

ncat remote-host port < /dev/zero &
ifconfig ethX allmulti

and results in:

[ 1253.338536] URB ffff88810ad01240 submitted while active
[ 1253.338616] WARNING: CPU: 2 PID: 2785 at drivers/usb/core/urb.c:379 usb_submit_urb+0x5f1/0x640 [usbcore]
[ 1253.338686] Modules linked in: usbhid uvcvideo rtl8150 xhci_pci xhci_hcd usbcore ext2 uvc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_pcsp usb_common serio_raw ppdev dm_mod nfnetlink [last unloaded: usbcore]
[ 1253.338724] CPU: 2 UID: 0 PID: 2785 Comm: ifconfig Tainted: G        W           6.17.0-rc4 #1 PREEMPT 
[ 1253.338734] Tainted: [W]=WARN
[ 1253.338737] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[ 1253.338740] RIP: 0010:usb_submit_urb+0x5f1/0x640 [usbcore]
[ 1253.338791] Code: 56 23 a0 e8 b1 17 3f e1 eb da b8 fe ff ff ff e9 fc fd ff ff 48 89 fe 48 c7 c7 88 20 25 a0 c6 05 c0 30 e1 ff 01 e8 cf 3a f0 e0 <0f> 0b eb a0 b8 f8 ff ff ff e9 d8 fd ff ff b8 ea ff ff ff c3 66 2e
[ 1253.338798] RSP: 0018:ffffc90000154e28 EFLAGS: 00010282
[ 1253.338804] RAX: 000000000000002b RBX: ffff88810ad01240 RCX: 0000000000000027
[ 1253.338808] RDX: ffff888226f17e08 RSI: 0000000000000001 RDI: ffff888226f17e00
[ 1253.338812] RBP: ffff88810be0ff00 R08: 00000000fff7ffff R09: ffffffff85a4d628
[ 1253.338816] R10: ffffffff82e4d680 R11: 0000000000000002 R12: ffff888125e19e00
[ 1253.338820] R13: 00000000000005ea R14: ffff88810be0ff00 R15: ffff8881326b4000
[ 1253.338824] FS:  00007fbb30220740(0000) GS:ffff88829ff7d000(0000) knlGS:0000000000000000
[ 1253.338830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1253.338834] CR2: 00007fbb301e5e38 CR3: 000000010be04000 CR4: 00000000001506f0
[ 1253.338838] Call Trace:
[ 1253.338846]  <IRQ>
[ 1253.338855]  rtl8150_start_xmit+0xa1/0x100 [rtl8150]
[ 1253.338865]  dev_hard_start_xmit+0x59/0x1c0
[ 1253.338875]  sch_direct_xmit+0x117/0x280
[ 1253.338883]  __qdisc_run+0x136/0x590
[ 1253.338890]  net_tx_action+0x1bb/0x2c0
[ 1253.338898]  handle_softirqs+0xcd/0x270
[ 1253.338907]  do_softirq+0x3b/0x50
[ 1253.338914]  </IRQ>
[ 1253.338916]  <TASK>
[ 1253.338919]  __local_bh_enable_ip+0x54/0x60
[ 1253.338927]  __dev_change_flags+0x9a/0x1e0
[ 1253.338933]  ? filemap_map_pages+0x3f3/0x620
[ 1253.338941]  netif_change_flags+0x22/0x60
[ 1253.338946]  dev_change_flags+0x3d/0x70
[ 1253.338951]  devinet_ioctl+0x388/0x710
[ 1253.338959]  inet_ioctl+0x145/0x190
[ 1253.338966]  ? netdev_name_node_lookup_rcu+0x59/0x70
[ 1253.338971]  ? netdev_name_node_lookup_rcu+0x59/0x70
[ 1253.338976]  ? dev_get_by_name_rcu+0xa/0x20
[ 1253.338982]  ? dev_ioctl+0x2fc/0x4b0
[ 1253.338989]  sock_do_ioctl+0x2f/0xd0
[ 1253.338996]  __x64_sys_ioctl+0x76/0xc0
[ 1253.339005]  do_syscall_64+0x42/0x180
[ 1253.339013]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1253.339019] RIP: 0033:0x7fbb3013fced
[ 1253.339024] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[ 1253.339028] RSP: 002b:00007ffdc876a850 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1253.339035] RAX: ffffffffffffffda RBX: 00007ffdc876a960 RCX: 00007fbb3013fced
[ 1253.339039] RDX: 00007ffdc876a8b0 RSI: 0000000000008914 RDI: 0000000000000004
[ 1253.339042] RBP: 00007ffdc876a8a0 R08: 000000000000000a R09: 000000000000000b
[ 1253.339045] R10: fffffffffffff8cb R11: 0000000000000246 R12: 00007ffdc876a8b0
[ 1253.339048] R13: 0000000000000004 R14: 0000000000000200 R15: 0000000000000000
[ 1253.339054]  </TASK>
[ 1253.339056] ---[ end trace 0000000000000000 ]---
[ 1253.339062] net eth1: failed tx_urb -16
[ 1253.339068] net eth1: failed tx_urb -16
[ 1253.339072] net eth1: failed tx_urb -16
[ 1253.339075] net eth1: failed tx_urb -16
[ 1253.339078] net eth1: failed tx_urb -16
[ 1253.339081] net eth1: failed tx_urb -16
[ 1253.339084] net eth1: failed tx_urb -16
[ 1253.339088] net eth1: failed tx_urb -16
[ 1253.339091] net eth1: failed tx_urb -16
[ 1253.339094] net eth1: failed tx_urb -16
[ 1253.339097] net eth1: failed tx_urb -16
[ 1253.339204] net eth1: failed tx_urb -16
[ 1253.339209] net eth1: failed tx_urb -16
[ 1253.339212] net eth1: failed tx_urb -16
[ 1253.339215] net eth1: failed tx_urb -16
[ 1253.339218] net eth1: failed tx_urb -16
[ 1253.339221] net eth1: failed tx_urb -16
[ 1253.339224] net eth1: failed tx_urb -16
[ 1253.339226] net eth1: failed tx_urb -16
[ 1253.339229] net eth1: failed tx_urb -16
[ 1253.339232] net eth1: failed tx_urb -16
[ 1253.339235] net eth1: failed tx_urb -16
[ 1253.339237] net eth1: failed tx_urb -16
[ 1253.339240] net eth1: failed tx_urb -16
[ 1253.339243] net eth1: failed tx_urb -16
[ 1253.339246] net eth1: failed tx_urb -16
[ 1253.339249] net eth1: failed tx_urb -16
[ 1253.339252] net eth1: failed tx_urb -16
[ 1253.339255] net eth1: failed tx_urb -16
[ 1253.339258] net eth1: failed tx_urb -16
[ 1253.339261] net eth1: failed tx_urb -16
[ 1253.339263] net eth1: failed tx_urb -16
[ 1253.339266] net eth1: failed tx_urb -16
[ 1253.339268] net eth1: failed tx_urb -16
[ 1253.339348] rtl8150 1-1:1.0 eth1: entered allmulticast mode

