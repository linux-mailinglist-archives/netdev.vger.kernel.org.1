Return-Path: <netdev+bounces-129623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E0984D0B
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AE02819A5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9231428E3;
	Tue, 24 Sep 2024 21:51:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471213F43B
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214682; cv=none; b=Z42x0CsD8KQ4i10Lk7xgsYH3W50Jvag1q/GefZik4Gvj3DFlU4YF71fIGaJzjmrAGA5hgVBk/+qHaAANB6bqaOhsF0ISyePjNMcItuo21KZ8VwpO4HyITcR22pCN3Wb9Bm2s4d0DhtO7Y48yvhu6piPIOoYRv7IA4uLQ0jw8hyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214682; c=relaxed/simple;
	bh=7nkYi9mRI6Nh6vUspfF6r4G+OKqgvF1CfuUEK8XrRrg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ugzyQambluxH3e87MTCrF98viWvJk34+J/wxMJ6Npf89wwZnrPMlG4CtLhQ1n43tfNr5Cdde/q7u+CqyEyR+cgp63RmDWFH5nqEPlRT7OQdhDZoVQNKeAc/LzHzKS/4/LcEiOQJiBk8pv0Lgty+ap/+SUGWzJdFrKp8DXDm9d3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f5605c674so88348095ab.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727214680; x=1727819480;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GLXPP8gloWEkHs7/dRo22kxqeF7ht3rRUiVq991l8g=;
        b=rARisJgxy8m92ECfhU0EzUhFRnlxt+ENpk3qSJjGyTi+HsuGmU1/LoKP6ejrCD6jJe
         TY8KqGGD64UskY+Ki06YI9Ollw2ahhuvLNZv9AoenMA/VVPJMXI9UWXSKII6c2Kp1Jq9
         NpMsaJ/ImfPoTc9sAuGMAcon5UEb7Sf46GSSrogivjaGci4c78KT7i1LSjVlw5fUOd9W
         wsgQG1L9trvULSRWrkADcRg1J/axVbHKzeoDmEv2bvY2FU7msLLTCZvGqILWCaJiA1aJ
         GZw3GElFlUFfh64PRq9SB6RDoAmbawf3Kr7rId2U5wLtPqrmWp8ZPZUAWqQ/F8ToXtiV
         zkwA==
X-Forwarded-Encrypted: i=1; AJvYcCVGAy1pejk0/zgy5psM5ZS/0Zk2U5mGdnB0MSyDEbJbSIwihDiiA59+D0TBmaJ2JGM7IyjVe/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/pKKfFaShcGMfPmsWnZizxvElqAUE9TiTKFv/rGeZN88C1lL
	7rnLWXHkYp70QICZJCr8C+RObtw1wRCE43yJ8BcwAVqn45lF+utSw/BmUo3RUnEBCbqxsvLOJtB
	E2OsHosH0TrdFTL0k68VBCnD5jpG+4yZ+5ouwRKbpFuw9q8iApPvKl0A=
X-Google-Smtp-Source: AGHT+IEMTTjR3dYhXKua/OTKRfkCZwu+4yRP9qDdp+MaoIt93J1zWlRRc5Apel76dVoHwX826H3pVjxNlRYPn1nfXLV9IDbHzKfF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a26d7747famr11393505ab.13.1727214680184; Tue, 24 Sep 2024
 14:51:20 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:51:20 -0700
In-Reply-To: <00000000000088906d0622445beb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f33458.050a0220.457fc.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] UBSAN: shift-out-of-bounds in xfrm_selector_match (2)
From: syzbot <syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    151ac45348af net: sparx5: Fix invalid timestamps
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15808a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
dashboard link: https://syzkaller.appspot.com/bug?extid=cc39f136925517aed571
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ad2a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1387b107980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81152b131cff/disk-151ac453.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/013d9758c594/vmlinux-151ac453.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ff7505093fc/bzImage-151ac453.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc39f136925517aed571@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in ./include/net/xfrm.h:900:23
shift exponent -96 is negative
CPU: 0 UID: 0 PID: 5231 Comm: syz-executor893 Not tainted 6.11.0-syzkaller-01459-g151ac45348af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 addr4_match include/net/xfrm.h:900 [inline]
 __xfrm4_selector_match net/xfrm/xfrm_policy.c:222 [inline]
 xfrm_selector_match+0xe9b/0x1030 net/xfrm/xfrm_policy.c:247
 xfrm_state_look_at+0xe8/0x480 net/xfrm/xfrm_state.c:1172
 xfrm_state_find+0x199f/0x4d70 net/xfrm/xfrm_state.c:1280
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2481 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2532 [inline]
 xfrm_resolve_and_create_bundle+0x6d2/0x2c90 net/xfrm/xfrm_policy.c:2826
 xfrm_lookup_with_ifid+0x334/0x1ee0 net/xfrm/xfrm_policy.c:3160
 xfrm_lookup net/xfrm/xfrm_policy.c:3289 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3300
 ip_route_connect include/net/route.h:333 [inline]
 __ip4_datagram_connect+0x96c/0x1260 net/ipv4/datagram.c:49
 __ip6_datagram_connect+0x194/0x1230
 ip6_datagram_connect net/ipv6/datagram.c:279 [inline]
 ip6_datagram_connect_v6_only+0x63/0xa0 net/ipv6/datagram.c:291
 __sys_connect_file net/socket.c:2067 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2084
 __do_sys_connect net/socket.c:2094 [inline]
 __se_sys_connect net/socket.c:2091 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2091
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0cdb8e8a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdce8cd648 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007ffdce8cd818 RCX: 00007fb0cdb8e8a9
RDX: 000000000000001c RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fb0cdc01610 R08: 000000000000000a R09: 00007ffdce8cd818
R10: 00000000000000e8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdce8cd808 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

