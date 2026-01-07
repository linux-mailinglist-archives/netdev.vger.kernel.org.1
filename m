Return-Path: <netdev+bounces-247682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A321ECFD51D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 12:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAB51301276F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF393002A5;
	Wed,  7 Jan 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDCZ9W/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187432FFDFA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783931; cv=none; b=H08pJv4MdoeSaSTO35CfIQDTJ8dkHj9p/rQ5h+WCS9oUg4uPr1ACMqRG/5nFl5v53Fv/YJwhfbojkNYTz9qDTnrOKq3EtuDSw7eg1Kd3f4DUFpKXSzKxNH+YieKi6hwbPZJBzmLvFKQ7E0vsdv2iRjbldUXYssk5TzlQJwxIy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783931; c=relaxed/simple;
	bh=vC+rfDueiphVZzfpeFA4hLF0uyo3KHGL1n66BXwo1kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIg5wNl6dfeiL0LvsNuEZigfUjqiSF6qYad605oS/MpzfrI6dpt38+ZDBVGJFRBdogipgt3gMUFx6Ze23+N6APvlScUjYL4z2Hvl7DZ5HkNfpghh/hbCAgxQD2YYGaBi0bMdTRtVHVrxK6Wp/pcR8XwMdt3yTVAOW9t/gN3/AOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDCZ9W/X; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ffa95fc5f1so16119091cf.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767783928; x=1768388728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e+AquoAyIfSR9Q2TEIP8Aagpv5iot4GbI+edDsterE=;
        b=bDCZ9W/XyCpyEroLyCrOojM1rAypUKMOYZNUngCQNcEJV9HMIVln8v7Y15SrVucGeh
         Q7Q2yl8FoWgmvYfMoUh0GbNdqvvFDx1BlqSdmVUPh4SQY4O3fDVSv1NimIdNwxk1UvAm
         wDiAj/LexK31yL+zYk7j6b19xpahnMQfXCVrQTY0t1RiaglipNzLMbax13y6UVP3cOpE
         +JudMrIEI/orqM/zGvHlNSimiZIuS+sLK/uOGky07Xjcx7OCvEoCB1P6vro1zWbP3e7w
         j4PDVyzSYWMSPBtiUImMXB08XP8LnSorT/wboya3a60j0a+VouM1U/pcHHOSacm/o1jT
         A5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783928; x=1768388728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+e+AquoAyIfSR9Q2TEIP8Aagpv5iot4GbI+edDsterE=;
        b=sbKt4h+d09fnS5l1o0NOoHrM829WzdcVvazugQ5RfK53Pfv+QhWRc1gix1JYa+X892
         mSTEo4yx5H7CvXGlbl3cPxRB/IJr+lgR8J5wr9KlGPALTTD/yXjg50jKYk0BUpMLp62c
         +0q/gUU/gHpqrvhNH8/S+sOOGqeksBcEh5Q0wkajEmkFrS9S5d+EEj/KZs1DPH3Qf8UH
         A3MgQRZw3IlCFPb66gVoVnvNqlbaYi/u/rZbCEEy4ooM1ntjxt3V/JgNOK2AsCFjMSxu
         /EyQYYbKbRut6XYkh/lxAKNKoueiR+16bmrGpyStsYC6flnVin4LNCAq/ti32knMGRgN
         isRA==
X-Forwarded-Encrypted: i=1; AJvYcCWJGVqjKRLWj6MD3GiRFtNtfIw5SqeueHnWqGC+0XW2VUsORXvRyZb59iRrWYlzcgq225WpyIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3qUSyp8BTlHl8h7KymijSayq3Cc3SHTSbhcRym9IpeMKuQFB
	iQWV2VWJvcocDOLhYu2yc7Bk6X//xsY0qOP7366RkncTjMvr1CwzdFDN/ePVoLJzaaCjsseT+01
	0NdXu+HvemzDimh7HmTjSV1576GefQ1rOWiF9vjDR
X-Gm-Gg: AY/fxX6QcMBA5vL7Ot723goaIYoj/cUUG1Xappf5+pcWh59rpSqGsT3gRjkVJBobBxX
	3m8hZJndcvNi0gQbGyt0h1TqPbKUUjVdmEWKcEeUZ48ROFvES76Lz88vdmAewnG+QlNlyMNSaYG
	Od8p5hLMWfGJ/fW5p+GiZ1mfGUGnKslUeUwFKgXSyatXMfztsfHjvrQ65NUZOu2/8gxpkFDybc4
	E3kjS/40qTwUrCFVEPtl5p81xFVlRajsLVMzrB2PloWXcKlfhgh0g1G7KHn5XQOFxfLpb3AJoBS
	hVaI
X-Google-Smtp-Source: AGHT+IG8FFq76luBAmJtf3J9btzdYoqgcOEhuOaJwlsG7Y9AvRdr7yrBVjW0i8og/Keh4XvZSnKs3R0yQXg8fGK4xW0=
X-Received: by 2002:ac8:580e:0:b0:4ee:1e28:acc5 with SMTP id
 d75a77b69052e-4ffb4a30d85mr24239001cf.61.1767783927677; Wed, 07 Jan 2026
 03:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <695e3d74.050a0220.1c677c.035f.GAE@google.com>
In-Reply-To: <695e3d74.050a0220.1c677c.035f.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Jan 2026 12:05:16 +0100
X-Gm-Features: AQt7F2puEZMC7Uq-i3CVfkpBIeAnMz8pJleM4rUZNh9Q2oSptXcxUf30e3ddqJU
Message-ID: <CANn89iJy0Gx35wV_e8Kq2PqdVA2GcjRU7nDxotgkqAzRAf6Ljg@mail.gmail.com>
Subject: Re: [syzbot] [bridge?] KCSAN: data-race in br_fdb_update /
 br_fdb_update (8)
To: syzbot <syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, horms@kernel.org, 
	idosch@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 12:03=E2=80=AFPM syzbot
<syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1304c92258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db319ff1b6a279=
7ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbfab43087ad5722=
2ce96
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f91c35600c27/dis=
k-f0b9d8eb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9edb3553b7a5/vmlinu=
x-f0b9d8eb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4d762ee145b8/b=
zImage-f0b9d8eb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com
>
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in br_fdb_update / br_fdb_update
>
> read to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 1:
>  br_fdb_update+0x106/0x460 net/bridge/br_fdb.c:1005
>  br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
>  br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
>  br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c=
:-1
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
>  br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
>  nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
>  nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
>  br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
>  __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
>  __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
>  __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
>  process_backlog+0x228/0x420 net/core/dev.c:6604
>  __napi_poll+0x5f/0x300 net/core/dev.c:7668
>  napi_poll net/core/dev.c:7731 [inline]
>  net_rx_action+0x425/0x8c0 net/core/dev.c:7883
>  handle_softirqs+0xba/0x290 kernel/softirq.c:622
>  do_softirq+0x45/0x60 kernel/softirq.c:523
>  __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  __alloc_skb+0x476/0x4b0 net/core/skbuff.c:674
>  alloc_skb include/linux/skbuff.h:1383 [inline]
>  wg_socket_send_buffer_to_peer+0x35/0x120 drivers/net/wireguard/socket.c:=
192
>  wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inl=
ine]
>  wg_packet_handshake_send_worker+0x10d/0x160 drivers/net/wireguard/send.c=
:51
>  process_one_work kernel/workqueue.c:3257 [inline]
>  process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
>  worker_thread+0x582/0x770 kernel/workqueue.c:3421
>  kthread+0x489/0x510 kernel/kthread.c:463
>  ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> write to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 0:
>  br_fdb_update+0x13e/0x460 net/bridge/br_fdb.c:1006
>  br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
>  br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
>  br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c=
:-1
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
>  br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
>  nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
>  nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
>  br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
>  __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
>  __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
>  __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
>  process_backlog+0x228/0x420 net/core/dev.c:6604
>  __napi_poll+0x5f/0x300 net/core/dev.c:7668
>  napi_poll net/core/dev.c:7731 [inline]
>  net_rx_action+0x425/0x8c0 net/core/dev.c:7883
>  handle_softirqs+0xba/0x290 kernel/softirq.c:622
>  do_softirq+0x45/0x60 kernel/softirq.c:523
>  __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
>  kernel_fpu_end+0x6c/0x80 arch/x86/kernel/fpu/core.c:480
>  blake2s_compress+0x67/0x1740 lib/crypto/x86/blake2s.h:42
>  blake2s_update+0xa3/0x160 lib/crypto/blake2s.c:119
>  hmac+0x141/0x270 drivers/net/wireguard/noise.c:324
>  kdf+0x10b/0x1d0 drivers/net/wireguard/noise.c:375
>  mix_dh drivers/net/wireguard/noise.c:413 [inline]
>  wg_noise_handshake_create_initiation+0x1ac/0x520 drivers/net/wireguard/n=
oise.c:550
>  wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:34 [inl=
ine]
>  wg_packet_handshake_send_worker+0xb2/0x160 drivers/net/wireguard/send.c:=
51
>  process_one_work kernel/workqueue.c:3257 [inline]
>  process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
>  worker_thread+0x582/0x770 kernel/workqueue.c:3421
>  kthread+0x489/0x510 kernel/kthread.c:463
>  ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> value changed: 0x0000000100026abc -> 0x0000000100026abd
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 8678 Comm: kworker/u8:42 Not tainted syzkaller #0 PREE=
MPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> net_ratelimit: 6540 callbacks suppressed
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:aa, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:aa, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:96:6e:14:75:db:9d, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:96:6e:14:75:db:9d, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
> net_ratelimit: 7050 callbacks suppressed
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:aa, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:aa, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:96:6e:14:75:db:9d, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:96:6e:14:75:db:9d, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source ad=
dress (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source add=
ress (addr:aa:aa:aa:aa:aa:1b, vlan:0)
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

I am taking care of this issue, I will add the syzbot tags when sending V3 =
of

https://lore.kernel.org/netdev/CANn89iLaMpL1Kz=3Dt13b0eGZ+m5dBxUpXx8oPKD1V-=
VwBAkzbJA@mail.gmail.com/T/#m19446ad4b132da817bda52a98a77a815034ed020

Thanks !

