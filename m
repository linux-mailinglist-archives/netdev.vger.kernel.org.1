Return-Path: <netdev+bounces-258780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NCwJkrckWmHnQEAu9opvQ
	(envelope-from <netdev+bounces-258780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA413EE4D
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A24C300D147
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577EB2D46A1;
	Sun, 15 Feb 2026 14:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6462F3632
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166791; cv=none; b=Yz909Ect+d2FSwTGfNX8+eGBv2CANrNj5/dUBBsuVtWte77QNvGc2LHkCsVpsz9au4I1fJYebuKnSHLwMzvhqBXou8GgrJUOnXhAfTIv9cr+sDOYlh4LItTUwGnsqSgZb6OKXXeITcXZpqh1VQiTsrpW4gi4ot6ZzgbN2Oc/89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166791; c=relaxed/simple;
	bh=kANZWyVz5SSkoFnZZKgZ7WKpFnYcom0kMPLXYSv6y8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jO3rjIDulRYF4bp7kRKfFm32kIti1g8bQy8++oY24n9LuKRXsrzws7A1UkGvfdP7xKXOYZk0TdVF74wX0wFHIWwVyzZzomEFbb1GW0h+YmsWB6XqOTGm8ZueBUpPubjXvOZ8vgGOVmtrEKzFukmUp8awkKvRdhcBU7gAwbHekKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66308f16ea1so22148533eaf.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166787; x=1771771587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HYMGBC3NRRKUc9X+aGwgpZ7aHFzS6lDTXhZs7CIQeQ=;
        b=gsIUt66SJ/ZXCJEOIkhu86b9VgjcXNzncvUW8nOX36wpYzhgMKHc5cMw6PbzJNh8xE
         GZuziJ+FXoVJoB7gKQYrncI4we1jFaDvmj1LnEcmJpt8oTyFYrOU+hZDhE62y/JWeVaM
         KQ2oNu+8FA/zaARHFJGPbCjLhgu82sjsf6wDTkVM7Ok9brXZ3rB/qX+aYeH2loQRx6T8
         0pXtmYt3c9c1grpg1VltTJPtZjY6KHBVjUZXEKMRlEdKsWDW5fiqx0P7jK2PN7sTn+x8
         rodz5sPqeKREKt2bDav5tP9370ffymmbZ6sds3mvHjMzuZ31NO4NVr8RZfvzHbnV0TUm
         tjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgPFypQjhTD3tYgP/vyZonHM/1TF3XHPUHezI5DKmFN9PAwkOhbJSo1qYIWuG7Ad/ccuTSJtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69Jck4s8B5+m3ZJ22Ng6LKWEmSjVkwdrlqyA8QPnHQOMx8t3u
	87kX3M+Yjcpi2lFWZ5wGCxTCaIFtjZO5JGb1rPS6UStToE2MbzSQEaFWHtMcusLqglNI60oveI8
	D1KZWRAGVXcyG0dJZqi5epj8CQ1pWT0S22QqivgbTXkLez73EukFuyRsYfS0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f021:b0:66a:ebc4:66ca with SMTP id
 006d021491bc7-67769d69f1bmr3535770eaf.83.1771166787426; Sun, 15 Feb 2026
 06:46:27 -0800 (PST)
Date: Sun, 15 Feb 2026 06:46:27 -0800
In-Reply-To: <68e4b5d8.050a0220.256323.0018.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6991dc43.a70a0220.2c38d7.00df.GAE@google.com>
Subject: Re: [syzbot] [bridge?] KMSAN: uninit-value in netif_skb_features (4)
From: syzbot <syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4b4f2aab682301f1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258780-lists,netdev=lfdr.de,1543a7d954d9c6d00407];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 01DA413EE4D
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    ca4ee40bf13d Partly revert "drm/hyperv: Remove reference t..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1575c722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b4f2aab682301f1
dashboard link: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1044ec02580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3fe5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68f5e4558a91/disk-ca4ee40b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea1eab60444d/vmlinux-ca4ee40b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc7e3debdec4/bzImage-ca4ee40b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in gso_features_check net/core/dev.c:3804 [inline]
BUG: KMSAN: uninit-value in netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
 gso_features_check net/core/dev.c:3804 [inline]
 netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
 validate_xmit_skb+0xb6/0x2400 net/core/dev.c:4003
 validate_xmit_skb_list+0xd4/0x320 net/core/dev.c:4065
 sch_direct_xmit+0xd4/0xcf0 net/sched/sch_generic.c:332
 __dev_xmit_skb net/core/dev.c:4179 [inline]
 __dev_queue_xmit+0x3016/0x5a50 net/core/dev.c:4795
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3077 [inline]
 packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xfe7/0x1080 net/socket.c:2592
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2681
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4466 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_node_noprof+0x3cd/0x12d0 mm/slub.c:4840
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x855/0x1190 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6750
 sock_alloc_send_pskb+0xacb/0xc60 net/core/sock.c:2995
 packet_alloc_skb net/packet/af_packet.c:2927 [inline]
 packet_snd net/packet/af_packet.c:3020 [inline]
 packet_sendmsg+0x7477/0xa320 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xfe7/0x1080 net/socket.c:2592
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2681
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6045 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

