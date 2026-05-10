Return-Path: <netdev+bounces-286397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCieHCPoAGpaOQEAu9opvQ
	(envelope-from <netdev+bounces-286397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:18:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA455062F3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A3763001CC2
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCDF2F0C7E;
	Sun, 10 May 2026 20:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250225A2A4
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444317; cv=none; b=NiU8jVk6DyAcPRVh8B5ogVI6w5YSieWPDY7w57wwntfzCd4DoocHjZGpi378LAoC6iq4zwtiTc+T0Fplx37IlY+Bd0G4LMEnUZg33URkJ6iBrcoSQtKtHffhhZhQXi0lwsTQLHdS9PET/wxI2b0K+1OIF/kpDuPucZxexlv65b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444317; c=relaxed/simple;
	bh=1VbD9tSoOOiOx7L7/yrlqyIvm1z7oewsM4VYLk9kyM4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k3hhpATY9CM0zwkbOVY2Z0w5S54niIkIN3+mhKaGBzl4pnz6WwGm4xhFwdqbZlg/MpAQlMdIGR6n+Wbh2cPbNWLdoan3EH1ja2xpZCecOdl19lRrsaHJxgbMJXIR+/8D+alEXUSi3fpgN2nKMWmWE0BEbB1LJGY5+6z8i7xkoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-696133ef271so6524954eaf.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 13:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778444315; x=1779049115;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsFrkuR5c5pzT52uZjALg+IZX4swjzWnbawhX1WZ8ZA=;
        b=HLmzrlralhdt3/u6iXlMdFn1ZfTxLqj4++WQN5QCrqQ9a/CC/4r9dwsxVMVGB0I99J
         UVv8PYYAuMiPaOnmasFfWAZPEC0TQz6b+dAE/L3+llAj4Y+mO9qDULvCxhgzocdNij+Z
         QEeteI+i34C3pRsbcRRU206kyNRQsJ250hHPzHFnFZL5VE7jm6W2YTjnb/u0DFtSR6/s
         TljmJfN/VubF1O4hWZD5Ymm4DPwg7c/EJiq5rNYyhvFUbBM3bs8q9krVpjgzZH+oKHML
         dI6FxtGk+cKR51O3ks5HqdbjOn8iAc5q0TiNxQd6wKoNVlaSY8BtjAfG9EuWu0UWFbwi
         TFbA==
X-Forwarded-Encrypted: i=1; AFNElJ8hiUCrTVbvPYUmbPml2VURKyUMjzs7aiCWMMwaxwNZye516rwlUHnUN13OSjcsx7ZAxM4X7zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUseMpWqOwCZh9FPvAciSoZDzGPEPDT5snYvkk8tIIAlHf5/7
	aK2xaUKThtxbshUW/P+dj4ooomvlFVy8H2rCqpW2vSTdnvu5fFoM1WtSacGO1F6WRsLHEegKCFv
	6TM91FxcatIMO9vIKjuU/HoFwZ9x8qK/pwu31fOegUES5IvMORhPAdhm0jeI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c8f:b0:694:8f3a:3f36 with SMTP id
 006d021491bc7-69b36adfb5dmr3605240eaf.27.1778444314878; Sun, 10 May 2026
 13:18:34 -0700 (PDT)
Date: Sun, 10 May 2026 13:18:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a00e81a.170a0220.1c0296.0218.GAE@google.com>
Subject: [syzbot] [net?] unregister_netdevice: waiting for DEV to become free (9)
From: syzbot <syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8BA455062F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-286397-lists,netdev=lfdr.de,e2af46126e0644cbebdd];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,goo.gl:url,storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    5cbb61bf4168 arm64/fpsimd: ptrace: zero target's fpsimd_st..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=142f40ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
dashboard link: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103f3dba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04156ec16593/disk-5cbb61bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bfa041e2c79/vmlinux-5cbb61bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92d82d8a79e/Image-5cbb61bf.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7915d7230a1d/mount_6.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15005a73980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com

unregister_netdevice: waiting for netdevsim1 to become free. Usage count = 2
ref_tracker: netdev@00000000f11a2c54 has 1/1 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4471 [inline]
     netdev_tracker_alloc include/linux/netdevice.h:4483 [inline]
     netdev_get_by_index+0x88/0xe0 net/core/dev.c:1027
     fib6_nh_init+0x258/0x14bc net/ipv6/route.c:3606
     ip6_route_info_create_nh+0x120/0x9a8 net/ipv6/route.c:3905
     addrconf_f6i_alloc+0x1e4/0x3b4 net/ipv6/route.c:4697
     ipv6_add_addr+0x458/0xd70 net/ipv6/addrconf.c:1126
     addrconf_add_linklocal+0x1e0/0x378 net/ipv6/addrconf.c:3311
     addrconf_addr_gen+0x27c/0x2e0 net/ipv6/addrconf.c:-1
     addrconf_init_auto_addrs+0x390/0x764 net/ipv6/addrconf.c:-1
     addrconf_notify+0x7a0/0xbe4 net/ipv6/addrconf.c:3752
     notifier_call_chain+0x194/0x60c kernel/notifier.c:85
     raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
     call_netdevice_notifiers_info+0xb8/0x120 net/core/dev.c:2249
     call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
     call_netdevice_notifiers net/core/dev.c:2301 [inline]
     __dev_notify_flags+0x160/0x27c net/core/dev.c:9794
     netif_change_flags+0xd0/0x15c net/core/dev.c:9823
     do_setlink+0xab0/0x31c0 net/core/rtnetlink.c:3180
     rtnl_changelink net/core/rtnetlink.c:3799 [inline]
     __rtnl_newlink net/core/rtnetlink.c:3972 [inline]
     rtnl_newlink+0xd24/0x113c net/core/rtnetlink.c:4109

netdevsim netdevsim2 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

