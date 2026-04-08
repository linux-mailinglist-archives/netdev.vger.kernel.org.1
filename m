Return-Path: <netdev+bounces-276606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD4vKZ561mnxFggAu9opvQ
	(envelope-from <netdev+bounces-276606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:56:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5E3BE94E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 792C93005A80
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61830B509;
	Wed,  8 Apr 2026 15:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAA3093C6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663303; cv=none; b=jWC6XPMWXgk77NvaoBIMOMdehqS4Ey4mz3aADLnGmVPtpRqb/A3Udux4ch3r+MzSV7JLc6xfvTEq0z+9VaH5oe3TFp2ZsVhY9zEp62ykpmgSq2FZ/JDM4WIq+vQovN0Mx134sNBn9KxtX6oQXVSuguBrVULh5nCw+W+h6Wv1438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663303; c=relaxed/simple;
	bh=QhKNrqDBC2u/uZV4lRpvFwlFS654uvCO+jjz/XxW6No=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AVW2oxqlV+AF/wVf3Nx7hp0Pq01rq81RF5cmx2qYyXtB1YlOK+Pff+CNmHy4EO/4dR1OJUS9C4l6FN39IUHAyTx9blv/gAdBAfyZ159BLJ64uao7GXrp1bPRwiJDULfpLOUhrAHnbfjDWpUoThGChPRLHaHbDSnvKo+0Nn/gmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-67e43c3c741so8551692eaf.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663301; x=1776268101;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtQeeChsD95X71/YXqh65zSsrGsCd5NcB4c7qSiNBxU=;
        b=GfgQUnUOzjHVYl64kQWgI2nTEgI1fUh/rby/NHPTumOeQ16w430g6ue6ng3C3xcmPJ
         IksqEZDSC/USrNuHoKC1G92Hmfb9rz+5photuVNb3KISkK6HFzmiWPWJ38m3xoNjf+2T
         +g7tQuBJ/zKiu/UWJvRKufwgZ1As9297uu9ARuiYz4FqtXGPSFvTk/1eSf+jztXMsIke
         Q6bzw9/hlPQwqNf67ziKbRuMWchhoQm09yvMHBkSC++oRoCpmdsVRf194SDaRKKjpS/j
         X5jjK1+tCHbW+bRqFN2TX0MGooLA7qFBUatAXi75YSmghmDCqb9xvGDRKvDahT22d7iK
         aI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYjok57HMDVO4N0oFT0pTl7BR8GPUzP/7+PfrvbsOLFNOgYoYEHG5VBHYxRoWqpAKtx2Mjg+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJjWrtFupcHCW4Smh+MsAlFy7203hr8oC8IjHeB09r2xyyYKf
	rUqUaU8fTCXU6V1tVAhKqghGs/ENSCQs0A7eTLT/Jq5tmcQXlsLx4evdGV/YHFxrWB8Wy7SCZc5
	XfxnroihOt7vOb7XWwjicuqpeekn1X2MA/6VMCiYELvV8soVUFX4EVrMi3KA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b8f:b0:684:743e:86a6 with SMTP id
 006d021491bc7-68a60facd1dmr43746eaf.20.1775663300991; Wed, 08 Apr 2026
 08:48:20 -0700 (PDT)
Date: Wed, 08 Apr 2026 08:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d678c4.050a0220.3030df.000a.GAE@google.com>
Subject: [syzbot] [net?] memory leak in xfrm_policy_construct
From: syzbot <syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e2bba615ee79faa5];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-276606-lists,netdev=lfdr.de,901d48e0b95aed4a2548];
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
X-Rspamd-Queue-Id: 88F5E3BE94E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    a0c83177734a Merge tag 'drm-fixes-2026-03-21' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117d66da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2bba615ee79faa5
dashboard link: https://syzkaller.appspot.com/bug?extid=901d48e0b95aed4a2548
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a481d6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1669ccba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76025f732b88/disk-a0c83177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51c8f0f97de7/vmlinux-a0c83177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46b7135c73d1/bzImage-a0c83177.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com

2026/03/21 23:24:08 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888125a86c00 (size 1024):
  comm "syz.0.17", pid 6082, jiffies 4294946151
  hex dump (first 32 bytes):
    00 e5 5f 1c 81 88 ff ff 00 00 00 00 00 00 00 00  .._.............
    22 01 00 00 00 00 ad de 00 01 00 00 00 00 ad de  "...............
  backtrace (crc f62518df):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __kmalloc_cache_noprof+0x377/0x480 mm/slub.c:5375
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    xfrm_policy_alloc+0x63/0x180 net/xfrm/xfrm_policy.c:432
    xfrm_policy_construct+0x30/0x260 net/xfrm/xfrm_user.c:2187
    xfrm_add_policy+0x12e/0x390 net/xfrm/xfrm_user.c:2246
    xfrm_user_rcv_msg+0x248/0x570 net/xfrm/xfrm_user.c:3507
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2550
    xfrm_netlink_rcv+0x34/0x40 net/xfrm/xfrm_user.c:3529
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a1/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2592
    ___sys_sendmsg+0x101/0x140 net/socket.c:2646
    __sys_sendmsg+0xcd/0x140 net/socket.c:2678
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

