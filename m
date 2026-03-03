Return-Path: <netdev+bounces-263048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X4HVH6t6pml7QQAAu9opvQ
	(envelope-from <netdev+bounces-263048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:07:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC41E9652
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA84430459FB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 06:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81C347531;
	Tue,  3 Mar 2026 06:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC430F95C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518053; cv=none; b=Sfpz++BEo9goz/Y8NqtjfGKkwZhSItInMH687n7R9FdPDYvyiiZLBpY+SEYwZ3J2cGwuxSHAfyDu3inaGEVMTMF5KywJ4ez7/1Gg8/wg1QA/9VcS6vi9aI7c4YYpcgn+OFmUIQeIkL4kw+t+LWxxRSlrbZGtsZcvSn0wmW6Wu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518053; c=relaxed/simple;
	bh=vvrILT+iq8oS4mB6nITgoC6Lmr1isJ71LVd3pdQSF6E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ktd7gqwTaJXLMz1PkCvSYPefbhNmNot7YR4gNA4EuAk6i3+VkMC+y2p71J8DoaFsSy3CpwwGha+N+dn7ffpSJVIpc3Lk1JHQPilJxuo9EdGeUn5/tFLit7cSYKKEjngBHD2vrug4qUAhkmyzkqP8GOv99nxop7SYhIifBpYLGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679a47a1febso103270937eaf.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 22:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518051; x=1773122851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXYLFdJyo3qj8tElYEFbgHcNzB4ixy6p8N0OWxG4X4A=;
        b=duuLJejy5rY8RBIvhNLxdHs3dR7h59PwxsV0Y/KCBeNFSfzogPKqG5f3YSm/J1BQht
         mRmQ4m+JpKD+kfMdtFSztAlBOU+vqqED07VDjEviwmlorkf5VIimBlRYNUfw94awAesC
         RNXI4ohyWpdxu2u43C1qeR+xZeEcp3vza1DYw4JnRUYltxrr04O0dT5YUdOh6SVIrGwc
         vKVCyxARUyJaDj6LxQp9HelR+IjCJMDZjnXpCxEUVAPqMXEyIirXYOieD5LAAyZ5OOMN
         2JesLYlgBoOGRoA5gQAO38ccF5q8q+fE13y++GUiXL3e/zvAaQFp14W4DpAOmts97y/P
         b80w==
X-Forwarded-Encrypted: i=1; AJvYcCVxOavfTmzrxbfAu/xd0BGIsn7RaCIrWy9KP7uRCy7Ri7xAjtch5cPfJqB9rWV+ubc9TaWpFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhv4aeRLaiAy9QMAhLvy1uJ2y6U0q3Fn+cgHWChLd0RZrl4EDg
	kGcb9OVfAA+qQUKXcx/Z4JCbES6DuC899G7JFghvWYXiopkKJvGQ9S015xhUaFZbuYLiC6dxqhz
	ug2zN2uqTmKIHNxyHpVQAl6T5ivV3buIZ7Bse6UnwJDdgaEzdrkhqVh5G3yY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208a:b0:679:97d5:dd25 with SMTP id
 006d021491bc7-679faf4e60bmr8716001eaf.56.1772518051182; Mon, 02 Mar 2026
 22:07:31 -0800 (PST)
Date: Mon, 02 Mar 2026 22:07:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a67aa3.a70a0220.b118c.000a.GAE@google.com>
Subject: [syzbot] [wireless?] KMSAN: uninit-value in nl80211_send_pmsr_capa
From: syzbot <syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1BDC41E9652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=10f867da86e38691];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263048-lists,netdev=lfdr.de,c686c6b197d10ff3a749];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    eb71ab2bf722 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b7d0ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f867da86e38691
dashboard link: https://syzkaller.appspot.com/bug?extid=c686c6b197d10ff3a749
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcbe8b5437ef/disk-eb71ab2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/245a6565a05b/vmlinux-eb71ab2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a83b065baa80/bzImage-eb71ab2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c686c6b197d10ff3a749@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nl80211_send_pmsr_ftm_capa net/wireless/nl80211.c:2302 [inline]
BUG: KMSAN: uninit-value in nl80211_send_pmsr_capa+0x6fe/0x1b50 net/wireless/nl80211.c:2404
 nl80211_send_pmsr_ftm_capa net/wireless/nl80211.c:2302 [inline]
 nl80211_send_pmsr_capa+0x6fe/0x1b50 net/wireless/nl80211.c:2404
 nl80211_send_wiphy+0x1464/0x96d0 net/wireless/nl80211.c:3302
 nl80211_dump_wiphy+0x5b6/0xc80 net/wireless/nl80211.c:3447
 genl_dumpit+0x14e/0x2a0 net/netlink/genetlink.c:1026
 netlink_dump+0xbaa/0x1800 net/netlink/af_netlink.c:2325
 netlink_recvmsg+0xc8a/0xfe0 net/netlink/af_netlink.c:1976
 sock_recvmsg_nosec+0x23e/0x2e0 net/socket.c:1078
 ____sys_recvmsg+0x4e5/0x620 net/socket.c:2810
 ___sys_recvmsg+0x20b/0x850 net/socket.c:2854
 do_recvmmsg+0x40e/0xdf0 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x383/0x500 net/socket.c:3039
 x64_sys_call+0x96d/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mac80211_hwsim_new_radio+0x60b8/0x7e20 drivers/net/wireless/virtual/mac80211_hwsim.c:5837
 hwsim_new_radio_nl+0x1839/0x3160 drivers/net/wireless/virtual/mac80211_hwsim.c:6504
 genl_family_rcv_msg_doit+0x338/0x3f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0xac5/0xc00 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2550
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x10b2/0x1250 net/netlink/af_netlink.c:1894
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
 slab_post_alloc_hook mm/slub.c:4522 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 __kmalloc_cache_noprof+0x35e/0x1260 mm/slub.c:5353
 kmalloc_noprof include/linux/slab.h:950 [inline]
 hwsim_new_radio_nl+0x1705/0x3160 drivers/net/wireless/virtual/mac80211_hwsim.c:6492
 genl_family_rcv_msg_doit+0x338/0x3f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0xac5/0xc00 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2550
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x10b2/0x1250 net/netlink/af_netlink.c:1894
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

CPU: 0 UID: 0 PID: 15981 Comm: syz.5.4560 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
=====================================================


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

