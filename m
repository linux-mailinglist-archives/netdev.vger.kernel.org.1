Return-Path: <netdev+bounces-293088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Np8LDRxGWqNwggAu9opvQ
	(envelope-from <netdev+bounces-293088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E5601335
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836F43011BF0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644538C2DE;
	Fri, 29 May 2026 10:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95948255F2D
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051890; cv=none; b=LdYIMw/Q96pUD6oolzyoYJP04DScajxRi44hMgPWlrd9w1i6YQRweLH6bivyovRFj83lomWH7RH6t0FJhtG6JhfbbRYNLoe4+sw3QfGbbCmwQUTFNfRQPPbfH0pH0d6zMaL41F2uIPATkPQnklEo6c4/gWCjcpP2Yg1RXcdILKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051890; c=relaxed/simple;
	bh=m9K2gAT1s9pLnmlCXZPSvIpdh+VMVFWNKunD/EJAU8s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B4xqCi2Fv62ijcpCWLCUMMVZ5Dm0hfCVFRzEqncaRww8kr9IM3Dc/eSqYnvU/q28dAx1OObmV6761rRRU20EKwreYUYlFTfyUQWRI5nrklwdgYVj3ZlZsmmb6OcWLIgmluLvfUY7dSdamJ994UYExlqF5KALGs6SlY/0RzsjCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-43b472c3a38so14789686fac.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 03:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051887; x=1780656687;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Me4SIojYXmgVa1abLeE4WDtQzl3d8au5fzFAB6sRCJY=;
        b=XvAnHa5PpA3XT7LIDe9ka530H1DbK5Ee23jD4PSaW/54Shq1XgaqGuFNdQE2rb/08C
         daamJq5g21gxr7s+JrZocSfymUSRk4UAmpkSMUpJYix7Iabo4AmFRuay7DgWP1b0pfWn
         4+P2Jramun9/eVe9/BfK9HFgtyhKoHEWNDN2iGE9hyru/GQO5LeqQBxNOP8d9BQzGQBD
         kECgm0HQoCRC83w+dojLsnywFQvoSxjf+MipCV3dTstLbSKPRM6A6zn7w/zisEZ+t46k
         ew/+YnWDG/te6dvczYGgjEB/mtmkdoTZn0AKHyy4GAff3v7ouR3kgjzdf5a+LFy3vFxc
         QjQw==
X-Forwarded-Encrypted: i=1; AFNElJ9eI2Gn7JP6IWoV5B7oAMis8PkiP8eWadkROQ6cV3eLtEhIP+csdwjoB2fvdtRlICGeFpH3+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzsT+5vSmAOP2UxlXhYksbKxW+ePTg1CdNKls5fLO/npnop2H
	xsb0g3IBuYDzbcL1PULQCa0JaQ4qg731J0uV/pCVsrpLKCX8XcKPhpSn4BjBoThEVA5KAtYRt91
	RJdgYWR4GW+1eQNfx/+FL978hFtTowiKW4QKAxOj1Wi/puqrhn8wkH2HqdJo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7608:b0:69e:5d9:7e49 with SMTP id
 006d021491bc7-69e05d98633mr799983eaf.34.1780051887642; Fri, 29 May 2026
 03:51:27 -0700 (PDT)
Date: Fri, 29 May 2026 03:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a196faf.c16d89a8.217f2c.0002.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __fl_lookup (3)
From: syzbot <syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=91978e795dcd971b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293088-lists,netdev=lfdr.de,fa2f5b1fb06147be5e16];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0B0E5601335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    6a97c4d5262d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131bdb06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91978e795dcd971b
dashboard link: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e37d654ca33b/disk-6a97c4d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dac2f748909e/vmlinux-6a97c4d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/800a8a09004d/bzImage-6a97c4d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com

syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
=====================================================
BUG: KMSAN: uninit-value in __rht_ptr_rcu include/linux/rhashtable.h:388 [inline]
BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:631 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:671 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:709 [inline]
BUG: KMSAN: uninit-value in __fl_lookup+0x6ce/0x940 net/sched/cls_flower.c:269
 __rht_ptr_rcu include/linux/rhashtable.h:388 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:631 [inline]
 rhashtable_lookup include/linux/rhashtable.h:671 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:709 [inline]
 __fl_lookup+0x6ce/0x940 net/sched/cls_flower.c:269
 fl_mask_lookup+0x305/0xd60 net/sched/cls_flower.c:302
 fl_classify+0x36b/0x780 net/sched/cls_flower.c:349
 tc_classify include/net/tc_wrapper.h:198 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x855/0x1ca0 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0x82/0x5a0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue net/core/dev.c:4174 [inline]
 __dev_xmit_skb net/core/dev.c:4289 [inline]
 __dev_queue_xmit+0x23c3/0x5a00 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x8c6b/0x9d60 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0xf37/0xfd0 net/socket.c:2698
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2787
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0x390 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 fl_set_masked_key net/sched/cls_flower.c:194 [inline]
 fl_mask_lookup+0x254/0xd60 net/sched/cls_flower.c:298
 fl_classify+0x36b/0x780 net/sched/cls_flower.c:349
 tc_classify include/net/tc_wrapper.h:198 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x855/0x1ca0 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0x82/0x5a0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue net/core/dev.c:4174 [inline]
 __dev_xmit_skb net/core/dev.c:4289 [inline]
 __dev_queue_xmit+0x23c3/0x5a00 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x8c6b/0x9d60 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0xf37/0xfd0 net/socket.c:2698
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2787
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0x390 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __skb_flow_dissect+0xfdb/0xa060 net/core/flow_dissector.c:1182
 skb_flow_dissect include/linux/skbuff.h:1603 [inline]
 fl_classify+0x349/0x780 net/sched/cls_flower.c:346
 tc_classify include/net/tc_wrapper.h:198 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x855/0x1ca0 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0x82/0x5a0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue net/core/dev.c:4174 [inline]
 __dev_xmit_skb net/core/dev.c:4289 [inline]
 __dev_queue_xmit+0x23c3/0x5a00 net/core/dev.c:4831
 dev_queue_xmit include/linux/netdevice.h:3418 [inline]
 packet_xmit+0x8f/0x710 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x8c6b/0x9d60 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0xf37/0xfd0 net/socket.c:2698
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2787
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0x390 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4577 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_node_noprof+0x3cd/0x12c0 mm/slub.c:4951
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x855/0x1190 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0x990 net/core/skbuff.c:6743
 sock_alloc_send_pskb+0xacb/0xc60 net/core/sock.c:2998
 packet_alloc_skb net/packet/af_packet.c:2932 [inline]
 packet_snd net/packet/af_packet.c:3025 [inline]
 packet_sendmsg+0x6ed5/0x9d60 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0xf37/0xfd0 net/socket.c:2698
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2787
 x64_sys_call+0x1e20/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0x390 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 13869 Comm: syz.9.1335 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
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

