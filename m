Return-Path: <netdev+bounces-176757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE1A6C03B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6406948648F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4822CBF9;
	Fri, 21 Mar 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egTq7eiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4E22CBFC
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575186; cv=none; b=rK3c/O+iBx2tg/84CvKol4r7yYg1wzfDs4n7z5m1hsIpyfqNM3tXw2iLI8xQskDl2LfIjpodCqrQ+Zc52MDyWku5c1HWTfeUs2ICdkh1ShLl7Ig9wiGAUgBn2EidgaRNNO3nfuMaaK3ngPgOh0wbqiDB11OCw+9s4bjretl2Icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575186; c=relaxed/simple;
	bh=dHYPVIKukVTB/9PlCPZhgMrqCFvgpPta0DU2iA+a+eA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QXo0YMkKAXZUJEdrDN5eoqj1ZyU252uL+7/l2vzEB+/Nydgy8bov5KzmHlGq9U9zKu2A1lSsGTSedZ4pyoa9qXSfm5iLVKFWOgx6OwG4qMW9LuEYOZkSEI06HSLL8kpl3en/0nzCtLRjTZgoC2toWLdh8ah58m7gfVqYIuX8M8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egTq7eiO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f254b875so19486606d6.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575183; x=1743179983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CeqtKPn9f39URC8E8gyapvtuDnj/nRFR88kZzi/xGs=;
        b=egTq7eiOWHlzBdkF+mPE6Rj2CFsJLRfMSjEPh/1gKOhs2gzfSVntZWZSiDM67kghwI
         Bk83JOW4Lmix1jGnkz+TTwqhhKH8tILs2w5TGfuKMmP0n/eLEtAwvta5/v8G5INHZvEe
         20iZdHwPAItQ/JjHkTKVwyvlO00lYmXJt9A20zbDmZ+MGn1jOQcJ4d8Xw+X1v0wCeyB9
         Xz1+AAu8tukxObP9Mc7y+uakmf9S+kaWM4bZ64rgxPgxTHcZ3rtr7mqSpynNuxTFdqW2
         hTSygqVhdbVJRGdbOVXkmZV3YVg66Yzak+tfZtN/GEVsaNgutRkB6007pL89bpiGvI3o
         sbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575183; x=1743179983;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CeqtKPn9f39URC8E8gyapvtuDnj/nRFR88kZzi/xGs=;
        b=Vc18W18gVcBzi5Wc0aeUr1tynvmlw0wONr/uiZ8r6l/5PLlqzoDLmmdjAvxqpy03qy
         af2kO7vyK8zdqIPqsxAAkAEaQ0fn7sl247auA9chHfxV4yFz9QT/yG5NtH4/ARE4W8T6
         /CbbdUYA6povW8RVJV5dE8NeIE7Ui5pC5Q1798mfqM/2XAmbS6LbNVcU37doy+6zhYaq
         xMbFBuVtOGu7WJnzddmLEF2m+TFisxrvrDDM/57pXbG7KieKTWK7q5qQMeix+mbBRhJ3
         75Qw+J5qWAPiPs1lk1GDVwHVRxA/GQsawWCDDk5DVVOYTFds+QEWNPq7BcSIrqm+WeLN
         a+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXGXNRsDCFF+MJHqPsUTbfjOjEMpQiMrE5PiDGrxzYLU+qtO3sR7BdlDaryAIKpKjl07l4RHX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg75Kt6xCTs+16UeMLZYYtuGdrmye0x7V+uFHiMlYiyocwPI57
	6X6cvg18o9UVbjO9EynxbR+OsloXxYOlieJONJkvd8/QqgKT/kxC
X-Gm-Gg: ASbGnctoG1D3gi6eUHr0MuMEtypkRw77VSwkuCAnqWy+mF8bKFkDlfw6Ypm7AGonTG/
	4NgJYmtyWbgKpcjdunTBILNDbMDvZ9YY+EGX7h07l3Ob8LE1ZeZos1Ut7y/wNp6xpLLZskzjLHE
	j1vEMqZ2/rANLqmfBtsiBYd8G8zODPOU7NsjfWkP2s9mwcbLzrN6lXMb5j6Bv8Z/aEnC5HROgm0
	zGchf/ppptTr2xg6FSDDN+tXKFVVLqjYKLu21i/pmfUqHBcKwdgQ4B5hRfvtZlfc8vktMEc22RT
	MfT7LQ17uN4OT8tAAeMbuDwVi4/8JmRuvWdgIrupgkSu3XZvloeWMRGirAqXNZxvstpIXdAXg4Q
	ozx8fwq+c9yRc/6NFgvDyEDizwW1IjY4b
X-Google-Smtp-Source: AGHT+IEiqr7SDwwpDbvcjSGPmzE5DDimdHxNCvKi5BQ69z4IUyfXh74Wjy6P9iCQoMo+zm1GTV6e6Q==
X-Received: by 2002:a05:6214:27e5:b0:6e6:5f08:e77d with SMTP id 6a1803df08f44-6eb3f297378mr66137986d6.19.1742575183335;
        Fri, 21 Mar 2025 09:39:43 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef34792sm12862276d6.68.2025.03.21.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:39:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:39:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <67dd964e5b730_14b14029454@willemb.c.googlers.com.notmuch>
In-Reply-To: <70a8c5bdf58ed1937e2f3edbefb37c55cfe6ebc1.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
 <70a8c5bdf58ed1937e2f3edbefb37c55cfe6ebc1.1742557254.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/5] udp_tunnel: fix UaF in GRO accounting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Siyzkaller reported a race in UDP tunnel GRO accounting, leading to
> UaF:
> 
> BUG: KASAN: slab-use-after-free in udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
> Read of size 8 at addr ffff88801235ebe8 by task syz.2.655/7921
> 
> CPU: 1 UID: 0 PID: 7921 Comm: syz.2.655 Not tainted 6.14.0-rc6-syzkaller-01313-g23c9ff659140 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0x16e/0x5b0 mm/kasan/report.c:521
>  kasan_report+0x143/0x180 mm/kasan/report.c:634
>  udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
>  sk_common_release+0x71/0x2e0 net/core/sock.c:3896
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_release+0x82/0x150 net/socket.c:675
>  sock_free drivers/net/wireguard/socket.c:339 [inline]
>  wg_socket_reinit+0x215/0x380 drivers/net/wireguard/socket.c:435
>  wg_stop+0x59f/0x600 drivers/net/wireguard/device.c:133
>  __dev_close_many+0x3a6/0x700 net/core/dev.c:1717
>  dev_close_many+0x24e/0x4c0 net/core/dev.c:1742
>  unregister_netdevice_many_notify+0x629/0x24f0 net/core/dev.c:11923
>  rtnl_delete_link net/core/rtnetlink.c:3512 [inline]
>  rtnl_dellink+0x526/0x8c0 net/core/rtnetlink.c:3554
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>  netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:709 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:724
>  ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>  ___sys_sendmsg net/socket.c:2618 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2650
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f35ab38d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f35ac28f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f35ab5a6160 RCX: 00007f35ab38d169
> RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000004
> RBP: 00007f35ab40e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f35ab5a6160 R15: 00007ffdddd781b8
>  </TASK>
> 
> Allocated by task 7770:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4115 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
>  sk_prot_alloc+0x58/0x210 net/core/sock.c:2190
>  sk_alloc+0x3e/0x370 net/core/sock.c:2249
>  inet_create+0x648/0xea0 net/ipv4/af_inet.c:326
>  __sock_create+0x4c0/0xa30 net/socket.c:1539
>  sock_create net/socket.c:1597 [inline]
>  __sys_socket_create net/socket.c:1634 [inline]
>  __sys_socket+0x150/0x3c0 net/socket.c:1681
>  __do_sys_socket net/socket.c:1695 [inline]
>  __se_sys_socket net/socket.c:1693 [inline]
>  __x64_sys_socket+0x7a/0x90 net/socket.c:1693
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 7768:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free mm/slub.c:4609 [inline]
>  kmem_cache_free+0x195/0x410 mm/slub.c:4711
>  sk_prot_free net/core/sock.c:2230 [inline]
>  __sk_destruct+0x4fd/0x690 net/core/sock.c:2327
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1389
>  __fput+0x3e9/0x9f0 fs/file_table.c:464
>  task_work_run+0x24f/0x310 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88801235e4c0
>  which belongs to the cache UDP of size 1856
> The buggy address is located 1832 bytes inside of
>  freed 1856-byte region [ffff88801235e4c0, ffff88801235ec00)
> 
> At disposal time, to avoid unconditionally acquiring a spin lock, UDP
> tunnel sockets are conditionally removed from the known tunnels list
> only if the socket is actually present in such a list.
> 
> Such check happens outside the socket lock scope: the current CPU
> could observe an uninitialized list entry even if the tunnel has been
> actually registered by a different core.
> 
> Address the issue moving the blamed check under the relevant list
> spin lock.
> 
> Reported-by: syzbot+1fb3291cc1beeb3c315a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
> Fixes: 8d4880db37835 ("udp_tunnel: create a fastpath GRO lookup.")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

