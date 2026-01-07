Return-Path: <netdev+bounces-247681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5441CFD556
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734C8301C915
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1CB2FD1DC;
	Wed,  7 Jan 2026 11:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B862EDD69
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783800; cv=none; b=PfdqAu+T/gXkJXOIlD1oUD2Ge/c2IWODmIUcSBnoYKMeOnN4JpHA2rcZkvo3tZXlShfXnBrk1aiSbsuWddKuTnCe5bqLVU+TiO3ET/NttfC1Rm39V8UioHVp4ePNASjNdbdisUniX8mPo7FAr67t3bGLXDzya7+GTUeaHdXm+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783800; c=relaxed/simple;
	bh=9YmFFHHYIqyVB3Ut9rjIEURsPfRSbWn9cithoGdSowA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kLYDSk2Dg2AJTeBF+tNDjhENo+ULI5G76MtjvrnGvIfuA9PX7WfjF/u58woYl6xnjFzCJ9T7YHRgv/xXHHg3tIfKAyDWeNOtvzSrvMkFjFyy7NvfME2MhXNRwWII21gD/yXA6+mpAPpK/EVdNdejN5fqh3PJGraRmJpvXTLCqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65b2cd67cceso4264827eaf.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 03:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783796; x=1768388596;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAzea6RibarWVUjrp90ecxeeipp3LvJAd2KfQev/m34=;
        b=VY5d+5lRZwL2yckfu84UxkEnztB2RQP/rrUyKU+d1X8ZYF2i1QakT8A2QopL0VxxK5
         OwDdWbHxBEyHqa7IqasHy12aMml7q059cPa9VgqKk/93SwFcUBwoFGMUcrMjfiZ/2O4L
         +hc/unNTEBQGytZUgBtC3b3OJoipiaUKx1O8E0+M1MdOnHO8CNeyqVwqVhQSPdiWh6oA
         GCtIiR1E8k0N9p1zV8QgwfXcPQI6zBDxFo67Wz89CdRiV87bCZ2oG1rmNOeS8oUr4zqt
         h4pCErUSLA4prjXpllVfANodFS7MuUiwMRnUjk7DuEL03l+LdqglMCJzE7ksQaQGqUlA
         X/8g==
X-Forwarded-Encrypted: i=1; AJvYcCXVFRQ/8Q/o0lTGsmzNxwFSuS/b35KhgmqPUO7MdXyjdlGQREAOJHJGbQlQZWmfM37CNLiISLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNDcHZ861Hf/nHV7wpNiSpcv8P7c8wm/eF6c5RPcbwvsC9Llw
	yUQG2/rgTWhnI8NHqQrFPk+RF6mhKGOqwKNl14BtwBlqDJJBHeONd2lrExkqQdAoozkPBi1Wb8T
	MP7m8Ux3dAsD46R2khdGsGBK92q0iB6OkMmbiS25//g4mO+un2pR+zn+C/cU=
X-Google-Smtp-Source: AGHT+IE/bvj8Ni/UExwZ9hRKWGqxU4MJF5rRLxU1s8dA+C5hRjhru7rhpGVctzgUZNlHKEjaVoQwZh5ck52qF5n7Tui/gByk1X4H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7815:b0:659:9a49:9023 with SMTP id
 006d021491bc7-65f5509c1admr623635eaf.80.1767783796217; Wed, 07 Jan 2026
 03:03:16 -0800 (PST)
Date: Wed, 07 Jan 2026 03:03:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e3d74.050a0220.1c677c.035f.GAE@google.com>
Subject: [syzbot] [bridge?] KCSAN: data-race in br_fdb_update / br_fdb_update (8)
From: syzbot <syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1304c922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b319ff1b6a2797ca
dashboard link: https://syzkaller.appspot.com/bug?extid=bfab43087ad57222ce96
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f91c35600c27/disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9edb3553b7a5/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d762ee145b8/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
==================================================================
BUG: KCSAN: data-race in br_fdb_update / br_fdb_update

read to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 1:
 br_fdb_update+0x106/0x460 net/bridge/br_fdb.c:1005
 br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
 br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
 process_backlog+0x228/0x420 net/core/dev.c:6604
 __napi_poll+0x5f/0x300 net/core/dev.c:7668
 napi_poll net/core/dev.c:7731 [inline]
 net_rx_action+0x425/0x8c0 net/core/dev.c:7883
 handle_softirqs+0xba/0x290 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x476/0x4b0 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1383 [inline]
 wg_socket_send_buffer_to_peer+0x35/0x120 drivers/net/wireguard/socket.c:192
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
 wg_packet_handshake_send_worker+0x10d/0x160 drivers/net/wireguard/send.c:51
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
 worker_thread+0x582/0x770 kernel/workqueue.c:3421
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

write to 0xffff88811a0655c0 of 8 bytes by interrupt on cpu 0:
 br_fdb_update+0x13e/0x460 net/bridge/br_fdb.c:1006
 br_handle_frame_finish+0x340/0xfc0 net/bridge/br_input.c:144
 br_nf_hook_thresh+0x1eb/0x220 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x4d1/0x570 net/bridge/br_netfilter_ipv6.c:-1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x1fa/0x2b0 net/bridge/br_netfilter_ipv6.c:184
 br_nf_pre_routing+0x52b/0xbd0 net/bridge/br_netfilter_hooks.c:508
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x4f0/0x9e0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x5df/0x1920 net/core/dev.c:6026
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x59/0x270 net/core/dev.c:6252
 process_backlog+0x228/0x420 net/core/dev.c:6604
 __napi_poll+0x5f/0x300 net/core/dev.c:7668
 napi_poll net/core/dev.c:7731 [inline]
 net_rx_action+0x425/0x8c0 net/core/dev.c:7883
 handle_softirqs+0xba/0x290 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 kernel_fpu_end+0x6c/0x80 arch/x86/kernel/fpu/core.c:480
 blake2s_compress+0x67/0x1740 lib/crypto/x86/blake2s.h:42
 blake2s_update+0xa3/0x160 lib/crypto/blake2s.c:119
 hmac+0x141/0x270 drivers/net/wireguard/noise.c:324
 kdf+0x10b/0x1d0 drivers/net/wireguard/noise.c:375
 mix_dh drivers/net/wireguard/noise.c:413 [inline]
 wg_noise_handshake_create_initiation+0x1ac/0x520 drivers/net/wireguard/noise.c:550
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:34 [inline]
 wg_packet_handshake_send_worker+0xb2/0x160 drivers/net/wireguard/send.c:51
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
 worker_thread+0x582/0x770 kernel/workqueue.c:3421
 kthread+0x489/0x510 kernel/kthread.c:463
 ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

value changed: 0x0000000100026abc -> 0x0000000100026abd

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 8678 Comm: kworker/u8:42 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
==================================================================
net_ratelimit: 6540 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
net_ratelimit: 7050 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:aa, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:96:6e:14:75:db:9d, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

