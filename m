Return-Path: <netdev+bounces-266248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA7YECZPsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:04:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E76255364
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C18317E9ED
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9993C9445;
	Tue, 10 Mar 2026 17:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A3B6361
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162132; cv=none; b=gizmUuhaW9WbVt7uZjLhRu3WU8fLeqacCQKVrzX3mBJ4Ub1gpmXGPtLp/bzvw8K06Jc/j3lUqK07acE03G+yhQVPC51iI5x4SY8hVwQyxRuFgwVvfYiUkwAZj2mQCaJ3MgDonDvfDKkuzYyQcFB2BlbHvAw6fTsxS/O43xeIJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162132; c=relaxed/simple;
	bh=VmCzHmrG9j2bMu3s45uDq31/hcIEsZkaQY0AfH8hzag=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GKntGx1L0tF0wyt615vvDPmG+MxTnfzyY93OXI/9D6bZn0UVWVfgCrmP3UzQFBlACE2ycAAkKgBs4wPXVSnMWtbPhGe0I7pd2z+7tOPoNPybQLDCKElTqwUlds0ijN2MLqI+8mIaufAogqF9z2rXkFHXsAy9xQWNLXF9bp4R6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67ba64650d9so48240745eaf.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162130; x=1773766930;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q21Kf+JSTc9Wfjs37P9MOrHmbMi2Fg3vu9CFH4m6XNY=;
        b=DixvO9J/gR6rN/eADU2Gv0A1ZIt0jfa9UzDyn+gGxDgRsU4ZIvZ1zeLqHSEQXqSD8Q
         Sz52LlV5Z+A8sG+WSsJrXM/s2lf+kaj2raXJxcowJkHi4T5jt1bvL1tT0v/AdmXDpFDz
         WGcYmM55KXSbtqb/AuGlZKjEzq2lAkz9rqsiHNLZIpk8bV+kzfJj8jvdPsOFZREsN1CP
         fEwKbve7JEycdS+zd732D4PdTrBtVk0TG9ciNwUBjJmFKLqkGnzScY6aP5mVbJJ+1K6J
         +uiBO+idIHAOnka18TpexNKU3jf9rVKIE5qUMnQzWi2qCeWhkRP+g44cx194UasmVRDd
         8eAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjt9EeF9wkN51Gth0z+hiKkuu5o6YPoVs2pnmOSCsyaIDA9HXlyTAlgosu3OClxox0MHgj+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g5LPadCixjYWT2fLcg9wmesA16Z7GWbds0puswO8Ik1jwR3l
	9MjH+6LlNmMWeTX/GRdFeI7FDhBJEUcuE7gQU408I1XmEDl5TUYZzEApbrj6pIT+ZeLTkHjfK6Q
	iOJyjcoJGyGZ5oFSnk3JmEMpXQveEVYY/fO69I9HcDACGF7bGJgQtxkAwskM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:cf16:0:b0:67b:a5a1:8ee0 with SMTP id
 006d021491bc7-67ba5a19256mr5796493eaf.66.1773162129784; Tue, 10 Mar 2026
 10:02:09 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:02:09 -0700
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b04e91.a70a0220.51e36.0000.GAE@google.com>
Subject: [syzbot ci] Re: net: move netdev_compute_master_upper_features to ndo_set_features
From: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>
To: andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	liuhangbin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, sridhar.samudrala@intel.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A1E76255364
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266248-lists,netdev=lfdr.de,ci098fa7c1795eceac];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,lists.linux.dev,davemloft.net,google.com,kernel.org,nvidia.com,resnulli.us,jvosburgh.net,vger.kernel.org,gmail.com,redhat.com,blackwall.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlesource.com:url,googlegroups.com:email]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] net: move netdev_compute_master_upper_features to ndo_set_features
https://lore.kernel.org/all/20260310-offload_compute-v1-0-3df79c09ea65@gmail.com
* [PATCH net-next 1/3] net: use ndo_set_features to set offload features for bonding/bridge/team
* [PATCH net-next 2/3] failover: use ndo_set_features for failover offload compute
* [PATCH net-next 3/3] net: no need to disable LRO specifically

and found the following issue:
WARNING in rtmsg_ifinfo_build_skb

Full report is available here:
https://ci.syzbot.org/series/d5001c4a-a51e-49c1-9106-624836e43ec2

***

WARNING in rtmsg_ifinfo_build_skb

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      52ede1bce557c66309f41ac29dd190be23ca9129
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/281e7e02-f6af-4b4a-845e-d1d5842a9301/config

batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
hsr_slave_0: entered promiscuous mode
hsr_slave_1: entered promiscuous mode
------------[ cut here ]------------
err == -EMSGSIZE
WARNING: net/core/rtnetlink.c:4421 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: syz-executor/6496
Modules linked in:
CPU: 0 UID: 0 PID: 6496 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:rtmsg_ifinfo_build_skb+0x218/0x260
Code: f6 ba 01 00 00 00 89 e9 e8 25 15 3a 00 4c 89 f0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7f 3a 2e 02 cc e8 49 3b 42 f8 90 <0f> 0b 90 eb 90 89 d9 80 e1 07 fe c1 38 c1 0f 8c 95 fe ff ff 48 89
RSP: 0018:ffffc9000637e9a0 EFLAGS: 00010293
RAX: ffffffff89835e27 RBX: 0000000000000000 RCX: ffff8881b80a57c0
RDX: 0000000000000000 RSI: 00000000ffffffa6 RDI: 00000000ffffffa6
RBP: 00000000ffffffa6 R08: 0000000000000004 R09: 0000000000000004
R10: fffff52000c6fcdc R11: 0000000000000000 R12: 1ffff110235ddc21
R13: 0000000000000000 R14: ffff8881133dc780 R15: ffff88811aeee000
FS:  0000555557c4a500(0000) GS:ffff88818de65000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555e1838c8 CR3: 0000000168b80000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 rtnetlink_event+0x1b7/0x270
 notifier_call_chain+0x1be/0x400
 netdev_change_features+0x95/0xe0
 __netdev_upper_dev_link+0xb20/0xc80
 netdev_upper_dev_link+0xb0/0x100
 macsec_newlink+0xb11/0x1200
 rtnl_newlink_create+0x329/0xb70
 rtnl_newlink+0x1666/0x1be0
 rtnetlink_rcv_msg+0x7d5/0xbe0
 netlink_rcv_skb+0x232/0x4b0
 netlink_unicast+0x80f/0x9b0
 netlink_sendmsg+0x813/0xb40
 __sys_sendto+0x672/0x710
 __x64_sys_sendto+0xde/0x100
 do_syscall_64+0x14d/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffadf757917
Code: 48 89 fa 4c 89 df e8 a8 56 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd0eb79f80 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000555557c4a500 RCX: 00007ffadf757917
RDX: 0000000000000054 RSI: 00007ffae0544670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffd0eb79fe4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000000 R14: 00007ffae0544670 R15: 0000000000000000
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

